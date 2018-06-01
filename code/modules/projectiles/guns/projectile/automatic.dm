/*
Breaking this all down so we can understand it. Lets have fun with comments! LOOK AT THE PICTURE! SEE THE SKULL!
*/

//This is the part where we talk about what an automatic is and what it does.
/obj/item/weapon/gun/projectile/automatic 																//Start of automatic
	name = "submachine gun"
	desc = "A lightweight, fast firing gun. Uses 9mm rounds."
	icon_state = "saber"	//ugly
	w_class = 3.0
	origin_tech = "combat=4;materials=2"
	mag_type = /obj/item/ammo_box/magazine/msmg9mm
	var/alarmed = 0

/obj/item/weapon/gun/projectile/automatic/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"
	return

/obj/item/weapon/gun/projectile/automatic/attackby(var/obj/item/A as obj, mob/user as mob)
	if(..() && chambered)
		alarmed = 0

/*
This is going to be the unsorted section
*/
/obj/item/weapon/gun/projectile/automatic/uzi
	name = "Machine Pistol"
	desc = "A lightweight, fast firing gun, for when you want someone dead. Uses .45 rounds."
	icon_state = "mpistol"
	item_state = "mpistol"
	w_class = 3.0
	origin_tech = "combat=5;materials=2;syndicate=8"
	mag_type = /obj/item/ammo_box/magazine/uzim45

/obj/item/weapon/gun/projectile/BPMP
	name = "Machine Pistol"
	desc = "Not pretty but it will have to do."
	icon_state = "BPMP"
	item_state = "c20r"
	w_class = 5
	var/projectiles_per_shot = 10
	var/deviation = 0
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/bullet/chaingun

/obj/item/weapon/gun/projectile/BPMP/attack_self


/obj/item/weapon/gun/projectile/BPMP/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/uzi.ogg', 75, 0)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
			sleep(2)
		cooldown = 0
		sleep 20
		cooldown = 1
	else
		playsound(loc, 'sound/weapons/shotgunpump.ogg', 60, 1)
		return



/obj/item/weapon/gun/projectile/automatic/BPAP
	name = "Auto Pistol"
	desc = "A lightweight, spray and pray. Good for surprises."
	icon_state = "bpap"
	w_class = 3.0
	origin_tech = "combat=5;materials=2;syndicate=8"
	mag_type = /obj/item/ammo_box/magazine/uzim100

/obj/item/weapon/gun/projectile/automatic/c20r
	name = "\improper C-20r SMG"
	desc = "A lightweight, fast firing gun, for when you REALLY need someone dead. Uses .45 ACP rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp"
	icon_state = "c20r"
	item_state = "c20r"
	w_class = 3.0
	origin_tech = "combat=5;materials=2;syndicate=8"
	mag_type = /obj/item/ammo_box/magazine/c20rm
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'

/obj/item/weapon/gun/projectile/automatic/c20r/New()
	..()
	update_icon()
	return

/obj/item/weapon/gun/projectile/automatic/c20r/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
	..()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		update_icon()
		alarmed = 1
	return

/obj/item/weapon/gun/projectile/automatic/c20r/attack_hand(mob/user as mob)
	if(loc == user)
		if(silenced)
			silencer_attack_hand(user)
	..()

/obj/item/weapon/gun/projectile/automatic/c20r/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/silencer))
		silencer_attackby(I,user)
	..()

/obj/item/weapon/gun/projectile/automatic/c20r/update_icon()
	..()
	icon_state = "c20r[silenced ? "-silencer" : ""][magazine ? "-[Ceiling(get_ammo(0)/4)*4]" : ""][chambered ? "" : "-e"]"
	return



/obj/item/weapon/gun/projectile/automatic/l6_saw
	name = "\improper Heavy Stubber"
	desc = "A rather traditionally made light machine gun with a pleasantly lacquered wooden pistol grip. Has 'Aussec Armoury- 2531' engraved on the reciever"
	icon_state = "l6closed100"
	item_state = "l6closedmag"
	w_class = 5
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/m762
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	var/cover_open = 0


/obj/item/weapon/gun/projectile/automatic/l6_saw/attack_self(mob/user as mob)
	cover_open = !cover_open
	user << "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>"
	update_icon()


