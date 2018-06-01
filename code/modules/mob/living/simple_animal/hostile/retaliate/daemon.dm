/*
Basic groundwork for daemonic NPCs
Eventually they will be used in daemon contracts and such. Right now I can make some agressive NPCs for the hulk.
-Drake
*/

/mob/living/simple_animal/hostile/retaliate/daemon
	name = "spirit"
	real_name = "spirit"
	desc = "A malevolent presence."
	icon = 'icons/mob/mob.dmi'
	icon_state = "void_demon"
	icon_living = "void_demon"
	icon_dead = "daemon_remains"
	layer = 4
	blinded = 0
	anchored = 1	//  don't get pushed around
	density = 0
	invisibility = INVISIBILITY_OBSERVER //This is what makes it a proper spirit.
	maxHealth = 500
	health = 500
	speak_emote = list("hisses")
	emote_hear = list("wails","screeches")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	harm_intent_damage = 5
	melee_damage_lower = 50
	melee_damage_upper = 150
	attacktext = "flogs"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speed = 0
	stop_automated_movement = 1
	status_flags = 0
	environment_smash = 0
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 450 //A good fire would hurt one, but not something small.
	heat_damage_per_tick = 15	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 10	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	unsuitable_atoms_damage = 10

	factions = list("void")

	Life()
		..()
		see_invisible = SEE_INVISIBLE_OBSERVER //Daemons can see into the immaterial world, I should think.
		var/turf/T = get_turf(src)
		if(T.flags & NOJAUNT)
			adjustBruteLoss(20)
			if(src.stat != DEAD)
				src.visible_message("<span class='danger'>\the [src] hisses in agony over the holy water!</span>")
		for(var/obj/item/clothing/tie/medal/gold/sealofpurity/S in range(1, T))
			adjustBruteLoss(1)
			if(prob(25))
				if(src.stat != DEAD)
					src.visible_message("<span class='danger'>\the [src] growls at the [S]!</span>")
			if(prob(5))
				if(invisibility != 0)
					if(src.stat != DEAD)
						src.visible_message("<span class='danger'>The holy power of the [S] forces \the [src] to materialize!</span>")
						invisibility = 0
						density = 1
						spawn(25)
							density = 0
							invisibility = INVISIBILITY_OBSERVER

	Move(NewLoc, direct) //Daemons are blocked by psychic walls too.
		var/turf/destination = get_step(get_turf(src),direct)
		for(var/obj/effect/warp/W in range(destination, 0)) //Ghost walls. For no particular reason. -Drake
			if(W.ghost_density)
				return
		..(NewLoc, direct)

/mob/living/simple_animal/hostile/retaliate/daemon/hulk
	name = "neverborn"
	real_name = "neverborn"
	maxHealth = 300
	health = 300

/mob/living/simple_animal/hostile/retaliate/daemon/hulk/Life()
	..()
	if(src.stat == DEAD) return
	for(var/mob/living/M in range(7, src))
		if(M != src && M.stat != DEAD && !("void" in M.factions))
			enemies.Add(M)
			emote("hisses at \the [M]")
			playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
	if(prob(25)) //Becomes visible (and actually damagable) for a moment.
		invisibility = 0
		density = 1
		spawn(25)
			density = 0
			invisibility = INVISIBILITY_OBSERVER

/mob/living/simple_animal/hostile/retaliate/daemon/lesser
	name = "wight"
	real_name = "wight"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ws"
	icon_living = "ws"
	icon_dead = "ws_dead"
	attacktext = "drains life from"
	maxHealth = 40
	health = 40
	melee_damage_lower = 10
	melee_damage_upper = 20
	density = 1

	Life()
		..()
		if(src.stat == DEAD) return
		for(var/mob/living/M in range(7, src))
			if(M != src && M.stat != DEAD && !("void" in M.factions))
				enemies.Add(M)
				emote("hisses at \the [M]")
				playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
		if(prob(5)) //Becomes visible for a moment.
			invisibility = 0
			spawn(15)
				invisibility = INVISIBILITY_OBSERVER

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/guard
	name = "Warped Guardsman"
	desc = "A twisted, shadowed, and warp consumed creature that appears to have once been a regular human."
	icon = 'icons/mob/mob.dmi'
	icon_state = "shadow"
	icon_living = "shadow"
	icon_dead = "shadow_dead"
	maxHealth = 120
	health = 120

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/predator
	name = "ebon geist"
	real_name = "ebon geist"
	attacktext = "tears into"
	icon = 'icons/mob/mob.dmi'
	icon_state = "daemon"
	icon_living = "daemon"
	icon_dead = "jaunt"
	maxHealth = 80
	health = 80
	melee_damage_lower = 20
	melee_damage_upper = 30

