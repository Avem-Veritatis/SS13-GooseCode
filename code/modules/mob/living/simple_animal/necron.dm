/mob/living/simple_animal/hostile/necron
	name = "necron warrior"
	desc = "A large, skeletal death-robot that doesn't like the emperor."
	icon = 'icons/mob/necron.dmi'
	icon_state = "necron"
	icon_living = "necron"
	icon_dead = "necron_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 1
	speak = list("Establishing control of planet...","Eliminating hostiles...")
	speak_emote = list("hisses","intones","projects","says")
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "uslessly punches"
	speed = 6
	move_to_delay = 10
	stop_automated_movement_when_pulled = 0
	maxHealth = 350
	health = 350
	harm_intent_damage = 0
	melee_damage_lower = 10
	melee_damage_upper = 20
	attacktext = "hits"
	a_intent = "harm"
	var/corpse = /mob/living/silicon/robot/necron/warrior/dead //Taken from syndicate hostile mobs, because corpses is a good idea.
	var/weapon1
	var/weapon2
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
	factions = list("necron")
	status_flags = CANPUSH
	ranged = 1
	rapid = 0
	retreat_distance = 2 //Short range and slow, good for survival.
	minimum_distance = 4
	environment_smash = 1
	luminosity = 2

	projectilesound = 'sound/weapons/Laser.ogg'
	projectiletype = /obj/item/projectile/beam/xray //gonna overwrite the use of this usually
	var/obj/item/ammo_casing/energy/beamshot/gauss/internalgun
	weapon1 = /obj/item/weapon/gun/energy/gauss/dead //Since gauss rifles don't really work for non-necrons, if you try and use this it explodes.
	var/bolt_enabled = 0 //If it just shoots regular old xray gun shots. Just for debugging purposes.
	var/shot2cooldown = 0
	var/internalguntype = /obj/item/ammo_casing/energy/beamshot/gauss
	var/datum/effect/effect/system/spark_spread/sparks

/mob/living/simple_animal/hostile/necron/adjustBruteLoss()
	sparks.set_up(3, 1, src)
	sparks.start()
	return ..()

/mob/living/simple_animal/hostile/necron/gib()
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	qdel(src)

/mob/living/simple_animal/hostile/necron/New()
	while(!ticker) //A bit preferable to deleting them since this will let ones placed on the actual map stay there.
		sleep(300)
	..()
	sparks = new /datum/effect/effect/system/spark_spread()
	internalgun = new internalguntype(src)
	if(ticker)
		if(ticker.mode)
			if(ticker.mode.name == "necron")
				for(var/datum/mind/necron in ticker.mode.necrons)
					src.friends += necron.current
	else
		return

/mob/living/simple_animal/hostile/necron/Shoot(var/target, var/start, var/user, var/bullet = 0)
	if(bolt_enabled)
		..()
		return
	if(target == start)
		return
	src.visible_message("\red The [src] fires the gauss flayer!")
	spawn(pick(0,3,3,4,4,5,5,5,5,5,6,6,6,7,7,7,7,8,8,8,9,9,9,10,10,10,10,10,11,12,13,14,15,16))
		internalgun.fire(target,user, 0, 0, 0) //Zero is literally just a filler. These variables aren't actually used.

/mob/living/simple_animal/hostile/necron/Die()
	..()
	if(usr && ticker)
		if(!istype(usr, /mob/living/silicon/robot/necron) && usr.mind && usr.mind.special_role != "Wizard")
			if(ishuman(usr))
				var/mob/living/carbon/human/H = usr
				H.necron_killcount += 1
				if(H.necron_killcount == 5)
					var/datum/game_mode/R = ticker.mode
					R.honors.Add("[usr.name] ([usr.key]) awarded honors for defeating large numbers of necrons")

/mob/living/simple_animal/hostile/necron/warrior/Die()
	..()
	if(weapon1)
		new weapon1 (src.loc)
	if(weapon2)
		new weapon2 (src.loc)
	if(prob(50))
		if(corpse)
			new corpse (src.loc)
		qdel(src)
	return

