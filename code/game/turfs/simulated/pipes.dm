/turf/simulated/floor/plating/pipe
	name = "ventilation pipe"
	icon = 'icons/turf/pipefloors.dmi'
	icon_state = "pipefloor"
	floor_tile = null
	intact = 1

/turf/simulated/floor/plating/pipe/New()
	..()
	src.co2 = rand(5, 40) //Stale air down here... There is a chance that some parts of the pipe have slightly unsafe levels of co2. Roughly one in seven, so you aren't in huge danger but probably bring internals.
	src.MakeSlippery(3)

/turf/simulated/floor/plating/pipe/ex_act()
	return

/turf/unsimulated/wall/stonepipe
	icon = 'icons/turf/pipefloors.dmi'
	icon_state = "stonewall"

/obj/effect/overlay/pipetop
	name = "ventilation pipe"
	icon = 'icons/turf/pipefloors.dmi'
	icon_state = "pipetop"
	density = 0
	opacity = 0
	anchored = 1
	layer = 10 //Just to be sure it is on top of EVERYTHING... Would be akward if a projectile went over it or something.

/obj/effect/overlay/stonewallcrack
	name = "wall"
	icon = 'icons/turf/pipefloors.dmi'
	icon_state = "stonewallcrack1"
	density = 0
	opacity = 0
	anchored = 1
	layer = 10

/obj/effect/landmark/wall_prob //Just to keep them guessing!
	name = "Possible Stonewall"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/wall_prob/New()
	var/turf/location = get_turf(src)
	if(prob(10))
		new /turf/unsimulated/wall/stonepipe(location)
	qdel(src)