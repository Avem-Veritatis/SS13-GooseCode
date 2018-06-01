/*
A self-randomizing, debilitating plague. For nurgle followers.
Might give plauge marines the option to choose one or two of the random paths this will follow.
Should be near done now.
*/

/datum/disease/plague
	name = "The Plague"
	max_stages = 5
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "Spaceacillin"
	cure_id = "spaceacillin"
	curable = 0 //Can't be cured without an actual cure administered.
	cure_chance = 10 //Pretty high chance of curing the disease once you get the cure.
	agent = "nurgle's blessings"
	affected_species = list("Human")
	permeability_mod = 0.75
	desc = "A severely debilitating plague."
	severity = "Serious"
	stage_prob = 1
	var/mutated = 0
	var/effect = "weaken"
	var/vision = 0

/datum/disease/plague/New()
	cure_id = pick("spaceacillin", "alkysine", "hooch", "fluorine", "morphine", "hyperzine", "speed", "silver", "plasma", "legecillin", "curare", "phenol", "thujone", "meth", "epinephrine", "chloromethane")
	cure = cure_id
	if(cure == "meth") cure = "snake"
	if(cure == "hyperzine") cure = "hypex"
	if(cure == "speed") cure = "spur"
	if(cure == "morphine") cure = "kalma" //Specific names for their IDs.
	effect = pick("weaken", "blind", "bleeding", "necrosis", "nurgling", "toxification")
	..()

