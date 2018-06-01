/turf/unsimulated/floor
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "floor"
	oxygen = ONE_ATMOSPHERE //Shuttles shouldn't be death traps that are constantly absolute zero...
	temperature = T20C

/turf/unsimulated/floor/plating
	name = "plating"
	icon_state = "plating"
	intact = 0

/turf/unsimulated/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"

/turf/unsimulated/floor/engine
	icon_state = "engine"

/turf/unsimulated/floor/grid
	icon_state = "grid"

/turf/unsimulated/floor/tyranid
	icon_state = "tyranid0"

/turf/unsimulated/floor/tyranid/New()
	..()
	icon_state = pick("tyranid0", "tyranid1", "tyranid2")

/turf/unsimulated/floor/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	thermal_conductivity = 1.6
	heat_capacity = 1000
	temperature = 265



/turf/unsimulated/floor/snow/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/weapon/snowshovel))
		if(stepping)
			user << "\blue You hit a patch of ice. Slow it down Mighty Mouse."
			return
		user << "\blue Digging up some of that snow..."
		playsound(src, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better
		ReplaceWithPlating()
		return
	return

/turf/unsimulated/floor/attack_paw(user as mob)
	return src.attack_hand(user)

/*
snow stuff!
*/

/turf/unsimulated/floor/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	//lighting_lumcount = 4 //I am going to add this line here but keep it hexed out until I can test other things. This is a possible solution to dark patches caused by explosions though.
	//luminosity = 15 //lets try that! //Emprah... It's THIS line's fault.
	thermal_conductivity = 1.6
	heat_capacity = 1000
	temperature = 265

	var/stepped = 0
	var/stepping = 0

/turf/unsimulated/floor/snow/New()
	..()
	if(icon_state == "snow" || icon_state == "snow1" || icon_state == "snow2" || icon_state == "snow3")
		var/snowmixer = rand(1, 3)
		switch(snowmixer)
			if(1)
				icon_state = "snow1"
			if(2)
				icon_state = "snow2"
			if(3)
				icon_state = "snow3"


/turf/unsimulated/floor/snow/Entered(AM as mob|obj)
	..()
	if(icon_state != "snow" && icon_state != "snow1" && icon_state != "snow2" && icon_state != "snow3" && icon_state != "snowt1" && icon_state != "snowt2") return //No deleting paths by stepping on them.
	stepping = 1
	if(locate(/obj/effect/fake_floor) in src) return //No footprints if they are not actually standing on the snow.
	if(ismob(AM))
		var/mob/living/M = AM
		if(M.reagents)
			if(M.reagents.has_reagent("flying")) //You don't leave footprints if you are hovering.
				return
	spawn(5)
		if(!istype(src, /turf/unsimulated/floor/snow)) return //If we aren't snow anymore, no need for this.
		if(!stepped)
			if(istype(AM,/mob/living/))
				icon_state = "snowt1"
				stepped = 1
				stepping = 0
			else
				stepping = 0
				return
		else
			name = "Snow tracks"
			switch(stepped)
				if(1)
					icon_state = "snowt2"
					stepped = 2
					stepping = 0
				if(2)
					icon_state = "snowt3"
					stepped = 3
					stepping = 0
				if(3)
					stepping = 0
					return


/turf/unsimulated/floor/snow/ex_act(severity)
	return

/*
croneworlds floor
*/
/turf/unsimulated/floor/crone
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "s1"


/turf/unsimulated/floor/crone/New()	//See? Normal snow
	..()
	var/floorrandom = rand(1, 10)
	switch(floorrandom)
		if(1)
			icon_state = "s1"
		if(2)
			icon_state = "s2"
		if(3)
			icon_state = "s3"
		if(4)
			icon_state = "s4"
		if(5)
			icon_state = "s5"
		if(6)
			icon_state = "s6"
		if(7)
			icon_state = "s7"
		if(8)
			icon_state = "s8"
		if(9)
			icon_state = "s9"
		if(10)
			icon_state = "s10"

/turf/unsimulated/floor/crone/ex_act(severity)
	return

/turf/unsimulated/floor/hiddentrigger
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "s1"
	var/stepped = 0
	var/counter = 1

/turf/unsimulated/floor/hiddentrigger/Entered(atom/movable/AM)		//ITS A TRAP!
	..()
	if(stepped) return
	if(istype(AM, /obj/effect))									//We don't want no effects
		return
	if(istype(AM, /atom/movable))								//Wait what is this?
		if(isliving(AM))										//Is it alive?
			stepped = 1
			for(var/obj/effect/landmark/cronespawner/A in landmarks_list)
				if(A.name == "cronespawner")
					new /obj/effect/landmark/costume/crone(get_turf(A))
					counter++
					qdel(A)
					AM.visible_message("<span class='danger'> falls into the darkness below!</span>")

/*
Emergency Late Join Workaround
*/

/turf/unsimulated/floor/slipstream
	name = "alphashuttle"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "snow"
	thermal_conductivity = 1.6
	heat_capacity = 1000
	temperature = 265


/turf/unsimulated/floor/slipstream/Entered(atom/movable/AM)		//ITS A TRAP!
	..()

	if(istype(AM, /obj/effect))									//We don't want no effects
		return

	if(istype(AM, /atom/movable))								//Wait what is this?
		if(isliving(AM))										//Is it alive?
			fall(AM)										//Seeya later!

	else
		return

/turf/unsimulated/floor/slipstream/proc/fall(mob/living/M as mob, mob/user as mob)
	M.loc = get_turf(locate("landmark*EmergencyLJ")) 			//SEEYA LATER!


/turf/unsimulated/floor/slipstream/ex_act(severity)
	return