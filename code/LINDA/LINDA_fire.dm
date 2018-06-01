
/atom/proc/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	return null

/turf/proc/hotspot_expose(exposed_temperature, exposed_volume, soh = 0)
	return

/turf/simulated/hotspot_expose(exposed_temperature, exposed_volume, soh)
	var/datum/gas_mixture/air_contents = return_air()
	if(!air_contents)
		return 0
	if(active_hotspot)
		if(soh)
			if(air_contents.toxins > 0.5 && air_contents.oxygen > 0.5)
				if(active_hotspot.temperature < exposed_temperature)
					active_hotspot.temperature = exposed_temperature
				if(active_hotspot.volume < exposed_volume)
					active_hotspot.volume = exposed_volume
		return 1

	var/igniting = 0

	if((exposed_temperature > PLASMA_MINIMUM_BURN_TEMPERATURE) && air_contents.toxins > 0.5)
		igniting = 1

	if(igniting)
		if(air_contents.oxygen < 0.5 || air_contents.toxins < 0.5)
			return 0

		active_hotspot = new(src)
		active_hotspot.temperature = exposed_temperature
		active_hotspot.volume = exposed_volume

		active_hotspot.just_spawned = (current_cycle < air_master.current_cycle)
			//remove just_spawned protection if no longer processing this cell
		air_master.add_to_active(src, 0)
	return igniting

//This is the icon for fire on turfs, also helps for nurturing small fires until they are full tile
/obj/effect/hotspot
	anchored = 1
	mouse_opacity = 0
	unacidable = 1//So you can't melt fire with acid.
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	layer = TURF_LAYER
	luminosity = 3
	var/volume = 125
	var/temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST
	var/just_spawned = 1
	var/bypassing = 0
	var/life = 50

/obj/effect/hotspot/New()
	..()
	perform_exposure()
	spawn(0)
		while(src.life >= 0)
			sleep(1)
			src.life --
			if(src.life == round(src.life, 10)) //Every second performs a new heat exposure
				perform_exposure()
		Kill()

/obj/effect/hotspot/proc/perform_exposure()
	var/turf/location = loc //This new hotspot code should work on any turf...
	if(!istype(location))	return 0
	location.temperature += 300
	for(var/atom/item in loc)
		if(item && item != src) // It's possible that the item is deleted in temperature_expose
			item.fire_act(null, temperature, volume)
	return 0


/obj/effect/hotspot/process()
	return

/turf/proc/updateFireOverlays()
	src.overlays.Cut()
	if(locate(/obj/effect/hotspot) in src) return
	if(locate(/obj/effect/hotspot) in get_step(src, NORTH))
		src.overlays += image('icons/effects/fire.dmi', "fire_n", layer=6)
	if(locate(/obj/effect/hotspot) in get_step(src, SOUTH))
		src.overlays += image('icons/effects/fire.dmi', "fire_s", layer=6)
	if(locate(/obj/effect/hotspot) in get_step(src, EAST))
		src.overlays += image('icons/effects/fire.dmi', "fire_e", layer=6)
	if(locate(/obj/effect/hotspot) in get_step(src, WEST))
		src.overlays += image('icons/effects/fire.dmi', "fire_w", layer=6)

/turf/proc/fullUpdateFireOverlays()
	spawn(2)
		for(var/turf/t in range(1,src)) t.updateFireOverlays()

/obj/effect/hotspot/proc/update_fringe()
	var/turf/T = get_turf(src)
	if(T)
		T.fullUpdateFireOverlays()
	else
		T = get_turf(src) //I would use recursion but that would need a variable to track the maximum depth
		if(T)
			T.fullUpdateFireOverlays()

/obj/effect/hotspot/proc/Kill()
	air_master.hotspots -= src
	DestroyTurf()
	garbage_collect()

/obj/effect/hotspot/proc/garbage_collect()
	var/turf/location = get_turf(src)
	location.temperature = initial(location.temperature) //quick and dirty way to restore a location's temperature
	update_fringe() //Should hopefully handle that the right way.
	if(istype(loc, /turf/simulated))
		var/turf/simulated/T = loc
		if(T.active_hotspot == src)
			T.active_hotspot = null
	loc = null

/obj/effect/hotspot/proc/DestroyTurf()

	if(istype(loc, /turf/simulated))
		var/turf/simulated/T = loc
		if(T.to_be_destroyed)
			var/chance_of_deletion
			if (T.heat_capacity) //beware of division by zero
				chance_of_deletion = T.max_fire_temperature_sustained / T.heat_capacity * 8 //there is no problem with prob(23456), min() was redundant --rastaf0
			else
				chance_of_deletion = 100
			if(prob(chance_of_deletion))
				T.ChangeTurf(/turf/snow)
			else
				T.to_be_destroyed = 0
				T.max_fire_temperature_sustained = 0

/obj/effect/hotspot/New()
	..()
	spawn(1) update_fringe()
	dir = pick(cardinal)
	air_update_turf()
	return

/obj/effect/hotspot/Crossed(mob/living/L)
	..()
	if(isliving(L))
		L.fire_act()
