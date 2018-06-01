/proc/make_apothecary(var/mob/living/carbon/human/whitelisted/H)
	for(var/obj/item/clothing/suit/armor/SM in H.contents)
		if(SM.astartes)
			SM.icon_state += "apoth"
			SM.item_state += "apoth"
	H.equip_to_slot(new /obj/item/clothing/under/surgerycybernetic, slot_w_uniform)

/proc/make_tech(var/mob/living/carbon/human/whitelisted/H)
	for(var/obj/item/clothing/suit/armor/SM in H.contents)
		if(SM.astartes)
			SM.icon_state += "tech"
			SM.item_state += "tech"
	H.equip_to_slot(new /obj/item/weapon/storage/backpack/mechaclamp, slot_back)