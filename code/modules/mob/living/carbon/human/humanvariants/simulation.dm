/mob/living/carbon/human/simulation
	name = "Imperial Guard"
	real_name = "Imperial Guard"
	universal_speak = 1
	gender = "male"
	var/mob/living/carbon/human/U = null
	var/obj/structure/stool/bed/chair/simulator/simulator = null
	var/list/enemies = list()
	var/max_enemies = 16
	var/list/stuff = list()

/mob/living/carbon/human/simulation/New()
	..()
	sleep (5)
	src.equip_to_slot_or_del(new /obj/item/clothing/under/color/imperial_s(src), slot_w_uniform)
	src.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/imperialarmor(src), slot_wear_suit)
	src.equip_to_slot_or_del(new /obj/item/clothing/shoes/imperialboots(src), slot_shoes)
	src.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(src), slot_ears)
	src.equip_to_slot_or_del(new /obj/item/clothing/head/imperialhelmet(src), slot_head)
	src.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(src), slot_gloves)
	src.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/hellgun(src), slot_r_hand)
	src.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/sechailer(src), slot_wear_mask)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/security(src), slot_back)
	src.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/hellgun(src), slot_in_backpack)
	src.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/hellgun(src), slot_in_backpack)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/tactical(src), slot_in_backpack)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/firstaid/tactical(src), slot_in_backpack)
	src.equip_to_slot_or_del(new /obj/item/weapon/complexknife/combatknife(src), slot_in_backpack)
	var/obj/item/weapon/card/id/W = new /obj/item/weapon/card/id(src)
	W.assignment = "Imperial Guard"
	W.registered_name = "Imperial Guard"
	W.update_label()
	src.equip_to_slot_or_del(W, slot_wear_id)
	src.update_icons()
	stuff = src.contents

	sleep (20)
	regenerate_icons()

/mob/living/carbon/human/simulation/death(gibbed)
	src << "\red You leave the simulation."
	if(src.simulator)
		src.simulator.toggle_on()
	else
		src << "\red ERROR: You are unable to leave... We apologize for the inconvenience."

/mob/living/carbon/human/simulation/Life()
	if(!U || U.stat != CONSCIOUS)
		src << "\red You leave the simulation."
		if(src.simulator)
			src.simulator.toggle_on()
		else
			src << "\red ERROR: You are unable to leave... We apologize for the inconvenience."
	..()

/mob/living/carbon/human/simulation/Del()
	for(var/atom/A in stuff)
		qdel(A)
	..()

/mob/living/carbon/human/simulation/verb/leave()
	set category = "Simulation"
	set name = "Exit Simulation"
	set desc = "Allows you to leave the simulation."
	src << "\red You leave the simulation."
	if(src.simulator)
		src.simulator.toggle_on()
	else
		src << "\red ERROR: You are unable to leave... We apologize for the inconvenience."

/mob/living/carbon/human/simulation/verb/spawnenemy()
	set category = "Simulation"
	set name = "Create Enemy"
	set desc = "Spawns an enemy into the simulation."

	if(enemies.len >= max_enemies)
		src << "\red You have reached your maximum enemy count. Begin a new session to create additional opponents."
		return

	var/list/dests = list()
	for(var/obj/effect/landmark/simulator/S in world)
		dests += get_turf(S)
	var/turf/T = pick(dests)

	var/enemytype = pick(/mob/living/carbon/human/simulation_enemy_cultist, /mob/living/carbon/human/simulation_enemy_cultist, /mob/living/carbon/human/simulation_enemy_cultist, /mob/living/carbon/human/simulation_enemy_guard, /mob/living/carbon/human/simulation_enemy_guard, /mob/living/carbon/human/simulation_enemy_marine)
	enemies += new enemytype(T)

/mob/living/carbon/human/simulation_enemy_guard
	name = "Heretic"
	real_name = "Heretic"
	universal_speak = 1
	gender = "male"
	var/list/stuff = list()

