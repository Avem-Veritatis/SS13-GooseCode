/obj/item/clothing/suit/armor/sister/hosp
	name = "Sister Hospitaller Armored Robes"
	desc = "The robes of a sister hospitaller, well armored and fitted high tech medical equipment."
	icon_state = "hospitaller"
	item_state = "hospitaller"
	blood_overlay_type = "armor"
	flags = STOPSPRESSUREDMAGE | THICKMATERIAL | NODROP
	body_parts_covered = CHEST|ARMS|GROIN
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)
	var/usetime = 0

	verb/useheal()
		set name = "Adalent injector (Treat Wounds)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/userescue()
		set name = "Naproxen injector (Triage Patient)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/usecombat()
		set name = "Bumetanide injector (Combat Stim)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/usepacify()
		set name = "Glorious Cocktail (Pacify Patient)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			usetime = world.time


/obj/item/clothing/suit/bio_suit/medicus
	name = "medicus suit"
	desc = "It protects you against splashing blood. You'll see a lot of that in this proffession."
	icon_state = "plaguedoctor2"
	item_state = "plaguedoctor"
	var/usetime = 0
	flags = NODROP

	verb/useheal()
		set name = "Adalent injector (Treat Wounds)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/heal(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/userescue()
		set name = "Naproxen injector (Triage Patient)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/rescue(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/usecombat()
		set name = "Bumetanide injector (Combat Stim)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/comcom(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/usepacify()
		set name = "Glorious Cocktail (Pacify Patient)"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "This injector is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/pacification(usr))
				usr.update_inv_hands()
			usetime = world.time

/obj/item/clothing/mask/gas/medicus
	name = "Medicus HUD"
	desc = "An advanced medical mask designed to provide biotic functionality and viral protection."
	icon_state = "death"
	item_state = "medicusmask"
	can_flip = null
