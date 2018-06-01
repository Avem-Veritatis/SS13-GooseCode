/obj/effect/proc_holder/changeling/epinephrine
	name = "Polymorphine Overdose"
	desc = "We use polymorphine as a combat stimulant."
	helptext = "Heals you. Removes all stuns instantly and adds a short-term reduction in further stuns. Can be used while unconscious. Continued use poisons the body."
	chemical_cost = 30
	dna_cost = 1
	req_human = 1
	req_stat = UNCONSCIOUS

//Recover from stuns.
/obj/effect/proc_holder/changeling/epinephrine/sting_action(var/mob/user)

	if(user.lying)
		user << "<span class='notice'>We arise.</span>"
	else
		user << "<span class='notice'>Adrenaline rushes through us.</span>"
	var/mob/living/carbon/C = usr
	user.stat = 0
	user.SetParalysis(0)
	user.SetStunned(0)
	user.SetWeakened(0)
	user.lying = 0
	user.update_canmove()
	user.reagents.add_reagent("synaptizine", 20)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		for(var/obj/item/organ/heart/heart in H.internal_organs)
			heart.beating = 1
			heart.status = 0
			heart.update_icon()
	C.setToxLoss(0)
	C.setOxyLoss(0)
	C.setCloneLoss(0)
	C.radiation = 0
	C.heal_overall_damage(C.getBruteLoss(), C.getFireLoss())

	feedback_add_details("changeling_powers","UNS")
	return 1
