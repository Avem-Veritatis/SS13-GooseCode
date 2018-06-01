/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = 0 				(defaults to 1)
	music = "music/music.ogg"		(defaults to "music/music.ogg")

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/area
	var/fire = null
	var/atmos = 1
	var/atmosalm = 0
	var/poweralm = 1
	var/party = null
	level = null
	name = "Snow"
	icon = 'icons/turf/areas.dmi'
	icon_state = "snow"
	layer = 10
	mouse_opacity = 0
	invisibility = INVISIBILITY_LIGHTING
	var/lightswitch = 1

	var/eject = null

	var/requires_power = 1
	var/always_unpowered = 0	//this gets overriden to 1 for space in area/New()

	var/power_equip = 1
	var/power_light = 1
	var/power_environ = 1
	var/music = null
	var/used_equip = 0
	var/used_light = 0
	var/used_environ = 0
	var/has_gravity = 1
	var/no_air = null
	var/area/master				// master area used for power calcluations
								// (original area before splitting due to sd_DAL)
	var/list/related			// the other areas of the same type as this
//	var/list/lights				// list of all lights on this area

/*Adding a wizard area teleport list because motherfucking lag -- Urist*/
/*I am far too lazy to make it a proper list of areas so I'll just make it run the usual telepot routine at the start of the game*/
var/list/teleportlocs = list()

proc/process_teleport_locs()
	for(var/area/AR in world)
		if(istype(AR, /area/shuttle) || istype(AR, /area/syndicate_station) || istype(AR, /area/wizard_station)) continue
		if(teleportlocs.Find(AR.name)) continue
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z == 1)
			teleportlocs += AR.name
			teleportlocs[AR.name] = AR

	var/not_in_order = 0
	do
		not_in_order = 0
		if(teleportlocs.len <= 1)
			break
		for(var/i = 1, i <= (teleportlocs.len - 1), i++)
			if(sorttext(teleportlocs[i], teleportlocs[i+1]) == -1)
				teleportlocs.Swap(i, i+1)
				not_in_order = 1
	while(not_in_order)

var/list/ghostteleportlocs = list()

proc/process_ghost_teleport_locs()
	for(var/area/AR in world)
		if(ghostteleportlocs.Find(AR.name)) continue
		if(istype(AR, /area/turret_protected/aisat) || istype(AR, /area/derelict) || istype(AR, /area/tdome))
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR
		var/turf/picked = safepick(get_area_turfs(AR.type))
		if (picked && (picked.z == 1 || picked.z == 5 || picked.z == 3))
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR

	var/not_in_order = 0
	do
		not_in_order = 0
		if(ghostteleportlocs.len <= 1)
			break
		for(var/i = 1, i <= (ghostteleportlocs.len - 1), i++)
			if(sorttext(ghostteleportlocs[i], ghostteleportlocs[i+1]) == -1)
				ghostteleportlocs.Swap(i, i+1)
				not_in_order = 1
	while(not_in_order)


/*-----------------------------------------------------------------------------*/

/area/engine/


/area/cancel/
	name = "\improper CANCEL"
	icon_state = "start"


/area/turret_protected/


/area/arrival
	requires_power = 0


/area/arrival/start
	name = "\improper Arrival Area"
	icon_state = "start"


/area/admin
	name = "\improper Admin room"
	icon_state = "start"


/area/space
	requires_power = 1
	always_unpowered = 1
	lighting_use_dynamic = 0
	power_light = 0
	power_equip = 0
	power_environ = 0
	has_gravity = 0
	ambientsounds = list('sound/ambience/title2.ogg')

/area/snow

	requires_power = 1
	always_unpowered = 1
	lighting_use_dynamic = 0
	power_light = 0
	power_equip = 0
	power_environ = 0
	ambientsounds = list('sound/ambience/ambiatm1.ogg')

/area/snow/fixed


//These are shuttle areas, they must contain two areas in a subgroup if you want to move a shuttle from one
//place to another. Look at escape shuttle for example.
//All shuttles show now be under shuttle since we have smooth-wall code.

/area/shuttle //DO NOT TURN THE lighting_use_dynamic STUFF ON FOR SHUTTLES. IT BREAKS THINGS.
	requires_power = 0
	luminosity = 1
	lighting_use_dynamic = 0
	var/push_dir = SOUTH
	var/destination

/area/shuttle/arrival
	name = "\improper Arrival Shuttle"

/area/shuttle/tram
	name = "\improper Guard Tram Line"

/area/shuttle/arrival/pre_game
	icon_state = "shuttle2"
	destination = /area/shuttle/arrival/station

/area/shuttle/arrival/station
	icon_state = "shuttle"
	destination = /area/shuttle/arrival/pre_game


/area/shuttle/escape
	name = "\improper Emergency Shuttle"


/area/shuttle/escape/station
	name = "\improper Emergency Shuttle Station"
	icon_state = "shuttle2"
	destination = /area/shuttle/escape/transit


/area/shuttle/escape/centcom
	name = "\improper Emergency Shuttle Centcom"
	icon_state = "shuttle"
	destination = /area/shuttle/escape/station

/area/shuttle/escape/transit // the area to pass through for 3 minute transit
	name = "\improper Emergency Shuttle Transit"
	icon_state = "shuttle"
	destination = /area/shuttle/escape/centcom

/area/shuttle/escape_pod1
	name = "\improper Escape Pod One"

/area/shuttle/escape_pod1/station
	icon_state = "shuttle2"
	destination = /area/shuttle/escape_pod1/transit

/area/shuttle/escape_pod1/centcom
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod1/station

/area/shuttle/escape_pod1/transit
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod1/centcom


	mob_activate(var/mob/living/L)
		push_mob_back(L, push_dir)

/area/shuttle/escape_pod2
	name = "\improper Escape Pod Two"

/area/shuttle/escape_pod2/station
	icon_state = "shuttle2"
	destination = /area/shuttle/escape_pod2/transit

/area/shuttle/escape_pod2/centcom
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod2/station

/area/shuttle/escape_pod2/transit
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod2/centcom

	mob_activate(var/mob/living/L)
		push_mob_back(L, push_dir)

