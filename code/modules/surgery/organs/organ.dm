/obj/item/organ
	name = "organ"
	icon = 'icons/obj/surgery.dmi'



/obj/item/organ/heart
	name = "heart"
	icon_state = "heart-on"
	var/beating = 1
	var/status = 0 //Increases when you get a drug overdose, enough and it stops beating.

/obj/item/organ/heart/update_icon()
	if(beating)
		icon_state = "heart-on"
	else
		icon_state = "heart-off"


/obj/item/organ/appendix
	name = "appendix"
	icon_state = "appendix"
	var/inflamed = 1

/obj/item/organ/appendix/update_icon()
	if(inflamed)
		icon_state = "appendixinflamed"
	else
		icon_state = "appendix"


//Looking for brains?
//Try code/modules/mob/living/carbon/brain/brain_item.dm

//Old Datum Limbs:
// code/modules/unused/limbs.dm


/obj/item/organ/limb
	name = "limb"
	var/mob/owner = null
	var/body_part = null
	var/brutestate = 0
	var/burnstate = 0
	var/brute_dam = 0
	var/burn_dam = 0
	var/max_damage = 0
	var/status = ORGAN_ORGANIC
	var/list/wounds = list()
	var/list/scars = list()

/obj/item/organ/limb/chest
	name = "chest"
	desc = "why is it detached..."
	icon_state = "chest"
	max_damage = 200
	body_part = CHEST


/obj/item/organ/limb/head
	name = "head"
	desc = "what a way to get a head in life..."
	icon_state = "head"
	max_damage = 200
	body_part = HEAD


/obj/item/organ/limb/l_arm
	name = "l_arm"
	desc = "why is it detached..."
	icon_state = "l_arm"
	max_damage = 75
	body_part = ARM_LEFT


/obj/item/organ/limb/l_leg
	name = "l_leg"
	desc = "why is it detached..."
	icon_state = "l_leg"
	max_damage = 75
	body_part = LEG_LEFT


/obj/item/organ/limb/r_arm
	name = "r_arm"
	desc = "why is it detached..."
	icon_state = "r_arm"
	max_damage = 75
	body_part = ARM_RIGHT


/obj/item/organ/limb/r_leg
	name = "r_leg"
	desc = "why is it detached..."
	icon_state = "r_leg"
	max_damage = 75
	body_part = LEG_RIGHT



//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/organ/limb/proc/take_damage(brute, burn, var/woundtype = null)
	if(owner && (owner.status_flags & GODMODE))	return 0	//godmode
	brute	= max(brute,0)
	burn	= max(burn,0)


	if(status == ORGAN_ROBOTIC) //This makes robolimbs not damageable by chems and makes it stronger
		brute = max(0, brute - 5)
		burn = max(0, burn - 4)

	var/can_inflict = max_damage - (brute_dam + burn_dam)
	if(!can_inflict)	return 0

	if(!istype(woundtype, /datum/wound)) //Lets not have all these emperor damned runtime errors for screwy arguments
		woundtype = null
	if(woundtype)
		wounds.Add(new woundtype())
	else if(woundtype == null) //if set to zero, no wound will be applied, if left at default null, will apply a wound automatically
		if(brute)
			if(brute >= 20)
				wounds.Add(new /datum/wound/fractures())
			else
				wounds.Add(new /datum/wound())
		if(burn && burn_dam >= 10)
			wounds.Add(new /datum/wound/burn())

	if((brute + burn) < can_inflict)
		brute_dam	+= brute
		burn_dam	+= burn
	else
		if(brute > 0)
			if(burn > 0)
				brute	= round( (brute/(brute+burn)) * can_inflict, 1 )
				burn	= can_inflict - brute	//gets whatever damage is left over
				brute_dam	+= brute
				burn_dam	+= burn
			else
				brute_dam	+= can_inflict
		else
			if(burn > 0)
				burn_dam	+= can_inflict
			else
				return 0
	return update_organ_icon()


