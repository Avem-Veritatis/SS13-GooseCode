/*
Chief Medical Officer
*/
/datum/job/cmo
	title = "Sister Hospitaller"
	flag = CMO
	department_head = list("Ecclesiarchy")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Ecclesiarchy"
	selection_color = "#ffddf0"
	req_admin_notify = 0
	minimal_player_age = 7

	default_id = /obj/item/weapon/card/id/silver
	default_pda = /obj/item/device/pda/heads/cmo
	default_headset = /obj/item/device/radio/headset/heads/cmo
	default_backpack = /obj/item/weapon/storage/backpack/satchel_sec
	default_satchel = /obj/item/weapon/storage/backpack/satchel_sec

	access = list(access_medical, access_morgue, access_genetics, access_heads, access_mineral_storeroom,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_heads, access_mineral_storeroom,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors)

/datum/job/cmo/equip_items(var/mob/living/carbon/human/H)
	H.gender = "female"
	H.hair_color = "fff"
	H.hair_style = "Bobcurl"
	H.facial_hair_style = "Shaved"
	H.facial_hair_color = "fff"
	H.verbs += /mob/living/carbon/human/proc/renderaidclone
	H.equip_to_slot_or_del(new /obj/item/clothing/under/surgerycybernetic(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/brown(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/sister/hosp(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/inferno(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night(H), slot_glasses)
	var/obj/item/weapon/implant/loyalty/E = new/obj/item/weapon/implant/loyalty(H)
	E.imp_in = H
	E.implanted = 1

	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/hospitalar(H), slot_in_backpack)
	H.rename_self("first_female")

/*
Medical Doctor
*/
/datum/job/doctor
	title = "Trauma Medicus"
	flag = DOCTOR
	department_head = list("Sister Hospitaller")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "Sister Hospitaller"
	selection_color = "#ffeef0"

	default_pda = /obj/item/device/pda/medical
	default_headset = /obj/item/device/radio/headset/headset_med
	default_backpack = /obj/item/weapon/storage/backpack/satchel_robo
	default_satchel = /obj/item/weapon/storage/backpack/satchel_robo

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_morgue, access_surgery)

/datum/job/doctor/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaidclone
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/bio_suit/medicus(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/paper/medicus(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/medicus, slot_wear_mask)

	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/medicus(H), slot_in_backpack)


/*
Chemist
*/
/datum/job/chemist
	title = "Pharmacologist"
	flag = CHEMIST
	department_head = list("Sister Hospitaller")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Sister Hospitaller"
	selection_color = "#ffeef0"

	default_pda = /obj/item/device/pda/chemist
	default_headset = /obj/item/device/radio/headset/headset_med
	default_backpack = /obj/item/weapon/storage/backpack/satchel_robo
	default_satchel = /obj/item/weapon/storage/backpack/satchel_robo

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_mineral_storeroom)
	minimal_access = list(access_medical, access_chemistry, access_mineral_storeroom)

/datum/job/chemist/equip_items(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chemist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/bio_suit/medicus(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/medicus, slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/night(H), slot_glasses)

	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/medicus(H), slot_in_backpack)

/*
Geneticist
*/
/datum/job/geneticist
	title = "Geneticist"
	flag = GENETICIST
	department_head = list("Sister Hospitaller", "Lord Inquisitor")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the sister hospitaller and lord inquisitor"
	selection_color = "#ffeef0"

	default_pda = /obj/item/device/pda/geneticist
	default_headset = /obj/item/device/radio/headset/headset_medsci
	default_backpack = /obj/item/weapon/storage/backpack/medic
	default_satchel = /obj/item/weapon/storage/backpack/satchel_gen

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_research)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_research)

/datum/job/geneticist/equip_items(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/geneticist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/labcoat/genetics(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/flashlight/pen(H), slot_s_store)

/*
Virologist
*/
/datum/job/virologist
	title = "Virologist"
	flag = VIROLOGIST
	department_head = list("Sister Hospitaller")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the sister hospitaller"
	selection_color = "#ffeef0"

	default_pda = /obj/item/device/pda/viro
	default_headset = /obj/item/device/radio/headset/headset_med
	default_backpack = /obj/item/weapon/storage/backpack/medic
	default_satchel = /obj/item/weapon/storage/backpack/satchel_vir

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_mineral_storeroom)
	minimal_access = list(access_medical, access_virology, access_mineral_storeroom)

/datum/job/virologist/equip_items(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/virologist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(H), slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/labcoat/virologist(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/flashlight/pen(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/hypospray/cure(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/hypospray/cure(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/hypospray/cure(H), slot_in_backpack)

