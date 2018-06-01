/obj/mecha/combat/lemanruss
	name = "Leman Russ Vanquisher Tank"
	desc = "A heavy tank popular among the Astra Militarum. This one is a vanquisher pattern, bearing heavy weapons. Equipped for cold climate."
	icon = 'icons/mecha/lemanruss.dmi'
	icon_state = "vanquisher"
	pixel_x = -12
	//pixel_y = -36
	bound_height = 64
	step_in = 4
	dir_in = 1
	health = 1500 //Three times that of a chimera.
	deflect_chance = 15
	damage_absorption = list("brute"=0.5,"fire"=0.4,"bullet"=0.65,"laser"=0.65,"energy"=0.5,"bomb"=1)
	max_temperature = 65000
	lights_power = 8
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/lemanruss
	internal_damage_threshold = 35
	max_equip = 4
	step_energy_drain = 6
	stepsound = 'sound/mecha/tank.ogg'
	can_drop = 0
	var/turf/target
	var/defence = 0
	var/defence_deflect = 60

/obj/mecha/combat/lemanruss/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999

/obj/mecha/combat/lemanruss/relaymove(mob/user,direction)
	if(defence)
		if(world.time - last_message > 20)
			src.occupant_message("<font color='red'>Unable to move while in defence mode</font>")
			last_message = world.time
		return 0
	. = ..()
	return

/obj/mecha/combat/lemanruss/verb/defence_mode()
	set category = "Exosuit Interface"
	set name = "Toggle defence mode"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	defence = !defence
	if(defence)
		deflect_chance = defence_deflect
		src.occupant_message("<font color='blue'>You enable [src] defence mode.</font>")
	else
		deflect_chance = initial(deflect_chance)
		src.occupant_message("<font color='red'>You disable [src] defence mode.</font>")
	src.log_message("Toggled defence mode.")
	return

/obj/mecha/combat/lemanruss/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_defense=1'>Toggle defense mode</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/lemanruss/Topic(href, href_list)
	..()
	if (href_list["toggle_defense"])
		src.defence_mode()
	return

/obj/mecha/combat/lemanruss/Bump(var/atom/obs)
	var/mob/living/M = obs
	if(isliving(M))
		if(istype(M, /mob/living/carbon/alien/humanoid/tyranid))
			src.visible_message("\red [src] bumps into [M]!")
			M.adjustBruteLoss(30)
		if(istype(M,/mob/living/silicon/robot))
			src.visible_message("\red [src] bumps into [M]!")
			M.adjustBruteLoss(20)
		else
			src.visible_message("\red [src] knocks over [M]!")
			M.stop_pulling()
			M.Weaken(5)
			M.adjustBruteLoss(25)
			M.lying = 1
	if(istype(target,/obj/machinery/door/airlock/)||istype(target,/obj/structure/))
		target.ex_act(2)
	..()

/obj/mecha/combat/lemanruss/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/vanquisher(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/autocannon(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster(src)
	ME.attach(src)
	return