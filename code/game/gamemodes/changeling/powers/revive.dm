/obj/effect/proc_holder/changeling/revive
	name = "Regenerate"
	desc = "You regenerate, healing all damage from your form."
	chemical_cost = 10
	req_stat = DEAD

//Revive from regenerative stasis
/obj/effect/proc_holder/changeling/revive/sting_action(var/mob/living/carbon/user)

	if(user.stat == DEAD)
		dead_mob_list -= user
		living_mob_list += user
	user.stat = CONSCIOUS
	user.tod = null
	user.setToxLoss(0)
	user.setOxyLoss(0)
	user.setCloneLoss(0)
	user.SetParalysis(0)
	user.SetStunned(0)
	user.SetWeakened(0)
	user.radiation = 0
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		for(var/obj/item/organ/heart/heart in H.internal_organs)
			heart.beating = 1
			heart.status = 0
			heart.update_icon()
	user.heal_overall_damage(user.getBruteLoss(), user.getFireLoss())
	user.reagents.clear_reagents()
	user << "<span class='notice'>You have regenerated.</span>"

	user.status_flags &= ~(FAKEDEATH)
	user.update_canmove()
	user.mind.changeling.purchasedpowers -= src
	feedback_add_details("changeling_powers","CR")
	return 1