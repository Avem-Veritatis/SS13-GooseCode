var/obj/list/shuttles = list(("escape" = new /datum/shuttle_manager(/area/shuttle/escape/centcom, 0)), ("pod1" =  new /datum/shuttle_manager(/area/shuttle/escape_pod1/station, 0)), ("pod2" = new /datum/shuttle_manager(/area/shuttle/escape_pod2/station, 0)), ("pod3" = new /datum/shuttle_manager(/area/shuttle/escape_pod3/station, 0)), ("pod4" = new /datum/shuttle_manager(/area/shuttle/escape_pod4/station, 0)), ("mining" = new /datum/shuttle_manager(/area/shuttle/mining/station, 10, 1)), ("eccles" = new /datum/shuttle_manager(/area/shuttle/preachershuttle, 10, 1)), ("celeb" = new /datum/shuttle_manager(/area/shuttle/celeb/space, 10, 1)), ("laborcamp" = new /datum/shuttle_manager(/area/shuttle/laborcamp/station, 10, 1)), ("DK1" = new /datum/shuttle_manager(/area/shuttle/DK/DK1SPACE, 10, 1)), ("DK2" = new /datum/shuttle_manager(/area/shuttle/DK/DK2SPACE, 10, 1)), ("MECH" = new /datum/shuttle_manager(/area/shuttle/mechanicus, 10, 1)), ("sob" = new /datum/shuttle_manager(/area/shuttle/sob/sobspace, 10, 1)), ("stargazer" = new /datum/shuttle_manager(/area/shuttle/stargazer/stargazerspace, 10, 1)), ("ork" = new /datum/shuttle_manager(/area/shuttle/ork/orkspace, 10, 1)), ("droppod" = new /datum/shuttle_manager(/area/shuttle/droppod/droppodspace, 0)), ("ferry" = new /datum/shuttle_manager(/area/shuttle/transport1/centcom, 0)), ("ladder" = new /datum/shuttle_manager(/area/shuttle/celeb2/hidden, 0)))
		//Pre-made shuttles should have non-number keys, so that buildable shuttles can use numbered keys without allowing 'I build a shuttle console with the escape number as its ID.'
datum/shuttle_manager
	var/tickstomove = 10 //How long does it take to move the shuttle?
	var/moving = 0 //Is it moving?
	var/area/shuttle/location //The current location of the actual shuttle
	var/check_disk // Should we prevent the shuttle from moving if the nuke disk is in board?

datum/shuttle_manager/New(var/area, var/delay, var/block_disk) //Create a new shuttle manager for the shuttle starting area, "area" and with a movement delay of tickstomove
	location = area
	tickstomove = delay
	check_disk = block_disk
	var/area/A = locate(location)
	A.has_gravity = 1


datum/shuttle_manager/proc/move_shuttle(var/override_delay, var/override_diskcheck)
	if(moving)	return 0
	moving = 1
	spawn(override_delay == null ? tickstomove*10 : override_delay)
		//Check for disk if check_disk is 1
		if(check_disk && !override_diskcheck)
			var/area/SHUTTLE = locate(location)
			if(SHUTTLE.GetTypeInAllContents(/obj/item/weapon/disk/nuclear))
				for(var/mob/MOB in SHUTTLE)
					MOB << "<span class='warning'>Unauthorized cargo detected. Aborting launch.</span>"
				moving = 0
				return

		var/area/shuttle/fromArea
		var/area/shuttle/toArea
		fromArea = locate(location) //the location of the shuttle
		toArea = locate(fromArea.destination)

		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		for(var/obj/D in toArea)		//why wasn't this already here?
			qdel(D)

		fromArea.move_contents_to(toArea)
		location = toArea.type

		fromArea.has_gravity = 0
		toArea.has_gravity = 1

		for(var/obj/machinery/door/D in toArea) //Close any doors on the shuttle
			spawn(0)
				D.close()

		for(var/mob/M in toArea)
			if(M.client)
				spawn(0)
					if(M.buckled)
						shake_camera(M, 2, 1) // turn it down a bit come on
					else
						shake_camera(M, 7, 1)
			if(istype(M, /mob/living/carbon))
				if(!M.buckled)
					M.Weaken(3)

		moving = 0
	return 1




/obj/machinery/computer/shuttle
	name = "Shuttle Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	req_access = list( )
	circuit = /obj/item/weapon/circuitboard/shuttle
	var/id

/obj/machinery/computer/shuttle/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat
	dat = text("<center><A href='?src=\ref[src];move=[1]'>Send Shuttle</A></center>")
	//user << browse("[dat]", "window=miningshuttle;size=200x100")
	var/datum/browser/popup = new(user, "miningshuttle", name, 200, 140)
	popup.set_content(dat)
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/machinery/computer/shuttle/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(!allowed(usr))
		usr << "\red Access denied."
		return
	if(href_list["move"])
		if(id in shuttles)
			var/datum/shuttle_manager/s = shuttles[id]
			if (s.move_shuttle())
				usr << "<span class='notice'>Shuttle recieved message and will be sent shortly.</span>"
			else
				usr << "<span class='notice'>Shuttle is already moving.</span>"
		else
			usr << "<span class='warning'>Invalid shuttle requested.</span>"


/obj/machinery/computer/shuttle/attackby(I as obj, user as mob)

	if (istype(I, /obj/item/weapon/card/emag))
		src.req_access = list()
		emagged = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"
	else
		..()
	return