/obj/machinery/portable_atmospherics
	name = "atmoalter"
	use_power = 0
	var/datum/gas_mixture2/air_contents = new
	var/obj/machinery/atmospherics/pipe/canister_connector/connected_port
	var/obj/item/weapon/tank/holding

	var/destroyed = 0

	var/maximum_pressure = 90*ONE_ATMOSPHERE

	New()
		..()
		air_contents.temperature = T20C
		spawn(2)
			update_icon()

	process()
		air_contents.burn()

	Destroy()
		del(air_contents)
		..()

	update_icon()
		return null

	CanAtmosPass()
		return 1

	proc
		connect(obj/machinery/atmospherics/pipe/canister_connector/new_port)
			//Make sure not already connected to something else
			if(connected_port || !new_port || new_port.connected_device)
				return 0

			//Make sure are close enough for a valid connection
			if(new_port.loc != loc)
				return 0

			//Perform the connection
			connected_port = new_port
			connected_port.connected_device = src

			anchored = 1 //Prevent movement

			return 1

		disconnect()
			if(!connected_port)
				return 0

			anchored = 0

			connected_port.connected_device = null
			connected_port = null

			return 1

/obj/machinery/portable_atmospherics/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if ((istype(W, /obj/item/weapon/tank) && !( src.destroyed )))
		if (src.holding)
			return
		var/obj/item/weapon/tank/T = W
		user.drop_item()
		T.loc = src
		src.holding = T
		update_icon()
		return

	else if (istype(W, /obj/item/weapon/wrench))
		if(connected_port)
			disconnect()
			user << "\blue You disconnect [name] from the port."
			update_icon()
			return
		else
			var/obj/machinery/atmospherics/pipe/canister_connector/possible_port = locate(/obj/machinery/atmospherics/pipe/canister_connector) in loc
			if(possible_port)
				if(connect(possible_port))
					user << "\blue You connect [name] to the port."
					update_icon()
					return
				else
					user << "\blue [name] failed to connect to the port."
					return
			else
				user << "\blue Nothing happens."
				return

	else if ((istype(W, /obj/item/device/analyzer)) && get_dist(user, src) <= 1)
		atmosanalyzer_scan(air_contents, user)
	return

/obj/machinery/portable_atmospherics/canister
	name = "canister"
	desc = "Well it's a canister. With gas and shit, or maybe not if it's empty. Were you expecting some kind of enlightening comment?"
	icon = 'icons/obj/atmos.dmi'
	icon_state = "canister"
	density = 1
	use_power = 0
	var/health = 100.0
	var/valve_open = 0
	var/release_pressure = ONE_ATMOSPHERE
	var/release_log = ""
	var/update_flag = 0
	var/datum/gas_spread/releasing

/obj/machinery/portable_atmospherics/canister/proc/check_change()
	var/old_flag = update_flag
	update_flag = 0
	if(holding)
		update_flag |= 1
	if(connected_port)
		update_flag |= 2

	var/tank_pressure = air_contents.get_pressure()
	if(tank_pressure < 10)
		update_flag |= 4
	else if(tank_pressure < ONE_ATMOSPHERE)
		update_flag |= 8
	else if(tank_pressure < 15*ONE_ATMOSPHERE)
		update_flag |= 16
	else
		update_flag |= 32

	if(update_flag == old_flag)
		return 1
	else
		return 0

/obj/machinery/portable_atmospherics/canister/update_icon()
	if (destroyed)
		overlays = 0
		icon_state = "[initial(icon_state)]-1"
		return

	icon_state = "[initial(icon_state)]"

	if(check_change()) //Returns 1 if no change needed to icons.
		return

	src.overlays = 0

	if(update_flag & 1)
		overlays += "can-open"
	if(update_flag & 2)
		overlays += "can-connector"
	if(update_flag & 4)
		overlays += "can-o0"
	if(update_flag & 8)
		overlays += "can-o1"
	else if(update_flag & 16)
		overlays += "can-o2"
	else if(update_flag & 32)
		overlays += "can-o3"
	return


/obj/machinery/portable_atmospherics/canister/temperature_expose(datum/gas_mixture2/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 1000)
		health -= 5
		healthcheck()

/obj/machinery/portable_atmospherics/canister/proc/healthcheck()
	if(destroyed)
		return 1

	if (src.health <= 10)

		var/datum/gas_spread/S = new /datum/gas_spread()
		S.air = src.air_contents
		S.spread(get_turf(src))
		src.air_contents = new /datum/gas_mixture2()

		src.destroyed = 1
		playsound(src.loc, 'sound/effects/spray.ogg', 10, 1, -3)
		src.density = 0
		update_icon()

		if (src.holding)
			src.holding.loc = src.loc
			src.holding = null

		return 1
	else
		return 1

/obj/machinery/portable_atmospherics/canister/process()
	if (destroyed)
		return

	..()

	if(valve_open)
		if(!releasing)
			releasing = new /datum/gas_spread()
			spawn(10) //Give it time to actually have some pressure with which to spread.
				releasing.spread(get_turf(src))
		releasing.air.merge(src.air_contents.remove(src.release_pressure))
	else
		releasing = null

	src.updateDialog()
	return

/obj/machinery/portable_atmospherics/canister/get_air()
	return air_contents

/obj/machinery/portable_atmospherics/canister/proc/return_temperature()
	return src.air_contents.temperature

/obj/machinery/portable_atmospherics/canister/proc/get_pressure()
	return src.air_contents.get_pressure()

/obj/machinery/portable_atmospherics/canister/blob_act()
	src.health -= 200
	healthcheck()
	return

