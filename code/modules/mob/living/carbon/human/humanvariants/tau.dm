/mob/living/carbon/human/tau
	name = "Unknown"
	real_name = "Unknown"
	voice_name = "Unknown"
	icon = 'icons/mob/tau.dmi'
	suicide_allowed = 0
	universal_speak = 1
	factions = list("tau")

/mob/living/carbon/human/tau/CanPass(atom/A, mob/target)//new
	if(istype(A) && A.pass_flags == PASSTAU)
		return 1
	if(istype(src) && src.density == 0)
		return prob(99)
	else
		return 0 //prob(2) //I'm sorry but I don't think you should be able to step through a wall if you run into it enough times...

/mob/living/carbon/human/tau/New()
	..()
	sleep (5)

	var/namelist = list ("Lo Kan", "Rho No", "Sen Jon", "Kas Lo", "Len Kan", "Ren Cron", "San Kas", "Ver Cha", "Dra Nan", "Tam Ra", "Lid Sa", "Chan Dra", "So Ka", "Las Nan", "Shrek Na", "Kes Ra", "Trab Pu Cip")
	var/rndname = pick(namelist)

	name = "Shas [rndname]"
	real_name = "Shas [rndname]"
	spawn(10)
		var/loadout = input("Select a loadout.","Loadout Selection") as null|anything in list("Fire Warrior", "XV15 Stealth Suit", "Water Caste Merchant", "Water Caste Diplomat")
		switch(loadout)
			if("Fire Warrior")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/fwarmor, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/fwhelmet, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/fwboots, slot_shoes)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tpc, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/under/taum, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/material, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/firecaste/W = new
				W.icon_state = "shas"
				W.assignment = "Tau Fire Warrior"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("XV15 Stealth Suit")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/tausuit/XV15, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/tausuit/XV15, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/fwboots, slot_shoes)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/burstcannon, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/under/taum, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/firecaste/W = new
				W.icon_state = "shas"
				W.assignment = "Tau Fire Warrior"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("Water Caste Merchant")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/head/tau/watercasteold, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/under/tau/watercasteold, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/device/tau/drone/controller, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/tau/drone/gun, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_r_hand)
				real_name = "Por [rndname]"
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "por"
				W.assignment = "Tau Merchant"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("Water Caste Diplomat")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/head/tau/watercaste, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/under/tau/watercaste, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/device/tau/drone/controller, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/tau/drone/gun, slot_r_hand)
				real_name = "Por [rndname]"
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "por"
				W.assignment = "Tau Diplomat"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
		regenerate_icons()
/*
Drones!
*/

/mob/living/simple_animal/tau
	factions = list("tau")
	stop_automated_movement_when_pulled = 0
	environment_smash = 1 //Set to 1 to break closets,tables,racks, etc; 2 for walls; 3 for rwalls
	var/stance = HOSTILE_STANCE_IDLE	//Used to determine behavior
	var/atom/target
	var/atom/master
	var/attack_same = 0 //Set us to 1 to allow us to attack our own faction, or 2, to only ever attack our own faction
	var/ranged = 0
	var/rapid = 0
	var/projectiletype
	var/projectilesound
	var/casingtype
	var/move_to_delay = 2 //delay for the automated movement.
	var/list/friends = list()
	var/vision_range = 9 //How big of an area to search for targets in, a vision of 9 attempts to find targets as soon as they walk into screen view

	var/aggro_vision_range = 10 //If a mob is aggro, we search in this radius. Defaults to 9 to keep in line with original simple mob aggro radius
	var/idle_vision_range = 9 //If a mob is just idling around, it's vision range is limited to this. Defaults to 9 to keep in line with original simple mob aggro radius
	var/ranged_message = "fires" //Fluff text for ranged mobs
	var/ranged_cooldown = 0 //What the starting cooldown is on ranged attacks
	var/ranged_cooldown_cap = 3 //What ranged attacks, after being used are set to, to go back on cooldown, defaults to 3 life() ticks
	var/retreat_distance = null //If our mob runs from players when they're too close, set in tile distance. By default, mobs do not retreat.
	var/minimum_distance = 1 //Minimum approach distance, so ranged mobs chase targets down, but still keep their distance set in tiles to the target, set higher to make mobs keep distance
	var/search_objects = 0 //If we want to consider objects when searching around, set this to 1. If you want to search for objects while also ignoring mobs until hurt, set it to 2. To completely ignore mobs, even when attacked, set it to 3
	var/list/wanted_objects = list() //A list of objects that will be checked against to attack, should we have search_objects enabled
	var/stat_attack = 0 //Mobs with stat_attack to 1 will attempt to attack things that are unconscious, Mobs with stat_attack set to 2 will attempt to attack the dead.
	var/stat_exclusive = 0 //Mobs with this set to 1 will exclusively attack things defined by stat_attack, stat_attack 2 means they will only attack corpses
	var/list/attack_faction = list() //Put a faction string here to have a mob only ever attack a specific faction

