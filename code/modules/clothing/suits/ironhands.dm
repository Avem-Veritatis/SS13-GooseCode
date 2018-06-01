/*
Some iron hands stuff.
For necron rounds perhaps.
This will let a new space marine chapter be showcased (and subsequently decimated by necrons probably)
*/

/obj/item/clothing/shoes/magboots/ironhands
	desc = "Boots for a space marine."
	name = "Marine Boots"
	icon_state = "ihboots"
	magboot_state = "ihboots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/weapon/tank/oxygen/ironhands
	name = "Iron Hands Marine Power Unit"
	desc = "The back unit containing oxygen and power storage for a suit of Iron Hands space marine suit."
	icon_state = "ihback"
	item_state = "ihback"
	volume = 2000
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/clothing/head/helmet/ironhands
	name = "Iron Marine Helmet"
	desc = "Helm of an Iron Hands Marine"
	icon_state = "ihhelmet"
	item_state = "ihhelmet"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR||!CANSTUN|!CANWEAKEN
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/suit/armor/ironhands
	name = "Iron Hands Power Armor"
	desc = "Extremely thick, powered armor for the Iron Hands Space Marine Chapter."
	icon_state = "ironhand"
	item_state = "ironhand"
	w_class = 4//bulky item
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/gun/projectile/automatic/bolter)
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)

/obj/item/clothing/suit/armor/ironhands/apothecary
	icon_state = "ironhandapoth"

/obj/item/clothing/suit/armor/ironhands/techmarine
	icon_state = "ironhandtech"

/obj/item/clothing/gloves/ironhands
	desc = "You could say that these are iron hands..."
	name = "Iron Hands Marine Gloves"
	icon_state = "ihgloves"
	item_state = "ihgloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/mob/living/carbon/human/whitelisted/ironhand
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	health = 250
	status_flags = 0

/mob/living/carbon/human/whitelisted/ironhand/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/ironhands, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ironhands, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/ironhands, slot_head)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)

/mob/living/carbon/human/whitelisted/ironhand/Life()
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

/mob/living/carbon/human/whitelisted/ironhand/regular/New()
	..()
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/ironhands, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/ironhands, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword/generic_chainsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)

	var/namelist = list ("Roman", "Tias", "Tiberias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Brother [rndname]"
	real_name = "Brother [rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "smcard"
	W.access = get_all_accesses()
	W.access += get_centcom_access("UltraMarine")
	W.assignment = "Iron Hands Marine"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/whitelisted/ironhand/apothecary/New()
	..()
	equip_to_slot_or_del(new /obj/item/clothing/under/surgerycybernetic, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/ironhands/apothecary, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/ironhands, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/storage/belt/medical/apothecary, slot_belt)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night, slot_glasses)

	var/namelist = list ("Roman", "Tias", "Tiberias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Apothecary [rndname]"
	real_name = "Apothecary [rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "smcard"
	W.access = get_all_accesses()
	W.access += get_centcom_access("UltraMarine")
	W.assignment = "Iron Hands Apothecary"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/whitelisted/ironhand/techmarine/New()
	..()
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/ironhands/techmarine, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/mechaclamp, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/full, slot_belt)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)

	var/namelist = list ("Roman", "Tias", "Tiberias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Iron Father [rndname]"
	real_name = "Iron Father [rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "smcard"
	W.access = get_all_accesses()
	W.access += get_centcom_access("UltraMarine")
	W.assignment = "Iron Father Marine"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()
	rename_self("[name]")