/obj/item/clothing/gloves/lordinquisitor  //gloves
	desc = "A fine upgrade to the human form. Insulated, unbreakable, it opens up the biotics tab for you. Look in the upper right hand corner."
	name = "Synthetic Arm"
	icon_state = "s-ninjan"
	item_state = "lioxarm"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	var/can_toggle = 1
	var/is_toggled = 1
	siemens_coefficient = 0
	permeability_coefficient = 0.05

	verb/togglescience()
		set name = "FOR SCIENCE!"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "You want to cheer the joys of science but... you can't!"
			return
		else
			var/science = pick('sound/voice/science1.ogg','sound/voice/science2.ogg','sound/voice/science3.ogg','sound/voice/science4.ogg')
			playsound(loc, science, 75, 0)
			usr.visible_message("<span class='warning'>[usr] reminds you about the importance of science.</span>", "<span class='notice'>You remind everyone about the importance of science!.</span>", "<span class='warning>Some jackass is ranting about science.</span>")
			can_toggle = 0
			sleep 80
			can_toggle = 1

	verb/toggletele()
		set name = "Toggle Teleportation Uplink"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This item cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/hand_tele/nd)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'>[usr] inserts the teleportation device back into his robotic arm.</span>", "<span class='notice'>You put the teleporter away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/hand_tele/nd)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>[usr] inserts the teleportation device back into his robotic arm.</span>", "<span class='notice'>You put the teleporter away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			src.is_toggled = 1
		else
			usr << "You pull out your teleportation device."
			usr.put_in_hands(new /obj/item/weapon/hand_tele/nd(usr))
			src.is_toggled = 2



