/mob/living/silicon/pai/Life()
	if (src.stat == 2)
		return
	if(src.cable)
		if(get_dist(src, src.cable) > 1)
			var/turf/T = get_turf(src.loc)
			for (var/mob/M in viewers(T))
				M.show_message("\red [src.cable] rapidly retracts back into its spool.", 3, "\red You hear a click and the sound of wire spooling rapidly.", 2)
			qdel(src.cable)
			cable = null

	regular_hud_updates()
	if(src.secHUD == 1)
		src.securityHUD(src)
	if(src.medHUD == 1)
		src.medicalHUD(src)
	if(silence_time)
		if(world.timeofday >= silence_time)
			silence_time = null
			src << "<font color=green>Communication circuit reinitialized. Speech and messaging functionality restored.</font>"

/mob/living/silicon/pai/updatehealth()
	if(status_flags & GODMODE)
		health = maxHealth
		stat = CONSCIOUS
		return
	health = maxHealth - getBruteLoss() - getFireLoss()

/mob/living/silicon/pai/proc/follow_pai()
	while(card)
		loc = get_turf(card)
		sleep(5)
	qdel(src) //if there's no pAI we shouldn't exist