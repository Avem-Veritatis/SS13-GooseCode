/*
Pretty simple code... But this is going to be awesome.
All you need to do is inject a syringe of your blood in the machine and it is locked so that only your DNA can open it.
Of coarse, if somebody gets a blood sample they could potentially replicate your DNA...
Or just hack the door which is a lot easier.
*/

/obj/machinery/door/airlock/highsecurity/blood
	name = "DNA Verification Airock"
	desc = "This airlock pairs to a single invidual by accepting a syringe full of their blood. It only allows access to users whose genetic pattern match that of the blood."
	var/datum/dna/dna_lock = null

/obj/machinery/door/airlock/highsecurity/blood/is_open_container()
	if(dna_lock)
		return 0
	spawn(10)
		if(reagents.total_volume)
			for(var/datum/reagent/blood/B in reagents.reagent_list)
				if(ishuman(B.data["donor"]))
					var/mob/living/carbon/human/H = B.data["donor"]
					if(H.dna)
						dna_lock = new /datum/dna
						dna_lock.unique_enzymes = H.dna.unique_enzymes
						dna_lock.struc_enzymes = H.dna.struc_enzymes
						dna_lock.uni_identity = H.dna.uni_identity
						dna_lock.blood_type = H.dna.blood_type
						dna_lock.mutantrace = H.dna.mutantrace
			if(!dna_lock)
				reagents.clear_reagents()
				src.visible_message("<b>[src]</b> buzzes \"Blood sample not viable. Removing sample...\"")
			else
				src.visible_message("<b>[src]</b> buzzes \"Blood sample accepted. Sample locked.\"")
	return 1

/obj/machinery/door/airlock/highsecurity/blood/New()
	..()
	create_reagents(5)

/obj/machinery/door/airlock/highsecurity/blood/allowed(mob/M)
	if(!dna_lock) return ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && dna_lock)
			var/datum/dna/D = dna_lock
			if(H.dna.unique_enzymes == D.unique_enzymes && H.dna.struc_enzymes == D.struc_enzymes && H.dna.uni_identity == D.uni_identity && H.dna.blood_type == D.blood_type && H.dna.mutantrace == D.mutantrace)
				return 1
	return 0