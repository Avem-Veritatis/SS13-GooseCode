/obj/effect/dummy/flyingmob
	name = "Something Flying"
	desc = "It's a bird! It's a plane!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	var/canmove = 1
	var/reappearing = 0
	density = 0
	anchored = 1

/obj/effect/dummy/flyingmob/Destroy()
	// Eject contents if deleted somehow
	for(var/atom/movable/AM in src)
		AM.loc = get_turf(src)
		AM.visible_message("\red <b>Falls from the sky!</b>")
	..()

/obj/effect/dummy/flyingmob/relaymove(var/mob/user, direction)
	if (!src.canmove || reappearing) return
	var/turf/newLoc = get_step(src,direction)
	if(newLoc)
		loc = newLoc
		src.canmove = 0
		spawn(1) src.canmove = 1

/obj/effect/dummy/flyingmob/ex_act(blah)
	return
/obj/effect/dummy/flyingmob/bullet_act(blah)
	return

/mob/living/proc/fly()
	if(flying) return
	if(!istype(src.loc, /turf/snow) && !istype(src.loc, /turf/unsimulated/floor/snow)) return
	src.notransform = 1
	spawn(0)
		flying = new /obj/effect/dummy/flyingmob(get_turf(src))
		if(src.buckled)
			src.buckled.unbuckle()
		src.visible_message("\red <b>[src] shoots up into the air!</b>")
		src.loc = flying
		src.notransform=0

/mob/living/proc/drop()
	if(!flying) return
	if(!istype(flying.loc, /turf/snow) && !istype(flying.loc, /turf/unsimulated/floor/snow))
		usr << "\red You land on the roof."
		dropping = 1
		return
	dropping = 0
	src.canmove = 0
	flying.reappearing = 1
	sleep(20)
	src.loc = get_turf(src)
	src.visible_message("\red <b>[src] falls from the sky!</b>")
	qdel(flying)
	flying = null
	src.canmove = 1
	if(src.client)
		src.client.eye = src
	for(var/mob/living/M in range(0, src))
		if(M != src)
			M.Weaken(3)