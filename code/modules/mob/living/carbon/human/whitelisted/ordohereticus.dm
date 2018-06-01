
/*
Ordo Hereticus
*/

/mob/living/carbon/human/OHstormtrooper
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	factions = list("imperium")

/mob/living/carbon/human/OHstormtrooper/New()
	..()
	sleep (5)
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	spawn(20)
		var/weaponchoice = input("Loadout.","Select a Loadout") as null|anything in list("StormTrooper", "Body Guard", "Grenadier")
		switch(weaponchoice)
			if("StormTrooper")
				equip_to_slot_or_del(new /obj/item/clothing/under/stormtroop, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/DK, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/black, slot_gloves)
				var/obj/item/weapon/card/id/ordohereticus/W = new
				W.access = get_all_accesses()
				W.access += get_centcom_access("Inquisitor")
				W.assignment = "StormTrooper"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(20)
				regenerate_icons()
				rename_self("[name]")
			if("Body Guard")
				equip_to_slot_or_del(new /obj/item/clothing/under/stormtroop, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/DK, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/black, slot_gloves)
				equip_to_slot_or_del(new /obj/item/clothing/suit/armor/bodyguard, slot_wear_suit)
				equip_to_slot_or_del(new /obj/item/clothing/head/bodyguard, slot_head)
				var/obj/item/weapon/card/id/ordohereticus/W = new
				W.access = get_all_accesses()
				W.access += get_centcom_access("Inquisitor")
				W.assignment = "Body Guard"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(20)
				regenerate_icons()
				rename_self("[name]")
			if("Grenadier")
				equip_to_slot_or_del(new /obj/item/clothing/under/stormtroop, slot_w_uniform)
				equip_to_slot_or_del(new /obj/item/clothing/shoes/DK, slot_shoes)
				equip_to_slot_or_del(new /obj/item/clothing/gloves/black, slot_gloves)
				var/obj/item/weapon/card/id/ordohereticus/W = new
				W.access = get_all_accesses()
				W.access += get_centcom_access("Inquisitor")
				W.assignment = "Grenadier"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(20)
				regenerate_icons()
				rename_self("[name]")

/mob/living/carbon/human/OHstormtrooper/leader/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/stormtroop, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/DK, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/black, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/mask/gas/stormtroop, slot_wear_mask)
	var/obj/item/weapon/card/id/ordohereticus/W = new
	W.access = get_all_accesses()
	W.access += get_centcom_access("Inquisitor")
	W.assignment = "StormTrooper (Captin)"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()
	rename_self("[name]")

/mob/living/carbon/human/OHinq
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	faction = "Inquisitor"

/mob/living/carbon/human/OHinq/leader

/mob/living/carbon/human/OHinq/New()
	..()
	sleep (5)
	verbs += /mob/living/carbon/human/proc/ohshuttle
	equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/inq, slot_back)
	equip_to_slot_or_del(new /obj/item/clothing/under/inq, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/inq, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/head/inqhat, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/laspistol2, slot_s_store)
	equip_to_slot_or_del(new /obj/item/device/pda/lawyer, slot_in_backpack)
	equip_to_slot_or_del(new /obj/item/weapon/powersword/pknife, slot_belt)
	equip_to_slot_or_del(new /obj/item/device/hdetector, slot_in_backpack)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/combat/inquisitor, slot_gloves)

	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)

	var/obj/item/weapon/card/id/ordohereticus/W = new
	W.access = get_all_accesses()
	W.access += get_centcom_access("Inquisitor")
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()
	rename_self("[name]")

/*
Shuttle verb
*/

/mob/living/carbon/human/proc/ohshuttle()
	set category = "Ordo Hereticus"
	set name = "Move ship"
	set desc = "Like an obediant dog... your ship comes on command."
	//set src in usr
	var/mob/living/carbon/human/U = src
	if(!ishuman(src))
		usr << text("<span class='notice'>Wait.. what are you?.</span>")
		return
	if(U.stat == DEAD)
		U <<"Pffft! Your dead! They aren't sending a ship for a dead man."							//user is dead
		return
	if(!U.canmove || U.stat || U.restrained())
		U.say("Must... reach... implant...")	//user is tied up
		return
	if(U.brainloss >= 60)
		U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//user is stupid
		U.visible_message(text("<span class='alert'>[U] stares blankly.</span>"))
		U << text("<span class='notice'>Your head feels funny.")
		U << text("<span class='notice'>Oh crap. You need to call an adult!")
		U.say("HERESY!")
		return
	else
		U.visible_message(text("<span class='alert'>[U] activates a tiny wrist mounted control panel. Implants are so useful!</span>"))
		var/datum/shuttle_manager/s = shuttles["stargazer"]
		if(istype(s)) s.move_shuttle(0,1)
		return
