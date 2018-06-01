//Regular rig suits
/obj/item/clothing/head/helmet/space/rig
	name = "Mechanicus Hood"
	desc = "A special hood designed for work in a hazardous, low-pressure environment. Has radiation shielding."
	icon_state = "rig0-engineering"
	item_state = "eng_helm"
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 75)
	allowed = list(/obj/item/device/flashlight)
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	item_color = "engineering" //Determines used sprites: rig[on]-[color] and rig[on]-[color]2 (lying down sprite)
	action_button_name = "Toggle Helmet Light"

	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		on = !on
		icon_state = "rig[on]-[item_color]"
//		item_state = "rig[on]-[item_color]"
		user.update_inv_head()	//so our mob-overlays update

		if(on)	user.AddLuminosity(brightness_on)
		else	user.AddLuminosity(-brightness_on)

	pickup(mob/user)
		if(on)
			user.AddLuminosity(brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.AddLuminosity(-brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)

/obj/item/clothing/suit/space/rig
	name = "Mechanicus Robes"
	desc = "Holy robes of the Adeptus Mechanicus. Protects against hazardous, low pressure environments. Has radiation shielding."
	icon_state = "rig-engineering"
	item_state = "eng_hardsuit"
	slowdown = 0 //
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 75)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/t_scanner, /obj/item/weapon/rcd)

//Atmospherics
/obj/item/clothing/head/helmet/space/rig/atmos
	name = "atmospherics hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has thermal shielding."
	icon_state = "rig0-atmospherics"
	item_state = "atmo_helm"
	item_color = "atmospherics"
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 0)
	heat_protection = HEAD												//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/rig/atmos
	name = "atmospherics hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has thermal shielding."
	icon_state = "rig-atmospherics"
	item_state = "atmo_hardsuit"
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 0)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS					//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT

//Chief Engineer's rig
/obj/item/clothing/head/helmet/space/rig/elite
	name = "Advanced Helmet"
	desc = "An advanced helmet designed for work in a hazardous, low pressure environment. Shines with a high polish."
	icon_state = "rig0-white"
	item_state = "ce_helm"
	item_color = "white"
	armor = list(melee = 40, bullet = 5, laser = 10,energy = 5, bomb = 50, bio = 100, rad = 90)
	heat_protection = HEAD												//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/rig/elite
	icon_state = "rig-white"
	name = "Magos Tech Armor"
	desc = "A high tech suit complete with space proof shielding, armor padding, total biological and radioactive protection, and of coarse seals of purity."
	item_state = "ce_hardsuit"
	armor = list(melee = 50, bullet = 30, laser = 30,energy = 65, bomb = 75, bio = 100, rad = 100)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS					//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/t_scanner, /obj/item/weapon/rcd,/obj/item/weapon/melee/telebaton)

//Mining rig
/obj/item/clothing/head/helmet/space/rig/mining
	name = "mining hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low pressure environment. Has reinforced plating."
	icon_state = "rig0-mining"
	item_state = "mining_helm"
	item_color = "mining"
	armor = list(melee = 40, bullet = 5, laser = 10,energy = 5, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/space/rig/mining
	icon_state = "rig-mining"
	name = "mining hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has reinforced plating."
	item_state = "mining_hardsuit"
	armor = list(melee = 40, bullet = 5, laser = 10,energy = 5, bomb = 50, bio = 100, rad = 50)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/weapon/pickaxe)



//Syndicate rig
/obj/item/clothing/head/helmet/space/rig/syndi
	name = "blood-red hardsuit helmet"
	desc = "An advanced helmet designed for work in special operations. Property of Gorlex Marauders."
	icon_state = "rig0-syndi"
	item_state = "syndie_helm"
	item_color = "syndi"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 35, bio = 100, rad = 50)

/obj/item/clothing/suit/space/rig/syndi
	icon_state = "rig-syndi"
	name = "blood-red hardsuit"
	desc = "An advanced suit that protects against injuries during special operations. Property of Gorlex Marauders."
	item_state = "syndie_hardsuit"
	slowdown = 1
	w_class = 3
	armor = list(melee = 60, bullet = 50, laser = 30, energy = 15, bomb = 35, bio = 100, rad = 50)
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)