/mob/living/simple_animal/tau/CanPass(atom/movable/mover, mob/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover) && mover.checkpass(PASSTAU))
		return 1
	else
		if(istype(mover, /obj/item/projectile) && density)
			return prob(20)
		else
			return !density

/mob/living/simple_animal/tau/Life()

	. = ..()
	if(!.)
		walk(src, 0)
		return 0
	if(client)
		return 0
	if(!stat)
		switch(stance)
			if(HOSTILE_STANCE_IDLE)
				FindMaster()
				target = null
				return

			if(HOSTILE_STANCE_ATTACK)
				var/new_target = FindTarget()
				GiveTarget(new_target)
				MoveToTarget()

			if(HOSTILE_STANCE_ATTACKING)
				AttackTarget()

		if(ranged)
			ranged_cooldown--

//////////////HOSTILE MOB TARGETTING AND AGGRESSION////////////


/mob/living/simple_animal/tau/proc/ListTargets()//Step 1, find out what we can see
	var/list/L = list()
	if(!search_objects)
		var/list/Mobs = hearers(vision_range, src) - src //Remove self, so we don't suicide
		L += Mobs
		for(var/obj/mecha/M in mechas_list)
			if(get_dist(M, src) <= vision_range && can_see(src, M, vision_range))
				L += M

	else
		var/list/Objects = oview(vision_range, src)
		L += Objects
	return L

/mob/living/simple_animal/tau/proc/ListMasters()//Step 1, find out what we can see
	var/list/L = list()
	if(!search_objects)
		var/list/Mobs = hearers(vision_range, src) - src //Remove self, so we don't suicide
		L += Mobs
		for(var/obj/mecha/M in mechas_list)
			if(get_dist(M, src) <= vision_range && can_see(src, M, vision_range))
				L += M

	else
		var/list/Objects = oview(vision_range, src)
		L += Objects
	return L

/mob/living/simple_animal/tau/proc/FindTarget()//Step 2, filter down possible targets to things we actually care about
	var/list/Targets = list()
	var/Target
	for(var/atom/A in ListTargets())
		if(Found(A))//Just in case people want to override targetting
			var/list/FoundTarget = list()
			FoundTarget += A
			Targets = FoundTarget
			break
		if(CanAttack(A))//Can we attack it?
			Targets += A
			continue
	Target = PickTarget(Targets)
	return Target //We now have a target

/mob/living/simple_animal/tau/proc/FindMaster(mob/living/H as mob)//Step 2, filter down possible targets to things we actually care about
	var/obj/item/device/tau/drone/controller = locate(/obj/item/device/tau/drone/controller) in H
	if(controller)
		Goto(H)

/mob/living/simple_animal/tau/proc/Found(var/atom/A)//This is here as a potential override to pick a specific target if available
	return

/mob/living/simple_animal/tau/proc/PickTarget(var/list/Targets)//Step 3, pick amongst the possible, attackable targets
	if(target != null)//If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/atom/A in Targets)
			var/target_dist = get_dist(src, target)
			var/possible_target_distance = get_dist(src, A)
			if(target_dist < possible_target_distance)
				Targets -= A
	if(!Targets.len)//We didnt find nothin!
		return
	var/chosen_target = pick(Targets)//Pick the remaining targets (if any) at random
	return chosen_target

/mob/living/simple_animal/tau/proc/PickMaster(var/list/Masters)//Copy pasted all so the drone can follow you.
	if(master != null)//If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/atom/A in Masters)
			var/master_dist = get_dist(src, master)
			var/possible_master_distance = get_dist(src, A)
			if(master_dist < possible_master_distance)
				Masters -= A
	if(!Masters.len)//We didnt find nothin! ...or did we?
		return
	var/chosen_master = pick(Masters)//Pick the remaining targets (if any) at random
	return chosen_master

