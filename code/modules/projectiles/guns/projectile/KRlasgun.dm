//KRIEGER LASGUN

/obj/item/weapon/gun/projectile/automatic/lasgunkreig
	name = "Lucious Pattern Lasgun"
	desc = "Standed issue ranged weapon of the Imperial Guard"
	icon_state = "lucious"
	item_state = "lucious"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/lasgunmag
	fire_sound = 'sound/weapons/lasgun.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 0
	ejectcasing = 0 //Technically energy based! None of that!

/obj/item/weapon/gun/projectile/automatic/lasgunkreig/process_chamber(var/eject_casing = 0, var/empty_chamber = 1)    //be afraid of my skill
	..()

//with a scope
/obj/item/weapon/gun/projectile/automatic/lasgun/kreig/scope					//KRIEGER LASGUN POST SCOPE
	name = "Lucious Pattern Lasgun"
	desc = "Standed issue ranged weapon of the Imperial Guard with a scope attached."
	icon_state = "luciouss"
	item_state = "lucious"
	slot_flags = SLOT_BACK
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/lasgunmag
	fire_sound = 'sound/weapons/lasgun.ogg'
	scoped = 1
	zoom = 0
	ejectcasing = 0 //Technically energy based! None of that!

/obj/item/weapon/gun/projectile/automatic/lasgunkreigscope/process_chamber(var/eject_casing = 0, var/empty_chamber = 1)    //be afraid of my skill
	..()
