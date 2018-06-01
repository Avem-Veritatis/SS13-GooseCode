//CONTAINS: Suit fibers and Detective's Scanning Computer

atom/var/list/suit_fibers

atom/proc/add_fibers(mob/living/carbon/human/M)
	if(M.gloves && istype(M.gloves,/obj/item/clothing/))
		var/obj/item/clothing/gloves/G = M.gloves
		if(G.transfer_blood > 1)	//bloodied gloves transfer blood to touched objects
			if(add_blood(G.bloody_hands_mob))	//only reduces the bloodiness of our gloves if the item wasn't already bloody
				G.transfer_blood--
	else if(M.bloody_hands > 1)
		if(add_blood(M.bloody_hands_mob))
			M.bloody_hands--

	if(!suit_fibers) suit_fibers = list()
	var/fibertext

	if(M.wear_suit)
		fibertext = "Material from \a [M.wear_suit]."
		if(prob(60) && !(fibertext in suit_fibers))
			suit_fibers += fibertext

		if(!(M.wear_suit.body_parts_covered & CHEST))
			if(M.w_uniform)
				fibertext = "Fibers from \a [M.w_uniform]."
				if(prob(50) && !(fibertext in suit_fibers))	//Wearing a suit means less of the uniform exposed.
					suit_fibers += fibertext

		if(!(M.wear_suit.body_parts_covered & HANDS))
			if(M.gloves)
				fibertext = "Material from a pair of [M.gloves.name]."
				if(prob(40) && !(fibertext in suit_fibers))
					suit_fibers += fibertext

	else
		if(M.w_uniform)
			fibertext = "Fibers from \a [M.w_uniform]."
			if(prob(50) && !(fibertext in suit_fibers))
				suit_fibers += fibertext

		if(M.gloves)
			fibertext = "Material from a pair of [M.gloves.name]."
			if(prob(40) && !(fibertext in suit_fibers))
				suit_fibers += fibertext


/atom/proc/add_hiddenprint(mob/living/M)
	if(isnull(M))		return
	if(isnull(M.key))	return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.dna, /datum/dna))
			return 0
		if(H.gloves)
			if(fingerprintslast != H.ckey)
				fingerprintshidden += text("\[[time_stamp()]\] (Wearing gloves). Real name: [], Key: []",H.real_name, H.key)
				fingerprintslast = H.ckey
			return 0
		if(!( fingerprints ))
			if(fingerprintslast != H.ckey)
				fingerprintshidden += text("\[[time_stamp()]\] Real name: [], Key: []",H.real_name, H.key)
				fingerprintslast = H.ckey
			return 1
	else
		if(fingerprintslast != M.ckey)
			fingerprintshidden += text("\[[time_stamp()]\] Real name: [], Key: []",M.real_name, M.key)
			fingerprintslast = M.ckey
	return


//Set ignoregloves to add prints irrespective of the mob having gloves on.
/atom/proc/add_fingerprint(mob/living/M as mob, ignoregloves = 0)
	if(isnull(M)) return
	if(isnull(M.key)) return
	if(ishuman(M))
		//Add the list if it does not exist.
		if(!fingerprintshidden)
			fingerprintshidden = list()

		//Fibers~
		add_fibers(M)

		//Now, lets get to the dirty work.
		//First, make sure their DNA makes sense.
		var/mob/living/carbon/human/H = M
		check_dna_integrity(H)	//sets up dna and its variables if it was missing somehow

		//Check if the gloves (if any) hide fingerprints
		if(H.gloves)
			var/obj/item/clothing/gloves/G = H.gloves
			if(G.transfer_prints)
				ignoregloves = 1

		//Now, deal with gloves.
		if(!ignoregloves)
			if(H.gloves && H.gloves != src)
				if(fingerprintslast != H.ckey)
					fingerprintshidden += text("\[[]\](Wearing gloves). Real name: [], Key: []",time_stamp(), H.real_name, H.key)
					fingerprintslast = H.ckey
				H.gloves.add_fingerprint(M)
				return 0

		//More adminstuffz
		if(fingerprintslast != H.ckey)
			fingerprintshidden += text("\[[]\]Real name: [], Key: []",time_stamp(), H.real_name, H.key)
			fingerprintslast = H.ckey

		//Make the list if it does not exist.
		if(!fingerprints)
			fingerprints = list()

		//Hash this shit.
		var/full_print = md5(H.dna.uni_identity)

		// Add the fingerprints
		fingerprints[full_print] = full_print

		return 1
	else
		//Smudge up dem prints some
		if(fingerprintslast != M.ckey)
			fingerprintshidden += text("\[[]\]Real name: [], Key: []",time_stamp(), M.real_name, M.key)
			fingerprintslast = M.ckey

	return


/atom/proc/transfer_fingerprints_to(var/atom/A)

	// Make sure everything are lists.
	if(!islist(A.fingerprints))
		A.fingerprints = list()
	if(!islist(A.fingerprintshidden))
		A.fingerprintshidden = list()

	if(!islist(fingerprints))
		fingerprints = list()
	if(!islist(fingerprintshidden))
		fingerprintshidden = list()

	// Transfer
	if(fingerprints)
		A.fingerprints |= fingerprints.Copy()            //detective
	if(fingerprintshidden)
		A.fingerprintshidden |= fingerprintshidden.Copy()    //admin
	A.fingerprintslast = fingerprintslast


//call without chance will definitely place fiber
/atom/proc/add_custom_fiber(fiber, chance)
	if(isnull(fiber))	return
	if(!suit_fibers)
		suit_fibers = list()

	if((isnull(chance) || prob(chance)) && !(fiber in suit_fibers))
		suit_fibers += fiber


/mob/living/proc/add_suit_fibers(fiber)
	if(isnull(fiber))	return
	if(!suit_fibers) suit_fibers = list()

	if(!(fiber in suit_fibers))
		suit_fibers += fiber

//similar to add_fibers, but in reverse. This adds trace evidence to a human over their clothing, and over them if they're naked.
/mob/living/carbon/human/add_suit_fibers(fiber)
	if(isnull(fiber))	return
	if(!suit_fibers) suit_fibers = list()

	if(wear_suit)
		wear_suit.add_custom_fiber(fiber, 70)

		if(!(wear_suit.body_parts_covered & CHEST))
			if(w_uniform)
				w_uniform.add_custom_fiber(fiber, 60)

		if(!(wear_suit.body_parts_covered & HANDS))
			if(gloves)
				gloves.add_custom_fiber(fiber, 40)

	else
		if(w_uniform)
			w_uniform.add_custom_fiber(fiber, 60)
		else
			add_custom_fiber(fiber)

		if(gloves)
			gloves.add_custom_fiber(fiber, 40)
