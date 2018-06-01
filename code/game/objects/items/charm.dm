/obj/item/goodluck
	name = "Good Luck Talisman"
	desc = "A good luck charm."
	icon = 'icons/obj/charm.dmi'
	icon_state = "goodluck"
	item_state = "coin"
	w_class = 1
	var/mob/living/bearer = null
	var/luck_granted = 5

/obj/item/goodluck/New()
	..()
	processing_objects.Add(src)

/obj/item/goodluck/process()
	if(bearer)
		if(get_turf(src) != get_turf(bearer))
			bearer.luck -= luck_granted
			src.bearer = null

/obj/item/goodluck/equipped(mob/user as mob)
	..()
	if(bearer != user)
		bearer = user
		bearer.luck += luck_granted

/obj/item/goodluck/badluck
	name = "Cursed Talisman"
	desc = "An ornate golden talisman..."
	icon_state = "cursed"
	luck_granted = -5