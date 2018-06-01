/mob/living/carbon/human/ork/gretchin/verb/hide()
	set name = "Hide"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Ork"

	if(stat != CONSCIOUS)
		return

	if (layer != TURF_LAYER+0.2)
		layer = TURF_LAYER+0.2
		src << text("\green You are now hiding.")
		playsound(loc, 'sound/voice/grethide1.ogg', 75, 0)
		for(var/mob/O in oviewers(src, null))
			if ((O.client && !( O.blinded )))
				O << text("<B>[] scurries to the ground!</B>", src)
	else
		layer = MOB_LAYER
		src << text("\green You have stopped hiding.")
		for(var/mob/O in oviewers(src, null))
			if ((O.client && !( O.blinded )))
				O << text("[] slowly peaks up from the ground...", src)

/mob/living/carbon/human/ork/gretchin/verb/evolve()
	set name = "Evolve"
	set desc = "Evolve into a fully grown Alien."
	set category = "Ork"

	if(stat != CONSCIOUS)
		return

	if(handcuffed || legcuffed)
		src << "\red You cannot evolve when you are cuffed."

	if(amount_grown >= max_grown)
		//green is impossible to read, so i made these blue and changed the formatting slightly
		src << "\blue <b>You are growing into mean looking Ork. It is time to make a decision.</b>"
		src << "\blue There are three to choose from:"
		src << "<B>Commando</B> \blue are all sneaky like."
		src << "<B>Nobs</B> \blue are the biggest and the strongest!"
		src << "<B>Oddboy</B> \blue these gots can do things dat help boyz but they are not as good at fightin untill they can become a boss."
		var/alien_caste = alert(src, "Pick one.",,"Commando","Nob","Oddboy")

		var/mob/living/carbon/human/ork/new_xeno
		switch(alien_caste)
			if("Commando")
				new_xeno = new /mob/living/carbon/human/ork/commando(loc)
			if("Nob")
				new_xeno = new /mob/living/carbon/human/ork/nob(loc)
			if("Oddboy")
				new_xeno = new /mob/living/carbon/human/ork/oddboy(loc)
		if(mind)	mind.transfer_to(new_xeno)
		for(var/obj/item/W in src) //Lets not delete everything... This is a lot easier than re-equipping it on the new mob though.
			src.unEquip(W)
		qdel(src)
		return
	else
		src << "\red You are not fully grown."
		return
