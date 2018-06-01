/*
Chief Engineer
*/
/datum/job/chief_engineer
	title = "Magos"
	flag = CHIEF
	department_head = list("Lord General")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Adeptus Mechanicus and the Omnissiah"
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	minimal_player_age = 7

	default_id = /obj/item/weapon/card/id/silver
	default_pda = /obj/item/device/pda/heads/ce
	default_pda_slot = slot_l_store
	default_headset = /obj/item/device/radio/headset/heads/ce
	default_backpack = /obj/item/weapon/storage/backpack/industrial
	default_satchel = /obj/item/weapon/storage/backpack/industrial
	default_storagebox = /obj/item/weapon/storage/box/engineer

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

/datum/job/chief_engineer/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chief_engineer(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/red(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/space/rig/elite(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/rig/elite(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/laspistol2(H), slot_l_store)
	H.faction = "Mechanicus"

	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/melee/telebaton(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/syringe(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/magos(H), slot_in_backpack)

/datum/job/chief_engineer/get_access()
	return get_all_accesses()

/*
Station Engineer
*/
/datum/job/engineer
	title = "Explorator"
	flag = ENGINEER
	department_head = list("Magos")
	department_flag = ENGSEC
	total_positions = 5
	spawn_positions = 5
	faction = "Station"
	supervisors = "the Magos"
	selection_color = "#fff5cc"

	default_pda = /obj/item/device/pda/engineering
	default_pda_slot = slot_l_store
	default_headset = /obj/item/device/radio/headset/headset_eng
	default_backpack = /obj/item/weapon/storage/backpack/industrial
	default_satchel = /obj/item/weapon/storage/backpack/industrial
	default_storagebox = /obj/item/weapon/storage/box/engineer

	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
									access_external_airlocks, access_construction, access_atmospherics, access_tcomsat)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
									access_external_airlocks, access_construction, access_tcomsat)

/datum/job/engineer/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/engineer(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/red(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/device/t_scanner(H), slot_r_store)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/space/rig(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/rig(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/laspistol2(H), slot_l_store)
	H.faction = "Mechanicus"
/*
Atmospheric Technician
*/

//I just realized... What on earth do we need this job for? I mean, the mechanicus would totally put a room full of useless pipes on an outpost, but nobody seriously wants to hold this job.
/*
/datum/job/atmos
	title = "Atmospheric Technician"
	flag = ATMOSTECH
	department_head = list("Magos")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the Magos"
	selection_color = "#fff5cc"

	default_pda = /obj/item/device/pda/atmos
	default_pda_slot = slot_l_store
	default_headset = /obj/item/device/radio/headset/headset_eng
	default_backpack = /obj/item/weapon/storage/backpack/industrial
	default_satchel = /obj/item/weapon/storage/backpack/industrial
	default_storagebox = /obj/item/weapon/storage/box/engineer

	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
									access_external_airlocks, access_construction, access_atmospherics)
	minimal_access = list(access_atmospherics, access_maint_tunnels, access_emergency_storage, access_construction)

/datum/job/atmos/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/atmospheric_technician(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/red(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/device/analyzer(H), slot_r_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/atmostech/(H), slot_belt)
*/