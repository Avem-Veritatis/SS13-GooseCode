/mob/living/carbon/human/ork/oddboy
	name = "Ork Oddboy"
	caste = "d"
	maxHealth = 150
	health = 150
	icon = 'icons/mob/ork.dmi'
	base_icon_state = "ork2"
	icon_state = "ork2"
	storedwaagh = 500
	max_waagh = 500


/mob/living/carbon/human/ork/oddboy/New()
	create_reagents(100)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	src.name = text("Ork Oddboy ([rand(1, 1000)])")
	src.real_name = src.name
	verbs.Add(/mob/living/carbon/human/ork/oddboy/verb/waagh,/mob/living/carbon/human/ork/nob/verb/oddscav)
	..()

/mob/living/carbon/human/ork/oddboy/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/human/ork/oddboy/verb/evolve()
	set name = "Evolve (500)"
	set desc = "Maybe now you DA boss?!?!?."
	set category = "Ork"

	if(powerc(500))
		// Queen check
		var/no_warboss = 1
		for(var/mob/living/carbon/human/ork/warboss/Q in living_mob_list)
			if(!Q.key || !Q.getorgan(/obj/item/organ/brain))
				continue
			no_warboss = 0

		if(no_warboss)
			adjustToxLoss(-500)
			src << "\green HA! NOW YOU DA BOSS!!"
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\green <B>[src] IS NOW DA BOSS! YOU LISTEN TO HIM!</B>"), 1)
			var/mob/living/carbon/human/ork/warboss/new_xeno = new (loc)
			mind.transfer_to(new_xeno)
			for(var/obj/item/W in src) //Lets not delete everything... This is a lot easier than re-equipping it on the new mob though.
				src.unEquip(W)
			qdel(src)
		else
			src << "<span class='notice'>I don't think tha boss will like that.</span>"
	return