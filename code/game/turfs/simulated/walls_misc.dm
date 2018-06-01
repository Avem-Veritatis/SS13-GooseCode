/turf/simulated/wall/cult
	name = "wall"
	desc = "The patterns engraved on the wall seem to shift as you try to focus on them. You feel sick"
	icon_state = "cult"
	walltype = "cult"

/turf/simulated/wall/polar1
	icon_state = "polar0"
	walltype = "polar"
	mineral = "silver" //A  little trick to stop smoothwall from acting up.

/turf/simulated/wall/polar2
	name = "reinforced wall"
	icon_state = "polaralt0"
	walltype = "polaralt"
	mineral = "silver"

/turf/simulated/wall/legacy_1
	icon_state = "metal0"
	walltype = "metal"

/turf/simulated/wall/legacy_1r
	icon_state = "rwall0"
	walltype = "rwall"

/turf/simulated/wall/legacy_2
	icon_state = "2iron0"
	walltype = "2iron"

/turf/simulated/wall/legacy_2r
	icon_state = "2r_iron0"
	walltype = "2r_iron"

/turf/simulated/wall/legacy_3
	icon_state = "iron0"
	walltype = "iron"

/turf/simulated/wall/legacy_3r
	icon_state = "r_iron0"
	walltype = "r_iron"

/turf/unsimulated/wall/padded
	name = "padded wall"
	icon_state = "padded"

/turf/unsimulated/wall/grid
	name = "wall"
	icon_state = "grid"

/turf/unsimulated/wall/snow
	name = "snow"
	icon_state = "snow"

/turf/unsimulated/wall/snow/New() //There shouldn't be so much of this on the map that this will be a problem.
	..()
	spawn(50)
		if(src.icon_state != "snow")  //And even if there is a lot of this, shouldn't actually rotate the ones that don't need it.
			dir = pick(1, 2, 4, 8)

/turf/unsimulated/wall/rockswall
	name = "rocks"
	icon = 'icons/obj/flora/rocks.dmi'
	icon_state = "rock"

/turf/unsimulated/wall/rockswall/New()
	..()
	if(prob(50) && icon_state == "rock")
		icon_state = "rock[pick(2, 3)]"