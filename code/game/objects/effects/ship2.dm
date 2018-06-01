/*
An ideally built ship system, founded on the idea of a fake area datum to power movement instead of an engine and nav console.
Because the old code is messy and this feature is worth getting perfect.
At this moment most of the old code is migrated over in the context of a single area, and some things are handled better just because of that.
I would also like to optimize the actual movement proc.
The teleport proc is about as optimized as one could hope although I would like to find a better way to handle landmarks.

-Drake
*/

/obj/effect/fake_floor
	name = "floor"
	desc = "The floor of a mobile craft."
	icon = 'icons/turf/floors.dmi'
	icon_state = "dark"
	density = 0
	anchored = 1
	layer = 2 //Turf layer. After all, it is a "turf".
	var/explosion_recursions = 1
	var/datum/fake_area/area = null
	var/damagedsprites = list("damaged1","damaged2","damaged3","damaged4","damaged5")

/obj/effect/fake_floor/Destroy()
	garbage_collect()
	..()

/obj/effect/fake_floor/proc/garbage_collect()
	var/turf/location = get_turf(src)
	location.name = initial(location.name)
	if(area)
		area.ship_turfs.Remove(src)
		area.under_turfs.Remove(location)

/obj/effect/fake_floor/New(loc, newicon = null) //Should allow us to assign a new icon on initializing, which will make life a lot easier.
	..()
	var/turf/location = get_turf(src)
	location.mouse_opacity = 0
	if(newicon)
		icon_state = newicon

/obj/effect/fake_floor/CanAtmosPass()
	return !density

/obj/effect/fake_floor/ex_act(severity)
	switch(severity)
		if(1.0)
			src.garbage_collect()
			qdel(src)
		if(2.0)
			if(prob(50))
				new /obj/item/stack/sheet/metal(get_turf(src))
			if(prob(60))
				src.garbage_collect()
				qdel(src)
			else
				src.icon_state = pick(damagedsprites)
		if(3.0)
			src.icon_state = pick(damagedsprites)

/obj/effect/fake_floor/blob_act()
	return

/obj/effect/fake_floor/fake_wall
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	icon = 'icons/turf/walls.dmi'
	icon_state = "metal0"
	density = 1
	opacity = 1
	explosion_recursions = 2
	var/hardness = 40
	var/thermite = 0
	var/base_icon_state = "metal"

/obj/effect/fake_floor/fake_wall/r_wall
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to seperate rooms."
	icon_state = "r_iron"
	hardness = 10
	base_icon_state = "r_iron"
	explosion_recursions = 3
	var/d_state = 0

/obj/effect/fake_floor/fake_wall/proc/dismantle_wall(devastated=0, explode=0)
	if(!devastated)
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		new /obj/item/stack/sheet/metal( get_turf(src) )
		new /obj/item/stack/sheet/metal( get_turf(src) )
	else
		new /obj/item/stack/sheet/metal( get_turf(src) )
		new /obj/item/stack/sheet/metal( get_turf(src) )
		new /obj/item/stack/sheet/metal( get_turf(src) )
	if(!devastated)
		var/obj/newfloor = new /obj/effect/fake_floor(get_turf(src))
		transfer_fingerprints_to(newfloor)
		newfloor.icon_state = "plating"
		newfloor.name = "plating"
		if(area)
			area.ship_turfs.Add(newfloor)
		if(istype(src, /obj/effect/fake_floor/fake_wall/r_wall))
			new /obj/structure/girder/reinforced( get_turf(src) )
		else
			new /obj/structure/girder( get_turf(src) )
	for(var/obj/effect/fake_floor/fake_wall/W in range(src,1))
		W.relativewall()
		W.update_icon()
	src.garbage_collect()
	qdel(src)

/obj/effect/fake_floor/fake_wall/ex_act(severity)
	switch(severity)
		if(1.0)
			src.garbage_collect()
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				dismantle_wall(0,1)
			else
				dismantle_wall(1,1)
		if(3.0)
			var/proba
			if (istype(src, /obj/effect/fake_floor/fake_wall/r_wall))
				proba = 15
			else
				proba = 40
			if (prob(proba))
				dismantle_wall(0,1)
		else
	return

/obj/effect/fake_floor/fake_wall/blob_act()
	if(prob(50))
		dismantle_wall()

