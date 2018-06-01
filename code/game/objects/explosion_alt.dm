//A recursive, multithreaded explosion proc.
//This isn't by any means perfect but it can blow up a whole department with less lag than a syndicate bomb could under the old code.
//It is also more realistic since some types of wall will hamper the spread of an explosion. I wouldn't do this except for the fact that the performance overhead for that is virtually nothing under this system.
//-Drake

/proc/explode(var/turf/T, var/devestation, var/heavy, var/light, var/flames, var/list/exploded = list(), var/recursions = 0)
	exploded.Add(T)
	var/temprecursions = recursions+1
	var/fake = 0
	for(var/obj/effect/fake_floor/FT in range(0, T))
		recursions += FT.explosion_recursions
		fake = 1
	for(var/obj/machinery/door/poddoor/PD in range(0, T))
		if(PD.density)
			recursions += 25
			fake = 1
	if(!fake)
		if(T)
			recursions += T.explosion_recursions //A turf with a high amount of this will reduce the range or outright block an explosion.
		else
			recursions += max(light, flames)
	if(recursions < max(flames, light)) //Spread the explosion... If we are going to spread, at least.
		spawn(1)
			var/turf/north = get_step(T, NORTH)
			if(!(north in exploded))
				explode(north, devestation, heavy, light, flames, exploded, recursions)
		spawn(1)
			var/turf/south = get_step(T, SOUTH)
			if(!(south in exploded))
				explode(south, devestation, heavy, light, flames, exploded, recursions)
		spawn(1)
			var/turf/east = get_step(T, EAST)
			if(!(east in exploded))
				explode(east, devestation, heavy, light, flames, exploded, recursions)
		spawn(1)
			var/turf/west = get_step(T, WEST)
			if(!(west in exploded))
				explode(west, devestation, heavy, light, flames, exploded, recursions)
	spawn(2)
		if(!T) return //No exploding things that are already exploded, right?
		if(!istype(T, /turf/snow) && recursions < flames && prob(50))
			new /obj/effect/hotspot(T)
		for(var/atom/A in range(T, 0))
			if(isarea(A)) continue //Maybe this will fix the lighting issue...?
			spawn(0)
				if(temprecursions < devestation)
					if(istype(A, /turf/simulated))
						var/turf/simulated/AT = A
						if(AT.explodable)
							qdel(A)
						else
							AT.ex_act(1) //Resists outright deletion.
					else if(iscarbon(A))
						var/mob/living/carbon/C = A
						if(isork(C))
							C.ex_act(2)																	//We have to give the poor orks something //Orks can have resistance, but I am changing this from 3 to 2... I do not feel an ork should take a total of 54 damage from standing in the epicenter of a massive plasma blast, even if they shouldn't gib so quickly.
						else if(C.dodging == 2 || (C.luck > 0 && prob(C.luck / 5)))
							C.throw_at(get_edge_target_turf(C, get_dir(pick(exploded), C)), 100, 10)
						else
							C.gib()
					else if(istype(A, /obj/item))
						qdel(A)
					else
						A.ex_act(1)
				else if(temprecursions < heavy)
					if(iscarbon(A))
						var/mob/living/carbon/C = A
						if(C.dodging == 2 || (C.luck > 0 && prob(C.luck / 5)))
							C.throw_at(get_edge_target_turf(C, get_dir(pick(exploded), C)), 100, 10)
						else
							C.ex_act(2)
					else
						A.ex_act(2)
				else if(temprecursions < light)
					if(iscarbon(A))
						var/mob/living/carbon/C = A
						if(C.dodging == 2 || (C.luck > 0 && prob(C.luck / 5)))
							C.throw_at(get_edge_target_turf(C, get_dir(pick(exploded), C)), 100, 10)
						else
							C.ex_act(3)
					else
						A.ex_act(3)
	return