/datum/disease/plague/stage_act()
	..()
	var/mob/living/carbon/human/H = affected_mob
	switch(stage)
		if(1)
			if(src.carrier)
				H.heal_organ_damage(1, 1)
				H.ignore_pain += 5
				H.unknown_pain += 5
				if(prob(5))
					H.visible_message("\red <b>[H]'s rotting flesh bursts open, spraying decayed filth, pus, and blood everywhere!</b>")
					new /obj/effect/gibspawner/taint(H.loc)
					for(var/mob/living/carbon/human/C in view(H, 2))
						if(C.viruses.len) continue
						var/blockprob = 0
						for(var/obj/item/clothing/A in C.get_equipped_items()) //A biosuit and hood will protect you.
							if(istype(A, /obj/item/clothing/suit/bio_suit))
								blockprob += 60
							if(istype(A, /obj/item/clothing/suit/bio_suit/medicus))
								blockprob += 60
							if(istype(A, /obj/item/clothing/suit/armor/sister/hosp))
								blockprob += 80
							if(istype(A, /obj/item/clothing/head/bio_hood))
								blockprob += 40
						if(prob(blockprob)) continue
						var/datum/disease/plague/D = new /datum/disease/plague()
						D.effect = src.effect
						D.holder = C
						D.affected_mob = C
						C.viruses += D
				return
			if(prob(10))
				switch(effect)
					if("weaken")
						H << "<b>You have a coughing fit!</b>"
						H.Stun(3)
						spawn(0) H.emote("cough")
						spawn(10) H.emote("cough")
						spawn(20) H.emote("cough")
						spawn(30) H.emote("cough")
					if("blind")
						H << "<b>Your eyes sting!</b>"
						H.eye_blurry += 5
						H.eye_stat += 1
						H.eye_blind += 1
					if("bleeding")
						if(H.getBruteLoss())
							H << "<b>Your wounds bleed uncontrollably!</b>"
							if(H.health > 35)
								H.adjustOxyLoss(10)
							var/turf/pos = get_turf(H)
							pos.add_blood_floor(H)
					if("necrosis")
						if(H.health > 20)
							H.adjustBruteLoss(1)
					if("nurgling")
						H << "\blue You feel as if Nurgle really does love you...."
					if("toxification")
						H.adjustToxLoss(1)
		if(2)
			if(!vision)
				vision = 1
				var/mob/living/simple_animal/hostile/retaliate/vision/plague/P = new /mob/living/simple_animal/hostile/retaliate/vision/plague(get_turf(H))
				P.my_target = H
			if(prob(10))
				switch(effect)
					if("weaken")
						if(prob(50))
							H << "<b>You have a coughing fit!</b>"
							H.Stun(3)
							spawn(0) H.emote("cough")
							spawn(10) H.emote("cough")
							spawn(20) H.emote("cough")
							spawn(30) H.emote("cough")
						else
							H << "<b>Your legs suddenly give way beneath you!</b>"
							H.Weaken(2)
					if("blind")
						H << "<b>Your eyes sting badly!</b>"
						H.eye_blurry += 5
						H.eye_stat += 1
						H.eye_blind += 2
						H.disabilities |= NEARSIGHTED
						spawn(50)
							H.disabilities &= ~NEARSIGHTED
					if("bleeding")
						if(H.getBruteLoss())
							H << "<b>Your wounds bleed uncontrollably!</b>"
							if(H.health > 35)
								H.adjustOxyLoss(15)
								H.adjustBruteLoss(2)
							var/turf/pos = get_turf(H)
							pos.add_blood_floor(H)
							H.Dizzy(1)
					if("necrosis")
						if(H.health > 20)
							H.adjustBruteLoss(2)
						H.Paralyse(2)
						H << "\red You feel a disturbing sense of deadness in your limbs!"
					if("nurgling")
						H.say("...nurgle...")
					if("toxification")
						if(H.getBruteLoss())
							H << "<b>Your wounds fester!</b>"
							H.adjustToxLoss(3)
						H.Stun(1)
						H.visible_message("<B>[H]</B> vomits on the floor!")
						var/tox_dam = H.getToxLoss()
						if(tox_dam < 50)
							H.adjustToxLoss(3)
						var/turf/pos = get_turf(H)
						pos.add_blood_floor(H)
						playsound(pos, 'sound/effects/splat.ogg', 50, 1)
		if(3)
			if(effect == "necrosis")
				if(!(HUSK in H.mutations))
					H.mutations.Add(HUSK)
					H << "\red Your skin peels off!"
					H.update_mutations()
			if(prob(10))
				switch(effect)
					if("weaken")
						if(prob(20))
							H << "<b>You have a coughing fit!</b>"
							spawn(0) H.emote("cough")
							spawn(10) H.emote("cough")
							spawn(20) H.emote("cough")
							spawn(30) H.emote("cough")
							spawn(40) H.emote("cough")
							spawn(50) H.emote("cough")
							spawn(60) H.emote("cough")
						else if(prob(50))
							H.emote("collapse")
							H.Dizzy(10)
						else
							H << "<b>Your legs suddenly give way beneath you!</b>"
							H.Weaken(5)
					if("blind")
						H.disabilities |= NEARSIGHTED
						H.eye_stat += 2
						H.Dizzy(10)
					if("bleeding")
						if(H.getBruteLoss())
							H << "<b>Your wounds bleed uncontrollably! You feel lightheaded...</b>"
							if(H.health > 35)
								H.adjustOxyLoss(20)
								H.adjustBruteLoss(5)
							var/turf/pos = get_turf(H)
							pos.add_blood_floor(H)
							H.Dizzy(10)
							new /obj/effect/gibspawner/blood(H.loc)
						else
							H << "<b>Your skin opens up in a spray of blood!</b>"
							H.adjustBruteLoss(10)
							new /obj/effect/gibspawner/blood(H.loc)
					if("necrosis")
						if(H.health > 20)
							H.adjustBruteLoss(2)
						H.Paralyse(2)
						H << "\red You feel a disturbing sense of deadness in your limbs!"
					if("nurgling")
						H << "\red Nurgle loves you..."
					if("toxification")
						if(H.getBruteLoss())
							H << "<b>Your wounds fester!</b>"
							H.adjustToxLoss(3)
						H.Stun(1)
						H.visible_message("<B>[H]</B> vomits on the floor!")
						var/tox_dam = H.getToxLoss()
						if(tox_dam < 50)
							H.adjustToxLoss(3)
						var/turf/pos = get_turf(H)
						pos.add_blood_floor(H)
						playsound(pos, 'sound/effects/splat.ogg', 50, 1)
		if(4) //At stage four the subject is spraying infection everywhere and highly contagious.
			H.unknown_pain += 2
			if(!mutated)
				H << "<b>Your flesh rots!</b>"
				H.mutate("rot")
				spawn(60)
					H << "<b>You begin to attract flies...</b>"
					H.mutate("flies")
				mutated = 1
			if(prob(10))
				H.visible_message("\red <b>[H]'s rotting flesh bursts open, spraying decayed filth, pus, and blood everywhere!</b>")
				new /obj/effect/gibspawner/taint(H.loc)
				for(var/mob/living/carbon/human/C in view(H, 2))
					if(C.viruses.len) continue
					var/blockprob = 0
					for(var/obj/item/clothing/A in C.get_equipped_items()) //A biosuit and hood will protect you.
						if(istype(A, /obj/item/clothing/suit/bio_suit))
							blockprob += 60
						if(istype(A, /obj/item/clothing/suit/bio_suit/medicus))
							blockprob += 60
						if(istype(A, /obj/item/clothing/suit/armor/sister/hosp))
							blockprob += 80
						if(istype(A, /obj/item/clothing/head/bio_hood))
							blockprob += 40
					if(prob(blockprob)) continue
					var/datum/disease/plague/D = new /datum/disease/plague()
					D.effect = src.effect
					D.holder = C
					D.affected_mob = C
					C.viruses += D
			if(prob(10))
				H.visible_message("\red <b>[H] doubles over and spasms in a fit of coughing, spraying a mist of green mucuous everywhere!</b>")
				H.Weaken(5)
				spawn(0)
					H.reagents.add_reagent("plague", 50)
					if(effect == "toxification")
						H.reagents.add_reagent("toxin", 10) //Coughing up poisons.
					if(effect == "bleeding")
						H.reagents.add_reagent("blood", 50) //Coughing up blood.
				spawn(15)
					H.reagents.add_reagent("plague", 50)
					if(effect == "toxification")
						H.reagents.add_reagent("toxin", 10)
					if(effect == "bleeding")
						H.reagents.add_reagent("blood", 50)
				spawn(0) H.emote("cough")
				spawn(10) H.emote("cough")
				spawn(20) H.emote("cough")
				spawn(30) H.emote("cough")
				spawn(40) H.emote("cough")
				spawn(50) H.emote("cough")
				spawn(30)
					var/location = get_turf(H)
					var/datum/effect/effect/system/chem_smoke_spread/S = new /datum/effect/effect/system/chem_smoke_spread
					S.attach(location)
					playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
					if(S)
						S.set_up(H.reagents, pick(2, 3, 4), 0, location)
						S.start()
						sleep(10)
						S.start()
				spawn(10)
					var/location = get_turf(H)
					var/datum/effect/effect/system/chem_smoke_spread/S = new /datum/effect/effect/system/chem_smoke_spread
					S.attach(location)
					playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
					if(S)
						S.set_up(H.reagents, pick(2, 3, 4), 0, location)
						S.start()
						sleep(10)
						S.start()
		if(5) //At stage five the subject is fully impacted by the disease's ultimate effect, and severely debilitated.
			H.unknown_pain += 2
			if(prob(10) && effect != "necrosis")
				H.visible_message("\red <b>[H]'s rotting flesh bursts open, spraying decayed filth, pus, and blood everywhere!</b>")
				new /obj/effect/gibspawner/taint(H.loc)
				for(var/mob/living/carbon/human/C in view(H, 2))
					if(C.viruses.len) continue
					var/blockprob = 0
					for(var/obj/item/clothing/A in C.get_equipped_items()) //A biosuit and hood will protect you.
						if(istype(A, /obj/item/clothing/suit/bio_suit))
							blockprob += 60
						if(istype(A, /obj/item/clothing/suit/bio_suit/medicus))
							blockprob += 60
						if(istype(A, /obj/item/clothing/suit/armor/sister/hosp))
							blockprob += 80
						if(istype(A, /obj/item/clothing/head/bio_hood))
							blockprob += 40
					if(prob(blockprob)) continue
					var/datum/disease/plague/D = new /datum/disease/plague()
					D.effect = src.effect
					D.holder = C
					D.affected_mob = C
					C.viruses += D
			if(prob(10))
				H.visible_message("\red <b>[H] doubles over and spasms in a fit of coughing, spraying a mist of green mucuous everywhere!</b>")
				H.Weaken(5)
				spawn(0)
					H.reagents.add_reagent("plague", 50)
					if(effect == "toxification")
						H.reagents.add_reagent("toxin", 10) //Coughing up poisons.
					if(effect == "bleeding")
						H.reagents.add_reagent("blood", 50) //Coughing up blood.
				spawn(15)
					H.reagents.add_reagent("plague", 50)
					if(effect == "toxification")
						H.reagents.add_reagent("toxin", 10)
					if(effect == "bleeding")
						H.reagents.add_reagent("blood", 50)
				spawn(0) H.emote("cough")
				spawn(10) H.emote("cough")
				spawn(20) H.emote("cough")
				spawn(30) H.emote("cough")
				spawn(40) H.emote("cough")
				spawn(50) H.emote("cough")
				spawn(30)
					var/location = get_turf(H)
					var/datum/effect/effect/system/chem_smoke_spread/S = new /datum/effect/effect/system/chem_smoke_spread
					S.attach(location)
					playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
					if(S)
						S.set_up(H.reagents, pick(2, 3, 4), 0, location)
						S.start()
						sleep(10)
						S.start()
				spawn(10)
					var/location = get_turf(H)
					var/datum/effect/effect/system/chem_smoke_spread/S = new /datum/effect/effect/system/chem_smoke_spread
					S.attach(location)
					playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
					if(S)
						S.set_up(H.reagents, pick(2, 3, 4), 0, location)
						S.start()
						sleep(10)
						S.start()
			if(prob(25))
				switch(effect)
					if("weaken") //Really, really incapacitated.
						if(prob(20))
							H << "<b>You have a coughing fit!</b>"
							H.Stun(5)
							spawn(60) H.Weaken(2)
							spawn(0) H.emote("cough")
							spawn(10) H.emote("cough")
							spawn(20) H.emote("cough")
							spawn(30) H.emote("cough")
							spawn(40) H.emote("cough")
							spawn(50) H.emote("cough")
							spawn(60) H.emote("cough")
							spawn(70) H.emote("cough")
						else if(prob(50))
							H.emote("collapse")
							H.Dizzy(15)
						else
							H << "<b>Your legs suddenly give way beneath you!</b>"
							H.Weaken(7)
					if("blind") //Eyes are effectively completely nonfunctional.
						H.eye_stat += 10
						H.eye_blind += 10
					if("bleeding") //Bleeds you to death.
						if(H.getBruteLoss())
							H << "<b>Your wounds bleed uncontrollably! You feel lightheaded...</b>"
							H.adjustOxyLoss(20)
							H.adjustBruteLoss(5)
							var/turf/pos = get_turf(H)
							pos.add_blood_floor(H)
							H.Dizzy(10)
							new /obj/effect/gibspawner/blood(H.loc)
						else
							H << "<b>Your skin opens up in a spray of blood!</b>"
							H.adjustBruteLoss(10)
							new /obj/effect/gibspawner/blood(H.loc)
					if("necrosis") //Turns you into a rotting, collapsing skeleton.
						if(H.dna && H.dna.mutantrace != "skeleton")
							H << "<b>Your flesh falls out in clumps...</b>"
							H.makeSkeleton()
							H.adjustBruteLoss(15)
						else
							H << "<b>You feel a sense of horrible numbness...</b>"
							H.adjustBruteLoss(1)
							H.emote("collapse")
					if("nurgling") //Turns you into a nurgle spawn.
						H.say("NURGLE LOVES US!!!!!!")
						H << "\red You feel a surge of loyalty to the lord of plagues."
						new /mob/living/simple_animal/chaosspawn/nspawn(H.loc)
						H.gib()
					if("toxification") //Releases lethal toxins nonstop.
						H.reagents.add_reagent(pick("mutagen", "thujone", "morphine", "mindbreaker", "strangle", "phenol", "ricin"), 5)
	return
