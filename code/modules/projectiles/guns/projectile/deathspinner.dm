/obj/item/weapon/gun/projectile/scatapult
	name = "Shuriken Catapult"
	desc = "The Shuriken Catapult is the standard type of shuriken weapon, firing razor-sharp monomolecular discs capable of slicing through flesh and penetrating a considerable thickness of plasteel armour."
	icon_state = "scatapult"
	item_state = "shuriken_pistol"
	w_class = 5
	var/projectiles_per_shot = 10
	var/deviation = 1
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/bullet/shurikan

/obj/item/weapon/gun/projectile/scatapult/attack_self(mob/living/user as mob)
	return


/obj/item/weapon/gun/projectile/scatapult/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/shur.ogg', 65, 0)
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
		sleep 10
		cooldown = 1
	else
		return