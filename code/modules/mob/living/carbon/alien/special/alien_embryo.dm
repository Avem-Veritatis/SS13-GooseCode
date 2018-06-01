// This is to replace the previous datum/disease/alien_embryo for slightly improved handling and maintainability
// It functions almost identically (see code/datums/diseases/alien_embryo.dm)
var/const/ALIEN_AFK_BRACKET = 450 // 45 seconds

/obj/item/alien_embryo
	name = "alien embryo"
	desc = "All slimy and yuck."
	icon = 'icons/mob/alien.dmi'
	icon_state = "larva0_dead"
	var/mob/living/affected_mob
	var/stage = 0

/obj/item/alien_embryo/New()
	if(istype(loc, /mob/living))
		affected_mob = loc
		affected_mob.status_flags |= XENO_HOST
		processing_objects.Add(src)
		spawn(0)
			AddInfectionImages(affected_mob)
	else
		qdel(src)

/obj/item/alien_embryo/Destroy()
	if(affected_mob)
		affected_mob.status_flags &= ~(XENO_HOST)
		spawn(0)
			RemoveInfectionImages(affected_mob)
	..()

/obj/item/alien_embryo/process()
	if(!affected_mob)	return
	if(loc != affected_mob)
		affected_mob.status_flags &= ~(XENO_HOST)
		processing_objects.Remove(src)
		spawn(0)
			RemoveInfectionImages(affected_mob)
			affected_mob = null
		return

	if(stage < 5 && prob(3))
		stage++
		spawn(0)
			RefreshInfectionImage(affected_mob)

	switch(stage)
		if(2, 3)
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "\red Your throat feels sore."
			if(prob(1))
				affected_mob << "\red Mucous runs down the back of your throat."
		if(4)
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(2))
				affected_mob << "\red Your muscles ache."
				if(prob(20))
					affected_mob.take_organ_damage(1)
			if(prob(2))
				affected_mob << "\red Your stomach hurts."
				if(prob(20))
					affected_mob.adjustToxLoss(1)
					affected_mob.updatehealth()
		if(5)
			affected_mob << "\red You feel something tearing its way out of your stomach..."
			affected_mob.adjustToxLoss(10)
			affected_mob.updatehealth()
			if(prob(50))
				AttemptGrow()

/obj/item/alien_embryo/proc/AttemptGrow(var/gib_on_success = 1)
	var/list/candidates = get_candidates(BE_ALIEN, ALIEN_AFK_BRACKET)
	var/client/C = null

	// To stop clientless larva, we will check that our host has a client
	// if we find no ghosts to become the alien. If the host has a client
	// he will become the alien but if he doesn't then we will set the stage
	// to 2, so we don't do a process heavy check everytime.

	if(candidates.len)
		C = pick(candidates)
	else if(affected_mob.client)
		C = affected_mob.client
	else
		stage = 4 // Let's try again later.
		return

	if(affected_mob.lying)
		affected_mob.overlays += image('icons/mob/alien.dmi', loc = affected_mob, icon_state = "burst_lie")
	else
		affected_mob.overlays += image('icons/mob/alien.dmi', loc = affected_mob, icon_state = "burst_stand")
	spawn(6)
		var/mob/living/carbon/alien/larva/new_xeno = new(affected_mob.loc)
		new_xeno.key = C.key
		new_xeno << sound('sound/voice/hiss5.ogg',0,0,0,100)	//To get the player's attention
		if(gib_on_success)
			affected_mob.gib()
		if(istype(new_xeno.loc,/mob/living/carbon))
			var/mob/living/carbon/digester = new_xeno.loc
			digester.stomach_contents += new_xeno
		qdel(src)

/*----------------------------------------
Proc: RefreshInfectionImage()
Des: Removes all infection images from aliens and places an infection image on all infected mobs for aliens.
----------------------------------------*/
/obj/item/alien_embryo/proc/RefreshInfectionImage()
	for(var/mob/living/carbon/alien/alien in player_list)
		if(alien.client)
			for(var/image/I in alien.client.images)
				if(dd_hasprefix_case(I.icon_state, "infected"))
					qdel(I)
			for(var/mob/living/L in mob_list)
				if(iscorgi(L) || iscarbon(L))
					if(L.status_flags & XENO_HOST)
						var/I = image('icons/mob/alien.dmi', loc = L, icon_state = "infected[stage]")
						alien.client.images += I

/*----------------------------------------
Proc: AddInfectionImages(C)
Des: Checks if the passed mob (C) is infected with the alien egg, then gives each alien client an infected image at C.
----------------------------------------*/
/obj/item/alien_embryo/proc/AddInfectionImages(var/mob/living/C)
	if(C)
		for(var/mob/living/carbon/alien/alien in player_list)
			if(alien.client)
				if(C.status_flags & XENO_HOST)
					var/I = image('icons/mob/alien.dmi', loc = C, icon_state = "infected[stage]")
					alien.client.images += I

/*----------------------------------------
Proc: RemoveInfectionImage(C)
Des: Removes the alien infection image from all aliens in the world located in passed mob (C).
----------------------------------------*/

