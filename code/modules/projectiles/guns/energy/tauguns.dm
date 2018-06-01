/obj/item/weapon/gun/projectile/tau/fusionblaster
	name = "Fusion Blaster"
	icon_state = "fusion"
	item_state = "fusion"
	desc = "A short-ranged Tau Melta Weapon that agitates the sub-atomic particles of the target, causing a massive build-up of heat."
	var/projectiles_per_shot = 2
	var/deviation = 0
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/bullet/fusion

/obj/item/weapon/gun/projectile/tau/fusionblaster/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
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
		sleep 15
		cooldown = 1
	else
		playsound(loc, 'sound/effects/sparks1.ogg', 60, 1)
		usr << "<span class='notice'>The Fusion Blaster is charging.</span>"

/obj/item/weapon/tau/drone/gun
	name = "Tau Gun Drone"
	desc = "A deployable Tau Gun Drone."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrench"
	flags = CONDUCT
	force = 7.0
	throwforce = 9.0
	w_class = 4.0
	m_amt = 150
	origin_tech = "materials=2;engineering=4"
	attack_verb = list("bashed", "bludgeoned", "whacked")

/obj/item/weapon/tau/drone/gun/attack_self(mob/user as mob)
	new /mob/living/simple_animal/tau/drone/gun(user.loc)
	user.drop_item()
	qdel(src)
	return

/obj/item/device/tau/drone/controller
	name = "Tau Drone Controller"
	desc = "A Drone Controller used by the tau to control drones."
	icon = 'icons/obj/device.dmi'
	icon_state = "droneC"
	flags = CONDUCT
	force = 3.0
	throwforce = 5.0
	w_class = 1.0
	m_amt = 150
	origin_tech = "materials=2;engineering=4"
	attack_verb = list("bashed", "bludgeoned", "whacked")
	var/used = 0


/obj/item/device/tau/drone/controller/attack_self(mob/living/user as mob)
	for(var/mob/living/simple_animal/tau/drone/gun/D in world)
		if (used)
			D.stance = 1
			user << "<span class='notice'>You switch the drones to Passive.</span>"
			used = 0
			return
		else
			D.stance = 3
			user << "<span class='notice'>You switch the drones to Aggressive.</span>"
			used = 1
			return
		used = !used