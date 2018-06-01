/mob/living/carbon/human/ork/gib_animation(var/animate)
	..(animate, "gibbed-h")

/mob/living/carbon/human/ork/dust_animation(var/animate)
	..(animate, "dust-h")

/mob/living/carbon/human/ork/dust(var/animation = 1)
	..()

/mob/living/carbon/human/ork/spawn_gibs()
	hgibs(loc, viruses, dna)

/mob/living/carbon/human/ork/spawn_dust()
	new /obj/effect/decal/remains/human(loc)

/mob/living/carbon/human/ork/death(gibbed)
	if(stat == DEAD)	return
	if(healths)		healths.icon_state = "health5"
	stat = DEAD
	dizziness = 0
	jitteriness = 0

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
	return ..(gibbed)
