/turf/simulated/floor/airless
	icon_state = "floor"
	name = "airless floor"
	oxygen = 0.01
	temperature = TCMB

	New()
		..()
		name = "floor"

/turf/simulated/floor/light
	name = "Light floor"
	luminosity = 5
	icon_state = "light_on"
	floor_tile = new/obj/item/stack/tile/light

	New()
		floor_tile.New() //I guess New() isn't run on objects spawned without the definition of a turf to house them, ah well.
		var/n = name //just in case commands rename it in the ..() call
		..()
		spawn(4)
			if(src)
				update_icon()
				name = n



/turf/simulated/floor/wood
	name = "floor"
	icon_state = "wood"
	floor_tile = new/obj/item/stack/tile/wood

/turf/simulated/floor/goonplaque
	name = "Commemorative Plaque"
	icon_state = "plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."

/turf/simulated/floor/vault
	icon_state = "rockvault"

/turf/simulated/wall/vault
	icon_state = "rockvault"

/turf/simulated/floor/engine
	name = "reinforced floor"
	icon_state = "engine"
	thermal_conductivity = 0.025
	heat_capacity = 325000

/turf/simulated/floor/engine/attackby(obj/item/weapon/C as obj, mob/user as mob)
	if(!C)
		return
	if(!user)
		return
	if(istype(C, /obj/item/weapon/wrench))
		user << "\blue Removing rods..."
		playsound(src, 'sound/items/Ratchet.ogg', 80, 1)
		if(do_after(user, 30))
			new /obj/item/stack/rods(src, 2)
			ChangeTurf(/turf/simulated/floor)
			var/turf/simulated/floor/F = src
			F.make_plating()
			return

/turf/simulated/floor/engine/cult
	name = "engraved floor"
	icon_state = "cult"

/turf/simulated/floor/engine/padded
	name = "padded floor"
	icon_state = "padded"

/turf/simulated/floor/engine/n20
	New()
		..()
		var/datum/gas_mixture2/adding = new
		adding.sleepgas = 3000
		adding.temperature = T20C

		assume_air(adding)

/turf/simulated/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"
	oxygen = 0
	temperature = TCMB

/turf/simulated/floor/plating
	name = "plating"
	icon_state = "plating"
	floor_tile = null
	intact = 0

/turf/simulated/floor/plating/snowy
	icon_state = "plating2"
	floor_tile = null
	intact = 1

/turf/simulated/floor/plating/snowy/attackby(obj/item/C as obj, mob/user as mob)

	if (istype(C, /obj/item/device/allenwrench))
		user << "\blue Polishing up that floor tile..."
		playsound(src, 'sound/items/Ratchet.ogg', 50, 1) //russle sounds sounded better
		ReplaceWithTile()
		return
	return

/turf/simulated/floor/plating/airless
	icon_state = "plating"
	name = "airless plating"
	//oxygen = 0.01
	//nitrogen = 0.01
	//temperature = TCMB
	oxygen = ONE_ATMOSPHERE //Not airless!
	//nitrogen = MOLES_N2STANDARD
	temperature = T20C

	New()
		..()
		name = "plating"

/turf/simulated/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"

/turf/simulated/floor/greengrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "gcircuit"

/turf/simulated/floor/bluegrid2
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit1"
	New()
		..()
		icon_state = pick("bcircuit1", "bcircuit2", "bcircuit3")

/turf/simulated/floor/greengrid2
	icon = 'icons/turf/floors.dmi'
	icon_state = "gcircuit1"
	New()
		..()
		icon_state = pick("gcircuit1", "gcircuit2", "gcircuit3")

/turf/simulated/floor/redgrid2
	icon = 'icons/turf/floors.dmi'
	icon_state = "rcircuit1"
	New()
		..()
		icon_state = pick("rcircuit1", "rcircuit2", "rcircuit3")

/turf/simulated/shuttle
	name = "shuttle"
	icon = 'icons/turf/shuttle.dmi'
	thermal_conductivity = 0.05
	heat_capacity = 0
	layer = 2

/turf/simulated/shuttle/wall
	name = "wall"
	icon_state = "wall1"
	opacity = 1
	density = 1
	blocks_air = 1

/turf/simulated/shuttle/floor
	name = "floor"
	icon_state = "floor"

/turf/simulated/shuttle/plating
	name = "plating"
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"

/turf/simulated/shuttle/floor4 // Added this floor tile so that I have a seperate turf to check in the shuttle -- Polymorph
	name = "Brig floor"        // Also added it into the 2x3 brig area of the shuttle.
	icon_state = "floor4"

/turf/simulated/floor/beach
	name = "Beach"
	icon = 'icons/misc/beach.dmi'

/turf/simulated/floor/beach/sand
	name = "Sand"
	icon_state = "sand"

/turf/simulated/floor/beach/coastline
	name = "Coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"

/turf/simulated/floor/beach/water
	name = "Water"
	icon_state = "water"


/turf/simulated/floor/grass
	name = "Grass patch"
	icon_state = "grass1"
	floor_tile = new/obj/item/stack/tile/grass
	luminosity = 5

	New()
		floor_tile.New() //I guess New() isn't ran on objects spawned without the definition of a turf to house them, ah well.
		icon_state = "grass[pick("1","2","3","4")]"
		..()
		spawn(4)
			if(src)
				update_icon()
				for(var/direction in cardinal)
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly

/turf/simulated/floor/carpet
	name = "Carpet"
	icon_state = "carpet"
	floor_tile = new/obj/item/stack/tile/carpet

	New()
		floor_tile.New() //I guess New() isn't ran on objects spawned without the definition of a turf to house them, ah well.
		if(!icon_state)
			icon_state = "carpet"
		..()
		spawn(4)
			if(src)
				update_icon()
				for(var/direction in list(1,2,4,8,5,6,9,10))
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly



/turf/simulated/floor/plating/ironsand/New()
	..()
	name = "Iron Sand"
	icon_state = "ironsand[rand(1,15)]"



/*
Droppod stuff!
*/

/turf/simulated/floor/dropod
	name = "Drop Pod Floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "droppodcenter"


/turf/simulated/floor/plating/stone
	name = "floor"
	desc = "A stone floor."
	icon_state = "s1"
	floor_tile = null
	intact = 1

/turf/simulated/floor/plating/stone/New()
	..()
	spawn(30)
		src.icon_state = "s[rand(1, 10)]"