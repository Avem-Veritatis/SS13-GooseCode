obj/item/weapon/gun/magic/staff/
	slot_flags = SLOT_BACK

obj/item/weapon/gun/magic/staff/change
	name = "staff of change"
	desc = "An artefact that spits bolts of coruscating energy which cause the target's very form to reshape itself"
	ammo_type = /obj/item/ammo_casing/magic/change
	icon_state = "staffofchange"
	item_state = "staffofchange"

obj/item/weapon/gun/magic/staff/animate
	name = "staff of animation"
	desc = "An artefact that spits bolts of life-force which causes objects which are hit by it to animate and come to life! This magic doesn't affect machines."
	ammo_type = /obj/item/ammo_casing/magic/animate
	icon_state = "staffofanimation"
	item_state = "staffofanimation"

obj/item/weapon/gun/magic/staff/healing
	name = "staff of healing"
	desc = "An artefact that spits bolts of restoring magic which can remove ailments of all kinds and even raise the dead."
	ammo_type = /obj/item/ammo_casing/magic/heal
	icon_state = "staffofhealing"
	item_state = "staffofhealing"

obj/item/weapon/gun/magic/staff/chaos
	name = "staff of chaos"
	desc = "An artefact that spits bolts of chaotic magic that can potentially do anything."
	ammo_type = /obj/item/ammo_casing/magic/chaos
	icon_state = "staffofhealing"
	item_state = "staffofhealing"
	max_charges = 10
	recharge_rate = 2
	no_den_usage = 1

obj/item/weapon/gun/magic/staff/door
	name = "staff of door creation"
	desc = "An artefact that spits bolts of transformative magic that can create doors in walls."
	ammo_type = /obj/item/ammo_casing/magic/door
	icon_state = "staffofhealing"
	item_state = "staffofhealing"
	max_charges = 10
	recharge_rate = 2
	no_den_usage = 1

/obj/item/weapon/misslea
	name = "Krak Missile"
	desc = "It's a freaking missile!"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "missilea"
	w_class = 2

/obj/item/weapon/plasmisslea
	name = "Plasma Missile"
	desc = "It's an emperor-damned PLASMA MISSILE!"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "plasmissilea"
	w_class = 2

/obj/item/weapon/gun/magic/staff/misslelauncher
	name = "Missile Launcher"
	desc = "A standard Imperial light anti-armor weapon."
	ammo_type = /obj/item/ammo_casing/magic/misslelauncher
	icon_state = "ml"
	item_state = "ml"
	fire_sound = 'sound/weapons/missle.ogg'
	max_charges = 1 //8, 4, 4, 3
	can_charge = 0

/obj/item/weapon/gun/magic/staff/misslelauncher/shoot_with_empty_chamber(mob/living/user as mob|obj)
	user << "<span class='warning'>CLICK.<span>"
	return

/obj/item/weapon/gun/magic/staff/misslelauncher/attackby(obj/item/I as obj, mob/user as mob)		//stealing from silencer
	if(istype(I, /obj/item/weapon/misslea))
		if(charges > 0)
			user << "The [src] is already loaded."
			return
		else
			chambered.projectile_type = /obj/item/projectile/magic/missle
			charges++
			user << "You slide the [I] into the [src]"
			qdel(I)
	if(istype(I, /obj/item/weapon/grenade/syndieminibomb))
		if(charges > 0)
			user << "The [src] is already loaded."
			return
		else
			chambered.projectile_type = /obj/item/projectile/magic/missle/khorne
			charges++
			user << "You slide the [I] into the [src]"
			qdel(I)
	if(istype(I, /obj/item/weapon/plasmisslea))
		if(charges > 0)
			user << "The [src] is already loaded."
			return
		else
			chambered.projectile_type = /obj/item/projectile/magic/missle/plasma
			charges++
			user << "You slide the [I] into the [src]"
			qdel(I)
	..()
