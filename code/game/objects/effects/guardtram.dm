/obj/machinery/door/poddoor/barracks
	name = "blast door"
	desc = "A sturdy imperial blast door."
	icon_state = "closed"
	density = 1
	opacity = 1

/obj/effect/fake_floor/tram
	icon_state = "floor"

/obj/effect/fake_floor/fake_wall/r_wall/tram

/obj/machinery/tram_switch
	name = "tram control"
	desc = "A tram control switch."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-fwd"
	anchored = 1
	var/position = 1			// 1 for at outpost, 0 for at barracks
	var/moving = 0
	var/datum/fake_area/area

/obj/machinery/tram_switch/New()
	..()
	spawn(20)
		area = new /datum/fake_area()
		for(var/obj/effect/fake_floor/tram/FF in range(20, src))
			area.add_turf(FF)
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tram/FW in range(20, src))
			area.add_turf(FW)

/obj/machinery/tram_switch/update_icon()
	if(position == 0)
		icon_state = "switch-rev"
	if(position == 1)
		icon_state = "switch-fwd"

/obj/machinery/tram_switch/attack_hand(mob/user, var/repeat = 1)
	if(repeat)
		for(var/obj/machinery/tram_switch_alt/TA in world)
			TA.attack_hand(user, 0)
	if(moving)
		user << "\red The tram is already moving!"
		return
	for(var/obj/machinery/door/poddoor/barracks/B in range(5, src))
		B.close(1)
	position = !position
	update_icon()
	var/direction = NORTH
	if(position)
		direction = SOUTH
	moving = 1
	var/loops = 0
	while(moving)
		sleep(4)
		moving = area.move(direction, 0)
		loops ++
		if(loops >= 60) //Maximum range of the tram.
			moving = 0
	for(var/obj/machinery/door/poddoor/barracks/B in range(5, src))
		B.open(1)

/obj/machinery/tram_switch_alt
	name = "tram control"
	desc = "A tram control switch."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-fwd"
	anchored = 1
	var/position = 1

/obj/machinery/tram_switch_alt/update_icon()
	if(position == 0)
		icon_state = "switch-rev"
	if(position == 1)
		icon_state = "switch-fwd"

/obj/machinery/tram_switch_alt/attack_hand(mob/user, var/repeat = 1)
	position = !position
	update_icon()
	if(repeat)
		for(var/obj/machinery/tram_switch/TS in world)
			TS.attack_hand(user, 0)
		for(var/obj/machinery/tram_switch_alt/TA in world)
			if(TA != src) TA.attack_hand(user, 0)