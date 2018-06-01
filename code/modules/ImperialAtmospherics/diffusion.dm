//This and gas_mix_new.dm will control most all of the new atmos code.

#define ATMOS_MAXRECURSIONS 20 //Just to be safe. //Lowering this to 20... Lets not let it get too out of hand, just in case.

var/global/kill_air = 1 //Alright... For now this can be set to 0. We don't need diffusion right now, and it is doing something unholy.

/atom/movable/proc/air_update_turf(var/command = 0) //This needs to trigger a gas spread.
	if(!istype(loc,/turf) && command)
		return
	for(var/turf/T in locs) // used by double wide doors and other nonexistant multitile structures
		T.air_update_turf(command)

/turf/proc/air_update_turf(var/command = 0)
	if(kill_air) return
	//world << "Air Update Turf Called at ([src.x], [src.y], [src.z])"
	var/o2 //It isn't actually any kind of performance concern as far as I know, but I don't really feel like running code that won't be doing anything at the moment.
	var/co2
	var/n2o
	var/cl
	var/p
	var/list/surrounding = list()
	if(istype(src, /turf/space/real))
		for(var/turf/T in orange(1, src))
			spawn(3)
				if(!istype(T, /turf/space/real) && T.get_pressure()) //Make sure everything gets vacuumed while also trying to make only one vacuum proc be called.
					vacuum(T)
		return
	for(var/turf/T in orange(1, src))
		if(!T.CanAtmosPass(src)) continue
		if(istype(T, /turf/space/real))
			vacuum(src)
			return
		surrounding.Add(T)
	for(var/turf/T in surrounding)
		if(!T.CanAtmosPass(src)) continue //If this one is blocked don't worry about it.
		if(o2) //Just a way to check if this is the first iteration or not.
			if(T.oxygen != o2) //If there are any differences in the surrounding turfs atmospheres, diffuse.
				var/datum/gas_spread/assimilation/A = new /datum/gas_spread/assimilation()
				A.spread(src)
				return
			if(T.co2 != co2)
				var/datum/gas_spread/assimilation/A = new /datum/gas_spread/assimilation()
				A.spread(src)
				return
			if(T.sleepgas != n2o)
				var/datum/gas_spread/assimilation/A = new /datum/gas_spread/assimilation()
				A.spread(src)
				return
			if(T.poison != cl)
				var/datum/gas_spread/assimilation/A = new /datum/gas_spread/assimilation()
				A.spread(src)
				return
			if(T.promethium != p)
				var/datum/gas_spread/assimilation/A = new /datum/gas_spread/assimilation()
				A.spread(src)
				return
		o2 = T.oxygen
		co2 = T.co2
		n2o = T.sleepgas
		cl = T.poison
		p = T.promethium

/atom/movable/proc/move_update_air(var/turf/T)
	if(istype(T,/turf))
		T.air_update_turf(1)
	air_update_turf(1)

/datum/gas_spread
	var/datum/gas_mixture2/air = new()
	var/list/turfs = list()
	var/killed = 1							//changed to 1 to circumvent lag on live build

/datum/gas_spread/New()
	..()
	spawn(2400)
		end()

/datum/gas_spread/proc/get_pressure() //Gets the pressure the spread effect exerts on a single tile.
	return src.air.get_pressure()/src.turfs.len