/area/shuttle/escape_pod3
	name = "\improper Escape Pod Three"
	push_dir = WEST

/area/shuttle/escape_pod3/station
	icon_state = "shuttle2"
	destination = /area/shuttle/escape_pod3/transit

/area/shuttle/escape_pod3/centcom
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod3/station

/area/shuttle/escape_pod3/transit
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod3/centcom

	mob_activate(var/mob/living/L)
		push_mob_back(L, push_dir)

/area/shuttle/escape_pod4 //Renaming areas 2hard
	name = "\improper Escape Pod Four"
	push_dir = WEST

/area/shuttle/escape_pod4/station
	icon_state = "shuttle2"
	destination = /area/shuttle/escape_pod4/transit

/area/shuttle/escape_pod4/centcom
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod4/station

/area/shuttle/escape_pod4/transit
	icon_state = "shuttle"
	destination = /area/shuttle/escape_pod4/centcom

	mob_activate(var/mob/living/L)
		push_mob_back(L, push_dir)

/area/shuttle/mining
	name = "\improper Mining Shuttle"


/area/shuttle/mining/station
	icon_state = "shuttle2"
	destination = /area/shuttle/mining/outpost


/area/shuttle/mining/outpost
	icon_state = "shuttle"
	destination = /area/shuttle/mining/station


/area/shuttle/laborcamp
	name = "\improper Labor Camp Shuttle"


/area/shuttle/laborcamp/station
	icon_state = "shuttle"
	destination = /area/shuttle/laborcamp/outpost


/area/shuttle/laborcamp/outpost
	icon_state = "shuttle"
	destination = /area/shuttle/laborcamp/station


/area/shuttle/transport1/centcom
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Centcom"
	destination = /area/shuttle/transport1/station


/area/shuttle/transport1/station
	icon_state = "shuttle"
	name = "\improper Transport Shuttle"
	destination = /area/shuttle/transport1/centcom


/area/shuttle/prison/
	name = "\improper Prison Shuttle"


/area/shuttle/specops/centcom
	name = "\improper Special Ops Shuttle"
	icon_state = "shuttlered"
	destination = /area/shuttle/specops/station


/area/shuttle/specops/station
	name = "\improper Special Ops Shuttle"
	icon_state = "shuttlered2"
	destination = /area/shuttle/specops/centcom


/area/shuttle/thunderdome
	name = "honk"

/*
Celeb Area
*/

/area/shuttle/celeb
	name = "\improper celeb Shuttle"

/area/shuttle/celeb/space
	name = "In space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/celeb/onplanet
	requires_power = 0

/area/shuttle/celeb/onplanet
	name = "Landed"
	icon_state = "shuttle1"
	destination = /area/shuttle/celeb/space
	requires_power = 0

/*
Shipwreck ladder teleport
*/

/area/shuttle/celeb2
	name = "\improper celeb Shuttle"

/area/shuttle/celeb2/hidden
	name = "Hidden"
	icon_state = "shuttle2"
	destination = /area/shuttle/celeb2/onplanet
	requires_power = 0

/area/shuttle/celeb2/onplanet
	name = "onplanet"
	icon_state = "shuttle1"
	destination = /area/shuttle/celeb2/hidden
	requires_power = 0

/*
SOB Area
*/

/area/centcom/sob
	name = "Order of the Sacred Rose"
	icon_state = "centcom"
	requires_power = 0


/area/shuttle/sob
	name = "\improper SOB Shuttle"

/area/shuttle/sob/sobspace
	name = "In space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/sob/sobplanet
	requires_power = 0

/area/shuttle/sob/sobplanet
	name = "Landed"
	icon_state = "shuttle1"
	destination = /area/shuttle/sob/sobspace
	requires_power = 0

/*
Chapel area
*/

/area/shuttle/preachershuttle
	name = "\improper Ecclesiarchy Shuttle"
	icon_state = "shuttle2"
	destination = /area/shuttle/preacherplanet
	requires_power = 0

/area/shuttle/preacherplanet
	name = "\improper Ecclesiarchy Shuttle"
	icon_state = "shuttle1"
	destination = /area/shuttle/preachershuttle
	requires_power = 0


/*
Mechanicus area
*/

/area/centcom/mechanicus
	name = "Engitorium"
	icon_state = "centcom"
	requires_power = 0

/area/shuttle/mechanicus
	name = "\improper Mechanicus Shuttle"
	icon_state = "shuttle2"
	destination = /area/shuttle/mechanicusplanet
	requires_power = 0

/area/shuttle/mechanicusplanet
	name = "\improper Mechanicus Shuttle"
	icon_state = "shuttle1"
	destination = /area/shuttle/mechanicus
	requires_power = 0


/*
Stargazer Area
*/

/area/shuttle/stargazer
	name = "\improper Stargazer Shuttle"

/area/shuttle/stargazer/stargazerspace
	name = "In space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/stargazer/stargazerplanet
	requires_power = 0

/area/shuttle/stargazer/stargazerplanet
	name = "Landed"
	icon_state = "shuttle1"
	destination = /area/shuttle/stargazer/stargazerspace
	requires_power = 0

/*
Ork Area
*/

/area/shuttle/ork
	name = "\improper Ork ship"

/area/shuttle/ork/orkspace
	name = "In space!"
	icon_state = "shuttle1"
	destination = /area/shuttle/ork/orkplanet
	requires_power = 0

	New()
		var/seed = rand(1, 5)
		switch(seed)
			if(1 to 2)
				destination = /area/shuttle/ork/orkplanet3
			if(1 to 2)
				destination = /area/shuttle/ork/orkplanet3
			if(2 to 4)
				destination = /area/shuttle/ork/orkplanet2
			if(2 to 4)
				destination = /area/shuttle/ork/orkplanet2
			if(4)
				destination = /area/shuttle/ork/orkplanet

/area/shuttle/ork/orkplanet
	name = "Landed"
	icon_state = "shuttle1"
	destination = /area/shuttle/ork/orkspace
	requires_power = 0

/area/shuttle/ork/orkplanet2
	name = "Landed2"
	icon_state = "shuttle1"
	destination = /area/shuttle/ork/orkspace
	requires_power = 0

