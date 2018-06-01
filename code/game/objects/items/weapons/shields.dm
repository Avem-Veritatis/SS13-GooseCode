/obj/item/weapon/shield
	name = "shield"

/obj/item/weapon/shield/riot
	name = "riot shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "riot"
	slot_flags = SLOT_BACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 4
	w_class = 4.0
	g_amt = 7500
	m_amt = 1000
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

	IsShield()
		return 1

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/melee/baton))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
				cooldown = world.time
		else
			..()

/obj/item/weapon/shield/nob
	name = "riot shield"
	desc = "It looks like it was ripped off a sentinal."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "nobshield"
	slot_flags = SLOT_BACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 4
	w_class = 4.0
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

	IsShield()
		return 1

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/melee/baton))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
				cooldown = world.time
		else
			..()


/obj/item/weapon/shield/riot/roman
	name = "roman shield"
	desc = "Bears an inscription on the inside: <i>\"Romanes venio domus\"</i>."
	icon_state = "roman_shield"
	item_state = "roman_shield"

/obj/item/weapon/shield/riot/imperial
	name = "imperial shield"
	desc = "Standard shield of the imperial guard."
	icon_state = "shieldimp"
	item_state = "shieldimp"

/obj/item/weapon/shield/riot/ksons
	name = "Thousand Sons Legion Shield"
	desc = "A shield. You block things with it."
	icon_state = "ksonsshield"
	item_state = "ksonsshield"

/obj/item/weapon/shield/riot/makeshift
	name = "makeshift shield"
	desc = "A makeshift slab shield."
	icon_state = "shieldmakeshift"
	item_state = "shieldmakeshift"
	slot_flags = 0

/obj/item/weapon/shield/energy //Now with a new sprite!
	name = "energy combat shield"
	desc = "A shield capable of stopping most projectile and melee attacks. Energy projectiles are reflected. It can be retracted, expanded, and stored anywhere."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "eshield0" // eshield21 for expanded
	force = 3.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 4
	w_class = 1
	origin_tech = "materials=4;magnets=3;syndicate=4"
	attack_verb = list("shoved", "bashed")
	var/active = 0
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	external_icon = list('icons/mob/inhand/items_righthand2.dmi', 'icons/mob/inhand/items_lefthand2.dmi')

/obj/item/weapon/shield/energy/IsShield()
	return (active)

/obj/item/weapon/shield/energy/IsReflect()
	return (active)

/obj/item/weapon/shield/energy/attack_self(mob/living/user)
	if((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>You beat yourself in the head with [src].</span>"
		user.take_organ_damage(5)
	active = !active

	if(active)
		force = 10
		icon_state = "eshield[active]"
		w_class = 4
		playsound(user, 'sound/weapons/saberon.ogg', 35, 1)
		user << "<span class='notice'>[src] is now active.</span>"
		reflect_chance = 40
	else
		force = 3
		icon_state = "eshield[active]"
		w_class = 1
		playsound(user, 'sound/weapons/saberoff.ogg', 35, 1)
		user << "<span class='notice'>[src] can now be concealed.</span>"
		reflect_chance = 0
	add_fingerprint(user)

/obj/item/weapon/shield/energy/dropped()
	qdel(src)

/*
Stormshield
*/

/obj/item/weapon/shield/stormshield
	name = "Storm Shield"
	desc = "A Storm Shield is a Power Shield that is used by the Space Marines and sometimes by Inquisitors of the Ordo Malleus to provide an extreme form of protection from ranged weapons fire and potent melee strikes."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "storm"
	slot_flags = SLOT_BACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 4
	w_class = 4.0
	g_amt = 7500
	m_amt = 1000
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

	IsShield()
		return 1

/obj/item/weapon/twohanded/required/rotshield
	name = "Rotten shield"
	desc = "The standart astartes crusade era boarding shield. At least, it used to be that."
	icon_state = "rot_shield"
	item_state = "rot_shield"
	force = 20
	force_wielded = 20
	w_class = 4.0
	slot_flags = SLOT_BACK
	throwforce = 5
	throw_speed = 3
	throw_range = 3
	can_parry = 1
	hitsound = 'sound/effects/shieldbash.ogg'
	attack_verb = list("bashed", "shoved")
	parryprob = 300
	parryduration = 30
	external_icon = list('icons/mob/inhand/items_righthand2.dmi', 'icons/mob/inhand/items_lefthand2.dmi')

/obj/item/weapon/twohanded/required/rotshield/update_icon()
	icon_state = "rot_shield"
	item_state = "rot_shield"
	return

/obj/item/weapon/twohanded/required/rotshield/IsShield()
	return 2 //Defined new shield behavior, this is a lot better of a shield but it is two handed.

/*
ORIGENAL ENERGY SHIELD

/obj/item/weapon/shield/energy
	name = "energy combat shield"
	desc = "A shield capable of stopping most projectile and melee attacks. Energy projectiles are reflected. It can be retracted, expanded, and stored anywhere."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "eshield0" // eshield1 for expanded
	force = 3.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 4
	w_class = 1
	origin_tech = "materials=4;magnets=3;syndicate=4"
	attack_verb = list("shoved", "bashed")
	var/active = 0
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/weapon/shield/energy/IsShield()
	return (active)

/obj/item/weapon/shield/energy/IsReflect()
	return (active)

/obj/item/weapon/shield/energy/attack_self(mob/living/user)
	if((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>You beat yourself in the head with [src].</span>"
		user.take_organ_damage(5)
	active = !active

	if(active)
		force = 10
		icon_state = "eshield[active]"
		w_class = 4
		playsound(user, 'sound/weapons/saberon.ogg', 35, 1)
		user << "<span class='notice'>[src] is now active.</span>"
		reflect_chance = 40
	else
		force = 3
		icon_state = "eshield[active]"
		w_class = 1
		playsound(user, 'sound/weapons/saberoff.ogg', 35, 1)
		user << "<span class='notice'>[src] can now be concealed.</span>"
		reflect_chance = 0
	add_fingerprint(user)
*/
