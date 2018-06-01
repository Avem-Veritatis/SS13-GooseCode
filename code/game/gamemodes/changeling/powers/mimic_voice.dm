/obj/effect/proc_holder/changeling/mimicvoice
	name = "Mimic Voice"
	desc = "You analyze and replicate the desired voice."
	helptext = "Will turn your voice into the name that you enter. You must constantly expend chemicals to maintain your form like this."
	chemical_cost = 0 //constant chemical drain hardcoded
	dna_cost = 1
	req_human = 1


// Fake Voice
/obj/effect/proc_holder/changeling/mimicvoice/sting_action(var/mob/user)
	var/datum/changeling/changeling=user.mind.changeling
	if(changeling.mimicing)
		changeling.mimicing = ""
		changeling.chem_recharge_slowdown -= 0.5
		user << "<span class='notice'>You stop impersonating that voice.</span>"
		return

	var/mimic_voice = input("Enter a name to mimic.", "Mimic Voice", null) as text
	if(!mimic_voice)
		return

	changeling.mimicing = mimic_voice
	changeling.chem_recharge_slowdown += 0.5
	user << "<span class='notice'>You analyze and replicate the voice of <b>[mimic_voice]</b>, this will stop you from regenerating chemicals while active.</span>"
	user << "<span class='notice'>Use this power again to return to our original voice and reproduce chemicals again.</span>"

	feedback_add_details("changeling_powers","MV")