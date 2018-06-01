//Necron game mode! Based loosely on the nuke ops controller.
//By DrakeMarshall

/datum/game_mode
	var/list/datum/mind/necrons = list()

/datum/game_mode/necron
	name = "necron"
	config_tag = "necron"
	required_players = 20 //10 players is about right I think.  //For debugging I put it at only 4. I wanted to do it with one but it only works with four or more. So I literally need 4 keys. Which sucks.
	required_enemies = 3 //Exactly three antagonists.
	recommended_enemies = 3
	pre_setup_before_jobs = 1
	antag_flag = BE_TRAITOR //If you can make a new flag for this sometime that would be great... For now this will do, since I don't really know where to begin in making one.

	uplink_welcome = "Necron Tomb World Console That Should Never Exist:"
	uplink_uses = 0

	var/finished = 0

/datum/game_mode/necron/announce()
	world << "<B>The current game mode is - Necron!</B>"
	world << "<B>Try to stay alive!</B>"
	world << "<B>Necrons</B>: Establish control of the planet, removing anything that stands in your way.\n<B>Personnel</B>: Barricade yourselves together and try not to die, and <B>escape on the shuttle!</B>"

/datum/game_mode/necron/pre_setup()

	for(var/stage = 1, stage<=3, stage++)
		var/datum/mind/new_necron = pick(antag_candidates)
		necrons += new_necron
		antag_candidates -= new_necron //So it doesn't pick the same guy each time.
		var/typeofnecron
		switch(stage)
			if(1)
				typeofnecron = "Necron Lord"
			if(2)
				typeofnecron = "Necron Cryptek"
			if(3)
				typeofnecron = "Necron Wraith"
		new_necron.special_role = typeofnecron

	for(var/datum/mind/necro_mind in necrons)
		necro_mind.assigned_role = "MODE" //So they aren't chosen for other jobs.
		log_game("[necro_mind.key] (ckey) has been selected as a necron")
	return 1

/datum/game_mode/necron/post_setup()

	var/list/turf/necro_spawn = list()

	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Player-Spawn")
			necro_spawn += get_turf(A)
			qdel(A)
			continue

	var/spawnpos = 1

	for(var/datum/mind/necro_mind in necrons)
		if(spawnpos > necro_spawn.len)
			spawnpos = 1
		necro_mind.current.loc = necro_spawn[spawnpos]

		var/mob/living/T = necro_mind.current
		var/necrontype
		switch(necro_mind.special_role)
			if("Necron Lord")
				necrontype = /mob/living/silicon/robot/necron/lord
			if("Necron Wraith")
				necrontype = /mob/living/silicon/robot/necron/wraith
			if("Necron Cryptek")
				necrontype = /mob/living/silicon/robot/necron/cryptek
		var/mob/living/silicon/robot/necron/new_necron = new necrontype(T.loc)
		if(T.mind)	T.mind.transfer_to(new_necron)
		new_necron << "<span class='noticealien'>Order. Unity. Obedience. We taught the galaxy these things long ago, and we will do so again.</span>"
		new_necron << "\red Systems starting up... Please wait while systems are made operational."
		new_necron.Stun(1)
		qdel(T)

		spawnpos++

	spawn()
		control_phases()

	return ..()

/datum/game_mode/necron/proc/control_phases() //Calls all the various stages of progression at the right time.
	phase1()
	sleep(3000)
	phase2()
	sleep(3000)
	phase3()
	sleep(6000)
	phase4()
	spawn(600)
		emergency_shuttle.incall(1, null)
		priority_announce("The emergency shuttle has been called. It will arrive in [round(emergency_shuttle.timeleft()/60)] minutes.", null, 'sound/AI/shuttlecalled.ogg', "Priority")
	sleep(6000)
	phase5()

/datum/game_mode/necron/proc/phase1()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Phase1")
			var/turf/T = get_turf(A)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/scarab(T)
			new /mob/living/simple_animal/hostile/scarab(T)
		if(A.name == "Necron-Supplies-Tele")
			sleep(160)
			var/turf/T2 = get_turf(A)
			if(prob(5))
				world << sound('sound/voice/interupt.ogg')
			else
				world << sound('sound/misc/necroncall.ogg')
				new /obj/structure/closet/crate/necronsurvival(T2)

/datum/game_mode/necron/proc/phase2()
	var/obj/structure/gausspylon/gauss1
	var/obj/structure/gausspylon/gauss2
	var/obj/structure/gausspylon/gauss3
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Gauss1-Spawn")
			var/turf/gauss1_loc = get_turf(A)
			gauss1 = new /obj/structure/gausspylon(gauss1_loc)
		if(A.name == "Necron-Gauss2-Spawn")
			var/turf/gauss2_loc = get_turf(A)
			gauss2 = new /obj/structure/gausspylon(gauss2_loc)
		if(A.name == "Necron-Gauss3-Spawn")
			var/turf/gauss3_loc = get_turf(A)
			gauss3 = new /obj/structure/gausspylon(gauss3_loc)
	var/list/gauss1_targets = list()
	var/list/gauss2_targets = list()
	var/list/gauss3_targets = list()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Gauss1-Target")
			gauss1_targets.Add(get_turf(A))
		if(A.name == "Necron-Gauss2-Target")
			gauss2_targets.Add(get_turf(A))
		if(A.name == "Necron-Gauss3-Target")
			gauss3_targets.Add(get_turf(A))
	spawn
		if(gauss1)
			gauss1.fire(gauss1_targets)
	spawn
		if(gauss2)
			gauss2.fire(gauss2_targets)
	spawn
		if(gauss3)
			gauss3.fire(gauss3_targets)