//Syndicate Stealth Rig
/obj/item/clothing/head/helmet/space/rig/syndistealth
	name = "night-black hardsuit helmet"
	desc = "An advanced helmet designed for work in covert operations. Property of Gorlex Marauders."
	icon_state = "rig0-stealth"
	item_state = "stealth_helm"
	item_color = "stealth"
	armor = list(melee = 65, bullet = 45, laser = 30,energy = 20, bomb = 30, bio = 100, rad = 50)

/obj/item/clothing/suit/space/rig/syndistealth
	icon_state = "stealth"
	name = "night-black hardsuit"
	desc = "An advanced suit that protects against injuries during covert operations. Property of Gorlex Marauders."
	item_state = "syndie_hardsuit"
	slowdown = 1
	w_class = 3
	armor = list(melee = 65, bullet = 45, laser = 30, energy = 20, bomb = 30, bio = 100, rad = 50)
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)


//Wizard Rig
/obj/item/clothing/head/helmet/space/rig/wizard
	name = "gem-encrusted hardsuit helmet"
	desc = "A bizarre gem-encrusted helmet that radiates magical energies."
	icon_state = "rig0-wiz"
	item_state = "wiz_helm"
	item_color = "wiz"
	unacidable = 1 //No longer shall our kind be foiled by lone chemists with spray bottles!
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 20, bomb = 35, bio = 100, rad = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/space/rig/wizard/warlock
	name = "gem-encrusted hardsuit helmet"
	desc = "A bizarre gem-encrusted helmet that radiates magical energies."
	icon_state = "warlock"
	item_state = "warlock"
	unacidable = 1 //No longer shall our kind be foiled by lone chemists with spray bottles!
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 20, bomb = 35, bio = 100, rad = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/rig/wizard
	icon_state = "rig-wiz"
	name = "Rune Armor"
	desc = "An Eldar Rune Armor set designed for the harshest of conditions."
	item_state = "wiz_hardsuit"
	slowdown = 1
	w_class = 3
	unacidable = 1
	armor = list(melee = 60, bullet = 50, laser = 70,energy = 70, bomb = 35, bio = 100, rad = 100)
	allowed = list(/obj/item/weapon/teleportation_scroll,/obj/item/weapon/tank/emergency_oxygen)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/rig/wizard/corsair
	name = "Corsair Armor"
	desc = "A wraithbone, space-proof suit of eldar corsair armor."
	item_state = "corsair"
	icon_state = "corsair"
	slowdown = 0
	armor = list(melee = 65, bullet = 55, laser = 75,energy = 70, bomb = 35, bio = 100, rad = 100)

//Medical Rig
/obj/item/clothing/head/helmet/space/rig/medical
	name = "medical hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low pressure environment. Built with lightweight materials for extra comfort."
	icon_state = "rig0-medical"
	item_state = "medical_helm"
	item_color = "medical"
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 50)

/obj/item/clothing/suit/space/rig/medical
	icon_state = "rig-medical"
	name = "medical hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Built with lightweight materials for easier movement."
	item_state = "medical_hardsuit"
	slowdown = 1
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/firstaid,/obj/item/device/healthanalyzer,/obj/item/stack/medical)
	armor = list(melee = 10, bullet = 5, laser = 10,energy = 5, bomb = 10, bio = 100, rad = 50)

	//Security
/obj/item/clothing/head/helmet/space/rig/security
	name = "security hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low pressure environment. Has an additional layer of armor."
	icon_state = "rig0-sec"
	item_state = "sec_helm"
	item_color = "sec"
	armor = list(melee = 50, bullet = 15, laser = 30,energy = 10, bomb = 25, bio = 100, rad = 50)

/obj/item/clothing/suit/space/rig/security
	icon_state = "rig-sec"
	name = "security hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has an additional layer of armor."
	item_state = "sec_hardsuit"
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank, /obj/item/weapon/gun/energy,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs)
	armor = list(melee = 50, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 100, rad = 50)