/datum/gas_spread/proc/spread(var/turf/T, var/recursions = 0) //This is the most performance intensive part of
	if(killed) return
	if(kill_air) return
	recursions++
	if(recursions >= ATMOS_MAXRECURSIONS)
		return
	turfs.Add(T)
	T.gas_spread_effects.Add(src)
	T.update_atmos_overlay()
	var/spread_pressure = src.get_pressure() + T.get_pressure()
	var/turf/north = get_step(T, NORTH)
	if(!(north in turfs) && north.CanAtmosPass(T))
		var/pressure_difference = spread_pressure-north.get_pressure()
		//world << "\red Pressure difference: [pressure_difference], [spread_pressure], [north.get_pressure()]"
		if(pressure_difference >= 10)
			//world << "\red Spreading in [(max(1, 100-pressure_difference))/10] seconds..."
			spawn(max(1, 100-pressure_difference))
				spread(north, recursions)
		//else
			//world << "\red Insufficient pressure difference."
	//else
	//	world << "\red CanAtmosPass returned negative"
	var/turf/south = get_step(T, SOUTH)
	if(!(south in turfs) && south.CanAtmosPass(T))
		var/pressure_difference = spread_pressure-south.get_pressure()
		if(pressure_difference >= 10)
			spawn(max(1, 100-pressure_difference))
				spread(south, recursions)
	var/turf/east = get_step(T, EAST)
	if(!(east in turfs) && east.CanAtmosPass(T))
		var/pressure_difference = spread_pressure-east.get_pressure()
		if(pressure_difference >= 10)
			spawn(max(1, 100-pressure_difference))
				spread(east, recursions)
	var/turf/west = get_step(T, WEST)
	if(!(west in turfs) && west.CanAtmosPass(T))
		var/pressure_difference = spread_pressure-west.get_pressure()
		if(pressure_difference >= 10)
			spawn(max(1, 100-pressure_difference))
				spread(west, recursions)

/datum/gas_spread/proc/end() //Hopefully DM garbage collection knows how to handle a datum that no longer has any references.
	if(killed) return
	spawn(0)
		killed = 1
		for(var/turf/T in turfs)   //I need to find a good way to know when to call this though...
			sleep(1)                 //Staggers all the varedits so that it won't be able to make lag.
			T.oxygen = (src.air.oxygen/turfs.len+T.oxygen)
			T.co2 = (src.air.co2/turfs.len+T.co2)
			T.promethium = (src.air.promethium/turfs.len+T.promethium)
			T.sleepgas = (src.air.sleepgas/turfs.len+T.sleepgas)
			T.poison = (src.air.poison/turfs.len+T.poison)
			T.temperature = ((src.air.temperature*src.get_pressure())+(T.temperature*T.get_pressure()))/(src.get_pressure()+T.get_pressure())
			T.gas_spread_effects.Remove(src)

/datum/gas_spread/pure   //Adds pure air for any turf it covers and negative any impurities. Those negative impurities are also placed positive in the air contents of a linked spread system.
	var/datum/gas_spread/linked

/datum/gas_spread/pure/spread(var/turf/T, var/recursions = 0)
	if(killed) return
	if(kill_air) return
	recursions++
	if(recursions >= ATMOS_MAXRECURSIONS)
		return
	turfs.Add(T)
	var/datum/gas_mixture2/G = T.get_air()
	if(linked)
		linked.air.oxygen += G.oxygen
		linked.air.co2 += G.co2
		linked.air.poison += G.poison
		linked.air.promethium += G.promethium
		linked.air.sleepgas += G.sleepgas
		var/g_p = G.get_pressure()
		var/l_p = linked.air.get_pressure()
		if(g_p+l_p > 10)
			linked.air.temperature = (l_p*linked.air.temperature+G.temperature*g_p)/(l_p+g_p)
		else
			linked.air.temperature = T20C
	else
		message_admins("Error: Purification proc not linked to anything, please report. Line 147 of diffusion.dm.",0,1)
		log_game("Error: Purification proc not linked to anything, please report. Line 147 of diffusion.dm.")
	src.air.oxygen -= G.oxygen
	src.air.co2 -= G.co2
	src.air.poison -= G.poison
	src.air.promethium -= G.promethium
	src.air.sleepgas -= G.sleepgas
	T.oxygen = ONE_ATMOSPHERE
	for(var/datum/gas_spread/GS in T.gas_spread_effects)
		if(!GS.killed) //Stop it from spreading, start it merging things.
			GS.end()
	T.gas_spread_effects.Add(src)
	T.update_atmos_overlay()
	var/turf/north = get_step(T, NORTH)
	if(!(north in turfs) && north.CanAtmosPass(T))
		spawn(10)
			spread(north, recursions)
	var/turf/south = get_step(T, SOUTH)
	if(!(south in turfs) && south.CanAtmosPass(T))
		spawn(10)
			spread(south, recursions)
	var/turf/east = get_step(T, EAST)
	if(!(east in turfs) && east.CanAtmosPass(T))
		spawn(10)
			spread(east, recursions)
	var/turf/west = get_step(T, WEST)
	if(!(west in turfs) && west.CanAtmosPass(T))
		spawn(10)
			spread(west, recursions)

