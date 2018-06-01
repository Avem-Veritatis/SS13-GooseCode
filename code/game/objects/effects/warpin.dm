//A neat little effect for Plague Marines

/obj/warpin
	name = "The Warp"
	icon = 'icons/obj/narsie.dmi'
	icon_state = "ws2"
	pixel_x = -89
	pixel_y = -85 //Some modifications to center it and get the animation going.

/obj/warpin/New()
	sleep(40)
	qdel(src)

/turf/unsimulated/floor/ksonsteleport
	name = "ksons"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "snow"
	thermal_conductivity = 1.6
	heat_capacity = 1000
	temperature = 265


/turf/unsimulated/floor/ksonsteleport/Entered(atom/movable/AM)		//ITS A TRAP!
	..()

	if(istype(AM, /obj/effect))									//We don't want no effects
		return

	if(istype(AM, /atom/movable))								//Wait what is this?
		if(isliving(AM))										//Is it alive?
			fall(AM)										//Seeya later!

	else
		return

/turf/unsimulated/floor/ksonsteleport/proc/fall(mob/living/M as mob, mob/user as mob)
	M.loc = get_turf(locate("landmark*ksons")) 			//SEEYA LATER!
	M.visible_message("<span class='danger'>[M.name] appears out of the warp!</span>")
	new /obj/warpin (M.loc)
	playsound(M.loc, 'sound/effects/ksonsintro.ogg', 75, 0)

/turf/unsimulated/floor/ksonsteleport/ex_act(severity)
	return