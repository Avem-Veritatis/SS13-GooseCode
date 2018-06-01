/*
LASGUNS
*/

//Lasguns

/obj/item/weapon/gun/projectile/automatic/lasgun
	name = "Lasgun"
	desc = "Standed issue ranged weapon of the Imperial Guard"
	icon_state = "lasgun"
	item_state = "lasgun"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/lasgunmag
	fire_sound = 'sound/weapons/lasgun.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	zoom = 0
	canattach = 0
	scopetype = 0
	ejectcasing = 0 //Technically energy based! None of that!

/obj/item/weapon/gun/projectile/automatic/lasgun/process_chamber(var/eject_casing = 0, var/empty_chamber = 1)    //be afraid of my skill
	..()

/*
Adding a lascannon here because I would rather not make a new file for a simple additional las-weapon.
*/

/obj/item/weapon/gun/projectile/automatic/lascannon
	name = "Las-Cannon"
	desc = "A heavy las-weapon that is particularly effective against armored opponents."
	icon_state = "lascannon"
	item_state = "lascannon"
	origin_tech = "combat=7;materials=3;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/lascannonmag
	fire_sound = 'sound/weapons/lasgun.ogg'
	ejectcasing = 0 //Technically energy based! None of that!