/obj/effect/fake_floor/fake_wall/attack_paw(mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if ((HULK in user.mutations))
		if (prob(hardness))
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			usr << text("<span class='notice'>You smash through the wall.</span>")
			usr.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))
			dismantle_wall(1)
			return
		else
			playsound(src, 'sound/effects/bang.ogg', 50, 1)
			usr << text("<span class='notice'>You punch the wall.</span>")
			return
	usr << "You push the wall but nothing happens!"
	return

/obj/effect/fake_floor/fake_wall/attack_animal(var/mob/living/simple_animal/M)
	if(M.environment_smash >= 2)
		if(istype(src, /obj/effect/fake_floor/fake_wall/r_wall))
			if(M.environment_smash == 3)
				dismantle_wall(1)
				playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
				M << "<span class='notice'>You smash through the wall.</span>"
			else
				M << "<span class='warning'>This wall is far too strong for you to destroy.</span>"
		else
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			M << "<span class='notice'>You smash through the wall.</span>"
			dismantle_wall(1)
			return

/obj/effect/fake_floor/fake_wall/attack_hand(mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if (HULK in user.mutations)
		if (prob(hardness))
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			usr << text("<span class='notice'>You smash through the wall.</span>")
			usr.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))
			dismantle_wall(1)
			return
		else
			playsound(src, 'sound/effects/bang.ogg', 50, 1)
			usr << text("<span class='notice'>You punch the wall.</span>")
			return
	user << "<span class='notice'>You push the wall but nothing happens!</span>"
	playsound(src, 'sound/weapons/Genhit.ogg', 25, 1)
	src.add_fingerprint(user)
	return

/obj/effect/fake_floor/fake_wall/attackby(obj/item/weapon/W as obj, mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	//get the user's location
	if( !istype(user.loc, /turf) )	return	//can't do this stuff whilst inside objects and such

	//THERMITE related stuff. Calls src.thermitemelt() which handles melting simulated walls and the relevant effects
	if( thermite )
		if( istype(W, /obj/item/weapon/weldingtool) )
			var/obj/item/weapon/weldingtool/WT = W
			if( WT.remove_fuel(0,user) )
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/weapon/pickaxe/plasmacutter))
			thermitemelt(user)
			return

		else if(istype(W, /obj/item/weapon/lighter))
			var/obj/item/weapon/lighter/L = W
			if(L.lit)
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/weapon/match))
			var/obj/item/weapon/match/M = W
			if(M.lit)
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/device/flashlight/flare/torch))
			var/obj/item/device/flashlight/flare/torch/T = W
			if(T.on)
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/device/assembly/igniter))
			thermitemelt(user)
			return

		else if(istype(W, /obj/item/candle))
			var/obj/item/candle/C = W
			if(C.lit)
				thermitemelt(user)
				return

		else if( istype(W, /obj/item/weapon/melee/energy/blade) )
			var/obj/item/weapon/melee/energy/blade/EB = W

			EB.spark_system.start()
			user << "<span class='notice'>You slash \the [src] with \the [EB]; the thermite ignites!</span>"
			playsound(src, "sparks", 50, 1)
			playsound(src, 'sound/weapons/blade1.ogg', 50, 1)

			thermitemelt(user)
			return

		else if(istype(W, /obj/item/weapon/melee/energy/sword))
			var/obj/item/weapon/melee/energy/sword/ES = W
			if(ES.active)
				thermitemelt(user)
				return

	var/turf/T = user.loc	//get user's location for delay checks

	//DECONSTRUCTION
	add_fingerprint(user)

	if( istype(W, /obj/item/weapon/weldingtool) )
		var/obj/item/weapon/weldingtool/WT = W
		if( WT.remove_fuel(0,user) )
			user << "<span class='notice'>You begin slicing through the outer plating.</span>"
			playsound(src, 'sound/items/Welder.ogg', 100, 1)

			sleep(100)
			if( !istype(src, /obj/effect/fake_floor/fake_wall) || !user || !WT || !WT.isOn() || !T )	return

			if( user.loc == T && user.get_active_hand() == WT )
				user << "<span class='notice'>You remove the outer plating.</span>"
				dismantle_wall()
		else
			user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
			return

	else if( istype(W, /obj/item/weapon/pickaxe/plasmacutter) )

		user << "<span class='notice'>You begin slicing through the outer plating.</span>"
		playsound(src, 'sound/items/Welder.ogg', 100, 1)

		sleep(60)
		if( !istype(src, /obj/effect/fake_floor/fake_wall) || !user || !W || !T )	return

		if( user.loc == T && user.get_active_hand() == W )
			user << "<span class='notice'>You remove the outer plating.</span>"
			dismantle_wall()
			for(var/mob/O in viewers(user, 5))
				O.show_message("<span class='warning'>The wall was sliced apart by [user]!</span>", 1, "<span class='warning'>You hear metal being sliced apart.</span>", 2)
		return

	//DRILLING
	else if (istype(W, /obj/item/weapon/pickaxe/diamonddrill))

		user << "<span class='notice'>You begin to drill though the wall.</span>"

		sleep(60)
		if( !istype(src, /obj/effect/fake_floor/fake_wall) || !user || !W || !T )	return

		if( user.loc == T && user.get_active_hand() == W )
			user << "<span class='notice'>Your drill tears though the last of the reinforced plating.</span>"
			dismantle_wall()
			for(var/mob/O in viewers(user, 5))
				O.show_message("<span class='warning'>The wall was drilled through by [user]!</span>", 1, "<span class='warning'>You hear the grinding of metal.</span>", 2)
		return

	else if( istype(W, /obj/item/weapon/melee/energy/blade) )
		var/obj/item/weapon/melee/energy/blade/EB = W

		EB.spark_system.start()
		user << "<span class='notice'>You stab \the [EB] into the wall and begin to slice it apart.</span>"
		playsound(src, "sparks", 50, 1)

		sleep(70)
		if( !istype(src, /obj/effect/fake_floor/fake_wall) || !user || !EB || !T )	return

		if( user.loc == T && user.get_active_hand() == W )
			EB.spark_system.start()
			playsound(src, "sparks", 50, 1)
			playsound(src, 'sound/weapons/blade1.ogg', 50, 1)
			dismantle_wall(1)
			for(var/mob/O in viewers(user, 5))
				O.show_message("<span class='warning'>The wall was sliced apart by [user]!</span>", 1, "<span class='warning'>You hear metal being sliced apart and sparks flying.</span>", 2)
		return

	else if(istype(W,/obj/item/apc_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/newscaster_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/alarm_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/firealarm_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/light_fixture_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/light_fixture_frame/small))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/weapon/contraband/poster))
		user << "\red You can't add this to the ship anymore!"
		return

	else
		return attack_hand(user)
	return

