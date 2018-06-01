/*
This is our new atmos system that will actually be present on the outpost very much.
Links each vent to a corresponding pump in the under maintenance.
If these vents have anything other than oxygen near them, they drain it down into the corridors and spit out pure oxygen (no matter what is actually down in those corridors)
When ventcrawling you use these vents to go down and the pumps to go up again.
Alternatively if one deconstructs a vent they can turn it into a passage down there.
If you go down there and flip a switch on the pump, you can switch the output to siphon pure air into the under maint and output whatever is below on the upper level.
So if you deconstruct a vent and haul a canister of promethium down, you can send fire to a localized place pretty easily.
But normally the system will siphon away fires quite effectively automatically.
Neat idea: When working with a vent, you can turn it into a ladder down to under maint. Make it possible to turn it into a concealed trap to send somebody falling down there as well.
*/

/*
/obj/structure/dummy_vent //Just for fun!
	icon = 'icons/obj/atmospherics/vent_pump.dmi'
	icon_state = "in"
	name = "air vent"
	desc = "A vent pipe with a valve and pump attached to it."
	density = 0
	opacity = 0
	anchored = 1
*/

/obj/machinery/atmospherics/vent
	icon = 'icons/obj/atmospherics/vent_pump.dmi'
	icon_state = "off"
	name = "air vent"
	desc = "A vent pipe with a valve and pump attached to it."
	use_power = 0
	unsecuring_tool = null
	density = 0
	opacity = 0
	anchored = 1
	layer = TURF_LAYER+0.1
	var/obj/machinery/atmospherics/vent/linked
	var/output = 0
	var/open = 0
	var/welded = 0
	var/rigged = 0
	var/datum/gas_spread/ventspread = null

/obj/machinery/atmospherics/vent/update_icon()
	return

/obj/machinery/atmospherics/vent/New()
	..()
	processing_objects.Add(src)
	update_icon()
	spawn(30)
		for(var/obj/machinery/atmospherics/vent/V in world)
			if(V.x == src.x && V.y == src.y && V.output != src.output)
				src.linked = V

/obj/machinery/atmospherics/vent/proc/vent() //If it detects something other than oxygen in the upper area, vents make a gas spread below of the upper area's contents and negative pure air, and make a gas spread above of negative the upper contents and positive pure air.
	if(!linked) return
	if(!ventspread || ventspread.killed != 1) return
	if(output)
		for(var/turf/T in range(1, src))
			var/datum/gas_mixture2/G = T.get_air()
			if(G.oxygen < 80 || G.promethium > 3 || G.sleepgas > 2 || G.poison > 1 || G.co2 > 10) //Don't do anything if we are dealing with pure air, or anything that is approximately breathable.
				var/datum/gas_spread/pure/P = new /datum/gas_spread/pure()
				var/datum/gas_spread/S = new /datum/gas_spread()
				P.linked = S
				P.spread(get_turf(src))
				S.spread(get_turf(src.linked)) //Really simple lightweight atmosphere exchange.
				ventspread = P

/obj/machinery/atmospherics/vent/process()
	return //Problem solved... For now.
	if(welded || open || rigged) return //If the machinery has been screwed with it won't work.
	vent()

/obj/machinery/atmospherics/vent/proc/toggle_open()
	src.open = !src.open
	src.update_icon()
	if(src.linked)
		linked.open = !linked.open
		linked.update_icon()

/obj/machinery/atmospherics/vent/proc/toggle_welded()
	src.welded = !src.welded
	src.update_icon()
	if(src.linked)
		linked.welded = !linked.welded
		linked.update_icon()

/obj/machinery/atmospherics/vent/proc/toggle_output()
	src.output = !src.output
	src.update_icon()
	if(src.linked)
		linked.output = !linked.output
		linked.update_icon()

/obj/machinery/atmospherics/vent/proc/toggle_rigged()
	src.rigged = !src.rigged
	src.update_icon()
	if(src.linked)
		linked.rigged = !linked.rigged
		linked.update_icon()

/obj/machinery/atmospherics/vent/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/weapon/screwdriver))
		if(!welded)
			user << "\red You can't remove the blade while it's still spinning! Weld it or something!"
			return
		if(!open)
			user << "Opening air vent..."
		else
			user << "Closing air vent..."
		if(do_after(user, 100))
			if(!open)
				user.visible_message("<b>[user]</b> opens the [src].")
			else
				user.visible_message("<b>[user]</b> closes the [src].")
			src.toggle_open()
		else
			if(!open)
				user << "You are distracted and fail to open the air vent."
			else
				user << "You are distracted and fail to close the air vent."
		return
	if(istype(W, /obj/item/weapon/weldingtool))
		if(open)
			user << "\red Close up the vent to weld or unweld it."
			return
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0,user))
			src.toggle_welded()
			return
	if(istype(W, /obj/item/weapon/crowbar))
		if(open)
			if(!rigged)
				user << "Disconnecting supports for this shaft..."
			else
				user << "Reconnecting supports for this shaft..."
			if(do_after(user, 300)) //Making this a large delay because otherwise it could be annoying as hell. I would make it a multistep process but that's bothersome, and to make it a concealed trap you do actually have to go through some steps. Five to be exact.
				if(!rigged)
					user.visible_message("<b>[user]</b> disconnects the support shafts for [src].")
				else
					user.visible_message("<b>[user]</b> reconnects the support shafts for [src].")
				src.toggle_rigged()
			else
				if(!rigged)
					user << "You are distracted and fail to disconnect the supports for this shaft."
				else
					user << "You are distracted and fail to reconnect the supports for this shaft."
			return
	..()

