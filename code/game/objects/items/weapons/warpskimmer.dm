/obj/item/weapon/warp_skimmer
	name = "Warp Skimmer"
	desc = "A device which allows you to move through the warp."
	icon = 'icons/obj/teleport.dmi'
	icon_state = "tp"
	var/uses = 10.0
	w_class = 2.0
	item_state = "paper"
	throw_speed = 3
	throw_range = 7
	origin_tech = "bluespace=4"
	var/mob/living/affecting = null

/obj/item/weapon/warp_skimmer/attack_self(mob/user as mob)
	verbs += /obj/item/weapon/warp_skimmer/proc/warp
	user <<"The warp skimmer is now active. Right click and select 'Warp to Area' This ability will only work so long as you have the Warp Skimmer on your person. Be warned."

/obj/item/weapon/warp_skimmer/proc/warp(turf/T in oview())
	set name = "Warp to Area"
	set desc = "Brave the warp for faster travel"
	set category = null//So it does not show up on the panel but can still be right-clicked.
	set src = usr.contents//Fixes verbs not attaching properly for objects. Praise the DM reference guide!


	var/mob/living/carbon/human/U = usr
	var/turf/mobloc = get_turf(U.loc)//To make sure that certain things work properly below.

	if(!usr.canmove || usr.stat || usr.restrained())
		usr << "<span class='notice'>Just... can't.... seem.... to reach....!!</span>"
		return

	if((!T.density)&&istype(mobloc, /turf))
		spawn(0)
			playsound(U.loc, 'sound/effects/sparks4.ogg', 50, 1)
			anim(mobloc,src,'icons/mob/mob.dmi',,"phaseout",,U.dir)

		handle_teleport_grab(T, U)
		U.loc = T

		spawn(0)
			playsound(U.loc, 'sound/effects/phasein.ogg', 25, 1)
			playsound(U.loc, 'sound/effects/sparks2.ogg', 50, 1)
			anim(U.loc,U,'icons/mob/mob.dmi',,"phasein",,U.dir)

//		spawn(0)//Any living mobs in teleport area are gibbed.
//			T.kill_creatures(U)
	else
		U << "\red You cannot teleport into solid walls or from solid matter"

/obj/item/weapon/warp_skimmer/proc/handle_teleport_grab(turf/T, mob/living/U)
	if(istype(U.get_active_hand(),/obj/item/weapon/grab))//Handles grabbed persons.
		var/obj/item/weapon/grab/G = U.get_active_hand()
		G.affecting.loc = locate(T.x+rand(-1,1),T.y+rand(-1,1),T.z)//variation of position.
	if(istype(U.get_inactive_hand(),/obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = U.get_inactive_hand()
		G.affecting.loc = locate(T.x+rand(-1,1),T.y+rand(-1,1),T.z)//variation of position.
	return