//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/organ/limb/proc/heal_damage(brute, burn, var/robotic)

	if(robotic && status != ORGAN_ROBOTIC) // This makes organic limbs not heal when the proc is in Robotic mode.
		brute = max(0, brute - 3)
		burn = max(0, burn - 3)

	if(!robotic && status == ORGAN_ROBOTIC) // This makes robolimbs not healable by chems.
		brute = max(0, brute - 3)
		burn = max(0, burn - 3)

	brute_dam	= max(brute_dam - brute, 0)
	burn_dam	= max(burn_dam - burn, 0)
	for(var/datum/wound/W in wounds)
		if(W.damtype == "brute" && brute_dam <= W.heal_thresh)
			if(W.scarname)
				scars.Add(W.scarname)
			wounds.Remove(W)
		if(W.damtype == "burn" && burn_dam <= W.heal_thresh)
			if(W.scarname)
				scars.Add(W.scarname)
			wounds.Remove(W)
	return update_organ_icon()


/obj/item/proc/item_heal_robotic(var/mob/living/carbon/human/H, var/mob/user, var/brute, var/burn)
	var/obj/item/organ/limb/affecting = H.get_organ(check_zone(user.zone_sel.selecting))

	var/dam //changes repair text based on how much brute/burn was supplied

	if(brute > burn)
		dam = 1
	else
		dam = 0

	if(affecting.status == ORGAN_ROBOTIC)
		if(brute > 0 && affecting.brute_dam > 0 || burn > 0 && affecting.burn_dam > 0)
			if (H != user)
				user.visible_message("<span class='notice'>[user] starts to repair [H]...</span>", "<span class='notice'>You begin repairing [H]...</span>")
				if(!do_mob(user, H, 20))	return
				user.visible_message("<span class='success'>[user] has fixed some of the [dam ? "dents on" : "burnt wires in"] [H]'s [affecting.getDisplayName()]!</span>",\
									"<span class='success'>You fix some of the [dam ? "dents on" : "burnt wires in"] [H]'s [affecting.getDisplayName()]</span>")
			else
				var/t_himself = "itself"
				if (user.gender == MALE)
					t_himself = "himself"
				else if (user.gender == FEMALE)
					t_himself = "herself"
				user.visible_message("<span class='notice'>[user] starts to repair [t_himself]...</span>", "<span class='notice'>You begin repairing yourself...</span>")
				if(!do_mob(user, H, 60))	return
				user.visible_message("<span class='success'>[user] fixes some [dam ? "dents on" : "burnt wires in"] [t_himself].</span>",\
									"<span class='success'>You fix some of the [dam ? "dents on" : "burnt wires in"] your [affecting.getDisplayName()].</span>")
			affecting.heal_damage(brute,burn,1)
			H.update_damage_overlays(0)
			H.updatehealth()
			for(var/mob/O in viewers(user, null))
				O.show_message(text("<span class='notice'>[user] has fixed some of the [dam ? "dents on" : "burnt wires in"] [H]'s [affecting.getDisplayName()]!</span>"), 1)
			return
		else
			user << "<span class='notice'>[H]'s [affecting.getDisplayName()] is already in good condition</span>"
			return
	else
		return

//Returns total damage...kinda pointless really
/obj/item/organ/limb/proc/get_damage()
	return brute_dam + burn_dam


//Updates an organ's brute/burn states for use by update_damage_overlays()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/organ/limb/proc/update_organ_icon()
	if(status == ORGAN_ORGANIC) //Robotic limbs show no damage - RR
		var/tbrute	= round( (brute_dam/max_damage)*3, 1 )
		var/tburn	= round( (burn_dam/max_damage)*3, 1 )
		if((tbrute != brutestate) || (tburn != burnstate))
			brutestate = tbrute
			burnstate = tburn
			return 1
		return 0

//Returns a display name for the organ
/obj/item/organ/limb/proc/getDisplayName() //Added "Chest" and "Head" just in case, this may not be needed - RR.
	switch(name)
		if("l_leg")		return "left leg"
		if("r_leg")		return "right leg"
		if("l_arm")		return "left arm"
		if("r_arm")		return "right arm"
		if("chest")     return "chest"
		if("head")		return "head"
		else			return name


