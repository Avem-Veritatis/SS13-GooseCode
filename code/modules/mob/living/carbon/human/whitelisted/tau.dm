/mob/living/carbon/human/tau/leader
	name = "Shas'O Ves'ya"
	real_name = "Shas'O Ves'ya"
	universal_speak = 1
	gender = "male"
	factions = list("tau")

/mob/living/carbon/human/tau/leader/New()
	..()
	sleep (10)
	if (usr.key == "Mrmaster21")
		name = "Shas'El Shi"
		real_name = "Shas'El Shi"
	equip_to_slot_or_del(new /obj/item/device/radio/headset, slot_ears)
	spawn(10)
		var/loadout = input("Select a loadout.","Loadout Selection") as null|anything in list("Fire Warrior", "XV25 Stealth Suit", "XV15 Stealth Suit", "Water Caste Merchant", "Water Caste Diplomat")
		switch(loadout)
			if("Fire Warrior")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/fwarmor, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/fwhelmet, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/fwboots, slot_shoes)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tpc, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/under/taum, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/material, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/plasma/lesser, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "shas"
				W.assignment = "Tau Fire Warrior"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("XV25 Stealth Suit")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/tausuit/XV25, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/tausuit/XV25, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/fwboots, slot_shoes)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/tau/fusionblaster, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/under/taum, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/plasma/lesser, slot_r_store)
				equip_to_slot_or_del(new /obj/item/device/tau/drone/controller, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/tau/drone/gun, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "shas"
				W.assignment = "Tau Fire Warrior"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("XV15 Stealth Suit")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/tausuit/XV15, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/tausuit/XV15, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/fwboots, slot_shoes)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/burstcannon, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/clothing/under/taum, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)
				equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/plasma/lesser, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/photon, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/firecaste/W = new
				W.icon_state = "shas"
				W.assignment = "Tau Fire Warrior"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("Water Caste Merchant")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/head/tau/watercasteold, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/under/tau/watercasteold, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/device/tau/drone/controller, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/tau/drone/gun, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_s_store)
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "por"
				W.assignment = "Tau Merchant"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
			if("Water Caste Diplomat")
				var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
				R.set_frequency(1341)
				equip_to_slot_or_del(R, slot_ears)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/head/tau/watercaste, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/under/tau/watercaste, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/device/tau/drone/controller, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/tau/drone/gun, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, slot_r_hand)
				var/obj/item/weapon/card/id/tau/watercaste/W = new
				W.icon_state = "por"
				W.assignment = "Tau Diplomat"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
		regenerate_icons()