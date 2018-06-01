/*
Bartender
*/
/datum/job/bartender
	title = "Bartender"
	flag = BARTENDER
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/bar
	default_headset = /obj/item/device/radio/headset/headset_srv

	access = list(access_hydroponics, access_bar, access_kitchen, access_morgue, access_mineral_storeroom)
	minimal_access = list(access_bar, access_mineral_storeroom)

/datum/job/bartender/equip_backpack(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	switch(H.backbag)
		if(1) //No backpack or satchel

			var/obj/item/weapon/storage/box/box = new default_storagebox(H)
			new /obj/item/ammo_casing/shotgun/beanbag(box)
			new /obj/item/ammo_casing/shotgun/beanbag(box)
			new /obj/item/ammo_casing/shotgun/beanbag(box)
			new /obj/item/ammo_casing/shotgun/beanbag(box)
			H.equip_to_slot_or_del(box, slot_r_hand)

		if(2) // Backpack
			var/obj/item/weapon/storage/backpack/BPK = new default_backpack(H)
			new default_storagebox(BPK)
			H.equip_to_slot_or_del(BPK, slot_back,1)
		if(3) //Satchel
			var/obj/item/weapon/storage/backpack/BPK = new default_satchel(H)
			new default_storagebox(BPK)
			H.equip_to_slot_or_del(BPK, slot_back,1)

/datum/job/bartender/equip_items(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/bartender(H), slot_w_uniform)

	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)

/*
Chef
*/
/datum/job/chef
	title = "Chef"
	flag = CHEF
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/chef
	default_headset = /obj/item/device/radio/headset/headset_srv

	access = list(access_hydroponics, access_bar, access_kitchen, access_morgue)
	minimal_access = list(access_kitchen, access_morgue)

/datum/job/chef/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chef(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/chef(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/chefhat(H), slot_head)

/*
Botanist
*/
/datum/job/hydro
	title = "Botanist"
	flag = BOTANIST
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/botanist
	default_headset = /obj/item/device/radio/headset/headset_srv

	access = list(access_hydroponics, access_bar, access_kitchen, access_morgue) // Removed tox and chem access because STOP PISSING OFF THE CHEMIST GUYS // //Removed medical access because WHAT THE FUCK YOU AREN'T A DOCTOR YOU GROW WHEAT //Given Morgue access because they have a viable means of cloning.
	minimal_access = list(access_hydroponics, access_morgue) // Removed tox and chem access because STOP PISSING OFF THE CHEMIST GUYS // //Removed medical access because WHAT THE FUCK YOU AREN'T A DOCTOR YOU GROW WHEAT //Given Morgue access because they have a viable means of cloning.

/datum/job/hydro/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/hydroponics(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/analyzer/plant_analyzer(H), slot_s_store)

/*
Quartermaster
*/
/datum/job/qm
	title = "Quartermaster"
	flag = QUARTERMASTER
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the sector munitorium and the imperial guard"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/quartermaster
	default_headset = /obj/item/device/radio/headset/headset_cargo

	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mint, access_mining, access_mining_station, access_mineral_storeroom)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mint, access_mining, access_mining_station)

