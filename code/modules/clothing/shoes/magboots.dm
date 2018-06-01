/obj/item/clothing/shoes/magboots
	desc = "Magnetic boots, often used during extravehicular activity to ensure the user remains safely attached to the vehicle."
	name = "magboots"
	icon_state = "magboots0"
	var/magboot_state = "magboots"
	var/magpulse = 0
	var/slowdown_off = 2
	action_button_name = "Toggle Magboots"


/obj/item/clothing/shoes/magboots/verb/toggle()
	set name = "Toggle Magboots"
	set category = "Object"
	set src in usr
	attack_self(usr)


/obj/item/clothing/shoes/magboots/attack_self(mob/user)
	if(src.magpulse)
		src.flags &= ~NOSLIP
		src.slowdown = SHOES_SLOWDOWN
		src.magpulse = 0
		icon_state = "[magboot_state]"
		user << "You disable the mag-pulse traction system."
	else
		src.flags |= NOSLIP
		src.slowdown = slowdown_off
		src.magpulse = 1
		icon_state = "[magboot_state]"
		user << "You enable the mag-pulse traction system."
	user.update_inv_shoes(0)	//so our mob-overlays update


/obj/item/clothing/shoes/magboots/examine()
	set src in view()
	..()
	var/state = "disabled"
	if(src.flags&NOSLIP)
		state = "enabled"
	usr << "Its mag-pulse traction system appears to be [state]."


/obj/item/clothing/shoes/magboots/advance
	desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer."
	name = "advanced magboots"
	icon_state = "advmag0"
	magboot_state = "advmag"
	slowdown_off = SHOES_SLOWDOWN

/obj/item/clothing/shoes/magboots/um
	desc = "UltraMarine Boots"
	name = "UltraMarine Boots"
	icon_state = "um_boots"
	magboot_state = "um_boots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/clothing/shoes/magboots/um/captain
	desc = "UltraMarine Captain Boots"
	name = "UltraMarine Captain Boots"
	icon_state = "umcap"
	magboot_state = "umcap"

/obj/item/clothing/shoes/magboots/sm
	desc = "SalamanderMarine Boots"
	name = "SalamanderMarine Boots"
	icon_state = "sl_boots"
	magboot_state = "sl_boots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/clothing/shoes/magboots/rg
	desc = "RavenGuard Boots"
	name = "RavenGuard Boots"
	icon_state = "rg_boots"
	magboot_state = "rg_boots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/clothing/shoes/magboots/rg/shadowcaptain
	desc = "RavenGuard Boots"
	name = "RavenGuard Boots"
	icon_state = "rgboots2"
	magboot_state = "rgboots2"

/obj/item/clothing/shoes/magboots/pm
	desc = "PlagueMarine Boots"
	name = "PlagueMarine Boots"
	icon_state = "pmboots"
	magboot_state = "pmboots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/clothing/shoes/magboots/kb
	desc = "SalamanderMarine Boots"
	name = "SalamanderMarine Boots"
	icon_state = "kbboots"
	magboot_state = "kbboots"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/clothing/shoes/magboots/ksons
	desc = "These are boots.... for the DARK GAWDS!!"
	name = "Chaos Boots"
	icon_state = "1k_boots"
	magboot_state = "1k_boots"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE