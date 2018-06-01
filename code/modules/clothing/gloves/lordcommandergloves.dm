/obj/item/clothing/gloves/lordcommander  //gloves
	desc = "A set of bionic implants that only a noble could afford."
	name = "Digital Wristband"
	icon_state = "s-ninjan"
	item_state = "s-ninjan"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	var/can_toggle = 1
	var/is_toggled = 1
	var/beaconactive = 0
	siemens_coefficient = 0
	permeability_coefficient = 0.05

	verb/togglegun()
		set name = "Toggle Biotic Gun"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This weapon cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/gun/energy/plasma/LCBionicGun)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'>With a snap of metal against metal, [usr] reforms his wrist mounted plasma gun into his arm.</span>", "<span class='notice'>You retract your bionic gun.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/gun/energy/plasma/LCBionicGun)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>With a snap of metal against metal, [usr] reforms his wrist mounted plasma gun into his arm.</span>", "<span class='notice'>You retract your bionic gun.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You lower your gun."
			src.is_toggled = 1
		else
			src.icon_state += "_open"
			usr << "You ready your gun."
			usr.put_in_hands(new /obj/item/weapon/gun/energy/plasma/LCBionicGun(usr))
			src.is_toggled = 2

	verb/toggleshield()
		set name = "Toggle Defensive Shield"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This item cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/shield/energy)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'>With a hum of energy, [usr]'s shield folds neatly back into his arm.</span>", "<span class='notice'>You put the shield away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/shield/energy)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>With a hum of energy, [usr]'s shield folds neatly back into his arm.</span>", "<span class='notice'>You put the shield away.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You lower your gun."
			src.is_toggled = 1
		else
			src.icon_state += "_open"
			usr << "You pull out your energy shield and get ready to activate it."
			usr.put_in_hands(new /obj/item/weapon/shield/energy(usr))
			src.is_toggled = 2

	verb/destresscall()
		set name = "Activate Distress Beacon"
		set category = "Biotics"
		if(usr.stat)
			usr << "Aren't you dead though? Or are you just unconscious? Alright... you dream of pushing the button. It is a nice dream."
			return
		if(beaconactive)
			usr << "The beacon is already active. Are you trying to turn it off? I think you'll need a cybernetica for that. The interface on this thing is not very user friendly."
			return
		if(!beaconactive)
			usr.visible_message("<span class='warning'>[usr] opens a glowing panel on the [name] and pauses in thought.</span>", "<span class='notice'>This will signal will broadcast to every relay station in the system.</span>", "<span class='warning>You hear a buzzing sound.</span>")
			if(alert("Activate distress beacon?",,"Yes","No")=="No")
				return

			beaconactive = 1
			usr.visible_message("<span class='warning'>[usr] pushes a button on the [name] and closes it.</span>", "<span class='notice'>Signal sent. Relay stations all over the system will spread the signal.</span>", "<span class='warning>You hear a tap.</span>")
			availfaction += "KRIEGOFFICERS"
			radarintercept("<font color='red'>This is General [usr.name], Commander of the 89th detachment on ArchAngel IV to all Imperial assets. We need reinforcements down here! Send everything you've got!</font'>")
			award(usr, "Send me everyone. EV-RY-ONE!!!!")
			for(var/mob/dead/G in world)
				G << "\red \b Distress Signal Sent. Krieg Officers now available to deploy."