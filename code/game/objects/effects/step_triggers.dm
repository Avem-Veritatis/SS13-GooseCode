/* Simple object type, calls a proc when "stepped" on by something */

/obj/effect/step_trigger
	var/affect_ghosts = 0
	var/stopper = 1 // stops throwers
	invisibility = 101 // nope cant see this shit
	anchored = 1

/obj/effect/step_trigger/proc/Trigger(var/atom/movable/A)
	return 0

/obj/effect/step_trigger/Crossed(H as mob|obj)
	..()
	if(!H)
		return
	if(istype(H, /mob/dead/observer) && !affect_ghosts)
		return
	Trigger(H)



/* Tosses things in a certain direction */

/obj/effect/step_trigger/thrower
	var/direction = SOUTH // the direction of throw
	var/tiles = 3	// if 0: forever until atom hits a stopper
	var/immobilize = 1 // if nonzero: prevents mobs from moving while they're being flung
	var/speed = 1	// delay of movement
	var/facedir = 0 // if 1: atom faces the direction of movement
	var/nostop = 0 // if 1: will only be stopped by teleporters
	var/list/affecting = list()

	Trigger(var/atom/A)
		if(!A || !istype(A, /atom/movable))
			return
		var/atom/movable/AM = A
		var/curtiles = 0
		var/stopthrow = 0
		for(var/obj/effect/step_trigger/thrower/T in orange(2, src))
			if(AM in T.affecting)
				return

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.canmove = 0

		affecting.Add(AM)
		while(AM && !stopthrow)
			if(tiles)
				if(curtiles >= tiles)
					break
			if(AM.z != src.z)
				break

			curtiles++

			sleep(speed)

			// Calculate if we should stop the process
			if(!nostop)
				for(var/obj/effect/step_trigger/T in get_step(AM, direction))
					if(T.stopper && T != src)
						stopthrow = 1
			else
				for(var/obj/effect/step_trigger/teleporter/T in get_step(AM, direction))
					if(T.stopper)
						stopthrow = 1

			if(AM)
				var/predir = AM.dir
				step(AM, direction)
				if(!facedir)
					AM.dir = predir



		affecting.Remove(AM)

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.canmove = 1

/* Stops things thrown by a thrower, doesn't do anything */

/obj/effect/step_trigger/stopper

/* Instant teleporter */

/obj/effect/step_trigger/teleporter
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0
	var/steps = 0

	Trigger(var/atom/movable/A)
		if(src.name == "shuttle fall")
			if(istype(A, /obj/mecha))
				A.visible_message("\red [A] is burned up as it falls from orbit!!!")
				qdel(A)
				return
		if(teleport_x && teleport_y && teleport_z)

			A.x = teleport_x
			A.y = teleport_y
			A.z = teleport_z
			if(steps)
				step(A, SOUTH)

/* Random teleporter, teleports atoms to locations ranging from teleport_x - teleport_x_offset, etc */

/obj/effect/step_trigger/teleporter/random
	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

	Trigger(var/atom/movable/A)
		if(teleport_x && teleport_y && teleport_z)
			if(teleport_x_offset && teleport_y_offset && teleport_z_offset)

				A.x = rand(teleport_x, teleport_x_offset)
				A.y = rand(teleport_y, teleport_y_offset)
				A.z = rand(teleport_z, teleport_z_offset)

/obj/effect/step_trigger/warpbounds/Trigger(var/atom/movable/A)
	if(istype(A, /mob/living))
		var/mob/living/M = A
		M.visible_message("\red <b>An unseen denizen of the warp smites [M]!</b>")
		M.gib()

/obj/effect/step_trigger/teleporter/random/orbitfall

	Trigger(var/atom/movable/A)
		..()
		if(isliving(A))
			var/mob/living/M = A
			award(M, "Shooting Star")
			M.visible_message("\red [M] falls from the sky!")
			//M.ex_act(1)
			//M.ex_act(1)
			M.fire_stacks += 50
			M.IgniteMob()
			M.take_overall_damage(600, 600)
			var/datum/effect/effect/system/bad_smoke_spread/S = new /datum/effect/effect/system/bad_smoke_spread()
			S.attach(M)
			S.start()
			new /obj/effect/crater(get_turf(M))

/obj/effect/crater
	name = "crater"
	desc = "that was a hard landing..."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "crater"
	anchored = 1
	density = 0
	opacity = 0
	layer = 2.9