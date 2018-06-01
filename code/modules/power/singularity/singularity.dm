//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

var/global/list/uneatable = list(
	/turf/snow,
	/obj/effect/overlay
	)

/obj/machinery/singularity
	name = "gravitational singularity"
	desc = "A gravitational singularity."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"
	anchored = 1
	density = 1
	layer = 6
	luminosity = 6
	unacidable = 1 //Don't comment this out.
	use_power = 0
	var/current_size = 1
	var/allowed_size = 1
	var/contained = 1 //Are we going to move around?
	var/energy = 100 //How strong are we?
	var/dissipate = 1 //Do we lose energy over time?
	var/dissipate_delay = 10
	var/dissipate_track = 0
	var/dissipate_strength = 1 //How much energy do we lose?
	var/move_self = 1 //Do we move on our own?
	var/grav_pull = 4 //How many tiles out do we pull?
	var/consume_range = 0 //How many tiles out do we eat
	var/event_chance = 15 //Prob for event each tick
	var/target = null //its target. moves towards the target if it has one
	var/last_failed_movement = 0//Will not move in the same dir if it couldnt before, will help with the getting stuck on fields thing
	var/teleport_del = 0
	var/last_warning

/obj/machinery/singularity/New(loc, var/starting_energy = 50, var/temp = 0)

	src.energy = starting_energy
	..()
	for(var/obj/machinery/singularity_beacon/singubeacon in world)
		if(singubeacon.active)
			target = singubeacon
			break
	return


/obj/machinery/singularity/attack_hand(mob/user as mob)
	consume(user)
	return 1


/obj/machinery/singularity/blob_act(severity)
	return

/obj/machinery/singularity/ex_act(severity)
	switch(severity)
		if(1.0)
			if(current_size <= 3)
				investigate_log("has been destroyed by a heavy explosion.","singulo")
				qdel(src)
				return
			else
				energy -= round(((energy+1)/2),1)
		if(2.0)
			energy -= round(((energy+1)/3),1)
		if(3.0)
			energy -= round(((energy+1)/4),1)
	return


/obj/machinery/singularity/bullet_act(obj/item/projectile/P)
	return 0 //Will there be an impact? Who knows.  Will we see it? No.


/obj/machinery/singularity/Bump(atom/A)
	consume(A)
	return


/obj/machinery/singularity/Bumped(atom/A)
	consume(A)
	return


/obj/machinery/singularity/process()
	eat()
	dissipate()
	check_energy()

	if(current_size >= 3)
		move()
		pulse()
		if(prob(event_chance))//Chance for it to run a special event TODO:Come up with one or two more that fit
			event()
	return


/obj/machinery/singularity/attack_ai() //to prevent ais from gibbing themselves when they click on one.
	return



/obj/machinery/singularity/proc/dissipate()
	if(!dissipate)
		return
	if(dissipate_track >= dissipate_delay)
		src.energy -= dissipate_strength
		dissipate_track = 0
	else
		dissipate_track++


/obj/machinery/singularity/proc/expand(var/force_size = 0)
	return 0


/obj/machinery/singularity/proc/check_energy()
	if(energy <= 0)
		investigate_log("collapsed.","singulo")
		qdel(src)
		return 0
	switch(energy)//Some of these numbers might need to be changed up later -Mport
		if(1 to 199)
			allowed_size = 1
		if(200 to 499)
			allowed_size = 3
		if(500 to 999)
			allowed_size = 5
		if(1000 to 1999)
			allowed_size = 7
		if(2000 to INFINITY)
			allowed_size = 9
	if(current_size != allowed_size)
		expand()
	return 1


/obj/machinery/singularity/proc/eat()
	set background = BACKGROUND_ENABLED
