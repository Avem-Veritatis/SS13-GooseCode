/mob/living/simple_animal/hostile/genestealer
	name = "genestealer"
	desc = "A wierd bug-alien that doesn't like the emperor."
	icon = 'icons/mob/tyranids.dmi'
	icon_state = "genestealer"
	icon_living = "genestealer"
	icon_dead = "ripper_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = -1
	maxHealth = 65
	health = 65

	harm_intent_damage = 5
	melee_damage_lower = 10 //high damage, high speed, low health.
	melee_damage_upper = 60
	attacktext = "slashes"
	attack_sound = 'sound/weapons/bite.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 1500

/mob/living/simple_animal/hostile/genestealer/Process_Spacemove(var/check_drift = 0)
	return 1

/mob/living/simple_animal/hostile/genestealer/Die()
	..()
	visible_message("[src] collapses back into a soup of biomass!")
	playsound(src, 'sound/voice/hiss6.ogg', 100, 1)

/mob/living/simple_animal/hostile/genestealer/AttackingTarget()
	..()
	var/mob/living/carbon/L = target
	if(istype(L))
		if(prob(10))
			L.Weaken(5)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")
			src.start_pulling(L) //Drags the target away instead of attacking them, because spookyness.
			retreat_distance = 10
			minimum_distance = 10
			spawn(100)
				retreat_distance = null
				minimum_distance = 1

/mob/living/simple_animal/hostile/genestealer/ymgarl
	health = 100 //A bit higher health, since ymgarl are a bit tougher than a regular jeanstealer.
	maxHealth = 100
	var/blood = 0 //How much blood the ymgarl has absorbed. The more it feeds, the more elaborate abilities it will use. This is a good reason to be careful when facing a ymgarl. They are definitely the most deadly first floor foe.

/mob/living/simple_animal/hostile/venator
	name = "venator"
	desc = "A shrouded, twisted, warped countenance. You feel a sharp pain in your head as you watch the flickering, shifting patterns of blasphemous writings surrounding it."
	icon = 'icons/obj/hulk.dmi'
	icon_state = "venator"
	icon_living = "venator"
	icon_dead = "venator_dead"
	gender = NEUTER
	a_intent = "harm"

	response_help = "touches"
	response_disarm = "pushes"

	speed = -1
	maxHealth = 600
	health = 600

	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 25
	attacktext = "claws"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	faction = list("daemon")
	move_to_delay = 0 // Very fast

	animate_movement = NO_STEPS // Do not animate movement, you jump around as you're a scary daemon.

	see_in_dark = 13
	vision_range = 18
	aggro_vision_range = 18
	idle_vision_range = 18

	search_objects = 1 // So that it can see through walls

	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS
	anchored = 1
	status_flags = GODMODE // Cannot push also

	var/cannot_be_seen = 1

	var/charging = 0

/mob/living/simple_animal/hostile/venator/New()
	..()
	see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING

/mob/living/simple_animal/hostile/venator/Move(var/turf/NewLoc)
	if(can_be_seen(NewLoc))
		if(prob(1))
			if(prob(5))
				charging = 1
		if(prob(1) & !charging)
			retreat_distance = 10 //chance it runs away, although given its view range it will almost definitely return to you.
			minimum_distance = 10
			charging = 1
			spawn(100)
				retreat_distance = null
				minimum_distance = 1
				charging = 0
		if(!charging)
			return 0
	return ..()

/mob/living/simple_animal/hostile/venator/Life()
	..()
	if(!client && target) // If we have a target and we're AI controlled
		var/mob/watching = can_be_seen()
		// If they're not our target
		if(watching && watching != target)
			// This one is closer.
			if(get_dist(watching, src) > get_dist(target, src))
				LoseTarget()
				GiveTarget(watching)
	if(prob(5))
		var/turf/T = usr.loc
		var/area/A = T.loc
		if(A)
			var/light_amount = 5
			if(A.lighting_use_dynamic)	light_amount = T.lighting_lumcount
			else						light_amount =  10
			if(light_amount > 2)
				for(var/obj/machinery/light/L in range(11, usr))
					L.on = 0
					if(prob(40))
						L.rigged = 1 //Some lights will break when you try turning the lights back on.
					L.update()
				for(var/obj/item/device/flashlight/F in range(11, usr))
					F.on = 0
					F.update_brightness(usr)
				for(var/obj/item/device/pda/P in range(11,usr))
					P.fon = 0
					P.SetLuminosity(0)
				for(var/mob/living/M in range(11, usr))
					for(var/obj/item/device/flashlight/F in M.contents)
						F.on = 0
						F.update_brightness(M)
					for(var/obj/item/device/pda/P in M.contents)
						P.fon = 0
						M.AddLuminosity(-P.f_lum)

/mob/living/simple_animal/hostile/venator/DestroySurroundings()
	if(can_be_seen() & !charging)
		return
	..()

/mob/living/simple_animal/hostile/venator/face_atom()
	if(can_be_seen() & !charging)
		return
	..()

/mob/living/simple_animal/hostile/venator/proc/can_be_seen(var/turf/destination)
	if(!cannot_be_seen)
		return null
	// Check for darkness
	var/turf/T = get_turf(loc)
	if(T && destination)
		// Don't check it twice if our destination is the tile we are on or we can't even get to our destination
		if(T == destination)
			destination = null
		else if(!T.lighting_lumcount && !destination.lighting_lumcount) // No one can see us in the darkness, right? //Wrong, but whatever. -someperson1.
			return null

	// We aren't in darkness, loop for viewers.
	var/list/check_list = list(src)
	if(destination)
		check_list += destination

	// This loop will, at most, loop twice.
	for(var/atom/check in check_list)
		for(var/mob/living/M in viewers(world.view + 1, check) - src)
			if(M.client && CanAttack(M) && !issilicon(M))
				if(!M.blinded && !(sdisabilities & BLIND))
					return M
	return null

