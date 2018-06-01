/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	flags = HEADCOVERSEYES
	item_state = "helmet"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/eldarhat
	name = "Guardian Helmet"
	desc = "A helmet forged of wraithbone."
	icon_state = "ehelmet"
	flags = HEADCOVERSEYES
	item_state = "ehelmet"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/corsair
	name = "Corsair Helmet"
	desc = "A corsair helmet forged of wraithbone."
	icon_state = "corsair"
	item_state = "corsair"
	armor = list(melee = 55, bullet = 20, laser = 55,energy = 15, bomb = 25, bio = 70, rad = 70)
	flags = HEADCOVERSEYES
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/cadianhelmet
	name = "Cadian Helmet"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon_state = "stormh"
	flags = HEADCOVERSEYES
	item_state = "stormh"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/bodyguard
	name = "Armored hood"
	desc = "Armored hood, what more do you want?"
	icon_state = "culthood"
	flags = HEADCOVERSEYES
	item_state = "culthood"
	armor = list(melee = 55, bullet = 15, laser = 50,energy = 20, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT


/obj/item/clothing/head/helmet/HoS
	name = "head of security hat"
	desc = "The hat of the Head of Security. For showing the officers who's in charge."
	icon_state = "enforcer"
	flags = HEADCOVERSEYES
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	flags_inv = 0
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/HoS/dermal
	name = "Dermal Armour Patch"
	desc = "You're not quite sure how you manage to take it on and off, but it implants nicely in your head."
	icon_state = "dermal"
	item_state = "dermal"

/obj/item/clothing/head/helmet/roman
	name = "roman helmet"
	desc = "An ancient helmet made of bronze and leather."
	armor = list(melee = 25, bullet = 0, laser = 25, energy = 10, bomb = 10, bio = 0, rad = 0)
	icon_state = "roman"
	item_state = "roman"

/obj/item/clothing/head/helmet/roman/legionaire
	name = "roman legionaire helmet"
	desc = "An ancient helmet made of bronze and leather. Has a red crest on top of it."
	icon_state = "roman_c"
	item_state = "roman_c"

/obj/item/clothing/head/helmet/warden
	name = "Seargent's Hat"
	desc = "It is a hat that Imperial Seargents wear a lot. It signifies the rank of 'not killed yet' among the imperial guard."
	icon_state = "beret_badge"
	flags_inv = 0

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH
	armor = list(melee = 82, bullet = 15, laser = 5,energy = 5, bomb = 5, bio = 2, rad = 0)
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/carapace
	name = "carapace helmet"
	desc = "It's a thick helmet with heavy armoring."
	icon_state = "carapace"
	item_state = "carapace"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH
	armor = list(melee = 75, bullet = 50, laser = 50,energy = 50, bomb = 50, bio = 50, rad = 60)
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "They're often used by highly trained Swat Members."
	icon_state = "swat"
	flags = HEADCOVERSEYES
	item_state = "swat"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	icon_state = "thunderdome"
	flags = HEADCOVERSEYES
	item_state = "thunderdome"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES

obj/item/clothing/head/helmet/redtaghelm
	name = "Red LaserTag Helmet"
	desc = "They have chosen their own end."
	icon_state = "redtaghelm"
	flags = HEADCOVERSEYES
	item_state = "redtaghelm"
	armor = list(melee = 30, bullet = 10, laser = 20,energy = 10, bomb = 20, bio = 0, rad = 0)
	// Offer about the same protection as a hardhat.
	flags_inv = HIDEEARS|HIDEEYES

obj/item/clothing/head/helmet/bluetaghelm
	name = "Blue LaserTag Helmet"
	desc = "They'll need more men."
	icon_state = "bluetaghelm"
	flags = HEADCOVERSEYES
	item_state = "bluetaghelm"
	armor = list(melee = 30, bullet = 10, laser = 20,energy = 10, bomb = 20, bio = 0, rad = 0)
	// Offer about the same protection as a hardhat.
	flags_inv = HIDEEARS|HIDEEYES

/*
imperial class helment
*/

/obj/item/clothing/head/imperialhelmet
	name = "Imperial Flak Helmet"
	desc = "Standard Imperial Guard Helmet"
	icon_state = "imperialhelmet"
	flags = HEADCOVERSEYES
	item_state = "imperialhelmet"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/imperialhelmet/reinforced
	name = "Reinforced Imperial Flak Helmet"
	desc = "Upgraded Imperial Guard Helmet"
	icon_state = "flakhelmet"
	item_state = "flakhelmet"
	armor = list(melee = 65, bullet = 35, laser = 50,energy = 20, bomb = 50, bio = 5, rad = 5)

/obj/item/clothing/head/DKhelmet
	name = "Mark IX Helmet"
	desc = "The standard-issue Mark IX helmet is made of plasteel and constructed to ensure a good fit around the gasmask; ventilation is provided through a top spine, which has its own internal filter to keep out biological and chemical agents."
	icon_state = "khelmet"
	flags = HEADCOVERSEYES
	item_state = "khelmet"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 90, rad = 90)
	flags_inv = HEADCOVERSEYES|BLOCKHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/valhalla
	name = "Valhallan Helmet"
	desc = "A cold resistant, heavily padded helmet that is issued to the Valhallan Ice Warriors."
	icon_state = "valhalla"
	flags = HEADCOVERSEYES
	item_state = "valhalla"
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	flags_inv = HEADCOVERSEYES|BLOCKHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/comissar2
	name = "Comissar Cap"
	desc = "An armored cap with the imperial insignia on it, symbolizing the authority of a Comissar."
	icon_state = "comissar3"
	flags = HEADCOVERSEYES
	item_state = "comissar2"
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	flags_inv = HEADCOVERSEYES|BLOCKHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/comissar2/festive
	name = "Commisar Festive cap"
	icon_state = "comissar2"

