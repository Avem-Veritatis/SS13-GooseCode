/obj/item/weapon/chainb
	name = "Attatchable chain blade"
	desc = "An attachable chain blade"
	icon = 'icons/obj/gun.dmi'
	icon_state = "caxea"
	w_class = 2
	force = 26
	throwforce = 10
	hitsound = 'sound/weapons/chainsword.ogg'
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")

/obj/item/weapon/scope
	name = "Attatchable scope"
	desc = "A standard scope"
	icon = 'icons/obj/gun.dmi'
	icon_state = "scope"
	w_class = 2
	var/scopetype = 0

/obj/item/weapon/scope/advanced
	name = "Advanced attatchable scope"
	desc = "An advanced scope"
	icon = 'icons/obj/gun.dmi'
	icon_state = "scope"
	w_class = 2
	scopetype = 1