/obj/item/weapon/gun/projectile/automatic/l6_saw/update_icon()
	icon_state = "l6[cover_open ? "open" : "closed"][magazine ? Ceiling(get_ammo(0)/12.5)*25 : "-empty"]"


/obj/item/weapon/gun/projectile/automatic/l6_saw/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		user << "<span class='notice'>[src]'s cover is open! Close it before firing!</span>"
	else
		..()
		update_icon()


/obj/item/weapon/gun/projectile/automatic/l6_saw/attack_hand(mob/user as mob)
	if(loc != user)
		..()
		return	//let them pick it up
	if(!cover_open || (cover_open && !magazine))
		..()
	else if(cover_open && magazine)
		//drop the mag
		magazine.update_icon()
		magazine.loc = get_turf(src.loc)
		user.put_in_hands(magazine)
		magazine = null
		update_icon()
		user << "<span class='notice'>You remove the magazine from [src].</span>"


/obj/item/weapon/gun/projectile/automatic/l6_saw/attackby(var/obj/item/A as obj, mob/user as mob)
	if(!cover_open)
		user << "<span class='notice'>[src]'s cover is closed! You can't insert a new mag!</span>"
		return
	..()

/obj/item/weapon/gun/projectile/automatic/tommygun
	name = "tommy gun"
	desc = "A genuine Chicago Typewriter."
	icon_state = "tommygun"
	item_state = "tommygun"
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'

/*
Bolters
*/

//a bolter
/obj/item/weapon/gun/projectile/automatic/bolter
	name = "Bolter"
	desc = "This thing is heavier than you."
	icon_state = "bolter"
	item_state = "bolter"
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/boltermag
	fire_sound = 'sound/weapons/Gunshot_bolter.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 0

//a glowing bolter

/obj/item/weapon/gun/projectile/automatic/bolter/glow
	name = "Bolter"
	desc = "This thing is heavier than you."
	icon_state = "bolterglow"
	item_state = "bolter"
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/boltermag
	fire_sound = 'sound/weapons/Gunshot_bolter.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 0

	dropped()
		qdel(src)

/obj/item/weapon/gun/projectile/automatic/bolter/scoped
	name = "Bolter"
	desc = " A standard bolter with multiple attachments"
	icon_state = "bolters"
	item_state = "bolter"
	hitsound = 'sound/weapons/chainsword.ogg'
	flags = CONDUCT
	slot_flags = 0
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/boltermag
	fire_sound = 'sound/weapons/Gunshot_bolter.ogg'
	scoped = 1
	chainb = 0
	canscope = 1
	canattach = 0
	force = 32
	throwforce = 12
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")

//other bolters


/obj/item/weapon/gun/projectile/automatic/bolter/chaos
	icon_state = "chaos_bolter"
	item_state = "chaos_bolter"

/obj/item/weapon/gun/projectile/automatic/bolter/chaos/ksons
	icon_state = "ksonbolter"
	item_state = "ksonsbolter"

/obj/item/weapon/gun/projectile/automatic/bpistol
	name = "Bolter Pistol"
	desc = "A modified version of the Astartes classic. Fires 10 heavilly modified bolts."
	icon_state = "bpistol"
	item_state = "bpistol"
	origin_tech = "combat=5;materials=1;syndicate=2"
	mag_type = /obj/item/ammo_box/magazine/bpistolmag
	fire_sound = 'sound/weapons/Gunshot_bolter.ogg'
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 1


/*
Flamer
*/

/obj/item/weapon/gun/projectile/flamer
	name = "Imperial Flamer"
	desc = "Is it hot in here? Or is it just you?"
	icon_state = "flamer_off"
	item_state = "flamer_off"
	w_class = 5
	var/projectiles_per_shot = 20
	var/deviation = 0.5
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	var/lit = 0
	projectile = /obj/item/projectile/bullet/fire

