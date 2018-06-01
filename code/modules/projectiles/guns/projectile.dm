/obj/item/weapon/gun/projectile
	desc = "Now comes in flavors like GUN. Uses 10mm ammo, for some reason"
	name = "projectile gun"
	icon_state = "pistol"
	origin_tech = "combat=2;materials=2"
	w_class = 3.0
	m_amt = 1000

	var/mag_type = /obj/item/ammo_box/magazine/m10mm //Removes the need for max_ammo and caliber info
	var/obj/item/ammo_box/magazine/magazine
	var/ejectcasing = 1
	var/chainb = 0
	var/scoped = 0
	var/canscope = 1
	var/zoom = 0
	var/canattach = 1
	var/scopetype = 0

/obj/item/weapon/gun/projectile/New()
	..()
	magazine = new mag_type(src)
	chamber_round()
	update_icon()
	return

/obj/item/weapon/gun/projectile/process_chamber(var/eject_casing = 1, var/empty_chamber = 1)
//	if(in_chamber)
//		return 1
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(isnull(AC) || !istype(AC))
		chamber_round()
		return
	if(eject_casing && ejectcasing)
		AC.loc = get_turf(src) //Eject casing onto ground.
	if(empty_chamber)
		chambered = null
	chamber_round()
	return

/obj/item/weapon/gun/projectile/proc/chamber_round()
	if (chambered || !magazine)
		return
	else if (magazine.ammo_count())
		chambered = magazine.get_round()
		chambered.loc = src
	return

/obj/item/weapon/gun/projectile/attackby(var/obj/item/A as obj, mob/user as mob)
	if (istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if (!magazine && istype(AM, mag_type))
			user.remove_from_mob(AM)
			magazine = AM
			magazine.loc = src
			user << "<span class='notice'>You load a new magazine into \the [src].</span>"
			chamber_round()
			A.update_icon()
			update_icon()
			return 1
		else if (magazine)
			user << "<span class='notice'>There's already a magazine in \the [src].</span>"
	if(istype(A, /obj/item/weapon/scope))
		if(canscope)
			user << "<span class='notice'>[src] can't be fitted with a scope."
			return
		if(scoped)
			user << "<span class='notice'>There is already a scope on the [src]."
			return
		else
			if(istype(A, /obj/item/weapon/scope/advanced))
				src.scopetype = 1
			user << "<span class='notice'>You slide the [A] onto the [src]."
			src.scoped = 1
			update_icon()
			qdel(A)
			return
		..()
	if(istype(A, /obj/item/weapon/chainb))
		if(canattach)
			user << "<span class='notice'>[src] can't be fitted with an attachment like this."
			return
		if(chainb)
			user << "<span class='notice'>There is already an attachment on this [src]."
			return
		else
			user << "<span class='notice'>You slide the [A] onto the [src]."
			src.chainb = 1
			src.force = 32
			update_icon()
			qdel(A)
			return
	if(istype(A, /obj/item/weapon/complexknife/combatknife))
		if(canattach)
			user << "<span class='notice'>[src] can't be fitted with an attachment like this."
			return
		if(chainb)
			user << "<span class='notice'>There is already an attachment on this [src]."
			return
		else
			user << "<span class='notice'>You slide the [A] onto the [src]."
			src.chainb = 1
			src.force = 17
			update_icon()
			qdel(A)
			return
		..()


/obj/item/weapon/gun/projectile/attack_self(mob/living/user as mob)
	if (magazine)
		magazine.loc = get_turf(src.loc)
		user.put_in_hands(magazine)
		magazine.update_icon()
		magazine = null
		user << "<span class='notice'>You pull the magazine out of \the [src].</span>"
	else
		user << "<span class='notice'>There's no magazine in \the [src].</span>"
	update_icon()
	return

/obj/item/weapon/gun/projectile/examine()
	..()
	usr << "Has [get_ammo()] round\s remaining."
	return

/obj/item/weapon/gun/projectile/proc/get_ammo(var/countchambered = 1)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count()
	return boolets

/obj/item/weapon/gun/projectile/attack(mob/M as mob, mob/user)
	if(user.a_intent == "harm") //Flogging
		..()
	if(chainb)
		playsound(M.loc, 'sound/weapons/chainsword.ogg', 75, 0)
		var/obj/item/weapon/grab/G = user.get_inactive_hand()
		if(!G)
			return
		var/mob/living/target = G.affecting
		if(target == M)																		//running down to the riptide
			if(istype(user.get_inactive_hand(), /obj/item/weapon/grab))
				user.visible_message("<span class='danger'><b>[user] begins to cut [target] in two!</b></span>")

				var/check = 7//X seconds before Gibbed, Totally not stolen from the Ninja Net
				while(!isnull(M)&&!isnull(src)&&check>0)//While M and net exist, X seconds have not passed.
					check--
					sleep(10)

			if(istype(user.get_inactive_hand(), /obj/item/weapon/grab))						//I want to be your left hand man
				if(isnull(M)||M.loc!=loc)//If mob is gone or not at the location.
					playsound(loc, 'sound/weapons/chainsword.ogg', 75, 0)
					new /obj/effect/gibspawner/blood(target.loc)
					new /obj/effect/gibspawner/generic(target.loc)
					user.visible_message("<span class='danger'><b>[user] has slashed [target] in half!</b></span>")
					target.gib()															//this cowboys running from himself
					return
	else
		return

/obj/item/weapon/gun/projectile/dropped(mob/user)
	if(user && user.client) user.client.view = world.view

/obj/item/weapon/gun/projectile/verb/zoom()
	if(scoped)
		set category = "Object"
		set name = "Use Scope"
		set popup_menu = 0
		if(!zoom && global_hud.darkMask[1] in usr.client.screen)
			usr << "Your welding equipment gets in the way of you looking down the scope"
			return
		if(!zoom && usr.get_active_hand() != src)
			usr << "You are too distracted to look down the scope, perhaps if it was in your active hand this might work better"
			return

		if(usr.client.view == world.view)
			if(scopetype == 0)
				usr.client.view = 10
				zoom = 1
			if(scopetype == 1)
				usr.client.view = 12
				zoom = 1
			if(scopetype == 2)
				usr.client.view = 15
				zoom = 1
		else
			usr.client.view = world.view
			zoom = 0
		usr << "<font color='[zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>"
		return