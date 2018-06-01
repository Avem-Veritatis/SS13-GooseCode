/mob/living/carbon/human/ork/nob/death(gibbed)
	playsound(loc, 'sound/voice/orkdie.ogg', 75, 0)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD

	if(!gibbed)
		update_canmove()
		if(client)	blind.alpha = 0

	tod = worldtime2text() //weasellos time of death patch
	if(mind)	mind.store_memory("Time of death: [tod]", 0)
	living_mob_list -= src
	for(var/mob/O in viewers(src, null))
		O.show_message("<B>[src]</B> finaly falls.", 1)

	return ..(gibbed)

/mob/living/carbon/human/ork/commando/death(gibbed)
	playsound(loc, 'sound/voice/orkdie.ogg', 75, 0)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD

	if(!gibbed)
		update_canmove()
		if(client)	blind.alpha = 0

	tod = worldtime2text() //weasellos time of death patch
	if(mind)	mind.store_memory("Time of death: [tod]", 0)
	living_mob_list -= src
	for(var/mob/O in viewers(src, null))
		O.show_message("<B>[src]</B> finaly falls.", 1)

	return ..(gibbed)

/mob/living/carbon/human/ork/oddboy/death(gibbed)
	playsound(loc, 'sound/voice/orkdie.ogg', 75, 0)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD

	if(!gibbed)
		update_canmove()
		if(client)	blind.alpha = 0

	tod = worldtime2text() //weasellos time of death patch
	if(mind)	mind.store_memory("Time of death: [tod]", 0)
	living_mob_list -= src
	for(var/mob/O in viewers(src, null))
		O.show_message("<B>[src]</B> finaly falls.", 1)

	return ..(gibbed)

/mob/living/carbon/human/ork/warboss/death(gibbed)
	playsound(loc, 'sound/voice/orkdie.ogg', 75, 0)
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
		O.show_message("<B>[src]</B> finaly falls.", 1)

	return ..(gibbed)
