//BLOODPACT LASGUN

/obj/item/weapon/gun/projectile/automatic/lasgunc
	name = "Lasgun"
	desc = "Standed issue ranged weapon of the Imperial Guard"
	icon_state = "lasgunc"
	item_state = "chaoslasgun"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/lasgunmag
	fire_sound = 'sound/weapons/lasgun.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 0


/obj/item/weapon/gun/projectile/automatic/lasgunc/process_chamber(var/eject_casing = 0, var/empty_chamber = 1)    //be afraid of my skill
	..()
