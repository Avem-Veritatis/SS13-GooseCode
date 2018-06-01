/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	var/id = null
	var/height = 0							//the 'height' of the ladder. higher numbers are considered physically higher
	var/obj/structure/ladder/down = null	//the ladder below this one
	var/obj/structure/ladder/up = null		//the ladder above this one

/obj/structure/ladder/New()
	spawn(8)
		for(var/obj/structure/ladder/L in world)
			if(L.id == id)
				if(L.height == (height - 1))
					down = L
					continue
				if(L.height == (height + 1))
					up = L
					continue

			if(up && down)	//if both our connections are filled
				break
		update_icon()

/obj/structure/ladder/update_icon()
	if(up && down)
		icon_state = "ladder11"

	else if(up)
		icon_state = "ladder10"

	else if(down)
		icon_state = "ladder01"

	else	//wtf make your ladders properly assholes
		icon_state = "ladder00"

/obj/structure/ladder/attack_hand(mob/user as mob)
	if(up && down)
		switch( alert("Go up or down the ladder?", "Ladder", "Up", "Down", "Cancel") )
			if("Up")
				user.visible_message("<span class='notice'>[user] climbs up \the [src]!</span>", \
									 "<span class='notice'>You climb up \the [src]!</span>")
				user.loc = get_turf(up)
				if(user.pulling)
					user.pulling.loc = get_turf(up)
				up.add_fingerprint(user)
			if("Down")
				user.visible_message("<span class='notice'>[user] climbs down \the [src]!</span>", \
									 "<span class='notice'>You climb down \the [src]!</span>")
				user.loc = get_turf(down)
				if(user.pulling)
					user.pulling.loc = get_turf(down)
				down.add_fingerprint(user)
			if("Cancel")
				return

	else if(up)
		user.visible_message("<span class='notice'>[user] climbs up \the [src]!</span>", \
							 "<span class='notice'>You climb up \the [src]!</span>")
		user.loc = get_turf(up)
		if(user.pulling)
			user.pulling.loc = get_turf(up)
		up.add_fingerprint(user)

	else if(down)
		user.visible_message("<span class='notice'>[user] climbs down \the [src]!</span>", \
							 "<span class='notice'>You climb down \the [src]!</span>")
		user.loc = get_turf(down)
		if(user.pulling)
			user.pulling.loc = get_turf(down)
		down.add_fingerprint(user)

	add_fingerprint(user)

/obj/structure/ladder/attack_paw(mob/user as mob)
	return attack_hand(user)

/obj/structure/ladder/attackby(obj/item/weapon/W, mob/user as mob)
	return attack_hand(user)

obj/structure/ladder/ex_act(severity)
	return





var/list/obj/structure/ladder2/LADDERS = list()

/obj/structure/ladder2    //because the first ladder was needlessly stupid
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	var/id = null			//id of this ladder
	var/id_target = null	//id of ladder which this moves you to. Simple shit right?

/obj/structure/ladder2/attack_hand(mob/user as mob)
	if(!ismob(user))
		//user.loc = src.loc	//Stop at ladder location
		return

	if(!id_target)
		//user.loc = src.loc	//Stop at ladder location, there is nowhere to climb to.
		return

	for(var/obj/structure/ladder2/LD in LADDERS)
		if(LD.id == src.id_target)
			usr.loc = LD.loc	//Teleport to location with correct id.
			if(usr.pulling)
				usr.pulling.loc = LD.loc
			return

	add_fingerprint(user)

/obj/structure/ladder2/attack_paw(mob/user as mob)
	return attack_hand(user)

/obj/structure/ladder2/attackby(obj/item/weapon/W, mob/user as mob)
	return attack_hand(user)

obj/structure/ladder2/ex_act(severity)
	return

/obj/structure/ladder2/New()
	..()
	LADDERS += src

/obj/structure/ladder2/Destroy()
	LADDERS -= src
	..()

