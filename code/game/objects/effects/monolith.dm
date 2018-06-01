/*
So. Necron modes.
Going to outline the new plan for them here, because might as well somewhere.
Six or so powerful moving turf monoliths will surround the outpost. The lord starts on one.
The lord may teleport between them, create units at a monolith, and teleport units from monolith to monolith.
The lord may also order the monolith to move somewhere else. It will blast apart anything in its way and advance.
The lord may also view each monolith at a distance and deliver orders to it from this vantage.
Essentially, the lord's objective is to crush all the outpost command centers or kill everyone.
The outpost's objectives is to destroy all six monoliths, then escape while exterminatus is called.
*/

/obj/effect/landmark/monolithcore
	name = "Monolith Core"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/monolithspawn
	name = "Monolith Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/machinery/door/poddoor/monolith //Hopefully the fake density variable will make all the simple mob necrons understand that they can use this kind of door.
	name = "lockdown door"
	desc = "A sturdy necron lockdown door."
	icon = 'icons/mob/necron.dmi'
	icon_state = "closed"
	density = 1
	opacity = 1
	var/stayopen = 0
	var/health = 10 //Unlike the baneblade, monolith doors are actually weaker than the walls. Still should keep a single plasma grenade from demolishing one unless it is placed brilliantly.
	var/density2 = 0

/obj/machinery/door/poddoor/monolith/ex_act(exforce)
	var/force = 6-exforce
	if(health > 0)
		health -= force
	else
		..(1)

/obj/machinery/door/poddoor/monolith/HasProximity(atom/movable/AM as mob|obj)
	if(istype(AM, /mob/living/silicon/robot/necron) || istype(AM, /mob/living/simple_animal/hostile/necron) || istype(AM, /mob/living/simple_animal/hostile/scarab) || istype(AM, /mob/living/simple_animal/hostile/necronwraith))
		if(src.density)
			proxopen()
	..()

/obj/machinery/door/poddoor/monolith/Bumped(mob/M as mob|obj)
	if(istype(M, /mob/living/silicon/robot/necron))
		if(src.density)
			proxopen()
	..()

/obj/machinery/door/poddoor/monolith/proc/proxopen()
	if(!density)
		stayopen = 1
		return
	spawn(0)
		density = 0
		open(1)
		spawn(50)
			stayopen = 1
			while(stayopen)
				sleep(30)
				if(!locate(/mob/living/silicon/robot/necron in get_turf(src)))
					stayopen = 0
			close(1)
	return

/obj/machinery/door/poddoor/monolith/proc/longtoggle()
	spawn(0)
		stayopen = 1
		open(1)
		spawn(200)
			close(1)
	return

/obj/machinery/door/poddoor/monolith/CanPass(atom/movable/AM, turf/target, height=0, air_group=0)
	if(air_group || (height==0))
		return 1
	if(istype(AM, /mob/living/silicon/robot/necron) || istype(AM, /mob/living/simple_animal/hostile/necron) || istype(AM, /mob/living/simple_animal/hostile/scarab) || istype(AM, /mob/living/simple_animal/hostile/necronwraith))
		spawn(0)
			open(1)
			spawn(50)
				close(1)
		return 1
	return src.density

/obj/effect/fake_floor/monolith
	name = "monolith"
	desc = "A monolith floor."
	icon_state = "monolith"
	var/health = 20

/obj/effect/fake_floor/monolith/ex_act(force)
	if(health >= 0)
		health -= force
	else
		..(1)

/obj/effect/fake_floor/fake_wall/r_wall/monolith
	name = "monolith"
	desc = "Looks sturdy."
	icon = 'icons/mob/tombs.dmi'
	icon_state = "lwall0"
	base_icon_state = "lwall"
	explosion_recursions = 60
	var/health = 20

/obj/effect/fake_floor/fake_wall/r_wall/monolith/ex_act(exforce)
	var/force = 6-exforce
	if(health > 0)
		health -= force
		if(health <= 15)
			src.overlays += image('icons/turf/walls.dmi', "armordamage")
	else
		for(var/obj/structure/fluxarc/FA in range(0, src))
			qdel(FA)
		..(1)

