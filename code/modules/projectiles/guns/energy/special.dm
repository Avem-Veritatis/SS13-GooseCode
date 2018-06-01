/obj/item/weapon/gun/energy/ionrifle
	name = "ion rifle"
	desc = "A man portable anti-armor weapon designed to disable mechanical threats"
	icon_state = "ionrifle"
	item_state = null	//so the human update icon uses the icon_state instead.
	origin_tech = "combat=2;magnets=4"
	w_class = 5
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/ion)

/obj/item/weapon/gun/energy/tester
	name = "pixel tester gun"
	desc = "Used to test a completely new projectile computation system. If are seeing this, you or somebody near you is probably spending too much time pressing all the buttons in front of them."
	icon_state = "decloner"
	origin_tech = "combat=9001"
	ammo_type = list(/obj/item/ammo_casing/energy/tester, /obj/item/ammo_casing/energy/laser/scattertest)
	alpha = 120

/obj/item/weapon/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon_state = "decloner"
	origin_tech = "combat=5;materials=4;powerstorage=3"
	ammo_type = list(/obj/item/ammo_casing/energy/declone)

/obj/item/weapon/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon_state = "flora"
	item_state = "obj/item/gun.dmi"
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut)
	origin_tech = "materials=2;biotech=3;powerstorage=3"
	modifystate = 1
	var/charge_tick = 0
	var/mode = 0 //0 = mutate, 1 = yield boost

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
		power_supply.give(100)
		update_icon()
		return 1

	attack_self(mob/living/user as mob)
		select_fire(user)
		update_icon()
		return

/obj/item/weapon/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon_state = "riotgun"
	item_state = "c20r"
	w_class = 4
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	cell_type = "/obj/item/weapon/stock_parts/cell/potato"
	clumsy_check = 0 //Admin spawn only, might as well let clowns use it.
	var/charge_tick = 0
	var/recharge_time = 5 //Time it takes for shots to recharge (in ticks)

	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()

	process()
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(100)

	update_icon()
		return


/obj/item/weapon/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	w_class = 1


/obj/item/weapon/gun/energy/mindflayer
	name = "mind flayer"
	desc = "A prototype weapon recovered from the ruins of Research-Station Epsilon."
	icon_state = "xray"
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)

/obj/item/weapon/gun/energy/kinetic_accelerator
	name = "proto-kinetic accelerator"
	desc = "According to Nanotrasen accounting, this is mining equipment. It's been modified for extreme power output to crush rocks, but often serves as a miner's first defense against hostile alien life; it's not very powerful unless used in a low pressure environment."
	icon_state = "kineticgun"
	item_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic)
	cell_type = "/obj/item/weapon/stock_parts/cell/crap"
	var/overheat = 0
	var/recent_reload = 1

/obj/item/weapon/gun/energy/kinetic_accelerator/shoot_live_shot()
	overheat = 1
	spawn(20)
		overheat = 0
		recent_reload = 0
	..()

/obj/item/weapon/gun/energy/kinetic_accelerator/attack_self(var/mob/living/user/L)
	if(overheat || recent_reload)
		return
	power_supply.give(500)
	playsound(src.loc, 'sound/weapons/shotgunpump.ogg', 60, 1)
	recent_reload = 1
	update_icon()
	return

/obj/item/weapon/gun/energy/disabler
	name = "disabler"
	desc = "A self defense weapon that exhausts targets, weakening them until they collapse. Non-lethal."
	icon_state = "disabler"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	cell_type = "/obj/item/weapon/stock_parts/cell"

/*
Plasma Gun
*/

/obj/item/weapon/gun/energy/plasma
	name = "Plasma Pistol"
	desc = "A very deadly weapon used by high ranking members of the Imperium..."
	icon_state = "ppistol"
	w_class = 2.0
	item_state = "plaspistol"
	m_amt = 2000
	origin_tech = "combat=2"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
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

