/obj/item/clothing/shoes/syndigaloshes
	desc = "A pair of brown shoes. They seem to have extra grip."
	name = "brown shoes"
	icon_state = "brown"
	item_state = "brown"
	permeability_coefficient = 0.05
	flags = NOSLIP
	origin_tech = "syndicate=3"

/obj/item/clothing/shoes/sneakers/mime
	name = "mime shoes"
	icon_state = "mime"
	item_color = "mime"

/obj/item/clothing/shoes/boots
	name = "warm boots"
	desc = "A nice pair of boots to keep your feet toasty."
	icon_state = "warmboots"
	item_color = "warmboots"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/swat
	name = "\improper Armored Boots"
	desc = "When you want to turn up the heat."
	icon_state = "jackboots"
	item_state = "jackboots"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	flags = NOSLIP

/obj/item/clothing/shoes/swat/comissar2
	icon_state = "comissar2"
	item_state = "comissar2"

/obj/item/clothing/shoes/swat/corsair
	name = "corsair boots"
	desc = "Armored corsair boots."
	icon_state = "corsair"
	item_state = "corsair"

/obj/item/clothing/shoes/DK
	name = "Krieg low marching boots"
	desc = "Standard-issue low marching boots using hob-nailed soles for grip and includes an anti-vesicant"
	icon_state = "kboots"
	item_state = "kboots"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 90, rad = 90)
	flags = NOSLIP
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MAX_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/swat/combat
	name = "combat boots"
	desc = "When you REALLY want to turn up the heat"

	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/space_ninja
	name = "ninja shoes"
	desc = "A pair of running shoes. Excellent for running and even better for smashing skulls."
	icon_state = "s-ninja"
	item_state = "secshoes"
	permeability_coefficient = 0.01
	flags = NOSLIP
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/cadianboots
	name = "Shock Trooper Boots"
	desc = "Imperial guard boots. Excellent for running and even better for smashing skulls."
	icon_state = "jackboots"
	item_state = "cadianboots"
	permeability_coefficient = 0.01
	flags = NOSLIP
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/sandal
	desc = "A pair of rather plain, wooden sandals."
	name = "sandals"
	icon_state = "wizard"

/obj/item/clothing/shoes/sandal/marisa
	desc = "A pair of magic black shoes."
	name = "magic shoes"
	icon_state = "black"

/obj/item/clothing/shoes/galoshes
	desc = "Rubber boots"
	name = "galoshes"
	icon_state = "galoshes"
	permeability_coefficient = 0.05
	flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1

/obj/item/clothing/shoes/clown_shoes
	desc = "The prankster's standard-issue clowning shoes. Damn, they're huge!"
	name = "clown shoes"
	icon_state = "clown"
	item_state = "clown_shoes"
	slowdown = SHOES_SLOWDOWN+1
	item_color = "clown"
	var/footstep = 1	//used for squeeks whilst walking

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "Combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots"
	item_state = "jackboots"
	item_color = "hosred"

/obj/item/clothing/shoes/cult
	name = "boots"
	desc = "A pair of boots worn by the followers of Chaos."
	icon_state = "cult"
	item_state = "cult"
	item_color = "cult"

	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/cyborg
	name = "cyborg boots"
	desc = "Shoes for a cyborg costume"
	icon_state = "boots"

/obj/item/clothing/shoes/laceup
	name = "laceup shoes"
	desc = "The height of fashion, and they're pre-polished!"
	icon_state = "laceups"

/obj/item/clothing/shoes/roman
	name = "roman sandals"
	desc = "Sandals with buckled leather straps on it."
	icon_state = "roman"
	item_state = "roman"

/obj/item/clothing/shoes/imperialboots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look uncomfortable"
	icon_state = "imperialboots"
	item_state = "imperialboots"
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)

/obj/item/clothing/shoes/imperialboots/reinforced
	name = "Reinforced Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look comfortable"
	icon_state = "flakboots"
	item_state = "flakboots"
	armor = list(melee = 40, bullet = 15, laser = 15,energy = 15, bomb = 30, bio = 0, rad = 5)
	flags = NOSLIP

/obj/item/clothing/shoes/sister
	name = "sister of battle boots"
	desc = "These boots were made for walkin"
	icon_state = "sister"
	item_state = "sister"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	flags = NOSLIP
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/fwboots
	name = "Fire Warrior Boots"
	desc = "Kicking ass for the greater good."
	icon_state = "FWboots"
	item_state = "FWboots"
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)

/obj/item/clothing/shoes/ork
	name = "shoes"
	desc = "Thank you for the new shoes!"
	icon_state = "orkshoes"
	item_state = "orkshoes"


/obj/item/clothing/shoes/sandal/warlockboots
	name = "Boots"
	desc = "For putting into the ass of Mon-kie"
	icon_state = "warlock"
	item_state = "warlock"

//Senseshal

/obj/item/clothing/shoes/hopboots
	name = "Boots"
	desc = "VERY expensive"
	icon_state = "hopboots"
	item_state = "hopboots"