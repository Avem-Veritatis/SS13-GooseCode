/obj/item/ammo_casing/proc/fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, params, var/distro, var/quiet, var/obj/item/weapon/gun/G = null)
	distro += variance
	if(projectiles_per_shot > 1)
		user.changeNext_move(projectiles_per_shot*fire_delay) //Make rapid firing not overlap!
	for (var/i = max(1, pellets), i > 0, i--)
		var/curloc = user.loc
		var/targloc = get_turf(target)
		ready_proj(target, user, quiet)
		if(BB && BB.homing)
			targloc = target //Target /them/ and not their location, if the bullet does that.
		if(BB && !BB.pixel_shot)
			if(distro)
				targloc = spread(targloc, curloc, distro)
		if(!throw_proj(targloc, user, params, distro))
			return 0
		if(i > 1)
			newshot()
	if(projectiles_per_shot > 1) //Any DRY enthusiast would be cross with me, but huzzah for utilitarianism!
		spawn(0) //Handles rapid firing in a spawn() call... Doesn't worry about return values because it's within a spawn() call.
			for(var/rapid = 1 to projectiles_per_shot-1)
				for (var/i = max(1, pellets), i > 0, i--)
					var/curloc = user.loc
					var/targloc = get_turf(target)
					ready_proj(target, user, quiet)
					if(BB && BB.homing)
						targloc = target //Target /them/ and not their location, if the bullet does that.
					if(BB && !BB.pixel_shot)
						if(distro)
							targloc = spread(targloc, curloc, distro)
					throw_proj(targloc, user, params, distro)
					if(i > 1)
						newshot()
				if(rapid > 1)
					if(G) //If a gun is firing it, make the gun use up a new shot in the rapid firing.
						G.process_chamber()
					newshot() //But technically the new shot comes from the first casing, the rest are just spit out on the floor.
				sleep(fire_delay)
	user.add_suit_fibers(trace_residue)
	add_custom_fiber(trace_residue)
	user.changeNext_move(4)
	update_icon()
	return 1

/obj/item/ammo_casing/proc/ready_proj(atom/target as mob|obj|turf, mob/living/user, var/quiet)
	if (!BB)
		return
	BB.original = target
	BB.firer = user
	BB.def_zone = user.zone_sel.selecting
	BB.silenced = quiet

	if(reagents && BB.reagents)
		reagents.trans_to(BB, reagents.total_volume) //For chemical darts/bullets
		reagents.delete()
	return

/obj/item/ammo_casing/proc/throw_proj(var/turf/targloc, mob/living/user as mob|obj, params, var/distro = null)
	var/turf/curloc = user.loc
	if (!istype(curloc) || !BB)
		return 0
	if(!istype(targloc) && !BB.homing) //unless this bullet is homing, this is an issue.
		return 0
	if(targloc == curloc)			//Fire the projectile
		user.bullet_act(BB)
		qdel(BB)
		return 1
	BB.loc = get_turf(user)
	BB.starting = get_turf(user)
	BB.current = curloc
	BB.yo = targloc.y - curloc.y
	BB.xo = targloc.x - curloc.x
	if(BB.homing)
		BB.target = targloc

	if(params)
		var/list/mouse_control = params2list(params)
		if(mouse_control["icon-x"])
			BB.p_x = text2num(mouse_control["icon-x"])  //Make this work for projectilebeam so that it can have specific locations shot if you click on them.
		if(mouse_control["icon-y"])                   //Note that you don't have to click on somebody to hit them, but if you selected the head location this will buff your damage.
			BB.p_y = text2num(mouse_control["icon-y"])

	if(BB.pixel_shot) //Get a more exact xo and yo firing.
		var/vector_x = (BB.xo*32)+BB.p_x-16 //Lets get that aimed proper like.
		var/vector_y = (BB.yo*32)+BB.p_y-16
		if(distro)
			vector_x = pixel_spread(vector_x, distro)
			vector_y = pixel_spread(vector_y, distro)
		var/angle = Atan2(vector_y, vector_x)
		BB.xo = sin(angle)*32
		BB.yo = cos(angle)*32
		BB.Angle = angle

	if(BB)
		BB.process()
	BB = null
	return 1

/obj/item/ammo_casing/proc/spread(var/turf/target, var/turf/current, var/distro)
	var/dx = abs(target.x - current.x)
	var/dy = abs(target.y - current.y)
	return locate(target.x + round(gaussian(0, distro) * (dy+2)/8, 1), target.y + round(gaussian(0, distro) * (dx+2)/8, 1), target.z)

/obj/item/ammo_casing/proc/pixel_spread(var/dimension, var/distro)
	return dimension+rand(-distro*32,distro*32)

//	gaussian(0, distro)