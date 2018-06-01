
/mob/living/carbon/human/ork/gretchin/regenerate_icons()
	overlays = list()
	update_icons()

/mob/living/carbon/human/ork/gretchin/update_icons()
	var/state = 3
	if(amount_grown > 150)
		max_waagh = 500
		state = 1
	else if(amount_grown > 50)
		state = 3

	if(stat == DEAD)
		icon_state = "gret[state]dead"
	else if (handcuffed || legcuffed) //This should be an overlay. Who made this an icon_state?
		icon_state = "gret[state]"
	else if(stat == UNCONSCIOUS || lying || resting)
		icon_state = "gret[state]sleep"
	else if (stunned)
		icon_state = "gret[state]sleep"
	else
		icon_state = "gret[state]"

/mob/living/carbon/human/ork/gretchin/update_transform() //All this is handled in update_icons()
	return update_icons()