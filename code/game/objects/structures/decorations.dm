/obj/structure/shrine
	name = "Imperium of man shrine"
	desc = "It's a shrine constructed by the 89th Imperial Regiment. If you have brushed up on your military tradition, you could probably guess that this was constructed or transported by guardsmen from the Hades Majoris, probably from the capital."
	icon = 'icons/obj/structures.dmi'
	icon_state = "pillar"
	density = 1
	anchored = 1

/obj/structure/aquilla
	name = "Imperial Monument"
	desc = "A large imperial aquilla."
	icon = 'icons/obj/aquilla.dmi'
	icon_state = "aquilla"
	density = 1
	anchored = 1
	pixel_x = -36

/obj/structure/pillar
	name = "pillar"
	desc = "An enormous stone pillar."
	icon = 'icons/obj/structureslarge.dmi'
	icon_state = "pillar"
	density = 1
	layer = 3.2//Just above doors
	//pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = 1.0
	flags = ON_BORDER
	var/health = 100
	var/ini_dir = null
	var/state = 0
	var/reinf = 0

/obj/structure/pillar/bullet_act(var/obj/item/projectile/Proj)
	if((Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		health -= Proj.damage
	..()
	if(health <= 0)
		explosion(loc, 1, 1, 1, 0, 1, flame_range = 0)
		qdel(src)
	return

/obj/structure/pillar/ex_act(severity)
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