/obj/item/alien_embryo/proc/RemoveInfectionImages(var/mob/living/C)
	if(C)
		for(var/mob/living/carbon/alien/alien in player_list)
			if(alien.client)
				for(var/image/I in alien.client.images)
					if(I.loc == C)
						if(dd_hasprefix_case(I.icon_state, "infected"))
							qdel(I)

/obj/item/alien_embryo/tyranid/process()
	if(!affected_mob)	return
	if(loc != affected_mob)
		affected_mob.status_flags &= ~(XENO_HOST)
		processing_objects.Remove(src)
		spawn(0)
			RemoveInfectionImages(affected_mob)
			affected_mob = null
		return

	if(stage < 5 && prob(3))
		stage++
		spawn(0)
			RefreshInfectionImage(affected_mob)

	if(affected_mob.stat != DEAD)
		switch(stage)
			if(2, 3)
				if(prob(3))
					affected_mob << "\red You feel like shit."
				if(prob(3))
					affected_mob << "\red A sudden pain wracks your gut."
				if(prob(3))
					affected_mob << "\red You feel like you are about to throw up."
			if(4)
				if(prob(3))
					affected_mob << "\red You feel like shit."
				if(prob(3))
					affected_mob << "\red A sudden pain wracks your gut."
					if(prob(20))
						affected_mob.take_organ_damage(1)
				if(prob(3))
					affected_mob << "\red Your feel like you are about to throw up."
					if(prob(20))
						affected_mob.adjustToxLoss(1)
						affected_mob.updatehealth()
				if(prob(3))
					affected_mob.visible_message("<B>[affected_mob]</B> vomits something out onto the floor!")
					affected_mob.nutrition -= 20
					affected_mob.adjustToxLoss(-3)
					var/turf/pos = get_turf(affected_mob)
					pos.add_vomit_floor(affected_mob)
					new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
					affected_mob.take_organ_damage(5,0)
					playsound(pos, 'sound/effects/splat.ogg', 50, 1)
			if(5)
				if(prob(3))
					affected_mob << "\red You feel like shit."
				if(prob(3))
					affected_mob << "\red A sudden pain wracks your gut."
					if(prob(20))
						affected_mob.take_organ_damage(1)
				if(prob(3))
					affected_mob << "\red Your feel like you are about to throw up."
					if(prob(20))
						affected_mob.adjustToxLoss(1)
						affected_mob.updatehealth()
				if(prob(3))
					affected_mob.visible_message("<B>[affected_mob]</B> vomits something out onto the floor!")
					affected_mob.nutrition -= 20
					affected_mob.adjustToxLoss(-3)
					var/turf/pos = get_turf(affected_mob)
					pos.add_vomit_floor(affected_mob)
					affected_mob.take_organ_damage(5,0)
					if(prob(2))
						var/mob/living/carbon/alien/larva/tyranid/new_xeno = new(affected_mob.loc)
						new_xeno.amount_grown = 185
						new_xeno.name = "parasite"
						new_xeno.icon_state = "larva2"
					else if(prob(2))
						new /mob/living/simple_animal/hostile/alien/parasite(affected_mob.loc)
					else
						new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
					playsound(pos, 'sound/effects/splat.ogg', 50, 1)
				if(prob(1) && prob(1) && prob(10)) //If left indefinitely, the subject will turn into a larva.
					affected_mob << "\red Your gut bursts open!"
					AttemptGrow()
	else
		if(stage >= 3)
			AttemptGrow() //If a dead body is infested, it will eventually burst open to create aliens. If a living body is infested and the subject dies, the body will burst open, leaving aliens and a larva with the subject's mind.

/obj/item/alien_embryo/tyranid/AttemptGrow(var/gib_on_success = 1)
	var/list/candidates = get_candidates(BE_ALIEN, ALIEN_AFK_BRACKET)
	var/client/C = null

	if(candidates.len)
		C = pick(candidates)
	else if(affected_mob.client)
		C = affected_mob.client
	else
		stage = 4 // Let's try again later.
		return

	if(affected_mob.lying)
		affected_mob.overlays += image('icons/mob/alien.dmi', loc = affected_mob, icon_state = "burst_lie")
	else
		affected_mob.overlays += image('icons/mob/alien.dmi', loc = affected_mob, icon_state = "burst_stand")
	spawn(6)
		var/mob/living/carbon/alien/larva/tyranid/new_xeno = new(affected_mob.loc)
		new_xeno.amount_grown = 185
		new_xeno.name = "parasite"
		new_xeno.icon_state = "larva2"
		new_xeno.key = C.key
		new_xeno << sound('sound/voice/hiss5.ogg',0,0,0,100)	//To get the player's attention
		new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
		new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
		new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
		new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
		new /mob/living/simple_animal/hostile/alien/ripper(affected_mob.loc)
		affected_mob.gib()
		if(istype(new_xeno.loc,/mob/living/carbon))
			var/mob/living/carbon/digester = new_xeno.loc
			digester.stomach_contents += new_xeno
		qdel(src)