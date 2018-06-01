//This allows for certain sectors of ruins to be random every time.
//Drake

proc/get_two_steps(location,direction)
	return get_step(get_step(location,direction),direction)

/*
/obj/effect/landmark/necron_ruins/New()
	var/turf/location = get_turf(src)
	var/list/unvisited = range(5,location)
	invisibility = 101
	if(!ticker)
		sleep(1200)
		new /obj/effect/landmark/necron_ruins(location)
		del(src)
	if(ticker)
		for(var/turf/simulated/T in unvisited)
			var/wall = 1
			for(var/mob/M in range(1,T))
				wall = 0
			for(var/obj/M in range(1,T))
				wall = 0
			if(wall)
				T.ChangeTurf(/turf/simulated/wall/necron)
		for(var/stage = 1, stage<=15, stage++)
			unvisited -= location
			location = get_turf(location) //should cut runtimes about areas down. no idea what causes them though
			if(location == null) break
			location.ChangeTurf(/turf/simulated/floor/necron)
			if(prob(3))
				new /obj/effect/landmark/necron_find(location)
			if(prob(15))
				new /obj/machinery/door/poddoor/necron(location)
			if(prob(1))
				new /obj/effect/mine/necron/lockdown(location)
			if(prob(1))
				new /obj/effect/mine/necron/incinerator(location)
			if(prob(1))
				new /obj/effect/mine/necron/gauss(location)
			if(prob(1))
				new /obj/effect/mine/necron/sleepgas(location)
			if(prob(1))
				new /obj/effect/mine/necron(location)
			if(prob(1))
				new /obj/effect/mine/necron/teleport(location)
			if(prob(1))
				new /mob/living/simple_animal/hostile/necron/sleeping(location)
			if(prob(5))
				new /obj/effect/mine/necron/randomize(location)
			var/list/possible = list()
			for(var/direction in list(NORTH,SOUTH,EAST,WEST))
				var/destination = get_two_steps(location,direction)
				if(destination in unvisited)
					possible += destination
			if(length(possible))
				var/newloc = pick(possible)
				var/turf/simulated/midturf = get_step(location,get_dir(location,newloc))
				midturf.ChangeTurf(/turf/simulated/floor/necron)
				unvisited -= midturf
				location = newloc
			else
				location = pick(unvisited)
*/
