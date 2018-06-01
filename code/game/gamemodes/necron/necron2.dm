/*
The reworked necron game mode!
In many ways similar but with tons of new content.
End round conditions:
    -No humans left alive, major necron victory
    -All human command centers destroyed, major necron victory
    -All necron monoliths destroyed, subsequent exterminatus+evac shuttle, major human victory
*/

/datum/game_mode
	var/list/datum/mind/necrons = list()
	var/list/datum/mind/necronwizards = list()
	var/list/honors = list()
	var/deployed = 0

/datum/game_mode/necron
	name = "necron"
	config_tag = "necron"
	required_players = 8
	required_enemies = 2
	recommended_enemies = 2
	pre_setup_before_jobs = 1
	antag_flag = BE_NECRON

	uplink_welcome = "Necron Tomb World"
	uplink_uses = 0

	var/finished = 0

/datum/game_mode/necron/announce()
	world << "<B>The current game mode is - Necron!</B>"
	world << "<B>Try to stay alive!</B>"
	world << "<B>Necrons</B>: Establish control of the planet, destroying enemy command centers and killing any life form that dares stand against you.\n<B>Imperium</B>: Destroy the necron monoliths and halt the necron advance, or die trying."

/datum/game_mode/necron/pre_setup()
	for(var/stage = 1, stage<=2, stage++)
		var/datum/mind/selected = pick(antag_candidates)
		antag_candidates -= selected
		var/role
		switch(stage)
			if(1)
				role = "Necron Lord"
				necrons += selected
			if(2)
				role = "Wizard"
				necronwizards += selected
		selected.special_role = role
	for(var/datum/mind/necro_mind in necrons)
		necro_mind.assigned_role = "MODE"
	for(var/datum/mind/eldar_mind in necronwizards)
		eldar_mind.assigned_role = "MODE"
	return 1

/datum/game_mode/necron/post_setup()
	for(var/datum/mind/necro_mind in necrons)
		log_game("[necro_mind.key] (ckey) has been selected as the Necron Lord")
		for(var/obj/effect/landmark/A in landmarks_list)
			if(A.name == "Necron-Player-Spawn")
				necro_mind.current.loc = get_turf(A)
		var/mob/living/T = necro_mind.current
		var/mob/living/silicon/robot/necron/new_necron = new /mob/living/silicon/robot/necron/lord2(T.loc)
		if(T.mind)	T.mind.transfer_to(new_necron)
		spawn(30)
			new_necron << "<span class='noticealien'>Order. Unity. Obedience. We taught the galaxy these things long ago, and we will do so again.</span>"
			new_necron << "<span class='noticealien'>This planet belongs to you. This galaxy belongs to your kind. Retake these things and crush the fools who pretend to lead in your absence.</span>"
		qdel(T)
	for(var/datum/mind/wizard in necronwizards)
		log_game("[wizard.key] (ckey) has been selected as the Eldar Warlock")
		forge_wizard_necron_objectives(wizard)
		equip_wizard(wizard.current)
		name_wizard(wizard.current)
		greet_wizard(wizard)
		wizard.current.loc = pick(wizardstart)

	spawn()
		control_phases()

	return ..()

/datum/game_mode/proc/forge_wizard_necron_objectives(var/datum/mind/wizard)
	var/datum/objective/protectnecron/objective = new
	objective.owner = wizard
	wizard.objectives += objective
	return

/datum/game_mode/necron/proc/control_phases()
	spawn(0)
		phase0()
	spawn(600)
		phase1() //Enter necron monoliths. Lights out. Segmentum announcement shortly after all this, followed by command center deployment.
	sleep(3000)
	spawn(0)
		phase2() //Enter gauss pylons. Enter a single group of marines of a new non-RTD chapter.

/datum/game_mode/necron/proc/phase0()
	var/list/MS = list()
	for(var/obj/effect/landmark/monolithspawn/S in world)
		MS.Add(S)
	for(var/obj/effect/landmark/monolithcore/C in world)
		var/obj/machinery/monolithcore/NC = new /obj/machinery/monolithcore(get_turf(C))
		var/obj/effect/landmark/monolithspawn/teleloc = pick(MS)
		spawn(30) NC.area.teleport(get_turf(teleloc))
		MS.Remove(teleloc)
		qdel(C)

/datum/game_mode/necron/proc/phase1()
	priority_announce("An electrical storm has been detected in your area, please repair potential electronic overloads.", "Electrical Storm Alert")
	for(var/obj/machinery/power/apc/apc in world) //Lights out!
		apc.overload_lighting()
	sleep(100)
	priority_announce("This is Vice Admiral Callistus Odell, of the Thanatos Glacial Imperial Navy Fleet.\nA full scale crisis is at hands. Legions of the ancient creatures known as necrons are awakening under the surface of Archangel IV. This is not a fucking drill. The Stargazer has been shot down and the entire planet is now a full scale warzone. The necrons must be contained, by any and all means.\n\n\nAve Imperator", "Crisis Vox")
	sleep(100)
	priority_announce("This is Vice Admiral Callistus Odell again.\nI recognize your outpost will need some support to keep from being overwhelmed. We cannot afford to lose your outpost right now, and reinforcements will be sent.\n\n\nA supply terminal and command center is being deployed just south of the outpost's bridge. Clear this area of people right fucking now, and be ready to use the terminal we have dropped. Good luck, and emperor protect you.\n\n\nAve Imperator", "Supply Drop Alert")
	sleep(100)
	for(var/obj/effect/landmark/supplycommandstart/SCS in world)
		new /obj/effect/landmark/supplycommand(get_turf(SCS))
	priority_announce("Admiral Odell here. The supply command center has been sucessfully deployed. Do not allow it to be destroyed. Scans indicate that there are six necron monoliths surrounding your outpost. It is vital that these are dealth with.\n\n\nGood luck.\n\n\nAve Imperator","Crisis Vox")
	deployed = 1