/datum/gas_spread/assimilation/spread(var/turf/T, var/recursions = 0) //Merges all nearby gasses.
	if(killed) return
	if(kill_air) return
	recursions++
	if(recursions >= ATMOS_MAXRECURSIONS)
		return
	turfs.Add(T)
	src.air.oxygen += T.oxygen
	T.oxygen = 0
	src.air.co2 += T.co2
	T.co2 = 0
	src.air.poison += T.poison
	T.poison = 0
	src.air.promethium += T.promethium
	T.promethium = 0
	src.air.sleepgas += T.sleepgas
	T.sleepgas = 0
	T.gas_spread_effects.Add(src)
	T.update_atmos_overlay()
	var/turf/north = get_step(T, NORTH)
	if(!(north in turfs) && north.CanAtmosPass(T))
		spawn(10)
			spread(north, recursions)
	var/turf/south = get_step(T, SOUTH)
	if(!(south in turfs) && south.CanAtmosPass(T))
		spawn(10)
			spread(south, recursions)
	var/turf/east = get_step(T, EAST)
	if(!(east in turfs) && east.CanAtmosPass(T))
		spawn(10)
			spread(east, recursions)
	var/turf/west = get_step(T, WEST)
	if(!(west in turfs) && west.CanAtmosPass(T))
		spawn(10)
			spread(west, recursions)

/proc/vacuum(var/turf/T, var/list/spreaded = list(), var/recursions = 0, var/turf/epicenter = null)
	if(kill_air) return
	if(!epicenter)
		//world << "Vacuum Proc Called at ([T.x], [T.y], [T.z])"
		epicenter = T
	recursions ++
	if(recursions >= ATMOS_MAXRECURSIONS)
		return
	spreaded.Add(T)
	var/turf/north = get_step(T, NORTH)
	if(!(north in spreaded) && north.CanAtmosPass(T))
		spawn(1)
			vacuum(north, spreaded, recursions, epicenter)
	var/turf/south = get_step(T, SOUTH)
	if(!(south in spreaded) && south.CanAtmosPass(T))
		spawn(1)
			vacuum(south, spreaded, recursions, epicenter)
	var/turf/east = get_step(T, EAST)
	if(!(east in spreaded) && east.CanAtmosPass(T))
		spawn(1)
			vacuum(east, spreaded, recursions, epicenter)
	var/turf/west = get_step(T, WEST)
	if(!(west in spreaded) && west.CanAtmosPass(T))
		spawn(1)
			vacuum(west, spreaded, recursions, epicenter)
	spawn(2)
		for(var/mob/living/M in range(0, T))
			spawn(0)
				M.throw_at(epicenter, 50, 1)
		for(var/obj/O in range(0, T))
			if(!O.anchored)
				spawn(0)
					O.throw_at(epicenter, 50, 1)
		for(var/datum/gas_spread/G in T.gas_spread_effects)
			T.gas_spread_effects.Remove(G)
			G.turfs.Remove(T)
			if(!G.killed)
				G.end()
		T.oxygen = 0
		T.co2 = 0
		T.promethium = 0
		T.sleepgas = 0
		T.poison = 0
		T.temperature = 0
		if(prob(15)) T.ex_act(3) //A bit of damage from the violent depressurization.