/obj/item/weapon/gun/projectile/flamer/attack_self(mob/living/user as mob)
	if(!lit)
		lit = 1
		user << "<span class='notice'>The [src] is ready.</span>"
		icon_state = "flamer_on"
		item_state = "flamer_on"
		update_icon()
		return
	else if(lit)
		lit = 0
		user << "<span class='notice'>The [src] is now off.</span>"
		icon_state = "flamer_off"
		item_state = "flamer_off"
		update_icon()
		return

/obj/item/weapon/gun/projectile/flamer/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown & lit)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/flamer.ogg', 60, 0)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
			sleep(1)
		cooldown = 0
		sleep 20
		cooldown = 1
	else
		return

/*
Hand Flamer
*/

/obj/item/weapon/gun/projectile/handflamer
	name = "Hand Flamer"
	desc = "Is it hot in here? Or is it just you?"
	icon_state = "handflamer_off"
	item_state = "handflamer_off"
	w_class = 2 //Pocket sized!
	var/projectiles_per_shot = 2
	var/deviation = 0
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	var/lit = 0
	projectile = /obj/item/projectile/bullet/fire

/obj/item/weapon/gun/projectile/handflamer/attack_self(mob/living/user as mob)
	if(!lit)
		lit = 1
		user << "<span class='notice'>The [src] is ready.</span>"
		icon_state = "handflamer_on"
		item_state = "handflamer_on"
		update_icon()
		return
	else if(lit)
		lit = 0
		user << "<span class='notice'>The [src] is now off.</span>"
		icon_state = "handflamer_off"
		item_state = "flamer_off"
		update_icon()
		return

/obj/item/weapon/gun/projectile/handflamer/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown & lit)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/flamer.ogg', 60, 0)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
			sleep(2)
		cooldown = 0
		sleep(4)
		cooldown = 1
	else
		return

/*
Heavy Flamer
*/

/obj/item/weapon/twohanded/required/hflamer
	name = "Heavy Flamer"
	desc = "Fire. Lots and lots of fire."
	icon = 'icons/obj/gun.dmi'
	icon_state = "hflamer_off"
	item_state = "hflamer_off"
	w_class = 5
	throw_range = 0
	force = 15
	attack_verb = list("bludgeoned")
	var/projectiles_per_shot = 35
	var/deviation = 0.85
	var/projectiles = 100000000
	var/cooldown = 1
	var/lit = 0
	var/projectile = /obj/item/projectile/bullet/fire
	var/icon_on = "hflamer_on"
	var/icon_off = "hflamer_off"

/obj/item/weapon/twohanded/required/hflamer/attack_self(mob/living/user as mob)
	if(!lit)
		lit = 1
		user << "<span class='notice'>The [src] is ready.</span>"
		icon_state = icon_on
		item_state = "hflamer_on"
		update_icon()
		return
	else if(lit)
		lit = 0
		user << "<span class='notice'>The [src] is now off.</span>"
		icon_state = icon_off
		item_state = "hflamer_off"
		update_icon()
		return

/obj/item/weapon/twohanded/required/hflamer/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown & lit)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/flamer.ogg', 60, 0)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
			sleep(1)
		cooldown = 0
		sleep(10)
		cooldown = 1
	else
		return

/obj/item/weapon/twohanded/required/hflamer/red
	name = "Ecclesiarchy Heavy Flamer"
	icon_state = "rhflamer_off"
	icon_on = "rhflamer_on"
	icon_off = "rhflamer_off"

/obj/item/weapon/twohanded/required/hflamer/green
	name = "Salamander Marines Heavy Flamer"
	icon_state = "ghflamer_off"
	icon_on = "ghflamer_on"
	icon_off = "ghflamer_off"

/*
Heavy Bolter
*/

/obj/item/weapon/twohanded/required/hbolter
	name = "Heavy Bolter"
	desc = "This thing is massive. Shit."
	icon = 'icons/obj/gun.dmi'
	icon_state = "hbolter-25"
	item_state = "hbolter"
	w_class = 5
	throw_range = 0
	force = 30
	attack_verb = list("bludgeoned")
	var/projectiles_per_shot = 3
	var/deviation = 0
	var/projectiles = 1000000000
	var/cooldown = 1
	var/projectile = /obj/item/projectile/bullet/gyro/heavy