/datum/game_mode/necron/proc/phase3()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Phase3")
			var/turf/T = get_turf(A)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/scarab(T)
			new /mob/living/simple_animal/hostile/scarab(T)
		if(A.name == "Necron-Monolith")
			var/turf/T2 = get_turf(A)
			new /mob/living/simple_animal/hostile/monolith(T2)

/datum/game_mode/necron/proc/phase4()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Phase4")
			var/turf/T = get_turf(A)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/necron(T)
			new /mob/living/simple_animal/hostile/scarab(T)
			new /mob/living/simple_animal/hostile/scarab(T)

/datum/game_mode/necron/proc/phase5()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Immortals-Spawn")
			var/turf/T = get_turf(A)
			new /obj/mecha/combat/spyder(T)
			var/list/candidates = get_candidates(BE_TRAITOR)
			while(candidates.len) //Spawns them all in.
				var/client/C = pick_n_take(candidates)
				candidates.Remove(C)
				var/mob/living/silicon/robot/necron/immortal/new_necron = new(T)
				new_necron.key = C.key
	for(var/obj/machinery/shieldwallgen/survival/S in world)
		S.broken = 1 //Disables their shields to put on some pressure.
	spawn(600)
		for(var/obj/effect/landmark/A in landmarks_list)
			if(A.name == "Necron-Shuttle-EMP")
				for(var/mob/living/silicon/robo in range(20,get_turf(A)))
					robo << "\red WARNING: POWERFUL ELECTROMAGNETIC INTERFERENCE DETECTED, RUNNING DIAGNOSTICS."
					robo.Stun(100)

/datum/game_mode/necron/check_finished()
	if(is_crew_all_dead())
		finished = 1
		return 1
	return ..()

/datum/game_mode/proc/is_crew_all_dead() //If this happens, the round ends early with necron victory.
	for(var/mob/living/carbon/human/M in mob_list)
		if(istype(M))
			if(M.mind)
				if(M.stat != 2)
					return 0
	return 1

/datum/game_mode/proc/is_on_shuttle(var/mob/living/player)
	var/turf/location = get_turf(player)
	if(!location)
		return 0
	var/area/check_area = location.loc
	if(istype(check_area, /area/shuttle/escape/centcom))
		return 1
	if(istype(check_area, /area/shuttle/escape_pod1/centcom))
		return 1
	if(istype(check_area, /area/shuttle/escape_pod2/centcom))
		return 1
	if(istype(check_area, /area/shuttle/escape_pod3/centcom))
		return 1
	if(istype(check_area, /area/shuttle/escape_pod4/centcom))
		return 1
	else
		return 0

/datum/game_mode/necron/proc/enumerate_survivors()
	var/survivors = 0
	for(var/datum/mind/person in world)
		if(person.faction != "necron")
			if(person.current)
				if(person.current.stat!=2)
					if(is_on_shuttle(person.current))
						survivors += 1
	return survivors

/datum/game_mode/necron/declare_completion()
	var/crew_evacuated = (emergency_shuttle.location==2)
	if(finished)
		feedback_set_details("round_end_result","win - all crew members neutralized")
		world << "\red <FONT size = 3><B> The necrons have killed everyone and taken the planet! Evacuation has failed!</B></FONT>"
	else if(is_crew_all_dead())
		feedback_set_details("round_end_result","win - all crew members neutralized")
		world << "\red <FONT size = 3><B> The necrons have killed everyone and taken the planet! Evacuation has failed!</B></FONT>"
	else if(crew_evacuated)
		if(enumerate_survivors() > 3)
			feedback_set_details("round_end_result","loss - a significant quantity of crewmembers were evacuated")
			world << "\red <FONT size = 3><B> The crew members have survived the awakening of the tomb world Archangel IV! Evacuation has succeeded!</B></FONT>"
		else
			feedback_set_details("round_end_result","draw - some crew evacuated but a significant majority failed to escape")
			world << "\red <FONT size = 3><B> Some of the crew members have survived the necrons! The necrons have killed most of the crew! Nobody wins!</B></FONT>"
	else
		feedback_set_details("round_end_result","draw - round ended unexpectedly")
		world << "\red <FONT size = 3><B> The round has ended early! Nobody wins!</B></FONT>"
	..()
	return 1

/datum/game_mode/proc/auto_declare_completion_necron()
	if( necrons.len || (ticker && istype(ticker.mode,/datum/game_mode/necron)) )
		var/text = "<br><FONT size=3><B>The necrons were:</B></FONT>"

		for(var/datum/mind/necron in necrons)

			text += "<br><b>[necron.key]</b> was <b>[necron.name]</b> ("
			if(necron.current)
				if(necron.current.stat == DEAD)
					text += "undergoing repairs"
				else
					text += "fully operational"
				if(necron.current.real_name != necron.name)
					text += " as <b>[necron.current.real_name]</b>"
			else
				text += "body destroyed (how on earth...?)"
			text += ")"

		text += "<br>"

		world << text
	return 1