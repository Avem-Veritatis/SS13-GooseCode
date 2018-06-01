/obj/item/weapon/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "handcuff"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 5
	m_amt = 500
	origin_tech = "materials=1"
	var/breakouttime = 600 //Deciseconds = 120s = 2 minutes


/obj/item/weapon/handcuffs/attack(mob/living/carbon/C, mob/user)
	if(CLUMSY in user.mutations && prob(50))
		user << "<span class='warning'>Uh... how do those things work?!</span>"
		if(!C.handcuffed)
			user.drop_item()
			loc = C
			C.handcuffed = src
			C.update_inv_handcuffed(0)
			return

	var/cable = 0
	if(istype(src, /obj/item/weapon/handcuffs/cable))
		cable = 1

	if(!C.handcuffed)
		C.visible_message("<span class='danger'>[user] is trying to put handcuffs on [C]!</span>", \
							"<span class='userdanger'>[user] is trying to put handcuffs on [C]!</span>")

		if(cable)
			playsound(loc, 'sound/weapons/cablecuff.ogg', 30, 1, -2)
		else
			playsound(loc, 'sound/weapons/handcuffs.ogg', 30, 1, -2)

		var/turf/user_loc = user.loc
		var/turf/C_loc = C.loc
		if(do_after(user, 30))
			if(!C || C.handcuffed)
				return
			if(user_loc == user.loc && C_loc == C.loc)
				user.drop_item()
				loc = C
				C.handcuffed = src
				C.update_inv_handcuffed(0)
			if(cable)
				feedback_add_details("handcuffs","C")
			else
				feedback_add_details("handcuffs","H")

			add_logs(user, C, "handcuffed")

/obj/item/weapon/handcuffs/cable
	name = "cable restraints"
	desc = "Looks like some cables tied together. Could be used to tie something up."
	icon_state = "cuff_red"
	item_state = "coil_red"
	breakouttime = 300 //Deciseconds = 30s

/obj/item/weapon/handcuffs/cable/red
	icon_state = "cuff_red"

/obj/item/weapon/handcuffs/cable/yellow
	icon_state = "cuff_yellow"

/obj/item/weapon/handcuffs/cable/blue
	icon_state = "cuff_blue"
	item_state = "coil_blue"

/obj/item/weapon/handcuffs/cable/green
	icon_state = "cuff_green"

/obj/item/weapon/handcuffs/cable/pink
	icon_state = "cuff_pink"

/obj/item/weapon/handcuffs/cable/orange
	icon_state = "cuff_orange"

/obj/item/weapon/handcuffs/cable/cyan
	icon_state = "cuff_cyan"

/obj/item/weapon/handcuffs/cable/white
	icon_state = "cuff_white"

/obj/item/weapon/handcuffs/cable/attackby(var/obj/item/I, mob/user as mob)
	..()
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		var/obj/item/weapon/wirerod/W = new /obj/item/weapon/wirerod
		R.use(1)

		user.unEquip(src)

		user.put_in_hands(W)
		user << "<span class='notice'>You wrap the cable restraint around the top of the rod.</span>"

		qdel(src)

/obj/item/weapon/handcuffs/cyborg/attack(mob/living/carbon/C, mob/user)
	if(isrobot(user))
		if(!C.handcuffed)
			playsound(loc, 'sound/weapons/handcuffs.ogg', 30, 1, -2)
			C.visible_message("<span class='danger'>[user] is trying to put handcuffs on [C]!</span>", \
								"<span class='userdanger'>[user] is trying to put handcuffs on [C]!</span>")
			if(do_mob(user, C, 30))
				if(C.handcuffed)
					return
				C.handcuffed = new /obj/item/weapon/handcuffs(C)
				C.update_inv_handcuffed(0)
		else
			C.visible_message("<span class='danger'>[user] tries to remove [C]'s handcuffs.</span>", \
							"<span class='notice'>[user] tries to remove [C]'s handcuffs.</span>")
			if(do_mob(user, C, 30))
				if(!C.handcuffed)
					return
				C.unEquip(C.handcuffed)