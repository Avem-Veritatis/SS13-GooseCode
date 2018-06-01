/obj/item/weapon/gun/projectile/shotgun
	name = "shotgun"
	desc = "Useful for sweeping alleys."
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = 4.0
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = "combat=4;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	var/recentpump = 0 // to prevent spammage
	var/pumped = 0
	var/pump_speed = 10

/obj/item/weapon/gun/projectile/shotgun/makeshift
	mag_type = /obj/item/ammo_box/magazine/internal/makeshift

/obj/item/weapon/gun/projectile/shotgun/attackby(var/obj/item/A as obj, mob/user as mob)
	var/num_loaded = magazine.attackby(A, user, 1)
	if(num_loaded)
		user << "<span class='notice'>You load [num_loaded] shell\s into \the [src]!</span>"
		A.update_icon()
		update_icon()

/obj/item/weapon/gun/projectile/shotgun/process_chamber()
	return ..(0, 0)

/obj/item/weapon/gun/projectile/shotgun/chamber_round()
	return

/obj/item/weapon/gun/projectile/shotgun/attack_self(mob/living/user)
	if(recentpump)	return
	pump(user)
	recentpump = 1
	spawn(pump_speed)
		recentpump = 0
	return

/obj/item/weapon/gun/projectile/shotgun/proc/pump(mob/M)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	pumped = 0
	if(chambered)//We have a shell in the chamber
		chambered.loc = get_turf(src)//Eject casing
		chambered = null
	if(!magazine.ammo_count())	return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/weapon/gun/projectile/shotgun/examine()
	..()
	if (chambered)
		usr << "A [chambered.BB ? "live" : "spent"] one is in the chamber."

/obj/item/weapon/gun/projectile/shotgun/combat
	name = "combat shotgun"
	icon_state = "cshotgun"
	origin_tech = "combat=5;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/shotcom
	w_class = 5
	pump_speed = 5

/obj/item/weapon/gun/projectile/shotgun/combat/voxlegis
	name = "Vox Legi Shotgun"
	desc = "A vox legi pattern combat shotgun used by the arbites."
	icon_state = "voxlegis"
	item_state = "voxlegis"
	w_class = 3
	mag_type = /obj/item/ammo_box/magazine/internal/voxlegi

/obj/item/weapon/gun/projectile/revolver/doublebarrel
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon_state = "dshotgun"
	item_state = "shotgun"
	w_class = 4.0
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = "combat=3;materials=1"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/dualshot
	var/sawn_off = 0

/obj/item/weapon/gun/projectile/revolver/doublebarrel/verb/rename_gun() //BARMAN CAN INTO SNOWFLAKES TOO
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun."

	var/mob/M = usr
	var/input = stripped_input(M,"What do you want to name the gun?", ,"", MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		M << "You name the gun [input]. Say hello to your new friend."
		return 1

/obj/item/weapon/gun/projectile/revolver/doublebarrel/verb/reskin_gun()
	set name = "Change gun furniture"
	set category = "Object"
	set desc = "Click to change the color of your gun's wooden furniture." //since naming it reskin when its the same gun with different colors would be dumb

	var/mob/M = usr
	var/list/options = list()
	options["Standard Walnut"] = "dshotgun"
	options["Dark Red Finish"] = "dshotgun-d"
	options["Ash"] = "dshotgun-f"
	options["Faded Grey"] = "dshotgun-g"
	options["Maple"] = "dshotgun-l"
	options["Rosewood"] = "dshotgun-p"
	var/choice = input(M,"What do you want to change the color to?","Refurnish Gun") in options

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice] + (sawn_off ? "-sawn" :)
		M << "Your gun is now refurnished with [choice]. Say hello to your new friend."
		return 1

/obj/item/weapon/gun/projectile/revolver/doublebarrel/attackby(var/obj/item/A as obj, mob/user as mob)
	..()
	if (istype(A,/obj/item/ammo_box) || istype(A,/obj/item/ammo_casing))
		chamber_round()
	if(sawn_off == 0 && (istype(A, /obj/item/weapon/circular_saw) || istype(A, /obj/item/weapon/melee/energy) || istype(A, /obj/item/weapon/pickaxe/plasmacutter)))
		user << "<span class='notice'>You begin to shorten the barrel of \the [src].</span>"
		if(get_ammo(0, 0) && afterattack(user, user))
			afterattack(user, user)	//will this work?
			afterattack(user, user)	//it will. we call it twice, for twice the FUN
		if(do_after(user, 30))	//SHIT IS STEALTHY EYYYYY
			icon_state = "[icon_state]-sawn"
			w_class = 3.0
			item_state = "gun"
			slot_flags &= ~SLOT_BACK	//you can't sling it on your back
			slot_flags |= SLOT_BELT		//but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
			user << "<span class='warning'>You shorten the barrel of \the [src]!</span>"
			name = "[name]"
			desc = "Omar's coming!"
			sawn_off = 1

/obj/item/weapon/gun/projectile/revolver/doublebarrel/attack_self(mob/living/user as mob)
	var/num_unloaded = 0
	while (get_ammo() > 0)
		var/obj/item/ammo_casing/CB
		CB = magazine.get_round(0)
		chambered = null
		CB.loc = get_turf(src.loc)
		CB.update_icon()
		num_unloaded++
	if (num_unloaded)
		user << "<span class = 'notice'>You break open \the [src] and unload [num_unloaded] shell\s.</span>"
	else
		user << "<span class='notice'>[src] is empty.</span>"

/*
Ork Shotta
*/

/obj/item/weapon/gun/projectile/shotgun/shotta
	name = "shotta"
	icon_state = "shotta"
	item_state = "slugga"
	origin_tech = "combat=5;materials=2"
	w_class = 5
	var/projectiles_per_shot = 4
	var/deviation = 0.7
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/bullet/pellet

/obj/item/weapon/gun/projectile/shotgun/shotta/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/Gunshot.ogg', 80, 1)
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
		sleep 8
		cooldown = 1
	else
		if(!istype(user, /mob/living/carbon/human/ork/))
			usr << "<span class='notice'>The recoil knocks you flat!!</span>"
			user.Weaken(3)
			return
		if(prob (50))
			playsound(loc, 'sound/weapons/shotgunpump.ogg', 60, 1)
			usr << "<span class='notice'>IT DON FIRE DAT FAST!</span>"
