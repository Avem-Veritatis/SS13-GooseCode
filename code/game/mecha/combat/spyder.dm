//TODO: This needs to only be drive-able by necrons (and normally borgs can't do much with mecha) and it needs to be able to hold multiple people like chimeras can.
//Necrons work as passengers... As for the driver, it doesn't work but that is fine since it makes sense to make the driver a MMI anyway.
//-DrakeMarshall

/obj/item/mecha_parts/mecha_equipment/weapon/gaussblaster
	name = "gauss blaster"
	origin_tech = "materials=6;combat=25"
	var/obj/item/ammo_casing/energy/beamshot/gauss/internalgun

/obj/item/mecha_parts/mecha_equipment/weapon/gaussblaster/New()
	..()
	internalgun = new /obj/item/ammo_casing/energy/beamshot/gauss/light(src)

/obj/item/mecha_parts/mecha_equipment/weapon/gaussblaster/action(atom/target)
	if(!action_checks(target)) return 0
	set_ready_state(0)
	var/turf/curloc = chassis.loc
	var/atom/targloc = get_turf(target)
	if (!targloc || !istype(targloc, /turf) || !curloc)
		return
	if (targloc == curloc)
		return
	playsound(chassis, fire_sound, 50, 1)
	internalgun.fire(target,chassis, 0, 0, 0)
	chassis.log_message("Fired from [src.name], targeting [target].")
	do_after_cooldown()
	return 1

/obj/mecha/combat/spyder
	desc = "A large, armored necron contraption that holds more necrons and shoots deadly gauss bolts."
	name = "\improper Spyder"
	icon = 'icons/mob/spyder.dmi'
	icon_state = "spyder"
	pixel_x = -20
	pixel_y = -20
	step_in = 3
	health = 300
	deflect_chance = 15
	damage_absorption = list("brute"=0.5,"fire"=0.7,"bullet"=0.45,"laser"=0.6,"energy"=0.7,"bomb"=0.7)
	max_temperature = 60000
	infra_luminosity = 3
	operation_req_access = list()
	wreckage = /obj/effect/effect/sparks
	add_req_access = 0
	internal_damage_threshold = 25
	force = 45
	max_equip = 3

/obj/mecha/combat/spyder/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/gaussblaster(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	var/list/candidates = get_candidates(BE_TRAITOR) //Default BE_TRAITOR until there is a new BE_NECRON flag.
	var/client/C = pick_n_take(candidates)
	if(C)
		var/obj/item/device/mmi/mmi_as_oc = new /obj/item/device/mmi(src)
		var/mob/brainmob = mmi_as_oc.brainmob
		brainmob.ckey = C.key
		brainmob.reset_view(src)
		occupant = brainmob
		brainmob.loc = src //should allow relaymove
		brainmob.canmove = 1
		mmi_as_oc.mecha = src
		src.verbs -= /obj/mecha/verb/eject
		src.Entered(mmi_as_oc)
		src.Move(src.loc)
		src.icon_state = initial(icon_state)
		dir = dir_in
		src.log_message("[mmi_as_oc] moved in as pilot.")
	return

/obj/mecha/combat/spyder/verb/enterback()
	set category = "Object"
	set name = "Climb in the back"
	set src in oview(1)

	if (usr.stat || usr.restrained() || !usr.Adjacent(src) || !isrobot(usr))
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

/obj/mecha/combat/spyder/inback(var/mob/living/M as mob)
	if(M && M.client && M in range(1))
		M.reset_view(src)
		M.stop_pulling()
		M.forceMove(src)
		src.passenger = M
		src.add_fingerprint(M)
		src.forceMove(src.loc)
		src.log_append_to_last("[M] moved in as passenger.")
		playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
		return 1
	else
		return 0

/obj/mecha/combat/spyder/verb/Deploy()
	set name = "Deploy"
	set category = "Exosuit Interface"
	set src = usr.loc
	set popup_menu = 0

	if(usr != src.passenger)	return

	src.depart()
	add_fingerprint(usr)
	return

/obj/mecha/combat/spyder/proc/depart()
	var/atom/movable/mob_container
	if(isrobot(passenger))
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

/obj/mecha/combat/spyder/container_resist()
	go_out()

/obj/mecha/combat/spyder/move_inside(var/mob/usr)
	if (usr.stat || !isrobot(usr) || usr.restrained() || !usr.Adjacent(src))
		return
	src.log_message("[usr] tries to move in.")
	if (src.occupant)
		usr << "\blue <B>The [src.name] is already occupied!</B>"
		src.log_append_to_last("Permission denied.")
		return
/*
	if (usr.abiotic())
		usr << "\blue <B>Subject cannot have abiotic items on.</B>"
		return
*/

	for(var/mob/living/carbon/slime/M in range(1,usr))
		if(M.Victim == usr)
			usr << "You're too busy getting your life sucked out of you."
			return
//	usr << "You start climbing into [src.name]"

	visible_message("\blue [usr] starts to climb into [src.name]")

	if(enter_after(40,usr))
		if(!src.occupant)
			moved_inside(usr)
		else if(src.occupant!=usr)
			usr << "[src.occupant] was faster. Try better next time, loser."
	else
		usr << "You stop entering the exosuit."
	return

/obj/mecha/combat/spyder/moved_inside(var/mob/living/silicon/robot/H as mob)
	if(H && H.client && H in range(1))
		/* //Apparently this is horribly glichy. Fortunately, there is an easier, more lore-accurate solution.
		H.reset_view(src)
		/*
		H.client.perspective = EYE_PERSPECTIVE
		H.client.eye = src
		*/
		H.stop_pulling()
		H.forceMove(src)
		src.occupant = H
		src.add_fingerprint(H)
		src.forceMove(src.loc)
		src.log_append_to_last("[H] moved in as pilot.")
		src.icon_state = initial(icon_state)
		dir = dir_in
		playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
		if(!hasInternalDamage())
			playsound(src,nominalsound,40,1)
		*/
		var/obj/item/device/mmi/mmi_as_oc = H.mmi
		var/mob/brainmob = mmi_as_oc.brainmob
		brainmob.ckey = H.ckey
		brainmob.reset_view(src)
		occupant = brainmob
		brainmob.loc = src //should allow relaymove
		brainmob.canmove = 1
		mmi_as_oc.mecha = src
		src.verbs -= /obj/mecha/verb/eject
		src.Entered(mmi_as_oc)
		src.Move(src.loc)
		src.icon_state = initial(icon_state)
		dir = dir_in
		src.log_message("[mmi_as_oc] moved in as pilot.")
		visible_message("[H] transfers consciousness to the [src].")
		visible_message("<b>[H]</b> blows apart!")
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		del(H)
		return 1
	else
		return 0