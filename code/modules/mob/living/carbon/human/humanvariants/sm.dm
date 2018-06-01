/mob/living/carbon/human/whitelisted/sm
	name = "Unknown"
	real_name = "Unknown"
	suicide_allowed = 0
	universal_speak = 1
	gender = "male"
	status_flags = 0

/mob/living/carbon/human/whitelisted/sm/New()
	..()
	sleep (5)
	immunetofire = 1
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spowerarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/sm, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/sm, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/security/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/smpowerhelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/smback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_r_hand)
	equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)

	var/namelist = list ("Roman", "Tias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Brother [rndname]"
	real_name = "Brother [rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "smcard"
	W.access = get_all_accesses()
	W.access += get_centcom_access("UltraMarine")
	W.assignment = "salamander marine"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()

/mob/living/carbon/human/whitelisted/sm/adjustFireLoss(var/amount)
	return

