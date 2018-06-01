
/*
Imperial Guard
*/
/mob/living/carbon/human/kriegofficer
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"

/mob/living/carbon/human/kriegofficer/New()
	..()
	sleep (5)
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/security, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/DKcoat/officer, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/DK, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/black, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/mask/gas/sechailer/DK, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/DKhelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/complexsword/DKsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen/double/DK, slot_r_store)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/hellpistol, slot_l_store)

	var/rndname = "Lieutenant #([rand(53000, 100000)])"

	name = "[rndname]"
	real_name = "[rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "dogtag"
	W.access = get_all_accesses()
	W.access += get_centcom_access("Captain")
	W.assignment = "Imperial Guard"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep (20)
	regenerate_icons()
