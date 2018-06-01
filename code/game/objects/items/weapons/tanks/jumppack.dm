
/*
RG tactical jetpack as an oxygen tank variant.
*/

/obj/item/weapon/tank/oxygen/jump/rg
	desc = "An Raven Guard JumpPack"
	icon_state = "RGjumppackoff"
	item_state = "RGjumppackoff"
	volume = 1000
	flags = STOPSPRESSUREDMAGE|NODROP
	var/usetime

/obj/item/weapon/tank/oxygen/jump/rg/verb/flight()
	set name = "Vertical Leap"
	set category = "Raven Guard"
	set desc = "Activate the jump pack to fly to high altitude. You may only take off or land outdoors."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.flying && !user.dropping)
		user << "\red You pulse the jump pack to land again."
		user.drop()
		return
	if(world.time < usetime + 120)
		user << "The jump pack is still charging!"
		return
	if(!istype(user.loc, /turf/snow) && !istype(user.loc, /turf/unsimulated/floor/snow))
		user.visible_message("\red [user] shoots into the air and hits their head on the ceiling!")
		user.Weaken(4)
		user.take_organ_damage(15, 0)
		return
	user.fly()
	sleep(50)
	if(user.flying)
		user << "\red You fall back down towards the ground..."
		user.drop()

/obj/item/weapon/tank/oxygen/jump/rg/verb/activatejetpack()
	set name = "Jetpack (short burst)"
	set category = "Raven Guard"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(ismob(usr))
		var/mob/living/user = usr
		if(user.flying) return
	if(world.time < usetime + 60)
		usr << "The Jetpack is still charging!"
		return
	else
		//Else we ride the train! This is how the train goes!
		spawn(0)
			var/mob/B = usr
			var/movementdirection = B.dir
			var/range = 1
			var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
			smoke.set_up(5, 0, B.loc)
			smoke.attach(B)
			smoke.start()
			item_state = "RGjumppackon"
			update_icon()
			playsound(loc, 'sound/effects/jump_pack1.ogg', 75, 0)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)

			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			playsound(loc, 'sound/effects/jump_pack2.ogg', 75, 0)
			sleep(2)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(2)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			playsound(loc, 'sound/effects/jump_pack3.ogg', 75, 0)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
	usetime = world.time	//and.... WE'RE DONE


/*
Grav chute
Basically a singificantly weaker jump pack
*/

/obj/item/weapon/tank/oxygen/jump/grav
	name = "Grav Chute"
	desc = "An elysian grav chute and oxygen tank rolled into one unit to fit on a guard's back."
	icon_state = "gravoff"
	item_state = "gravoff"
	volume = 1000
	var/usetime

/obj/item/weapon/tank/oxygen/jump/grav/verb/flight()
	set name = "Takeoff/Landing"
	set category = "Grav Chute"
	set desc = "Activate the grav chute to fly to high altitude. You may only take off or land outdoors."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.flying)
		if(!istype(user.flying.loc, /turf/snow) && !istype(user.flying.loc, /turf/unsimulated/floor/snow))
			user << "\red You cannot land here!"
			return
		item_state = "gravoff"
		item_state = "gravoff"
		user.drop()
		update_icon()
		return
	if(world.time < usetime + 120)
		user << "The grav chute is still charging!"
		return
	if(!istype(user.loc, /turf/snow) && !istype(user.loc, /turf/unsimulated/floor/snow))
		user.visible_message("\red [user] shoots into the air and hits their head on the ceiling!")
		user.Weaken(4)
		user.take_organ_damage(5, 0)
		return
	user.fly()
	item_state = "gravon"
	icon_state = "gravon"
	update_icon()

/obj/item/weapon/tank/oxygen/jump/grav/verb/hover()
	set name = "Hover"
	set category = "Grav Chute"
	set desc = "Activate the grav chute to start hovering."
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(world.time < usetime + 120)
		usr << "The grav chute is still charging!"
		return
	var/mob/living/M = usr
	if(istype(M) && M.reagents)
		M.pixel_y = 20
		M.reagents.add_reagent("flying", 20) //Sort of a messy way to do it but infinitely easier than making a secnondary hover code.
		M << "\red You begin to hover."

