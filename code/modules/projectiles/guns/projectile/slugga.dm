//Lets do this.

//some tape

/obj/item/weapon/taperoll
	name = "Goose Tape"
	desc = "This is some incredible Ork technology right here."
	icon = 'icons/obj/orkslugga.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = 1
//a slugga

/obj/item/weapon/gun/projectile/slugga
	name = "Slugga"
	desc = "What dis?"
	icon = 'icons/obj/orkslugga.dmi'
	icon_state = "slugga"
	item_state = "slugga"
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/sluggamag
	fire_sound = 'sound/weapons/gunshot.ogg'
	var/projectiles = 45
	var/deviation = 0.1
	var/projectile
	var/cooldown = 0
	var/iconticker = 0
	var/state = 0
	var/las = 0
	var/bolter = 0
	var/flamer = 0
	var/auto = 0
	var/hauto = 0
	var/shotgun = 0
	var/hell = 0
	var/plasma = 0
	var/tau = 0
	var/missle = 0			//god help us all
	var/taped = 1			//No no! It's a normal gun! Completely! I swear! Don't let the vars fool you! It's normal. Everything is normal here now... how are you?

/obj/item/weapon/gun/projectile/slugga/attackby(obj/item/I as obj, mob/user as mob)
	if(state > 29)
		user << "Looks like there is no more room for that. Any more and only a cybork could lift it."
		return
	if(!istype(user, /mob/living/carbon/human/ork/))
		user << "What on earth are you trying to do?"
		return
	if(istype(I, /obj/item/weapon/taperoll))
		taped = 1
		playsound(loc, 'sound/items/tape.ogg', 50, 0)
		return

	if(istype(I, /obj/item/weapon/gun/projectile/automatic/lasgun)||istype(I,/obj/item/weapon/gun/projectile/automatic/lasgunkreig)||istype(I,/obj/item/weapon/gun/projectile/automatic/laspistol2)||istype(I,/obj/item/weapon/gun/projectile/automatic/laspistol))
		taped = 0
		las++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/projectile/automatic/bolter)||istype(I,/obj/item/weapon/gun/projectile/automatic/bpistol))
		taped = 0
		bolter++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/projectile/flamer)||istype(I,/obj/item/weapon/gun/projectile/handflamer)||istype(I,/obj/item/weapon/twohanded/required/hflamer)||istype(I,/obj/item/weapon/gun/projectile/sbolter))
		taped = 0
		flamer++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/projectile/autogun)||istype(I,/obj/item/weapon/gun/projectile/snazzgun)||istype(I,/obj/item/weapon/gun/projectile/shoota)||istype(I,/obj/item/weapon/gun/projectile/slugga))
		taped = 0
		auto++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/twohanded/required/hbolter)||istype(I,/obj/item/weapon/gun/projectile/automatic/tommygun)||istype(I,/obj/item/weapon/gun/projectile/automatic/l6_saw)||istype(I,/obj/item/weapon/gun/projectile/automatic/BPAP))
		taped = 0
		hauto++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/projectile/BPMP)||istype(I,/obj/item/weapon/gun/projectile/automatic/hellgun)||istype(I,/obj/item/weapon/gun/projectile/meltagun))
		taped = 0
		hell++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/projectile/shotgun)||istype(I,/obj/item/weapon/gun/projectile/shotgun/shotta)||istype(I,/obj/item/weapon/gun/projectile/revolver/doublebarrel)||istype(I,/obj/item/weapon/gun/projectile/automatic/deagle))
		taped = 0
		shotgun++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/energy/plasma)||istype(I,/obj/item/weapon/gun/energy/plasma/pistol)||istype(I,/obj/item/weapon/gun/energy/plasma/rifle)||istype(I,/obj/item/weapon/gun/energy/tesla/taurail)||istype(I,/obj/item/weapon/gun/projectile/automatic/lascannon))
		taped = 0
		plasma++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/energy/pulse_rifle/trifle)||istype(I,/obj/item/weapon/gun/energy/pulse_rifle/tpc)||istype(I,/obj/item/weapon/gun/projectile/burstcannon)||istype(I,/obj/item/weapon/gun/energy/pulse_rifle)||istype(I,/obj/item/weapon/gun/energy/taser))
		taped = 0
		tau++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	if(istype(I, /obj/item/weapon/gun/magic/staff/misslelauncher))
		taped = 0
		missle++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)
	else
		if(istype(I, /obj/item/weapon/gun))
			taped = 0
			shotgun++
			state++
			user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
			qdel(I)
			update_icon()
			playsound(src, 'sound/machines/click.ogg', 25, 1)

	..()