// Cannot talk

/mob/living/simple_animal/hostile/venator/say()
	return 0

// Turn to dust when gibbed

/mob/living/simple_animal/hostile/venator/gib(var/animation = 0)
	dust(animation)


// Stop attacking clientless mobs

/mob/living/simple_animal/hostile/venator/CanAttack(var/atom/the_target)
	if(isliving(the_target))
		var/mob/living/L = the_target
		if(!L.client && !L.ckey)
			return 0
	return ..()

/obj/effect/mine/tyranid
	name = "vent pump"
	icon = 'icons/obj/atmospherics/vent_pump.dmi'
	icon_state = "hout"
	triggerproc = "triggergenestealer"
	density = 0

/obj/effect/mine/tyranid/New()
		..()
		icon_state = "hout"

/obj/effect/mine/tyranid/Bumped(mob/M as mob|obj)
	if(triggered) return
	if(istype(M, /mob/living/carbon/human) || istype(M, /mob/living/carbon/monkey))
		triggered = 1
		call(src,triggerproc)(M)

/obj/effect/mine/tyranid/HasProximity(atom/movable/AM as mob|obj) //Just going near it triggers it.
	Bumped(AM)

/obj/effect/mine/proc/triggergenestealer()
	var/mob/living/jeanstealer = new /mob/living/simple_animal/hostile/genestealer(loc)
	jeanstealer.visible_message("<b>The genestealer scrambles out of the ventilation ducts!</b>") //doesn't delete the false vent.

/obj/effect/shipshifter
	name = "floor"
	icon = null
	icon_state = null
	density = 0
	var/list/false_turfs = list()
	var/list/under = list()
	var/spent = 0

/obj/effect/shipshifter/proc/moveturfs(direction)
	var/blocked = 0
	for(var/obj/effect/fake_floor/T in false_turfs)
		var/turf/destination = get_step(T,direction)
		if(destination.density)
			blocked = 1
		var/check = 1
		for(var/atom/O in range(0,destination))
			if(O in false_turfs)
				check = 0
		if(check)
			for(var/obj/O in range(0,destination))
				if(O.density & O.anchored)
					blocked = 1
				if(O.density & !O.anchored)
					/*
					var/turf/checkturf = get_step(O,direction)
					var/blockage = occupied(checkturf)
					if(!isturf(blockage))
						var/obj/OB = blockage
						if(OB.anchored)
							blocked = 1
						else
							var/turf/checkturf2 = get_step(OB,direction)
							var/blockage2 = occupied(checkturf2)
							if(blockage2)
								blocked = 1
						*/
					step(O,direction)
					if(O.loc == destination)
						blocked = 1
				else
					blocked = 1
				/*
				if(!O.density & !O.anchored)
					step(O,direction)
					if(O.loc == destination)
						under.Add(O)
						O.layer = 1.9
				if(!O.density & O.anchored)
					under.Add(O)
					O.layer = 1.9
				*/
			for(var/mob/living/M in range(0,destination))
				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					shake_camera(M, 10, 1)
					if(prob(50))
						H.Paralyse(1)
	if(blocked)
		return 0
	var/list/moved = list() //this isn't an elegant solution but it is certainly functional
	for(var/obj/effect/fake_floor/T in false_turfs)
		var/turf/destination = get_step(T,direction)
		var/check = 1
		for(var/atom/O in range(0,destination))
			if(O in false_turfs)
				check = 0
		if(check)
			for(var/obj/O in range(0,destination))
				if(!O.density & !O.anchored)
					step(O,direction)
					if(O.loc == destination)
						under.Add(O)
						O.layer = 1.9
				if(!O.density & O.anchored)
					under.Add(O)
					O.layer = 1.9
		for(var/atom/movable/MA in range(0,T))
			if(!(MA in moved) & !(MA in under))
				MA.loc = get_step(MA,direction)
				moved.Add(MA)
	for(var/obj/U in under) //This is our bug. It uncovers all the ones it found needed covering. Maybe because of background delays...?
		var/covered = 0
		for(var/atom/A in range(0,U))
			if(A in false_turfs)
				covered = 1
		if(!covered)
			U.layer = initial(U.layer)
			under.Remove(U)
	//src.loc = get_step(src,direction)
	return 1

/obj/effect/shipshifter/proc/shipfall()
	set background = BACKGROUND_ENABLED
	spawn()
		var/direction = pick(cardinal)
		var/clear = 1
		var/depth = 0
		while(clear)
			sleep(5)
			clear = moveturfs(direction)
			depth ++
			if(depth > 30) //We don't want it going /to/ far... This makes it only able to go a maximum of thirty.
				clear = 0

/obj/effect/shipshifter/Bumped(atom/A as mob|obj)
	if(!spent)
		if(prob(25))
			spent = 1
			if(ismob(A))
				A << "\red Your motion dislodges the debree!"
				A.visible_message("\red The floor shakes as the debree [A] is standing on starts to move with a metalic screech!")
			shipfall()

/obj/effect/shipshifter/HasProximity(atom/movable/AM as mob|obj) //Just going near it triggers it.
	Bumped(AM)