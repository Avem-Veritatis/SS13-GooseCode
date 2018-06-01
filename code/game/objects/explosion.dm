//TODO: Flash range does nothing currently

//A very crude linear approximatiaon of pythagoras theorem.
/proc/cheap_pythag(var/dx, var/dy)
	dx = abs(dx); dy = abs(dy);
	if(dx>=dy)	return dx + (0.5*dy)	//The longest side add half the shortest side approximates the hypotenuse
	else		return dy + (0.5*dx)


proc/trange(var/Dist=0,var/turf/Center=null)//alternative to range (ONLY processes turfs and thus less intensive)
	if(Center==null) return

	//var/x1=((Center.x-Dist)<1 ? 1 : Center.x-Dist)
	//var/y1=((Center.y-Dist)<1 ? 1 : Center.y-Dist)
	//var/x2=((Center.x+Dist)>world.maxx ? world.maxx : Center.x+Dist)
	//var/y2=((Center.y+Dist)>world.maxy ? world.maxy : Center.y+Dist)

	var/turf/x1y1 = locate(((Center.x-Dist)<1 ? 1 : Center.x-Dist),((Center.y-Dist)<1 ? 1 : Center.y-Dist),Center.z)
	var/turf/x2y2 = locate(((Center.x+Dist)>world.maxx ? world.maxx : Center.x+Dist),((Center.y+Dist)>world.maxy ? world.maxy : Center.y+Dist),Center.z)
	return block(x1y1,x2y2)

/*
New Explosions
*/

proc/explosion(turf/epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, adminlog = 0, ignorecap = 0, flame_range = 0, shrapnel_count = 0)
	src = null	//so we don't abort once src is deleted
	epicenter = get_turf(epicenter)

	var/far_dist = 0
	far_dist += heavy_impact_range * 5
	far_dist += devastation_range * 20


	var/max_range = max(devastation_range, heavy_impact_range, light_impact_range, flame_range)
	var/frequency = get_rand_frequency()
	for(var/mob/M in player_list)
		// Double check for client
		if(M && M.client)
			var/turf/M_turf = get_turf(M)
			if(M_turf && epicenter && M_turf.z == epicenter.z)
				var/dist = get_dist(M_turf, epicenter)
				// If inside the blast radius + world.view - 2
				if(dist <= round(max_range + world.view - 2, 1))
					M.playsound_local(epicenter, get_sfx("explosion"), 100, 1, frequency, falloff = 5) // get_sfx() is so that everyone gets the same sound
				// You hear a far explosion if you're outside the blast radius. Small bombs shouldn't be heard all over the station.
				else if(dist <= far_dist)
					var/far_volume = Clamp(far_dist, 30, 50) // Volume is based on explosion size and dist
					far_volume += (dist <= far_dist * 0.5 ? 50 : 0) // add 50 volume if the mob is pretty close to the explosion
					M.playsound_local(epicenter, 'sound/effects/explosionfar.ogg', far_volume, 1, frequency, falloff = 5)

	// Archive the uncapped explosion for the doppler array
	var/devestation = max(devastation_range * 2, 0)
	var/heavy = max(heavy_impact_range * 2, 0)
	var/light = max(light_impact_range * 2, 0)
	var/flames = max(flame_range * 2, 0)

	if(shrapnel_count)
		var/occupied = 0
		for(var/mob/living/carbon/C in epicenter) //Absorbing the shrapnel for everyone else.
			C.visible_message("\red <b>[C] absorbs shrapnel from the blast!</b>")
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				H.take_overall_damage(15*shrapnel_count, 5*shrapnel_count, deliveredwound=/datum/wound/shrapnel)
				if(H.lying && H.mind && !isork(H) && H.mind.special_role != "traitor" && H.mind.special_role != "Heretic" && H.mind.special_role != "syndicate" && H.mind.special_role != "wizard" && H.mind.special_role != "cultist" && H.mind.special_role != "Genestealer Cult Member")
					for(var/mob/living/carbon/human/H2 in range(5, H))
						if(!H2.lying && H2.mind && !isork(H2) && H2.mind.special_role != "traitor" && H2.mind.special_role != "Heretic" && H2.mind.special_role != "syndicate" && H2.mind.special_role != "wizard" && H2.mind.special_role != "cultist" && H2.mind.special_role != "Genestealer Cult Member")
							award(H, "<b>Self Sacrifice</b>")
							break
			else
				C.take_overall_damage(15*shrapnel_count, 5*shrapnel_count)
			if(C.lying || prob(50)) occupied = 1 //Blocks shrapnel for everyone else if they are lying down on top of the explosive or a chance to if they aren't.
		if(!occupied)
			for(var/i=0, i<shrapnel_count, i++) //Scatters shrapnel, hopefully...
				spawn((round(i, 20)/20))
					var/obj/item/projectile/bullet/shrapnel/A = new /obj/item/projectile/bullet/shrapnel(epicenter)
					A.current = epicenter
					var/angle = rand(0, 359) //Should fire it in a random direction...
					if(prob(50))
						angle = pick(rand(-10, 10), rand(80, 100), rand(170, 190), rand(260, 280)) //This algorithm should favor a starburst pattern of expansion, favoring the four cardinal directions and diagonals. A fair amount of randomness is inherent in it however.
					A.yo = round(sin(angle)*10)
					A.xo = round(cos(angle)*10)
					A.process()

	explode (epicenter, devestation, heavy, light, flames)
	spawn (3)
		var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
		smoke.set_up(5, 0, epicenter)
		smoke.attach(epicenter)
		smoke.start()
	for (var/mob/O in viewers(epicenter))
		flick("flash2", O.flash)