/obj/item/weapon/gun/projectile/slugga/update_icon()
	..()
	deviation = 0.1
	if(state >= 12)
		deviation = 0.2
	if(state >= 25)
		deviation = 0.3
	switch(state)
		if(0 to 2)
			iconticker = 1
			name = "Modified Slugga"
		if(3 to 4)
			iconticker = 2
			name = "TWO Sluggas"
		if(5 to 6)
			iconticker = 3
			name = "SLUGGAMANGA"
		if(7 to 8)
			iconticker = 4
			name = "BIG SLUGGAMANGA"
		if(9 to 10)
			iconticker = 5
			name = "KROOK"
		if(11 to 12)
			iconticker = 6
			name = "KROOK KRUMPA"
		if(13 to 15)
			iconticker = 7
			name = "KRUMPA KANNON"
		if(16 to 19)
			iconticker = 8
			name = "MEGAKANNON"
		if(20 to 25)
			iconticker = 9
			name = "FLASH"
		if(26 to 30)
			iconticker = 10
			name = "DAKKAMASTA"
			if(usr)
				award(usr, "FLASH GIT")
	icon_state = "[initial(icon_state)][iconticker][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"
	return



/obj/item/weapon/gun/projectile/slugga/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(!istype(user, /mob/living/carbon/human/ork/))
		user << "What even is this? How does it work? Does it work?"
		return
	if(!taped)
		user.visible_message("\red This needs to be taped up before it can be used!")
		return
	if(!cooldown)
		cooldown = 1
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		var/newlock = get_turf(user)												//Where are we? I wanna see if we moved later.
		if(cooldown >= 1)															//base slugga round
			projectile = /obj/item/projectile/bullet/chaingun
			for(var/i=1 to min(projectiles, cooldown))								//This instruction in the for loop is essential to the entire process and I have no idea why. -Norc
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(src, 'sound/weapons/Gunshot.ogg', 50, 1)
				A.process()
		if(las >= 1)																	//amount of lasguns
			projectile = /obj/item/projectile/bullet/lasgun
			for(var/i=1 to min(projectiles, las))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/lasgun.ogg', 50, 1)
				A.process()
				sleep(1)
		if(bolter >= 1)																//amount of bolters
			projectile = /obj/item/projectile/bullet/gyro
			for(var/i=1 to min(projectiles, bolter))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(src, 'sound/weapons/Gunshot_bolter.ogg', 50, 1)
				A.process()
				sleep(1)
		if(flamer >= 1)																//amount of flamers
			projectile = /obj/item/projectile/bullet/fire
			for(var/i=1 to min(projectiles, flamer))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/flamer.ogg', 60, 0)
				A.process()
				sleep(1)
		if(auto >= 1)																//amount of auto times 3
			projectile = /obj/item/projectile/bullet/chaingun
			for(var/i=1 to min(projectiles, auto))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(src, 'sound/weapons/uzi.ogg', 50, 1)
				A.process()
				sleep(1)
		if(hauto >= 1)																//amount of heavy auto times 3
			projectile = /obj/item/projectile/bullet/gyro
			for(var/i=1 to min(projectiles, hauto))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(src, 'sound/weapons/Gunshot_bolter.ogg', 50, 1)
				A.process()
				sleep(1)
		if(shotgun >= 1)																//amount of shotguns times 3
			projectile = /obj/item/projectile/bullet/pellet
			deviation = 0.7
			for(var/i=1 to min(projectiles, shotgun))
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
				playsound(loc, 'sound/weapons/Gunshot.ogg', 80, 1)
				A.process()
				sleep(1)
				deviation = 0.1
		if(hell >= 1)																//amount of hellguns
			projectile = /obj/item/projectile/beam/hellbeam
			for(var/i=1 to min(projectiles, hell))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/lasercannonfire.ogg', 50, 1)
				A.process()
				sleep(1)
		if(plasma >= 1)																//amount of plasma
			projectile = /obj/item/projectile/energy/plasma
			for(var/i=1 to min(projectiles, plasma))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/plasma.ogg', 50, 1)
				A.process()
				sleep(1)
		if(tau >= 1)																	//amount of tau stuff
			projectile = /obj/item/projectile/energy/heavyplasma
			for(var/i=1 to min(projectiles, tau))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/plasma.ogg', 50, 1)
				A.process()
				sleep(1)
		if(missle >= 1)																	//amount of tau stuff
			projectile = /obj/item/projectile/magic/missle
			for(var/i=1 to min(projectiles, missle))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'sound/weapons/missle.ogg', 50, 1)
				A.process()
				sleep(3)
		sleep(8)
		cooldown = 0
	return