/obj/item/weapon/twohanded/required/hbolter/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		award(user, "My daddy taught me how to use this...")
		if(prob(2))
			user << "\red The [src] jams up!"
			cooldown = 0
			sleep(50)
			cooldown = 1
			return
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/Gunshot_bolter.ogg', 75, 0)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
			sleep(1)
		cooldown = 0
		sleep(3)
		cooldown = 1
	else
		return

/*
Shoota
*/

/obj/item/weapon/gun/projectile/shoota
	name = "Ork Shoota"
	desc = "Dis is a nice piece of flash!"
	icon_state = "shoota"
	item_state = "slugga"
	w_class = 5
	var/projectiles_per_shot = 8
	var/deviation = 1
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 0
	projectile = /obj/item/projectile/bullet/shootabullet
	scoped = 0
	chainb = 0
	canscope = 1
	canattach = 0


/obj/item/weapon/gun/projectile/shoota/attack_self(mob/living/user as mob)
	return


/obj/item/weapon/gun/projectile/shoota/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(!istype(user, /mob/living/carbon/human/ork/) && !istype(user, /mob/living/carbon/human/whitelisted/))
		usr << "<span class='notice'>The recoil knocks you flat!!</span>"
		user.Weaken(3)
		return
	if(!cooldown)
		cooldown = 1
		spawn (0)
			var/turf/curloc = get_turf(user)
			var/turf/targloc = get_turf(target)
			var/target_x = targloc.x
			var/target_y = targloc.y
			var/target_z = targloc.z
			playsound(loc, 'sound/weapons/dakka.ogg', 75, 0)
			for(var/i=1 to min(projectiles, projectiles_per_shot))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				var/newlock = get_turf(user)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				src.projectiles--
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				A.process()
				sleep(2)
			sleep 10
			cooldown = 0
	else
		var/dakdak = pick('sound/voice/dakkashout.ogg','sound/voice/dakkashout2.ogg','sound/voice/dakkashout3.ogg','sound/voice/dakkashout4.ogg')
		if(prob (50))
			playsound(loc, dakdak, 60, 0)
			user.say(pick("I GOT DA BITS AND PIECES FOR DIS FIGHT!!!", "DANCE HUMIE DANCE!", "LOOK AT MY FLASH!!", "WAAAAAAAAAAAAAAGH!!!"))

/obj/item/weapon/gun/projectile/snazzgun //A shoota with the fire rate stats of a flamer. A definite ork advantage, but more lore friendly than a heavy bolter.
	name = "Snazz Gun"
	desc = "Dis flash is a good git killa!"
	icon_state = "snazzgun"
	item_state = "slugga"
	w_class = 5
	var/projectiles_per_shot = 10
	var/deviation = 0.5
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 0
	projectile = /obj/item/projectile/bullet/shootabullet
	scoped = 0
	chainb = 0
	canscope = 1
	canattach = 0


/obj/item/weapon/gun/projectile/snazzgun/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(!istype(user, /mob/living/carbon/human/ork/) && !istype(user, /mob/living/carbon/human/whitelisted/))
		usr << "<span class='notice'>The recoil knocks you flat!!</span>"
		user.Weaken(3)
		return
	if(!cooldown)
		cooldown = 1
		spawn (0)
			var/turf/curloc = get_turf(user)
			var/turf/targloc = get_turf(target)
			var/target_x = targloc.x
			var/target_y = targloc.y
			var/target_z = targloc.z
			playsound(loc, 'sound/weapons/dakka.ogg', 75, 0)
			for(var/i=1 to min(projectiles, projectiles_per_shot))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				var/newlock = get_turf(user)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				src.projectiles--
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				A.process()
				sleep(1)
			sleep(10)
			cooldown = 0
	else
		var/dakdak = pick('sound/voice/dakkashout.ogg','sound/voice/dakkashout2.ogg','sound/voice/dakkashout3.ogg','sound/voice/dakkashout4.ogg')
		if(prob (50))
			playsound(loc, dakdak, 60, 0)
			user.say(pick("I GOT DA BITS AND PIECES FOR DIS FIGHT!!!", "DANCE HUMIE DANCE!", "LOOK AT MY FLASH!!", "WAAAAAAAAAAAAAAGH!!!"))


