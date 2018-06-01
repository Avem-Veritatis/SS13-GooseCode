/obj/item/weapon/gun/energy/pulse_rifle
	name = "pulse rifle"
	desc = "A heavy-duty, pulse-based energy weapon, preferred by front-line combat personnel."
	icon_state = "pulse"
	item_state = null	//so the human update icon uses the icon_state instead.
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	cell_type = "/obj/item/weapon/stock_parts/cell/super"


/obj/item/weapon/gun/energy/pulse_rifle/attack_self(mob/living/user as mob)
	select_fire(user)

/obj/item/weapon/gun/energy/pulse_rifle/destroyer
	name = "pulse destroyer"
	desc = "A heavy-duty, pulse-based energy weapon."
	cell_type = "/obj/item/weapon/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)

/obj/item/weapon/gun/energy/pulse_rifle/destroyer/attack_self(mob/living/user as mob)
	user << "\red [src.name] has three settings, and they are all DESTROY."



/obj/item/weapon/gun/energy/pulse_rifle/M1911
	name = "m1911-P"
	desc = "It's not the size of the gun, it's the size of the hole it puts through people."
	icon_state = "m1911-p"
	cell_type = "/obj/item/weapon/stock_parts/cell/infinite"

//Tau Pulse Rifle

/obj/item/weapon/gun/energy/pulse_rifle/trifle
	name = "Tau Pulse Rifle"
	icon = 'icons/obj/Taurifle.dmi'
	icon_state = "trifle"
	item_state = "trifle"
	slot_flags = SLOT_BACK
	desc = "The work horse of the fire-caste. This weapon sports some rather incredible technology."
	cell_type = "/obj/item/weapon/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)
	var/zoom = 0

/obj/item/weapon/gun/energy/pulse_rifle/trifle/attack_self(mob/living/user as mob)
	user << "\red [src.name] has three settings, and they are all 'Greater Good'."

/obj/item/weapon/gun/energy/pulse_rifle/trifle/dropped(mob/user)
	user.client.view = world.view
	..()

/*
This is called from
modules/mob/mob_movement.dm if you move you will be zoomed out
modules/mob/living/carbon/human/life.dm if you die, you will be zoomed out.
*/

/obj/item/weapon/gun/energy/pulse_rifle/trifle/verb/zoom()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 0
	if(usr.stat || !(istype(usr,/mob/living/carbon/human/tau)))
		usr << "You are unable to focus down the scope of the rifle."
		return
	if(!zoom && global_hud.darkMask[1] in usr.client.screen)
		usr << "Your welding equipment gets in the way of you looking down the scope"
		return
	if(!zoom && usr.get_active_hand() != src)
		usr << "You are too distracted to look down the scope, perhaps if it was in your active hand this might work better"
		return

	if(usr.client.view == world.view)
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)	// If the user has already limited their HUD this avoids them having a HUD when they zoom in
		usr.button_pressed_F12(1)
		usr.client.view = 12
		zoom = 1
	else
		usr.client.view = world.view
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)
		zoom = 0
	usr << "<font color='[zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>"
	return

//Tau Pulse Carbine

/obj/item/weapon/gun/energy/pulse_rifle/tpc
	name = "Tau Pulse Carbine"
	icon = 'icons/obj/taurifle.dmi'
	icon_state = "tpc"
	item_state = "tpc"
	desc = "The Pulse Carbine is similar in most respects to a Pulse Rifle, but sacrifices the Pulse Rifle's longer range for greater portability and an underslung Photon Grenade launcher. This allows the weapon to fire a Photon Grenade over a short distance, a capability that is especially useful in close quarters where the weapon can then be used to pin down those enemies affected by the Photon Grenade's flashbang effect."
	cell_type = "/obj/item/weapon/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse2)
	var/zoom = 0

/obj/item/weapon/gun/energy/pulse_rifle/tpc/attack_self(mob/living/user as mob)
	user << "\red [src.name] has three settings, and they are all 'Greater Good'."


/obj/item/weapon/gun/energy/pulse_rifle/tpc/verb/zoom()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 0
	if(usr.stat || !(istype(usr,/mob/living/carbon/human/tau)))
		usr << "You are unable to focus down the scope of the rifle."
		return
	if(!zoom && global_hud.darkMask[1] in usr.client.screen)
		usr << "Your welding equipment gets in the way of you looking down the scope"
		return
	if(!zoom && usr.get_active_hand() != src)
		usr << "You are too distracted to look down the scope, perhaps if it was in your active hand this might work better"
		return

	if(usr.client.view == world.view)
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)	// If the user has already limited their HUD this avoids them having a HUD when they zoom in
		usr.button_pressed_F12(1)
		usr.client.view = 12
		zoom = 1
	else
		usr.client.view = world.view
		if(!usr.hud_used.hud_shown)
			usr.button_pressed_F12(1)
		zoom = 0
	usr << "<font color='[zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>"
	return

/obj/item/weapon/gun/energy/pulse_rifle/tpc/attack_self(mob/living/user as mob)
	user << "\red [src.name] has three settings, and they are all 'Greater Good'."

/*
Pulseblaster
*/

/obj/item/weapon/gun/projectile/tau/pulseblaster
	name = "Pulse blaster"
	desc = "Commonly used by Fire Warrior Breacher Teams. Similar to the Human Shotgun in function, the Pulse Blaster is designed to deliver powerful close-range firepower."
	icon = 'icons/obj/gun.dmi'
	icon_state = "pulseb"
	item_state = "pulseb"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=5"
	var/projectiles_per_shot = 2
	var/deviation = 0.88
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/energy/pulseb

/obj/item/weapon/gun/projectile/tau/pulseblaster/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	user.alpha =255
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/pulse.ogg', 80, 1)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if(!targloc || targloc == curloc)
				break
			var/obj/item/projectile/A = new projectile(curloc)
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
		cooldown = 0
		sleep 9
		cooldown = 1
	else
		playsound(loc, 'sound/effects/sparks1.ogg', 60, 1)

/obj/item/weapon/gun/energy/pulse_rifle/tau/pistol
	name = "Pulse pistol"
	icon = 'icons/obj/gun.dmi'  //NEEDS ICON
	icon_state = "pulsep"
	item_state = "pulsep"
	desc = "A small sidearm version of the Tau Pulse Rifle, issued to personnel only as a hold-out weapon for desperate situations."
	cell_type = "/obj/item/weapon/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse2)