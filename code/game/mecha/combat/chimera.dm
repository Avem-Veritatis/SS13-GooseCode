/obj/mecha/combat/chimera
	desc = "A lightweight, transport vehicle. Popular among the imperial guard."
	name = "Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimera"
	pixel_x = -20
	pixel_y = -20
	//bound_y = -15 //Lets see if we can make them take up two tiles of space! -Drake
	//bound_height = 64 //Perfect! //Not for chimera. Turning is... Complicated.
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	var/overload = 0
	var/overload_coeff = 2
	wreckage = /obj/structure/mecha_wreckage/chimera
	internal_damage_threshold = 35
	max_equip = 2
	step_energy_drain = 3
	stepsound = 'sound/mecha/tank.ogg'
	var/turf/target

/obj/mecha/combat/chimera/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999

/obj/mecha/combat/chimera/verb/overload()
	set category = "Chimera Controls"
	set name = "Toggle actuators overload"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	if(overload)
		overload = 0
		step_in = initial(step_in)
		step_energy_drain = initial(step_energy_drain)
		src.occupant_message("<font color='blue'>You disable leg actuators overload.</font>")
	else
		overload = 1
		step_in = min(1, round(step_in/2))
		step_energy_drain = step_energy_drain*overload_coeff
		src.occupant_message("<font color='red'>You enable leg actuators overload.</font>")
	src.log_message("Toggled leg actuators overload.")
	return

/obj/mecha/combat/chimera/dyndomove(direction)
	if(!..()) return
	if(overload)
		health--
		if(health < initial(health) - initial(health)/3)
			overload = 0
			step_in = initial(step_in)
			step_energy_drain = initial(step_energy_drain)
			src.occupant_message("<font color='red'>Leg actuators damage threshold exceded. Disabling overload.</font>")
	return


/obj/mecha/combat/chimera/get_stats_part()
	var/output = ..()
	output += "<b>Leg actuators overload: [overload?"on":"off"]</b>"
	return output

/obj/mecha/combat/chimera/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_leg_overload=1'>Toggle leg actuators overload</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/chimera/Topic(href, href_list)
	..()
	if (href_list["toggle_leg_overload"])
		src.overload()
	return

/*
People container
*/

/obj/mecha/combat/chimera/verb/enterback()
	set category = "Object"
	set name = "Climb in the back"
	set src in oview(1)

	if (usr.stat || usr.restrained() || !usr.Adjacent(src))
		return
	src.log_message("[usr] starts to climb in back.")
	for(var/mob/living/carbon/slime/M in range(1,usr))
		if(M.Victim == usr)
			usr << "You're too busy getting your life sucked out of you."
			return
//	usr << "You start climbing into [src.name]"

	visible_message("\blue [usr] starts to climb into the back of [src.name]")

	if(enter_after(40,usr))
		inback(usr)
	else
		usr << "You stop entering the exosuit."
	return

/obj/mecha/combat/proc/inback(var/mob/living/carbon/human/H as mob)
	if(H && H.client && H in range(1))
		H.reset_view(src)
		/*
		H.client.perspective = EYE_PERSPECTIVE
		H.client.eye = src
		*/
		H.stop_pulling()
		H.forceMove(src)
		src.passenger = H
		src.add_fingerprint(H)
		src.forceMove(src.loc)
		src.log_append_to_last("[H] moved in as passenger.")
		playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
		return 1
	else
		return 0

/obj/mecha/combat/chimera/verb/Deploy()
	set name = "Deploy"
	set category = "Exosuit Interface"
	set src = usr.loc
	set popup_menu = 0

	if(usr != src.passenger)	return

	src.depart()
	add_fingerprint(usr)
	return

/obj/mecha/combat/chimera/container_resist()
	go_out()


