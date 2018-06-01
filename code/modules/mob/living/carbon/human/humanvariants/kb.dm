/mob/living/carbon/human/kb
	name = "Khorne Berseker"
	real_name = "Khorne Berseker"
	universal_speak = 1
	gender = "male"
	maxHealth = 250
	health = 250
	status_flags = 0

/mob/living/carbon/human/kb/New()
	..()
	sleep (5)
	var/radio_freq = SYND_FREQ
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/syndicate
	R.set_frequency(radio_freq)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/syndicate, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/KBpowerarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/kb, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/KBpowerhelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword/chainaxe2, slot_belt)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/KBback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter/chaos, slot_s_store)
	equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate, slot_wear_id)

	factions += "syndicate"

	sleep (20)
	regenerate_icons()

/mob/living/carbon/human/kb/Life()
	..()
	if(prob(5))
		if(stat != DEAD)
			var/chat = pick('sound/weapons/KBkillsthemall.ogg', 'sound/weapons/KBblood.ogg', 'sound/weapons/KBdeath.ogg', 'sound/weapons/KBlaugh.ogg', 'sound/weapons/KBmoan.ogg', 'sound/weapons/KBwantsyablood.ogg', 'sound/weapons/KByes.ogg', 'sound/weapons/KByesyes.ogg')
			playsound(loc, chat, 75, 0)