/obj/effect/fake_floor/fake_wall/proc/thermitemelt(mob/user as mob)
	overlays = list()
	var/obj/effect/overlay/O = new/obj/effect/overlay( get_turf(src) )
	O.name = "thermite"
	O.desc = "Looks hot."
	O.icon = 'icons/effects/fire.dmi'
	O.icon_state = "2"
	O.anchored = 1
	O.opacity = 1
	O.density = 1
	O.layer = 5

	playsound(src, 'sound/items/Welder.ogg', 100, 1)

	if(thermite >= 50)
		var/obj/effect/fake_floor/F = new /obj/effect/fake_floor(get_turf(src))
		F.icon_state = "wall_thermite"
		F.name = "plating"
		if(area)
			area.ship_turfs.Add(F)
		src.garbage_collect()
		qdel(src)
		if(user != null)
			F.add_hiddenprint(user)
		spawn(max(100,300-thermite))
			if(O)	qdel(O)
	else
		thermite = 0
		spawn(50)
			if(O)	qdel(O)
	return

datum/reagent/thermite/reaction_obj(var/obj/O, var/volume)
	src = null
	if(volume >= 1 && istype(O, /obj/effect/fake_floor/fake_wall))
		var/obj/effect/fake_floor/fake_wall/Wall = O
		if(istype(Wall, /obj/effect/fake_floor/fake_wall/r_wall))
			Wall.thermite = Wall.thermite+(volume*2.5)
		else
			Wall.thermite = Wall.thermite+(volume*10)
		Wall.overlays = list()
		Wall.overlays += image('icons/effects/effects.dmi',"thermite")
	return

