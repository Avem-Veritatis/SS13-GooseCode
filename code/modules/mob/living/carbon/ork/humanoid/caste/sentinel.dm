/mob/living/carbon/human/ork/nob
	name = "Ork Nob"
	icon = 'icons/mob/ork.dmi'
	caste = "s"
	maxHealth = 350
	health = 350
	storedwaagh = 150
	max_waagh = 150
	icon_state = "ork"
	waagh_rate = 10
	base_icon_state = "ork"


/mob/living/carbon/human/ork/nob/New()
	create_reagents(100)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	if(name == "ork nob")
		name = text("ork nob ([rand(1, 1000)])")
	real_name = name
	verbs.Add(/mob/living/carbon/human/ork/nob/verb/waagh, /mob/living/carbon/human/ork/nob/verb/nobscav)
	..()

/mob/living/carbon/human/ork/nob/handle_regular_hud_updates()
	..() //-Yvarov

	if (healths)
		if (stat != 2)
			switch(health)
				if(125 to INFINITY)
					healths.icon_state = "health0"
				if(100 to 125)
					healths.icon_state = "health1"
				if(75 to 100)
					healths.icon_state = "health2"
				if(25 to 75)
					healths.icon_state = "health3"
				if(0 to 25)
					healths.icon_state = "health4"
				else
					healths.icon_state = "health5"
		else
			healths.icon_state = "health6"

/mob/living/carbon/human/ork/nob/movement_delay()
	. = ..()
	. += 1