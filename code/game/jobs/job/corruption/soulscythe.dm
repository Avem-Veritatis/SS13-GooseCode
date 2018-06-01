/*
This is a bit of code I made a little while back. I am just migrating it over so I can make use of some of its components in the slaanesh dagger.
-Drake
*/

/obj/item/weapon/soulscythe  //A weapon inlaid with soulstones that holds multiple souls from people you kill.
	icon_state = "scythe0"
	name = "Soul Scythe"
	desc = "A wicked edged scythe inlaid with blood red soulstone fragments and covered in patterns that seem to shift before your eyes. Staring at it too long makes your head hurt."
	force = 40.0
	throwforce = 80.0
	throw_speed = 6
	throw_range = 3
	w_class = 4.0
	flags = CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = "materials=2;combat=2"
	attack_verb = list("sliced", "reaped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/soulstones = list()

/obj/item/weapon/soulscythe/New()
	..()
	soulstones += new /obj/item/device/soulstone(src) //ten attatched soulstones
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src)
	soulstones += new /obj/item/device/soulstone(src) //I could use a for loop but I am lazy and its just ten copy/pastes  -Drake

/obj/item/weapon/soulscythe/IsShield()
		return 1

/obj/item/weapon/soulscythe/attack(mob/living/M as mob, mob/user as mob)
	..()
	for(var/obj/item/device/soulstone/stone in soulstones)
		if(istype(M,/mob/living/simple_animal/shade))
			if(stone.imprinted == M.name)
				stone.attack(M, user)
				return
	for(var/obj/item/device/soulstone/stone in soulstones)
		if(stone.imprinted == "empty")
			stone.attack(M, user)
			return

/obj/item/weapon/soulscythe/attack_self(mob/user)
	..()
	var/viewed = 0
	for(var/obj/item/device/soulstone/stone in soulstones)
		if(!viewed)
			if(stone.imprinted != "empty")
				if(stone.contents.len)
					viewed = 1
					stone.attack_self(user)

/obj/item/weapon/soulscythe/throw_impact(atom/hit_atom)
	..()
	if(isliving(hit_atom))
		var/mob/living/vict = hit_atom
		vict.visible_message("\red The [src] swings in midair as if it had a mind of its own, pointing like a compass needle to [hit_atom]'s heart as its point slashes them!", \
	"\red You feel a stabbing pain in your chest as the [src] drives itself towards your heart!.", \
	"\red You hear the sound of steel slicing through flesh.")