/obj/mecha/combat/chimera/proc/depart()
	var/atom/movable/mob_container
	if(ishuman(passenger))
		mob_container = src.passenger
	else
		return
	if(mob_container.forceMove(src.loc))//ejecting mob container
	/*
		if(ishuman(occupant) && (get_pressure() > HAZARD_HIGH_PRESSURE))
			use_internal_tank = 0
			var/datum/gas_mixture2/environment = get_turf_air()
			if(environment)
				var/env_pressure = environment.get_pressure()
				var/pressure_delta = (cabin.get_pressure() - env_pressure)
		//Can not have a pressure delta that would cause environment pressure > tank pressure

				var/transfer_moles = 0
				if(pressure_delta > 0)
					transfer_moles = pressure_delta*environment.volume/(cabin.return_temperature() * R_IDEAL_GAS_EQUATION)

			//Actually transfer the gas
					var/datum/gas_mixture2/removed = cabin.air_contents.remove(transfer_moles)
					loc.assume_air(removed)

			occupant.SetStunned(5)
			occupant.SetWeakened(5)
			occupant << "You were blown out of the mech!"
	*/
		src.log_message("[mob_container] moved out.")
		passenger.reset_view()
		/*
		if(src.occupant.client)
			src.occupant.client.eye = src.occupant.client.mob
			src.occupant.client.perspective = MOB_PERSPECTIVE
		*/
		src.passenger << browse(null, "window=exosuit")
		if(src.passenger.hud_used && src.last_user_hud)
			src.passenger.hud_used.show_hud(HUD_STYLE_STANDARD)

		if(istype(mob_container, /obj/item/device/mmi))
			var/obj/item/device/mmi/mmi = mob_container
			if(mmi.brainmob)
				passenger.loc = mmi
			mmi.mecha = null
			src.passenger.canmove = 0
			src.verbs += /obj/mecha/verb/eject
		src.passenger = null
		src.icon_state = initial(icon_state)+"-open"
		src.dir = dir_in
	return

/*
Run them down!
*/
/obj/mecha/combat/chimera/Bump(var/atom/obs)
	var/mob/M = obs
	if(ismob(M))
		if(istype(M, /mob/living/carbon/alien/humanoid/tyranid))
			src.visible_message("\red [src] bumps into [M]!")
		if(istype(M,/mob/living/silicon/robot))
			src.visible_message("\red [src] bumps into [M]!")
		else
			src.visible_message("\red [src] knocks over [M]!")
			M.stop_pulling()
			M.Weaken(5)
			M.lying = 1
	if(istype(target,/obj/machinery/door/airlock/)||istype(target,/obj/structure/))
		target.ex_act(2)
	..()

/*
Types
*/

/obj/mecha/combat/chimera/AC						//AUTOCANNON
	desc = "A lightweight, recon vehicle. Popular among the imperial guard. This one has an autocannon on top."
	name = "Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimeraAC"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/chimera
	internal_damage_threshold = 10
	max_equip = 2
	step_energy_drain = 3

/obj/mecha/combat/chimera/AC/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/autocannon(src)
	ME.attach(src)
	return

/obj/mecha/combat/chimera/inq					//INQUISITOR
	desc = "A lightweight troop transport owned by the Inquisition. This one fires incendiary rounds."
	name = "Inquisition Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimeraINQ"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/chimera/inqchimera
	internal_damage_threshold = 10
	max_equip = 2
	step_energy_drain = 3

/obj/mecha/combat/chimera/inq/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/incendiary(src)
	ME.attach(src)
	return

/obj/mecha/combat/chimera/BP						//Blood Pact
	desc = "A lightweight, recon vehicle. Popular among the imperial guard. This one has a conversion beam projector on top."
	name = "Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimera"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/chimera/inqchimera
	internal_damage_threshold = 10
	max_equip = 2
	step_energy_drain = 3

/obj/mecha/combat/chimera/BP/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse(src)
	ME.attach(src)
	return

/obj/mecha/combat/chimera/valhallan
	desc = "A lightweight, recon vehicle. Popular among the imperial guard. This one has an autocannon on top."
	name = "Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimeravalhallan"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/chimera/inqchimera
	internal_damage_threshold = 10
	max_equip = 2
	step_energy_drain = 3

/obj/mecha/combat/chimera/valhallan/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/autocannon(src)
	ME.attach(src)
	return

/obj/mecha/combat/chimera/kreig
	desc = "A lightweight, recon vehicle. Popular among the imperial guard. This one has an autocannon on top."
	name = "Chimera"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "chimerakreig"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 500
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/chimera/inqchimera
	internal_damage_threshold = 10
	max_equip = 2
	step_energy_drain = 3

/obj/mecha/combat/chimera/kreig/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/autocannon(src)
	ME.attach(src)
	return