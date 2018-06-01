/turf/sand
	icon = 'icons/turf/sand.dmi'
	name = "sand"
	icon_state = "1"
	oxygen = ONE_ATMOSPHERE
	temperature = 273
	luminosity = 1

/turf/sand/New()
	icon_state = pick("1", "2", "3", "4", "5", "6")

