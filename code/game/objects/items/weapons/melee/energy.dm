/obj/item/weapon/melee/energy/
	var/active = 0
	woundtypes = list(/datum/wound/burn, /datum/wound/slash)

/obj/item/weapon/melee/energy/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</span>", \
						"<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>"))
	return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/melee/energy/rejects_blood()
	return 1

/obj/item/weapon/meele/energy/psword
	name = "Power Sword"
	desc = "An advanced weapon of melee destruction"
	icon_state = "psword"
	item_state = "psword"
	force = 40.0
	throwforce = 25.0
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = 3.0
	flags = CONDUCT | NOSHIELD
	slot_flags = SLOT_BELT
	origin_tech = "combat=3"
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")

/obj/item/weapon/melee/energy/psword/attack_self(mob/user, slot)
	playsound(loc, 'sound/effects/inq.ogg', 75, 0)
	..()

/obj/item/weapon/melee/energy/axe
	name = "energy axe"
	desc = "An energised battle axe."
	icon_state = "axe0"
	force = 40.0
	throwforce = 25.0
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = 3.0
	flags = CONDUCT | NOSHIELD
	origin_tech = "combat=3"
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")

/obj/item/weapon/melee/energy/axe/suicide_act(mob/user)
		user.visible_message("<span class='suicide'>[user] swings the [src.name] towards /his head! It looks like \he's trying to commit suicide.</span>")
		return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/melee/energy/axe/attack_self(mob/user)
	active = !active
	if(active)
		user << "<span class='notice'>[src] is now energised.</span>"
		force = 150 //these are the drugs, friend
		hitsound = 'sound/weapons/blade1.ogg'
		icon_state = "axe1"
		w_class = 5
	else
		user << "<span class='notice'>[src] can now be concealed.</span>"
		force = 40
		hitsound = 'sound/weapons/bladeslice.ogg'
		icon_state = "axe0"
		w_class = 3 //it goes back to three you goose
	add_fingerprint(user)

/obj/item/weapon/melee/energy/sword
	color
	name = "energy sword"
	desc = "May the force be within you."
	icon_state = "sword0"
	force = 3.0
	throwforce = 5.0
	hitsound = "swing_hit" //it starts deactivated
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	flags = NOSHIELD
	origin_tech = "magnets=3;syndicate=4"
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	var/hacked = 0

/obj/item/weapon/melee/energy/sword/New()
	item_color = pick("red", "blue", "green", "purple")

/obj/item/weapon/melee/energy/sword/IsShield()
	if(active)
		return 1
	return 0

