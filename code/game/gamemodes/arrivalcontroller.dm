/obj/effect/landmark/placeholderalpha //I am just going to make this type since it doesn't appear to exist yet.
	name = "arrivals spawn placeholder" //If this is just my computer not syncing which it probably is, feel free to delete these two lines. I will after I sync.

	New()
		..()
		invisibility = 100 //I don't want this being invisible to the code!!!

/datum/controller/gameticker/proc/arrivalcontroller()
	var/area/centcom/transportONE/B
	var/area/centcom/transportTWO/C
	var/area/centcom/transportTHREE/D
	var/area/centcom/transportFOUR/E
	for(var/area/centcom/A in world)
		if(istype(A, /area/centcom/transportONE)) B = A
		if(istype(A, /area/centcom/transportTWO)) C = A
		if(istype(A, /area/centcom/transportTHREE)) D = A
		if(istype(A, /area/centcom/transportFOUR)) E = A
	var/list/shuttles = list(B, C, D, E)

	for(var/area/centcom/transport in shuttles)
		for(var/turf/T in transport)
			for(var/mob/living/P in T)
				P.show_message("<FONT color='blue'>You are starting your descent towards the planet.</FONT>")
				P.show_message("<span class='alert'>Estimated Arrival is...</span>")

	for(var/turf/T in get_area_turfs(B))
		for(var/mob/living/P in T)
			P << "\blue Four Minutes."

	for(var/turf/T in get_area_turfs(C))
		for(var/mob/living/P in T)
			P << "\blue Six Minutes."

	for(var/turf/T in get_area_turfs(D))
		for(var/mob/living/P in T)
			P << "\blue Eight Minutes, sir."

	for(var/turf/T in get_area_turfs(E))
		for(var/mob/living/P in T)
			P << "\blue Eight Minutes."

	sleep(1200)					//two minutes I think

	for(var/turf/T in get_area_turfs(B))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nTwo Minutes."

	for(var/turf/T in get_area_turfs(C))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nFour Minutes."

	for(var/turf/T in get_area_turfs(D))
		for(var/mob/living/P in T)
			P << "\blue Planet in sight. Stolen battleship identified. I will have you in range of the planet in...\nSix Minutes."

	for(var/turf/T in get_area_turfs(E))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nSix Minutes."

	sleep(1200)					//two minutes I think

	for(var/turf/T in get_area_turfs(B))
		for(var/mob/living/P in T)
			P << "\blue Arriving."
			if(P.buckled)
				P.buckled.unbuckle()
			P.loc = get_turf(locate("landmark*TONE"))

	for(var/turf/T in get_area_turfs(C))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nTwo Minutes."

	for(var/turf/T in get_area_turfs(D))
		for(var/mob/living/P in T)
			P << "\blue No movement on the battleship. Our weapons are hot. Holding fire. \nFour Minutes untill we have teleporter range."

	for(var/turf/T in get_area_turfs(E))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nFour Minutes."

	sleep(1200)					//two minutes I think

	for(var/turf/T in get_area_turfs(C))
		for(var/mob/living/P in T)
			P << "\blue Arriving."
			if(P.buckled)
				P.buckled.unbuckle()
			P.loc = get_turf(locate("landmark*TTWO"))

	for(var/turf/T in get_area_turfs(D))
		for(var/mob/living/P in T)
			P << "\blue \nTwo Minutes. After you teleport we will pull back to high orbit and keep an LOS on the battleship. Prepare to deploy."
			P << sound('sound/effects/droppod.ogg')

	for(var/turf/T in get_area_turfs(E))
		for(var/mob/living/P in T)
			P << "\blue Estimated Arrival is...\nTwo Minutes."

	sleep(1200)					//two minutes I think

	for(var/turf/T in get_area_turfs(D))
		for(var/mob/living/P in T)
			P << "\blue We are now in teleporter range. Good Luck."

		for(var/obj/machinery/door/poddoor/K in T)
			qdel(K)

	for(var/turf/T in get_area_turfs(E))
		for(var/mob/living/P in T)
			P << "\blue Arriving."
			if(P.buckled)
				P.buckled.unbuckle()
			P.loc = get_turf(locate("landmark*TFOUR"))

	//clean up

	for(var/obj/effect/landmark/K in landmarks_list)
		if(K.name == "JoinLate")
			qdel(K)

	for(var/obj/effect/landmark/placeholderbeta/K in landmarks_list)		//Find the placeholders!
		var/turf/unsimulated/floor/slipstream/N = new(get_turf(K))							//Heres one!
		N.name = "JoinLate"
		qdel(K)

	for(var/obj/effect/landmark/placeholderalpha/K in landmarks_list)		//Find the placeholders!
		var/obj/effect/landmark/N = new(get_turf(K))							//Heres one!,
		N.name = "JoinLate"														//Change it's name!
		qdel(K)																	//Lets get rid of the placeholder!
