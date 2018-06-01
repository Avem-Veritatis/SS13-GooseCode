// HIVE MIND UPLOAD/DOWNLOAD DNA
var/list/datum/dna/hivemind_bank = list()

/obj/effect/proc_holder/changeling/hivemind_upload
	name = "Tactical Network"
	desc = "Allows you to broadcast victem appearances in the airwaves to allow other appoeratives to assimulate it."
	chemical_cost = 10
	dna_cost = 0

/obj/effect/proc_holder/changeling/hivemind_upload/sting_action(var/mob/user)
	var/datum/changeling/changeling = user.mind.changeling
	var/list/names = list()
	for(var/datum/dna/DNA in changeling.absorbed_dna)
		if(!(DNA in hivemind_bank))
			names += DNA.real_name

	if(names.len <= 0)
		user << "<span class='notice'>The network already has these.</span>"
		return

	var/chosen_name = input("Select an appearance to broadcast: ", "broadcast appearance", null) as null|anything in names
	if(!chosen_name)
		return

	var/datum/dna/chosen_dna = changeling.get_dna(chosen_name)
	if(!chosen_dna)
		return

	hivemind_bank += chosen_dna
	user << "<span class='notice'>You transmit the appearance of [chosen_name] to the network.</span>"
	feedback_add_details("changeling_powers","HU")
	return 1

/obj/effect/proc_holder/changeling/hivemind_download
	name = "Network aquire"
	desc = "Allows you to aquire appearances that have been stored on the network."
	chemical_cost = 20
	dna_cost = 0

/obj/effect/proc_holder/changeling/hivemind_download/can_sting(var/mob/living/carbon/user)
	if(!..())
		return
	var/datum/changeling/changeling = user.mind.changeling
	if(changeling.absorbed_dna[1] == user.dna)//If our current DNA is the stalest, we gotta ditch it.
		user << "<span class='warning'>You have reached our capacity to store information! You must transform before aquiring more.</span>"
		return
	return 1

/obj/effect/proc_holder/changeling/hivemind_download/sting_action(var/mob/user)
	var/datum/changeling/changeling = user.mind.changeling
	var/list/names = list()
	for(var/datum/dna/DNA in hivemind_bank)
		if(!(DNA in changeling.absorbed_dna))
			names[DNA.real_name] = DNA

	if(names.len <= 0)
		user << "<span class='notice'>There are no new identities to aquire from the air.</span>"
		return

	var/S = input("Select an identity to aquire from the network: ", "aquire identity", null) as null|anything in names
	if(!S)	return
	var/datum/dna/chosen_dna = names[S]
	if(!chosen_dna)
		return

	if(changeling.absorbed_dna.len)
		changeling.absorbed_dna.Cut(1,2)
	changeling.absorbed_dna |= chosen_dna
	user << "<span class='notice'>You aquire the identity of [S] from the network.</span>"
	feedback_add_details("changeling_powers","HD")
	return 1