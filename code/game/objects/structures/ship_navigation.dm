/obj/machinery/shipnav
	name = "\improper Navigation System"
	desc = "The device which allows a pilot to move their craft."
	icon = 'icons/obj/machines/ship.dmi'
	icon_state = "controller0"
	density = 1
	anchored = 1
	var/base_icon = "controller"
	var/datum/fake_area/area
	var/mob/living/pilot
	var/shipname = "ship"
	var/can_move = 1
	var/speed = 5
	var/collision_force = 1

/obj/machinery/shipnav/update_icon()
	if(pilot)
		icon_state = "[base_icon]1"
	else
		icon_state = "[base_icon]0"

/obj/machinery/shipnav/proc/accept_pilot(var/mob/living/M)
	M.loc = src
	pilot = M
	if(pilot.client)
		pilot.client.view = 14
		if(shipname)
			pilot << "\red You enter the navigation module to the [shipname]."
		else
			pilot << "\red You enter the navigation module."
			shipname = input(pilot,"Choose the name for the craft.","Name craft.","[shipname]") as text
	update_icon()

/obj/machinery/shipnav/proc/eject_pilot()
	if(pilot)
		pilot.loc = get_turf(src)
		pilot.client.view = world.view
		pilot = null
		update_icon()

/obj/machinery/shipnav/verb/move_inside()
	set category = "Pilot Interface"
	set name = "Pilot Craft"
	set src in oview(1)

	if(usr && iscarbon(usr))
		accept_pilot(usr)

/obj/machinery/shipnav/verb/eject()
	set name = "Eject Pilot Console"
	set category = "Pilot Interface"
	set src = oview(1)

	if(usr && iscarbon(usr))
		if(pilot) eject_pilot()

/obj/machinery/shipnav/ex_act()
	..()
	eject_pilot()

/obj/machinery/shipnav/bullet_act()
	..()
	eject_pilot()

/obj/machinery/shipnav/blob_act()
	..()
	eject_pilot()

/obj/machinery/shipnav/relaymove(mob/user,direction)
	if(area && can_move)
		can_move = 0
		spawn(speed) can_move = 1
		if(!area.move(direction, collision_force, smoothingtime = speed)) user << "\red Movement obstructed."