/datum/game_mode/necron/proc/phase2()
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Necron-Gauss-Spawn")
			new /obj/structure/gausspylon(get_turf(A))
	for(var/datum/mind/N in necrons)
		N.current << "<span class='noticealien'>Gauss pylons online.</span>"
		N.current << "<span class='noticealien'>Awaiting orders to fire on enemy targets.</span>"
	var/ghosts = 0
	while(ghosts < 3) //Wait for some ghosts to use.
		ghosts = 0
		for(var/mob/dead/observer/O in player_list)
			if(O.client && O.ckey)
				ghosts += 1
		sleep(450)
	priority_announce("Vice Admiral Callistus Odell here... I have arranged for a group of Iron Hands marines to be deployed to your outpost. Hang in there.\n\n\nThe Emperor Protects!", "Reinforcements Update")
	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Iron Hands Ironfather Spawn")
			var/mob/living/carbon/human/H = new /mob/living/carbon/human/whitelisted/ironhand/techmarine(get_turf(A))
			request_ghost("An Iron Hands marine has been deployed. Do you wish to be considered to play as one?", "Iron Hands Request", H)
		if(A.name == "Iron Hands Apothecary Spawn")
			var/mob/living/carbon/human/H = new /mob/living/carbon/human/whitelisted/ironhand/apothecary(get_turf(A))
			request_ghost("An Iron Hands marine has been deployed. Do you wish to be considered to play as one?", "Iron Hands Request", H)
		if(A.name == "Iron Hands Marine Spawn")
			var/mob/living/carbon/human/H = new /mob/living/carbon/human/whitelisted/ironhand/regular(get_turf(A))
			request_ghost("An Iron Hands marine has been deployed. Do you wish to be considered to play as one?", "Iron Hands Request", H)

/datum/game_mode/necron/check_finished()
	if(is_crew_all_dead() || command_centers_destroyed() || monoliths_destroyed())
		finished = 1
		return 1
	return ..()

/datum/game_mode/proc/is_crew_all_dead()
	for(var/mob/living/carbon/human/M in mob_list)
		if(istype(M))
			if(M.mind)
				if(M.stat != 2)
					return 0
	return 1

/datum/game_mode/proc/command_centers_destroyed()
	if(!deployed) return 0
	for(var/obj/machinery/computer/supplydrop/S in world)
		if(!(S.stat & BROKEN) && S.z == 1)
			return 0
	return 1

/datum/game_mode/proc/monoliths_destroyed()
	if(!deployed) return 0
	for(var/obj/machinery/monolithcore/C in world)
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
	if(is_crew_all_dead())
		feedback_set_details("round_end_result","win - all crew members neutralized")
		world << "\red <FONT size = 3><B> The necrons have killed everyone! The outpost has fallen!</B></FONT>"
	else if(command_centers_destroyed())
		feedback_set_details("round_end_result","win - all command centers destroyed")
		world << "\red <FONT size = 3><B> The necrons have destroyed all human command centers! The outpost has fallen!</B></FONT>"
	else if(monoliths_destroyed())
		feedback_set_details("round_end_result","loss - all monoliths destroyed")
		world << "\red <FONT size = 3><B> All the necron monoliths are destroyed! The outpost has held off the necrons in this part of the planet!</B></FONT>"
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
				if(!isrobot(necron.current))
					text += "body dismantled"
				else if(necron.current.stat == DEAD)
					text += "undergoing repairs"
				else
					text += "fully operational"
				if(necron.current.real_name != necron.name)
					text += " as <b>[necron.current.real_name]</b>"
			else
				text += "body destroyed (well done, this is not easy)"
			text += ")"

		text += "<br><FONT size=3><B>The eldar warlocks were:</B></FONT>"

		for(var/datum/mind/wizard in necronwizards)
			text += "<br><b>[wizard.key]</b> was <b>[wizard.name]</b> ("
			if(wizard.current)
				if(wizard.current.stat == DEAD)
					text += "died"
				else
					text += "survived"
				if(wizard.current.real_name != wizard.name)
					text += " as <b>[wizard.current.real_name]</b>"
			else
				text += "body destroyed"
			text += ")"

		text += "<br>"

		text += "<br><FONT size=3><B>Outpost Defenders:</B></FONT>"
		text += "<br>"
		for(var/honor in honors)
			text += honor
			text += "<br>"
		for(var/mob/living/carbon/human/H in world)
			if(H.mind && H.mind.special_role != "Wizard")
				if(H.stat == DEAD)
					if(H.z != 1)
						text += "[H.name] ([H.mind.key]) died fleeing the outpost"
					else
						text += "[H.name] ([H.mind.key]) body found on the outpost"
					text += "<br>"
				else
					if(H.z != 1)
						text += "[H.name] ([H.mind.key]) fled the outpost"
					else
						text += "[H.name] ([H.mind.key]) survived to the end on the outpost"
					text += "<br>"
		text += "<br>"

		text += "<br>"
		text += "<br>"

		world << text
	return 1