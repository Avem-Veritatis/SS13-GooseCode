/mob/living/carbon/human/ork/commando
	name = "Ork Kommando"
	icon = 'icons/mob/ork.dmi'
	caste = "h"
	maxHealth = 200
	health = 200
	storedwaagh = 150
	max_waagh = 150
	icon_state = "ork"
	base_icon_state = "ork"
	waagh_rate = 5


/mob/living/carbon/human/ork/commando/New()
	create_reagents(100)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	if(name == "ork commando")
		name = text("ork commando ([rand(1, 1000)])")
	real_name = name
	verbs.Add(/mob/living/carbon/human/ork/commando/verb/waagh,/mob/living/carbon/human/ork/commando/verb/komscav)
	..()

/mob/living/carbon/human/ork/commando/handle_regular_hud_updates()
	..() //-Yvarov

	if (healths)
		if (stat != 2)
			switch(health)
				if(150 to INFINITY)
					healths.icon_state = "health0"
				if(100 to 150)
					healths.icon_state = "health1"
				if(50 to 100)
					healths.icon_state = "health2"
				if(25 to 50)
					healths.icon_state = "health3"
				if(0 to 25)
					healths.icon_state = "health4"
				else
					healths.icon_state = "health5"
		else
			healths.icon_state = "health6"


/mob/living/carbon/human/ork/commando/handle_environment()
	if(m_intent == "run" || resting)
		..()
	else
		adjustToxLoss(-heal_rate)

/mob/living/carbon/human/ork/commando/movement_delay()
	. = -0.5		//hunters are sanic
	. += ..()	//but they still need to slow down on stun
