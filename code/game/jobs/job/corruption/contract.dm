/*
Daemon Contracts
Should be a very good addition to corruption
First implementation of this should be a mob vision daemon that offers plague infected people respite if they swear fealty to nurgle.
*/

/datum/boon
	var/name = "generic daemonic boon"
	var/desc = "This should not exist. Ever. Contact a coder about this heresy."

/datum/boon/proc/activate(var/mob/living/carbon/human/H)
	return

/datum/boon/regeneration
	name = "Full Regeneration"
	desc = "Grants a full physical regeneration, healing all injuries, removing any toxification or addictions, and restoring the subject to paragonal condition."

/datum/boon/regeneration/activate(var/mob/living/carbon/human/H)
	H.revive()
	H.addictions = list()
	H.reagents.add_reagent("adminordrazine", 1)
	H.visible_message("<b>[H] miraculously recovers from all injury and ailment!</b>")
	return

/datum/boon/revival
	name = "Lesser Regeneration"
	desc = "Grants a surge of vitality, a second chance. Will revive the dead and save the dying."

/datum/boon/revival/activate(var/mob/living/carbon/human/H)
	H.adjustBruteLoss(-50)
	H.adjustFireLoss(-50)
	H.reagents.add_reagent("revival", 50)
	H.reagents.add_reagent("legecillin", 50)
	H.reagents.add_reagent("tricordrazine", 50)
	H.reagents.add_reagent("doctorsdelight", 50)
	return

/datum/boon/disease_carrier
	name = "Disease Carrier"
	desc = "Become a carrier of all diseases, not impacted by their worst symptoms."

/datum/boon/disease_carrier/activate(var/mob/living/carbon/human/H)
	H.factions += "NURGLE" //TODO: Make this cause people to carry any disease they are exposed to.
	for(var/datum/disease/D in H.viruses)
		D.carrier = 1
		D.stage = 1
	return

/datum/bane
	var/name = "generic daemonic bane"
	var/desc = "This should not exist. Ever. Contact a coder about this heresy."

/datum/bane/proc/activate(var/mob/living/carbon/human/H)
	return

/datum/bane/mutation
	name = "Visible Mutation"
	desc = "The price is exacted in the form of one or more visible mutations."

/datum/bane/mutation/activate(var/mob/living/carbon/human/H)
	H.mutate()
	return

/datum/bane/nurgle_fealty
	name = "Fealty to Nurgle"
	desc = "Your soul is commanded by the plague lord in the afterlife."

/datum/bane/nurgle_fealty/activate(var/mob/living/carbon/human/H)
	award(usr, "You feel it too, don't you?")
	H.fealty = "nurgle"
	if(H.mind)
		ticker.mode.add_cultist(H.mind)
		H.mind.special_role = "Cultist"
	return

/datum/daemon_contract
	var/datum/boon/boon = null
	var/datum/bane/bane = null
	var/mob/living/carbon/human/subject
	var/phrase = "I accept the terms of the contract."

/datum/daemon_contract/proc/activate(var/mob/living/carbon/human/H)
	src.subject = H
	src.subject.pending_contracts.Remove(src)
	src.subject.contracts.Add(src)
	spawn(0)
		boon.activate(src.subject)
	spawn(0)
		bane.activate(src.subject)
	return

/datum/daemon_contract/proc/offer(var/mob/living/carbon/human/H)
	H.pending_contracts.Add(src)
	return

/datum/daemon_contract/plague
	phrase = "I swear fealty to the plague lord nurgle in exchange for respite from my disease."

/datum/daemon_contract/plague/New()
	boon = new /datum/boon/disease_carrier
	bane = new /datum/bane/nurgle_fealty