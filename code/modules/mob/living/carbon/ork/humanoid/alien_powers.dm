/*NOTES:
These are general powers. Specific powers are stored under the appropriate ork creature type.
*/

/*ork spit now works like a taser shot. It won't home in on the target but will act the same once it does hit.
Doesn't work on other orks/AI.*/


/mob/living/carbon/human/ork/proc/powerc(X, Y)//Y is optional, checks for weed planting. X can be null.
	if(stat)
		src << "\green You must be conscious to do this."
		return 0
	else if(X && getwaagh() < X)
		src << "\green Not enough plasma stored."
		return 0
	else if(Y && (!isturf(src.loc) || istype(src.loc, /turf/space)))
		src << "\green Bad place for a garden!"
		return 0
	else	return 1

/mob/living/carbon/human/ork/gretchin/verb/plant()
	set name = "Da Waaaagh banna! (100)"
	set desc = "Plants some ork weeds"
	set category = "Ork"

	if(powerc(100))
		adjustToxLoss(-100)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>If it's a Waaagh [src] wants, it's a WAAAAAGH he'll get!</B>"), 1)
		new /obj/structure/human/ork/waagh/node(loc)
		playsound(loc, 'sound/voice/gretbanner.ogg', 75, 0)
	return

/*
/mob/living/carbon/human/ork/verb/ActivateHuggers()
	set name = "Activate facehuggers (5)"
	set desc = "Makes all nearby facehuggers activate"
	set category = "ork"

	if(powerc(5))
		adjustToxLoss(-5)
		for(var/obj/item/clothing/mask/facehugger/F in range(8,src))
			F.GoActive()
		emote("roar")
	return
*/
//warboss verbs
/mob/living/carbon/human/ork/nob/verb/waagh()
	set name = "Waaaaagh!!!(20)"
	set desc = "Heal"
	set category = "Ork"

	if(powerc(20))
		visible_message("<span class='warning'>WAAAAAAAAAAAAAAAAAAAAAAAAGH!</span>")
		playsound(loc, 'sound/effects/waagh1.ogg', 50) //keep it at 15% volume so people don't jump out of their skin too much
		spawn(0)
			for(var/i = 0, i<5,i++)
				adjustBruteLoss(-5)
				adjustOxyLoss(-5)
				adjustFireLoss(-5)
				adjustToxLoss(-20)
				sleep(10)
/*
 * Scavange
 */

/mob/living/carbon/human/ork/nob/verb/oddscav()
	set name = "Scavenge for supplies (150)"
	set desc = "Look around and find some things to use."
	set category = "Ork"

	if(powerc(150))
		adjustToxLoss(-150)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>[src] begins looting the surrounding area.</B>"), 1)
		new /obj/item/weapon/storage/backpack/oddbag/full(loc)
		playsound(loc, 'sound/voice/orknobscav.ogg', 75, 0)
	return

/mob/living/carbon/human/ork/nob/verb/nobscav()
	set name = "Scavenge for supplies (150)"
	set desc = "Look around and find some things to use."
	set category = "Ork"

	if(powerc(150))
		adjustToxLoss(-150)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>[src] begins looting the surrounding area.</B>"), 1)
		new /obj/item/weapon/storage/backpack/nobbag/full(loc)
		playsound(loc, 'sound/voice/orknobscav.ogg', 75, 0)
	return

/mob/living/carbon/human/ork/commando/verb/komscav()
	set name = "Scavenge for supplies (150)"
	set desc = "Look around and find some things to use."
	set category = "Ork"

	if(powerc(150))
		adjustToxLoss(-150)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>[src] begins looting the surrounding area.</B>"), 1)
		new /obj/item/weapon/storage/backpack/kombag/full(loc)
		playsound(loc, 'sound/voice/kommandoscav.ogg', 75, 0)
	return

/mob/living/carbon/human/ork/oddboy/verb/waagh()
	set name = "Waaaaagh!!!(20)"
	set desc = "Heal"
	set category = "Ork"

	if(powerc(20))
		visible_message("<span class='warning'>WAAAAAAAAAAAAAAAAAAAAAAAAGH!</span>")
		playsound(loc, 'sound/effects/waagh1.ogg', 50) //keep it at 15% volume so people don't jump out of their skin too much
		spawn(0)
			for(var/i = 0, i<5,i++)
				adjustBruteLoss(-5)
				adjustOxyLoss(-5)
				adjustFireLoss(-5)
				adjustToxLoss(-20)
				sleep(10)

/mob/living/carbon/human/ork/commando/verb/waagh()
	set name = "Waaaaagh!!!(20)"
	set desc = "Heal"
	set category = "Ork"

	if(powerc(20))
		visible_message("<span class='warning'>WAAAAAAAAAAAAAAAAAAAAAAAAGH!</span>")
		playsound(loc, 'sound/effects/waagh1.ogg', 50) //keep it at 15% volume so people don't jump out of their skin too much
		spawn(0)
			for(var/i = 0, i<5,i++)
				adjustBruteLoss(-5)
				adjustOxyLoss(-5)
				adjustFireLoss(-5)
				adjustToxLoss(-20)
				sleep(10)

