/*NOTES:
These are general powers. Specific powers are stored under the appropriate alien creature type.
*/

/*Alien spit now works like a taser shot. It won't home in on the target but will act the same once it does hit.
Doesn't work on other aliens/AI.*/


/mob/living/carbon/alien/proc/powerc(X, Y)//Y is optional, checks for weed planting. X can be null.
	if(cooldown)
		src << "\green Not so fast!"
		return 0
	cooldown = 1
	spawn(3) cooldown = 0
	if(stat)
		src << "\green You must be conscious to do this."
		return 0
	else if(X && getPlasma() < X)
		src << "\red Not enough biomass stored."
		return 0
	else if(Y && (!isturf(src.loc) || istype(src.loc, /turf/space) || istype(src.loc, /turf/unsimulated/floor/snow)))
		if(!(locate(/obj/effect/fake_floor) in usr.loc)) //If they are on a fake floor, they can plant.
			src << "\green Bad place for a garden!"
			return 0
	else if(Y && (istype(src.loc, /turf/unsimulated/floor/tyranid) || istype(src.loc, /turf/unsimulated/floor/plating)))
		src << "\green Build a hive on the surface of the planet!"
		return 0
	else	return 1

/mob/living/carbon/alien/humanoid/verb/plant()
	set name = "Plant Weeds (50)"
	set desc = "Plants some alien weeds"
	set category = "Alien"

	if(powerc(50,1))
		adjustToxLoss(-50)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>[src] has planted some alien weeds!</B>"), 1)
		new /obj/structure/alien/weeds/node(loc)
	return

/*
/mob/living/carbon/alien/humanoid/verb/ActivateHuggers()
	set name = "Activate facehuggers (5)"
	set desc = "Makes all nearby facehuggers activate"
	set category = "Alien"

	if(powerc(5))
		adjustToxLoss(-5)
		for(var/obj/item/clothing/mask/facehugger/F in range(8,src))
			F.GoActive()
		emote("roar")
	return
*/
/mob/living/carbon/alien/humanoid/verb/whisp(mob/M as mob in oview())
	set name = "Whisper (10)"
	set desc = "Whisper to someone"
	set category = "Alien"

	if(powerc(10))
		adjustToxLoss(-10)
		var/msg = sanitize(input("Message:", "Alien Whisper") as text|null)
		if(msg)
			log_say("AlienWhisper: [key_name(src)]->[M.key] : [msg]")
			M << "\green You hear a strange, alien voice in your head... \italic [msg]"
			src << {"\green You said: "[msg]" to [M]"}
	return

/mob/living/carbon/alien/humanoid/verb/transfer_plasma(mob/living/carbon/alien/M as mob in oview())
	set name = "Transfer Plasma"
	set desc = "Transfer Plasma to another alien"
	set category = "Alien"

	if(isalien(M))
		var/amount = input("Amount:", "Transfer Plasma to [M]") as num
		if (amount)
			amount = abs(round(amount))
			if(powerc(amount))
				if (get_dist(src,M) <= 1)
					M.adjustToxLoss(amount)
					adjustToxLoss(-amount)
					M << "\green [src] has transfered [amount] plasma to you."
					src << {"\green You have trasferred [amount] plasma to [M]"}
				else
					src << "\green You need to be closer."
	return


/mob/living/carbon/alien/humanoid/proc/corrosive_acid(O as obj|turf in oview(1)) //If they right click to corrode, an error will flash if its an invalid target./N
	set name = "Corrossive Acid (100)"
	set desc = "Drench an object in acid, destroying it over time."
	set category = "Alien"

	if(powerc(100))
		if(O in oview(1))
			// OBJ CHECK
			if(isobj(O))
				var/obj/I = O
				if(I.unacidable)	//So the aliens don't destroy energy fields/singularies/other aliens/etc with their acid.
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

			adjustToxLoss(-100)
			new /obj/effect/acid(get_turf(O), O)
			visible_message("\green <B>[src] vomits globs of vile stuff all over [O]. It begins to sizzle and melt under the bubbling mess of acid!</B>")
		else
			src << "\green Target is too far away."
	return


/mob/living/carbon/alien/humanoid/proc/neurotoxin() // ok
	set name = "Spit Neurotoxin (50)"
	set desc = "Spits neurotoxin at someone, paralyzing them for a short time."
	set category = "Alien"

	if(powerc(50))
		adjustToxLoss(-50)
		src.visible_message("\red [src] spits neurotoxin!", "\green You spit neurotoxin.")

		var/turf/T = loc
		var/turf/U = get_step(src, dir) // Get the tile infront of the move, based on their direction
		if(!isturf(U) || !isturf(T))
			return

		var/obj/item/projectile/bullet/neurotoxin/A = new /obj/item/projectile/bullet/neurotoxin(usr.loc)
		A.current = U
		A.yo = U.y - T.y
		A.xo = U.x - T.x
		A.process()
	return

/mob/living/carbon/alien/humanoid/proc/resin()
	set name = "Secrete Resin (75)"
	set desc = "Secrete tough malleable resin."
	set category = "Alien"

	if(powerc(75))
		var/choice = input("Choose what you wish to shape.","Resin building") as null|anything in list("resin door","resin wall","resin membrane","resin nest") //would do it through typesof but then the player choice would have the type path and we don't want the internal workings to be exposed ICly - Urist
		if(!choice || !powerc(75))	return
		adjustToxLoss(-75)
		src << "\green You shape a [choice]."
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[src] vomits up a thick purple substance and begins to shape it!</B>"), 1)
		switch(choice)
			if("resin door")
				new /obj/structure/mineral_door/resin(loc)
			if("resin wall")
				new /obj/structure/alien/resin/wall(loc)
			if("resin membrane")
				new /obj/structure/alien/resin/membrane(loc)
			if("resin nest")
				new /obj/structure/stool/bed/nest(loc)
	return

/mob/living/carbon/alien/humanoid/verb/regurgitate()
	set name = "Regurgitate"
	set desc = "Empties the contents of your stomach"
	set category = "Alien"

	if(powerc() && stomach_contents.len)
		for(var/atom/movable/A in stomach_contents)
			if(A in stomach_contents)
				stomach_contents.Remove(A)
				A.loc = loc
				//Paralyse(10)
		src.visible_message("\green <B>[src] hurls out the contents of their stomach!</B>")
	return