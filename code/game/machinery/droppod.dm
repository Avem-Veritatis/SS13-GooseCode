/obj/machinery/door_control/sdroppod
	name = "Big Red Button"
	desc = "It's bad news. It's a big red button that once pressed... can not be unpressed."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "sec_lock"
	use_power = 0
	var/used = 0					//How many drop pods are ready
	var/poddeployed = 1 //to see if a drop pod has already been deployed


/obj/machinery/door_control/sdroppod/attack_hand(mob/user as mob)
	if(used > 6)
		user << "\red All Drop Pods Deployed. Zero Remaining."			//Yep not enough drop pods
		return
	used++


	for(var/area/droppod/dp1/X in world)					//Lets look at all the areas. Since areas don't move.
 															//Lets look at all the movable objects in that location

		for(var/area/droppod/dp2/T in world)			//Lets look at all the areas again. All one of them.

			X.move_contents_to(T, /turf/simulated/floor/dropod)
			for(var/mob/living/carbon/A in T)
				playsound(A,'sound/effects/droppod.ogg',50,1)		//playsound
				shake_camera(A, 7, 1)

	..()
	icon_state = "sec_lock"
	sleep (260)

	for(var/area/droppod/dp2/X in world)						//Lets look at all the landmarks
		for(var/atom/movable/O in X)					//Lets look at all the movable objects in that location
			O.loc = get_turf(locate("landmark*saladrop3"))	//Move object to saladrop2

	if(poddeployed)
		var/datum/shuttle_manager/s = shuttles["droppod"]
		if(istype(s)) s.move_shuttle(0,1)
		poddeployed = 0


	world << sound('sound/effects/explosionfar.ogg')
	return