/mob/living/simple_animal/tau/CanAttack(var/atom/L)//Can we actually attack a possible target?
	//made by wb
	if(ismob(L))
		var/mob/M = L

		//Stat checks
		if(M.stat > stat_attack)
			return 0
		if(M.stat != stat_attack && stat_exclusive == 1)
			return 0

		//Friend check
		if(M in src.friends) return 0

		//Faction checks
		if(src.attack_faction in M.factions)  return 1
		if(length(M.factions & src.factions))
			if(src.attack_same)  return 1
			return 0
		if(src.attack_same != 2) return 1
		return 0

	else

		var/obj/O = L

		if(istype(O,/obj/mecha))
			var/obj/mecha/M = O
			if(!M.occupant)				return 0
			if(!src.CanAttack(M.occupant))  return 0
			return 1

		if(O.type in src.wanted_objects)
			return 1

	return 0
	//old commented out code
	/*if(see_invisible < the_target.invisibility)//Target's invisible to us, forget it
		return 0
	if(isliving(the_target) && search_objects < 2)
		var/mob/living/L = the_target
		var/factsmatch = length(L.factions & src.factions)
		if(L.stat > stat_attack || L.stat != stat_attack && stat_exclusive == 1)
			return 0
		if(factsmatch && !attack_same || !factsmatch && attack_same == 2 || !factsmatch && attack_faction)
			return 0
		if(L in friends)
			return 0
		return 1
	if(isobj(the_target))
		if(the_target.type in wanted_objects)
			return 1
		if(istype(the_target, /obj/mecha) && search_objects < 2)
			var/obj/mecha/M = the_target
			if(M.occupant)//Just so we don't attack empty mechs
				if(CanAttack(M.occupant))
					return 1
	return 0*/

/mob/living/simple_animal/tau/proc/GiveTarget(var/new_target)//Step 4, give us our selected target
	target = new_target
	if(target != null)
		Aggro()
		stance = HOSTILE_STANCE_ATTACK
	return

/mob/living/simple_animal/tau/proc/MoveToTarget()//Step 5, handle movement between us and our target
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return
	if(target in ListTargets())
		var/target_distance = get_dist(src,target)
		if(ranged)//We ranged? Shoot at em
			if(target_distance >= 2 && ranged_cooldown <= 0)//But make sure they're a tile away at least, and our range attack is off cooldown
				OpenFire(target)
		if(retreat_distance != null)//If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance)//If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,move_to_delay)
			else
				Goto(target,move_to_delay,minimum_distance)//Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,move_to_delay,minimum_distance)
		if(isturf(loc) && target.Adjacent(src))	//If they're next to us, attack
			AttackingTarget()
		return
	if(environment_smash)
		if(target.loc != null && get_dist(src, target.loc) <= vision_range)//We can't see our target, but he's in our vision range still
			if(environment_smash >= 2)//If we're capable of smashing through walls, forget about vision completely after finding our target
				Goto(target,move_to_delay,minimum_distance)
				FindHidden()
				return
			else
				if(FindHidden())
					return
	LostTarget()

/mob/living/simple_animal/tau/proc/Goto(var/target, var/delay, var/minimum_distance)
	walk_to(src, target, minimum_distance, delay)

/mob/living/simple_animal/tau/adjustBruteLoss(var/damage)
	..(damage)
	if(!stat && search_objects < 3)//Not unconscious, and we don't ignore mobs
		if(search_objects)//Turn off item searching and ignore whatever item we were looking at, we're more concerned with fight or flight
			search_objects = 0
			target = null
		if(stance == HOSTILE_STANCE_IDLE)//If we took damage while idle, immediately attempt to find the source of it so we find a living target
			Aggro()
			var/new_target = FindTarget()
			GiveTarget(new_target)
		if(stance == HOSTILE_STANCE_ATTACK)//No more pulling a mob forever and having a second player attack it, it can switch targets now if it finds a more suitable one
			if(target != null && prob(40))
				var/new_target = FindTarget()
				GiveTarget(new_target)

/mob/living/simple_animal/tau/proc/AttackTarget(var/atom/L)

	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	if(!(target in ListTargets()))
		LostTarget()
		return 0
	if(isturf(loc) && target.Adjacent(src))
		AttackingTarget()
		return 1

/mob/living/simple_animal/tau/proc/AttackingTarget()
	target.attack_animal(src)

/mob/living/simple_animal/tau/proc/Aggro()
	vision_range = aggro_vision_range

/mob/living/simple_animal/tau/proc/LoseAggro()
	stop_automated_movement = 0
	vision_range = idle_vision_range

/mob/living/simple_animal/tau/proc/LoseTarget()
	stance = HOSTILE_STANCE_IDLE
	target = null
	walk(src, 0)
	LoseAggro()