/obj/effect/fake_floor/fake_wall/r_wall/monolith/thermitemelt(mob/user as mob)
	health -= 5
	if(health <= 15)
		src.overlays += image('icons/turf/walls.dmi', "armordamage")
	return

/obj/effect/fake_floor/fake_wall/r_wall/monolith/ankh
	icon_state = "lawall0"
	base_icon_state = "lawall"

/datum/necron_group
	var/name = "warrior phalanx"
	var/list/mob/living/simple_animal/necrons = list()

/datum/necron_group/New()
	..()
	src.name = "[src.name] ([rand(0, 999)])"

/datum/necron_group/scarab
	name = "canoptek scarab swarm"

/datum/necron_group/immortal
	name = "immortal squad"

/datum/necron_group/lych
	name = "lych guard phalanx"

/datum/necron_group/wraith
	name = "canoptek wraith"

/obj/machinery/monolithcore
	name = "monolith core"
	desc = "The core of a necron monolith."
	icon = 'icons/obj/monolithcore.dmi'
	icon_state = "core"
	pixel_x = -4
	pixel_y = -4
	anchored = 1
	luminosity = 10
	var/health = 300
	var/datum/fake_area/area
	var/moving = null
	var/list/datum/necron_group/squads = list()
	var/warningcooldown = 0

/obj/machinery/monolithcore/proc/healthcheck()
	if(health <=0)
		src.ex_act(1)

/obj/machinery/monolithcore/bullet_act(obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	healthcheck()

/obj/machinery/monolithcore/New()
	..()
	spawn(20)
		src.name = "monolith core ([rand(0, 999)])"
		area = new /datum/fake_area()
		for(var/obj/effect/fake_floor/monolith/FF in range(6, src))
			area.add_turf(FF)
		for(var/obj/effect/fake_floor/fake_wall/r_wall/monolith/FW in range(6, src))
			area.add_turf(FW)
		processing_objects.Add(src)

/obj/machinery/monolithcore/ex_act() //Destroy the core and the entire thing shuts down.
	if(usr && ticker)
		if(!istype(usr, /mob/living/silicon/robot/necron) && usr.mind && usr.mind.special_role != "Wizard")
			award(usr, "Destroyed Monolith")
			var/datum/game_mode/R = ticker.mode
			R.honors.Add("<b>[usr.name]</b> ([usr.key]) awarded honors for destroying a monolith") //Anyone who destroys a monolith gets special honors.
	for(var/obj/effect/fake_floor/monolith/FF in area.ship_turfs)
		FF.icon_state = "monolithoff"
	for(var/obj/effect/fake_floor/fake_wall/r_wall/monolith/FW in area.ship_turfs)
		FW.base_icon_state = "wall"
	for(var/obj/effect/fake_floor/fake_wall/r_wall/monolith/ankh/FW2 in area.ship_turfs)
		FW2.base_icon_state = "awall"
	for(var/obj/effect/fake_floor/fake_wall/r_wall/monolith/FW in area.ship_turfs)
		FW.relativewall()
		for(var/obj/structure/fluxarc/FA in range(0, FW))
			FA.broken = 1
	qdel(src)

/obj/machinery/monolithcore/process()
	if(!warningcooldown)
		for(var/obj/effect/fake_floor/fake_wall/r_wall/baneblade/BB in range(12, src))
			for(var/mob/living/silicon/robot/necron/lord2/N in world)
				N << "<span class='noticealien'>ALERT: Enemy heavy armor detected near [src.name].</span>"
			warningcooldown = 1
			spawn(200) warningcooldown = 0
	if(moving)
		if(prob(65))
			area.move(moving, 2, smoothingtime = 5)
		return
	if(prob(3))
		if(area)
			area.move(pick(NORTH, SOUTH, EAST, WEST), 2, smoothingtime = 5)