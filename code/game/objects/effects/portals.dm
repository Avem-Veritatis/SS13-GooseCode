/obj/effect/portal
	name = "Warp Portal"
	desc = "A mostly stable tunnel through the warp created by sanctioned imperial transportation equipment."
	icon = 'icons/effects/warpgate.dmi'
	icon_state = "blank"
	density = 1
	unacidable = 1//Can't destroy energy portals.
	var/obj/item/target = null
	var/creator = null
	anchored = 1.0

/obj/effect/portal/Bumped(mob/M as mob|obj)
	src.teleport(M)

/obj/effect/portal/Crossed(AM as mob|obj)
	src.teleport(AM)

/obj/effect/portal/New(loc, turf/target, creator, lifespan=300)
	portals += src
	src.loc = loc
	src.target = target
	src.creator = creator
	for(var/mob/M in src.loc)
		src.teleport(M)
	if(!istype(src, /obj/effect/portal/wormhole))
		anim(get_turf(src) , src, 'icons/effects/warpgate.dmi', "portal_in", sleeptime = 11, direction = src.dir)
		src.icon_state = "portal"
	if(lifespan > 0)
		spawn(lifespan)
			if(!istype(src, /obj/effect/portal/wormhole))
				src.icon_state = "blank"
				anim(get_turf(src) , src, 'icons/effects/warpgate.dmi', "portal_out", sleeptime = 4, direction = src.dir)
			qdel(src)
	return

/obj/effect/portal/Destroy()
	portals -= src
	if(istype(creator, /obj/item/weapon/hand_tele))
		var/obj/item/weapon/hand_tele/O = creator
		O.active_portals--
	return ..()

/obj/effect/portal/proc/teleport(atom/movable/M as mob|obj)
	if(istype(M, /obj/effect)) //sparks don't teleport
		return
	if(M.anchored&&istype(M, /obj/mecha))
		return
	if(icon_state == "portal1")
		return
	if (!( target ))
		qdel(src)
		return
	if (istype(M, /atom/movable))
		do_teleport(M, target, 1) ///You will appear adjacent to the beacon

