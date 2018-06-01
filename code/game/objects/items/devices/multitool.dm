/**
 * Multitool -- A multitool is used for hacking electronic devices.
 * TO-DO -- Using it as a power measurement tool for cables etc. Nannek.
 *
 * Allenwrench - a religious icon
 */

/obj/item/device/multitool
	name = "multitool"
	desc = "Used for pulsing wires to test which to cut. Not recommended by doctors."
	icon_state = "multitool"
	force = 5.0
	w_class = 2.0
	throwforce = 0
	throw_range = 7
	throw_speed = 3
	m_amt = 50
	g_amt = 20
	origin_tech = "magnets=1;engineering=1"
	var/obj/machinery/telecomms/buffer // simple machine buffer for device linkage
	hitsound = 'sound/weapons/tap.ogg'


// Syndicate device disguised as a multitool; it will turn red when an AI camera is nearby.


/obj/item/device/multitool/ai_detect
	var/track_delay = 0

/obj/item/device/multitool/ai_detect/New()
	..()
	processing_objects += src


/obj/item/device/multitool/ai_detect/Destroy()
	processing_objects -= src
	..()

/obj/item/device/multitool/ai_detect/process()

	if(track_delay > world.time)
		return

	var/found_eye = 0
	var/turf/our_turf = get_turf(src)

	if(cameranet.chunkGenerated(our_turf.x, our_turf.y, our_turf.z))

		var/datum/camerachunk/chunk = cameranet.getCameraChunk(our_turf.x, our_turf.y, our_turf.z)

		if(chunk)
			if(chunk.seenby.len)
				for(var/mob/camera/aiEye/A in chunk.seenby)
					var/turf/eye_turf = get_turf(A)
					if(get_dist(our_turf, eye_turf) < 8)
						found_eye = 1
						break

	if(found_eye)
		icon_state = "[initial(icon_state)]_red"
	else
		icon_state = initial(icon_state)

	track_delay = world.time + 10 // 1 second
	return

/*
Allen Wrench
*/

/obj/item/device/allenwrench
	name = "Allen Wrench"
	desc = "The wrench of Saint Allen. For he did stand before the gathering and declare 'No longer shall I struggle with pliers. Instead I shall create a new tool specific for this bolt. Brothers! Throw down your screw drivers and follow me!'. -Exert, The Phillips heresy."
	icon = 'icons/obj/items.dmi'
	icon_state = "awrench"
	flags = CONDUCT|NODROP
	slot_flags = SLOT_BELT
	item_state = "c_tube"
	w_class = 2.0
	m_amt = 50
	origin_tech = "engineering=1"
	var/constructionsystem = 0
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")

/obj/item/device/allenwrench/attack(mob/living/carbon/C, mob/user)
	if(istype(C) && !istype(src, /obj/item/device/allenwrench/heretek))
		user.visible_message("<span class='notice'>[C] is blessed in the name of Saint Allen.</span>")
	..()

/obj/item/device/allenwrench/attack_self(usr)
	usr << "<span class='warning'>You can feel it.. you can just feel genius.</span>"

/*
turretprobe
*/

/obj/item/device/turretprobe
	name = "Target Reconciliation And Penance. T.R.A.P"
	desc = "It's a trap!!!"
	icon = 'icons/obj/items.dmi'
	icon_state = "trap"
	flags = CONDUCT|NODROP
	slot_flags = SLOT_BELT
	item_state = "implantcase"
	w_class = 2.0
	m_amt = 50
	origin_tech = "engineering=3"
	var/list/factions = list("Mechanicus")
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")

/obj/item/device/turretprobe/attack(mob/living/carbon/C, mob/user)
	if(istype(C))
		if(length(factions & C.factions))
			C.factions -= "Mechanicus"
			user.visible_message("<span class='notice'>[C] is scanned by the device.</span>")
			usr << "<span class='warning'>All turrets will now TARGET this lifeform.</span>"
		else
			C.factions += "Mechanicus"
			user.visible_message("<span class='notice'>[C] is scanned by the device.</span>")
			usr << "<span class='warning'>All turrets will now IGNORE this lifeform.</span>"
	else
		return
/obj/item/device/turretprobe/attack_self(usr)
	usr << "<span class='warning'>You can feel it.. you can just feel genius.</span>"
