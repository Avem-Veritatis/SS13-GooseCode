/obj/machinery/renamer
	name = "Facial reprint"
	desc = "It remolds your 'human' mask. Makes it even harder for primitives to identify you."
	icon = 'icons/obj/machines/antimatter.dmi'
	icon_state = "control"
	density = 1
	anchored = 1


/obj/machinery/renamer/attack_hand(mob/user)
	user.rename_self("[name]")
	icon_state = "control_on"
	playsound(loc, pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)
	spawn(30)
		icon_state = "control"
		return