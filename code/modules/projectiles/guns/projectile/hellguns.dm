/*
Hell Gun
*/

/obj/item/weapon/gun/projectile/automatic/hellgun
	name = "Imperial Hellgun"
	desc = "A Hellgun is a pattern of Imperial Lasgun that possesses a more advanced and powerful laser plasma generation system intended to provide more energetic laser fire on-target. This makes the Hellgun superior in both range and power output compared to the standard-issue Lasgun. However, the higher power output requires superior quality power cells."
	icon_state = "hellgun"
	item_state = "lasgun"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/hellgunmag
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	zoom = 0
	canattach = 0
	scopetype = 0
	ejectcasing = 0 //Technically energy based! None of that!

/obj/item/weapon/gun/projectile/automatic/hellgun/process_chamber(var/eject_casing = 0, var/empty_chamber = 1)    //be afraid of my skill
	..()