/*
	Changeling Mutations! ~By Miauw
	Contains:
		Arm Blade
		Space Suit
	TODO:
		Shield
		Armor
*/

/obj/effect/proc_holder/changeling/arm_blade
	name = "Ctan Phase Blade"
	desc = "This is a metal blade of unknown composition that, through the use of highly advanced Necron physics, is capable of slicing through any object irrespective of its physical properties."
	helptext = "Cannot be used while in lesser form."
	chemical_cost = 20
	dna_cost = 1
	genetic_damage = 8
	req_human = 1


/obj/effect/proc_holder/changeling/arm_blade/try_to_sting(var/mob/user, var/mob/target)
	if(istype(user.l_hand, /obj/item/weapon/complexsword/arm_blade)) //Not the nicest way to do it, but eh
		qdel(user.l_hand)
		user.visible_message("<span class='warning'>[user] retracts the blade into a small wrist mount.</span>", "<span class='notice'>You hide your weapon</span>", "<span class='warning>What was that sound?</span>")
		user.update_inv_hands()
		return
	if(istype(user.r_hand, /obj/item/weapon/complexsword/arm_blade))
		qdel(user.r_hand)
		user.visible_message("<span class='warning'>[user] retracts the blade into a small wrist mount.</span>", "<span class='notice'>You hide your weapon</span>", "<span class='warning>What was that sound?</span>")
		user.update_inv_hands()
		return
	..(user, target)

/obj/effect/proc_holder/changeling/arm_blade/sting_action(var/mob/user)
	if(!user.drop_item())
		user << "The [user.get_active_hand()] is stuck to your hand! Manual Dexterity FTL!"
		return
	user.put_in_hands(new /obj/item/weapon/complexsword/arm_blade(user))
	return 1

/obj/item/weapon/complexsword/arm_blade
	name = "Ctan Phase Blade"
	desc = "This is a metal blade of unknown composition that, through the use of highly advanced Necron physics, is capable of slicing through any object irrespective of its physical properties."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	flags = ABSTRACT | NODROP
	w_class = 5.0
	force = 100
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0

/obj/item/weapon/complexsword/arm_blade/New()
	..()
	if(ismob(loc))
		loc.visible_message("<span class='warning'>A thin green blade slides out of [loc.name]\'s arm!</span>", "<span class='warning'>You ready your phase blade.</span>", "<span class='warning'>You hear a pulse of energy crackle to life!</span>")

/obj/item/weapon/complexsword/arm_blade/dropped(mob/user)
	visible_message("<span class='warning'>[user] retracts the blade and hides it in a wrist mounted compartment</span>", "<span class='notice'>You put the blade away.</span>", "<span class='warning>What was that?!</span>")
	qdel(src)

/obj/item/weapon/complexsword/arm_blade/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/structure/table))
		var/obj/structure/table/T = target
		T.table_destroy(1, user)

	if(istype(target,/turf/simulated/wall))
		target.ex_act(2)

	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user) //muh copypasta

	else if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/A = target

		if(!A.requiresID() || A.allowed(user)) //This is to prevent stupid shit like hitting a door with an arm blade, the door opening because you have acces and still getting a "the airlocks motors resist our efforts to force it" message.
			return

		if(A.arePowerSystemsOn() && !(A.stat & NOPOWER))
			user << "<span class='notice'>The airlock's motors resist our efforts to force it. But you prove stronger!</span>"
			A.open(1)

		else if(A.locked)
			user << "<span class='notice'>The airlock's bolts prevent it from being forced.</span>"
			return

		else
			//user.say("Heeeeeeeeeerrre's Johnny!")
			user.visible_message("<span class='warning'>[user] forces the door to open with \his [src]!</span>", "<span class='warning'>You force the door to open.</span>", "<span class='warning'>You hear a metal screeching sound.</span>")
			A.open(1)

/obj/item/weapon/complexsword/arm_blade/attack(mob/living/M as mob, mob/user as mob)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/*
Neural Shredder
*/
/obj/item/weapon/gun/energy/neuralshredder
	name = "Neural Shredder"
	desc = "A very deadly weapon used by members of the Officio Assassinorum."
	icon_state = "ns"
	w_class = 2.0
	item_state = "ns"
	m_amt = 2000
	origin_tech = "combat=2"
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	cell_type = "/obj/item/weapon/stock_parts/cell/super"
	var/charge_tick = 0


	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()


	process()
		charge_tick++
		if(charge_tick < 4) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(50)
		return 1


	update_icon()
		return

/obj/effect/proc_holder/changeling/neuralshredder
	name = "Neural Shredder"
	desc = "The Neural Shredder is of unknown origin, although some speculate that it is but one of a range of psychic weapons developed by the Adeptus Astra Telepathica."
	helptext = "Cannot be used while in lesser form."
	chemical_cost = 20
	dna_cost = 1
	genetic_damage = 8
	req_human = 1

/obj/effect/proc_holder/changeling/neuralshredder/try_to_sting(var/mob/user, var/mob/target)
	if(istype(user.l_hand, /obj/item/weapon/gun/energy/neuralshredder)) //Not the nicest way to do it, but eh
		qdel(user.l_hand)
		user.visible_message("<span class='warning'>[user] quickly hides the gun.</span>", "<span class='notice'>You hide the gun</span>", "<span class='warning>You did not just hear an assasin hiding a gun.</span>")
		user.update_inv_hands()
		return
	if(istype(user.r_hand, /obj/item/weapon/gun/energy/neuralshredder))
		qdel(user.r_hand)
		user.visible_message("<span class='warning'>[user] quickly hides the gun.</span>", "<span class='notice'>You hide the gun</span>", "<span class='warning>You did not just hear an assasin hiding a gun.</span>")
		user.update_inv_hands()
		return
	..(user, target)

/obj/effect/proc_holder/changeling/neuralshredder/sting_action(var/mob/user)
	if(!user.drop_item())
		user << "The [user.get_active_hand()] is stuck to your hand, put it away first."
		return
	user.put_in_hands(new /obj/item/weapon/gun/energy/neuralshredder(user))
	return 1

/obj/item/weapon/gun/energy/neuralshredder/New()
	..()
	if(ismob(loc))
		loc.visible_message("<span class='warning'>[loc.name]\'s pulls out a gun!</span>", "<span class='warning'>Your Neural Shredder hums to life.</span>", "<span class='warning'>Invisible airwaves crackle with life!</span>")

/obj/item/weapon/gun/energy/neuralshredder/dropped(mob/user)
	visible_message("<span class='warning'>[user] quickly hides the neural shredder.</span>", "<span class='notice'>You put neural shredder away.</span>", "<span class='warning>What was that?!</span>")
	qdel(src)