/obj/effect/fake_floor/fake_wall/r_wall/attackby(obj/item/weapon/W as obj, mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	//get the user's location
	if( !istype(user.loc, /turf) )	return	//can't do this stuff whilst inside objects and such

	//THERMITE related stuff. Calls src.thermitemelt() which handles melting simulated walls and the relevant effects
	if( thermite )
		if( istype(W, /obj/item/weapon/weldingtool) )
			var/obj/item/weapon/weldingtool/WT = W
			if( WT.remove_fuel(0,user) )
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/weapon/pickaxe/plasmacutter))
			thermitemelt(user)
			return

		else if( istype(W, /obj/item/weapon/melee/energy/blade) )
			var/obj/item/weapon/melee/energy/blade/EB = W

			EB.spark_system.start()
			user << "<span class='notice'>You slash \the [src] with \the [EB]; the thermite ignites!</span>"
			playsound(src, "sparks", 50, 1)
			playsound(src, 'sound/weapons/blade1.ogg', 50, 1)

			thermitemelt(user)
			return

		else if(istype(W, /obj/item/weapon/melee/energy/sword))
			var/obj/item/weapon/melee/energy/sword/ES = W
			if(ES.active)
				thermitemelt(user)
				return

	var/turf/T = user.loc	//get user's location for delay checks

	//DECONSTRUCTION
	add_fingerprint(user)

	switch(d_state)
		if(0)
			if (istype(W, /obj/item/weapon/wirecutters))
				playsound(src, 'sound/items/Wirecutter.ogg', 100, 1)
				src.d_state = 1
				src.icon_state = "r_wall-1"
				new /obj/item/stack/rods( src )
				user << "<span class='notice'>You cut the outer grille.</span>"
				return

		if(1)
			if (istype(W, /obj/item/weapon/screwdriver))
				user << "<span class='notice'>You begin removing the support lines.</span>"
				playsound(src, 'sound/items/Screwdriver.ogg', 100, 1)

				sleep(40)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( d_state == 1 && user.loc == T && user.get_active_hand() == W )
					src.d_state = 2
					src.icon_state = "r_wall-2"
					user << "<span class='notice'>You remove the support lines.</span>"
				return

			//REPAIRING (replacing the outer grille for cosmetic damage)
			else if( istype(W, /obj/item/stack/rods) )
				var/obj/item/stack/rods/O = W
				src.d_state = 0
				src.icon_state = "r_iron"
				relativewall_neighbours()	//call smoothwall stuff
				user << "<span class='notice'>You replace the outer grille.</span>"
				O.use(1)
				return

		if(2)
			if( istype(W, /obj/item/weapon/weldingtool) )
				var/obj/item/weapon/weldingtool/WT = W
				if( WT.remove_fuel(0,user) )

					user << "<span class='notice'>You begin slicing through the metal cover.</span>"
					playsound(src, 'sound/items/Welder.ogg', 100, 1)

					sleep(60)
					if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !WT || !WT.isOn() || !T )	return

					if( d_state == 2 && user.loc == T && user.get_active_hand() == WT )
						src.d_state = 3
						src.icon_state = "r_wall-3"
						user << "<span class='notice'>You press firmly on the cover, dislodging it.</span>"
				else
					user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
				return

			if( istype(W, /obj/item/weapon/pickaxe/plasmacutter) )

				user << "<span class='notice'>You begin slicing through the metal cover.</span>"
				playsound(src, 'sound/items/Welder.ogg', 100, 1)

				sleep(40)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( d_state == 2 && user.loc == T && user.get_active_hand() == W )
					src.d_state = 3
					src.icon_state = "r_wall-3"
					user << "<span class='notice'>You press firmly on the cover, dislodging it.</span>"
				return

		if(3)
			if (istype(W, /obj/item/weapon/crowbar))

				user << "<span class='notice'>You struggle to pry off the cover.</span>"
				playsound(src, 'sound/items/Crowbar.ogg', 100, 1)

				sleep(100)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( d_state == 3 && user.loc == T && user.get_active_hand() == W )
					src.d_state = 4
					src.icon_state = "r_wall-4"
					user << "<span class='notice'>You pry off the cover.</span>"
				return

		if(4)
			if (istype(W, /obj/item/weapon/wrench))

				user << "<span class='notice'>You start loosening the anchoring bolts which secure the support rods to their frame.</span>"
				playsound(src, 'sound/items/Ratchet.ogg', 100, 1)

				sleep(40)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( d_state == 4 && user.loc == T && user.get_active_hand() == W )
					src.d_state = 5
					src.icon_state = "r_wall-5"
					user << "<span class='notice'>You remove the bolts anchoring the support rods.</span>"
				return

		if(5)
			if( istype(W, /obj/item/weapon/weldingtool) )
				var/obj/item/weapon/weldingtool/WT = W
				if( WT.remove_fuel(0,user) )

					user << "<span class='notice'>You begin slicing through the support rods.</span>"
					playsound(src, 'sound/items/Welder.ogg', 100, 1)

					sleep(100)
					if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !WT || !WT.isOn() || !T )	return

					if( d_state == 5 && user.loc == T && user.get_active_hand() == WT )
						src.d_state = 6
						src.icon_state = "r_wall-6"
						new /obj/item/stack/rods( src )
						user << "<span class='notice'>The support rods drop out as you cut them loose from the frame.</span>"
				else
					user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
				return

			if( istype(W, /obj/item/weapon/pickaxe/plasmacutter) )

				user << "<span class='notice'>You begin slicing through the support rods.</span>"
				playsound(src, 'sound/items/Welder.ogg', 100, 1)

				sleep(70)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( d_state == 5 && user.loc == T && user.get_active_hand() == W )
					src.d_state = 6
					src.icon_state = "r_wall-6"
					new /obj/item/stack/rods( src )
					user << "<span class='notice'>The support rods drop out as you cut them loose from the frame.</span>"
				return

		if(6)
			if( istype(W, /obj/item/weapon/crowbar) )

				user << "<span class='notice'>You struggle to pry off the outer sheath.</span>"
				playsound(src, 'sound/items/Crowbar.ogg', 100, 1)

				sleep(100)
				if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

				if( user.loc == T && user.get_active_hand() == W )
					user << "<span class='notice'>You pry off the outer sheath.</span>"
					dismantle_wall()
				return

	//DRILLING
	if (istype(W, /obj/item/weapon/pickaxe/diamonddrill))

		user << "<span class='notice'>You begin to drill though the wall.</span>"

		sleep(200)
		if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !W || !T )	return

		if( user.loc == T && user.get_active_hand() == W )
			user << "<span class='notice'>Your drill tears though the last of the reinforced plating.</span>"
			dismantle_wall()

	else if( istype(W, /obj/item/stack/sheet/metal) && d_state )
		var/obj/item/stack/sheet/metal/MS = W

		user << "<span class='notice'>You begin patching-up the wall with \a [MS].</span>"

		sleep( max(20*d_state,100) )	//time taken to repair is proportional to the damage! (max 10 seconds)
		if( !istype(src, /obj/effect/fake_floor/fake_wall/r_wall) || !user || !MS || !T )	return

		if( user.loc == T && user.get_active_hand() == MS && d_state )
			src.d_state = 0
			src.icon_state = "r_iron"
			relativewall_neighbours()	//call smoothwall stuff
			user << "<span class='notice'>You repair the last of the damage.</span>"
			MS.use(1)

	else if(istype(W, /obj/item/weapon/melee/energy/blade))
		user << "<span class='notice'>This wall is too thick to slice through. You will need to find a different path.</span>"
		return

	else if(istype(W,/obj/item/apc_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/newscaster_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/alarm_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/firealarm_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/light_fixture_frame))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/light_fixture_frame/small))
		user << "\red You can't add this to the ship anymore!"
		return

	else if(istype(W,/obj/item/weapon/contraband/poster))
		user << "\red You can't add this to the ship anymore!"
		return

	else
		return attack_hand(user)
	return

