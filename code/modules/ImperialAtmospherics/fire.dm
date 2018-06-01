/atom/proc/temperature_expose(datum/gas_mixture2/air, exposed_temperature, exposed_volume)
	return

/turf/proc/hotspot_expose(exposed_temperature, exposed_volume, soh = 0)
	return

/obj/effect/hotspot
	anchored = 1
	mouse_opacity = 0
	unacidable = 1//So you can't melt fire with acid.
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	layer = TURF_LAYER
	luminosity = 3

/obj/effect/hotspot/New()
	..()
	if(istype(src.loc, /turf/simulated))
		var/turf/T = src.loc
		if(T.active_hotspot)
			qdel(src)
		else
			T.active_hotspot = src
			T.cooldown()
	else
		qdel(src)
	spawn(1) update_fringe()
	dir = pick(cardinal)
	processing_objects.Add(src)
	return

/obj/effect/hotspot/process()
	var/turf/T = get_turf(src)
	if(T)
		Kill()
	if(T.temperature >= 1200)
		icon_state = "3"
	else if(T.temperature >= 800)
		icon_state = "2"
	else if(T.temperature >= 400)
		icon_state = "1"
	else
		if(prob(20)) Kill()
	if(!T.burn()) //Fire will not last as long without fuel and oxygen to react.
		if(prob(5)) Kill()
	for(var/turf/A in orange(1, T)) //Spread the fire to adjacent turfs.
		A.ignite()
	if(prob(40))
		var/datum/gas_mixture2/G = T.get_air()
		for(var/obj/O in orange(0, T))
			O.temperature_expose(G, G.temperature, G.get_pressure())

/obj/effect/hotspot/proc/update_fringe()
	var/turf/T = get_turf(src)
	if(T)
		T.fullUpdateFireOverlays()
	else
		T = get_turf(src) //I would use recursion but that would need a variable to track the maximum depth
		if(T)
			T.fullUpdateFireOverlays()

/obj/effect/hotspot/Crossed(mob/living/L)
	..()
	if(isliving(L))
		L.fire_act()

/obj/effect/hotspot/proc/Kill()
	//var/turf/location = get_turf(src)
	update_fringe()
	if(isturf(loc))
		var/turf/T = loc
		if(T.active_hotspot == src)
			T.active_hotspot = null
	loc = null
	qdel(src)

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