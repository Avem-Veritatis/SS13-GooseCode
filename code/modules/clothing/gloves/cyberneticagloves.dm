/obj/item/clothing/gloves/cybernetica  //gloves
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

	verb/toggleUSBdevice()
		set name = "Toggle USB Device"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This item cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/USBinterface)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'>[usr] pauses for a moment and allows the robotic arm to reform itself.</span>", "<span class='notice'>You put the USB device away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/USBinterface)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>[usr] pauses for a moment and allows the robotic arm to reform itself.</span>", "<span class='notice'>You put the USB device away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			src.is_toggled = 1
		else
			usr << "You pull out your USB device."
			usr.put_in_hands(new /obj/item/weapon/USBinterface(usr))
			src.is_toggled = 2