/obj/machinery/atmospherics/vent/attack_hand(mob/user as mob)
	if(open)
		if(rigged)
			user << "\red The ladder and supports are disconnected from this shaft. Reconnect them to use this shaft."
			return
		if(!linked)
			user << "\red This pipe is collapsed."
			return
		user.visible_message("<b>[user]</b> enters the [src]!")
		user.loc = get_turf(linked)
		if(user.pulling)
			user.pulling.loc = get_turf(linked)
		user.visible_message("<b>[user]</b> emerges from the [src]!")

/obj/machinery/atmospherics/vent/upper
	output = 1

/obj/machinery/atmospherics/vent/upper/Crossed(atom/movable/AM as mob|obj)
	if(!linked) return
	if(rigged)
		if(iscarbon(AM))
			var/mob/living/carbon/C = AM
			if(!linked) return
			if(!open)
				toggle_open()
				update_icon()
			C.visible_message("\red [C] falls down the ventilation shaft!") //I sort of want a sound for this...
			C.loc = get_turf(linked)
			C.visible_message("\red [C] falls from the vent above!")
			C.Weaken(6)
			C.Paralyse(2)
			C.take_overall_damage(10)

/obj/machinery/atmospherics/vent/upper/update_icon()
	src.overlays.Cut()
	if(open)
		icon_state = "off"
		if(rigged)
			src.overlays += image('icons/obj/atmospherics/vent_pump.dmi', "pit", layer=3)
		else
			src.overlays += image('icons/obj/atmospherics/vent_pump.dmi', "ladderdown", layer=3)
	else
		if(welded)
			icon_state = "weld"
		else
			if(output)
				icon_state = "out"
			else
				icon_state = "in"
	return

/obj/machinery/atmospherics/vent/lower
	name = "pump"
	icon_state = "pump"
	output = 0

/obj/machinery/atmospherics/vent/lower/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		user << "Adjusting filter mode..."
		if(do_after(user, 150))
			user.visible_message("<b>[user]</b> adjusts the filter mode for [src].")
			src.toggle_output()
			if(output)
				user << "\red You set the [src] to divert unclean air on the upper level and filter air on the lower level."
			else
				user << "\red You set the [src] to divert unclean air on the lower level and filter air on the upper level."
		else
			user << "You are distracted and fail to adjust the filter mode."
		return
	..()

/obj/machinery/atmospherics/vent/lower/update_icon()
	src.overlays.Cut()
	src.icon_state = "pump"
	if(output)
		src.overlays += image('icons/obj/atmospherics/vent_pump.dmi', "valveclosed", layer=3)
	else
		src.overlays += image('icons/obj/atmospherics/vent_pump.dmi', "valveopen", layer=3)
	if(open)
		if(!rigged)
			src.overlays += image('icons/obj/atmospherics/vent_pump.dmi', "ladderup", layer=3)
	return

/obj/machinery/atmospherics/vent/AltClick(var/mob/living/L)
	if(!L.ventcrawler || !isliving(L) || !Adjacent(L))
		return
	if(L.stat)
		L << "You must be conscious to do this!"
		return
	if(L.lying)
		L << "You can't vent crawl while you're stunned!"
		return
	if(welded)
		L << "That vent is welded shut."
		return
	if(!src.linked)
		L << "This vent is not connected to anything."
		return
	if(iscarbon(L) && L.ventcrawler < 2) // lesser ventcrawlers can't bring items
		for(var/obj/item/carried_item in L.contents)
			if(!istype(carried_item, /obj/item/weapon/implant))//If it's not an implant
				L << "<span class='warning'> You can't be carrying items or have items equipped when vent crawling!</span>"
				return
	for(var/mob/O in viewers(L, null))
		O.show_message(text("<B>[L] scrambles into the ventillation ducts!</B>"), 1)
	for(var/mob/O in hearers(src.linked,null))
		O.show_message("You hear something squeezing through the ventilation ducts.",2)
	L.loc = src.linked.loc
	var/area/new_area = get_area(L.loc)
	if(new_area)
		new_area.Entered(L)