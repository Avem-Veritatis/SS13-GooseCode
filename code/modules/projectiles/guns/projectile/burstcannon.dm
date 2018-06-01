/obj/item/weapon/gun/projectile/burstcannon
	name = "Burst Cannon"
	icon = 'icons/obj/gun.dmi'
	icon_state = "hbolter"
	desc = "A Burst Cannon is a form of multi-barrelled Tau Pulse Weapon, and utilises the same plasma induction technologies found in a Pulse Rifle to fire micro-pulses of plasma accelerated to near-light speeds."
	var/projectiles_per_shot = 4
	var/deviation = 0.1
	var/projectile
	var/projectiles = 1280
	var/cooldown = 1
	projectile = /obj/item/projectile/beam/pulse2

/obj/item/weapon/gun/projectile/burstcannon/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	user.alpha =255
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
			playsound(src, 'sound/weapons/pulse.ogg', 100, 1)
			A.process()
			sleep(3)
		sleep(8)
		cooldown = 1
	return

/obj/item/weapon/gun/projectile/burstcannon/attack_self(mob/living/user as mob)
	if(projectiles_per_shot == 4)
		user << "\red You switch the [src.name] from a four round burst to a six round burst."
		projectiles_per_shot = 6  //Lets not make this too OP, These are pulse shots.
		deviation = 0.2
	else if(projectiles_per_shot == 6)
		user << "\red You switch the [src.name] from a six round burst to a four round burst."
		projectiles_per_shot = 4
		deviation = 0.15
	return