/*
Storm Bolter
*/

/obj/item/weapon/gun/projectile/sbolter
	name = "Storm Bolter"
	desc = "The Storm Bolter is a two-barreled version of the Bolter weapon, equipped with a 100-round magazine and capable of rapid fire."
	icon_state = "stormbolter"
	item_state = "stormbolter"
	w_class = 5
	var/projectiles_per_shot = 5
	var/deviation = 0
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 0
	projectile = /obj/item/projectile/bullet/gyro

/obj/item/weapon/gun/projectile/sbolter/attack_self(mob/living/user as mob)
	return


/obj/item/weapon/gun/projectile/sbolter/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(!istype(user, /mob/living/carbon/human/ork) && !istype(user, /mob/living/carbon/human/sob) && !istype(user, /mob/living/carbon/human/whitelisted))
		usr << "<span class='notice'>The recoil knocks you flat!!</span>"
		user.Weaken(3)
		return
	if(!cooldown)
		cooldown = 1
		spawn (0)
			var/turf/curloc = get_turf(user)
			var/turf/targloc = get_turf(target)
			var/target_x = targloc.x
			var/target_y = targloc.y
			var/target_z = targloc.z
			for(var/i=1 to min(projectiles, projectiles_per_shot))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				var/newlock = get_turf(user)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				src.projectiles--
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(loc, 'sound/weapons/Gunshot_bolter.ogg', 75, 0)
				A.process()
				sleep(3)
			sleep 10
			cooldown = 0
	else
		if(istype(user, /mob/living/carbon/human/whitelisted))
			var/sobshout = pick('sound/voice/umshout1.ogg','sound/voice/umshout2.ogg')
			playsound(loc, sobshout, 60, 0)


/*
AutoCannon
*/
/obj/item/weapon/gun/projectile/AutoCannon
	name = "AutoCannon"
	desc = "Autocannons are usually either mounted on weapon carriages or vehicles because of their great weight. Due to their high rate of fire and sufficient killing power, they are effective against large infantry formations and light armored vehicles. This makes them ideal for use against large Tyranid organisms and Orkish vehicles. They are also useful against heavy infantry such as Space Marines, although their power armour has been known to stop autocannon rounds."
	icon_state = "AC"
	item_state = "misteratmos"
	w_class = 5
	var/projectiles_per_shot = 10
	var/deviation = 0
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 0
	projectile = /obj/item/projectile/bullet/shootabullet
	flags = NODROP

/obj/item/weapon/gun/projectile/AutoCannon/cyborg
	flags = 0

/obj/item/weapon/gun/projectile/AutoCannon/cyborg/dropped()
	return

/obj/item/weapon/gun/projectile/AutoCannon/attack_self(mob/living/user as mob)
	return


/obj/item/weapon/gun/projectile/AutoCannon/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown) return

	if(!cooldown)
		spawn (0)
			cooldown = 1
			var/turf/curloc = get_turf(user)
			var/turf/targloc = get_turf(target)
			var/target_x = targloc.x
			var/target_y = targloc.y
			var/target_z = targloc.z
			for(var/i=1 to min(projectiles, projectiles_per_shot))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				var/newlock = get_turf(user)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				src.projectiles--
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/caseless/a75 (src.loc)
				playsound(loc, 'sound/weapons/ac.ogg', 85, 0)
				A.process()
				sleep(5)
			sleep 30
			cooldown = 0
	else
		return

/obj/item/weapon/gun/projectile/AutoCannon/dropped()
	qdel(src)

/*
Autogun
*/

/obj/item/weapon/gun/projectile/autogun
	name = "AutoGun"
	desc = "A durable, rapid fire battle rifle that forms an excellent staple for imperial forces. Has a 360 shot magazine."
	icon_state = "autogun_old" //The legacy sprite for the legacy gun.
	item_state = "autogun"
	w_class = 4
	force = 15.0 //Not bad for clubbing people with.
	var/projectiles_per_shot = 1
	var/deviation = 0.3
	var/projectile
	var/projectiles = 360
	var/cooldown = 1
	projectile = /obj/item/projectile/bullet/autogun
	scoped = 0
	chainb = 0
	canscope = 0
	canattach = 0


