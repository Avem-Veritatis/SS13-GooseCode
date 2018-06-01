var/list/DUALWIELDABLES = list(/obj/item/weapon/gun/projectile/automatic/silenced, /obj/item/weapon/gun/projectile/automatic/deagle, /obj/item/weapon/gun/projectile/automatic/pistol, /obj/item/weapon/gun/projectile/automatic/laspistol, /obj/item/weapon/gun/projectile/automatic/laspistol2, /obj/item/weapon/gun/projectile/automatic/flaregun, /obj/item/weapon/gun/projectile/automatic/hellpistol, /obj/item/weapon/gun/projectile/automatic/needler, /obj/item/weapon/gun/energy/plasma/pistol, /obj/item/weapon/gun/energy/decloner, /obj/item/weapon/gun/energy/floragun, /obj/item/weapon/gun/energy/pulse_rifle/tau/pistol, /obj/item/weapon/gun/energy/taser, /obj/item/weapon/gun/energy/eldarpistol, /obj/item/weapon/gun/projectile/revolver, /obj/item/weapon/gun/projectile/automatic/bpistol)

/obj/item/weapon/twohanded/required/dualpistol
	name = "Dual Wielded Pistols"
	desc = "A set of generic dual wielded pistols that should never exist. Please report the bug to somebody."
	icon = 'icons/obj/gun.dmi'
	icon_state = "revolver"
	item_state = "dualpistol"
	w_class = 5
	throw_range = 0
	force = 15
	attack_verb = list("bludgeoned")
	var/obj/item/weapon/gun/projectile/gun1
	var/obj/item/weapon/gun/projectile/gun2
	var/cooldown = 1

/obj/item/weapon/twohanded/required/dualpistol/proc/assemble(var/obj/item/weapon/gun/projectile/guns1, var/obj/item/weapon/gun/projectile/guns2)
	src.name = "[guns1] and [guns2] (wielded)"
	src.desc = "A [guns1] and a [guns2] dual wielded."
	src.icon = guns1.icon
	src.icon_state = guns1.icon_state
	var/image/I = image(guns2.icon, icon_state = guns2.icon_state)
	I.pixel_x += 5
	I.pixel_y += 5
	src.overlays += I
	guns1.loc = src
	guns2.loc = src
	gun1 = guns1
	gun2 = guns2
	return

/obj/item/weapon/twohanded/required/dualpistol/proc/dismantle()
	gun1.loc = get_turf(src)
	gun2.loc = get_turf(src)
	if(usr.get_inactive_hand()) //Sanity check because of a runtime... I guess maybe if the holder gets deleted this can be a problem.
		qdel(usr.get_inactive_hand()) //Should remove their off hand twohanded object.
	qdel(src)

/obj/item/weapon/twohanded/required/dualpistol/attack_self(mob/living/user as mob)
	dismantle()

/obj/item/weapon/twohanded/required/dualpistol/dropped()
	dismantle()

/obj/item/weapon/twohanded/required/dualpistol/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		if(istype(gun1, /obj/item/weapon/gun/energy))
			var/obj/item/weapon/gun/energy/E = gun1
			E.newshot()
		if(istype(gun2, /obj/item/weapon/gun/energy))
			var/obj/item/weapon/gun/energy/E = gun2
			E.newshot()
		if(gun1.chambered)
			if(!gun1.chambered.fire(target, user, null, 0, 0))
				gun1.shoot_with_empty_chamber(user)
			else
				if(get_dist(user, target) <= 1)
					gun1.shoot_live_shot(user, 1, target)
				else
					gun1.shoot_live_shot(user)
		else
			gun1.shoot_with_empty_chamber(user)
		gun1.process_chamber()
		gun1.update_icon()
		sleep(1)
		if(gun2.chambered)
			if(!gun2.chambered.fire(target, user, null, 0, 0))
				gun2.shoot_with_empty_chamber(user)
			else
				if(get_dist(user, target) <= 1)
					gun2.shoot_live_shot(user, 1, target)
				else
					gun2.shoot_live_shot(user)
		else
			gun2.shoot_with_empty_chamber(user)
		gun2.process_chamber()
		gun2.update_icon()
		cooldown = 0
		sleep(3)
		cooldown = 1
	return

/mob/living/carbon/human/verb/dual_wield()
	set name = "Dual Wield Pistols"
	set category = "IC"

	var/obj/item/I1 = src.get_active_hand()
	var/obj/item/I2 = src.get_inactive_hand()

	if(!I1 || !I2)
		src << "\red You have to be holding two pistols to do this..."
		return

	if(!(I1.type in DUALWIELDABLES))
		src << "\red The [I1] is not something you can dual wield."
		return
	if(!(I2.type in DUALWIELDABLES))
		src << "\red The [I2] is not something you can dual wield."
		return
	if(I1.flags & NODROP || I2.flags & NODROP)
		src << "\red You can't do this with weapons that are stuck to your hands!"
		return

	src.drop_items()
	var/obj/item/weapon/twohanded/required/dualpistol/DP = new(src)
	DP.assemble(I1, I2)
	DP.wielded = 1
	src.put_in_active_hand(DP)
	var/obj/item/weapon/twohanded/offhand/O = new /obj/item/weapon/twohanded/offhand(src)
	src.put_in_inactive_hand(O)