/mob/living/carbon/human/sob
	name = "Unknown"
	real_name = "Unknown"
	suicide_allowed = 0
	universal_speak = 1
	gender = "female"
	hair_color = "fff"
	hair_style = "Bobcurl"
	facial_hair_style = "Shaved"
	facial_hair_color = "fff"
	factions = list("imperium")//new
	var/rezticker = 0

/mob/living/carbon/human/sob/New()
	..()
	sleep (5)
	immunetofire = 1
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/sister, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/sister, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/sister, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/security/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sister, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/book/manual/astartes, slot_l_hand)
	spawn(35)
		var/weaponchoice = input("Loadout.","Select a Loadout") as null|anything in list("Retributor", "Seraphim", "Battle Sister")
		switch(weaponchoice)
			if("Retributor")
				equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/sister, slot_back)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_s_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/bpistolmag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/bpistolmag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
				if(prob(5))
					equip_to_slot_or_del(new /obj/item/weapon/twohanded/required/multimelta, slot_r_hand)
				else
					equip_to_slot_or_del(new /obj/item/weapon/twohanded/required/hflamer, slot_r_hand)
			if("Seraphim")
				equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/jump/sob, slot_back)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_r_hand)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol, slot_s_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_r_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/storage/belt/imperialbelt/sob, slot_belt)
			if("Battle Sister")
				equip_to_slot_or_del(new /obj/item/weapon/chainsword, slot_belt)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/sister, slot_back)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/grenade/chem_grenade/incendiary, slot_in_backpack)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/flamer, slot_r_hand)

	var/namelist = list ("Tina", "Debra", "Julia", "Cassandra", "Elisa", "Verona", "Sandra", "Vera", "Drasa", "Tammara", "Lidia", "Chandra", "Samantha", "Claria", "Romania", "Sitrina", "Silena")
	var/rndname = pick(namelist)

	name = "Sister [rndname]"
	real_name = "Sister [rndname]"
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "orange"
	W.access = get_all_accesses()
	W.access += get_centcom_access("Special Ops Officer")
	W.assignment = "sister"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	sleep (20)
	rename_self("[name]")
	regenerate_icons()

/mob/living/carbon/human/sob/Life()
	..()
	if(prob(1))
		if(stat != DEAD)
			var/chat = pick('sound/voice/sob1.ogg','sound/voice/sob2.ogg', 'sound/voice/sob3.ogg', 'sound/voice/sob4.ogg')
			playsound(loc, chat, 75, 0)

/mob/living/carbon/human/sob/adjustFireLoss(var/amount)
	return

/*
Prioress
*/

/mob/living/carbon/human/sob/cannoness

/mob/living/carbon/human/sob/cannoness/New()
	..()
	equip_to_slot_or_del(new /obj/item/weapon/gun/energy/inferno, slot_in_backpack)

/mob/living/carbon/human/sob/cannoness/Life()
	..()
	if(prob(1))
		var/chat = pick('sound/voice/sobshout1.ogg','sound/voice/sobshout2.ogg')
		playsound(loc, chat, 75, 0)

/*
on death
*/

/mob/living/carbon/human/sob/death(gibbed)
	if(!gibbed)
		if(!rezticker)
			spawn(0)
				lastchance(src.client)
	..()

/mob/living/carbon/human/sob/proc/lastchance(var/client/C)
	if(!C)	return
	rezticker = 1
	var/response = alert(C, "You get a single 20 second revive. Just click here.", "Pray to the Emperor", "Do it!", "I'll pass")
	if(response == "Do it!")
		roar(src)
	if(response == "I'll pass")
	else
		return

/mob/living/carbon/human/sob/proc/roar()
	var/mob/living/carbon/human/P = src
	revive(P)
	for(var/datum/reagent/R in P.reagents.reagent_list)
		P.reagents.clear_reagents()
	P.maxHealth = 5000
	P.health = 5000
	P.status_flags = 0
	for(var/obj/item/clothing/head/helmet/sister/H in P.contents)
		qdel(H)
	for(var/obj/item/clothing/glasses/hud/security/night/H in P.contents)
		qdel(H)
	for(var/obj/item/clothing/mask/breath/H in P.contents)
		qdel(H)
	for(var/obj/item/weapon/storage/backpack/sister/H in P.contents)
		qdel(H)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sister/halo, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/chainsword/ultramarine_chainsword/glow, slot_r_hand)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter/glow, slot_l_hand)
	//equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/sister/wing, slot_back)
	src.wings = 1
	P.regenerate_icons()
	P << sound('sound/effects/sobrev.ogg')
	P.luminosity = 10
	src.mutate("goldenglow") //Adding a little golden glow overlay for the SoB... Working on those wings. -Drake
	sleep(300)
	for(var/datum/mutation/generic/glow/G in src.mutations_warp)
		mutations_warp.Remove(G)
	src.update_mutations()
	src.wings = 0
	src.luminosity = 0
	src.maxHealth = 100
	src.adjustOxyLoss(10000)
	src.death()
	for(var/obj/item/clothing/head/helmet/sister/H in P.contents)
		qdel(H)
	//for(var/obj/item/weapon/storage/backpack/sister/H in P.contents)
	//	qdel(H)
	src.regenerate_icons()
