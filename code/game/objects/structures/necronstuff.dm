/obj/structure/oblisk
	name = "Strange structure"
	desc = "You feel like something is watching you."
	icon = 'icons/obj/structureslarge.dmi'
	icon_state = "oblisk"
	density = 1
	layer = 3.2//Just above doors
	//pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = 1.0
	flags = ON_BORDER
	var/health = 100
	var/ini_dir = null
	var/state = 0
	var/reinf = 0
//	var/silicate = 0 // number of units of silicate
//	var/icon/silicateIcon = null // the silicated icon


/obj/structure/oblisk/bullet_act(var/obj/item/projectile/Proj)
	if((Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		health -= Proj.damage
	..()
	if(health <= 0)
		explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
		qdel(src)
	return


/obj/structure/oblisk/ex_act(severity)
	switch(severity)
		if(1.0)
			explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
			qdel(src)
			return
		if(2.0)
			explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
			qdel(src)
			return
		if(3.0)
			if(prob(50))
				explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
				qdel(src)
				return

/obj/structure/oblisp
	name = "Strange structure"
	desc = "You feel like something is watching you."
	icon = 'icons/obj/structureslarge.dmi'
	icon_state = "power"
	density = 1
	layer = 3.2//Just above doors
	//pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = 1.0
	flags = ON_BORDER
	var/health = 100
	var/ini_dir = null
	var/state = 0
	var/reinf = 0
//	var/silicate = 0 // number of units of silicate
//	var/icon/silicateIcon = null // the silicated icon


/obj/structure/oblisp/bullet_act(var/obj/item/projectile/Proj)
	if((Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		health -= Proj.damage
	..()
	if(health <= 0)
		explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
		qdel(src)
	return


/obj/structure/oblisp/ex_act(severity)
	switch(severity)
		if(1.0)
			explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
			qdel(src)
			return
		if(2.0)
			explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
			qdel(src)
			return
		if(3.0)
			if(prob(50))
				explosion(loc, 1, 1, 1, 0, 1, flame_range = 5)
				qdel(src)
				return