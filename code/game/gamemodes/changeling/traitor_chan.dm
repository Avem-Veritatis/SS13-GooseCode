/datum/game_mode/traitor/changeling
	name = "traitor+changeling"
	config_tag = "traitorchan"
	traitors_possible = 3 //hard limit on traitors if scaling is turned off
	restricted_jobs = list("AI", "Servitor")
	required_players = 2
	required_enemies = 1	// how many of each type are required
	recommended_enemies = 3

	var/list/possible_changelings = list()
	var/const/changeling_amount = 1 //hard limit on changelings if scaling is turned off

/datum/game_mode/traitor/changeling/announce()
	world << "<B>The current game mode is - I'm not telling you!</B>"
	world << "<B>There is some crazy shit going down man! I can't say anything but... man it's going to be insane! Look, I'll give you a hint okay. Geese. Thats it. Thats all I'm going to say.</B>"

/datum/game_mode/traitor/changeling/can_start()
	if(!..())
		return 0
	possible_changelings = get_players_for_role(BE_CHANGELING)
	if(possible_changelings.len < required_enemies)
		return 0
	return 1

/datum/game_mode/traitor/changeling/pre_setup()
	if(config.protect_roles_from_antagonist)
		restricted_jobs += protected_jobs

	var/list/datum/mind/possible_changelings = get_players_for_role(BE_CHANGELING)

	var/num_changelings = 1

	if(config.changeling_scaling_coeff)
		num_changelings = max(1, round((num_players())/(config.changeling_scaling_coeff*2)))
	else
		num_changelings = max(1, min(num_players(), changeling_amount))

	for(var/datum/mind/player in possible_changelings)
		for(var/job in restricted_jobs)//Removing robots from the list
			if(player.assigned_role == job)
				possible_changelings -= player

	if(possible_changelings.len>0)
		for(var/j = 0, j < num_changelings, j++)
			if(!possible_changelings.len) break
			var/datum/mind/changeling = pick(possible_changelings)
			possible_changelings -= changeling
			changelings += changeling
			modePlayer += changelings
		return ..()
	else
		return 0

/datum/game_mode/traitor/changeling/post_setup()
	for(var/datum/mind/changeling in changelings)
		changeling.current.make_changeling(changeling.current)
		changeling.special_role = "Changeling"
		forge_changeling_objectives(changeling)
		greet_changeling(changeling)
	..()
	return

/datum/game_mode/traitor/changeling/make_antag_chance(var/mob/living/carbon/human/character) //Assigns changeling to latejoiners
	if(changelings.len >= round(joined_player_list.len / (config.changeling_scaling_coeff*2)) + 1) //Caps number of latejoin antagonists
		..()
		return
	if (prob(100/(config.changeling_scaling_coeff*2)))
		if(character.client.prefs.be_special & BE_CHANGELING)
			if(!jobban_isbanned(character.client, "changeling") && !jobban_isbanned(character.client, "Syndicate"))
				if(!(character.job in ticker.mode.restricted_jobs))
					character.mind.make_Changling()
	..()