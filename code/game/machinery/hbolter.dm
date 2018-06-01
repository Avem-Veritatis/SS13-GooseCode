/obj/item/weapon/twohanded/required/bolterc
	icon_state = "bolterc"
	item_state = "bolterc"
	name = "Collapsed Heavy Bolter"
	desc = "A neatly collapsed stationary heavy bolter."
	force = 5
	w_class = 4.0
	slot_flags = SLOT_BACK
	force_unwielded = 5
	force_wielded = 5
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	flags = NOSHIELD
	hitsound = 'sound/weapons/thudswoosh.ogg'
	attack_verb = list("whacked")

/obj/item/weapon/twohanded/required/bolterc/update_icon()
	icon_state = "bolterc"
	item_state = "bolterc"
	return

/obj/item/weapon/twohanded/required/bolterc/verb/unpack()
	set name = "Unpack Heavy Bolter"
	set desc = "Unpack the heavy bolter. This will take a bit of time."
	set category = "Object"
	set src in usr
	usr.visible_message("\red [usr] starts to unpack the [src]!")
	if(do_after(usr, 50))
		usr.visible_message("\red [usr] unpacks the [src]!")
		var/turf/T = get_step(usr, usr.dir)
		var/obj/machinery/cannon/bolter/B = new /obj/machinery/cannon/bolter(T)
		B.dir = usr.dir
		qdel(src)
	else
		usr.visible_message("\red [usr] is distracted and fails to unpack the [src]!")

/obj/item/cannonball/boltermag
	name = "Heavy Bolter Ammunition Box"
	desc = "You put it in the gun to make it go bang."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "boltermag"
	force = 1
	throwforce = 1
	w_class = 1.0
	throw_speed = 1

/obj/machinery/cannon/bolter
	name = "Heavy Bolter"
	desc = "An imperial heavy bolter. It's massive."
	icon = 'icons/obj/machines/cannon.dmi'
	icon_state = "bolter"
	anchored = 1

	fire()
		loaded = 0
		if(dir == EAST || dir == WEST)
			spawn(0)
				src.pixel_x = 2
				sleep(2)
				src.pixel_x = -2
				sleep(2)
				src.pixel_x = 2
				sleep(2)
				src.pixel_x = -2
				sleep(2)
				src.pixel_x = 2
				sleep(2)
				src.pixel_x = -2
				sleep(2)
				src.pixel_x = 2
				sleep(2)
				src.pixel_x = -2
				sleep(2)
				src.pixel_x = 0
		if(dir == NORTH || dir == SOUTH)
			spawn(0)
				src.pixel_y = 2
				sleep(2)
				src.pixel_y = -2
				sleep(2)
				src.pixel_y = 2
				sleep(2)
				src.pixel_y = -2
				sleep(2)
				src.pixel_y = 2
				sleep(2)
				src.pixel_y = -2
				sleep(2)
				src.pixel_y = 2
				sleep(2)
				src.pixel_y = -2
				sleep(2)
				src.pixel_y = 0
		if(usr)
			src.visible_message("\red <b>[usr] fires the [src]!</b>")
		for(var/i=1 to 8)
			sleep(2)
			var/turf/T = loc
			var/turf/U = get_step(src, dir) // Get the tile infront of the move, based on their direction
			if(!isturf(U) || !isturf(T))
				return
			playsound(loc, 'sound/weapons/Gunshot_bolter.ogg', 75, 0)
			var/obj/item/projectile/bullet/gyro/heavy/A = new /obj/item/projectile/bullet/gyro/heavy(src.loc)
			A.current = U
			A.yo = U.y - T.y
			A.xo = U.x - T.x
			A.process()

	attackby(obj/item/O, mob/user)
		if(istype(O, /obj/item/cannonball/boltermag))
			if(!loaded)
				user.visible_message("<span class='notice'>[user] begins loading the [src]...</span>","<span class='notice'>Loading the [src]...</span>")
				if(do_after(user, 25))
					loaded = 1
					qdel(O)
					user.visible_message("<span class='notice'>[user] loads ammunition into the [src].</span>", "<span class='notice'>You load ammunition into the [src].</span>")
				else
					user.visible_message("<span class='notice'>[user] is distracted and fails to load ammunition into [src].</span>")
			else
				user.visible_message("<span class='notice'>[user] tries to load a ammunition into the [src] but finds there is already a magazine there.</span>", "<span class='notice'>There is already a magazine in there.</span>")

/obj/machinery/cannon/bolter/verb/pack()
	set name = "Pack Heavy Bolter"
	set desc = "Pack the heavy bolter. This will take a bit of time."
	set category = "Object"
	set src in oview(1)
	usr.visible_message("\red [usr] starts to collapse the [src]!")
	if(do_after(usr, 50))
		usr.visible_message("\red [usr] collapses the [src]!")
		new /obj/item/weapon/twohanded/required/bolterc(src.loc)
		qdel(src)
	else
		usr.visible_message("\red [usr] is distracted and fails to collapse the [src]!")