/area/shuttle/ork/orkplanet3
	name = "Landed2"
	icon_state = "shuttle1"
	destination = /area/shuttle/ork/orkspace
	requires_power = 0


/*
Krieg Area
*/

/area/shuttle/DK/DK1SPACE
	name = "In Space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/DK/DK1PLANET
	requires_power = 0

/area/shuttle/DK/DK1PLANET
	name = "Arch Angel IV"
	icon_state = "shuttle1"
	destination = /area/shuttle/DK/DK1SPACE
	requires_power = 0

/area/shuttle/DK/DK2SPACE
	name = "In Space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/DK/DK2PLANET
	requires_power = 0

/area/shuttle/DK/DK2PLANET
	name = "Arch Angel IV"
	icon_state = "shuttle1"
	destination = /area/shuttle/DK/DK2SPACE
	requires_power = 0

/*
Droppod
*/

/area/shuttle/droppod/droppodspace
	name = "In Space!"
	icon_state = "shuttle2"
	destination = /area/shuttle/droppod/droppodplanet
	requires_power = 0

/area/shuttle/droppod/droppodplanet
	name = "Arch Angel IV"
	icon_state = "shuttle1"
	destination = /area/shuttle/droppod/droppodspace
	requires_power = 0

/area/droppod/dp1
	name = "Drop Pod"
	icon_state = "shuttle2"
	requires_power = 0

/area/droppod/dp2
	name = "Drop Pod"
	icon_state = "shuttle2"
	requires_power = 0



/area/start
	name = "start area"
	icon_state = "start"
	requires_power = 0
	luminosity = 1
	lighting_use_dynamic = 0


// === end remove

/area/spacecontent
	name = "space"
	has_gravity = 0

/area/snowcontent
	name = "snow"

/area/spacecontent/a1
	icon_state = "spacecontent1"

/area/spacecontent/a2
	icon_state = "spacecontent2"

/area/spacecontent/a3
	icon_state = "spacecontent3"

/area/spacecontent/a4
	icon_state = "spacecontent4"

/area/spacecontent/a5
	icon_state = "spacecontent5"

/area/spacecontent/a6
	icon_state = "spacecontent6"

/area/spacecontent/a7
	icon_state = "spacecontent7"

/area/spacecontent/a8
	icon_state = "spacecontent8"

/area/spacecontent/a9
	icon_state = "spacecontent9"

/area/spacecontent/a10
	icon_state = "spacecontent10"

/area/spacecontent/a11
	icon_state = "spacecontent11"

/area/spacecontent/a11
	icon_state = "spacecontent12"

/area/spacecontent/a12
	icon_state = "spacecontent13"

/area/spacecontent/a13
	icon_state = "spacecontent14"

/area/spacecontent/a14
	icon_state = "spacecontent14"

/area/spacecontent/a15
	icon_state = "spacecontent15"

/area/spacecontent/a16
	icon_state = "spacecontent16"

/area/spacecontent/a17
	icon_state = "spacecontent17"

/area/spacecontent/a18
	icon_state = "spacecontent18"

/area/spacecontent/a19
	icon_state = "spacecontent19"

/area/spacecontent/a20
	icon_state = "spacecontent20"

/area/spacecontent/a21
	icon_state = "spacecontent21"

/area/spacecontent/a22
	icon_state = "spacecontent22"

/area/spacecontent/a23
	icon_state = "spacecontent23"

/area/spacecontent/a24
	icon_state = "spacecontent24"

/area/spacecontent/a25
	icon_state = "spacecontent25"

/area/spacecontent/a26
	icon_state = "spacecontent26"

/area/spacecontent/a27
	icon_state = "spacecontent27"

/area/spacecontent/a28
	icon_state = "spacecontent28"

/area/spacecontent/a29
	icon_state = "spacecontent29"

/area/spacecontent/a30
	icon_state = "spacecontent30"

/area/awaycontent
	name = "space"

/area/awaycontent/a1
	icon_state = "awaycontent1"

/area/awaycontent/a2
	icon_state = "awaycontent2"

/area/awaycontent/a3
	icon_state = "awaycontent3"

/area/awaycontent/a4
	icon_state = "awaycontent4"

/area/awaycontent/a5
	icon_state = "awaycontent5"

/area/awaycontent/a6
	icon_state = "awaycontent6"

/area/awaycontent/a7
	icon_state = "awaycontent7"

/area/awaycontent/a8
	icon_state = "awaycontent8"

/area/awaycontent/a9
	icon_state = "awaycontent9"

/area/awaycontent/a10
	icon_state = "awaycontent10"

/area/awaycontent/a11
	icon_state = "awaycontent11"

/area/awaycontent/a11
	icon_state = "awaycontent12"

/area/awaycontent/a12
	icon_state = "awaycontent13"

/area/awaycontent/a13
	icon_state = "awaycontent14"

/area/awaycontent/a14
	icon_state = "awaycontent14"

/area/awaycontent/a15
	icon_state = "awaycontent15"

/area/awaycontent/a16
	icon_state = "awaycontent16"

/area/awaycontent/a17
	icon_state = "awaycontent17"

/area/awaycontent/a18
	icon_state = "awaycontent18"

/area/awaycontent/a19
	icon_state = "awaycontent19"

/area/awaycontent/a20
	icon_state = "awaycontent20"

/area/awaycontent/a21
	icon_state = "awaycontent21"

/area/awaycontent/a22
	icon_state = "awaycontent22"

/area/awaycontent/a23
	icon_state = "awaycontent23"

/area/awaycontent/a24
	icon_state = "awaycontent24"

/area/awaycontent/a25
	icon_state = "awaycontent25"

/area/awaycontent/a26
	icon_state = "awaycontent26"

/area/awaycontent/a27
	icon_state = "awaycontent27"

/area/awaycontent/a28
	icon_state = "awaycontent28"

/area/awaycontent/a29
	icon_state = "awaycontent29"

/area/awaycontent/a30
	icon_state = "awaycontent30"

// CENTCOM

/area/centcom
	name = "\improper Centcom"
	icon_state = "centcom"
	requires_power = 0


/area/centcom/control
	name = "\improper Centcom Docks"