/obj/item/weapon/gun/energy/plasma/LCBionicGun
	name = "Plasma Gun"
	desc = "A bionic implant threaded into your arm all ghost in the shell style. Remember to untoggle it before toggling anything else."
	icon_state = "ppistol"
	w_class = 2.0
	item_state = "plaspistol"
	m_amt = 2000
	origin_tech = "combat=2"
	slot_flags = 0
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/weapon/gun/energy/plasma/LCBionicGun/dropped()
	qdel(src)

/obj/item/weapon/gun/energy/plasma/LCBionicGun/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(prob(2-min((user.luck/50), 2))) //+100 luck and no venting action will ever happen, -100 luck and it is twice as lucky to happen.
		if (isliving(loc))
			var/mob/living/M = loc
			M << "\red The [src] overheats and vents a small jet of plasma in your face!"
			M.take_organ_damage(0, 5)
			M.fire_stacks += 3
			M.IgniteMob()
	return

/obj/item/weapon/gun/energy/plasma/pistol
	name = "Plasma Pistol"
	desc = "A very deadly weapon used by high ranking members of the Imperium..."
	icon_state = "ppistol"
	w_class = 2.0
	item_state = "plaspistol"
	m_amt = 2000
	origin_tech = "combat=2"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	cell_type = "/obj/item/weapon/stock_parts/cell/super"

/obj/item/weapon/gun/energy/plasma/pistol/chaos
	name = "Chaos Plasma Pistol"
	desc = "A very deadly weapon used by Heretics!."
	icon_state = "chaosplaspistol"
	w_class = 2.0
	item_state = "chaosplaspistol"

/obj/item/weapon/gun/energy/plasma/pistol/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(prob(4-min((user.luck/50), 2)))
		var/turf/T = get_turf(src.loc)

		if (ismob(loc))
			var/mob/M = loc
			M.show_message("\red Your [src] explodes!", 1)

		if(T)
			T.hotspot_expose(700,125)

			explosion(T, -1, -1, 2, 3)
		qdel(src)
	return

/obj/item/weapon/gun/energy/plasma/rifle
	name = "Heavy Plasma Rifle"
	desc = "A very deadly weapon used by high ranking members of the Imperium..."
	icon_state = "prifle"
	w_class = 2.0
	item_state = "prifle"
	m_amt = 2000
	origin_tech = "combat=2"
	ammo_type = list(/obj/item/ammo_casing/energy/plasmarifle, /obj/item/ammo_casing/energy/plasmaburst)
	cell_type = "/obj/item/weapon/stock_parts/cell/super"
	modifystate = -1 //Will need to outright override icon modifications to get around the troublesome initial() statements.
	var/heat = 0

/obj/item/weapon/gun/energy/plasma/rifle/process()
	if(heat > 0)
		heat --
	if(icon_state == "prifle-crit" && heat < 25)
		icon_state = "prifle"
	charge_tick++
	if(charge_tick < 4) return 0
	charge_tick = 0
	if(!power_supply) return 0
	power_supply.give(50)
	return 1

/obj/item/weapon/gun/energy/plasma/rifle/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(select == 1)
		heat += 2
	else if(select == 2)
		heat += 13
	else
		user << "\red There's a bit of an error... Please report this to a developer. Mention that it is located on line 266 of special.dm if you would."
	if(heat >= 25)
		icon_state = "prifle-crit"
		if(prob(50))
			user << "\red [src] is heating up in your hands!"
	var/selectprob = 20
	if(select == 2) selectprob = 50
	selectprob -= min((user.luck/20), selectprob)
	if(heat >= 30 && prob(selectprob))
		var/turf/T = get_turf(src.loc)
		if (isliving(loc))
			var/mob/living/M = loc
			M.show_message("\red Your [src] critically overheats!", 1)
			M.fire_stacks += 3
			M.IgniteMob()
		if(T)
			//atmos_spawn_air(SPAWN_HEAT | SPAWN_TOXINS, 30)
			explosion(T, -1, -1, 2, 3)
	return

