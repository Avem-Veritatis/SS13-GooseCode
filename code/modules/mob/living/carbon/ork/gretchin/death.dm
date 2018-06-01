/mob/living/carbon/human/ork/gretchin/death(gibbed)
	playsound(loc, 'sound/voice/gretdie1.ogg', 75, 0)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD

	if(!gibbed)
		update_canmove()
		if(client)	animate(src.blind, alpha = 0, time = 20)

	tod = worldtime2text() //weasellos time of death patch
	if(mind)	mind.store_memory("Time of death: [tod]", 0)
	living_mob_list -= src
	for(var/mob/O in viewers(src, null))
		O.show_message("<B>[src]</B> screams obscene things and then falls over dead.", 1)

	return ..(gibbed)