/obj/machinery/portable_atmospherics/canister/bullet_act(var/obj/item/projectile/Proj)
	if((Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		if(Proj.damage)
			src.health -= round(Proj.damage / 2)
			healthcheck()
	..()

/obj/machinery/portable_atmospherics/canister/ex_act(severity)
	switch(severity)
		if(1.0)
			if(destroyed || prob(30))
				qdel(src)
			else
				src.health = 0
				healthcheck()
			return
		if(2.0)
			if(destroyed)
				qdel(src)
			else
				src.health -= rand(40, 100)
				healthcheck()
			return
		if(3.0)
			src.health -= rand(15,40)
			healthcheck()
			return
	return

/obj/machinery/portable_atmospherics/canister/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(!istype(W, /obj/item/weapon/wrench) && !istype(W, /obj/item/weapon/tank) && !istype(W, /obj/item/device/analyzer) && !istype(W, /obj/item/device/pda))
		visible_message("\red [user] hits the [src] with a [W]!")
		src.health -= W.force
		src.add_fingerprint(user)
		healthcheck()

	if(istype(user, /mob/living/silicon/robot) && istype(W, /obj/item/weapon/tank/jetpack))
		var/obj/item/weapon/tank/jetpack/J = W
		var/tofill = J.volume - J.air_contents.get_pressure()
		if(tofill > 0)
			J.air_contents.merge_gas(src.air_contents.remove(tofill))
			user << "You pulse-pressurize your jetpack from the tank."
		return

	..()

/obj/machinery/portable_atmospherics/canister/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/portable_atmospherics/canister/attack_paw(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/portable_atmospherics/canister/attack_hand(var/mob/user as mob)
	return src.interact(user)

/obj/machinery/portable_atmospherics/canister/interact(var/mob/user as mob)
	if (src.destroyed)
		return

	user.set_machine(src)
	var/holding_text
	if(holding)
		holding_text = {"<BR><B>Tank Pressure</B>: [holding.air_contents.get_pressure()] KPa<BR>
<A href='?src=\ref[src];remove_tank=1'>Remove Tank</A><BR>
"}
	var/output_text = {"<TT><B>[name]</B><BR>
Pressure: [air_contents.get_pressure()] KPa<BR>
Port Status: [(connected_port)?("Connected"):("Disconnected")]
[holding_text]
<BR>
Release Valve: <A href='?src=\ref[src];toggle=1'>[valve_open?("Open"):("Closed")]</A><BR>
Release Pressure: <A href='?src=\ref[src];pressure_adj=-1000'>-</A> <A href='?src=\ref[src];pressure_adj=-100'>-</A> <A href='?src=\ref[src];pressure_adj=-10'>-</A> <A href='?src=\ref[src];pressure_adj=-1'>-</A> [release_pressure] <A href='?src=\ref[src];pressure_adj=1'>+</A> <A href='?src=\ref[src];pressure_adj=10'>+</A> <A href='?src=\ref[src];pressure_adj=100'>+</A> <A href='?src=\ref[src];pressure_adj=1000'>+</A><BR>
<HR>
<A href='?src=\ref[user];mach_close=canister'>Close</A><BR>
"}

	user << browse("<html><head><title>[src]</title></head><body>[output_text]</body></html>", "window=canister;size=600x300")
	onclose(user, "canister")
	return

/obj/machinery/portable_atmospherics/canister/Topic(href, href_list)

	//Do not use "if(..()) return" here, canisters will stop working in unpowered areas like space or on the derelict.
	if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
		usr << browse(null, "window=canister")
		onclose(usr, "canister")
		return

	if (((get_dist(src, usr) <= 1) && istype(src.loc, /turf)))
		usr.set_machine(src)

		if(href_list["toggle"])
			if (valve_open)
				if (holding)
					release_log += "Valve was <b>closed</b> by [usr] ([usr.ckey]), stopping the transfer into the [holding]<br>"
				else
					release_log += "Valve was <b>closed</b> by [usr] ([usr.ckey]), stopping the transfer into the <font color='red'><b>air</b></font><br>"
			else
				if (holding)
					release_log += "Valve was <b>opened</b> by [usr] ([usr.ckey]), starting the transfer into the [holding]<br>"
				else
					release_log += "Valve was <b>opened</b> by [usr] ([usr.ckey]), starting the transfer into the <font color='red'><b>air</b></font><br>"
			valve_open = !valve_open

		if (href_list["remove_tank"])
			if(holding)
				holding.loc = loc
				holding = null

		if (href_list["pressure_adj"])
			var/diff = text2num(href_list["pressure_adj"])
			if(diff > 0)
				release_pressure = min(10*ONE_ATMOSPHERE, release_pressure+diff)
			else
				release_pressure = max(ONE_ATMOSPHERE/10, release_pressure+diff)

		src.updateUsrDialog()
		src.add_fingerprint(usr)
		update_icon()
	else
		usr << browse(null, "window=canister")
		return
	return

/obj/machinery/portable_atmospherics/canister/sleeping_agent
	name = "canister: \[N2O\]"
	icon_state = "canister"

	New()
		..()
		air_contents.sleepgas = 10*ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/oxygen
	name = "canister: \[O2\]"
	icon_state = "canister"

	New()
		..()
		air_contents.oxygen = 10*ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/promethium
	name = "canister \[Promethium\]"
	icon_state = "canisterfuel"

	New()
		..()
		air_contents.promethium = 10*ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/carbon_dioxide
	name = "canister \[CO2\]"
	icon_state = "canisterpoison"

	New()
		..()
		air_contents.co2 = 10*ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/poison
	name = "canister \[Cl\]"
	icon_state = "canisterpoison"

	New()
		..()
		air_contents.poison = 10*ONE_ATMOSPHERE