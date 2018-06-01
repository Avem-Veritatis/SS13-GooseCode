//Captain's Spacesuit
/obj/item/clothing/head/helmet/space/capspace
	name = "captain's space helmet"
	icon_state = "capspace"
	item_state = "capspacehelmet"
	desc = "Tissue paper is better than this... you idiot."
	body_parts_covered = CHEST|GROIN
	slowdown = 5
	armor = list(melee = -10, bullet = -5, laser = -5, energy = -5, bomb = -5, bio = -0, rad = -0)

//Captain's space suit This is not the proper path but I don't currently know enough about how this all works to mess with it.
/obj/item/clothing/suit/space/captain
	name = "captain's armor"
	desc = "Tissue paper is better than this... you idiot."
	icon_state = "caparmor"
	item_state = "capspacesuit"
	w_class = 5
	allowed = list(/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy, /obj/item/weapon/gun/projectile, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs)
	slowdown = 5
	armor = list(melee = -10, bullet = -5, laser = -5, energy = -5, bomb = -5, bio = -0, rad = -0)

//Old Spacesuit
/obj/item/clothing/head/helmet/space/oldsuit
	name = "Old Space Helmet"
	desc = "An old fashioned space helmet. Good times."
	icon_state = "spaceold"
	item_state = "spaceold"

/obj/item/clothing/suit/space/oldsuit
	name = "Old Space Suit"
	icon_state = "spaceold"
	item_state = "spaceold"
	desc = "An old fashioned baggy grey space suit. Good times."
	slowdown = 1



//Deathsquad suit
/obj/item/clothing/head/helmet/space/deathsquad
	name = "deathsquad helmet"
	desc = "That's not red paint. That's real blood."
	icon_state = "deathsquad"
	item_state = "deathsquad"
	armor = list(melee = 65, bullet = 55, laser = 35,energy = 20, bomb = 30, bio = 30, rad = 30)

/obj/item/clothing/head/helmet/space/deathsquad/beret
	name = "officer's beret"
	desc = "An armored beret commonly used by special operations officers. Uses forcefield technology to protect the head from space."
	icon_state = "beret_badge"
	armor = list(melee = 65, bullet = 55, laser = 35,energy = 20, bomb = 30, bio = 30, rad = 30)
	flags = STOPSPRESSUREDMAGE
	flags_inv = 0


//NASA Voidsuit
/obj/item/clothing/head/helmet/space/nasavoid
	name = "NASA Void Helmet"
	desc = "An old, NASA Centcom branch designed, dark red space suit helmet."
	icon_state = "void"
	item_state = "void"

/obj/item/clothing/suit/space/nasavoid
	name = "NASA Voidsuit"
	icon_state = "void"
	item_state = "void"
	desc = "An old, NASA Centcom branch designed, dark red Space suit."
	slowdown = 1
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/multitool)


//Space santa outfit suit
/obj/item/clothing/head/helmet/space/santahat
	name = "Santa's hat"
	desc = "Ho ho ho. Merrry X-mas!"
	icon_state = "santahat"
	flags = HEADCOVERSEYES | BLOCKHAIR | STOPSPRESSUREDMAGE

/obj/item/clothing/suit/space/santa
	name = "Santa's suit"
	desc = "Festive!"
	icon_state = "santa"
	item_state = "santa"
	slowdown = 0
	flags = STOPSPRESSUREDMAGE
	allowed = list(/obj/item) //for stuffing exta special presents


//Space pirate outfit
/obj/item/clothing/head/helmet/space/pirate
	name = "pirate hat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)
	flags = HEADCOVERSEYES | BLOCKHAIR | STOPSPRESSUREDMAGE

/obj/item/clothing/suit/space/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)
	slowdown = 0
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)


