/**********************Mineral deposits**************************/

/turf/simulated/mineral //wall piece
	name = "rocks"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock_nochance"
	opacity = 1
	density = 1
	blocks_air = 1
	oxygen = ONE_ATMOSPHERE
	temperature = 273
	var/mineralName = ""
	var/mineralAmt = 3
	var/spread = 0 //will the seam spread?
	var/spreadChance = 0 //the percentual chance of an ore spreading to the neighbouring tiles
	var/last_act = 0
	var/scan_state = null //Holder for the image we display when we're pinged by a mining scanner
	var/hidden = 1

/turf/simulated/mineral/ex_act(severity)
	switch(severity)
		if(3.0)
			if (prob(75))
				src.gets_drilled()
		if(2.0)
			if (prob(90))
				src.gets_drilled()
		if(1.0)
			src.gets_drilled()
	return

/turf/simulated/mineral/New()

	spawn(1)
		var/turf/T
		if((istype(get_step(src, NORTH), /turf/simulated/floor)) || (istype(get_step(src, NORTH), /turf/space)) || (istype(get_step(src, NORTH), /turf/simulated/shuttle/floor)) || (istype(get_step(src, NORTH), /turf/snow)) || (istype(get_step(src, NORTH), /turf/rocks)))
			T = get_step(src, NORTH)
			if (T)
				T.overlays += image('icons/turf/walls.dmi', "rock_side_s")
		if((istype(get_step(src, SOUTH), /turf/simulated/floor)) || (istype(get_step(src, SOUTH), /turf/space)) || (istype(get_step(src, SOUTH), /turf/simulated/shuttle/floor)) || (istype(get_step(src, NORTH), /turf/snow)) || (istype(get_step(src, NORTH), /turf/rocks)))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += image('icons/turf/walls.dmi', "rock_side_n", layer=6)
		if((istype(get_step(src, EAST), /turf/simulated/floor)) || (istype(get_step(src, EAST), /turf/space)) || (istype(get_step(src, EAST), /turf/simulated/shuttle/floor)) || (istype(get_step(src, NORTH), /turf/snow)) || (istype(get_step(src, NORTH), /turf/rocks)))
			T = get_step(src, EAST)
			if (T)
				T.overlays += image('icons/turf/walls.dmi', "rock_side_w", layer=6)
		if((istype(get_step(src, WEST), /turf/simulated/floor)) || (istype(get_step(src, WEST), /turf/space)) || (istype(get_step(src, WEST), /turf/simulated/shuttle/floor)) || (istype(get_step(src, NORTH), /turf/snow)) || (istype(get_step(src, NORTH), /turf/rocks)))
			T = get_step(src, WEST)
			if (T)
				T.overlays += image('icons/turf/walls.dmi', "rock_side_e", layer=6)

	if (mineralName && mineralAmt && spread && spreadChance)
		for(var/dir in cardinal)
			if(prob(spreadChance))
				var/turf/T = get_step(src, dir)
				if(istype(T, /turf/simulated/mineral/random))
					Spread(T)

	HideRock()
	return

/turf/simulated/mineral/proc/HideRock()
	if(hidden)
		icon_state = "rock"
		if(prob(50))
			icon_state = "rock[pick(2, 3)]"
	return

/turf/simulated/mineral/proc/Spread(var/turf/T)
	new src.type(T)

/turf/simulated/mineral/random
	name = "Mineral deposit"
	icon_state = "rock"
	var/mineralSpawnChanceList = list("Uranium" = 18, "Diamond" = 5, "Gold" = 12, "Silver" = 18, "Plasma" = 25, "Iron" = 40, "Gibtonite" = 2/*, "Adamantine" =5*/, "Cave" = 2)//Currently, Adamantine won't spawn as it has no uses. -Durandan
	var/mineralChance = 17