/mob/living/simple_animal/hostile/necron/Life()
	if(kill_tombs) return
	if(src.stat != DEAD && src.health < src.maxHealth) //Slow regeneration.
		src.health += 1
	if(src.stat != DEAD && ranged && !shot2cooldown) //Shoots at tactical equipment.
		for(var/obj/machinery/computer/supplydrop/S in view(2, src))
			if(src.stat && shot2cooldown)
				src.Shoot(S, get_turf(src), src)
				shot2cooldown = 1
				spawn(20) shot2cooldown = 0
		for(var/obj/effect/fake_floor/fake_wall/r_wall/baneblade/B in view(4, src))
			if(src.stat && shot2cooldown)
				src.Shoot(B, get_turf(src), src)
				shot2cooldown = 1
				spawn(15) shot2cooldown = 0
		for(var/turf/simulated/wall/W in view(4, src)) //And nearby walls if there is nothing else.
			if(src.stat && shot2cooldown)
				src.Shoot(W, get_turf(src), src)
				shot2cooldown = 1
				spawn(10) shot2cooldown = 0
	else if(src.stat != DEAD && !shot2cooldown)
		for(var/obj/machinery/computer/supplydrop/S in view(1, src))
			if(src.stat && shot2cooldown)
				src.visible_message("\red The [src] slices at the [S]!")
				S.ex_act(3)
				shot2cooldown = 1
				spawn(20) shot2cooldown = 0
	..()

/mob/living/simple_animal/hostile/necron/scarab //Literally just a weaker, reskinned necron. Adds variety and makes use of the small spyder icon I have.
	name = "necron scarab"
	desc = "A spider-like death-robot that doesn't like the emperor."
	icon_state = "spyder"
	icon_living = "spyder"
	icon_dead = "spyder_dead"
	maxHealth = 160
	health = 160
	speed = 4 //Slightly faster, but much lower health.
	move_to_delay = 8
	luminosity = 2

/mob/living/simple_animal/hostile/necron/scarab/Die()
	..()
	visible_message("<b>[src]</b> blows apart!")
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	return

/mob/living/simple_animal/hostile/scarab
	name = "scarab"
	desc = "A spider-like death-robot that doesn't like the emperor."
	icon = 'icons/mob/necron.dmi'
	icon_state = "scarab"
	icon_living = "scarab"
	icon_dead = "scarab_dead"
	pass_flags = PASSTABLE
	health = 25
	maxHealth = 25
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "cuts"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("necron")
	factions = list("necron")
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	speed = -1
	move_to_delay = 2
	wander = 1
	layer = 5
	environment_smash = 2
	luminosity = 2

/mob/living/simple_animal/hostile/scarab/New()
	if(!ticker)
		qdel(src)
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)
	..()
	name = "scarab ([rand(1, 999)])"
	if(ticker)
		if(ticker.mode)
			if(ticker.mode.name == "necron")
				for(var/datum/mind/necron in ticker.mode.necrons)
					src.friends += necron.current
	else
		return

/mob/living/simple_animal/hostile/scarab/Die()
	..()
	visible_message("\red <b>[src]</b> is smashed into pieces!")
	if(prob(75)) qdel(src)
	return

/mob/living/simple_animal/hostile/scarab/gib()
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	qdel(src)

/mob/living/simple_animal/hostile/scarab/Life()
	if(kill_tombs) return
	..()
	if(src.stat != DEAD && !istype(get_turf(src), /turf/simulated/floor/necron) && !istype(get_turf(src), /turf/simulated/floor/onecron) && !istype(get_turf(src), /turf/necron) && prob(60))
		for(var/atom/A in range(1, src))
			if(!ismob(A) && !istype(A, /turf/simulated/wall/necron) && !istype(A, /obj/effect/fake_floor/fake_wall/r_wall/monolith) && !istype(A, /obj/effect/fake_floor/monolith) && !istype(A, /obj/machinery/door/poddoor/monolith) && !istype(A, /obj/machinery/monolithcore) && !istype(A, /obj/structure/fluxarc) && !istype(A, /obj/structure/necron_entrance))
				A.ex_act(3)
				if(istype(A, /obj/structure/girder))
					A.ex_act(2)
			if(ismob(A))
				var/mob/living/M = A
				if(M.stat == DEAD && !istype(M, /mob/living/silicon/robot/necron))
					if(prob(10))
						src.visible_message("\red <b>[src]</b> methodically slices apart the body of [A]!")
						M.gib()
		if(prob(30))
			if(isturf(src.loc))
				var/turf/T = src.loc
				T.ChangeTurf(/turf/necron) //optimized turf for scarabs to build

/mob/living/simple_animal/hostile/scarab/DestroySurroundings()
	if(prob(60))
		for(var/atom/A in range(1, src))
			if(!ismob(A) && !istype(A, /turf/simulated/wall/necron) && !istype(A, /obj/effect/fake_floor/fake_wall/r_wall/monolith) && !istype(A, /obj/effect/fake_floor/monolith) && !istype(A, /obj/machinery/door/poddoor/monolith) && !istype(A, /obj/machinery/monolithcore) && !istype(A, /obj/structure/fluxarc) && !istype(A, /obj/structure/necron_entrance))
				A.ex_act(3)
	return

