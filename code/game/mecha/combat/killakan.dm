/obj/mecha/combat/killakan
	desc = "Is this...? What is this? I don't.... what the fuck is this?"
	name = "KillaKan"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "killakan"
	step_in = 6
	health = 20000
	deflect_chance = 50
	damage_absorption = list("brute"=10,"fire"=10,"bullet"=10,"laser"=10,"energy"=10,"bomb"=10)
	max_temperature = 65000
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/killakan
	add_req_access = 0
	internal_damage_threshold = 5
	force = 45
	max_equip = 6
	can_drop = 0
	var/kantimer = 1

/obj/mecha/combat/killakan/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/flamer2(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	nominalsound = pick('sound/mecha/which.ogg')
	return

/obj/mecha/combat/killakan/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999
	src.verbs -= /obj/mecha/verb/start_move_inside											//We remove the normal way to get in

/obj/mecha/combat/killakan/bullet_act(var/obj/item/projectile/Proj) //wrapper
	src.log_message("Hit by projectile. Type: [Proj.name]([Proj.flag]).",1)
	call((proc_res["dynbulletdamage"]||src), "dynbulletdamage")(Proj) //calls equipment
	..()
	spawnjunk(loc)
	return

/obj/mecha/combat/killakan/proc/spawnjunk()
	var/junkish = rand(1,11)
	var/attackedsound = pick('sound/mecha/stomp.ogg', 'sound/mecha/stompem.ogg', 'sound/mecha/stompy.ogg')
	if(kantimer)
		kantimer = 0
		playsound(loc, attackedsound, 50, 0)
	switch (junkish)
		if (1) new /obj/item/weapon/screwdriver(loc)
		if (2) new /obj/item/mecha_parts/part/ripley_left_arm(loc)
		if (3) new /obj/item/stack/sheet/plasteel(loc)
		if (4) new /obj/item/weapon/gun/projectile/BPMP(loc)
		if (5) new /obj/item/weapon/extinguisher(loc)
		if (6) new /obj/item/weapon/gun/projectile/slugga(loc)
		if (7) new /obj/item/mecha_parts/part/phazon_left_leg(loc)
		if (8) new /obj/item/trash/cheesie(loc)
		if (9) new /obj/item/device/flash(loc)
		//if (10) new /obj/item/device/transfer_valve(loc)
		if (11) kantimer = 1
	return

																			//we insert the new way to get in.
/obj/mecha/combat/killakan/verb/ork_move_inside() 							//just a rehash of move_inside to stop the humans using kans debate.
	set category = "Object"
	set name = "Enter Exosuit"
	set src in oview(1)
	if (!isork(usr) && !isgretchin(usr))
		usr << "\blue <B>You have no idea how to get inside a [src.name].</B>"
		return
	else
		move_inside(usr)