/turf/simulated/mineral/random/New()
	..()
	if (prob(mineralChance))
		var/mName = pickweight(mineralSpawnChanceList) //temp mineral name

		if (mName)
			var/turf/simulated/mineral/M
			switch(mName)
				if("Uranium")
					M = new/turf/simulated/mineral/uranium(src)
				if("Iron")
					M = new/turf/simulated/mineral/iron(src)
				if("Diamond")
					M = new/turf/simulated/mineral/diamond(src)
				if("Gold")
					M = new/turf/simulated/mineral/gold(src)
				if("Silver")
					M = new/turf/simulated/mineral/silver(src)
				if("Plasma")
					M = new/turf/simulated/mineral/plasma(src)
				if("Cave")
					new/turf/simulated/floor/plating/asteroid/airless/cave(src)
				if("Gibtonite")
					M = new/turf/simulated/mineral/gibtonite(src)
				if("Clown")
					M = new/turf/simulated/mineral/clown(src)
				/*if("Adamantine")
					M = new/turf/simulated/mineral/adamantine(src)*/
			if(M)
				src = M
				M.levelupdate()
	return

/turf/simulated/mineral/random/high_chance
	icon_state = "rock_highchance"
	mineralChance = 25
	mineralSpawnChanceList = list("Uranium" = 35, "Diamond" = 30, "Gold" = 45, "Silver" = 50, "Plasma" = 30)

/turf/simulated/mineral/random/high_chance/New()
	icon_state = "rock"
	..()

/turf/simulated/mineral/random/clown
	icon_state = "rock_highchance"
	mineralChance = 25
	mineralSpawnChanceList = list("Clown" = 50)

/turf/simulated/mineral/random/clown/New()
	icon_state = "rock"
	..()

/turf/simulated/mineral/random/low_chance
	icon_state = "rock_lowchance"
	mineralChance = 8
	mineralSpawnChanceList = list("Uranium" = 8, "Diamond" = 2, "Gold" = 4, "Silver" = 8, "Plasma" = 20, "Iron" = 40, "Gibtonite" = 1)

/turf/simulated/mineral/random/low_chance/New()
	icon_state = "rock"
	..()

/turf/simulated/mineral/uranium
	name = "Uranium deposit"
	mineralName = "Uranium"
	spreadChance = 5
	spread = 1
	hidden = 1
	scan_state = "rock_Uranium"

/turf/simulated/mineral/iron
	name = "Iron deposit"
	icon_state = "rock_Iron"
	mineralName = "Iron"
	spreadChance = 20
	spread = 1
	hidden = 0

/turf/simulated/mineral/diamond
	name = "Diamond deposit"
	mineralName = "Diamond"
	spreadChance = 0
	spread = 1
	hidden = 1
	scan_state = "rock_Diamond"

/turf/simulated/mineral/gold
	name = "Gold deposit"
	mineralName = "Gold"
	spreadChance = 5
	spread = 1
	hidden = 1
	scan_state = "rock_Gold"

/turf/simulated/mineral/silver
	name = "Silver deposit"
	mineralName = "Silver"
	spreadChance = 5
	spread = 1
	hidden = 1
	scan_state = "rock_Silver"

/turf/simulated/mineral/plasma
	name = "Plasma deposit"
	icon_state = "rock_Plasma"
	mineralName = "Plasma"
	spreadChance = 8
	spread = 1
	hidden = 1
	scan_state = "rock_Plasma"

/turf/simulated/mineral/clown
	name = "Bananium deposit"
	icon_state = "rock_Clown"
	mineralName = "Clown"
	mineralAmt = 3
	spreadChance = 0
	spread = 0
	hidden = 0

////////////////////////////////Gibtonite
/turf/simulated/mineral/gibtonite
	name = "Gibtonite deposit"
	icon_state = "rock_Gibtonite"
	mineralName = "Gibtonite"
	mineralAmt = 1
	spreadChance = 0
	spread = 0
	hidden = 1
	scan_state = "rock_Gibtonite"
	var/det_time = 8 //Countdown till explosion, but also rewards the player for how close you were to detonation when you defuse it
	var/stage = 0 //How far into the lifecycle of gibtonite we are, 0 is untouched, 1 is active and attempting to detonate, 2 is benign and ready for extraction
	var/activated_ckey = null //These are to track who triggered the gibtonite deposit for logging purposes
	var/activated_name = null

/turf/simulated/mineral/gibtonite/New()
	det_time = rand(8,10) //So you don't know exactly when the hot potato will explode
	..()

/turf/simulated/mineral/gibtonite/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/device/mining_scanner) && stage == 1)
		user.visible_message("<span class='notice'>You use [I] to locate where to cut off the chain reaction and attempt to stop it...</span>")
		defuse()
	if(istype(I, /obj/item/weapon/pickaxe))
		src.activated_ckey = "[user.ckey]"
		src.activated_name = "[user.name]"
	..()

/turf/simulated/mineral/gibtonite/proc/explosive_reaction()
	if(stage == 0)
		icon_state = "rock_Gibtonite_active"
		name = "Gibtonite deposit"
		desc = "An active gibtonite reserve. Run!"
		stage = 1
		visible_message("<span class='warning'>There was gibtonite inside! It's going to explode!</span>")
		var/turf/bombturf = get_turf(src)
		var/area/A = get_area(bombturf)
		var/log_str = "[src.activated_ckey]<A HREF='?_src_=holder;adminmoreinfo=\ref[usr]'>?</A> [src.activated_name] has triggered a gibtonite deposit reaction <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[bombturf.x];Y=[bombturf.y];Z=[bombturf.z]'>[A.name] (JMP)</a>."
		if(z != 5)
			message_admins(log_str)
		log_game("[src.activated_ckey] ([src.activated_name]) has triggered a gibtonite deposit reaction at [A.name] ([A.x], [A.y], [A.z]).")
		countdown()

/turf/simulated/mineral/gibtonite/proc/countdown()
	spawn(0)
		while(stage == 1 && det_time > 0 && mineralAmt >= 1)
			det_time--
			sleep(5)
		if(stage == 1 && det_time <= 0 && mineralAmt >= 1)
			var/turf/bombturf = get_turf(src)
			mineralAmt = 0
			explosion(bombturf,1,3,5, adminlog = 0)
		if(stage == 0 || stage == 2)
			return

/turf/simulated/mineral/gibtonite/proc/defuse()
	if(stage == 1)
		icon_state = "rock_Gibtonite_inactive"
		desc = "An inactive gibtonite reserve. The ore can be extracted."
		stage = 2
		if(det_time < 0)
			det_time = 0
		visible_message("<span class='notice'>The chain reaction was stopped! The gibtonite had [src.det_time] reactions left till the explosion!</span>")

/turf/simulated/mineral/gibtonite/gets_drilled()
	if(stage == 0 && mineralAmt >= 1) //Gibtonite deposit is activated
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,1)
		explosive_reaction()
		return
	if(stage == 1 && mineralAmt >= 1) //Gibtonite deposit goes kaboom
		var/turf/bombturf = get_turf(src)
		mineralAmt = 0
		explosion(bombturf,1,2,5, adminlog = 0)
	if(stage == 2) //Gibtonite deposit is now benign and extractable. Depending on how close you were to it blowing up before defusing, you get better quality ore.
		var/obj/item/weapon/twohanded/required/gibtonite/G = new /obj/item/weapon/twohanded/required/gibtonite/(src)
		if(det_time <= 0)
			G.quality = 3
			G.icon_state = "Gibtonite ore 3"
		if(det_time >= 1 && det_time <= 2)
			G.quality = 2
			G.icon_state = "Gibtonite ore 2"
	var/turf/simulated/floor/plating/asteroid/airless/gibtonite_remains/G = ChangeTurf(/turf/simulated/floor/plating/asteroid/airless/gibtonite_remains)
	G.fullUpdateMineralOverlays()

/turf/simulated/floor/plating/asteroid/airless/gibtonite_remains
	var/det_time = 0
	var/stage = 0

////////////////////////////////End Gibtonite

/turf/simulated/floor/plating/asteroid/airless/cave
	var/length = 100
	var/mob_spawn_list = list("Goldgrub" = 4, "Goliath" = 9, "Basilisk" = 8, "Hivelord" = 6, "Scarab" = 1, "Spirit" = 1)
	var/sanity = 1

