/mob/living/carbon/human/ork/warboss
	name = "ork warboss"
	icon = 'icons/mob/ork.dmi'
	caste = "q"
	maxHealth = 250
	health = 250
	icon_state = "ork2"
	status_flags = CANPARALYSE
	storedwaagh = 500
	max_waagh = 500
	heal_rate = 5
	waagh_rate = 20
	ventcrawler = 0 //pull over that ass too fat

/mob/living/carbon/human/ork/warboss/leader

/mob/living/carbon/human/ork/warboss/New()
	create_reagents(100)
	spawn(1200)
		src << "\red You start to grow!"
		src.reagents.add_reagent("growth2", 1)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/taperoll, slot_r_hand) //I'm just gonna stuff this in here. He needs this.
	//there should only be one warboss
	playsound(loc, 'sound/voice/warboss.ogg', 75, 0)
	for(var/mob/living/carbon/human/ork/warboss/Q in living_mob_list)
		if(Q == src)		continue
		if(Q.stat == DEAD)	continue
		if(Q.client)
			name = "ork nob ([rand(1, 999)])"
			break

	real_name = src.name
	verbs.Add(/mob/living/carbon/human/ork/warboss/verb/waagh,/mob/living/carbon/human/ork/warboss/verb/seeds)
	rename_self("Warboss")
	..()

/mob/living/carbon/human/ork/warboss/handle_regular_hud_updates()
	..() //-Yvarov //Who? -Norc //When? -Drake

	if (src.healths)
		if (src.stat != 2)
			switch(health)
				if(250 to INFINITY)
					src.healths.icon_state = "health0"
				if(175 to 250)
					src.healths.icon_state = "health1"
				if(100 to 175)
					src.healths.icon_state = "health2"
				if(50 to 100)
					src.healths.icon_state = "health3"
				if(0 to 50)
					src.healths.icon_state = "health4"
				else
					src.healths.icon_state = "health5"
		else
			src.healths.icon_state = "health6"

//warboss verbs
/mob/living/carbon/human/ork/warboss/verb/seeds()

	set name = "Distribute Spores (250)" //Given that every gretchin is now potentially going to get a player eventually, worth raising the price.
	set desc = "Throw all this stuff on da ground!."
	set category = "ork"

	if(locate(/obj/structure/human/ork/bush) in get_turf(src))
		src << "Theres already stuff here!."
		return

	if(powerc(250,1))//Can't plant eggs on spess tiles. That's silly.
		adjustToxLoss(-250)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>[src] is mad and he is throwing STUFF ON DA GROUND!</B>"), 1)
		new /obj/structure/human/ork/bush(loc)
	return


/mob/living/carbon/human/ork/warboss/large
	icon = 'icons/mob/ork.dmi'
	icon_state = "ork_boyz"
	pixel_x = -16

/mob/living/carbon/human/ork/warboss/large/update_icons()
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	if(stat == DEAD)
		icon_state = "ork_boyz"
	else if(stat == UNCONSCIOUS || lying || resting)
		icon_state = "ork_boyz"
	else
		icon_state = "ork_boyz"
