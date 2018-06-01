/obj/item/weapon/gun/syringe
	name = "syringe gun"
	desc = "A spring loaded rifle designed to fit syringes, used to incapacitate unruly patients from a distance."
	icon_state = "syringegun"
	item_state = "syringegun"
	w_class = 3
	throw_speed = 3
	throw_range = 7
	force = 4
	m_amt = 2000
	clumsy_check = 0
	fire_sound = 'sound/items/syringeproj.ogg'
	var/list/syringes = list()
	var/max_syringes = 1

/obj/item/weapon/gun/syringe/New()
	..()
	chambered = new /obj/item/ammo_casing/syringegun(src)

/obj/item/weapon/gun/syringe/proc/newshot()
	if(!syringes.len) return

	var/obj/item/weapon/reagent_containers/syringe/S = syringes[1]

	if(!S) return

	chambered.BB = new /obj/item/projectile/bullet/dart/syringe(src)
	S.reagents.trans_to(chambered.BB, S.reagents.total_volume)
	chambered.BB.name = S.name
	syringes.Remove(S)

	qdel(S)
	return

/obj/item/weapon/gun/syringe/process_chamber()
	return

/obj/item/weapon/gun/syringe/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, params)
	newshot()
	..()

/obj/item/weapon/gun/syringe/examine()
	..()
	usr << "Can hold [max_syringes] syringe\s. Has [syringes.len] syringe\s remaining."
	return

/obj/item/weapon/gun/syringe/attack_self(mob/living/user as mob)
	if(!syringes.len)
		user << "<span class='notice'>[src] is empty.</span>"
		return 0

	var/obj/item/weapon/reagent_containers/syringe/S = syringes[syringes.len]

	if(!S) return 0
	S.loc = user.loc

	syringes.Remove(S)
	user << "<span class = 'notice'>You unload [S] from \the [src]!</span>"

	return 1

/obj/item/weapon/gun/syringe/attackby(var/obj/item/A as obj, mob/user as mob, var/show_msg = 1)
	if(istype(A, /obj/item/weapon/reagent_containers/syringe))
		if(syringes.len < max_syringes)
			user.drop_item()
			user << "<span class='notice'>You load [A] into \the [src].</span>"
			syringes.Add(A)
			A.loc = src
			return 1
		else
			usr << "<span class='notice'>[src] cannot hold more syringes.</span>"
	return 0

/obj/item/weapon/gun/syringe/rapidsyringe
	name = "rapid syringe gun"
	desc = "A modification of the syringe gun design, using a rotating cylinder to store up to six syringes."
	icon_state = "rapidsyringegun"
	max_syringes = 6

/obj/item/weapon/gun/syringe/plague
	name = "plague rifle"
	desc = "A chaos-tainted weapon that brings plague upon nurgle's foes."
	icon_state = "plaguegun"
	max_syringes = 12

/obj/item/weapon/gun/syringe/plague/New()
	..()
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))
	syringes.Add(new /obj/item/weapon/reagent_containers/syringe/viral(src))

/obj/item/projectile/bullet/dart/plague
	name = "plague bolt"
	icon_state = "cbbolt"
	damage = 15
	weaken = 3
	force_inject = 1 //Making a new parameter so that decent armor won't completely deflect plague bolt.

/obj/item/ammo_casing/shotgun/dart/plague
	name = "plague bolt"
	desc = "Contains nurgle's blessings."
	icon_state = "pmshell"
	projectile_type = /obj/item/projectile/bullet/dart/plague

/obj/item/ammo_casing/shotgun/dart/plague/New()
	..()
	src.reagents.add_reagent("plague", 25)
	src.reagents.add_reagent("fatigue", 5) //This will allow the bolts to incapacitate as well as infect.

/obj/item/ammo_box/magazine/internal/shotplague
	name = "plague rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/plague
	caliber = "shotgun"
	max_ammo = 64 //This gun doesn't have reloads, so might as well give it lots of ammunition. You also need to pump with each shot.
	multiload = 0

/obj/item/weapon/gun/projectile/shotgun/combat/plague
	name = "plague rifle"
	icon_state = "plaguegun"
	origin_tech = "combat=8;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/shotplague
	w_class = 3
	pump_speed = 3