/datum/disease/rot
	name = "The Rot"
	max_stages = 3
	spread = "Airborne"
	cure = "Spaceacillin"
	cure_id = "spaceacillin"
	cure_chance = 10
	agent = "H13N1 flu virion"
	affected_species = list("Human", "Monkey")
	permeability_mod = 0.75
	desc = "If left untreated the subject will get burned to death for being a heretic."
	severity = "Serious"

/datum/disease/rot/stage_act()
	..()
	switch(stage)
		if(2)
/*
			if(affected_mob.sleeping && prob(20))  //removed until sleeping is fixed --Blaank
				affected_mob << "\blue You feel better."
				stage--
				return
*/
			if(affected_mob.lying && prob(20))  //added until sleeping is fixed --Blaank
				affected_mob << "\blue You feel as if Nurgle really does love you...."
				stage++
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "\red You feel light as a feather."
				if(prob(20))
					affected_mob.take_organ_damage(2)
			if(prob(1))
				affected_mob << "\red Your feel at peace."
				if(prob(20))
					affected_mob.adjustToxLoss(2)
					affected_mob.updatehealth()

		if(3)
/*
			if(affected_mob.sleeping && prob(15))  //removed until sleeping is fixed
				affected_mob << "\blue You feel better."
				stage--
				return
*/
			if(affected_mob.lying && prob(15))  //added until sleeping is fixed
				affected_mob << "\blue You feel better."
				stage--
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "\red You feel weaker but... strong somehow."
				if(prob(20))
					affected_mob.take_organ_damage(2)
			if(prob(1))
				affected_mob << "\red Things are going to turn out okay."
				if(prob(20))
					affected_mob.adjustToxLoss(2)
					affected_mob.updatehealth()
	return
