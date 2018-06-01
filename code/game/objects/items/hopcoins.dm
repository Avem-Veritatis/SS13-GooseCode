/obj/item/hopcoin
	name = "Writ of Request"
	desc = "Official Seal of the Officio Administratum. Guarentees the holder special rights and privileges. Can be exchanged for goods and services."
	icon = 'icons/obj/coin.dmi'
	icon_state = "coin"
	item_state = "coin"
	w_class = 1

	New()
		..()
		pixel_x = rand(-8, 8)
		pixel_y = rand(-8, 8)

	dropped()
		var/dropsound = 'sound/items/coinflip.ogg'
		playsound(src.loc, dropsound, 50, 0)
