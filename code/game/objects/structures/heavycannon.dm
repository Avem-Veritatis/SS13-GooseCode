/obj/structure/banebladecannon
	name = "Mega Battle Cannon"
	desc = "A heavy baneblade cannon."
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "cannon"
	pixel_x = -16
	pixel_y = -16

/obj/structure/banebladecannon/ex_act(severity)
	return

/obj/structure/banebladecannon/proc/fire(var/atom/T)
	if(src.dir == NORTH && src.y - T.y >= 0) return
	if(src.dir == SOUTH && src.y - T.y <= 0) return
	if(src.dir == EAST && src.x - T.x >= 0) return
	if(src.dir == WEST && src.x - T.x <= 0) return
	if(src.dir == NORTH || src.dir == SOUTH)
		if(get_dir(src, T) == EAST || get_dir(src, T) == WEST) return
	if(src.dir == EAST || src.dir == WEST)
		if(get_dir(src, T) == NORTH || get_dir(src, T) == SOUTH) return
	var/turf/curloc = src.loc
	var/atom/targloc
	if(!istype(T, /turf/))
		targloc = get_turf(T)
	else
		targloc = T
	if (!targloc || !istype(targloc, /turf) || !curloc)
		return
	if (targloc == curloc)
		return
	playsound(loc, 'sound/weapons/missle.ogg', 75, 0)
	var/obj/item/projectile/A = new /obj/item/projectile/magic/baneblade(src.loc)
	A.current = curloc
	A.yo = targloc.y - curloc.y
	A.xo = targloc.x - curloc.x
	A.process()

/obj/structure/banebolter
	name = "Twin Linked Heavy Bolter"
	desc = "Two massive guns linked together."
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndieturret0"

/obj/structure/banebladecannon/ex_act(severity)
	return

/obj/structure/banebolter/proc/fire(var/atom/T)
	if(get_dist(src, T) > 8) return
	if((src.dir == NORTH || src.dir == NORTHWEST  || src.dir == NORTHEAST) && src.y - T.y >= 0) return
	if((src.dir == SOUTH || src.dir == SOUTHWEST  || src.dir == SOUTHEAST) && src.y - T.y <= 0) return
	if((src.dir == EAST || src.dir == NORTHEAST  || src.dir == SOUTHEAST) && src.x - T.x >= 0) return
	if((src.dir == WEST || src.dir == NORTHWEST || src.dir == SOUTHWEST) && src.x - T.x <= 0) return
	for(var/stage = 1, stage<=20, stage++)
		sleep(2)
		playsound(loc, 'sound/weapons/Gunshot_bolter.ogg', 75, 0)
		var/turf/curloc = src.loc
		var/atom/targloc
		if(!istype(T, /turf/))
			targloc = get_turf(T)
		else
			targloc = T
		if (!targloc || !istype(targloc, /turf) || !curloc)
			return
		if (targloc == curloc)
			return
		var/obj/item/projectile/A = new /obj/item/projectile/bullet/gyro/heavy(src.loc)
		A.current = curloc
		A.yo = targloc.y - curloc.y
		A.xo = targloc.x - curloc.x
		A.process()

/obj/structure/fluxarc
	name = "Gauss Flux Arc"
	desc = "An array of linked gauss flayers that will fuck things up."
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "fluxarc"
	pixel_x = -16
	pixel_y = -16
	var/obj/item/ammo_casing/energy/beamshot/fluxarc/internalgun
	var/cooldown = 0
	var/broken = 0

/obj/structure/fluxarc/New()
	..()
	internalgun = new /obj/item/ammo_casing/energy/beamshot/fluxarc()
	processing_objects.Add(src)

/obj/structure/fluxarc/ex_act(severity)
	return

/obj/structure/fluxarc/proc/fire(var/atom/T)
	if(broken) return
	if(src.dir == NORTH && src.y - T.y >= 0) return
	if(src.dir == SOUTH && src.y - T.y <= 0) return
	if(src.dir == EAST && src.x - T.x >= 0) return
	if(src.dir == WEST && src.x - T.x <= 0) return
	spawn(rand(0, 15))
		if(src.dir == NORTH && src.y - T.y >= 0) return
		if(src.dir == SOUTH && src.y - T.y <= 0) return
		if(src.dir == EAST && src.x - T.x >= 0) return
		if(src.dir == WEST && src.x - T.x <= 0) return
		internalgun.fire(T,src, 0, 0, 0)

/obj/structure/fluxarc/process()
	if(!locate(/obj/effect/fake_floor/fake_wall/r_wall/monolith) in get_turf(src))
		qdel(src)
	for(var/mob/living/carbon/C in view(5, src))
		if(!cooldown && C.stat != DEAD)
			src.fire(C)
			cooldown = 1
			spawn(15) cooldown = 0
	for(var/obj/machinery/computer/supplydrop/S in view(5, src))
		if(!cooldown)
			src.fire(S)
			cooldown = 1
			spawn(15) cooldown = 0
	for(var/obj/mecha/M in view(5, src))
		if(!cooldown)
			src.fire(M)
			cooldown = 1
			spawn(15) cooldown = 0
	for(var/obj/effect/fake_floor/fake_wall/r_wall/baneblade/B in view(10, src))
		if(!cooldown)
			src.fire(B)
			cooldown = 1
			spawn(8) cooldown = 0
	for(var/turf/simulated/wall/W in view(5, src))
		if(!cooldown)
			src.fire(W)
			cooldown = 1
			spawn(3) cooldown = 0
	for(var/obj/structure/girder/G in view(5, src))
		if(!cooldown)
			src.fire(G)
			cooldown = 1
			spawn(3) cooldown = 0
	for(var/obj/structure/S in view(5, src))
		if(!cooldown)
			src.fire(S)
			cooldown = 1
			spawn(3) cooldown = 0

/obj/structure/outpostcannon
	name = "Hydra Turret"
	desc = "A large anti-air platform set up around the outpost to keep it defended."
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "turretl"
	layer = FLY_LAYER

/obj/structure/outpostcannonfiller //Gives it two tiles of density.
	name = "Hydra Turret"
	desc = "A large anti-air platform set up around the outpost to keep it defended."
	icon = null
	icon_state = null