/mob/living/simple_animal/hostile/retaliate/daemon/poltergeist //To make people superstitious and maybe to give the preacher something to do.
	name = "malicious spirit"
	real_name = "malicious spirit"
	icon_state = "revenant_idle"
	icon_living = "revenant_idle"
	icon_dead = "shade_dead"
	attacktext = "curses"
	maxHealth = 50
	health = 50
	melee_damage_lower = 5 //Very low actual damage. These aren't meant to be immediate threats to life.
	melee_damage_upper = 5
	density = 0
	environment_smash = 1 //Spooky ghost smashing windows.
	var/is_zombie = 0
	var/attack_rate = 98
	var/default_attack_rate = 98
	var/agressive_attack_rate = 10

	Life()
		..()
		if(src.stat == DEAD) return
		if(istype(src, /mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/nurgle)) return //Not the same passive effects.
		for(var/mob/living/M in range(7, get_turf(src)))
			if(M != src && M.stat != DEAD && !("void" in M.factions))
				enemies.Add(M)
		for(var/mob/living/carbon/human/H in range(1, get_turf(src)))
			if(H.stat == DEAD && src.is_zombie == 0)
				src.possess(H)
		for(var/mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/P in range(1, get_turf(src)))
			if(P.stat != DEAD && P.is_zombie == 1 && src.is_zombie == 0 && prob(25))
				P.visible_message("<b>The [src] possesses the corpse of [P], joining its brethren already inhabiting it!<b>")
				P.maxHealth += 150
				P.health += 150
				P.speed -= 1
				qdel(src)
				return
		for(var/obj/machinery/D in range(7, get_turf(src)))
			if(prob(1) && prob(10))
				D.emp_act(1) //Screws with nearby machinery.
		for(var/mob/living/carbon/human/H in range(7, get_turf(src)))
			if(prob(1) && prob(20))
				H.emp_act(1)
		for(var/obj/item/O in range(2, src))
			if(prob(1) && prob(10)) //Chance to curse objects lying around.
				var/cursepath = pick(/datum/curse_effect/ignite, /datum/curse_effect/blind, /datum/curse_effect/undroppable, /datum/curse_effect/stone)
				O.curses += new cursepath
		for(var/obj/item/weapon/reagent_containers/R in range(4, get_turf(src)))
			if(prob(1 && prob(10)))
				if(R.reagents)
					R.reagents.add_reagent("toxin", 5) //Makes nearby food inedible.
					R.reagents.add_reagent("radium", 5)
		for(var/obj/machinery/light/L in range(7, get_turf(src)))
			if(prob(1 && prob(7))) //Blows up a light.
				L.on = 0
				L.rigged = 1
				L.update()
				spawn(10)
					L.on = 1
					L.update()

		var/turf/T = get_turf(src)
		var/area/A = T.loc
		if(A)
			var/light_amount = 5
			if(A.lighting_use_dynamic)	light_amount = T.lighting_lumcount
			else						light_amount =  10
			if(light_amount > 18) //A bright enough light can force them to appear. Has to be pretty bright, however.
				if(invisibility != 0)
					invisibility = 0
					retreat_distance = 10 //Runs away from bright lights.
					minimum_distance = 10
					if(src.stat != DEAD)
						src.visible_message("<span class='danger'>\the [src] materializes in the bright light!</span>")
				adjustBruteLoss(2)
				if(src.stat != DEAD)
					src.visible_message("<span class='danger'>\the [src] hisses in pain from the bright light!</span>")
			else
				if(invisibility == 0)
					if(!is_zombie)
						invisibility = INVISIBILITY_OBSERVER
						spawn(50) //Five seconds after leaving the light, the spirit will once more be agressive.
							retreat_distance = null
							minimum_distance = 1

	AttackingTarget()
		if(prob(attack_rate)) return //Lower and less reliable attack rate usually, unless it is actually fighting or it is a zombie.
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(H.purity > 0)
				if(prob(H.purity*3))
					H.visible_message("<span class='danger'>\the [src] curses [H]!</span>")
					H.visible_message("<span class='danger'>[H] resists \the [src]'s curse!</span>")
					return
			var/obj/item/weapon/nullrod/N = locate() in H
			if(N)
				if(prob(25))
					H.visible_message("<span class='danger'>\the [src] curses [H]!</span>")
					H.visible_message("<span class='danger'>The [N] protects [H] from \the [src]'s curse!</span>")
					return
			var/obj/item/clothing/tie/medal/gold/sealofpurity/S = locate() in H
			if(S)
				if(prob(25))
					H.visible_message("<span class='danger'>\the [src] curses [H]!</span>")
					H.visible_message("<span class='danger'>The [S] protects [H] from \the [src]'s curse!</span>")
					return
		..()
		var/mob/living/carbon/L = target
		if(istype(L))
			if(prob(10))
				L.Weaken(7)
				L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")
				src.start_pulling(L) //Drags the target away instead of attacking them, because spookyness.
				retreat_distance = 10
				minimum_distance = 10
				spawn(100)
					retreat_distance = null
					minimum_distance = 1
			if(prob(10))
				L.hallucination += 30
			if(prob(10))
				L.sleeping += 3
			if(prob(10))
				L.fire_stacks += 1
				L.IgniteMob()
			if(prob(10))
				randmutb(L)
			if(prob(10))
				L.reagents.add_reagent("toxin", 10)

	Die()
		src.visible_message("<span class='warning'>The [src] is dispelled!</span>")
		..()
		if(is_zombie)
			for(var/mob/M in contents)
				M.loc = src.loc
			qdel(src)

	adjustBruteLoss(var/damage)
		..(damage)
		if(!is_zombie)
			attack_rate = agressive_attack_rate
			spawn(150) //Stays more agressive for a bit.
				attack_rate = default_attack_rate

/mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/proc/possess(var/mob/living/carbon/human/H) //Hooray for blob code.
	loc.visible_message("<span class='warning'>The [src] possesses the corpse of [H.name]!</span>")
	if(H.wear_suit)
		var/obj/item/clothing/suit/armor/A = H.wear_suit
		if(A.armor && A.armor["melee"])
			maxHealth += A.armor["melee"] //That zombie's got armor, I want armor!
	maxHealth += 100
	health = maxHealth
	speed = 1
	name = H.name
	desc = "A shambling corpse animated by chaos!"
	melee_damage_lower = 10
	melee_damage_upper = 15
	icon = H.icon
	icon_state = "husk_s"
	overlays = H.overlays
	H.hair_style = null
	H.update_hair()
	H.loc = src
	is_zombie = 1
	invisibility = 0
	density = 1
	attack_rate = 0

/mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/nurgle //Like a poltergeist, only it spreads diseases instead of cursing things. Only engages in direct combat when threatened. It is a bit more powerful in direct combat.
	name = "unclean spirit"
	real_name = "unclean spirit"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ks"
	icon_living = "ks"
	icon_dead = "ks_dead"
	icon_gib = "syndicate_gib"
	attack_rate = 100
	default_attack_rate = 100
	agressive_attack_rate = 0
	environment_smash = 0
	maxHealth = 80
	health = 80
	melee_damage_lower = 10 //Very low actual damage. These aren't meant to be immediate threats to life.
	melee_damage_upper = 10
	alpha = 100 //The sprite is fully opaque, so this will make it semitransparent.
	var/virus_spread = list(/datum/disease/advance/flu, /datum/disease/advance/cold, /datum/disease/brainrot, /datum/disease/rot, /datum/disease/advance/nurgle, /datum/disease/cold9, /datum/disease/fluspanish, /datum/disease/transformation/zombie)

/mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/nurgle/Life()
	..()
	if(src.stat == DEAD) return
	for(var/mob/living/M in range(7, get_turf(src)))
		if(M != src && M.stat != DEAD && !("void" in M.factions))
			enemies.Add(M)
			if(prob(2))
				src.target = M //Chance it will switch targets when it is near multiple people.
	for(var/mob/living/carbon/human/H in range(3, get_turf(src)))
		if(prob(1) && prob(20))
			var/virus_type = pick(virus_spread)
			var/datum/disease/D = new virus_type
			D.holder = H
			D.affected_mob = H
			H.viruses += D

/mob/living/simple_animal/hostile/retaliate/daemon/bloodletter
	name = "Bloodletter"
	real_name = "Bloodletter"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "bloodletter"
	icon_living = "bloodletter"
	icon_dead = "daemon_remains"
	maxHealth = 650
	health = 650
	harm_intent_damage = 0
	melee_damage_lower = 100
	melee_damage_upper = 150
	speed = 0
	move_to_delay = 2
	alpha = 240
	attacktext = "mauls"

	attack_animal(mob/living/simple_animal/M as mob) //A real daemon that isn't some lesser warp creature is particularly resistant to shades.
		if(M.melee_damage_upper == 0)
			M.emote("[M.friendly] [src]")
		else
			if(M.attack_sound)
				playsound(loc, M.attack_sound, 50, 1, 1)
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
			add_logs(M, src, "attacked", admin=0)
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
				damage /= 4
			adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette
	name = "Daemonette"
	real_name = "Daemonette"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemon_remains"
	harm_intent_damage = 0

	attack_animal(mob/living/simple_animal/M as mob)
		if(M.melee_damage_upper == 0)
			M.emote("[M.friendly] [src]")
		else
			if(M.attack_sound)
				playsound(loc, M.attack_sound, 50, 1, 1)
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
			add_logs(M, src, "attacked", admin=0)
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
				damage /= 4
			adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror
	name = "Horror of Tzeench"
	real_name = "Horror of Tzeench"
	speed = -1
	move_to_delay = 1
	harm_intent_damage = 0
	speak_chance = 5
	speak_emote = list("giggles", "laughs", "chuckles")
	attacktext = "curses"
	alpha = 150
	var/horror_color = "#FF0088"

	attack_animal(mob/living/simple_animal/M as mob)
		if(M.melee_damage_upper == 0)
			M.emote("[M.friendly] [src]")
		else
			if(M.attack_sound)
				playsound(loc, M.attack_sound, 50, 1, 1)
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
			add_logs(M, src, "attacked", admin=0)
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
				damage /= 4
			adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/Life()
	..()
	if(src.stat == DEAD) return
	if(src.horror_color == "FF0088" && src.stance == HOSTILE_STANCE_ATTACK)
		for(var/mob/living/carbon/C in range(src, 1))
			if(C in src.enemies)
				C.fire_stacks += 1
				C.IgniteMob()
	if(prob(25))
		for(var/atom/movable/target in range(5, get_turf(src)))
			src.icon = target.icon
			src.icon_state = target.icon_state
			src.overlays = target.overlays
			src.color = horror_color
			src.GlichAnimation(changecolor = 0)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/blue
	speed = 2
	move_to_delay = 4
	horror_color = "0000FF"
	speak_emote = list("scowls")
	maxHealth = 150
	health = 150
	melee_damage_lower = 20
	melee_damage_upper = 40
	attacktext = "chokes"

/mob/living/simple_animal/hostile/retaliate/daemon/plaguebearer
	name = "Plaguebearer"
	real_name = "Plaguebearer"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "plaguebearer"
	icon_living = "plaguebearer"
	icon_dead = "daemon_remains"
	maxHealth = 850
	health = 850
	speed = 1
	move_to_delay = 5
	melee_damage_lower = 50
	melee_damage_upper = 100

	attack_animal(mob/living/simple_animal/M as mob)
		if(M.melee_damage_upper == 0)
			M.emote("[M.friendly] [src]")
		else
			if(M.attack_sound)
				playsound(loc, M.attack_sound, 50, 1, 1)
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
			add_logs(M, src, "attacked", admin=0)
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
				damage /= 4
			adjustBruteLoss(damage)