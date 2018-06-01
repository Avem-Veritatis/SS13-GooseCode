#define CARGODRONE_MOVE_TIME 240
#define CARGODRONE_COOLDOWN 200

/area/cargodrone
	name = "CargoDrone"
	icon_state = "start"

/area/cargodrone/transit

/area/cargodrone/start

/area/cargodrone/orks

/area/cargodrone/eldar

/area/cargodrone/tau

/area/cargodrone/krieg

/area/cargodrone/ruins

/obj/machinery/computer/cargodrone
	name = "Cargo Drone Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "aiupload"
	var/area/curr_location
	var/moving = 0
	var/lastMove = 0


/obj/machinery/computer/cargodrone/New()
	curr_location= locate(/area/cargodrone/start)


/obj/machinery/computer/cargodrone/proc/syndicate_move_to(area/destination as area)
	if(moving)	return
	if(lastMove + CARGODRONE_COOLDOWN > world.time)	return
	var/area/dest_location = locate(destination)
	if(curr_location == dest_location)	return

	moving = 1
	lastMove = world.time

	if(curr_location.z != dest_location.z)
		var/area/transit_location = locate(/area/cargodrone/transit)
		curr_location.move_contents_to(transit_location)
		curr_location = transit_location
		curr_location.has_gravity = 0
		transit_location.has_gravity = 1
		sleep(CARGODRONE_MOVE_TIME)

	curr_location.move_contents_to(dest_location)
	curr_location = dest_location
	moving = 0
	return 1

/obj/machinery/computer/cargodrone/attack_hand(mob/user as mob)
	if(!allowed(user))
		user << "\red Access Denied"
		return

	user.set_machine(src)

	var/dat = {"Location: [curr_location]<br>
	Ready to move[max(lastMove + CARGODRONE_COOLDOWN - world.time, 0) ? " in [max(round((lastMove + CARGODRONE_COOLDOWN - world.time) * 0.1), 0)] seconds" : ": now"]<br>
	<a href='?src=\ref[src];syndicate=1'>CargoDrone Transit</a><br>
	<a href='?src=\ref[src];station_nw=1'>ArchAngel II: Rural Areas</a> |
	<a href='?src=\ref[src];station_ne=1'>ArchAngel Asteroid Belt</a><br>
	<a href='?src=\ref[src];station_sw=1'>ArchAngel OuterSystem</a> |
	<a href='?src=\ref[src];station_se=1'>ArchAngel Regentrophen</a><br>
	<a href='?src=\ref[src];mining=1'>ArchAngel IV: Ruins</a><br>
	<a href='?src=\ref[user];mach_close=computer'>Close</a>"}

	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")
	return


/obj/machinery/computer/cargodrone/Topic(href, href_list)
	if(..())
		return

	var/mob/living/user = usr

	user.set_machine(src)

	if(href_list["syndicate"])
		syndicate_move_to(/area/cargodrone/start)
	else if(href_list["station_nw"])
		var/area/cargodrone/start/outpoststart
		for(var/mob/living/interloper in outpoststart)								//Some one there?
			interloper <<"Woooops! You fell off the back of the drone."
			interloper.Weaken(4)
			interloper.loc = get_turf(locate("landmark*cargodronefall"))			//GET OUT!
		syndicate_move_to(/area/cargodrone/orks)
	else if(href_list["station_ne"])
		var/area/cargodrone/start/outpoststart
		for(var/mob/living/interloper in outpoststart)
			interloper <<"Woooops! You fell off the back of the drone."
			interloper.Weaken(4)
			interloper.loc = get_turf(locate("landmark*cargodronefall"))
		syndicate_move_to(/area/cargodrone/eldar)
	else if(href_list["station_sw"])
		var/area/cargodrone/start/outpoststart
		for(var/mob/living/interloper in outpoststart)
			interloper <<"Woooops! You fell off the back of the drone."
			interloper.Weaken(4)
			interloper.loc = get_turf(locate("landmark*cargodronefall"))
		syndicate_move_to(/area/cargodrone/tau)
	else if(href_list["station_se"])
		var/area/cargodrone/start/outpoststart
		for(var/mob/living/interloper in outpoststart)
			interloper <<"Woooops! You fell off the back of the drone."
			interloper.Weaken(4)
			interloper.loc = get_turf(locate("landmark*cargodronefall"))
		syndicate_move_to(/area/cargodrone/krieg)
	else if(href_list["mining"])
		syndicate_move_to(/area/cargodrone/ruins)

	updateUsrDialog()
	return