/area/centcom/evac
	name = "\improper Centcom Emergency Shuttle"

/area/centcom/suppy
	name = "\improper Centcom Supply Shuttle"

/area/centcom/ferry
	name = "\improper Centcom Transport Shuttle"

/area/centcom/prison
	name = "\improper Admin Prison"

/area/centcom/holding
	name = "\improper Holding Facility"

/area/centcom/transportONE
	name = "\improper High Orbit. ArchAngel IV"
	icon_state = "AAStarter"

/area/centcom/transportTWO
	name = "\improper High Orbit. ArchAngel IV"
	icon_state = "AAStarter"

/area/centcom/transportTHREE
	name = "\improper High Orbit. ArchAngel IV"
	icon_state = "AAStarter"

/area/centcom/transportFOUR
	name = "\improper High Orbit. ArchAngel IV"
	icon_state = "AAStarter"

//SYNDICATES

/area/syndicate_mothership
	name = "\improper Syndicate Mothership"
	icon_state = "syndie-ship"
	requires_power = 0


/area/syndicate_mothership/control
	name = "\improper Syndicate Control Room"
	icon_state = "syndie-control"

/area/syndicate_mothership/elite_squad
	name = "\improper Syndicate Elite Squad"
	icon_state = "syndie-elite"

//EXTRA

/area/asteroid
	name = "\improper Asteroid"
	icon_state = "asteroid"
	requires_power = 0


/area/asteroid/cave
	name = "\improper Asteroid - Underground"
	icon_state = "cave"
	requires_power = 0

/area/asteroid/artifactroom
	name = "\improper Asteroid - Artifact"
	icon_state = "cave"

/area/asteroid/artifactroom/New()
	..()
	lighting_use_dynamic = 1
	InitializeLighting()

/area/planet/clown
	name = "\improper Clown Planet"
	icon_state = "honk"
	requires_power = 0


/area/telesciareas
	name = "\improper Cosmic Anomaly"
	icon_state = "telesci"
	requires_power = 0

/area/tdome
	name = "\improper Thunderdome"
	icon_state = "thunder"
	requires_power = 0


/area/tdome/tdome1
	name = "\improper Thunderdome (Team 1)"
	icon_state = "green"

/area/tdome/tdome2
	name = "\improper Thunderdome (Team 2)"
	icon_state = "yellow"

/area/tdome/tdomeadmin
	name = "\improper Thunderdome (Admin.)"
	icon_state = "purple"

/area/tdome/tdomeobserve
	name = "\improper Thunderdome (Observer.)"
	icon_state = "purple"

//Ork

/area/ork
	name = "orkland"
	desc = "This is orkland one! Or maybe two! So hard to keep them straight."
	icon_state = "ork"


/area/syndicate_station
	name = "\improper Syndicate Station"
	icon_state = "yellow"
	requires_power = 0

/area/syndicate_station/start
	name = "\improper Syndicate Forward Operating Base"
	icon_state = "yellow"


/area/syndicate_station/southwest
	name = "\improper south-west of SS13"
	icon_state = "southwest"

/area/syndicate_station/northwest
	name = "\improper north-west of SS13"
	icon_state = "northwest"

/area/syndicate_station/northeast
	name = "\improper north-east of SS13"
	icon_state = "northeast"

/area/syndicate_station/southeast
	name = "\improper south-east of SS13"
	icon_state = "southeast"

/area/syndicate_station/north
	name = "\improper north of SS13"
	icon_state = "north"

/area/syndicate_station/south
	name = "\improper south of SS13"
	icon_state = "south"

/area/syndicate_station/commssat
	name = "\improper south of the communication satellite"
	icon_state = "south"

/area/syndicate_station/mining
	name = "\improper north east of the mining asteroid"
	icon_state = "north"

/area/syndicate_station/transit
	name = "\improper hyperspace"
	icon_state = "shuttle"

/area/wizard_station
	name = "\improper Wizard's Den"
	icon_state = "yellow"
	requires_power = 0







//PRISON
/area/prison
	name = "\improper Prison Station"
	icon_state = "brig"

/area/prison/arrival_airlock
	name = "\improper Prison Station Airlock"
	icon_state = "green"
	requires_power = 0

/area/prison/control
	name = "\improper Prison Security Checkpoint"
	icon_state = "security"

/area/prison/crew_quarters
	name = "\improper Prison Security Quarters"
	icon_state = "security"

/area/prison/rec_room
	name = "\improper Prison Rec Room"
	icon_state = "green"

/area/prison/closet
	name = "\improper Prison Supply Closet"
	icon_state = "dk_yellow"

/area/prison/hallway/fore
	name = "\improper Prison Fore Hallway"
	icon_state = "yellow"

/area/prison/hallway/aft
	name = "\improper Prison Aft Hallway"
	icon_state = "yellow"

/area/prison/hallway/port
	name = "\improper Prison Port Hallway"
	icon_state = "yellow"

/area/prison/hallway/starboard
	name = "\improper Prison Starboard Hallway"
	icon_state = "yellow"

/area/prison/morgue
	name = "\improper Prison Morgue"
	icon_state = "morgue"

/area/prison/medical_research
	name = "\improper Prison Genetic Research"
	icon_state = "medresearch"

/area/prison/medical
	name = "\improper Prison Medbay"
	icon_state = "medbay"

/area/prison/solar
	name = "\improper Prison Solar Array"
	icon_state = "storage"
	requires_power = 0

/area/prison/podbay
	name = "\improper Prison Podbay"
	icon_state = "dk_yellow"

/area/prison/solar_control
	name = "\improper Prison Solar Array Control"
	icon_state = "dk_yellow"

/area/prison/solitary
	name = "Solitary Confinement"
	icon_state = "brig"

/area/prison/cell_block/A
	name = "Prison Cell Block A"
	icon_state = "brig"

/area/prison/cell_block/B
	name = "Prison Cell Block B"
	icon_state = "brig"

/area/prison/cell_block/C
	name = "Prison Cell Block C"
	icon_state = "brig"

//STATION13

/area/atmos
 	name = "Atmospherics"
 	icon_state = "atmos"

