//Big huge necron stuff for fluff mostly but also quite deadly in their own right. -DrakeMarshall
//Best part is, these icons are so large I can actually just scale these things and call it a day. These are literally just photographs which I gave transparent background, green glow in the appropriate areas, and a gaussian blur.

/mob/living/simple_animal/hostile/monolith
	name = "Necron Monolith"
	desc = "A huge floating necron construction equipped with an ungodly amount of firepower."
	icon = 'icons/mob/necronbuilding.dmi'
	icon_state = "monolith"
	icon_living = "monolith"
	icon_dead = "monolith"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	speak_emote = list("broadcasts")
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "uslessly punches"
	speed = 70
	move_to_delay = 70 //REALLY REALLY SLOW
	stop_automated_movement_when_pulled = 0
	maxHealth = 2000
	health = 2000
	harm_intent_damage = 0
	melee_damage_lower = 10
	melee_damage_upper = 20
	attacktext = "hits"
	a_intent = "harm"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	faction = list("necron")
	status_flags = CANPUSH
	ranged = 1
	rapid = 0
	retreat_distance = 2
	minimum_distance = 11 //Not that easy to approach as a human.
	projectilesound = 'sound/weapons/Laser.ogg'
	projectiletype = /obj/item/projectile/beam/xray //gonna overwrite the use of this so w/e
	pixel_x = -32 //Proper location.
	var/obj/item/ammo_casing/energy/beamshot/gauss/internalgun

/mob/living/simple_animal/hostile/monolith/New()
	..()
	internalgun = new /obj/item/ammo_casing/energy/beamshot/gauss(src)
	if(ticker.mode.name == "necron")
		for(var/datum/mind/necron in ticker.mode.necrons)
			src.friends += necron.current
	else
		return

/mob/living/simple_animal/hostile/monolith/Shoot(var/target, var/start, var/user, var/bullet = 0)
	if(target == start)
		return
	var/turf/s1 = get_step(get_turf(src),NORTH) //monolith has four guns, three visible (the fourth is in the same location as the mid one behind) so that three shots looks like the right graphic.
	var/turf/s2 = get_step(get_turf(src),NORTHWEST)
	var/turf/s3 = get_step(get_turf(src),NORTHEAST)
	var/obj/f1 = new /obj/effect/effect/sparks(s1) //Seriously hack-ish but it should work and this is a cool effect.
	var/obj/f2 = new /obj/effect/effect/sparks(s2)
	var/obj/f3 = new /obj/effect/effect/sparks(s3)
	spawn(pick(2,3,4,5,6,7,8,9,10,11,12,13,14,15))
		internalgun.fire(target,f1, 0, 0, 0) //Zero is literally just a filler. These variables aren't actually used.
		internalgun.fire(target,f2, 0, 0, 0)
		internalgun.fire(target,f3, 0, 0, 0) //Actually passes turfs as firers but the code is adaptable it can still do it with that.

/mob/living/simple_animal/hostile/monolith/gib() //Yeah that would look bad.
	return

/obj/structure/gausspylon
	name = "Gauss Pylon"
	desc = "A monstrous necron turret. Designed with the sole purpose of mass destruction in mind."
	icon = 'icons/mob/necronbuilding.dmi'
	icon_state = "gausspylon"
	density = 1
	opacity = 1
	anchored = 1
	var/list/targets
	var/obj/item/ammo_casing/energy/beamshot/gauss/internalgun
	var/charged = 1

/obj/structure/gausspylon/New(loc)
	..()
	internalgun = new /obj/item/ammo_casing/energy/beamshot/heavy_gauss(src)
	src.name = "[src.name] ([rand(0, 999)])"

/obj/structure/gausspylon/proc/fire(targets)
	spawn()
		for(var/T in targets)
			for(var/mob/living/M in view(7,T)) //Gives them a variable warning.
				shake_camera(M, 20, 1)
			var/target = get_turf(T)
			spawn(pick(5,10,15,20,25,30,35,40,45,50,55,60,65,70,75))
				internalgun.fire(target,src, 0, 0, 0)
			sleep(600)
	return