/datum/job/qm/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/cargo(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/brown(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/fingerless(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/weapon/clipboard(H), slot_l_hand)

/*
Cargo Technician
*/
/datum/job/cargo_tech
	title = "Cargo Technician"
	flag = CARGOTECH
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/cargo
	default_headset = /obj/item/device/radio/headset/headset_cargo

	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/cargo_tech/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/cargotech(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/fingerless(H), slot_gloves)

/*
Shaft Miner
*/
/datum/job/mining
	title = "Shaft Miner"
	flag = MINER
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the quartermaster and the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/shaftminer
	default_headset = /obj/item/device/radio/headset/headset_cargo
	default_backpack = /obj/item/weapon/storage/backpack/industrial
	default_satchel = /obj/item/weapon/storage/backpack/satchel_eng
	default_storagebox = /obj/item/weapon/storage/box/engineer

	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_mint, access_mining, access_mining_station, access_mineral_storeroom)
	minimal_access = list(access_mining, access_mint, access_mining_station, access_mailsorting, access_mineral_storeroom)

/datum/job/mining/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/miner(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/fingerless(H), slot_gloves)

	if(H.backbag == 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/crowbar(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/bag/ore(H), slot_l_store)
		H.equip_to_slot_or_del(new /obj/item/weapon/mining_voucher(H), slot_r_store)
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/crowbar(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/bag/ore(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/mining_voucher(H), slot_in_backpack)

/*
Celebrity
*/
/datum/job/celebrity
	title = "Celebrity"
	flag = CELEBRITY
	department_head = list("Rock and Roll")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Rock and Roll"
	selection_color = "#dddddd"

	access = list(access_theatre, access_maint_tunnels)
	minimal_access = list(access_theatre)

/datum/job/celebrity/equip_items(var/mob/living/carbon/human/H)
	H.fully_replace_character_name(H.real_name, pick(clown_names)) // Give him a temporary random name to prevent identity revealing
	H.verbs += /mob/living/carbon/human/proc/renderaid
	H.verbs += /mob/living/carbon/human/proc/celebshuttle
	H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_ears)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/powdered_wig(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/celebrity(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket/red(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	if(H.backbag == 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/celebjudgement(H), slot_l_store)
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/celebjudgement(H), slot_in_backpack)

	H.rename_self("clown")
	if(prob(25))
		H.verbs += /mob/living/carbon/human/proc/celebfall //I was changing them back and forth RAPIDLY //This is how we get the verb!

/*
Mime
*/
/datum/job/mime
	title = "Mime"
	flag = MIME
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/mime
	default_backpack = /obj/item/weapon/storage/backpack/mime

	access = list(access_theatre, access_maint_tunnels)
	minimal_access = list(access_theatre)


/datum/job/mime/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/mime(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/white(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/mime(H), slot_wear_mask)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/beret(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/suspenders(H), slot_wear_suit)

	if(H.backbag == 1)
		H.equip_to_slot_or_del(new /obj/item/toy/crayon/mime(H), slot_l_store)
		H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing(H), slot_l_hand)
	else
		H.equip_to_slot_or_del(new /obj/item/toy/crayon/mime(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing(H), slot_in_backpack)

	if(H.mind)
		H.mind.spell_list += new /obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall(null)
		H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/speak(null)
		H.mind.miming = 1
		if(prob(25))
			H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/concentrate(null)

	H.rename_self("mime")

/*
Janitor
*/
/datum/job/janitor
	title = "Janitor"
	flag = JANITOR
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/janitor
	default_headset = /obj/item/device/radio/headset/headset_srv

	access = list(access_janitor, access_maint_tunnels)
	minimal_access = list(access_janitor, access_maint_tunnels)

/datum/job/janitor/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/janitor(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)

/*
Librarian
*/
/datum/job/librarian
	title = "Librarian"
	flag = LIBRARIAN
	department_head = list("Seneschal")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/librarian

	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)

/datum/job/librarian/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket/red(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/barcodescanner(H), slot_r_store)
	H.equip_to_slot_or_del(new /obj/item/device/laser_pointer(H), slot_l_store)

/*
Inquisitor
*/
/datum/job/lawyer
	title = "Inquisitor"
	flag = LAWYER
	department_head = list("Ordo Hereticus")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Ordo Hereticus"
	selection_color = "#dddddd"
	var/global/lawyers = 0 //Counts lawyer amount
	default_backpack = /obj/item/weapon/storage/backpack/inq
	default_satchel = /obj/item/weapon/storage/backpack/inq
	default_pda = /obj/item/device/pda/lawyer
	default_headset = /obj/item/device/radio/headset/headset_sec
	default_id = /obj/item/weapon/card/id/inquisitor

	access = list(access_security, access_sec_doors, access_brig, access_court, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_theatre, access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom, access_cent_inquisitor, access_cent_general, access_cent_hereticus)
	minimal_access = list(access_security, access_sec_doors, access_court,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_theatre, access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom, access_cent_inquisitor, access_cent_general, access_cent_hereticus)

/datum/job/lawyer/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/inq(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/inq/random(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/inqhat(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/laspistol2(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/device/pda/lawyer(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/weapon/powersword/pknife(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/device/hdetector(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/weapon/paper/inq(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat/inquisitor(H), slot_gloves)
	H.faction = "Inquisitor"
	if (prob(50))
		var/obj/item/weapon/implant/loyalty/E = new/obj/item/weapon/implant/loyalty(H)
		E.imp_in = H
		E.implanted = 1

	spawn(10)
		H.wear_id.name = "[H.real_name]'s Inquisitorial Seal"

	spawn(10)
		var/weaponchoice = input(H, "Select a weapon.","Weapon Selection") as null|anything in list("Power Sword", "Mercy Chainsword", "Hell Pistol", "Stubber Pistol", "Inferno Pistol")
		switch(weaponchoice)
			if("Power Sword")
				H.equip_to_slot_or_del(new /obj/item/weapon/powersword/(H), slot_r_hand)
			if("Mercy Chainsword")
				H.equip_to_slot_or_del(new /obj/item/weapon/twohanded/chainswordig/inq(H), slot_r_hand)
			if("Hell Pistol")
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/hellpistol(H), slot_r_hand)
			if("Inferno Pistol")
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/inferno(H), slot_r_hand)
			if("Stubber Pistol")
				H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/pistol(H), slot_r_hand)


//--Eldar Spy--

/datum/job/eldarspy
	title = "Assistant"
	flag = ELDARSPY
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Everyone!"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	idtype = /obj/item/weapon/card/id/assistant

// eldarspy/datum/job/eldarspy/equip_items(var/mob/living/carbon/human/H)
	//H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	//H.equip_to_slot_or_del(new /obj/item/clothing/suit/cape(H), slot_wear_suit)
	//H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)  //Looks like an assistant
	// removalH.equip_to_slot_or_del(new /obj/item/weapon/paper/espy(H), slot_in_backpack)  //With a cloaking device
	//H.equip_to_slot_or_del(new /obj/item/device/soulstone(H), slot_in_backpack)	//and a soulstone. Perfectly normal!
	//H.equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate(H), slot_in_backpack)

//datum/job/assistant/get_access()
//	if(config.jobs_have_maint_access & ASSISTANTS_HAVE_MAINT_ACCESS) //Config has assistant maint access set
//		. = ..()
//		. |= list(access_maint_tunnels)
//	else
//		return ..()