/mob/living/simple_animal/hostile/scarab/sleeping
	wander = 0
	stop_automated_movement = 1

/mob/living/simple_animal/hostile/necron/lychguard //Not very dangerous on its own since it is slow and has no ranged attack.
	name = "lych guard"                              //But a good support unit for the necron lord.
	icon_state = "lychguard"
	icon_living = "lychguard"
	icon_dead = "necron_dead"
	ranged = 0
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 70
	melee_damage_upper = 90
	maxHealth = 800
	health = 800
	attacktext = "slashes"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	wander = 0

/mob/living/simple_animal/hostile/necron/immortal
	name = "Necron Immortal"
	maxHealth = 500
	health = 500
	weapon1 = /obj/item/weapon/gun/energy/gaussblaster/dead
	internalguntype = /obj/item/ammo_casing/energy/beamshot/gauss/blaster

/mob/living/simple_animal/hostile/necronwraith
	name = "wraith"
	desc = "A glowing green robot with two deadly looking claws."
	icon = 'icons/mob/necron.dmi'
	icon_state = "wraith"
	icon_living = "wraith"
	icon_dead = "scarab_dead"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE //Phasing power!
	health = 45
	maxHealth = 45
	melee_damage_lower = 40 //Three hits is death for most targets.
	melee_damage_upper = 50
	attacktext = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("necron")
	factions = list("necron")
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	speed = -2
	move_to_delay = 1 //Faster even than scarabs
	wander = 1
	layer = 5
	environment_smash = 2

/mob/living/simple_animal/hostile/necronwraith/Life()
	if(kill_tombs) return
	..()

/mob/living/simple_animal/hostile/necronwraith/New()
	if(!ticker)
		qdel(src)
	..()
	if(ticker)
		if(ticker.mode)
			if(ticker.mode.name == "necron")
				for(var/datum/mind/necron in ticker.mode.necrons)
					src.friends += necron.current
	else
		return

/mob/living/simple_animal/hostile/necronwraith/Die()
	..()
	visible_message("\red <b>[src]</b> is smashed into pieces!")
	if(prob(25)) qdel(src)
	return

/mob/living/simple_animal/hostile/necronwraith/DestroySurroundings()
	var/turf/T = get_step(src, src.dir)
	src.loc = T
	playsound(src.loc, 'sound/effects/phasein.ogg', 25, 1)
	playsound(src.loc, "sparks", 50, 1)
	anim(src.loc,src,'icons/mob/mob.dmi',,"wraithblur",,src.dir)
	return

/mob/living/simple_animal/hostile/necronwraith/gib()
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	qdel(src)

/mob/living/simple_animal/hostile/grabber
	name = "runner"
	desc = "A hunched over green skeleton robot shambling around."
	icon = 'icons/mob/necron.dmi'
	icon_state = "grabber"
	icon_living = "grabber"
	icon_dead = "scarab_dead"
	health = 40
	maxHealth = 40
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "grabs"
	faction = list("necron")
	factions = list("necron")
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	speed = -1
	move_to_delay = 2
	wander = 1
	luminosity = 2
	var/alarmraised = 0

/mob/living/simple_animal/hostile/grabber/New()
	if(!ticker)
		qdel(src)
	..()
	if(ticker)
		if(ticker.mode)
			if(ticker.mode.name == "necron")
				for(var/datum/mind/necron in ticker.mode.necrons)
					src.friends += necron.current
	else
		return

/mob/living/simple_animal/hostile/grabber/Die()
	..()
	visible_message("\red <b>[src]</b> is smashed into pieces!")
	if(prob(50)) qdel(src)
	return

/mob/living/simple_animal/hostile/grabber/gib()
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	qdel(src)

/mob/living/simple_animal/hostile/grabber/Life()
	if(kill_tombs) return
	..()

/mob/living/simple_animal/hostile/grabber/AttackingTarget()
	src.visible_message("\red The [src] latches onto [target]!")
	if(prob(30))
		var/mob/living/M = target
		if(istype(M))
			M.Weaken(1)
	var/mob/living/carbon/human/H = target
	if(istype(H))
		H.reagents_speedmod += 2
	if(!alarmraised)
		alarmraised = 1
		src.visible_message("\red <b>[src]</b> lets out a loud and grating screech!")
		for(var/mob/living/simple_animal/hostile/S in range(11, src))
			if("necron" in S.factions || "necron" in S.faction)
				S.asleep = 0
				S.target = src.target
				S.Goto(pick(range(3, get_turf(src))), S.move_to_delay)