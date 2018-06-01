
//Bartender
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chef"
	item_state = "chef"

//Captain
/obj/item/clothing/head/caphat
	name = "Lord Commander's hat"
	icon_state = "captain"
	desc = "What is this thing even made out of?"
	item_state = "that"

/obj/item/clothing/head/caphat2
	name = "Lord Commander's hat"
	icon_state = "captain2"
	desc = "What is this thing even made out of?"
	item_state = "captain2"

//Captain: This probably shouldn't be space-worthy
/obj/item/clothing/head/helmet/cap
	name = "captain's cap"
	desc = "You fear to wear it for the negligence it brings."
	icon_state = "capcap"
	flags_inv = 0
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT

//Head of Personnel
/obj/item/clothing/head/hopcap
	name = "Expensive Hat"
	icon_state = "hophat"
	desc = "Made from real cotton."

//Chaplain
/obj/item/clothing/head/chaplain_hood
	name = "chaplain's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags = HEADCOVERSEYES|BLOCKHAIR

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags = HEADCOVERSEYES|BLOCKHAIR

/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "comm"
	item_state = "comm"
	allowed = list(/obj/item/weapon/reagent_containers/food/snacks/candy_corn, /obj/item/weapon/pen)
	armor = list(melee = 50, bullet = 5, laser = 25,energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/head/det_hat/attack_self(mob/user, slot)
	playsound(loc, 'sound/ambience/comisar.ogg', 75, 0)
	..()

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, a mime's favorite headwear."
	icon_state = "beret"

//Security
/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A beret with the security insignia emblazoned on it. For officers that are more inclined towards style than safety."
	icon_state = "beret_badge"


/obj/item/clothing/head/beret/sec/navyhos
	name = "head of security's beret"
	desc = "A beret with the security insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon_state = "hosberet"


/obj/item/clothing/head/beret/sec/navywarden
	name = "warden's beret"
	desc = "A beret with the security insignia emblazoned on it. Not to be mixed with casual attire."
	icon_state = "wardenberet"


/obj/item/clothing/head/beret/sec/navyofficer
	icon_state = "officerberet"


/obj/item/clothing/head/billydonka
	name = "candyman's hat"
	desc = "And the world tastes good 'cause the candyman thinks it should.."
	icon_state = "billydonkahat"
	item_state = "billydonkahat"

//assistant

/obj/item/clothing/suit/cape
	name = "thick cape"
	desc = "A long woolen cape. Take this, it's cold out there."
	icon_state = "cape"
	item_state = "cape"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS|HEAD
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	flags = BLOCKHAIR
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS | HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list(/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/paper,/obj/item/weapon/gun/energy,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/seclite)