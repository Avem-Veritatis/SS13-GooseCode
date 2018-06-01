/*
TODO: Track human deaths in necron rounds to award honors to people who died blowing up monoliths and stuff once the round ends.
*/

/mob/living/carbon/human/gib_animation(var/animate)
	..(animate, "gibbed-h")

/mob/living/carbon/human/dust_animation(var/animate)
	..(animate, "dust-h")

/mob/living/carbon/human/dust(var/animation = 1)
	..()

/mob/living/carbon/human/spawn_gibs()
	hgibs(loc, viruses, dna)

/mob/living/carbon/human/spawn_dust()
	new /obj/effect/decal/remains/human(loc)

/mob/living/carbon/human/death(gibbed)
	if(usr && usr != src)
		award(usr, "\red First Blood")
		if(ticker && istype(ticker.mode, /datum/game_mode/wizard))
			if(src.mind && src.mind.special_role == "Wizard")
				if(usr.mind)
					award(usr, "<span class='gold'>Witch Hunter</span>")
					var/datum/game_mode/R = ticker.mode
					R.honors.Add("<b>[usr.name]</b> ([usr.mind.key]) defeated the warlock")
		if(ticker && istype(ticker.mode, /datum/game_mode/nuclear))
			if(src.mind && src.mind.special_role == "Syndicate")
				if(usr.mind)
					award(usr, "<span class='khorne'>Pact Breaker</span>")
					var/datum/game_mode/R = ticker.mode
					R.honors.Add("<b>[usr.name]</b> ([usr.mind.key]) defeated the blood pact member [src.real_name]")
		if(ticker && istype(ticker.mode, /datum/game_mode/necron))
			if(src.mind && usr.mind && usr.mind.special_role != "Wizard")
				var/datum/game_mode/R = ticker.mode
				R.honors.Add("[usr.name] ([usr.mind.key]) under investigation")
	if(gibbed)
		if(ticker && istype(ticker.mode, /datum/game_mode/necron))
			if(src.mind && src.mind.special_role != "Wizard")
				var/datum/game_mode/R = ticker.mode
				R.honors.Add("[src.name] ([src.mind.key]) body missing")
	if(mind) //Loss of spells after death. Eventually I will redo magic and spells won't be stored in the mind var but this will do for now. -Drake
		for(var/obj/O in mind.spell_list)
			qdel(O)
		mind.spell_list = list()
	if(stat == DEAD)	return
	if(healths)		healths.icon_state = "health5"
	stat = DEAD
	dizziness = 0
	jitteriness = 0
	for(var/obj/item/organ/heart/heart in src.internal_organs)
		heart.beating = 0
		heart.update_icon()

	if(istype(loc, /obj/mecha))
		var/obj/mecha/M = loc
		if(M.occupant == src)
			M.go_out()

	if(!gibbed)
		emote("deathgasp") //let the world KNOW WE ARE DEAD

		update_canmove()
		if(client) animate(src.blind, alpha = 0, time = 20)

	tod = worldtime2text()		//weasellos time of death patch
	if(mind)	mind.store_memory("Time of death: [tod]", 0)
	if(ticker && ticker.mode)
//		world.log << "k"
		sql_report_death(src)
		ticker.mode.check_win()		//Calls the rounds wincheck, mainly for wizard, malf, and changeling now
	if(!gibbed)
		var/obj/item/device/soulstone/stone = locate(/obj/item/device/soulstone) in src
		if(stone)
			stone.transfer_soul("FORCE", src, src)
	return ..(gibbed)

/mob/living/carbon/human/proc/makeSkeleton()
	if(!check_dna_integrity(src) || (dna.mutantrace == "skeleton"))	return
	dna.mutantrace = "skeleton"
	status_flags |= DISFIGURED
	update_hair()
	update_body()
	return 1

/mob/living/carbon/proc/ChangeToHusk()
	if(HUSK in mutations)	return
	mutations.Add(HUSK)
	status_flags |= DISFIGURED	//makes them unknown without fucking up other stuff like admintools
	return 1

/mob/living/carbon/human/ChangeToHusk()
	. = ..()
	if(.)
		update_hair()
		update_body()

/mob/living/carbon/proc/Drain()
	ChangeToHusk()
	mutations |= NOCLONE
	return 1