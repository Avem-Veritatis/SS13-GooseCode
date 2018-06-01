/obj/mecha/combat/baneblade
	name = "\improper Baneblade Pilot System"
	desc = "The piloting console of an imperial baneblade heavy tank."
	icon_state = "baneblade"
	step_in = 4
	dir_in = 1
	health = 125
	deflect_chance = 0
	damage_absorption = list("brute"=0.9,"fire"=0.9,"bullet"=0.9,"laser"=0.9,"energy"=0.9,"bomb"=0.9)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/baneblade
	internal_damage_threshold = 35
	max_equip = 2
	step_energy_drain = 3
	can_drop = 0
	stepsound = 'sound/mecha/tank.ogg'
	var/datum/fake_area/area
	var/collision_force = 2

/obj/mecha/combat/baneblade/click_action(atom/target,mob/user) //Exactly the same code, only it doesn't worry about the dir checks.
	if(!src.occupant || src.occupant != user ) return
	if(user.stat) return
	if(state)
		occupant_message("<font color='red'>Maintenance protocols in effect</font>")
		return
	if(!get_charge()) return
	if(src == target) return
	if(hasInternalDamage(MECHA_INT_CONTROL_LOST))
		target = safepick(view(3,target))
		if(!target)
			return
	if(!target.Adjacent(src))
		if(selected && selected.is_ranged())
			selected.action(target)
	else if(selected && selected.is_melee())
		selected.action(target)
	else
		src.melee_action(target)
	return

/obj/mecha/combat/baneblade/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/megacannon(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/banebolter(src)
	ME.attach(src)
	spawn(20)
		area = new /datum/fake_area()
		for(var/obj/effect/fake_floor/baneblade/FF in range(50, src))
			area.add_turf(FF)
		for(var/obj/effect/fake_floor/fake_wall/r_wall/baneblade/FW in range(50, src))
			area.add_turf(FW)
	return

/obj/mecha/combat/baneblade/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999

/obj/mecha/combat/baneblade/dyndomove(direction)
	if(area && can_move)
		can_move = 0
		spawn(step_in) can_move = 1
		if(area.move(direction, collision_force, smoothingtime = 4))
			playsound(src,stepsound,40,1)
	return

/obj/mecha/combat/baneblade/moved_inside(var/mob/living/M as mob)
	..()
	M.client.view = 16
	M.sight |= SEE_MOBS|SEE_OBJS|SEE_TURFS
	M.see_in_dark = 8
	M.see_invisible = SEE_INVISIBLE_LEVEL_TWO
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.tempxray = 1

/obj/mecha/combat/baneblade/go_out()
	if(src.occupant && isliving(src.occupant))
		var/mob.living/M = src.occupant
		if(ishuman(src.occupant))
			var/mob/living/carbon/human/H = src.occupant
			H.tempxray = 0
		if(src.occupant.client)
			src.occupant.client.view = 7
		M.see_in_dark = initial(M.see_in_dark)
		M.see_invisible = initial(M.see_invisible)
	..()

/obj/mecha/combat/baneblade/proc/closedoors()
	for(var/obj/machinery/door/poddoor/baneblade/O in range(50, src))
		spawn(0)
			O.close(1)
	src.log_message("Closed all blast doors.")
	return

/obj/mecha/combat/baneblade/verb/doors()
	set category = "Exosuit Interface"
	set name = "Toggle External Blast Doors"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	for(var/obj/machinery/door/poddoor/baneblade/outer/O in range(50, src))
		spawn(0)
			if(O.density) O.open(1)
			else O.close(1)
	src.log_message("Toggled external blast doors.")
	return

/obj/mecha/combat/baneblade/verb/doors2()
	set category = "Exosuit Interface"
	set name = "Toggle Interior Blast Doors"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	for(var/obj/machinery/door/poddoor/baneblade/medium/O in range(50, src))
		spawn(0)
			if(O.density) O.open(1)
			else O.close(1)
	src.log_message("Toggled interior blast doors.")
	return

/obj/mecha/combat/baneblade/verb/doors3()
	set category = "Exosuit Interface"
	set name = "Toggle Pilot Chamber Blast Doors"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	for(var/obj/machinery/door/poddoor/baneblade/inner/O in range(50, src))
		spawn(0)
			if(O.density) O.open(1)
			else O.close(1)
	src.log_message("Toggled pilot chamber blast doors.")
	return

/obj/mecha/combat/baneblade/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];doors=1'>Close All Blast Doors</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/baneblade/Topic(href, href_list)
	..()
	if (href_list["doors"])
		src.closedoors()
	return