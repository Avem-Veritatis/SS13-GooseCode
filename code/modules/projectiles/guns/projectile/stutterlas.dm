/*
Possibly can be used in either...
A) Black market
B) Imperial guard corruption, after defacing the imperial infantryman's uplifting primer
C) A weapon in the armory for imperial guards, overlooking the fact that it is an illegal modification.
*/

/obj/item/weapon/gun/projectile/automatic/stutterlas
	name = "Stutter Lasgun"
	desc = "A lasgun that has been customized illegally to fire quickly."
	icon_state = "stutterlas"
	item_state = "lasgun"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=4"
	mag_type = /obj/item/ammo_box/magazine/stutterlas
	fire_sound = 'sound/weapons/lasgun.ogg'
	ejectcasing = 0