/turf/simulated/floor/plating/asteroid/airless/cave/proc/SpawnMonster(var/turf/T)
	if(prob(30))
		if(istype(loc, /area/mine/explored))
			return
		for(var/atom/A in range(30,T))//Lowers chance of mob clumps
			if(istype(A, /mob/living/simple_animal/hostile/asteroid))
				return
		var/randumb = pickweight(mob_spawn_list)
		switch(randumb)
			if("Goliath")
				new /mob/living/simple_animal/hostile/asteroid/goliath(T)
			if("Goldgrub")
				new /mob/living/simple_animal/hostile/asteroid/goldgrub(T)
			if("Basilisk")
				new /mob/living/simple_animal/hostile/asteroid/basilisk(T)
			if("Hivelord")
				new /mob/living/simple_animal/hostile/asteroid/hivelord(T)
			if("Scarab")
				new /mob/living/simple_animal/hostile/necron/scarab(T)
			if("Spirit")
				new /mob/living/simple_animal/hostile/dark_ghost(T)
	return

/turf/simulated/mineral/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "\red You don't have the dexterity to do this!"
		return

	if (istype(W, /obj/item/weapon/pickaxe))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return
/*
	if (istype(W, /obj/item/weapon/pickaxe/radius))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return
*/
//Watch your tabbing, microwave. --NEO
		if(last_act+W:digspeed > world.time)//prevents message spam
			return
		last_act = world.time
		user << "\red You start picking."
		playsound(user, 'sound/weapons/Genhit.ogg', 20, 1)

		if(do_after(user,W:digspeed))
			user << "\blue You finish cutting into the rock."
			gets_drilled()
	else
		return attack_hand(user)
	return

/turf/simulated/mineral/proc/gets_drilled()
	if ((src.mineralName != "") && (src.mineralAmt > 0) && (src.mineralAmt < 11))
		var/i
		for (i=0;i<mineralAmt;i++)
			if (src.mineralName == "Uranium")
				new /obj/item/weapon/ore/uranium(src)
			if (src.mineralName == "Iron")
				new /obj/item/weapon/ore/iron(src)
			if (src.mineralName == "Gold")
				new /obj/item/weapon/ore/gold(src)
			if (src.mineralName == "Silver")
				new /obj/item/weapon/ore/silver(src)
			if (src.mineralName == "Plasma")
				new /obj/item/weapon/ore/plasma(src)
			if (src.mineralName == "Diamond")
				new /obj/item/weapon/ore/diamond(src)
			if (src.mineralName == "Clown")
				new /obj/item/weapon/ore/clown(src)
	var/turf/simulated/floor/plating/asteroid/airless/N = ChangeTurf(/turf/simulated/floor/plating/asteroid/airless)
	N.fullUpdateMineralOverlays()
	return

/turf/simulated/mineral/attack_animal(mob/living/simple_animal/user as mob)
	if(user.environment_smash >= 2)
		gets_drilled()
	..()

/*
/turf/simulated/mineral/proc/setRandomMinerals()
	var/s = pickweight(list("uranium" = 5, "iron" = 50, "gold" = 5, "silver" = 5, "plasma" = 50, "diamond" = 1))
	if (s)
		mineralName = s

	var/N = text2path("/turf/simulated/mineral/[s]")
	if (N)
		var/turf/simulated/mineral/M = new N
		src = M
		if (src.mineralName)
			mineralAmt = 5
	return*/