/obj/effect/fake_floor/fake_wall/New(loc, newicon = null)
	..(loc, newicon)
	if(newicon)
		base_icon_state = newicon
	relativewall_neighbours()

/obj/effect/fake_floor/fake_wall/Destroy()
	for(var/obj/effect/fake_floor/fake_wall/W in range(src,1))
		W.relativewall()
		W.update_icon()
	..()
	return

/obj/effect/fake_floor/fake_wall/relativewall_neighbours()
	for(var/obj/effect/fake_floor/fake_wall/W in range(src,1))
		W.relativewall()
		W.update_icon()//Refreshes the wall to make sure the icons don't desync
	return

/obj/effect/fake_floor/fake_wall/relativewall()
	var/junction = 0 //will be used to determine from which side the wall is connected to other walls
	for(var/obj/effect/fake_floor/fake_wall/W in orange(src,1))
		if(abs(src.x-W.x)-abs(src.y-W.y)) //doesn't count diagonal walls
			junction |= get_dir(src,W)
	icon_state = "[base_icon_state][junction]"
	return

/turf/simulated/proc/make_fake()
	var/obj/effect/fake_floor/T
	if(istype(src,/turf/simulated/wall))
		var/turf/simulated/wall/wallturf = src
		if(istype(src,/turf/simulated/wall/r_wall))
			var/obj/effect/fake_floor/fake_wall/W = new /obj/effect/fake_floor/fake_wall/r_wall(src)
			W.name = src.name
			W.desc = src.desc
			W.icon = src.icon
			W.icon_state = src.icon_state
			W.base_icon_state = wallturf.walltype
			W.relativewall_neighbours()
			T = W
		else
			var/obj/effect/fake_floor/fake_wall/W = new /obj/effect/fake_floor/fake_wall(src)
			W.name = src.name
			W.desc = src.desc
			W.icon = src.icon
			W.icon_state = src.icon_state
			W.base_icon_state = wallturf.walltype
			W.relativewall_neighbours()
			T = W
	else
		var/obj/effect/fake_floor/F = new /obj/effect/fake_floor(src)
		F.name = src.name
		F.desc = src.desc
		F.icon = src.icon
		F.icon_state = src.icon_state
		T = F
	ChangeTurf(/turf/simulated/floor/plating)
	return T

