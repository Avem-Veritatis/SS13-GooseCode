/turf
	var/list/gas_spread_effects = list()
	var/oxygen = ONE_ATMOSPHERE
	var/co2 = 0
	var/promethium = 0
	var/sleepgas = 0
	var/poison = 0
	var/temperature = T20C
	var/obj/effect/hotspot/active_hotspot = null

	proc/get_pressure() //Note: This does NOT factor in any gas spreads that exist over the other.
		return oxygen+co2+promethium+sleepgas+poison //Which is good because those shouldn't stop mixing and diffusion.

	get_air() //Constructs a gas datum based on the turfs stats.
		//world << "get_air called at ([src.x], [src.y], [src.z])" //This is called a fair amount by living things, but not enough apparently...
		var/datum/gas_mixture2/G = new /datum/gas_mixture2()
		G.oxygen = src.oxygen
		G.co2 = src.co2
		G.promethium = src.promethium
		G.sleepgas = src.sleepgas
		G.poison = src.poison
		G.temperature = src.temperature
		for(var/datum/gas_spread/D in src.gas_spread_effects)
			G = G.merge_gas(D.air)
		return G

	proc/CanAtmosPass(var/turf/T) //Unsimulated turfs don't allow diffusion.
		return 0

	proc/update_atmos_overlay() //TODO: Make this and figure out when it should trigger.
		spawn(2)
			overlays.Cut()
			var/siding_icon_state = return_siding_icon_state()
			if(siding_icon_state)
				overlays += image('icons/turf/floors.dmi',siding_icon_state)
			updateFireOverlays()
			var/datum/gas_mixture2/G = src.get_air()
			if(G.sleepgas >= 50)
				overlays.Add(slmaster)
			else if(G.sleepgas >= 20)
				overlays.Add(slmaster2)
			else if(G.sleepgas >= 5)
				overlays.Add(slmaster3)

	remove_air(var/amount)
		//world << "remove_air called at ([src.x], [src.y], [src.z])"
		var/datum/gas_mixture2/atmos = src.get_air()
		var/pressure = atmos.get_pressure()
		var/oxy = (amount*atmos.oxygen)/pressure
		var/co = (amount*atmos.co2)/pressure
		var/fuel = (amount*atmos.promethium)/pressure
		var/n2o = (amount*atmos.sleepgas)/pressure
		var/tox = (amount*atmos.poison)/pressure
		var/datum/gas_mixture2/G = new /datum/gas_mixture2()
		G.oxygen = oxy
		G.co2 = co
		G.promethium = fuel
		G.sleepgas = n2o
		G.poison = tox
		G.temperature = src.temperature
		return G

/turf/simulated/CanAtmosPass(var/turf/T) //A quick check that air can flow freely between two tiles.
	for(var/atom/movable/A in T.contents)          //Eliminates superconductivity checks.
		if(!A.CanAtmosPass(src))
			return 0
	for(var/atom/movable/A in src.contents)
		if(!A.CanAtmosPass(T))
			return 0
	return !(src.density||T.density)

atom/movable/proc/CanAtmosPass() //Moved over from LINDA_SYSTEM because these defines are important.
	return 1

atom/proc/CanPass(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	return (!density || !height || air_group)

turf/CanPass(atom/movable/mover, turf/target, height=1.5,air_group=0)
	if(!target) return 0

	if(istype(mover)) // turf/Enter(...) will perform more advanced checks
		return !density

	/*
	else // Now, doing more detailed checks for air movement and air group formation //Now, no longer doing that, because we don't use air groups anymore -Drake
		if(target.blocks_air||blocks_air)
			return 0

		for(var/obj/obstacle in src)
			if(!obstacle.CanPass(mover, target, height, air_group))
				return 0
		for(var/obj/obstacle in target)
			if(!obstacle.CanPass(mover, src, height, air_group))
				return 0

		return 1
	*/

/turf
	proc/burn()
		return 0
	proc/cooldown()
		return
	proc/ignite()
		return

/turf/simulated
	cooldown() //Cools a tile back down to room temperature. Called when a tile's atmosphere ignites.
		set background = BACKGROUND_ENABLED
		spawn(0)
			while(src.temperature > T20C)
				src.temperature = max(src.temperature - 10, T20C)
				sleep(10)

	burn()
		var/datum/gas_mixture2/G = src.get_air()
		if(G.promethium && G.oxygen)
			var/consumed = (min(G.promethium, G.oxygen)%20)+1
			src.promethium -= consumed //NOTE: This means that a turf may actually have a NEGATIVE value for some of these numbers before the gas_spread effect meges.
			src.oxygen -= consumed     //While this seems crazy, it's all part of the plan. The plan for absurd optimization in exchange for a tiny bit of realism.
			src.co2 += consumed*2 //No thermal expansion because that would actually be really messy to deal with the diffusion for.
			src.temperature += consumed*60
			return 1
		else
			update_atmos_overlay()
			return 0

	ignite()
		if(src.active_hotspot)
			return
		if(src.burn())
			cooldown() //Starts things cooling back down as it ignites them.
			new /obj/effect/hotspot(src)