/obj/item/clothing/head/bpimperialhelmet
	name = "Helmet"
	desc = "Standard Helmet"
	icon_state = "bpimperialhelmet"
	flags = HEADCOVERSEYES|BLOCKHAIR
	item_state = "bpimperialhelmet"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/*
Power Armor Class Helmet
*/

/obj/item/clothing/head/helmet/umpowerhelmet
	name = "Ultra Marine Helmet"
	desc = "Headwear of the UltraMarines"
	icon_state = "um_helm"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	item_state = "um_helm"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/umpowerhelmet/devastator
	name = "Ultra Marine Devastator Helmet"
	desc = "Headwear of the UltraMarines"
	icon_state = "um_devhelm"
	item_state = "um_devhelm"

/obj/item/clothing/head/helmet/umpowerhelmet/captain
	name = "Ultra Marine Captain Helmet"
	desc = "Headwear of an UltraMarine Captain"
	icon_state = "umcpt_helm"
	item_state = "umcpt_helm"
	armor = list(melee = 75, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 75, rad = 95)

/obj/item/clothing/head/helmet/rgpowerhelmet
	name = "Raven Guard Helmet"
	desc = "Headwear of the Raven Guard"
	icon_state = "rghelmet"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	item_state = "rghelmet"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/rgpowerhelmet/chaplain
	name = "Raven Guard Chaplain Helmet"
	desc = "Headwear of the Raven Guard"
	icon_state = "rghelmet2"
	item_state = "rghelmet2"

/obj/item/clothing/head/helmet/rgpowerhelmet/captain
	name = "Shadow Captain Helmet"
	desc = "Headwear of the Raven Guard"
	icon_state = "rgcpt_helm"
	item_state = "rgcpt_helm"

/obj/item/clothing/head/helmet/smpowerhelmet
	name = "Salamander Marine Helmet"
	desc = "Helm of the Salamander Marines"
	icon_state = "sl_helm"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR||!CANSTUN|!CANWEAKEN
	item_state = "sl_helm"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/smpowerhelmet/captain
	name = "Salamander Marine Captain Helmet"
	desc = "Headwear of an Salamander Marine Captain"
	icon_state = "slcpt_helm"
	item_state = "slcpt_helm"
	armor = list(melee = 75, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 75, rad = 95)

/obj/item/clothing/head/helmet/smpowerhelmet/devastator
	name = "Salamander Marine Devastator Helmet"
	desc = "Headwear of an Salamander Marine"
	icon_state = "sl_devhelm"
	item_state = "sl_devhelm"

/obj/item/clothing/head/helmet/umpowerhelmet/vet
	name = "Veteran Helmet"
	desc = "Headwear of the Veterans"
	icon_state = "nco_helm"
	item_state = "nco_helm"

/obj/item/clothing/head/helmet/umpowerhelmet/tech
	name = "Veteran Helmet"
	desc = "Headwear of the Veterans"
	icon_state = "techie_helm"
	item_state = "techie_helm"

/obj/item/clothing/head/helmet/umpowerhelmet/apoth
	name = "Veteran Helmet"
	desc = "Headwear of the Veterans"
	icon_state = "apoth_helm"
	item_state = "apoth_helm"

/obj/item/clothing/head/helmet/sister
	name = "Sister of Battle Helmet"
	desc = "A very expensive Adeptus Soritas helm"
	icon_state = "sister"
	flags = HEADCOVERSEYES|!CANSTUN|!CANWEAKEN|BLOCKHAIR
	item_state = "sister"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/sister/halo
	name = "HOLY CRAP!"
	desc = "What the crap?"
	icon_state = "crappyhalo"
	flags = HEADCOVERSEYES|!CANSTUN|!CANWEAKEN|BLOCKHAIR
	item_state = "crappyhalo"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/KBpowerhelmet
	name = "Chaos Marine Helmet"
	desc = "Helm of the Khornites"
	icon_state = "KBpower"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	item_state = "KBpower"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/fwhelmet
	name = "Fire Warrior Helmet"
	desc = "There is more technology in this helmet than on all of Terra."
	icon_state = "FWhelm"
	flags = HEADCOVERSEYES
	item_state = "FWhelm"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/tau/fwbhelmet
	name = "Fire Warrior Breacher Helmet"
	desc = "There is more technology in this helmet than on all of Terra."
	icon_state = "tbrea"
	flags = HEADCOVERSEYES
	item_state = "tbrea"
	armor = list(melee = 65, bullet = 35, laser = 55,energy = 25, bomb = 35, bio = 0, rad = 10)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/pmpowerhelmet
	name = "Plague Marine Helmet"
	desc = "Headwear of the PlagueMarines"
	icon_state = "pmhelmet"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	item_state = "pmhelmet"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/head/helmet/ksonshelmet
	name = "Thousand Sons Helmet"
	desc = "Thousand Sons Helmet"
	icon_state = "ksons"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	item_state = "ksons"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 100, bomb = 55, bio = 55, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1