/datum/fake_area
	var/name = "Fake Area"
	var/desc = "An Area. But Fake."
	var/list/ship_turfs = list()
	var/list/under_turfs = list()
	var/list/under = list()

/datum/fake_area/proc/move(var/direction, var/collision_force, var/smoothingtime = 2)
	set background = 1 //If this takes a long time or repeats a lot, that is okay.

	var/blocked = 0
	var/cleanup = 0
	for(var/obj/effect/fake_floor/T in ship_turfs)
		if(!T || T.loc == null)
			ship_turfs.Remove(T)
			cleanup = 1
	if(cleanup) return 0
	for(var/obj/effect/fake_floor/T in ship_turfs)
		var/turf/destination = get_step(T,direction)
		if(destination && destination.density)
			if(collision_force)
				destination.ex_act(4-collision_force)
			blocked = 1
		if(!destination) destination = get_step(T,direction)
		if(!destination) blocked = 1 //Going to assume they are trying to go off the side of the map or something, which would be bad.
		var/check = 1
		for(var/atom/O in range(0,destination))
			if(O in ship_turfs)
				check = 0
		if(check)
			for(var/obj/O in range(0,destination))
				T.density = 1
				var/dense = !O.CanPass(T, T.loc, 1, 0)
				T.density = initial(T.density)
				if(istype(O, /obj/structure/window)) dense = 1 //Because windows are shit and let you move through them sometimes when they shouldn't.
				if(O && dense && O.anchored)
					if(collision_force)
						if(prob(20))
							O.blob_act() //This should improve some matters...
						O.ex_act(4-collision_force)
					blocked = 1
				else if(O && dense && !O.anchored)
					step(O,direction)
					if(O.loc == destination)
						if(collision_force)
							O.ex_act(4-collision_force)
						blocked = 1
			for(var/mob/living/M in range(0,destination))
				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					if(collision_force)
						H.Paralyse(2)
						H.take_organ_damage(5*collision_force, 0)
					else
						H.Weaken(2)
						H.take_organ_damage(1, 0)
					step(H,direction)
					if(H && H.loc == destination)
						blocked = 1
	if(blocked)
		return 0
	var/list/moved = list()
	for(var/obj/effect/fake_floor/T in ship_turfs)
		var/turf/destination = get_step(T,direction)
		var/check = 1
		for(var/atom/O in range(0,destination))
			if(O in ship_turfs)
				check = 0
		if(check)
			if(!destination) destination = get_step(T,direction)
			for(var/obj/O in range(0,destination))
				if(istype(O, /obj/effect/hotspot))
					var/obj/effect/hotspot/H = O
					H.Kill()
				else
					T.density = 1
					var/dense = !O.CanPass(T, T.loc, 1, 0)
					T.density = initial(T.density)
					if(istype(O, /obj/structure/window)) dense = 1
					if(!dense && !O.anchored)
						step(O,direction)
						if(O.loc == destination)
							under.Add(O)
							O.layer = 1.9
					if(!dense && O.anchored)
						under.Add(O)
						O.layer = 1.9
			if(destination)
				destination.mouse_opacity = 0                               //A little hack to make it more realistic. No right click seeing the underlying turf.
				under_turfs.Add(destination)
			else
				spawn(2)
					while(!destination) //I hope to the emperor this while loop doesn't blow up someday. If I know what causes that it will be easy to patch though.
						sleep(2)
						destination = get_step(T,direction)
					destination.mouse_opacity = 0
					under_turfs.Add(destination)
		for(var/atom/movable/MA in range(0,T))
			if(!(MA in moved) && !(MA in under) && (!istype(MA, /obj/effect/landmark) || MA.name != "pmteam"))
				MA.loc = get_step(MA,direction)
				moved.Add(MA)
				spawn(0) //Faking smooth movement for things that can't even move.
					if(direction == NORTH)
						MA.pixel_y = -31
						animate(MA, pixel_y = 0, time = smoothingtime)
					if(direction == SOUTH)
						MA.pixel_y = 31
						animate(MA, pixel_y = 0, time = smoothingtime)
					if(direction == EAST)
						MA.pixel_x = -31
						animate(MA, pixel_x = 0, time = smoothingtime)
					if(direction == WEST)
						MA.pixel_x = 31
						animate(MA, pixel_x = 0, time = smoothingtime)
	for(var/turf/UT in under_turfs)
		var/covered = 0
		for(var/atom/A in range(0,UT))
			if(A in ship_turfs)
				covered = 1
		if(!covered)
			UT.mouse_opacity = initial(UT.mouse_opacity)
	for(var/obj/U in under)
		var/covered = 0
		for(var/atom/A in range(0,U))
			if(A in ship_turfs)
				covered = 1
		if(!covered)
			U.layer = initial(U.layer)
			under.Remove(U)
	return 1

