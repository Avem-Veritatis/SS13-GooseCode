/obj/effect/landmark/nurgleship
	name = "nurgle ship warp point"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/nurgleship2
	name = "nurgle ship intermediary warp point"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/fake_floor/nurgle
	name = "engraved floor"
	desc = "A floor engraved with heretical writings."
	icon_state = "cult"
	damagedsprites = list("cultdamage","cultdamage2","cultdamage3","cultdamage4","cultdamage5","cultdamage6","cultdamage7")

/obj/effect/fake_floor/fake_wall/nurgle
	icon_state = "arust0"
	base_icon_state = "arust"

/obj/machinery/shipnav/nurgle
	icon_state = "nurglecontroller0"
	base_icon = "nurglecontroller"
	shipname = "Plague Ship"
	var/warping = 0

/obj/machinery/shipnav/nurgle/New()
	..()
	spawn(20)
		area = new /datum/fake_area()
		for(var/obj/effect/fake_floor/nurgle/FF in range(50, src))
			area.add_turf(FF)
		for(var/obj/effect/fake_floor/fake_wall/nurgle/FW in range(50, src))
			area.add_turf(FW)

/obj/machinery/shipnav/nurgle/relaymove(mob/user,direction)
	if(warping)
		return
	..()

/obj/machinery/shipnav/nurgle/verb/warp()
	set name = "Warp Craft"
	set category = "Pilot Interface"
	set src = usr.loc
	set popup_menu = 0

	if(usr != src.pilot)	return

	if(warping)
		usr << "\red The vessel is already set to warp somewhere!"
		return

	var/list/destinations = list()
	var/list/names = list()
	for(var/obj/effect/landmark/nurgleship/N in world)
		var/nametag = "Warp Point ([N.x], [N.y], [N.z])"
		destinations[nametag] = N
		names.Add(nametag)

	var/selection = input(usr,"Select a destination.", "Warp Craft") as null|anything in names
	if(selection)
		spawn(0)
			usr << "\red Preparing to travel through the warp..."
			warping = 1
			sleep(70)
			for(var/obj/effect/landmark/nurgleship2/N2 in world)
				area.teleport(get_turf(N2))
				break
			sleep(70)
			area.teleport(get_turf(destinations[selection]))
			warping = 0
	return
