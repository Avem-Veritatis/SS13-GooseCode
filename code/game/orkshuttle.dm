/obj/structure/shuttle/ork
	name = "ork rocket"
	icon = 'icons/turf/orkturf.dmi'
	density = 1
	anchored = 1

/obj/structure/shuttle/ork/engine
	name = "ork engine"
	icon_state = "engine"

/obj/structure/shuttle/ork/rightstructure
	name = "ork engine"
	icon_state = "rightside1"

/obj/structure/shuttle/ork/leftstructure
	name = "ork engine"
	icon_state = "leftside1"

/obj/structure/shuttle/ork/leftstructure2
	name = "ork engine"
	icon_state = "leftside2"

/obj/structure/shuttle/ork/leftstructure3
	name = "ork engine"
	icon_state = "leftside3"

/obj/structure/shuttle/ork/leftstructure4
	name = "ork engine"
	icon_state = "leftside4"

/obj/structure/shuttle/ork/leftstructure5
	name = "ork engine"
	icon_state = "leftside5"

/obj/structure/shuttle/ork/rightstructure
	name = "ork engine"
	icon_state = "rightside"

/obj/structure/shuttle/ork/rightstructure2
	name = "ork engine"
	icon_state = "rightside2"

/obj/structure/shuttle/ork/rightstructure3
	name = "ork engine"
	icon_state = "rightside3"

/obj/structure/shuttle/ork/rightstructure4
	name = "ork engine"
	icon_state = "rightside4"

/obj/structure/shuttle/ork/rightstructure5
	name = "ork engine"
	icon_state = "rightside5"

/obj/structure/shuttle/ork/middlelstructure
	name = "ork engine"
	icon_state = "mleft1"

/obj/structure/shuttle/ork/middlestructure
	name = "ork engine"
	icon_state = "mm1"

/obj/structure/shuttle/ork/middlerstructure
	name = "ork engine"
	icon_state = "mright1"

/obj/structure/shuttle/ork/fillerstructure2
	name = "Rokkit!"
	icon_state = "filler2"

/obj/structure/shuttle/ork/fillerstructure3
	name = "Rokkit!"
	icon_state = "filler3"

/obj/structure/shuttle/ork/fillerstructure4
	name = "Rokkit!"
	icon_state = "filler4"

/obj/structure/shuttle/ork/fillerstructure5
	name = "Rokkit!"
	icon_state = "filler5"

/obj/structure/shuttle/ork/fillerstructure1
	name = "Rokkit!"
	icon_state = "filler1"

/obj/structure/shuttle/ork/middlelstructure2
	name = "ork engine"
	icon_state = "mleft2"

/obj/structure/shuttle/ork/middlestructure2
	name = "ork engine"
	icon_state = "mm2"

/obj/structure/shuttle/ork/middlerstructure2
	name = "ork engine"
	icon_state = "mright2"

/obj/structure/shuttle/ork/fillerstructure6
	name = "Rokkit!"
	icon_state = "filler6"


/obj/machinery/computer/shuttle/ork
	name = "Labor Shuttle Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	circuit = /obj/item/weapon/circuitboard/labor_shuttle
	id = "ork"


/obj/machinery/computer/shuttle/ork/one_way
	name = "Rokkit button!"
	desc = "DO NOT PUSH DIS BUTTON!!!!"
	circuit = /obj/item/weapon/circuitboard/labor_shuttle/one_way
	req_access = list( )

/obj/machinery/computer/shuttle/ork/one_way/Topic(href, href_list)
	if(href_list["move"])
		var/datum/shuttle_manager/s = shuttles["ork"]
		if(s.location == /area/shuttle/ork/orkplanet)
			usr << "\blue BUT YOU IS THERE!"
			return 0
		world << sound('sound/effects/lookout.ogg')
		sleep (80)
		for(var/mob/living/M in world)
			shake_camera(M, 20, 1)
		world << sound('sound/effects/explosionfar.ogg')
	..()

/obj/machinery/conveyor_switch/oneway/ork
	name = "Rokkit button!"
	desc = "DO NOT PUSH DIS BUTTON!!!!"
	var/idle = 1

/obj/machinery/conveyor_switch/oneway/ork/attack_hand(mob/user)
	..()
	if (idle)
		idle = 0
		world << sound('sound/effects/lookout.ogg')
		sleep (80)
		for(var/mob/living/M in world)
			shake_camera(M, 20, 1)
		world << sound('sound/effects/explosionfar.ogg')

		var/datum/shuttle_manager/s = shuttles["ork"]
		if(istype(s)) s.move_shuttle(0,1)
		message_admins("[key_name_admin(usr)] moved the orkshuttle", 1)
		log_admin("[key_name(usr)] moved the orkshuttle")
	else
		usr << "\blue BUT YOU IS THERE!"

