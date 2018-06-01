/mob/living/carbon/human/ork
	name = "Ork"
	voice_name = "Ork"
	voice_message = "shouts"
	say_message = "shouts"
	icon = 'icons/mob/ork.dmi'
	gender = NEUTER
	dna = null
	factions = list("ork")
	ventcrawler = 2
	var/storedwaagh = 250
	var/max_waagh = 500

	var/has_fine_manipulation = 1

	var/move_delay_add = 0 // movement delay to add

	status_flags = CANPARALYSE|CANPUSH
	var/heal_rate = 10
	var/waagh_rate = 10

/mob/living/carbon/human/ork/New()
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down
	universal_speak = 1
	//src.hud_used.ui_style = 'icons/mob/screen_ork2.dmi' //Give orks their orky UI

	..()

/mob/living/carbon/human/ork/adjustToxLoss(amount)
	storedwaagh = min(max(storedwaagh + amount,0),max_waagh) //upper limit of max_waagh, lower limit of 0
	return

/mob/living/carbon/human/ork/proc/getwaagh()
	return storedwaagh

/mob/living/carbon/human/ork/eyecheck()
	return 2

/mob/living/carbon/human/ork/updatehealth()
	if(status_flags & GODMODE)
		health = maxHealth
		stat = CONSCIOUS
		return
	//oxyloss is only used for suicide
	health = maxHealth - getOxyLoss() - getFireLoss() - getBruteLoss() - getCloneLoss()

/mob/living/carbon/human/ork/proc/ork_handle_environment(var/datum/gas_mixture2/environment)

	//If there are ork weeds on the ground then heal if needed or give some toxins
	if(locate(/obj/structure/human/ork/waagh) in loc)
		if(health >= maxHealth - getCloneLoss())
			adjustToxLoss(waagh_rate)
		else
			adjustBruteLoss(-heal_rate)
			adjustFireLoss(-heal_rate)
			adjustOxyLoss(-heal_rate)

	for(var/mob/living/carbon/alien/humanoid/tyranid/zoanthropes/Z in range(src, 7))
		if(Z.inhibitor)
			adjustToxLoss(-(waagh_rate+5))
			if(prob(5)) src << "\red SOMETHIN NEARBY IZ RUINING WAAAAAGH"
	for(var/mob/living/carbon/alien/humanoid/tyranid/zoanthropes/Z in range(src, 1))
		if(Z.inhibitor)
			adjustToxLoss(-(waagh_rate*8))

	if(!environment)
		return

	..()

/mob/living/carbon/human/ork/proc/ork_handle_mutations_and_radiation()

	if(getFireLoss())
		if((COLD_RESISTANCE in mutations) || prob(5))
			adjustFireLoss(-1)

	// orks love radiation nom nom nom
	if (radiation)
		if (radiation > 100)
			radiation = 100

		if (radiation < 0)
			radiation = 0

		switch(radiation)
			if(1 to 49)
				radiation--
				if(prob(25))
					adjustToxLoss(1)

			if(50 to 74)
				radiation -= 2
				adjustToxLoss(1)
				if(prob(5))
					radiation -= 5

			if(75 to 100)
				radiation -= 3
				adjustToxLoss(3)


/mob/living/carbon/human/ork/IsAdvancedToolUser()
	return has_fine_manipulation

/mob/living/carbon/human/ork/Process_Spaceslipping()
	return 0 // Don't slip in space.

/mob/living/carbon/human/ork/Stat()

	statpanel("Status")
	stat(null, "Intent: [a_intent]")
	stat(null, "Move Mode: [m_intent]")

	..()

	if (client.statpanel == "Status")
		stat(null, "waagh Stored: [getwaagh()]/[max_waagh]")

	if(emergency_shuttle)
		if(emergency_shuttle.online && emergency_shuttle.location < 2)
			var/timeleft = emergency_shuttle.timeleft()
			if (timeleft)
				stat(null, "ETA-[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")

/mob/living/carbon/human/ork/Stun(amount)
	if(status_flags & CANSTUN)
		stunned = max(max(stunned,amount),0) //can't go below 0, getting a low amount of stun doesn't lower your current stun
	else
		// add some movement delay
		move_delay_add = min(move_delay_add + round(amount / 2), 10) // a maximum delay of 10
	return

/mob/living/carbon/human/ork/getTrail()
	return "xltrails"

/mob/living/carbon/human/ork/canBeHandcuffed()
	return 1
