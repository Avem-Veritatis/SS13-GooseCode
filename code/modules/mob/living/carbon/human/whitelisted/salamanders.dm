/*
Salamanders
*/

/mob/living/carbon/human/whitelisted/sm/leader
	universal_speak = 1
	gender = "male"
	status_flags = 0

/mob/living/carbon/human/whitelisted/sm/leader/New()
	..()
	qdel(src.wear_suit) //Get rid of normal marine armor for this to even work.
	qdel(src.head)
	qdel(src.gloves)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spowerarmor/captain, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/sm, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/sm/captain, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/smpowerhelmet/captain, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/smback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/twohanded/mjollnir/samander, slot_r_hand)
	equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
	regenerate_icons()

/mob/living/carbon/human/whitelisted/sm/leader/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		base_icon_state = "salamander_m"
		icon_state = "salamander_m_s"
		C.handcuffed = initial(C.handcuffed)
		if(C.reagents)
			for(var/datum/reagent/R in C.reagents.reagent_list)
				//C.reagents.clear_reagents()
				C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2) //Lets healing chems help marines, and the most potent of poisons to still impact them.
				C.adjustToxLoss(-2)
	for(var/datum/disease/D in viruses)
		D.cure(0)


/mob/living/carbon/human/whitelisted/sm
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 250
	health = 250
	status_flags = 0
	factions = list("imperium")//new

/mob/living/carbon/human/whitelisted/sm/New()
	..()
	immunetofire = 1
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
				equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/smback, slot_back)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spowerarmor/apoth, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/sm, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/sm, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/apoth, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "smcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "Salamander Apothecary"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")
			if("Techmarine")
				equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/industrial, slot_back)
				equip_to_slot_or_del(new /obj/item/aluminumtube4/clamp, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/mask/gas/TRAP, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spowerarmor/tech, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/sm, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/sm, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/tech, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				new /obj/item/weapon/snowshovel/ig970 (loc)
				maxHealth = 175
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "smcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "Salamander Techmarine"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")
			if("Tactical")
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/smback, slot_back)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spowerarmor, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/sm, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/sm, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/smpowerhelmet, slot_head)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "smcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "Salamander Tactical Marine"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")

/mob/living/carbon/human/whitelisted/sm/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		base_icon_state = "salamander_m"
		icon_state = "salamander_m_s"
		if(C.reagents)
			C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			C.adjustToxLoss(-2)
	for(var/datum/disease/D in viruses)
		if(!istype(D, /datum/disease/plague)) //...this one can infect marines.
			D.cure(0)

/mob/living/carbon/human/whitelisted/sm/adjustFireLoss(var/amount)
	return