//Maintenance

/area/maintenance/undermaint
	name = "Under Maintenance"
	icon_state = "under"
	requires_power = 0
	luminosity = 1
	lighting_use_dynamic = 0

/area/maintenance/safe
	name = "Safehouse"
	icon_state = "safe"

/area/maintenance/atmos_control
	name = "Atmospherics Maintenance"
	icon_state = "fpmaint"


/area/maintenance/fpmaint
	name = "EVA Maintenance"
	icon_state = "fpmaint"


/area/maintenance/fpmaint2
	name = "Arrivals North Maintenance"
	icon_state = "fpmaint"


/area/maintenance/fsmaint
	name = "Dormitory Maintenance"
	icon_state = "fsmaint"


/area/maintenance/fsmaint2
	name = "Bar Maintenance"
	icon_state = "fsmaint"


/area/maintenance/asmaint
	name = "Medbay Maintenance"
	icon_state = "asmaint"


/area/maintenance/asmaint2
	name = "Science Maintenance"
	icon_state = "asmaint"


/area/maintenance/apmaint
	name = "Cargo Maintenance"
	icon_state = "apmaint"


/area/maintenance/maintcentral
	name = "Bridge Maintenance"
	icon_state = "maintcentral"


/area/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "fmaint"


/area/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "smaint"


/area/maintenance/port
	name = "Locker Room Maintenance"
	icon_state = "pmaint"


/area/maintenance/aft
	name = "Engineering Maintenance"
	icon_state = "amaint"


/area/maintenance/storage
	name = "Atmospherics"
	icon_state = "green"


/area/maintenance/incinerator
	name = "\improper Incinerator"
	icon_state = "disposal"


/area/maintenance/disposal
	name = "Waste Disposal"
	icon_state = "disposal"

/area/maintenance/electrical
	name = "Electrical Maintenance"
	icon_state = "yellow"


//Hallway

/area/hallway/primary/fore
	name = "\improper Fore Primary Hallway"
	icon_state = "hallF"


/area/hallway/primary/starboard
	name = "\improper Starboard Primary Hallway"
	icon_state = "hallS"


/area/hallway/primary/aft
	name = "\improper Aft Primary Hallway"
	icon_state = "hallA"


/area/hallway/primary/port
	name = "\improper Port Primary Hallway"
	icon_state = "hallP"


/area/hallway/primary/central
	name = "\improper Central Primary Hallway"
	icon_state = "hallC"


/area/hallway/secondary/exit
	name = "\improper Escape Shuttle Hallway"
	icon_state = "escape"

/area/hallway/secondary/construction
	name = "\improper Construction Area"
	icon_state = "construction"


/area/hallway/secondary/entry
	name = "\improper Arrival Shuttle Hallway"
	icon_state = "entry"


//Command

/area/bridge
	name = "\improper Bridge"
	icon_state = "bridge"
	music = "signal"


/area/bridge/meeting_room
	name = "\improper Heads of Staff Meeting Room"
	icon_state = "meeting"
	music = null

/area/crew_quarters
	name = "\improper root for crew_quarters"


/area/crew_quarters/captain
	name = "\improper Captain's Office"
	icon_state = "captain"

/area/crew_quarters/courtroom
	name = "\improper Courtroom"
	icon_state = "courtroom"

/area/crew_quarters/heads
	name = "\improper Seneschal's Office"
	icon_state = "head_quarters"

/area/crew_quarters/hor
	name = "\improper Research Director's Office"
	icon_state = "head_quarters"

/area/crew_quarters/chief
	name = "\improper Chief Engineer's Office"
	icon_state = "head_quarters"

/area/mint
	name = "\improper Mint"
	icon_state = "green"


/area/comms
	name = "\improper Communications Relay"
	icon_state = "tcomsatcham"


/area/server
	name = "\improper Messaging Server Room"
	icon_state = "server"


//Crew

/area/crew_quarters
	name = "\improper Dormitories"
	icon_state = "Sleep"

/area/crew_quarters/toilet
	name = "\improper Dormitory Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep
	name = "\improper Dormitories"
	icon_state = "Sleep"

/area/crew_quarters/sleep_male
	name = "\improper Male Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_male/toilet_male
	name = "\improper Male Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep_female
	name = "\improper Female Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_female/toilet_female
	name = "\improper Female Toilets"
	icon_state = "toilet"

/area/crew_quarters/locker
	name = "\improper Locker Room"
	icon_state = "locker"

/area/crew_quarters/locker/locker_toilet
	name = "\improper Locker Toilets"
	icon_state = "toilet"

/area/crew_quarters/fitness
	name = "\improper Fitness Room"
	icon_state = "fitness"

/area/crew_quarters/cafeteria
	name = "\improper Cafeteria"
	icon_state = "cafeteria"

/area/crew_quarters/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

/area/crew_quarters/bar
	name = "\improper Bar"
	icon_state = "bar"

/area/crew_quarters/theatre
	name = "\improper Theatre"
	icon_state = "Theatre"

/area/library
 	name = "\improper Library"
 	icon_state = "library"

/area/chapel/main
	name = "\improper Chapel"
	icon_state = "chapel"
	ambientsounds = list('sound/ambience/ambicha4.ogg')


/area/chapel/office
	name = "\improper Chapel Office"
	icon_state = "chapeloffice"


/area/lawoffice
	name = "\improper Law Office"
	icon_state = "law"







/area/holodeck
	name = "\improper Holodeck"
	icon_state = "Holodeck"
	luminosity = 1
	lighting_use_dynamic = 0


/area/holodeck/alphadeck
	name = "\improper Holodeck Alpha"

/area/holodeck/source_plating
	name = "\improper Holodeck - Off"
	icon_state = "Holodeck"

/area/holodeck/source_emptycourt
	name = "\improper Holodeck - Empty Court"

/area/holodeck/source_boxingcourt
	name = "\improper Holodeck - Boxing Court"

/area/holodeck/source_basketball
	name = "\improper Holodeck - Basketball Court"

/area/holodeck/source_thunderdomecourt
	name = "\improper Holodeck - Thunderdome Court"

/area/holodeck/source_beach
	name = "\improper Holodeck - Beach"
	icon_state = "Holodeck" // Lazy.

