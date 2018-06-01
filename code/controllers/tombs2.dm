var/global/kill_tombs = 0

var/list/PREFABS = list()

/area/necron_catacombs
	name = "necron catacombs"
	desc = "A tomb city. Lots of spooky winding corridors."
	icon_state = "necron"

/turf/simulated/wall/necron
	name = "wall"
	desc = "A glowing, alien green wall."
	icon = 'icons/mob/tombs.dmi'
	icon_state = "wall0"
	walltype = "wall"
	explodable = 0
	explosion_recursions = 1000 //No explosions can permeate it.
	var/glowing = 0
	var/ankh = 0

/turf/simulated/wall/necron/relativewall()
	return

/turf/simulated/wall/necron/relativewall_neighbours()
	return

/turf/simulated/wall/necron/proc/update_smoothing() //Relativewall, but not called on initialization. Death to lag.
	if(kill_tombs) return
	var/junction = 0
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		if(abs(src.x-W.x)-abs(src.y-W.y))
			junction |= get_dir(src,W)
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		if(!W.mobile)
			if(abs(src.x-W.x)-abs(src.y-W.y))
				junction |= get_dir(src,W)
	src.icon_state = "[walltype][junction]"

/turf/simulated/wall/necron/New()
	..()
	if(kill_tombs) return
	if(!istype(src.loc, /area/necron_catacombs)) //Just don't update the smoothing on the tombs themselves.
		spawn(1) update_smoothing() //Hope the spawn() doesn't cause issues, this should just make sure it takes all the objects around it into account.
	return

/turf/simulated/wall/necron/ex_act()
	return

/turf/simulated/wall/necron/blob_act()
	return

/turf/simulated/wall/necron/attack_paw()
	return

/turf/simulated/wall/necron/attack_animal()
	return

/turf/simulated/wall/necron/attack_hand()
	return

/turf/simulated/wall/necron/attackby()
	return

/turf/simulated/wall/necron/thermitemelt()
	return

/turf/simulated/wall/necron/ankh
	icon_state = "awall0"
	walltype = "awall"
	ankh = 1

/turf/simulated/wall/necron/proc/pulse(var/range = 15)
	if(kill_tombs) return
	if(glowing) return
	range -= 1
	if(range > 0)
		spawn(2)
			for(var/turf/simulated/wall/necron/N in orange(1, src))
				if(!N.glowing)
					N.pulse(range)
	glowing = 1
	var/icon_off = src.icon_state
	src.icon_state = "l[src.icon_state]"
	spawn(5)
		glowing = 0
		src.icon_state = icon_off

/turf/simulated/floor/necron
	icon = 'icons/mob/tombs.dmi'
	icon_state = "ofloor"
	explodable = 0
	var/glowing = 0

/turf/simulated/floor/necron/Entered(AM as mob|obj)
	..()
	/*
	spawn(2)
		for(var/mob/living/simple_animal/hostile/necron/sleeping/N in range(7, src))
			if(N.asleep && N != AM)
				if(get_dist(N, AM) <= N.idle_vision_range)
					N.asleep = 0
					N.visible_message("\red The [N]'s eyes light up as it sluggishly comes to life!")
		for(var/mob/living/simple_animal/hostile/scarab/sleeping/N in range(7, src))
			if(N.asleep  && N != AM)
				if(get_dist(N, AM) <= 7)
					N.asleep = 0
	*/

/turf/simulated/floor/necron/ex_act()
	return

/turf/simulated/floor/necron/attack_paw()
	return

/turf/simulated/floor/necron/attack_hand()
	return

/turf/simulated/floor/necron/attackby()
	return

/turf/simulated/floor/necron/proc/pulse(var/range = 15)
	if(kill_tombs) return
	if(glowing) return
	range -= 1
	if(range > 0)
		spawn(2)
			for(var/turf/simulated/floor/necron/N in orange(1, src))
				if(!N.glowing)
					N.pulse(range)
	glowing = 1
	var/icon_off = src.icon_state
	src.icon_state = "l[src.icon_state]"
	spawn(5)
		glowing = 0
		src.icon_state = icon_off

/turf/simulated/floor/onecron
	icon = 'icons/mob/tombs.dmi'
	icon_state = "floor"
	explodable = 0
	var/glowing = 0
	var/symbols = 1

/turf/simulated/floor/onecron/ex_act()
	return

/turf/simulated/floor/onecron/attack_paw()
	return

/turf/simulated/floor/onecron/attack_hand()
	return

/turf/simulated/floor/onecron/attackby()
	return

/turf/simulated/floor/onecron/proc/pulse(var/range = 2)
	if(kill_tombs) return
	if(glowing) return
	if(range > 2)
		range = 2
	range -= 1
	if(range > 0)
		spawn(1)
			for(var/turf/simulated/floor/onecron/N in orange(1, src))
				if(!N.glowing)
					N.pulse(range)
	glowing = 1
	var/icon_off = src.icon_state
	src.icon_state = "l[src.icon_state]"
	spawn(3)
		glowing = 0
		src.icon_state = icon_off
	..(range)

/turf/simulated/floor/onecron/Entered(AM as mob|obj)
	..()
	if(kill_tombs) return
	spawn(2)
		//for(var/mob/living/simple_animal/hostile/necron/sleeping/N in range(7, src))
		//	if(N.asleep && N != AM)
		//		if(get_dist(N, AM) <= N.idle_vision_range)
		//			N.asleep = 0
		//			N.visible_message("\red The [N]'s eys light up as it sluggishly comes to life!")
		//for(var/mob/living/simple_animal/hostile/scarab/sleeping/N in range(7, src))
		//	if(N.asleep && N != AM)
		//		if(get_dist(N, AM) <= 7)
		//			N.asleep = 0
	if(isliving(AM))
		pulse()

/obj/effect/landmark/prefab_source
	name = "Prefab Source"
	icon = 'icons/mob/screen_gen.dmi'
	anchored = 1.0

/obj/effect/landmark/prefab_source/New()
	PREFABS.Add(src)
	..()

/obj/effect/landmark/necron_ruins/New() //Why in the emperor's name is this not copying over step triggers?!
	while(!ticker) //This might be good to include.
		sleep(300)
	var/obj/effect/landmark/prefab_source/source = pick(PREFABS)
	var/turf/center = get_turf(source)
	for(var/atom/A in range(3, center))
		if(A != source && !isarea(A))
			var/turf/destination = locate(src.x + A.x - center.x, src.y + A.y - center.y, src.z + A.z - center.z)
			var/copytype = A.type
			var/atom/copy = new copytype(destination)
			if(isturf(A))
				copy.icon = A.icon
				copy.icon_state = A.icon_state
	//for(var/obj/effect/step_trigger/S in range(3, center)) //Do I need to manually copy these...? //Hell that isn't even working. What in the emperor's name...
	//	var/turf/destination = locate(src.x + S.x - center.x, src.y + S.y - center.y, src.z + S.z - center.z)
	//	new S.type(destination)
	qdel(src)

/obj/effect/landmark/necron_prob
	name = "Possible Necron Find"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/necron_prob/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	if(prob(10))
		new /obj/effect/landmark/necron_find(src.loc)
	qdel(src)