/obj/item/weapon/gun/projectile/autogun/attack_self(mob/living/user as mob)
	if(projectiles_per_shot == 1)
		user << "\red You switch the [src.name] from semi-automatic to three round burst."
		projectiles_per_shot = 3
		deviation = 0.05
	else if(projectiles_per_shot == 3)
		user << "\red You switch the [src.name] from three round burst to fully automatic."
		projectiles_per_shot = 10
		deviation = 0.35
	else if(projectiles_per_shot == 10)
		user << "\red You switch the [src.name] from fully automatic to semi-automatic."
		projectiles_per_shot = 1
		deviation = 0
	else
		user << "\red You switch the [src.name] to semi-automatic."
		projectiles_per_shot = 1
		deviation = 0
	return

/obj/item/weapon/gun/projectile/autogun/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(src.projectiles <= 0)
		user.visible_message("\red *click*")
		return
	if(cooldown)
		cooldown = 0
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			var/newlock = get_turf(user)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
			if (newlock != curloc) break
			if (targloc == curloc)
				continue
			var/obj/item/projectile/A = new projectile(curloc)
			src.projectiles--
			A.firer = user
			A.original = target
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			new /obj/item/ammo_casing/caseless/a75 (src.loc)
			playsound(src, 'sound/weapons/uzi.ogg', 100, 1)
			A.process()
			sleep(3)
		sleep(8)
		cooldown = 1
	return

/obj/item/weapon/gun/projectile/automatic/autogun2
	name = "AutoGun"
	desc = "A durable, rapid fire battle rifle that forms an excellent staple for imperial forces. Has a 160 shot magazine. Select fire of semi-automatic, three round burst, and fully automatic."
	icon_state = "autogun"
	item_state = "autogun"
	w_class = 3
	force = 15.0
	slot_flags = SLOT_BACK
	origin_tech = "combat=4;materials=4;syndicate=1"
	mag_type = /obj/item/ammo_box/magazine/autogun
	fire_sound = 'sound/weapons/uzi.ogg'
	var/select_fire = 6
	var/bladed = 0
	var/chambered.projectiles_per_shot = 6
	var/chambered.variance = 0.25

/*AUTOGUN/obj/item/weapon/gun/projectile/automatic/autogun2/attack_self(mob/living/user as mob) //TODO: Redo rapid fire for all guns but flamers and ork guns. Redo gun attachments.
	if(select_fire == 1)
		user << "\red You switch the [src.name] from semi-automatic to three round burst."
		select_fire = 3
		chambered.projectiles_per_shot = 3
		chambered.variance = 0
	else if(select_fire == 3)
		user << "\red You switch the [src.name] from three round burst to fully automatic."
		select_fire = 10
		chambered.projectiles_per_shot = 10
		chambered.variance = 0.25
	else if(select_fire == 10)
		user << "\red You switch the [src.name] from fully automatic to semi-automatic."
		select_fire = 1
		chambered.projectiles_per_shot = 1
		chambered.variance = 0
	else
		user << "\red You switch the [src.name] to semi-automatic."
		select_fire = 1
		chambered.projectiles_per_shot = 1
		chambered.variance = 0
	return*/

/obj/item/weapon/gun/projectile/automatic/autogun2/chamber_round()
	if (chambered || !magazine)
		return
	else if (magazine.ammo_count())
		chambered = magazine.get_round()
		chambered.loc = src
		chambered.projectiles_per_shot = select_fire
		if(select_fire == 6)
			chambered.variance = 0.25
		else
			chambered.variance = 0
	return

/obj/item/weapon/gun/projectile/automatic/autogun2/attackby(obj/item/I as obj, mob/user as mob)
	if(!bladed)
		if(istype(I, /obj/item/weapon/complexknife/combatknife))
			bladed = 1
			force = 25
			update_icon()
			qdel(I)
			return
	..()

/obj/item/weapon/gun/projectile/automatic/autogun2/update_icon()
	..()
	if(bladed)
		icon_state = "bautogun[chambered ? "" : "-e"]"
	else
		icon_state = "autogun[chambered ? "" : "-e"]"
	return