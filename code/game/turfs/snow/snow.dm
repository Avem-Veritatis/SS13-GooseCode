/turf/snow
	icon = 'icons/turf/snow.dmi'
	name = "\proper snow"
	icon_state = "gravsnow"
	oxygen = ONE_ATMOSPHERE
	temperature = 265
	luminosity = 15

/turf/snow/attackby(obj/item/C as obj, mob/user as mob)

	if (istype(C, /obj/item/weapon/snowshovel))
		user << "\blue Digging up some of that snow..."
		playsound(src, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better
		ReplaceWithPlating()
		return
	return

/turf/necron
	icon = 'icons/mob/tombs.dmi'
	name = "\proper floor"
	icon_state = "floor"
	oxygen = ONE_ATMOSPHERE
	temperature = 273
	//luminosity = 1

/turf/rocks
	name = "\proper rocks"
	icon_state = "rocks"
	oxygen = ONE_ATMOSPHERE
	temperature = 273
	//luminosity = 1
	var/rocky = 1

/turf/rocks/New()
	..()
	if(rocky && prob(10))
		src.overlays += image('icons/obj/flora/rocks.dmi', "floor[rand(1, 10)]")