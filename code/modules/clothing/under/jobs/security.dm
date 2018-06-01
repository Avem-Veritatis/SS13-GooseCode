/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security + Jensen cosplay gear
 *		Navy uniforms
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Sergeant\" written on the shoulders."
	name = "imperial uniform"
	icon_state = "warden"
	item_state = "r_suit"
	item_color = "warden"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	can_roll = 0

/obj/item/clothing/under/rank/security
	name = "imperial uniform"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "imperial_s"
	item_state = "r_suit"
	item_color = "imperial"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/security/fire
	name = "Fire proof undersuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection against fire"
	has_sensor = 0
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS					//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT

/*
 * Detective
 */
/obj/item/clothing/under/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "commissar"
	item_state = "commissar"
	item_color = "commissar"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Comissar\". It has additional armor to protect the wearer."
	name = "imperial uniform"
	icon_state = "hos"
	item_state = "r_suit"
	item_color = "hosred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	can_roll = 0

/*
 * Jensen cosplay gear
 */
/obj/item/clothing/under/rank/head_of_security/jensen
	name = "imperial uniform"
	desc = "You never asked for anything that stylish."
	icon_state = "jensen"
	item_state = "jensen"
	item_color = "jensen"
	can_roll = 0

/obj/item/clothing/suit/armor/hos/jensen
	name = "armored trenchoat"
	desc = "A trenchoat augmented with a special alloy for some protection and style"
	icon_state = "jensencoat"
	item_state = "jensencoat"
	flags_inv = 0


/*
 * Navy uniforms
 */

/obj/item/clothing/under/rank/security/navyblue
	name = "imperial uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	item_state = "officerblueclothes"
	item_color = "officerblueclothes"
	can_roll = 0

/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Comissar."
	name = "imperial uniform"
	icon_state = "hosblueclothes"
	item_state = "hosblueclothes"
	item_color = "hosblueclothes"
	can_roll = 0

/obj/item/clothing/under/rank/warden/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Sergeant."
	name = "imperial uniform"
	icon_state = "wardenblueclothes"
	item_state = "wardenblueclothes"
	item_color = "wardenblueclothes"
	can_roll = 0