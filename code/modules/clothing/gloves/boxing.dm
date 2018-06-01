/obj/item/clothing/gloves/boxing
	name = "boxing gloves"
	desc = "Because you really needed another excuse to punch your crewmates."
	icon_state = "boxing"
	item_state = "boxing"

/obj/item/clothing/gloves/boxing/green
	icon_state = "boxinggreen"
	item_state = "boxinggreen"

/obj/item/clothing/gloves/boxing/blue
	icon_state = "boxingblue"
	item_state = "boxingblue"

/obj/item/clothing/gloves/boxing/yellow
	icon_state = "boxingyellow"
	item_state = "boxingyellow"

/obj/item/clothing/gloves/white
	name = "white gloves"
	desc = "These look pretty fancy."
	icon_state = "latex"
	item_state = "lgloves"
	item_color="mime"

	redcoat
		item_color = "redcoat"		//Exists for washing machines. Is not different from white gloves in any way.

/obj/item/clothing/gloves/white/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/toy/crayon))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.mind && H.mind.assigned_role == "Mime" && H.purity <= -22)
				usr.visible_message("<span class='notice'>[usr] colors the [src] in shades of black and red.</span>", "<span class='notice'>You color the gloves in blacks and reds. It almost seems like they become something more under your careful work. These will serve you well.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
				user.put_in_hands(new /obj/item/clothing/gloves/combat/harlequin(user))
				qdel(src)
				return
	..()