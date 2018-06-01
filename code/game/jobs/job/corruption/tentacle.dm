/*
Slaaneshi tentacle mutation by Drake
Enjoy
*/

/obj/item/clothing/under/tentacles
	name = "Tentacles"
	desc = "A chaotic alteration of the flesh to manifest tentacles."
	icon = 'icons/obj/corrupt.dmi'
	icon_state = "slaanesh"
	item_state = "tentacles"
	item_color = "tentacles"
	has_sensor = 0
	can_roll = 0
	armor = list(melee = 15, bullet = 0, laser = 5,energy = 0, bomb = 5, bio = 0, rad = 25)
	flags = NODROP | STOPSPRESSUREDMAGE

/obj/item/clothing/under/tentacles/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/under/tentacles/process() //Lol this will still function when the wearer is dead. -Drake
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		for(var/mob/living/M in oview(1, H))
			if(prob(40))
				var/action = rand(1, 3)
				switch(action)
					if(1)
						H.visible_message("<span class='warning'>One of [H]'s tentacles slaps [M]!</span>")
						M.damageoverlaytemp = 9001 //Lol this will make them freak out for a moment.
					if(2)
						if(M.reagents)
							H.visible_message("<span class='warning'>One of [H]'s tentacles stings [M]!</span>")
							M.reagents.add_reagent("hallucinations", 10)
							M.reagents.add_reagent("stoxin", 10)
					if(3)
						H.visible_message("<span class='warning'>One of [H]'s tentacles hits [M]!</span>")
						M.take_organ_damage(10, 0)