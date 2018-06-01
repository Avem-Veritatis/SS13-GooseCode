/mob/living/simple_animal/kbspawn/
	name = "Shade of the warp"
	real_name = "Shade"
	desc = "Reality is very thin here."
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "shade"
	icon_living = "shade"
	icon_dead = "ws_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 100
	health = 100
	speak_emote = list("growls")
	emote_hear = list("wails","screeches")
	response_help  = "taps"
	response_disarm = "flails at"
	response_harm   = "punches"
	melee_damage_lower = 0
	melee_damage_upper = 0
	anchored = 1
	canmove = 0
	status_flags = 0

/mob/living/simple_animal/kbspawn/Life()  //its alive unless it's not
	..()
	if(stat == 2)
		new /obj/item/weapon/ectoplasm (src.loc)
		for(var/mob/M in viewers(src, null))
			if((M.client && !( M.blinded )))
				M.show_message("\red [src] roars as it departs this world. ")
				ghostize()
		qdel(src)
		return

/mob/living/simple_animal/kbspawn/New()   //just got here
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	request_player()

//Procs for grabbing players.
/mob/living/simple_animal/kbspawn/proc/request_player()
	for(var/mob/dead/observer/O in player_list)
		if(jobban_isbanned(O, "Syndicate"))
			continue
		if(O.client)
			if(O.client.prefs.be_special & BE_ALIEN)
				question(O.client)

/mob/living/simple_animal/kbspawn/proc/question(var/client/C)
	spawn(0)
		if(!C)	return
		var/response = alert(C, "A Khorne minion needs a player. Are you interested?", "Khorne Berserker", "Yes", "No", "Never for this round")
		if(!C || ckey)
			return
		if(response == "Yes")
			transfer_personality(C)
		else if (response == "Never for this round")
			C.prefs.be_special ^= BE_ALIEN

/mob/living/simple_animal/kbspawn/proc/transfer_personality(var/client/candidate)

	if(!candidate)
		return

	src.mind = candidate.mob.mind
	src.ckey = candidate.ckey
	if(src.mind)
		src.mind.assigned_role = "syndicate"
		sleep 2
		src << "<font color='red'> You have not yet broken free from the warp. The person that summoned you needs to touch you with his sword. You are a minion of the warp. Khorne is your god. Your purpose is to find the biggest baddest mutha fucker and fight him in single combat, prefferably with your hands but melee weapons are also acceptable. When you are done with that, just kill everyone you can find. Then kill yourself! Then kill death itself! Also see if you can kill your own name. Bonus points if you can ride a Defiler while you are doing all this.</font>"

/mob/living/simple_animal/kbspawn/attackby(obj/item/weapon/P as obj)
	if(istype(P, /obj/item/weapon/melee/kbsword))
		kbize()
	else
		return

/*
Chaosspawn
*/
/mob/living/simple_animal/chaosspawn/
	name = "Spawn"
	real_name = "Spawn"
	desc = "WTF IS THAT!"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ks"
	icon_living = "ks"
	icon_dead = "ks_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 250
	health = 250
	speak_emote = list("growls")
	emote_hear = list("wails","screeches")
	response_help  = "taps"
	response_disarm = "flails at"
	response_harm   = "punches"
	melee_damage_lower = 15
	melee_damage_upper = 35
	attacktext = "slashes"
	a_intent = "harm"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	minbodytemp = 0
	maxbodytemp = 4000
	min_oxy = 0
	max_co2 = 0
	max_tox = 0
	speed = -1
	stop_automated_movement = 1
	status_flags = 0
	factions = list("cult")
	status_flags = CANPUSH
	heat_damage_per_tick = 20
	luminosity = 2

/mob/living/simple_animal/chaosspawn/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/nullrod))
		visible_message("\red <b>[I] strikes a blow against \the [src], banishing it!</b>")
		qdel(src)
		return
	if(istype(I, /obj/item/weapon/twohanded/pchainsword))
		visible_message("\red <b>[I] strikes a blow against \the [src], banishing it!</b>")
		qdel(src)
		return
	..()

/mob/living/simple_animal/chaosspawn/nspawn
	name = "Lesser Nurgle Spawn"
	real_name = "Lesser Nurgle Spawn"
	desc = "WTF IS THAT!"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ks"
	icon_living = "ks"
	icon_dead = "ks_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 250
	health = 250
	speak_emote = list("growls")
	emote_hear = list("wails","screeches")
	response_help  = "taps"
	response_disarm = "flails at"
	response_harm   = "punches"
	melee_damage_lower = 15
	melee_damage_upper = 35
	attacktext = "slashes"
	a_intent = "harm"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	minbodytemp = 0
	maxbodytemp = 4000
	min_oxy = 0
	max_co2 = 0
	max_tox = 0
	speed = -1
	stop_automated_movement = 1
	status_flags = 0
	factions = list("cult")
	status_flags = CANPUSH
	heat_damage_per_tick = 20


/mob/living/simple_animal/chaosspawn/nspawn/Life()  //its alive unless it's not
	..()
	if(stat == 2)
		new /obj/item/weapon/ectoplasm (src.loc)
		for(var/mob/M in viewers(src, null))
			if((M.client && !( M.blinded )))
				M.show_message("\red [src] roars as it departs this world. ")
				ghostize()
		qdel(src)
		return