/mob/living/simple_animal/tau/proc/LostTarget()
	stance = HOSTILE_STANCE_IDLE
	walk(src, 0)
	LoseAggro()

//////////////END HOSTILE MOB TARGETTING AND AGGRESSION////////////

/mob/living/simple_animal/tau/Die()
	LoseAggro()
	..()
	walk(src, 0)

/mob/living/simple_animal/tau/proc/OpenFire(var/the_target)

	var/target = the_target
	visible_message("\red <b>[src]</b> [ranged_message] at [target]!", 1)

	var/tturf = get_turf(target)
	if(rapid)
		spawn(1)
			Shoot(tturf, src.loc, src)
			if(casingtype)
				new casingtype(get_turf(src))
		spawn(4)
			Shoot(tturf, src.loc, src)
			if(casingtype)
				new casingtype(get_turf(src))
		spawn(6)
			Shoot(tturf, src.loc, src)
			if(casingtype)
				new casingtype(get_turf(src))
	else
		Shoot(tturf, src.loc, src)
		if(casingtype)
			new casingtype
	ranged_cooldown = ranged_cooldown_cap
	return

/mob/living/simple_animal/tau/proc/Shoot(var/target, var/start, var/user, var/bullet = 0)
	if(target == start)
		return

	var/obj/item/projectile/A = new projectiletype(user:loc)
	playsound(user, projectilesound, 100, 1)
	if(!A)	return

	if (!istype(target, /turf))
		qdel(A)
		return
	A.current = target
	A.yo = target:y - start:y
	A.xo = target:x - start:x
	spawn( 0 )
		A.process()
	return

/mob/living/simple_animal/tau/proc/DestroySurroundings()
	if(environment_smash)
		EscapeConfinement()
		for(var/dir in cardinal)
			var/turf/T = get_step(src, dir)
			if(istype(T, /turf/simulated/wall) || istype(T, /turf/simulated/mineral))
				if(T.Adjacent(src))
					T.attack_animal(src)
			for(var/atom/A in T)
				if(!A.Adjacent(src))
					continue
				if(istype(A, /obj/structure/window) || istype(A, /obj/structure/closet) || istype(A, /obj/structure/table) || istype(A, /obj/structure/grille) || istype(A, /obj/structure/rack))
					A.attack_animal(src)
	return

/mob/living/simple_animal/tau/proc/EscapeConfinement()
	if(buckled)
		buckled.attack_animal(src)
	if(!isturf(src.loc) && src.loc != null)//Did someone put us in something?
		var/atom/A = src.loc
		A.attack_animal(src)//Bang on it till we get out
	return

/mob/living/simple_animal/tau/proc/FindHidden()
	if(istype(target.loc, /obj/structure/closet) || istype(target.loc, /obj/machinery/disposal) || istype(target.loc, /obj/machinery/sleeper))
		var/atom/A = target.loc
		Goto(A,move_to_delay,minimum_distance)
		if(A.Adjacent(src))
			A.attack_animal(src)
		return 1

/mob/living/simple_animal/tau/proc/Follow()
	if(istype(master.loc, /obj/structure/closet) || istype(target.loc, /obj/machinery/disposal) || istype(target.loc, /obj/machinery/sleeper))
		var/atom/A = master.loc
		Goto(A,move_to_delay,minimum_distance)
		if(A.Adjacent(src))
			A.attack_animal(src)
		return 1

/mob/living/simple_animal/tau/drone
	name = "Tau Drone"
	desc = "Tau Drone"
	icon_state = "gundrone"
	icon_living = "gundrone"
	speak_chance = 0
	turns_per_move = 3
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	stop_automated_movement_when_pulled = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "kamakizes"
	a_intent = "harm"
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	factions = list("tau")
	status_flags = CANPUSH

/mob/living/simple_animal/tau/drone/Die()
	..()
	new /obj/effect/gibspawner/robot(src.loc)
	new /obj/effect/effect/sparks(src.loc)
	qdel(src)

/mob/living/simple_animal/tau/drone/gun
	name = "Tau Gun Drone"
	desc = "A Tau Gun Drone"
	icon_state = "gundrone"
	icon_living = "gundrone"
	ranged = 1
	rapid = 1
	retreat_distance = 5
	minimum_distance = 1
	icon_state = "gundrone"
	icon_living = "gundrone"
	projectilesound = 'sound/weapons/pulse.ogg'
	projectiletype = /obj/item/projectile/beam/pulse2/drone