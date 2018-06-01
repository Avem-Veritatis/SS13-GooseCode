/mob/living/carbon/human/valhallan
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	factions = list("imperium")

/mob/living/carbon/human/valhallan/New()
	..()
	sleep (5)
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/security, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/valhalla, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/imperialboots/reinforced, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/combat, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/mask/gas/sechailer, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/valhalla, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen/engi, slot_belt)
	equip_to_slot_or_del(new /obj/item/weapon/shield/riot/imperial, slot_r_hand)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/autogun2, slot_l_hand)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/imperial, slot_r_store)
	equip_to_slot_or_del(new /obj/item/weapon/grenade/krak, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/complexsword/IGsword, slot_back)

	var/rndname = "#([rand(53000, 100000)])"

	name = "[rndname]"
	real_name = "[rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "dogtag"
	W.access = list(access_security, access_sec_doors, access_brig, access_court, access_maint_tunnels, access_morgue)
	W.access += get_centcom_access("Captain")
	W.assignment = "Imperial Guard"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep (20)
	regenerate_icons()
