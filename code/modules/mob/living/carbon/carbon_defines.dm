/mob/living/carbon/
	gender = MALE
	var/list/stomach_contents	= list()
	var/list/internal_organs	= list()	//List of /obj/item/organ in the mob. they don't go in the contents.

	var/silent = null 		//Can't talk. Value goes down every life proc.

	var/obj/item/handcuffed = null //Whether or not the mob is handcuffed
	var/obj/item/legcuffed = null  //Same as handcuffs but for legs. Bear traps use this.

//inventory slots
	var/obj/item/back = null
	var/obj/item/clothing/mask/wear_mask = null
	var/obj/item/weapon/tank/internal = null

	var/datum/dna/dna = null//Carbon
	var/bleedout = 0

/mob/living/carbon/Life()
	..()
	if(bleedout && src.stat != DEAD)
		src.adjustOxyLoss(5)
		src.take_organ_damage(5, 0)
		if(src.loc == get_turf(src))
			new /obj/effect/decal/cleanable/blood(src.loc)