//Ancient hardsuit - Found on away missions/in space.
/obj/item/clothing/head/helmet/space/rig/ancient
	name = "ancient hardsuit helmet"
	desc = "A bulky, antique helmet that protects from hazardous, low pressure environments. You're not sure how old this is."
	icon_state = "rig0-ancient"
	item_state = "ancient_helm"
	item_color = "ancient"
	armor = list(melee = 40, bullet = 25, laser = 40,energy = 20, bomb = 20, bio = 100, rad = 60)

/obj/item/clothing/suit/space/rig/ancient
	name = "ancient hardsuit"
	desc = "A bulky, antique hardsuit with the date '2301' scratched into the chestplate. How old is this thing?"
	icon_state = "rig-ancient"
	item_state = "ancient_hardsuit"
	slowdown = 3
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank)
	armor = list(melee = 40, bullet = 25, laser = 40,energy = 20, bomb = 20, bio = 100, rad = 60)

//weird dark rig i dunno //Huh, lets put this in the space hulk eventually.
/obj/item/clothing/head/helmet/space/rig/dark
	name = "dark rig helmet"
	desc = "A strange dark rig suit helmet."
	icon_state = "rig0-dark"
	item_state = "dark_helm"
	item_color = "dark"
	armor = list(melee = 35, bullet = 15, laser = 35,energy = 10, bomb = 15, bio = 100, rad = 50)
	unacidable = 1 //An extra perk of this find. This /might/ actually make resist a plasma gun shot.

/obj/item/clothing/suit/space/rig/dark
	name = "dark rig suit"
	desc = "A strange dark rig suit."
	icon_state = "dark"
	item_state = "dark-rig"
	slowdown = 2
	armor = list(melee = 35, bullet = 15, laser = 35,energy = 10, bomb = 15, bio = 100, rad = 50)

// COLD RIGZ
	//Security
/obj/item/clothing/head/helmet/space/rig/security/cold
	name = "security cryo hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, cold, low pressure environment. Has an additional layer of armor."
	icon_state = "rig0-seccold"
	item_state = "sec_cold"
	item_color = "seccold"


/obj/item/clothing/suit/space/rig/security/cold
	icon_state = "cryo-security"
	name = "security cryo hardsuit"
	desc = "A special suit that protects against hazardous, cold, low pressure environments. Has an additional layer of armor."
	item_state = "sec_coldsuit"

//Engineering
/obj/item/clothing/head/helmet/space/rig/cold
	name = "engineering cryo hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, cold, low-pressure environment. Has radiation shielding."
	icon_state = "rig0-engicold"
	item_state = "eng_cold"
	item_color = "engicold"

/obj/item/clothing/suit/space/rig/cold
	name = "engineering cryo hardsuit"
	desc = "A special suit that protects against hazardous, cold, low pressure environments. Has radiation shielding."
	icon_state = "cryo-engineering"
	item_state = "eng_coldsuit"

//Atmospherics
/obj/item/clothing/head/helmet/space/rig/atmos/cold
	name = "atmospherics cryo hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, cold, low-pressure environment. Has thermal shielding."
	icon_state = "rig0-atmocold"
	item_state = "atmo_cold"
	item_color = "atmocold"

/obj/item/clothing/suit/space/rig/atmos/cold
	name = "atmospherics cryo hardsuit"
	desc = "A special suit that protects against hazardous, cold, low pressure environments. Has thermal shielding."
	icon_state = "cryo-atmos"
	item_state = "atmo_coldsuit"

//Mining
/obj/item/clothing/head/helmet/space/rig/mining/cold
	name = "mining cryo hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, cold, low pressure environment. Has reinforced plating."
	icon_state = "rig0-minecold"
	item_state = "mining_cold"
	item_color = "minecold"


/obj/item/clothing/suit/space/rig/mining/cold
	icon_state = "cryo-mining"
	name = "mining cryo hardsuit"
	desc = "A special suit that protects against hazardous, cold, low pressure environments. Has reinforced plating."
	item_state = "mining_coldsuit"
