/obj/item/weapon/gun/projectile/meltagun
	name = "Meltagun"
	icon_state = "melta"
	item_state = "meltagun"
	desc = "It's a meltagun!"
	origin_tech = "combat=5;materials=2"
	w_class = 5
	var/projectiles_per_shot = 4
	var/deviation = 0.7
	var/projectile
	var/projectiles = 100000000
	var/cooldown = 1
	projectile = /obj/item/projectile/temp/melta

/obj/item/weapon/gun/projectile/meltagun/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/melta.ogg', 80, 1)
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
		sleep 30
		cooldown = 1
	else
		playsound(loc, 'sound/weapons/shotgunpump.ogg', 60, 1)
		usr << "<span class='notice'>Not ready yet!</span>"

/obj/item/weapon/gun/projectile/meltagun/attack_self(mob/living/user as mob)
	return

/*
types
*/

/obj/item/weapon/gun/projectile/meltagun/bp
	name = "Blood Pact Meltagun"
	icon_state = "meltabp"
	item_state = "chaosmeltagun"
	desc = "It's a meltagun! It has seen better days."

/obj/item/weapon/gun/projectile/meltagun/ig
	name = "Meltagun"
	icon_state = "melta"
	item_state = "meltagun"
	desc = "It's a meltagun! A very advanced weapon that turns the heat up to 40k" //40k not 30k lolz

/obj/item/weapon/gun/projectile/meltagun/um
	name = "UltraMarine Meltagun"
	icon_state = "meltaum"
	item_state = "meltagun"
	desc = "It's a meltagun! A very advanced weapon that turns the heat up to 40k"


/*
Multi-Melta
*/

/obj/item/weapon/twohanded/required/multimelta
	name = "Multi-Melta"
	desc = "A multi-meltagun! This meltagun with multiple barrels can obliterate well... Anything."
	icon = 'icons/obj/gun.dmi'
	icon_state = "multimelta"
	item_state = "multimelta"
	w_class = 5
	throw_range = 0
	force = 20
	attack_verb = list("bludgeoned")
	var/projectiles_per_shot = 12
	var/deviation = 0.8
	var/projectiles = 100000000
	var/cooldown = 1
	var/projectile = /obj/item/projectile/temp/melta

/obj/item/weapon/twohanded/required/multimelta/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cooldown)
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		playsound(loc, 'sound/weapons/melta.ogg', 80, 1)
		for(var/i=1 to min(projectiles, projectiles_per_shot))
			var/dx = round(gaussian(0,deviation),1)
			var/dy = round(gaussian(0,deviation),1)
			targloc = locate(target_x+dx, target_y+dy, target_z)
			if (!targloc || !curloc)
				continue
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
		sleep(40)
		cooldown = 1
	else
		return