/area/holodeck/source_burntest
	name = "\improper Holodeck - Atmospheric Burn Test"

/area/holodeck/source_wildlife
	name = "\improper Holodeck - Wildlife Simulation"


//Factions

/area/factions
	name = "A strange place"
	icon_state = "away"
	requires_power = 0

/area/factions/deathkorps
	name = "Imperial Escort 'Regentropfen'"
	icon_state = "DK"

/area/factions/stargazer
	name = "Imperial Cruiser 'Stargazer'"
	icon_state = "SG"



//Engineering

/area/engine


/area/engine/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"
	requires_power = 0//This area only covers the batteries and they deal with their own power

/area/engine/engineering
	name = "Engineering"
	icon_state = "engine_smes"

/area/engine/break_room
	name = "\improper Engineering Foyer"
	icon_state = "engine"

/area/engine/chiefs_office
	name = "\improper Chief Engineer's office"
	icon_state = "engine_control"

/area/engine/secure_construction
	name = "\improper Secure Construction Area"
	icon_state = "engine"

/area/engine/gravity_generator
	name = "Gravity Generator Room"
	icon_state = "blue"


//Solars

/area/solar
	requires_power = 0
	luminosity = 1
	lighting_use_dynamic = 0


	auxport
		name = "\improper Fore Port Solar Array"
		icon_state = "panelsA"

	auxstarboard
		name = "\improper Fore Starboard Solar Array"
		icon_state = "panelsA"

	fore
		name = "\improper Fore Solar Array"
		icon_state = "yellow"

	aft
		name = "\improper Aft Solar Array"
		icon_state = "aft"

	starboard
		name = "\improper Aft Starboard Solar Array"
		icon_state = "panelsS"

	port
		name = "\improper Aft Port Solar Array"
		icon_state = "panelsP"

/area/maintenance/auxsolarport
	name = "Fore Port Solar Maintenance"
	icon_state = "SolarcontrolA"


/area/maintenance/starboardsolar
	name = "Aft Starboard Solar Maintenance"
	icon_state = "SolarcontrolS"


/area/maintenance/portsolar
	name = "Aft Port Solar Maintenance"
	icon_state = "SolarcontrolP"


/area/maintenance/auxsolarstarboard
	name = "Fore Starboard Solar Maintenance"
	icon_state = "SolarcontrolA"


/area/assembly/chargebay
	name = "\improper Mech Bay"
	icon_state = "mechbay"


/area/assembly/showroom
	name = "\improper Robotics Showroom"
	icon_state = "showroom"


/area/assembly/robotics
	name = "\improper Robotics Lab"
	icon_state = "ass_line"


/area/assembly/assembly_line //Derelict Assembly Line
	name = "\improper Assembly Line"
	icon_state = "ass_line"
	power_equip = 0
	power_light = 0
	power_environ = 0


//Teleporter

/area/teleporter
	name = "\improper Teleporter"
	icon_state = "teleporter"
	music = "signal"


/area/gateway
	name = "\improper Gateway"
	icon_state = "teleporter"
	music = "signal"


/area/AIsattele
	name = "\improper AI Satellite Teleporter Room"
	icon_state = "teleporter"
	music = "signal"


//MedBay

/area/medical/medbay
	name = "Medbay"
	icon_state = "medbay"

//Medbay is a large area, these additional areas help level out APC load.
/area/medical/medbay2
	name = "Medbay"
	icon_state = "medbay2"


/area/medical/medbay3
	name = "Medbay"
	icon_state = "medbay3"


/area/medical/patients_rooms
	name = "\improper Patient's Rooms"
	icon_state = "patients"


/area/medical/cmo
	name = "\improper Chief Medical Officer's office"
	icon_state = "CMO"


/area/medical/robotics
	name = "Robotics"
	icon_state = "medresearch"


/area/medical/research
	name = "Medical Research"
	icon_state = "medresearch"


/area/medical/virology
	name = "Virology"
	icon_state = "virology"


/area/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"


/area/medical/chemistry
	name = "Chemistry"
	icon_state = "chem"


/area/medical/surgery
	name = "Surgery"
	icon_state = "surgery"


/area/medical/cryo
	name = "Cryogenics"
	icon_state = "cryo"


/area/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"


/area/medical/genetics
	name = "Genetics Lab"
	icon_state = "genetics"


/area/medical/genetics_cloning
	name = "Cloning Lab"
	icon_state = "cloning"


/area/medical/sleeper
	name = "Medbay Treatment Center"
	icon_state = "exam_room"


//Security


/area/security/main
	name = "\improper Security Office"
	icon_state = "security"


/area/security/brig
	name = "\improper Brig"
	icon_state = "brig"


/area/security/prison
	name = "\improper Prison Wing"
	icon_state = "sec_prison"


/area/security/processing
	name = "\improper Labor Shuttle Dock"
	icon_state = "sec_prison"


/area/security/warden
	name = "\improper Brig Control"
	icon_state = "Warden"


/area/security/armory
	name = "\improper Armory"
	icon_state = "armory"


/area/security/hos
	name = "\improper Head of Security's Office"
	icon_state = "sec_hos"


/area/security/detectives_office
	name = "\improper Detective's Office"
	icon_state = "detective"


/area/security/range
	name = "\improper Firing Range"
	icon_state = "firingrange"

/*
	New()
		..()

		spawn(10) //let objects set up first
			for(var/turf/turfToGrayscale in src)
				if(turfToGrayscale.icon)
					var/icon/newIcon = icon(turfToGrayscale.icon)
					newIcon.GrayScale()
					turfToGrayscale.icon = newIcon
				for(var/obj/objectToGrayscale in turfToGrayscale) //1 level deep, means tables, apcs, locker, etc, but not locker contents
					if(objectToGrayscale.icon)
						var/icon/newIcon = icon(objectToGrayscale.icon)
						newIcon.GrayScale()
						objectToGrayscale.icon = newIcon
*/

/area/ai_monitored/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"


/area/ai_monitored/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"


/area/security/checkpoint
	name = "\improper Security Checkpoint"
	icon_state = "checkpoint1"