/mob/living/simple_animal/chaosspawn/nspawn/New()   //just got here
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	request_player()

//Procs for grabbing players.
/mob/living/simple_animal/chaosspawn/nspawn/proc/request_player()
	for(var/mob/dead/observer/O in player_list)
		if(jobban_isbanned(O, "Syndicate"))
			continue
		if(O.client)
			if(O.client.prefs.be_special & BE_ALIEN)
				question(O.client)

/mob/living/simple_animal/chaosspawn/nspawn/proc/question(var/client/C)
	spawn(0)
		if(!C)	return
		var/response = alert(C, "A Nurgle Spawn needs a player. Are you interested?", "Nurgle Spawn request", "Yes", "No", "Never for this round")
		if(!C || ckey)
			return
		if(response == "Yes")
			transfer_personality(C)
		else if (response == "Never for this round")
			C.prefs.be_special ^= BE_ALIEN

/mob/living/simple_animal/chaosspawn/nspawn/proc/transfer_personality(var/client/candidate)

	if(!candidate)
		return

	src.mind = candidate.mob.mind
	src.ckey = candidate.ckey
	if(src.mind)
		src.mind.assigned_role = "Nurgle Spawn"
		sleep 2
		src << "<font color='red'> You are a warpling. Nurgle is your god. Your purpose is to support his cultists in this realm and ensure their victory.</font>"

/mob/living/simple_animal/nspawn/verb/ventcrawl()
	set name = "Crawl through Vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Nurgle Spawn"

//	if(!istype(V,/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent))
//		return
	var/obj/machinery/atmospherics/vent/vent_found
	var/welded = 0
	for(var/obj/machinery/atmospherics/vent/v in range(1,src))
		if(!v.welded)
			vent_found = v
			break
		else
			welded = 1
	if(vent_found)
		src.visible_message("\red [src] scrambles into the [vent_found]!")
		src.loc = vent_found.linked.loc
	else if(welded)
		src << "\red That vent is welded."
	else
		src << "\blue You must be standing on or beside an air vent to enter it."
	return

/*
Warp Spawn
*/

/mob/living/simple_animal/chaosspawn/warpspawn
	name = "Warp Spawn"
	real_name = "Warp Spawn"
	desc = "WTF IS THAT!"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ws"
	icon_living = "ws"
	icon_dead = "ws_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 250
	health = 250
	speak_emote = list("growls")
	emote_hear = list("wails","screeches")
	response_help  = "taps"
	response_disarm = "flails at"
	response_harm   = "punches"
	melee_damage_lower = 15
	melee_damage_upper = 35
	attacktext = "slashes"
	a_intent = "harm"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	minbodytemp = 0
	maxbodytemp = 4000
	min_oxy = 0
	max_co2 = 0
	max_tox = 0
	speed = -1
	stop_automated_movement = 1
	status_flags = 0
	factions = list("cult")
	status_flags = CANPUSH
	heat_damage_per_tick = 20


/mob/living/simple_animal/chaosspawn/warpspawn/Life()  //its alive unless it's not
	..()
	if(stat == 2)
		new /obj/item/weapon/ectoplasm (src.loc)
		for(var/mob/M in viewers(src, null))
			if((M.client && !( M.blinded )))
				M.show_message("\red [src] roars as it departs this world. ")
				ghostize()
		qdel(src)
		return

/mob/living/simple_animal/chaosspawn/warpspawn/New()   //just got here
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	request_player()

//Procs for grabbing players.
/mob/living/simple_animal/chaosspawn/warpspawn/proc/request_player()
	for(var/mob/dead/observer/O in player_list)
		if(jobban_isbanned(O, "Syndicate"))
			continue
		if(O.client)
			if(O.client.prefs.be_special & BE_ALIEN)
				question(O.client)

/mob/living/simple_animal/chaosspawn/warpspawn/proc/question(var/client/C)
	spawn(0)
		if(!C)	return
		var/response = alert(C, "A Tzeentch Spawn needs a player. Are you interested?", "Tzeentch Spawn request", "Yes", "No", "Never for this round")
		if(!C || ckey)
			return
		if(response == "Yes")
			transfer_personality(C)
		else if (response == "Never for this round")
			C.prefs.be_special ^= BE_ALIEN

/mob/living/simple_animal/chaosspawn/warpspawn/proc/transfer_personality(var/client/candidate)

	if(!candidate)
		return

	src.mind = candidate.mob.mind
	src.ckey = candidate.ckey
	if(src.mind)
		src.mind.assigned_role = "Warp Spawn"
		sleep 2
		src << "<font color='red'> You are a warpling. Tzeentch is your god. Your purpose is to support his cultists in this realm and ensure their victory.</font>"

/mob/living/simple_animal/chaosspawn/warpspawn/verb/ventcrawl()
	set name = "Crawl through Vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Warp Spawn"

//	if(!istype(V,/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent))
//		return
	var/obj/machinery/atmospherics/vent/vent_found
	var/welded = 0
	for(var/obj/machinery/atmospherics/vent/v in range(1,src))
		if(!v.welded)
			vent_found = v
			break
		else
			welded = 1
	if(vent_found)
		src.visible_message("\red [src] scrambles into the [vent_found]!")
		src.loc = vent_found.linked.loc
	else if(welded)
		src << "\red That vent is welded."
	else
		src << "\blue You must be standing on or beside an air vent to enter it."
	return