/datum/fake_area/proc/teleport(var/turf/centerdest)
	var/turf/center = get_turf(pick(ship_turfs)) //Randomly selects a point of reference from the area.
	for(var/obj/effect/fake_floor/T in ship_turfs)
		if(!T)
			ship_turfs.Remove(T)
		var/x_coord = centerdest.x + T.x - center.x
		var/y_coord = centerdest.y + T.y - center.y
		var/z_coord = centerdest.z + T.z - center.z
		if(x_coord > world.maxx || x_coord < 1)
			return 0
		if(y_coord > world.maxy || y_coord < 1)
			return 0
		if(z_coord > world.maxz || z_coord < 1)
			return 0
	for(var/obj/effect/fake_floor/T in ship_turfs)
		for(var/mob/living/M in get_turf(T))
			if(M.client)
				spawn(0)
					if(M.buckled)
						shake_camera(M, 2, 1)
					else
						shake_camera(M, 7, 1)
			if(istype(M, /mob/living/carbon))
				if(!M.buckled)
					M.Weaken(3)
		var/turf/destination = locate(centerdest.x + T.x - center.x, centerdest.y + T.y - center.y, centerdest.z + T.z - center.z)
		for(var/obj/O in destination)
			if(!istype(O, /obj/effect/landmark) && !istype(O, /obj/effect/warp))
				qdel(O)
		for(var/mob/living/M in destination)
			M.gib()
		for(var/atom/movable/MA in get_turf(T))
			if(MA != T && !(MA in under) && !(istype(MA, /obj/effect/landmark)) && !istype(MA, /obj/effect/warp))
				MA.loc = destination
			if(istype(MA, /obj/effect/landmark) && MA.name == "pmteam") //Move that landmark.
				MA.loc = destination
		T.loc = destination
		if(destination.density)
			destination.ChangeTurf(/turf/snow) //Destroys any turf it is landing on.
		destination.mouse_opacity = 0
		src.under_turfs.Add(destination)
	return 1

/datum/fake_area/proc/add_turf(var/atom/T)
	if(istype(T, /obj/effect/fake_floor))
		src.ship_turfs.Add(T)
		var/turf/location = get_turf(T)
		src.under_turfs.Add(location)
		return 1
	else if(istype(T, /turf/simulated))
		var/turf/simulated/ST = T
		var/obj/effect/fake_floor/F = ST.make_fake()
		src.ship_turfs.Add(F)
		var/turf/location = get_turf(F)
		src.under_turfs.Add(location)
		return 1
	else
		return 0