/mob/living/carbon/human/simulation_enemy_guard/New()
	..()
	sleep (5)
	src.equip_to_slot_or_del(new /obj/item/clothing/under/color/imperial_s(src), slot_w_uniform)
	src.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/imperialarmor(src), slot_wear_suit)
	src.equip_to_slot_or_del(new /obj/item/clothing/shoes/imperialboots(src), slot_shoes)
	src.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(src), slot_ears)
	src.equip_to_slot_or_del(new /obj/item/clothing/head/imperialhelmet(src), slot_head)
	src.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(src), slot_gloves)
	src.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/lasgun(src), slot_r_hand)
	src.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/sechailer(src), slot_wear_mask)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/security(src), slot_back)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/box(src), slot_in_backpack)
	var/obj/item/weapon/card/id/W = new /obj/item/weapon/card/id(src)
	W.assignment = "Heretic"
	W.registered_name = "Heretic"
	W.update_label()
	src.equip_to_slot_or_del(W, slot_wear_id)
	src.update_icons()

	stuff = src.contents

	factions += "simulation"

	sleep (20)
	regenerate_icons()
	src.reagents.add_reagent("berserk", 10)
	src.reagents.add_reagent("increase", 10)
	spawn(10)	src.berserkmaster = "simulation"

/mob/living/carbon/human/simulation_enemy_guard/Del()
	for(var/atom/A in stuff)
		qdel(A)
	..()

/mob/living/carbon/human/simulation_enemy_cultist
	name = "Heretic"
	real_name = "Heretic"
	universal_speak = 1
	gender = "male"
	var/list/stuff = list()

/mob/living/carbon/human/simulation_enemy_cultist/New()
	..()
	sleep (5)
	src.equip_to_slot_or_del(new /obj/item/clothing/under/color/imperial_s(src), slot_w_uniform)
	src.equip_to_slot_or_del(new /obj/item/clothing/head/culthood/alt(src), slot_head)
	src.equip_to_slot_or_del(new /obj/item/clothing/suit/cultrobes/alt(src), slot_wear_suit)
	src.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult(src), slot_shoes)
	src.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/cultpack(src), slot_back)
	src.put_in_hands(new /obj/item/weapon/complexsword/cultblade(src))
	var/obj/item/weapon/card/id/W = new /obj/item/weapon/card/id(src)
	W.assignment = "Heretic"
	W.registered_name = "Heretic"
	W.update_label()
	src.equip_to_slot_or_del(W, slot_wear_id)
	src.update_icons()

	stuff = src.contents

	factions += "simulation"

	sleep (20)
	regenerate_icons()
	src.reagents.add_reagent("berserk", 10)
	src.reagents.add_reagent("increase", 10)
	spawn(10)	src.berserkmaster = "simulation"

/mob/living/carbon/human/simulation_enemy_cultist/Del()
	for(var/atom/A in stuff)
		qdel(A)
	..()

/mob/living/carbon/human/simulation_enemy_marine
	name = "Heretic"
	real_name = "Heretic"
	universal_speak = 1
	gender = "male"
	var/list/stuff = list()

/mob/living/carbon/human/simulation_enemy_marine/New()
	..()
	sleep (5)
	src.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate(src), slot_w_uniform)
	src.equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots(src), slot_shoes)
	src.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/KBpowerarmor(src), slot_wear_suit)
	src.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(src), slot_gloves)
	src.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/KBpowerhelmet(src), slot_head)
	src.equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/KBback(src), slot_back)
	src.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag(src), slot_l_store)
	src.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag(src), slot_r_store)
	src.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter/chaos(src), slot_r_hand)
	src.equip_to_slot_or_del(new /obj/item/weapon/chainsword/chainaxe2(src), slot_belt)
	src.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat(src), slot_wear_mask)
	var/obj/item/weapon/card/id/W = new /obj/item/weapon/card/id(src)
	W.assignment = "Heretic"
	W.registered_name = "Heretic"
	W.update_label()
	src.equip_to_slot_or_del(W, slot_wear_id)
	src.update_icons()

	stuff = src.contents

	factions += "simulation"

	sleep (20)
	regenerate_icons()
	src.reagents.add_reagent("berserk", 10)
	src.reagents.add_reagent("increase", 10)
	spawn(10)	src.berserkmaster = "simulation"

/mob/living/carbon/human/simulation_enemy_marine/Del()
	for(var/atom/A in stuff)
		qdel(A)
	..()