/obj/item/weapon/tank/oxygen/jump/grav/verb/activatejetpack()
	set name = "Pulse Chute"
	set category = "Grav Chute"
	set desc = "Discharge the grav chut in an ultrashort pulse to smash through things."
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(ismob(usr))
		var/mob/living/user = usr
		if(user.flying) return
	if(world.time < usetime + 120)
		usr << "The grav chute is still charging!"
		return
	else
		//Else we ride the train! This is how the train goes!
		spawn(0)
			var/mob/B = usr
			var/movementdirection = B.dir
			var/range = 1
			var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
			smoke.set_up(5, 0, B.loc)
			smoke.attach(B)
			smoke.start()
			item_state = "gravon"
			icon_state = "gravon"
			update_icon()
			playsound(loc, 'sound/effects/jump_pack1.ogg', 75, 0)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)

			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			item_state = "gravoff"
			icon_state = "gravoff"
	usetime = world.time	//and.... WE'RE DONE



/*
Sister of Battle Jump pack
*/

/obj/item/weapon/tank/oxygen/jump/sob
	desc = "A Sister of Battle JumpPack"
	icon_state = "sisterpack"
	item_state = "sisterpack"
	volume = 1000
	flags = STOPSPRESSUREDMAGE|NODROP
	var/usetime

/obj/item/weapon/tank/oxygen/jump/sob/verb/flight()
	set name = "Vertical Leap"
	set category = "Jump Pack"
	set desc = "Activate the jump pack to fly to high altitude. You may only take off or land outdoors."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.flying && !user.dropping)
		user << "\red You pulse the jump pack to land again."
		user.drop()
		return
	if(world.time < usetime + 120)
		user << "The jump pack is still charging!"
		return
	if(!istype(user.loc, /turf/snow) && !istype(user.loc, /turf/unsimulated/floor/snow))
		user.visible_message("\red [user] shoots into the air and hits their head on the ceiling!")
		user.Weaken(4)
		user.take_organ_damage(15, 0)
		return
	user.fly()
	sleep(50)
	if(user.flying)
		user << "\red You fall back down towards the ground..."
		user.drop()

/obj/item/weapon/tank/oxygen/jump/sob/verb/activatejetpack()
	set name = "Jetpack (short burst)"
	set category = "Jump Pack"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(ismob(usr))
		var/mob/living/user = usr
		if(user.flying) return
	if(world.time < usetime + 60)
		usr << "The Jetpack is still charging!"
		return
	else
		//Else we ride the train! This is how the train goes!
		spawn(0)
			var/mob/B = usr
			var/movementdirection = B.dir
			var/range = 1
			var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
			smoke.set_up(5, 0, B.loc)
			smoke.attach(B)
			smoke.start()
			item_state = "sisterpack"
			update_icon()
			playsound(loc, 'sound/effects/jump_pack1.ogg', 75, 0)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(4)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(1)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			playsound(loc, 'sound/effects/jump_pack2.ogg', 75, 0)
			sleep(2)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(2)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
				if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
					var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
					playsound(loc, randomizer, 75, 0)
					qdel(M)
				if (istype(M, /turf/simulated/wall/r_wall))
					M.ex_act(1)
			for(var/obj/structure/grille/M in range(range, src.loc))
				qdel(M)
			for(var/obj/structure/window/M in range(range, src.loc))
				qdel(M)
			for(var/turf/simulated/floor/M in range(range, src.loc))
				M.burn_tile()
			for(var/obj/machinery/door/M in range(range, src.loc))
				qdel(M)
			for(var/mob/living/carbon/human/M in range(range, src.loc))
				if(!istype(M, /mob/living/carbon/human/sob))
					M.Weaken(3)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
			sleep(3)
			playsound(loc, 'sound/effects/jump_pack3.ogg', 75, 0)
			B.Move(get_step(usr,movementdirection), movementdirection)	//chugga chugga
	usetime = world.time	//and.... WE'RE DONE