/mob/living/carbon/human/ork/warboss/verb/waagh()
	set name = "Waaaaagh!!!(20)"
	set desc = "Heal"
	set category = "Ork"

	if(powerc(20))
		visible_message("<span class='warning'>WAAAAAAAAAAAAAAAAAAAAAAAAGH!</span>")
		playsound(loc, 'sound/effects/waagh1.ogg', 65) //keep it at 15% volume so people don't jump out of their skin too much //Now slightly louder because HE DA BOSS
		spawn(0)
			for(var/i = 0, i<5,i++)
				adjustBruteLoss(-5)
				adjustOxyLoss(-5)
				adjustFireLoss(-5)
				adjustToxLoss(-20)
				sleep(10)


/* NOPE
/mob/living/carbon/human/ork/verb/transfer_plasma(mob/living/carbon/human/ork/M as mob in oview())
	set name = "Transfer Waagh"
	set desc = "Transfer Waagh to another ork"
	set category = "Ork"

	if(isork(M))
		var/amount = input("Amount:", "Transfer Plasma to [M]") as num
		if (amount)
			amount = abs(round(amount))
			if(powerc(amount))
				if (get_dist(src,M) <= 1)
					M.adjustToxLoss(amount)
					adjustToxLoss(-amount)
					M << "\green [src] has transfered [amount] waagh to you."
					src << {"\green You have trasferred [amount] waagh to [M]"}
				else
					src << "\green You need to be closer."
	return
*/

/* NOPE
/mob/living/carbon/human/ork/proc/corrosive_acid(O as obj|turf in oview(1)) //If they right click to corrode, an error will flash if its an invalid target./N
	set name = "Corrossive Acid (200)"
	set desc = "Drench an object in acid, destroying it over time."
	set category = "Ork"

	if(powerc(200))
		if(O in oview(1))
			// OBJ CHECK
			if(isobj(O))
				var/obj/I = O
				if(I.unacidable)	//So the orks don't destroy energy fields/singularies/other orks/etc with their acid.
					src << "\green You cannot dissolve this object."
					return
			// TURF CHECK
			else if(istype(O, /turf/simulated))
				var/turf/T = O
				// R WALL
				if(istype(T, /turf/simulated/wall/r_wall))
					src << "\green You cannot dissolve this object."
					return
				// R FLOOR
				if(istype(T, /turf/simulated/floor/engine))
					src << "\green You cannot dissolve this object."
					return
			else// Not a type we can acid.
				return

			adjustToxLoss(-200)
			new /obj/effect/acid(get_turf(O), O)
			visible_message("\green <B>[src] vomits globs of vile stuff all over [O]. It begins to sizzle and melt under the bubbling mess of acid!</B>")
		else
			src << "\green Target is too far away."
	return
*/
/* NOPE
/mob/living/carbon/human/ork/proc/neurotoxin() // ok
	set name = "Spit Neurotoxin (50)"
	set desc = "Spits neurotoxin at someone, paralyzing them for a short time."
	set category = "Ork"

	if(powerc(50))
		adjustToxLoss(-50)
		src.visible_message("\red [src] spits neurotoxin!", "\green You spit neurotoxin.")

		var/turf/T = loc
		new /obj/structure/closet/ork/piloguns(T.loc)

		var/turf/U = get_step(src, dir) // Get the tile infront of the move, based on their direction
		if(!isturf(U) || !isturf(T))
			return

		var/obj/item/projectile/bullet/neurotoxin/A = new /obj/item/projectile/bullet/neurotoxin(usr.loc)
		A.current = U
		A.yo = U.y - T.y
		A.xo = U.x - T.x
		A.process()
	return
*/
/mob/living/carbon/human/ork/proc/construction()
	set name = "Build Stuff (75)"
	set desc = "Time to build stuff!"
	set category = "Ork"

	if(powerc(75))
		var/choice = input("Choose what you wish to build.","Construct building") as null|anything in list("Door","Wall","Window","Pile-o-guns") //would do it through typesof but then the player choice would have the type path and we don't want the internal workings to be exposed ICly - Urist
		if(!choice || !powerc(75))	return
		adjustToxLoss(-75)
		src << "\green You construct a [choice]."
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[src] starts building something!</B>"), 1)
		switch(choice)
			if("Door")
				new /obj/structure/mineral_door/ork(loc)
			if("Wall")
				new /obj/structure/human/ork/construction/wall(loc)
			if("Window")
				new /obj/structure/human/ork/construction/window(loc)
			if("Pile-o-guns")
				var/announce = pick('sound/voice/gretpilo.ogg','sound/voice/gretpilo2.ogg')
				playsound(loc, announce, 75, 0)
				makegunpile()

	return

/mob/living/carbon/human/ork/proc/makegunpile(mob/user as mob)
	new /obj/structure/closet/ork/piloguns(src.loc)


/* NOPE
/mob/living/carbon/human/ork/verb/regurgitate()
	set name = "Regurgitate"
	set desc = "Empties the contents of your stomach"
	set category = "Ork"

	if(powerc() && stomach_contents.len)
		for(var/atom/movable/A in stomach_contents)
			if(A in stomach_contents)
				stomach_contents.Remove(A)
				A.loc = loc
				//Paralyse(10)
		src.visible_message("\green <B>[src] hurls out the contents of their stomach!</B>")
	return
*/