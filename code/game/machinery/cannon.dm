/*
The Basic Cannon Template
*/

/obj/machinery/cannon
	name = "Cannon Template"
	desc = "This resembles a cannon which is often used as a template for other cannons. How odd."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "pmcannon"
	density = 1
	anchored = 0
	use_power = 0
	var/loaded = 0

/obj/machinery/cannon/attack_hand(mob/user)
	if(!loaded)
		user.visible_message("<span class='notice'>[user] opens the cannon's breach and inspects the chamber.</span>", "<span class='notice'>You check to see if it is loaded. NOPE! It's not.</span>")
		return
	else
		user.visible_message("<span class='notice'>[user] fires the [src].</span>", "<span class='notice'>You fire the [src].</span>")
		fire()

/obj/machinery/cannon/proc/fire()
	var/cannonsound = pick('sound/machines/cannon1.ogg','sound/machines/cannon2.ogg','sound/machines/cannon3.ogg')
	playsound(loc, cannonsound, 60, 0)
	loaded = 0
	switch(dir)
		if(8)
			spawn(0)
				pixel_x = 10
				sleep (4)
				pixel_x = 5
				sleep (2)
				pixel_x = 3
				sleep (1)
				pixel_x = 0
		if(4)
			spawn(0)
				pixel_x = -10
				sleep (4)
				pixel_x = -5
				sleep (2)
				pixel_x = -3
				sleep (1)
				pixel_x = -0
		if(1)
			spawn(0)
				pixel_y = -10
				sleep (4)
				pixel_y = -5
				sleep (2)
				pixel_y = -3
				sleep (1)
				pixel_y = 0
		if(2)
			spawn(0)
				pixel_y = 10
				sleep (4)
				pixel_y = 5
				sleep (2)
				pixel_y = 3
				sleep (1)
				pixel_y = 0

/*
Nurgle Cannon
*/


/obj/machinery/cannon/nurglecannon
	name = "Plague Cannon"
	desc = "This resembles an artillery piece from the 31rd century, but it appears to have been in the warp for a long long time."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "pmcannon"

	fire()
		..()
		var/obj/machinery/cannon/B = src
		var/movementdirection = B.dir
		var/range = 1
		var/obj/item/cannonball/nurgleround/A = new(B.loc)
		var/newtonforce = 300 										//Force is equal to mass times velocity- THANKS NEWTON!
		var/maxrange = 0

		A.Move(get_step(B,movementdirection), movementdirection)	//Lets get clear of the cannon
		A.Move(get_step(B,movementdirection), movementdirection)

		//everyone gets knocked down
		while(newtonforce > 1)
			if(maxrange > 80) break
			for(var/turf/simulated/wall/M in range(range, A.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(A.loc, randomizer, 75, 0)
					qdel(M)
					newtonforce -= 35											//get through 2 normal walls
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
					newtonforce -= 55											//get through 1 reinforced wall
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(A.loc, randomizer, 75, 0)
			for(var/obj/structure/M in range(range, A.loc))						//structures
				if(istype(M, /obj/structure/grille))
					qdel(M)
					newtonforce -= 15												//get through 6 grills
				if(!istype(M,/obj/structure/ladder) && !istype(M,/obj/structure/ladder2) && !istype(M,/obj/structure/necron_entrance))
					qdel(M)
					newtonforce -= 15
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(A.loc, randomizer, 75, 0)
			for(var/obj/effect/fake_floor/fake_wall/M in range(range, A.loc))
				if(!istype(M, /obj/effect/fake_floor/fake_wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(A.loc, randomizer, 75, 0)
					newtonforce -= 35
					qdel(M)
				else
					newtonforce -= 55
					M.ex_act(1)
			for(var/obj/structure/window/M in range(range, A.loc))
				qdel(M)															//fuck glass
			for(var/obj/machinery/M in range(range, A.loc))
				if(!istype(M,/obj/machinery/cannon/nurglecannon) && !istype(M,/obj/machinery/power))
					qdel(M)
					newtonforce -= 10												//get through 10 doors

			for(var/mob/living/carbon/human/M in range(range, A.loc))
				M.Weaken(4)
				newtonforce -= 1												//OUCH!
				M.visible_message("<span class='notice'>[M] was struck by a large projectile!</span>", "<span class='notice'>You were hit by a large object.</span>")
				M.apply_damage(10, BRUTE, "head")
			A.Move(get_step(A,movementdirection), movementdirection)	//chugga chugga
			maxrange ++
			sleep(1)
		A.activate()

	attackby(obj/item/O, mob/user)
		if(istype(O, /obj/item/cannonball/nurgleround))
			if(!loaded)
				loaded = 1
				qdel(O)
				user.visible_message("<span class='notice'>[user] loads a round into the cannon.</span>", "<span class='notice'>You load a round into the cannon.</span>")
			else
				user.visible_message("<span class='notice'>[user] tries to load a round into the cannon but finds the cannon quite full.</span>", "<span class='notice'>There is already a round in there.</span>")


/*
Cannon Balls
*/

/obj/item/cannonball
	name = "Template Cannonball"
	desc = "It's a cannonball template!"
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "head"
	force = 1
	throwforce = 1
	w_class = 1.0
	throw_speed = 1

/obj/item/cannonball/proc/activate()
	//Kaboom!

/*
Nurgle Ammo
*/

/obj/item/weapon/reagent_containers/glass/beaker/cheat
	name = "Gas"
	desc = "ITS GAS OKAY?! ITS NOTHING BUT GAS! SERIOUSLY!"
	//that aught to convince them. the fewls!!!
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "blank"
	volume = 200

/obj/item/cannonball/nurgleround
	name = "Rotting head"
	desc = "It's a severed head."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "head"

	New()
		..()
		pixel_x = rand(0, 3)
		pixel_y = rand(0, 3)

	activate()

		var/obj/item/weapon/reagent_containers/glass/beaker/cheat/Bhax = new(src.loc)				//Stealing from Drake yay!

		Bhax.reagents.add_reagent("plague", 50)
		Bhax.reagents.add_reagent("potassium", 50)
		Bhax.reagents.add_reagent("phosphorus", 50)
		Bhax.reagents.add_reagent("sugar", 50)
		sleep(60)
		qdel(Bhax)

/*
Nurgle Ammo Dispensor
*/

/obj/machinery/nammodispensor
	name = "ammunition bag"
	desc = "This is a bag of body parts that may prove useful. It has been attached to the wall."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "heads"
	density = 0
	anchored = 1
	use_power = 0
	var/hashead = 10

/obj/machinery/nammodispensor/attack_hand(mob/user)
	if(!hashead)
		user.visible_message("<span class='notice'>[user] checks the bag for ammunition but finds none.</span>", "<span class='notice'>Looks like there is none left.</span>")
		return
	else
		user.visible_message("<span class='notice'>[user] grabs a head from the [src].</span>", "<span class='notice'>You fish out some ammo.</span>")
		new /obj/item/cannonball/nurgleround (user.loc)
		hashead--
		spawn (600)
			hashead++
			return
