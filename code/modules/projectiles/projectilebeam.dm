//Beam based projectiles. Totally beats the baystation's beam system.
//If this works, it will improve the graphics and mechanics of some weapons a lot.
//By DrakeMarshall

/obj/item/ammo_casing/energy/beamshot
	name = "beam lens"
	projectile_type = null
	var/beam_icon = "r_beam"
	var/cap_icon = null
	var/beam_name = "energy bolt"
	var/damage = 10
	var/damage_type = BRUTE
	var/flag = "energy"
	var/stun = 0
	var/weaken = 0
	var/paralyze = 0
	var/irradiate = 0
	var/stutter = 0
	var/eyeblur = 0
	var/drowsy = 0
	var/ex_power = 0 //If it calls ex_act on target and severity of explosion force.
	var/collateral = 0 //Goes through stuff or not
	var/ex_on_hit = 0
	var/meltwalls = 0
	var/flamable = 0
	var/antivehicle = 0

/obj/item/ammo_casing/energy/beamshot/newshot()
	return

/proc/working_getline(var/atom/source, var/atom/target, var/length=124) //Getcollisionline is better except for stuff that effects everything along itself. High default range since collateral weapons fire far.
	var/turf/current = get_turf(source)
	var/turf/target_turf = get_turf(target)
	var/steps = 0
	var/list/turfs = list()
	while(current != target_turf)
		if(steps > length) return turfs
		current = get_step_towards(current, target_turf)
		turfs.Add(current)
		steps++
	return turfs

/proc/getcollisionline(var/atom/source, var/atom/target, var/length=20)
	var/turf/current = get_turf(source)
	var/turf/target_turf = get_turf(target)
	var/steps = 0
	while(current != target_turf)
		if(steps > length) return 0
		current = get_step_towards(current, target_turf)
		if(current.density) return current
		for(var/atom/A in current)
			if(A.density & (A != source)) return A
		steps++
	return target

