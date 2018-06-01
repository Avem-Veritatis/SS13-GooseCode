
/*
UltraMarines
*/

/mob/living/carbon/human/whitelisted/um/leader
	name = "Sergeant Tiberius"
	real_name = "Sergeant Tiberius"
	universal_speak = 1
	gender = "male"
	health = 250
	status_flags = 0
	factions = list("imperium")

/mob/living/carbon/human/whitelisted/um/leader/New()
	..()

	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	qdel(src.wear_suit) //Get rid of normal marine armor for this to even work.
	qdel(src.shoes)
	qdel(src.head)
	qdel(src.belt)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor/captain, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um/captain, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/um, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/captain, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/powersword/umpsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/umback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/sbolter, slot_r_hand)
	equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)



/mob/living/carbon/human/whitelisted/um/leader/CanPass(atom/A, mob/target)
	if(istype(A) && A.pass_flags == PASSULTRA)
		return 1
	if(istype(src) && src.density == 0)
		return prob(99)
	else
		return prob(2)

/mob/living/carbon/human/whitelisted/um/leader/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(C.reagents)
			for(var/datum/reagent/R in C.reagents.reagent_list)
				//C.reagents.clear_reagents()
				C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
				C.adjustToxLoss(-2)
	for(var/datum/disease/D in viruses)
		D.cure(0)


/mob/living/carbon/human/whitelisted/um
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 250
	health = 250
	status_flags = 0
	factions = list("imperium")//new

/mob/living/carbon/human/whitelisted/um/CanPass(atom/A, mob/target)
	if(istype(A) && A.pass_flags == PASSULTRA)
		return 1
	if(istype(src) && src.density == 0)
		return prob(99)
	else
		return prob(2)

/mob/living/carbon/human/whitelisted/um/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	var/namelist = list ("Roman", "Tias", "Tiberias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Brother [rndname]"
	real_name = "Brother [rndname]"

	spawn(20)
		var/weaponchoice = input("Loadout.","Select a Loadout") as null|anything in list("Apothecary", "Techmarine", "Tactical")
		switch(weaponchoice)
			if("Apothecary")
				equip_to_slot_or_del(new /obj/item/clothing/under/surgerycybernetic, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor/apoth, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/um, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/apoth, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword/ultramarine_chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/umback, slot_back)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "umcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "UltraMarine Apothecary"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")
			if("Techmarine")
				equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor/tech, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/um, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/tech, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword/ultramarine_chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/industrial, slot_back)
				equip_to_slot_or_del(new /obj/item/aluminumtube4/clamp, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/mask/gas/TRAP, slot_wear_mask)
				new /obj/item/weapon/snowshovel/ig970 (loc)
				maxHealth = 175
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "umcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "UltraMarine Techmarine"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")
			if("Tactical")
				equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/um, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword/ultramarine_chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/umback, slot_back)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "umcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "Tactical UltraMarine"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")

/mob/living/carbon/human/whitelisted/um/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(C.reagents)
			C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			C.adjustToxLoss(-2)
			/*
			for(var/datum/reagent/R in C.reagents.reagent_list)
				C.reagents.clear_reagents()
			*/
	for(var/datum/disease/D in viruses)
		if(!istype(D, /datum/disease/plague)) //...this one can infect marines.
			D.cure(0)