/obj/effect/forcefield
	desc = "A space wizard's magic wall."
	name = "FORCEWALL"
	icon = 'icons/effects/effects.dmi'
	icon_state = "m_shield"
	anchored = 1.0
	opacity = 0
	density = 1
	unacidable = 1

/obj/effect/forcefield/refractor
	name = "Refractor Field"
	desc = "A field that blocks many projectiles."
	icon_state = "ion_fade"
	mouse_opacity = 0
	alpha = 50

/obj/effect/forcefield/refractor/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/item/projectile))
		return 0
	return 1

/obj/effect/forcefield/refractor/New()
	..()
	spawn(600)
		qdel(src)
	return

/obj/effect/forcefield/refractor2
	name = "Refractor Field"
	desc = "A field that blocks many projectiles."
	icon_state = "ion_fade"
	mouse_opacity = 0
	alpha = 50

/obj/effect/forcefield/refractor2/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/item/projectile))
		return 0
	return 1

///////////Mimewalls///////////

/obj/effect/forcefield/mime
	icon_state = "empty"
	name = "invisible wall"
	desc = "You have a bad feeling about this."
	var/timeleft = 300
	var/last_process = 0

/obj/effect/forcefield/mime/New()
	..()
	last_process = world.time
	processing_objects.Add(src)

/obj/effect/forcefield/mime/process()
	timeleft -= (world.time - last_process)
	if(timeleft <= 0)
		processing_objects.Remove(src)
		qdel(src)