/area/security/checkpoint2
	name = "\improper Security Checkpoint"
	icon_state = "security"


/area/security/checkpoint/supply
	name = "Security Post - Cargo Bay"
	icon_state = "checkpoint1"


/area/security/checkpoint/engineering
	name = "Security Post - Engineering"
	icon_state = "checkpoint1"


/area/security/checkpoint/medical
	name = "Security Post - Medbay"
	icon_state = "checkpoint1"

/area/security/checkpoint/science
	name = "Security Post - Science"
	icon_state = "checkpoint1"


/area/security/vacantoffice
	name = "\improper Vacant Office"
	icon_state = "security"


/area/quartermaster
	name = "\improper Quartermasters"
	icon_state = "quart"


///////////WORK IN PROGRESS//////////

/area/quartermaster/sorting
	name = "\improper Delivery Office"
	icon_state = "quartstorage"


////////////WORK IN PROGRESS//////////

/area/quartermaster/office
	name = "\improper Cargo Office"
	icon_state = "quartoffice"


/area/quartermaster/storage
	name = "\improper Cargo Bay"
	icon_state = "quartstorage"


/area/quartermaster/qm
	name = "\improper Quartermaster's Office"
	icon_state = "quart"


/area/quartermaster/miningdock
	name = "\improper Mining Dock"
	icon_state = "mining"


/area/quartermaster/miningstorage
	name = "\improper Mining Storage"
	icon_state = "green"


/area/quartermaster/mechbay
	name = "\improper Mech Bay"
	icon_state = "yellow"


/area/janitor/
	name = "\improper Custodial Closet"
	icon_state = "janitor"


/area/hydroponics
	name = "Hydroponics"
	icon_state = "hydro"


//Toxins

/area/toxins/lab
	name = "\improper Research and Development"
	icon_state = "toxlab"


/area/toxins/xenobiology
	name = "\improper Xenobiology Lab"
	icon_state = "toxlab"


/area/toxins/storage
	name = "\improper Toxins Storage"
	icon_state = "toxstorage"


/area/toxins/mineral_storeroom
	name = "\improper Mineral Storeroom"
	icon_state = "toxmisc"


/area/toxins/test_area
	name = "\improper Toxins Test Area"
	icon_state = "toxtest"


/area/toxins/mixing
	name = "\improper Toxins Mixing Room"
	icon_state = "toxmix"


/area/toxins/misc_lab
	name = "\improper Testing Lab"
	icon_state = "toxmisc"


/area/toxins/server
	name = "\improper Server Room"
	icon_state = "server"


/area/toxins/telesci
	name = "\improper Telescience Lab"
	icon_state = "toxtest"


//Storage

/area/storage/tools
	name = "Auxiliary Tool Storage"
	icon_state = "storage"


/area/storage/primary
	name = "Primary Tool Storage"
	icon_state = "primarystorage"


/area/storage/autolathe
	name = "Autolathe Storage"
	icon_state = "storage"


/area/storage/art
	name = "Art Supply Storage"
	icon_state = "storage"


/area/storage/auxillary
	name = "Auxillary Storage"
	icon_state = "auxstorage"


/area/storage/eva
	name = "EVA Storage"
	icon_state = "eva"


/area/storage/secure
	name = "Secure Storage"
	icon_state = "storage"


/area/storage/emergency
	name = "Starboard Emergency Storage"
	icon_state = "emergencystorage"


/area/storage/emergency2
	name = "Port Emergency Storage"
	icon_state = "emergencystorage"


/area/storage/tech
	name = "Technical Storage"
	icon_state = "auxstorage"


/area/storage/testroom
	requires_power = 0
	name = "\improper Test Room"
	icon_state = "storage"


//DJSTATION

/area/djstation
	name = "\improper Ruskie DJ Station"
	icon_state = "DJ"


/area/djstation/solars
	name = "\improper DJ Station Solars"
	icon_state = "DJ"


//DERELICT

/area/derelict
	name = "\improper Derelict Station"
	icon_state = "storage"

/area/derelict/hallway/primary
	name = "\improper Derelict Primary Hallway"
	icon_state = "hallP"

/area/derelict/hallway/secondary
	name = "\improper Derelict Secondary Hallway"
	icon_state = "hallS"

/area/derelict/arrival
	name = "\improper Derelict Arrival Centre"
	icon_state = "yellow"

/area/derelict/storage/equipment
	name = "Derelict Equipment Storage"

/area/derelict/storage/storage_access
	name = "Derelict Storage Access"

/area/derelict/storage/engine_storage
	name = "Derelict Engine Storage"
	icon_state = "green"

/area/derelict/bridge
	name = "\improper Derelict Control Room"
	icon_state = "bridge"

/area/derelict/secret
	name = "\improper Derelict Secret Room"
	icon_state = "library"

/area/derelict/bridge/access
	name = "Derelict Control Room Access"
	icon_state = "auxstorage"

/area/derelict/bridge/ai_upload
	name = "\improper Derelict Computer Core"
	icon_state = "ai"

/area/derelict/solar_control
	name = "\improper Derelict Solar Control"
	icon_state = "engine"

/area/derelict/crew_quarters
	name = "\improper Derelict Crew Quarters"
	icon_state = "fitness"

/area/derelict/medical
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/derelict/medical/morgue
	name = "\improper Derelict Morgue"
	icon_state = "morgue"

/area/derelict/medical/chapel
	name = "\improper Derelict Chapel"
	icon_state = "chapel"

/area/derelict/teleporter
	name = "\improper Derelict Teleporter"
	icon_state = "teleporter"

/area/derelict/eva
	name = "Derelict EVA Storage"
	icon_state = "eva"

/area/derelict/ship
	name = "\improper Abandoned Ship"
	icon_state = "yellow"

/area/solar/derelict_starboard
	name = "\improper Derelict Starboard Solar Array"
	icon_state = "panelsS"

/area/solar/derelict_aft
	name = "\improper Derelict Aft Solar Array"
	icon_state = "aft"

/area/derelict/singularity_engine
	name = "\improper Derelict Singularity Engine"
	icon_state = "engine"

//Construction

