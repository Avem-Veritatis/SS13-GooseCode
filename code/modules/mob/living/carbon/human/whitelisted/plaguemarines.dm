
/*
Plague Marines
*/

/mob/living/carbon/human/whitelisted/pmleader
	name = "Lord Corpsus"
	real_name = "Lord Corpsus"
	universal_speak = 1
	gender = "male"
	maxHealth = 300
	health = 300
	status_flags = 0

/mob/living/carbon/human/whitelisted/pmleader/New()
	..()

	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/pmpowerarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/pm, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/pm, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/pmpowerhelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_belt)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/plague, slot_r_store)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/plague, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/pmback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/shotgun/combat/plague, slot_s_store)
	equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate, slot_wear_id)
	equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/pmbag/full, slot_r_hand)

	spawn(50)
		if(src.mind)
			ticker.mode.add_cultist(src.mind)
			src.mind.special_role = "Cultist"

	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/whitelisted/pmleader/Life()
	..()
	if(prob(1))
		var/chat = pick('sound/voice/plaguemarines.ogg','sound/voice/plaguemarines2.ogg', 'sound/voice/plaguemarines3.ogg')
		playsound(loc, chat, 75, 0)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(!stat)
			C.heal_organ_damage(2,2)												//plaguemarine regeneration
		if(C.reagents)
			C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			C.adjustToxLoss(-2)
			/*
			for(var/datum/reagent/R in C.reagents.reagent_list)
				C.reagents.clear_reagents()
			*/
	for(var/datum/disease/D in viruses)
		D.carrier = 1
	src.unknown_pain += 5

/mob/living/carbon/human/whitelisted/pm
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 300
	health = 300
	status_flags = 0

/mob/living/carbon/human/whitelisted/pm/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/pmpowerarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/pm, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/pm, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/pmpowerhelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_belt)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/plague, slot_r_store)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/plague, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/pmback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/shotgun/combat/plague, slot_s_store)
	equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate, slot_wear_id)
	equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/pmbag/full, slot_r_hand)

	spawn(50)
		if(src.mind)
			ticker.mode.add_cultist(src.mind)
			src.mind.special_role = "Cultist"

	var/namelist = list ("Nas", "Chod", "Keras", "Treg", "Lidacus", "Creasion", "Crasius", "Nabrus", "Soras", "Kylus", "Logren", "Crecep", "Meridian", "Davros", "Drusus", "Razal", "Ferox", "Nacret")
	var/rndname = pick(namelist)

	name = "Disciple [rndname]"
	real_name = "Disciple [rndname]"
	sleep(10)
	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/whitelisted/pm/Life()
	..()
	if(prob(1))
		if(stat != DEAD)
			var/chat = pick('sound/voice/plaguemarines.ogg','sound/voice/plaguemarines2.ogg', 'sound/voice/plaguemarines3.ogg')
			playsound(loc, chat, 75, 0)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(!stat)
			C.heal_organ_damage(2,2)												//plaguemarine regeneration
		if(C.reagents)
			C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			C.adjustToxLoss(-2)
			/*
			for(var/datum/reagent/R in C.reagents.reagent_list)
				C.reagents.clear_reagents()
			*/
	for(var/datum/disease/D in viruses)
		D.carrier = 1
	src.unknown_pain += 5

/obj/item/weapon/storage/backpack/pmbag/
	name = "Bag of heads"
	desc = "It's a bag that smells like death."
	icon_state = "nobbag"

/obj/item/weapon/storage/backpack/pmbag/full
	New()
		..()
		new /obj/item/cannonball/nurgleround( src )
		new /obj/item/cannonball/nurgleround( src )
		new /obj/item/cannonball/nurgleround( src )
		new /obj/item/cannonball/nurgleround( src )
		new /obj/item/cannonball/nurgleround( src )
		new /obj/item/cannonball/nurgleround( src )