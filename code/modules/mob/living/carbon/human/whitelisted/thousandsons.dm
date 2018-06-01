
/*
Thousand Sons
*/

/mob/living/carbon/human/whitelisted/ksons/leader
	name = "Archeron the Eternal"
	real_name = "Archeron the Eternal"
	universal_speak = 1
	gender = "male"
	status_flags = 0

/mob/living/carbon/human/whitelisted/ksons
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 250
	health = 250
	status_flags = 0

/mob/living/carbon/human/whitelisted/ksons/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/thousandarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/ksons, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ksons, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/ksonshelmet, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword/ksons_chainsword, slot_belt)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
	equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/ksons, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter/chaos/ksons, slot_s_store)
	equip_to_slot_or_del(new /obj/item/weapon/shield/riot/ksons, slot_l_hand)
	verbs += /mob/living/carbon/human/whitelisted/proc/ksonspell

	var/namelist = list ("Si'ryon", "Azugar", "Ereraz", "Elatoth", "Caorpudaran", "Guralock", "Jirah", "Furrulak", "Lostix", "Honnux", "Guragar", "Furfar", "Zydire", "Nazustix", "Buldaban", "Davrhaz", "Nazuphus", "Madaran")
	var/rndname = pick(namelist)

	name = "[rndname] the Enlightened"
	real_name = "[rndname] the Enlightened"
	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/whitelisted/ksons/Life()
	..()
	var/mob/living/carbon/C = src
	if(iscarbon(src))
		C.handcuffed = initial(C.handcuffed)
		if(!stat)
			C.heal_organ_damage(1,1)

	for(var/datum/reagent/R in C.reagents.reagent_list)
		C.reagents.clear_reagents()



/mob/living/carbon/human/whitelisted/ksons/death(gibbed)
	mind.spell_list = list()
	verbs.Remove(/mob/living/carbon/human/whitelisted/proc/ksonspell)
	..()

/*
Spell verb
*/

/mob/living/carbon/human/whitelisted/proc/ksonspell()
	set category = "Spells"
	set name = "Recieve the gifts of Tzeentch"
	set desc = "This will give you spells"
	//set src in usr
	mind.spell_list += new /obj/effect/proc_holder/spell/aoe_turf/knock(null)
	mind.spell_list += new /obj/effect/proc_holder/spell/aoe_turf/conjure/floor(null)
	mind.spell_list += new /obj/effect/proc_holder/spell/aoe_turf/conjure/lesserforcewall(null)
	mind.spell_list += new /obj/effect/proc_holder/spell/dumbfire/fireball(null)
	verbs -= /mob/living/carbon/human/whitelisted/proc/ksonspell