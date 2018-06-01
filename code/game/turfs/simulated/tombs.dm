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

/turf/simulated/wall/necron/relativewall() //For some reason this is setting it to 15, causing lots of lag, than getting the sprites right...
	var/get_ankh = 1
	var/walls = 0
	for(var/turf/simulated/wall/necron/N in orange(1, src))
		walls = 1
		if(N.ankh)
			get_ankh = 0
	if(walls && get_ankh)
		icon_state = "awall0"
		walltype = "awall"
		src.ankh = 1
	..()

/turf/simulated/wall/necron/ex_act()
	return

/turf/simulated/wall/necron/attack_paw()
	return

/turf/simulated/wall/necron/attack_animal()
	return

/turf/simulated/wall/necron/attack_hand()
	return

/turf/simulated/wall/necron/attackby()
	return

/turf/simulated/wall/necron/ankh
	icon_state = "awall0"
	walltype = "awall"
	ankh = 1

/turf/simulated/wall/necron/proc/pulse(var/range = 15)
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

/turf/simulated/floor/necron/ex_act()
	return

/turf/simulated/floor/necron/attack_paw()
	return

/turf/simulated/floor/necron/attack_hand()
	return

/turf/simulated/floor/necron/attackby()
	return

/turf/simulated/floor/necron/proc/pulse(var/range = 15)
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

/turf/simulated/floor/onecron/nosymbols
	symbols = 0

/turf/simulated/floor/onecron/New()
	..()
	sleep(4)
	if(istype(src, /turf/simulated/floor/onecron))
		if(symbols)
			src.relativefloor()

/turf/simulated/floor/onecron/ex_act()
	return

/turf/simulated/floor/onecron/attack_paw()
	return

/turf/simulated/floor/onecron/attack_hand()
	return

/turf/simulated/floor/onecron/attackby()
	return

/turf/simulated/floor/onecron/proc/pulse(var/range = 2)
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
	spawn(2)
		for(var/mob/living/simple_animal/hostile/necron/sleeping/N in range(7, src))
			if(N.asleep && N != AM)
				if(get_dist(N, AM) <= N.idle_vision_range)
					N.asleep = 0
					N.visible_message("\red The [src]'s eys light up as it sluggishly comes to life!")
		for(var/mob/living/simple_animal/hostile/scarab/sleeping/N in range(7, src))
			if(N.asleep && N != AM)
				if(get_dist(N, AM) <= 7)
					N.asleep = 0
	if(isliving(AM))
		pulse()

/turf/simulated/floor/onecron/proc/relativefloor()
	var/junction = 0
	for(var/turf/simulated/floor/onecron/F in orange(src,1))
		if((abs(src.x-F.x)-abs(src.y-F.y)) == 0)
			var/dir = get_dir(src,F)
			if(dir == NORTHEAST)
				dir = 1
			if(dir == NORTHWEST)
				dir = 2
			if(dir == SOUTHEAST)
				dir = 4
			if(dir == SOUTHWEST)
				dir = 8
			junction |= dir
	icon_state = "floor[junction]"