/obj/item/ammo_casing/energy/beamshot/fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, params, var/distro, var/quiet)
	var/p_x = 16
	var/p_y = 16
	if(params)
		var/list/mouse_control = params2list(params)
		if(mouse_control["icon-x"])
			p_x = text2num(mouse_control["icon-x"])
		if(mouse_control["icon-y"])
			p_y = text2num(mouse_control["icon-y"])
	if(!collateral)
		target = getcollisionline(user,target)
		if(isturf(target))
			var/turf/T = target
			for(var/mob/living/M in range(0,T))
				target = M //Targets mobs on turf
				break
	spawn(0)
		if(collateral)
			user.Beam(get_turf(target),beam_icon,,14,124)
		else
			user.Beam(get_turf(target),beam_icon,,7,20)
	if(cap_icon)
		spawn(0)
			var/atom/movable/overlay/animation = new(get_turf(target))
			animation.icon = 'icons/obj/projectiles.dmi'
			animation.layer = 3
			animation.icon_state = src.cap_icon
			animation.master = get_turf(target)
			flick(beam_name, animation)
			if(collateral)
				sleep(20)
			else
				sleep(10)
			qdel(animation)
	if(!collateral)
		beam_hit(target, p_x, p_y, user)
		if(istype(target,/mob/living))
			var/mob/living/L = target
			if(istype(L,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = L
				if(!H) return
				if(H.check_shields(damage, "the [beam_name]") && prob(80))
					return
				if(istype(user,/mob/living/carbon/human))
					if(H.check_reflect(user.zone_sel.selecting))
						return
				else
					if(H.check_reflect("chest") && prob(90))
						return
				var/organ
				if(istype(user,/mob/living/carbon/human))
					organ = H.get_organ(check_zone(user.zone_sel.selecting))
				else
					organ = H.get_organ(check_zone("chest"))
				var/defense = H.checkarmor(organ, flag)
				H.apply_damage(damage, damage_type, organ, defense)
			else
				if(L) L.apply_damage(damage, damage_type)
			if(L) L.apply_effects(stun, weaken, paralyze, irradiate, stutter, eyeblur, drowsy, 0)
		if(ex_power && target)
			target.ex_act(ex_power)
		if(meltwalls)
			if(istype(target, /turf/simulated/wall))
				var/turf/simulated/wall/W = target
				W.thermite += 60
				W.thermitemelt(user)
		if(antivehicle)
			if(istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
				target.ex_act(1)
	else
		var/list/targets = list()
		for(var/turf/T in working_getline(user,target))
			if(T.density)
				targets.Add(T)
			for(var/atom/A in T)
				if(A.density & (A != user))
					targets.Add(A)
		for(var/atom/tohit in targets)
			beam_hit(tohit, p_x, p_y, user)
			if(istype(tohit,/mob/living))
				var/mob/living/L = tohit
				if(istype(L,/mob/living/carbon/human))
					var/mob/living/carbon/human/H = L
					if(H.check_shields(damage, "the [beam_name]") && prob(80))
						return
					if(H.check_reflect(user.zone_sel.selecting) && prob(90))
						return
					var/organ = H.get_organ(check_zone(user.zone_sel.selecting))
					var/defense = H.checkarmor(organ, flag)
					H.apply_damage(damage, damage_type, organ, defense)
				else
					L.apply_damage(damage, damage_type)
				L.apply_effects(stun, weaken, paralyze, irradiate, stutter, eyeblur, drowsy, 0)
			if(ex_power)
				tohit.ex_act(ex_power)
			if(meltwalls)
				if(istype(tohit, /turf/simulated/wall))
					var/turf/simulated/wall/W = tohit
					W.thermite += 60
					W.thermitemelt(user)
			if(antivehicle)
				if(istype(tohit,/obj/structure/)||istype(tohit,/obj/machinery/door/))
					tohit.ex_act(1)
	if(ex_on_hit)
		explosion(get_turf(target),1,3,4,6)
	if(antivehicle)
		if(istype(target,/obj/mecha/))
			var/turf/T = get_turf(target)
			explosion(T, 2, 2, 3, 0, 2, flame_range = 0)
		if(istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
			target.ex_act(1)
	if(flamable)
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/M = target
			M.adjust_fire_stacks(1)
			M.IgniteMob()
	return 1

/obj/item/ammo_casing/energy/beamshot/proc/beam_hit(var/atom/A, var/p_x, var/p_y, var/mob/living/user)
	return

/obj/item/ammo_casing/energy/beamshot/gauss
	name = "gauss flayer generator"
	beam_icon = "gauss"
	cap_icon = "green_laser"
	beam_name = "gauss flayer beam"
	damage = 30
	damage_type = BRUTE
	flag = "energy"
	select_name = "gauss flayer"
	irradiate = 60
	stutter = 20
	eyeblur = 10
	ex_power = 3

/obj/item/ammo_casing/energy/beamshot/gauss/blaster
	name = "gauss blaster generator"
	select_name = "gauss blaster"
	beam_name = "gauss blaster beam"
	damage = 5
	irradiate = 20
	stutter = 5
	eyeblur = 5
	ex_power = 2 //Less radiation and such, more raw force for destroying walls and such.

/obj/item/ammo_casing/energy/beamshot/gauss/light
	name = "light staff generator"
	select_name = "gauss bolt"
	beam_name = "gauss bolt"
	ex_power = 2

/obj/item/ammo_casing/energy/beamshot/heavy_gauss
	name = "heavy gauss generator"
	beam_icon = "gauss_heavy"
	cap_icon = "heavy_gauss"
	beam_name = "heavy gauss bolt"
	flag = "energy"
	select_name = "heavy gauss"
	damage_type = BRUTE
	damage = 150
	irradiate = 200
	stutter = 100
	eyeblur = 100
	ex_power = 1
	collateral = 1
	ex_on_hit = 1

/obj/item/ammo_casing/energy/beamshot/fluxarc
	name = "gauss flux arc generator"
	beam_icon = "gauss"
	cap_icon = "heavy_gauss"
	beam_name = "gauss flayer beam"
	damage = 0
	damage_type = BRUTE
	flag = "energy"
	select_name = "gauss flux beam"
	irradiate = 60
	stutter = 20
	eyeblur = 10
	ex_power = 2
	antivehicle = 1

/obj/item/ammo_casing/energy/beamshot/thunder
	name = "femtosecond pulse laser"
	beam_icon = "thunder"
	cap_icon = "blue_laser"
	beam_name = "electricity arc"
	damage = 25
	damage_type = BURN
	flag = "energy"
	select_name = "electric arc"
	weaken = 2
	paralyze = 1
	stutter = 10
	eyeblur = 10
	drowsy = 5
	ex_power = 3

/obj/item/ammo_casing/energy/beamshot/thunder/bolt
	beam_name = "MASSIVE THUNDERBOLT"
	select_name = "thunderbolt"
	ex_on_hit = 1
	weaken = 20
	paralyze = 10
	damage = 60

/obj/item/ammo_casing/energy/beamshot/laser
	name = "laser focusing lens"
	beam_icon = "laser"
	cap_icon = "red_laser"
	beam_name = "precision laser beam"
	damage = 35
	damage_type = BURN
	flag = "laser"
	select_name = "laser"

/obj/item/ammo_casing/energy/beamshot/laser/beam_hit(var/atom/A, var/p_x, var/p_y, var/mob/living/user)
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		if(!H.lying)
			if(p_x >= 12 && p_x <= 20 && p_y >= 23 && p_y <= 29)
				user << "\red Head shot!"
				H.apply_damage(20,"burn","head")

/obj/item/weapon/gun/energy/gauss
	name = "gauss flayer"
	desc = "An absurdly high tech rifle that has confounded the mechanicus for centuries. Standard issue in the Necron forces, this rifle releases massive discharges of energy that pulls targets apart on an atomic level."
	icon = 'icons/mob/necron.dmi'
	icon_state = "gaussflayer"
	item_state = "xray"
	w_class = 3.0
	m_amt = 3000
	force = 25.0 //There is an axehead on the end of the flayer.
	origin_tech = "combat=20;magnets=20"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/gauss)

/obj/item/weapon/gun/energy/gausspistol
	name = "gauss flayer"
	desc = "An absurdly high tech pistol that has confounded the mechanicus for centuries. The side arm of a powerful member of necron society, this pistol releases massive discharges of energy that pulls targets apart on an atomic level."
	icon = 'icons/mob/necron.dmi'
	icon_state = "gausspistol"
	item_state = "xray"
	w_class = 2.0
	m_amt = 1000
	force = 10.0
	origin_tech = "combat=20;magnets=20"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/gauss)

/obj/item/weapon/gun/energy/gaussblaster
	name = "gauss blaster"
	desc = "An absurdly high tech rifle that has confounded the mechanicus for centuries. Standard issue in the Necron Immortals, this blaster releases massive discharges of energy that pulls targets apart on an atomic level."
	icon = 'icons/mob/necron.dmi'
	icon_state = "gaussblaster"
	item_state = "xray"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=20;magnets=20"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/gauss/blaster)

/obj/item/weapon/gun/energy/gauss/dead/New()
	..()
	power_supply.rigged = 1

/obj/item/weapon/gun/energy/gaussblaster/dead/New()
	..()
	power_supply.rigged = 1

/obj/item/weapon/gun/magic/staff/lightstaff
	name = "light staff"
	desc = "An extremely high tech staff that confounds all technological understanding, a mark of status and power carried by necron lords and some crypteks."
	ammo_type = /obj/item/ammo_casing/energy/beamshot/gauss/light
	icon = 'icons/mob/necron.dmi'
	icon_state = "lightstaff"
	item_state = "staffofdoor"
	force = 40.0 //Also is a melee weapon, true to lore. Almost as good as a wraith's phase claw.
	max_charges = 2
	recharge_rate = 14

/obj/item/weapon/gun/magic/staff/lightstaff/afterattack(atom/target as mob, mob/living/user as mob, flag)
	if(charges > 0)
		charges--
		..()
	else
		user << "\red Error: The [src] is still charging."

/obj/item/weapon/gun/magic/staff/lightstaff/newshot()
	return

/obj/item/weapon/gun/magic/staff/lightstaff/greater
	force = 60.0
	max_charges = 6
	recharge_rate = 5

/obj/item/weapon/gun/energy/laserbeam
	name = "laser gun"
	desc = "A laser gun that actually follows the laws of physics."
	icon_state = "laser"
	item_state = "laser"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=3;magnets=2"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/laser)

/obj/item/weapon/gun/energy/tesla
	name = "ARC Gun"
	desc = "A gun that shoots thunder."
	icon_state = "disabler"
	item_state = "disabler"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=6;magnets=10"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/thunder)

/obj/item/weapon/gun/energy/thunder
	name = "Thunder Rifle"
	desc = "A gun that shoots massive thunderbolts."
	icon_state = "disabler"
	item_state = "disabler"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=10;magnets=12"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/thunder/bolt)

/obj/item/weapon/gun/energy/gauss/robo/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		if(R && R.cell)
			var/obj/item/ammo_casing/energy/shot = ammo_type[select]
			if(R.cell.use(shot.e_cost))
				..()
				src.power_supply.give(shot.e_cost) //This is a messy way to go about it... But it can work for now.
			else
				R << "\red Not enough power."
	return

/obj/item/weapon/gun/energy/gauss/robo/emp_act()
	return

/obj/item/weapon/gun/energy/gausspistol/robo/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		if(R && R.cell)
			var/obj/item/ammo_casing/energy/shot = ammo_type[select]
			if(R.cell.use(shot.e_cost))
				..()
				src.power_supply.give(shot.e_cost)
			else
				R << "\red Not enough power."
	return

/obj/item/weapon/gun/energy/gausspistol/robo/emp_act()
	return

/obj/item/weapon/gun/energy/gaussblaster/robo/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		if(R && R.cell)
			var/obj/item/ammo_casing/energy/shot = ammo_type[select]
			if(R.cell.use(shot.e_cost))
				..()
				src.power_supply.give(shot.e_cost) //This is a messy way to go about it... But it can work for now.
			else
				R << "\red Not enough power."
	return

/obj/item/weapon/gun/energy/gaussblaster/robo/emp_act()
	return

/obj/item/weapon/gun/energy/longlas //this is a work in progress... will be significantly improved soon.
	name = "Long-Las"                 //Considering giving some extra gear to IG, like long-las, something rapid fire (possibly has to be set up), maybe a higher damage thing like a shotgun, maybe a weak autogun, and a stubber pistol. Also for fun a 9-70 entrenchment tool which can build weak fortifications and clear snow.
	desc = "Standed issue long-ranged precision weapon of the Imperial Guard" //For fun also make a book "Imperial Infantryman's Uplifting Primer"
	icon_state = "longlas"                                                    //lol what if a guard started corruption by destroying the book
	item_state = "longlas"
	slot_flags = SLOT_BACK
	origin_tech = "combat=6;materials=2;syndicate=2"
	fire_sound = 'sound/weapons/lasgun.ogg'
	w_class = 5
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/laser)
	var/zoom = 0

/obj/item/weapon/gun/energy/longlas/dropped(mob/user)
	user.client.view = world.view
	..()

/obj/item/weapon/gun/energy/longlas/verb/zoom()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 0
	if(!zoom && global_hud.darkMask[1] in usr.client.screen)
		usr << "Your welding equipment gets in the way of you looking down the scope"
		return
	if(!zoom && usr.get_active_hand() != src)
		usr << "You are too distracted to look down the scope, perhaps if it was in your active hand this might work better"
		return

	if(usr.client.view == world.view)
		usr.client.view = 12
		zoom = 1
	else
		usr.client.view = world.view
		zoom = 0
	usr << "<font color='[zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>"
	return

/obj/item/weapon/gun/energy/longlas/attackby(obj/item/weapon/W, mob/user) //Can be reloaded /and/ recharged... I would disable the recharging feature but this has to be an energy based weapon.
	if(istype(W, /obj/item/ammo_box/magazine/lasgunmag))
		user << "You reload the [src]."
		src.power_supply.give(1000)
		update_icon()
		qdel(W)
		return
	..()