/area/construction
	name = "\improper Construction Area"
	icon_state = "yellow"


/area/construction/supplyshuttle
	name = "\improper Supply Shuttle"
	icon_state = "yellow"

/area/construction/quarters
	name = "\improper Engineer's Quarters"
	icon_state = "yellow"

/area/construction/qmaint
	name = "Maintenance"
	icon_state = "yellow"

/area/construction/hallway
	name = "\improper Hallway"
	icon_state = "yellow"

/area/construction/solars
	name = "\improper Solar Panels"
	icon_state = "yellow"

/area/construction/solarscontrol
	name = "\improper Solar Panel Control"
	icon_state = "yellow"

/area/construction/Storage
	name = "Construction Site Storage"
	icon_state = "yellow"

//AI
/area/ai_monitored/security/armory
	name = "\improper Armory"
	icon_state = "armory"


/area/ai_monitored/storage/eva
	name = "EVA Storage"
	icon_state = "eva"


/area/ai_monitored/storage/secure
	name = "Secure Storage"
	icon_state = "storage"


/area/ai_monitored/storage/emergency
	name = "Emergency Storage"
	icon_state = "storage"



/area/turret_protected/


/area/turret_protected/ai_upload
	name = "\improper AI Upload Chamber"
	icon_state = "ai_upload"

/area/turret_protected/ai_upload_foyer
	name = "AI Upload Access"
	icon_state = "ai_foyer"

/area/turret_protected/ai
	name = "\improper AI Chamber"
	icon_state = "ai_chamber"

/area/turret_protected/aisat
	name = "\improper AI Satellite"
	icon_state = "ai"

/area/aisat
	name = "\improper AI Satellite Exterior"
	icon_state = "storage"


/area/turret_protected/aisat_interior
	name = "\improper AI Satellite Antechamber"
	icon_state = "ai"

/area/turret_protected/AIsatextFP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextFS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextAS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextAP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/NewAIMain
	name = "\improper AI Main New"
	icon_state = "storage"



//Misc



/area/wreck/ai
	name = "\improper AI Chamber"
	icon_state = "ai"


/area/wreck/main
	name = "\improper Wreck"
	icon_state = "storage"


/area/wreck/engineering
	name = "\improper Power Room"
	icon_state = "engine"


/area/wreck/bridge
	name = "\improper Bridge"
	icon_state = "bridge"


/area/generic
	name = "Unknown"
	icon_state = "storage"

// Telecommunications Satellite

/area/tcommsat



/area/tcommsat/entrance
	name = "\improper Telecoms Teleporter"
	icon_state = "tcomsatentrance"


/area/tcommsat/chamber
	name = "\improper Abandoned Satellite"
	icon_state = "tcomsatcham"


/area/turret_protected/tcomsat
	name = "\improper Telecoms Satellite"
	icon_state = "tcomsatlob"



/area/turret_protected/tcomfoyer
	name = "\improper Telecoms Foyer"
	icon_state = "tcomsatentrance"



/area/turret_protected/tcomwest
	name = "\improper Telecommunications Satellite West Wing"
	icon_state = "tcomsatwest"



/area/turret_protected/tcomeast
	name = "\improper Telecommunications Satellite East Wing"
	icon_state = "tcomsateast"



/area/tcommsat/computer
	name = "\improper Telecoms Control Room"
	icon_state = "tcomsatcomp"


/area/tcommsat/server
	name = "\improper Telecoms Server Room"
	icon_state = "tcomsatcham"


/area/tcommsat/lounge
	name = "\improper Telecommunications Satellite Lounge"
	icon_state = "tcomsatlounge"



// Away Missions
/area/awaymission
	name = "\improper Strange Location"
	icon_state = "away"


/area/awaymission/example
	name = "\improper Strange Station"
	icon_state = "away"

/area/awaymission/desert
	name = "Mars"
	icon_state = "away"

/area/awaymission/listeningpost
	name = "\improper Listening Post"
	icon_state = "away"
	requires_power = 0

/area/awaymission/beach
	name = "Beach"
	icon_state = "null"
	luminosity = 1
	lighting_use_dynamic = 0
	requires_power = 0


/////////////////////////////////////////////////////////////////////
/*
 Lists of areas to be used with is_type_in_list.
 Used in gamemodes code at the moment. --rastaf0
*/

// CENTCOM
var/list/centcom_areas = list(
	/area/centcom,
	/area/shuttle/escape/centcom,
	/area/shuttle/escape_pod1/centcom,
	/area/shuttle/escape_pod2/centcom,
	/area/shuttle/escape_pod3/centcom,
	/area/shuttle/escape_pod4/centcom,
	/area/shuttle/transport1/centcom,
	/area/shuttle/specops/centcom,
)

//SPACE STATION 13
var/list/the_station_areas = list(
	/area/shuttle/arrival,
	/area/shuttle/escape/station,
	/area/shuttle/escape_pod1/station,
	/area/shuttle/escape_pod2/station,
	/area/shuttle/escape_pod3/station,
	/area/shuttle/escape_pod4/station,
	/area/shuttle/mining/station,
	/area/shuttle/transport1/station,
//	/area/shuttle/transport2/station,	//not present on map
	/area/shuttle/specops/station,
	/area/atmos,
	/area/cancel,
	/area/maintenance,
	/area/hallway,
	/area/bridge,
	/area/crew_quarters,
	/area/holodeck,
//	/area/mint,		//not present on map
	/area/library,
	/area/chapel,
	/area/lawoffice,
	/area/engine,
	/area/solar,
	/area/assembly,
	/area/teleporter,
	/area/medical,
	/area/security,
	/area/quartermaster,
	/area/janitor,
	/area/hydroponics,
	/area/toxins,
	/area/storage,
	/area/construction,
	/area/ai_monitored/storage/eva, //do not try to simplify to "/area/ai_monitored" --rastaf0
//	/area/ai_monitored/storage/secure,	//not present on map
//	/area/ai_monitored/storage/emergency,	//not present on map
	/area/turret_protected/ai_upload, //do not try to simplify to "/area/turret_protected" --rastaf0
	/area/turret_protected/ai_upload_foyer,
	/area/turret_protected/ai,
)
