/obj/item/weapon/gun/projectile/automatic/exitus
	name = "Exitus Rifle"
	icon_state = "exitus"
	item_state = "exitus"
	slot_flags = SLOT_BACK
	origin_tech = "combat=12;materials=6;syndicate=6"
	desc = "An ultra high tech rifle used by the Imperial assassins known as the Vindicaire temple. Features include armor piercing, homing projectiles, and a very long range thermal scope."
	mag_type = /obj/item/ammo_box/magazine/exitus
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
	recoil = 1
	silenced = 1
	w_class = 5
	zoom = 0
	scoped = 1
	scopetype = 1

/obj/item/weapon/gun/projectile/automatic/exitus/dropped(mob/user)
	user.client.view = world.view
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.tempthermal = 0
	..()

/obj/item/weapon/gun/projectile/automatic/exitus/enforcement
	mag_type = /obj/item/ammo_box/magazine/exitus/enforcement
	flags = NODROP
	silenced = 0