/obj/item/weapon/melee/energy/sword/attack_self(mob/living/user)
	if ((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>You accidentally cut yourself with [src], like a doofus!</span>"
		user.take_organ_damage(5,5)
	active = !active
	if (active)
		force = 30
		throwforce = 20
		hitsound = 'sound/weapons/blade1.ogg'
		attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		if(istype(src,/obj/item/weapon/melee/energy/sword))
			icon_state = "sword[item_color]"
		if(istype(src,/obj/item/weapon/melee/energy/sword/pirate))
			icon_state = "cutlass1"
		if(istype(src,/obj/item/weapon/melee/energy/sword/kb))
			icon_state = "kb"
		if(istype(src,/obj/item/weapon/melee/energy/sword/sb))
			icon_state = "sb"
		if(istype(src,/obj/item/weapon/melee/energy/sword/tb))
			icon_state = "tb"
		if(istype(src,/obj/item/weapon/melee/energy/sword/nb))
			icon_state = "nb"
		w_class = 4
		playsound(user, 'sound/weapons/saberon.ogg', 35, 1) //changed it from 50% volume to 35% because deafness
		user << "<span class='notice'>[src] is now active.</span>"
	else
		force = 3
		throwforce = 5.0
		hitsound = "swing_hit"
		attack_verb = null
		if(istype(src,/obj/item/weapon/melee/energy/sword/pirate))
			icon_state = "cutlass0"
		else
			icon_state = "sword0"
		w_class = 2
		playsound(user, 'sound/weapons/saberoff.ogg', 35, 1)  //changed it from 50% volume to 35% because deafness
		user << "<span class='notice'>[src] can now be concealed.</span>"
	add_fingerprint(user)
	return

/obj/item/weapon/melee/energy/sword/attackby(obj/item/weapon/W, mob/living/user)
	..()
	if(istype(W, /obj/item/weapon/melee/energy/sword/kb) && istype(src, /obj/item/weapon/melee/energy/sword/kb) && W != src)
		user << "<span class='notice'>You attach the ends of the two energy swords, making a single double-bladed weapon!</span>"
		user << "<b>BLOOD FOR THE BLOOD GOD!!!</b>"
		new /obj/item/weapon/twohanded/dualsaber/khorne(user.loc)
		user.unEquip(W)
		user.unEquip(src)
		qdel(W)
		qdel(src)
		return
	if(istype(W, /obj/item/weapon/melee/energy/sword))
		if(W == src) //Not sure if this is actually possible seeing how procs work.
			user << "<span class='notice'>You try to attach the end of the energy sword to... itself. You're not very smart, are you?</span>"
			if(ishuman(user))
				user.adjustBrainLoss(10)
		else
			user << "<span class='notice'>You attach the ends of the two energy swords, making a single double-bladed weapon! You're cool.</span>"
			var/obj/item/weapon/twohanded/dualsaber/newSaber = new /obj/item/weapon/twohanded/dualsaber(user.loc)
			if(src.hacked) // That's right, we'll only check the "original" esword.
				newSaber.hacked = 1
				newSaber.item_color = "rainbow"
			user.unEquip(W)
			user.unEquip(src)
			qdel(W)
			qdel(src)
	else if(istype(W, /obj/item/device/multitool))
		if(hacked == 0)
			hacked = 1
			item_color = "rainbow"
			user << "<span class='warning'>RNBW_ENGAGE</span>"

			if(active)
				icon_state = "swordrainbow"
				user.update_inv_hands(0)
		else
			user << "<span class='warning'>It's already fabulous!</span>"

/obj/item/weapon/melee/energy/sword/cyborg
	var/hitcost = 500

/obj/item/weapon/melee/energy/sword/cyborg/attack(mob/M, var/mob/living/silicon/robot/R)
	if(R.cell)
		var/obj/item/weapon/stock_parts/cell/C = R.cell
		if(active && !(C.use(hitcost)))
			attack_self(R)
			R << "<span class='notice'>It's out of charge!</span>"
			return
		..()
	return

/obj/item/weapon/melee/energy/sword/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(active)
		if(istype(src, /obj/item/weapon/melee/energy/sword/kb))
			new /obj/effect/gibspawner/blood(M.loc)
		else
			if(prob(20)) new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/melee/energy/sword/pirate
	name = "energy cutlass"
	desc = "Arrrr matey."
	icon_state = "cutlass0"

/obj/item/weapon/melee/energy/sword/kb
	name = "sword handle"
	desc = "There is something unholy about this device."
	icon_state = "sword0"

/obj/item/weapon/melee/energy/sword/sb
	name = "sword handle"
	desc = "There is something unholy about this device."
	icon_state = "sword0"

/obj/item/weapon/melee/energy/sword/tb
	name = "sword handle"
	desc = "There is something unholy about this device."
	icon_state = "sword0"

/obj/item/weapon/melee/energy/sword/nb
	name = "sword handle"
	desc = "There is something unholy about this device."
	icon_state = "sword0"
	slot_flags = SLOT_BELT

/obj/item/weapon/melee/energy/sword/green
	New()
		item_color = "green"

/obj/item/weapon/melee/energy/sword/red
	New()
		item_color = "red"

/obj/item/weapon/melee/energy/blade
	name = "energy blade"
	desc = "A concentrated beam of energy in the shape of a blade. Very stylish... and lethal."
	icon_state = "blade"
	force = 70.0//Normal attacks deal very high damage.
	hitsound = 'sound/weapons/blade1.ogg'
	throwforce = 1//Throwing or dropping the item deletes it.
	throw_speed = 3
	throw_range = 1
	w_class = 4.0//So you can't hide it in your pocket or some such.
	flags = NOSHIELD
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	var/datum/effect/effect/system/spark_spread/spark_system

//Most of the other special functions are handled in their own files. aka special snowflake code so kewl
/obj/item/weapon/melee/energy/blade/New()
	spark_system = new /datum/effect/effect/system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/weapon/melee/energy/blade/dropped()
	qdel(src)

/obj/item/weapon/melee/energy/blade/proc/grabthrow()
	qdel(src)