/turf/simulated/mineral/Bumped(AM as mob|obj)
	..()
	if(istype(AM,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = AM
		if((istype(H.l_hand,/obj/item/weapon/pickaxe)) && (!H.hand))
			src.attackby(H.l_hand,H)
		else if((istype(H.r_hand,/obj/item/weapon/pickaxe)) && H.hand)
			src.attackby(H.r_hand,H)
		return
	else if(istype(AM,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = AM
		if(istype(R.module_active,/obj/item/weapon/pickaxe))
			src.attackby(R.module_active,R)
			return
/*	else if(istype(AM,/obj/mecha))
		var/obj/mecha/M = AM
		if(istype(M.selected,/obj/item/mecha_parts/mecha_equipment/tool/drill))
			src.attackby(M.selected,M)
			return*/
//Aparantly mechs are just TOO COOL to call Bump(), so fuck em (for now)
	else
		return

/**********************Asteroid**************************/

/turf/simulated/floor/plating/asteroid //floor piece
	name = "Asteroid"
	icon = 'icons/turf/floors.dmi'
	icon_state = "rocks"
	icon_plating = "rocks"
	var/dug = 0       //0 = has not yet been dug, 1 = has already been dug

/turf/simulated/floor/plating/asteroid/airless
	//oxygen = 0.01
	//nitrogen = 0.01
	//temperature = TCMB
	oxygen = ONE_ATMOSPHERE
	temperature = 273

/turf/simulated/floor/plating/asteroid/New()
	var/proper_name = name
	..()
	name = proper_name
	//if (prob(50))
	//	seedName = pick(list("1","2","3","4"))
	//	seedAmt = rand(1,4)
	if(prob(20))
		icon_state = "asteroid[rand(0,12)]"
//	spawn(2)
//O		updateMineralOverlays()

/turf/simulated/floor/plating/asteroid/ex_act(severity)
	switch(severity)
		if(3.0)
			return
		if(2.0)
			if (prob(20))
				src.gets_dug()
		if(1.0)
			src.gets_dug()
	return

/turf/simulated/floor/plating/asteroid/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if(!W || !user)
		return 0

	if ((istype(W, /obj/item/weapon/shovel)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug)
			user << "\red This area has already been dug"
			return

		user << "\red You start digging."
		playsound(src, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(40)
		if ((user.loc == T && user.get_active_hand() == W))
			user << "\blue You dug a hole."
			gets_dug()
			return

	if ((istype(W,/obj/item/weapon/pickaxe/drill)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug)
			user << "\red This area has already been dug"
			return

		user << "\red You start digging."
		playsound(src, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(30)
		if ((user.loc == T && user.get_active_hand() == W))
			user << "\blue You dug a hole."
			gets_dug()

	if ((istype(W,/obj/item/weapon/pickaxe/diamonddrill)) || (istype(W,/obj/item/weapon/pickaxe/borgdrill)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug)
			user << "\red This area has already been dug"
			return

		user << "\red You start digging."
		playsound(src, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(0)
		if ((user.loc == T && user.get_active_hand() == W))
			user << "\blue You dug a hole."
			gets_dug()

	if(istype(W,/obj/item/weapon/storage/bag/ore))
		var/obj/item/weapon/storage/bag/ore/S = W
		if(S.collection_mode == 1)
			for(var/obj/item/weapon/ore/O in src.contents)
				O.attackby(W,user)
				return

	else
		..(W,user)
	return

/turf/simulated/floor/plating/asteroid/proc/gets_dug()
	if(dug)
		return
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	dug = 1
	icon_plating = "asteroid_dug"
	icon_state = "asteroid_dug"
	return

/turf/proc/updateMineralOverlays()
	src.overlays.Cut()

	if(istype(get_step(src, NORTH), /turf/simulated/mineral))
		src.overlays += image('icons/turf/walls.dmi', "rock_side_n")
	if(istype(get_step(src, SOUTH), /turf/simulated/mineral))
		src.overlays += image('icons/turf/walls.dmi', "rock_side_s", layer=6)
	if(istype(get_step(src, EAST), /turf/simulated/mineral))
		src.overlays += image('icons/turf/walls.dmi', "rock_side_e", layer=6)
	if(istype(get_step(src, WEST), /turf/simulated/mineral))
		src.overlays += image('icons/turf/walls.dmi', "rock_side_w", layer=6)

/turf/simulated/mineral/updateMineralOverlays()
	return



/turf/proc/fullUpdateMineralOverlays()
	for (var/turf/t in range(1,src))
		t.updateMineralOverlays()

/turf/simulated/floor/plating/asteroid/Entered(atom/movable/M as mob|obj)
	..()
	if(istype(M,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = M
		if(istype(R.module, /obj/item/weapon/robot_module/miner))
			if(istype(R.module_state_1,/obj/item/weapon/storage/bag/ore))
				src.attackby(R.module_state_1,R)
			else if(istype(R.module_state_2,/obj/item/weapon/storage/bag/ore))
				src.attackby(R.module_state_2,R)
			else if(istype(R.module_state_3,/obj/item/weapon/storage/bag/ore))
				src.attackby(R.module_state_3,R)
			else
				return