//	if(defer_powernet_rebuild != 2)
//		defer_powernet_rebuild = 1
	// Let's just make this one loop.
	for(var/atom/X in orange(grav_pull,src))
		var/dist = get_dist(X, src)
		// Movable atoms only
		if(dist > consume_range && istype(X, /atom/movable))
			if(is_type_in_list(X, uneatable))	continue
			if(((X) &&(!X:anchored) && (!istype(X,/mob/living/carbon/human)))|| (src.current_size >= 9))
				step_towards(X,src)

			else if(istype(X,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = X

				if(istype(H.shoes,/obj/item/clothing/shoes/magboots))
					var/obj/item/clothing/shoes/magboots/M = H.shoes
					if(!M.magpulse)
						step_towards(H,src)
				else
					step_towards(H,src)

				if(current_size >= 5)
					var/list/handlist = list(H.l_hand, H.r_hand)
					for(var/obj/item/hand in handlist)
						if(prob(current_size * 5) && hand.w_class <= 2 && H.unEquip(hand))
							step_towards(hand, src)
							H << "<span class='warning'>\The [src] pulls \the [hand] from your grip!</span>"

				H.apply_effect(current_size * 3, IRRADIATE)
		// Turf and movable atoms
		else if(dist <= consume_range && (isturf(X) || istype(X, /atom/movable)))
			consume(X)

//	if(defer_powernet_rebuild != 2)
//		defer_powernet_rebuild = 0
	return


/obj/machinery/singularity/proc/consume(var/atom/A)
	var/gain = 0
	if(is_type_in_list(A, uneatable))
		return 0
	if (istype(A,/mob/living))//Mobs get gibbed
		var/mob/living/M = A
		gain = 20
		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(H.mind)

				if((H.mind.assigned_role == "Station Engineer") || (H.mind.assigned_role == "Chief Engineer") )
					gain = 100

				if(H.mind.assigned_role == "Clown")
					gain = rand(-300, 300) // HONK

		investigate_log(" has consumed [key_name(M)].","singulo") //Oh that's where the clown ended up!
		M.gib()
		sleep(1)
	else if(istype(A,/obj/))

		if (istype(A,/obj/item/weapon/storage/backpack/holding))
			var/dist = max((current_size - 2),1)
			explosion(src.loc,(dist),(dist*2),(dist*4))
			return

		if(istype(A, /obj/machinery/singularity))//Welp now you did it
			var/obj/machinery/singularity/S = A
			src.energy += (S.energy/2)//Absorb most of it
			qdel(S)
			var/dist = max((current_size - 2),1)
			explosion(src.loc,(dist),(dist*2),(dist*4))
			return//Quits here, the obj should be gone, hell we might be

		if((teleport_del) && (!istype(A, /obj/machinery)))//Going to see if it does not lag less to tele items over to Z 2
			var/obj/O = A
			O.x = 2
			O.y = 2
			O.z = 2
		else
			A.ex_act(1.0)
			if(A && isnull(A.gc_destroyed))
				qdel(A)
		gain = 2
	else if(isturf(A))
		var/turf/T = A
		if(T.intact)
			for(var/obj/O in T.contents)
				if(O.level != 1)
					continue
				if(O.invisibility == 101)
					src.consume(O)
		T.ChangeTurf(/turf/snow)
		gain = 2
	src.energy += gain
	return


/obj/machinery/singularity/proc/move(var/force_move = 0)
	if(!move_self)
		return 0

	var/movement_dir = pick(alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move

	if(target && prob(60))
		movement_dir = get_dir(src,target) //moves to a singulo beacon, if there is one

	if(current_size >= 9)//The superlarge one does not care about things in its way
		spawn(0)
			step(src, movement_dir)
		spawn(1)
			step(src, movement_dir)
		return 1
	else if(check_turfs_in(movement_dir))
		last_failed_movement = 0//Reset this because we moved
		spawn(0)
			step(src, movement_dir)
		return 1
	else
		last_failed_movement = movement_dir
	return 0


/obj/machinery/singularity/proc/check_turfs_in(var/direction = 0, var/step = 0)
	if(!direction)
		return 0
	var/steps = 0
	if(!step)
		switch(current_size)
			if(1)
				steps = 1
			if(3)
				steps = 3//Yes this is right
			if(5)
				steps = 3
			if(7)
				steps = 4
			if(9)
				steps = 5
	else
		steps = step
	var/list/turfs = list()
	var/turf/T = src.loc
	for(var/i = 1 to steps)
		T = get_step(T,direction)
	if(!isturf(T))
		return 0
	turfs.Add(T)
	var/dir2 = 0
	var/dir3 = 0
	switch(direction)
		if(NORTH||SOUTH)
			dir2 = 4
			dir3 = 8
		if(EAST||WEST)
			dir2 = 1
			dir3 = 2
	var/turf/T2 = T
	for(var/j = 1 to steps)
		T2 = get_step(T2,dir2)
		if(!isturf(T2))
			return 0
		turfs.Add(T2)
	for(var/k = 1 to steps)
		T = get_step(T,dir3)
		if(!isturf(T))
			return 0
		turfs.Add(T)
	for(var/turf/T3 in turfs)
		if(isnull(T3))
			continue
		if(!can_move(T3))
			return 0
	return 1


/obj/machinery/singularity/proc/can_move(var/turf/T)
	if(!T)
		return 0
	if((locate(/obj/machinery/field/containment) in T)||(locate(/obj/machinery/shieldwall) in T))
		return 0
	else if(locate(/obj/machinery/field/generator) in T)
		var/obj/machinery/field/generator/G = locate(/obj/machinery/field/generator) in T
		if(G && G.active)
			return 0
	else if(locate(/obj/machinery/shieldwallgen) in T)
		var/obj/machinery/shieldwallgen/S = locate(/obj/machinery/shieldwallgen) in T
		if(S && S.active)
			return 0
	return 1


/obj/machinery/singularity/proc/event()
	var/numb = pick(1,2,3,4,5,6)
	switch(numb)
		if(1)//EMP
			emp_area()
		if(2,3)//tox damage all carbon mobs in area
			toxmob()
		if(4)//Stun mobs who lack optic scanners
			mezzer()
		else
			return 0
	return 1


/obj/machinery/singularity/proc/toxmob()
	var/toxrange = 10
	var/toxdamage = 4
	var/radiation = 15
	var/radiationmin = 3
	if (src.energy>200)
		toxdamage = round(((src.energy-150)/50)*4,1)
		radiation = round(((src.energy-150)/50)*5,1)
		radiationmin = round((radiation/5),1)//
	for(var/mob/living/M in view(toxrange, src.loc))
		M.apply_effect(rand(radiationmin,radiation), IRRADIATE)
		toxdamage = (toxdamage - (toxdamage*M.getarmor(null, "rad")))
		M.apply_effect(toxdamage, TOX)
	return


/obj/machinery/singularity/proc/mezzer()
	for(var/mob/living/carbon/M in oviewers(8, src))
		if(istype(M, /mob/living/carbon/brain)) //Ignore brains
			continue

		if(M.stat == CONSCIOUS)
			if (istype(M,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				if(istype(H.glasses,/obj/item/clothing/glasses/meson))
					H << "\blue You look directly into The [src.name], good thing you had your protective eyewear on!"
					return
		M << "\red You look directly into The [src.name] and feel weak."
		M.apply_effect(3, STUN)
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red <B>[] stares blankly at The []!</B>", M, src), 1)
	return


/obj/machinery/singularity/proc/emp_area()
	empulse(src, 8, 10)
	return


/obj/machinery/singularity/proc/pulse()

	for(var/obj/machinery/power/rad_collector/R in rad_collectors)
		if(get_dist(R, src) <= 15) // Better than using orange() every process
			R.receive_pulse(energy)
	return

/*
WarpStorm
*/

/obj/machinery/singularity/warpstorm //Moving warpstorm to a child object of the singularity so it can be made to function differently. --NEO
	name = "The Warp"
	icon_state = "blank" //Until the spawn graphic triggers, it shouldn't show a full warp rift.
	desc = "Your mind begins to bubble and ooze as it tries to comprehend what it sees."
	icon = 'icons/obj/narsie.dmi'
	pixel_x = -89
	pixel_y = -85
	current_size = 1 //It moves/eats like a max-size singulo, aside from range. --NEO
	contained = 0 //Are we going to move around?
	dissipate = 0 //Do we lose energy over time?
	move_self = 1 //Do we move on our own?
	grav_pull = 2 //How many tiles out do we pull?
	consume_range = 2 //How many tiles out do we eat
	var/new_form = /mob/living/carbon/human

/obj/machinery/singularity/warpstorm/large
	name = "The Warp"
	icon = 'icons/obj/narsie.dmi'
	// Pixel stuff centers warpstorm.
	current_size = 2
	move_self = 1 //Do we move on our own?
	grav_pull = 2
	consume_range = 2 //How many tiles out do we eat

/obj/machinery/singularity/warpstorm/large/New()
	..()
	world << "<font size='8' color='red'><b>A Warp Storm Has Appeared!</b></font>"
	world << pick(sound('sound/hallucinations/im_here1.ogg'), sound('sound/hallucinations/im_here2.ogg'))
	if(emergency_shuttle)
		emergency_shuttle.incall(0.3) // Cannot recall
	icon_state = "ws1"
	sleep(40)
	icon_state = "ws2"

/obj/machinery/singularity/warpstorm/process()
	eat()
	if(!target || prob(5))
		pickcultist()
	move()
	if(prob(25))
		mezzer()
	if(prob(2))
		new /mob/living/simple_animal/hostile/retaliate/daemon/poltergeist(get_turf(src))
	if(prob(2))
		new /mob/living/simple_animal/hostile/retaliate/daemon/poltergeist/nurgle(get_turf(src))
	if(prob(2))
		new /mob/living/simple_animal/hostile/retaliate/daemon/lesser/predator(get_turf(src))
	if(prob(2))
		new /mob/living/simple_animal/hostile/retaliate/daemon/lesser(get_turf(src))
	if(prob(1))
		new /mob/living/simple_animal/hostile/retaliate/daemon/hulk(get_turf(src))

/obj/machinery/singularity/warpstorm/Bump(atom/A)//you dare stand before a god?!
	godsmack(A)
	return

/obj/machinery/singularity/warpstorm/Bumped(atom/A)
	godsmack(A)
	return

/obj/machinery/singularity/warpstorm/proc/godsmack(var/atom/A)
	if(istype(A,/obj/))
		var/obj/O = A
		O.ex_act(1.0)
		if(O) qdel(O)

	else if(isturf(A))
		var/turf/T = A
		T.ChangeTurf(/turf/simulated/floor/engine/cult)


/obj/machinery/singularity/warpstorm/mezzer()
	for(var/mob/living/carbon/M in oviewers(8, src))
		if(M.stat == CONSCIOUS)
			if(!iscultist(M))
				M << "\red You feel your sanity crumble away in an instant as you gaze upon [src.name]..."
				M.apply_effect(3, STUN)

///mob/living/simple_animal/chaosspawn/warpspawn
/obj/machinery/singularity/warpstorm/consume(var/atom/A)
	if(is_type_in_list(A, uneatable))
		return 0

	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/C = A
		var/selection = pick(1, 2, 3)
		switch(selection)
			if(1)
				C.visible_message("\red <b>[C] is torn apart in the warp!<b>")
				C.spawn_dust()
				C.change_mob_type(/mob/living/simple_animal/chaosspawn/warpspawn, src, "Warp Exhile", 1)
			if(2)
				C.visible_message("\red <b>The warp drags [C] in!<b>")
				enter_warp(C)
			if(3)
				C.visible_message("\red <b>The warp lashes out at [C]!<b>")
				C.Paralyse(1)
				step_away(C,src,15)
				step_away(C,src,15)
				step_away(C,src,15)
				spawn(10)
					C.make_chaos_spawn()
	if(isturf(A))
		var/turf/T = A
		if(istype(T, /turf/simulated/floor) && !istype(T, /turf/simulated/floor/engine/cult))
			if(prob(20)) T.ChangeTurf(/turf/simulated/floor/engine/cult)

		else if(istype(T,/turf/simulated/wall) && !istype(T, /turf/simulated/wall/cult))
			if(prob(20)) T.ChangeTurf(/turf/simulated/wall/cult)
	return

/obj/machinery/singularity/warpstorm/ex_act() //No throwing bombs at it either. --NEO
	return

/obj/machinery/singularity/warpstorm/proc/pickcultist() //warpstorm rewards his cultists with being devoured first, then picks a ghost to follow. --NEO
	var/list/cultists = list()
	for(var/datum/mind/cult_nh_mind in ticker.mode.cult)
		if(!cult_nh_mind.current)
			continue
		if(cult_nh_mind.current.stat)
			continue
		var/turf/pos = get_turf(cult_nh_mind.current)
		if(pos.z != src.z)
			continue
		cultists += cult_nh_mind.current
	if(cultists.len)
		acquire(pick(cultists))
		return
		//If there was living cultists, it picks one to follow.
	for(var/mob/living/carbon/human/food in living_mob_list)
		if(food.stat)
			continue
		var/turf/pos = get_turf(food)
		if(pos.z != src.z)
			continue
		cultists += food
	if(cultists.len)
		acquire(pick(cultists))
		return
		//no living cultists, pick a living human instead.
	for(var/mob/dead/observer/ghost in player_list)
		if(!ghost.client)
			continue
		var/turf/pos = get_turf(ghost)
		if(pos.z != src.z)
			continue
		cultists += ghost
	if(cultists.len)
		acquire(pick(cultists))
		return
		//no living humans, follow a ghost instead.

/obj/machinery/singularity/warpstorm/proc/acquire(var/mob/food)
	target << "\blue <b>THE WARP HAS LOST INTEREST IN YOU</b>"
	target = food
	if(ishuman(target))
		target << "\red <b>THE WARP HUNGERS FOR YOUR SOUL</b>"
	else
		target << "\red <b>NURGLE HAS CHOSEN YOU TO LEAD HIM TO HIS NEXT MEAL</b>"

//Wizard warpstorm

/obj/machinery/singularity/warpstorm/wizard
	grav_pull = 0

/obj/machinery/singularity/warpstorm/wizard/eat()
	set background = BACKGROUND_ENABLED
//	if(defer_powernet_rebuild != 2)
//		defer_powernet_rebuild = 1
	for(var/atom/X in orange(consume_range,src))
		if(isturf(X) || istype(X, /atom/movable))
			consume(X)
//	if(defer_powernet_rebuild != 2)
//		defer_powernet_rebuild = 0
	return
