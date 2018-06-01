/obj/effect/landmark/supplydropsegmentum
	name = "Supply Drop Segmentum"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/supplypoint
	name = "Supply Point"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/baneblade
	name = "Baneblade Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/supplycommandstart
	name = "Supply Commmand Center"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/fake_floor/supplydrop
	icon_state = "supplydrop"

/obj/effect/fake_floor/supplydrop/ex_act()
	return

/obj/effect/fake_floor/fake_wall/r_wall/supplydrop
	name = "wall"
	icon_state = "polar0"
	base_icon_state = "polar"

/obj/effect/fake_floor/fake_wall/r_wall/supplydrop/ex_act()
	return

/datum/supplydroppack
	var/name = "Empty Drop"
	var/id = "error"
	var/cost = 0

/datum/supplydroppack/proc/add_equipment(var/turf/T)
	return

/datum/supplydropcontroller
	var/points = 2000
	var/datum/fake_area/dropshuttle
	var/centcomm = 1
	var/list/packs = list()
	var/reinforcements_cooldown = 0
	var/baneblade_deployed = 0

/datum/supplydropcontroller/proc/process_points()
	spawn(0)
		set background = BACKGROUND_ENABLED
		while(1)
			points += 5
			if(reinforcements_cooldown)
				reinforcements_cooldown --
			sleep(30)

/datum/supplydropcontroller/New()
	..()
	spawn(0)
		while(!ticker) //Make sure everything is in place before we set up this controller.
			sleep(100)   //Probably a better way to make this controller but I haven't looked over how the rest of the controllers are done.
		spawn(100)
			dropshuttle = new /datum/fake_area()
			for(var/obj/effect/fake_floor/supplydrop/S in world) //Why isn't this including all the turfs... This is very similar to what the guard tram does...
				dropshuttle.add_turf(S)
			for(var/obj/effect/fake_floor/fake_wall/r_wall/supplydrop/SW in world)
				dropshuttle.add_turf(SW)
		spawn(100)
			for(var/packtype in typesof(/datum/supplydroppack))
				packs.Add(new packtype())
		spawn(100)
			process_points()
	return

var/global/datum/supplydropcontroller/supplydropcontroller = new()

/obj/machinery/computer/supplydrop
	name = "Crisis Support Terminal"
	desc = "This terminal is your one and only hope when a crisis is declared. Through this you may call down support, reinforcements, and all kinds of weapon. The emperor protects!"
	icon_state = "supplydrop"
	icon = 'icons/obj/computerlarge.dmi'
	density = 1
	anchored = 1
	pixel_x = -4
	active_power_usage = 0
	idle_power_usage = 0

/obj/machinery/computer/supplydrop/process()
	if(stat & BROKEN)
		return 0
	return 1

/obj/machinery/computer/supplydrop/emp_act(severity)
	return

/obj/machinery/computer/supplydrop/ex_act(severity)
	src.stat &= BROKEN
	if(severity <= 2)
		qdel(src)
	return

/obj/machinery/computer/supplydrop/attack_hand(mob/user as mob)  //Hexing out due to crashes caused by line 130.
	user.set_machine(src)
	var/dat = "<B>Crisis Support Terminal:</B><BR><BR>"
	dat += "Available Support Points: [supplydropcontroller.points]<BR><BR>"
	if(supplydropcontroller.centcomm)
		dat += "Supply Drop Shuttle Ready<BR><BR>"
	else
		dat += "<A href='byond://?src=\ref[src];transit=1'>Send Supply Drop Shuttle Away</A><BR><BR>"
	dat += "<B>Support</B><BR>"
	dat += "<A href='byond://?src=\ref[src];guards=1'>Imperial Guard Squad Reinforcements (200)</A><BR><BR>"
	dat += "<A href='byond://?src=\ref[src];airstrike=1'>Airstrike (250)</A><BR><BR>"
	dat += "<A href='byond://?src=\ref[src];fortress=1'>Auxillary Command Center Drop (500)</A><BR><BR>"
	dat += "<A href='byond://?src=\ref[src];baneblade=1'>Baneblade Heavy Tank (1500)</A><BR><BR>"
	dat += "<B>Munitions</B><BR>"
	for(var/datum/supplydroppack/pack in supplydropcontroller.packs)
		if(pack.id != "error")
			dat += "<A href='byond://?src=\ref[src];[pack.id]=1'>[pack.name] ([pack.cost])</A><BR>"
	dat += "<br><b>Long Range Scans</b><br>"
	for(var/obj/machinery/monolithcore/MC in world)
		if(MC && MC.loc)
			var/turf/T = get_turf(MC)
			var/area/A = get_area(T)
			if(A)
				dat += "Necron Monolith: [A.name] ([MC.x], [MC.y])<br>"
	dat += "<br><b>The emperor protects!</b><br><HR>"
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")
	return

/obj/machinery/computer/supplydrop/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/supplydrop/Topic(href, href_list)
	if(stat & BROKEN)
		return

	if (usr.stat || usr.restrained()) return //Nope! We are either dead or restrained!

	if(href_list["guards"])
		if(supplydropcontroller.points >= 200)
			var/ghosts = 0
			for(var/mob/dead/observer/O in player_list)
				if(O.client && O.ckey)
					ghosts += 1
			if(ghosts <= 3)
				usr << "\red ((there aren't enough candidates right now for this))"
				return
			if(!supplydropcontroller.reinforcements_cooldown)
				supplydropcontroller.points -= 200
				supplydropcontroller.reinforcements_cooldown = 10
				var/r_type = rand(1, 4)
				switch(r_type)
					if(1)
						usr << "\red A squad of Valhallan Ice Warriors has been sent."
						valhallan_support()
					if(2)
						usr << "\red A squad of Elysian Drop Troops has been sent."
						elysian_support()
					if(3)
						usr << "\red A squad of the Death Korps Krieg has been sent."
						kreig_support()
					if(4)
						usr << "\red A squad of Cadian Shock Troops has been sent."
						cadian_support()
				interact(usr)
			else
				usr << "\red Reinforcements not yet available! (wait a bit before calling another set of reinforcements)"
		else
			usr << "\red Not enough support points!"
		return

	if(href_list["airstrike"])
		if(supplydropcontroller.points >= 250)
			supplydropcontroller.points -= 250
			var/A
			A = input("Area to bombard", "Open Fire", A) in teleportlocs
			var/area/thearea = teleportlocs[A]
			if (usr.stat || usr.restrained()) return
			if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
				priority_announce("Targetting [A] for airstrike.")
				message_admins("[key_name_admin(usr)] has called an airstrike.", 1)
				var/list/L = list()
				for(var/turf/T in get_area_turfs(thearea.type))
					L+=T
				var/loc = pick(L)
				explosion(loc,2,5,11)
			interact(usr)
		else
			usr << "\red Not enough support points!"
		return

	if(href_list["fortress"])
		if(supplydropcontroller.points >= 500)
			supplydropcontroller.points -= 500
			var/A
			A = input("Area to send command center", "Modular Drop", A) in teleportlocs
			var/area/thearea = teleportlocs[A]
			if (usr.stat || usr.restrained()) return
			if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
				priority_announce("Command Center Module Inbound")
				message_admins("[key_name_admin(usr)] has created a new command center.", 1)
				var/list/L = list()
				for(var/turf/T in get_area_turfs(thearea.type))
					L+=T
				var/loc = pick(L)
				new /obj/effect/landmark/supplycommand(loc)
			interact(usr)
		else
			usr << "\red Not enough support points!"
		return

	if(href_list["baneblade"])
		if(supplydropcontroller.baneblade_deployed)
			usr << "\red The only baneblade tank in the area has already been deployed."
			return
		if(supplydropcontroller.points >= 1500)
			supplydropcontroller.points -= 1500
			supplydropcontroller.baneblade_deployed = 1
			for(var/obj/mecha/combat/baneblade/BB in world)
				for(var/obj/effect/landmark/baneblade/BS in world)
					usr << "\red Baneblade deployed. Use the teleporter to quickly travel to it."
					src.visible_message("\red [src] spits out a small device!")
					new /obj/item/device/baneblade_jaunter(get_turf(src))
					BB.area.teleport(get_turf(BS))
			interact(usr)
		return

	if(href_list["transit"])
		if(supplydropcontroller.centcomm)
			usr << "\red The supply drop is not located on the outpost."
			return
		playsound(src.loc,'sound/effects/droppod.ogg',75,1)
		for(var/obj/effect/landmark/supplydropsegmentum/D in world)
			supplydropcontroller.dropshuttle.teleport(get_turf(D))
			for(var/atom/A in range(9, D))
				if(!istype(A, /obj/effect/fake_floor) && !istype(A, /obj/effect/landmark) && !istype(A, /obj/effect/light_emitter))
					if(istype(A, /mob/living))
						var/mob/living/M = A
						if(ishuman(M))
							if(M.stat == DEAD) //TODO: Make the end-round stats show who escaped, whose body was recovered, et cetera.
								M << "\red Your body is recovered by the imperium."
								if(ticker)
									if(M.mind && M.mind.special_role != "Wizard")
										var/datum/game_mode/R = ticker.mode
										R.honors.Add("<b>[M.name]</b> ([M.mind.key]) body recovered with support ship")
							else
								if(prob(10))
									M << "\red You are evacuated from the combat zone."
									if(ticker)
										if(M.mind && M.mind.special_role != "Wizard")
											var/datum/game_mode/R = ticker.mode
											R.honors.Add("<b>[M.name]</b> ([M.mind.key]) evacuated from the combat zone")
								else
									M << "\red You are evacuated from the combat zone and subsequently executed for dishonorable combat"
									if(ticker)
										if(M.mind && M.mind.special_role != "Wizard")
											var/datum/game_mode/R = ticker.mode
											R.honors.Add("<b>[M.name]</b> ([M.mind.key]) executed for dishonorable combat after fleeing on the support ship")
						else
							M << "\red You are sent to an imperial craft and subsequently purged."
					qdel(A)
				supplydropcontroller.centcomm = 1
				interact(usr)
		return

	if(!supplydropcontroller.centcomm)
		usr << "\red The supply drop is still landed on the outpost! Send it back up!"
		return

	for(var/option in href_list) //This might acesss href_list keys, or values. Not sure how the "dictionary" object works in DM. There /should/ be a .keys() function...
		for(var/datum/supplydroppack/P in supplydropcontroller.packs)
			if(option == P.id)
				if(supplydropcontroller.points >= P.cost)
					supplydropcontroller.points -= P.cost
					for(var/obj/effect/landmark/supplydropsegmentum/D in world)
						P.add_equipment(get_turf(D))
					var/A
					A = input(usr, "Area to drop supplies", "Supply Drop", A) in teleportlocs
					var/area/thearea = teleportlocs[A]
					supplydropcontroller.dropshuttle.teleport(pick(get_area_turfs(thearea.type)))
					supplydropcontroller.centcomm = 0
					playsound(src.loc,'sound/effects/droppod.ogg',75,1)
					interact(usr)
				else
					usr << "\red Not enough support points."

/datum/supplydroppack/entrenchment
	name = "9-70 Entrenchment Tools Drop"
	id = "entrenchment"
	cost = 25

/datum/supplydroppack/entrenchment/add_equipment(var/turf/T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		new /obj/item/stack/sheet/metal/full(get_turf(point))
		new /obj/item/weapon/snowshovel/ig970(get_turf(point))
		new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/lasguns
	name = "Las-Weapons Drop"
	id = "lasguns"
	cost = 50

/datum/supplydroppack/lasguns/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(prob(7))
			new /obj/item/weapon/gun/projectile/automatic/lascannon(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(prob(80))
			new /obj/machinery/rack/lasgun/full(get_turf(point))
		else if(prob(50))
			new /obj/machinery/rack/pistol/full(get_turf(point))
		else
			new /obj/machinery/rack/longlas/full(get_turf(point))

/datum/supplydroppack/hellguns
	name = "Hellguns Drop"
	id = "hellguns"
	cost = 100

/datum/supplydroppack/hellguns/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(prob(80))
			new /obj/machinery/rack/hellgun/full(get_turf(point))
		else
			new /obj/machinery/rack/hellpistol/full(get_turf(point))

/datum/supplydroppack/autoguns
	name = "Auto-Weapons Drop"
	id = "autoguns"
	cost = 50

/datum/supplydroppack/autoguns/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(prob(90))
			new /obj/machinery/rack/autogun/full(get_turf(point))
		else
			new /obj/item/weapon/gun/projectile/automatic/l6_saw(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/melee
	name = "Melee Weapons Drop"
	id = "swords"
	cost = 100

/datum/supplydroppack/melee/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		var/drop = rand(1, 100)
		switch(drop)
			if(1 to 10)
				new /obj/machinery/rack/chainsword(get_turf(point))
			if(11 to 50)
				new /obj/machinery/rack/chainsword2(get_turf(point))
			else
				new /obj/machinery/rack/powersword(get_turf(point))

/datum/supplydroppack/bolters
	name = "Bolter Drop"
	id = "bolters"
	cost = 150

/datum/supplydroppack/bolters/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		new /obj/machinery/rack/bolter/full(get_turf(point))

/datum/supplydroppack/flamers
	name = "Flamer Weapons Drop"
	id = "flamers"
	cost = 300

/datum/supplydroppack/flamers/add_equipment(var/turf/T)
	var/handflamers = 2
	var/flamers = 2
	var/heavyflamers = 1
	var/grenades = 2
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(handflamers)
			handflamers --
			new /obj/item/weapon/gun/projectile/handflamer(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(flamers)
			flamers --
			new /obj/item/weapon/gun/projectile/flamer(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(heavyflamers)
			heavyflamers --
			new /obj/item/weapon/twohanded/required/hflamer(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(grenades)
			grenades --
			new /obj/item/weapon/grenade/chem_grenade/mini/promethium(get_turf(point))
			new /obj/item/weapon/grenade/chem_grenade/mini/promethium(get_turf(point))
			new /obj/item/weapon/grenade/chem_grenade/mini/promethium(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/plasma
	name = "Plasma Weapons Drop"
	id = "plasma"
	cost = 400

/datum/supplydroppack/plasma/add_equipment(var/turf/T)
	var/pistols = 3
	var/rifles = 2
	var/missiles = 1
	var/grenades = 1
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(pistols)
			pistols --
			new /obj/item/weapon/gun/energy/plasma/pistol(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(rifles)
			rifles --
			new /obj/item/weapon/gun/energy/plasma/rifle(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(missiles)
			missiles --
			new /obj/item/weapon/plasmisslea(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(grenades)
			grenades --
			new /obj/item/weapon/grenade/plasma(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/melta
	name = "Melta Weapons Drop"
	id = "melta"
	cost = 400

/datum/supplydroppack/melta/add_equipment(var/turf/T)
	var/meltaguns = 4
	var/inferno = 2
	var/multimelta = 1
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(meltaguns)
			meltaguns --
			new /obj/item/weapon/gun/projectile/meltagun/ig(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(inferno)
			inferno --
			new /obj/item/weapon/gun/energy/inferno(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(multimelta)
			multimelta --
			new /obj/item/weapon/twohanded/required/multimelta(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/hbolter
	name = "Heavy Bolters Drop"
	id = "hbolter"
	cost = 400

/datum/supplydroppack/hbolter/add_equipment(var/turf/T)
	var/hbolters = 3
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(hbolters)
			hbolters --
			new /obj/item/weapon/twohanded/required/hbolter(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/heavy
	name = "Heavy Weapons Drop"
	id = "heavy"
	cost = 1000

/datum/supplydroppack/heavy/add_equipment(var/turf/T)
	var/hbolters = 2
	var/multimelta = 2
	var/rifles = 2
	var/heavyflamers = 2
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(hbolters)
			hbolters --
			new /obj/item/weapon/twohanded/required/hbolter(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(multimelta)
			multimelta --
			new /obj/item/weapon/twohanded/required/multimelta(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(rifles)
			rifles --
			new /obj/item/weapon/gun/energy/plasma/rifle(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(heavyflamers)
			heavyflamers --
			new /obj/item/weapon/twohanded/required/hflamer(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/explosives
	name = "Heavy Explosives Drop"
	id = "explosives"
	cost = 750

/datum/supplydroppack/explosives/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	var/launchers = 4
	var/missiles = 4
	var/grenades = 4
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(launchers)
			launchers --
			new /obj/item/weapon/gun/magic/staff/misslelauncher(get_turf(point))
			new /obj/item/weapon/misslea(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(missiles)
			missiles --
			new /obj/item/weapon/plasmisslea(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else if(grenades)
			grenades --
			new /obj/item/weapon/grenade/plasma(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else
			new /obj/machinery/rack/kraks/full(get_turf(point))

/datum/supplydroppack/medical
	name = "Medi-Packs and Expinovite Drop"
	id = "medical"
	cost = 300

/datum/supplydroppack/medical/add_equipment(var/turf/T)
	new /obj/item/weapon/wrench(T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(prob(80))
			new /obj/machinery/rack/firstaid2/full(get_turf(point))
		else
			new /obj/machinery/rack/expinovite/full(get_turf(point))

/datum/supplydroppack/stimpacks
	name = "Combat Stimulants Drop"
	id = "stimpacks"
	cost = 200

/datum/supplydroppack/stimpacks/add_equipment(var/turf/T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		if(prob(50))
			new /obj/item/weapon/reagent_containers/hypospray/stimpack(get_turf(point))
			new /obj/item/weapon/reagent_containers/hypospray/stimpack(get_turf(point))
			new /obj/item/weapon/reagent_containers/hypospray/stimpack(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))
		else
			new /obj/item/device/cheminhaler(get_turf(point))
			new /obj/item/device/cheminhaler(get_turf(point))
			new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/flakarmor
	name = "Reinforced Flak Armor Drop"
	id = "flakarmor"
	cost = 75

/datum/supplydroppack/flakarmor/add_equipment(var/turf/T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		new /obj/item/clothing/shoes/imperialboots/reinforced(get_turf(point))
		new /obj/item/clothing/suit/armor/imperialarmor/reinforced(get_turf(point))
		new /obj/item/clothing/head/imperialhelmet/reinforced(get_turf(point))
		new /obj/structure/closet/crate(get_turf(point))

/datum/supplydroppack/carapace
	name = "Carapace Armor Drop"
	id = "carapace"
	cost = 100

/datum/supplydroppack/carapace/add_equipment(var/turf/T)
	for(var/obj/effect/landmark/supplypoint/point in world)
		new /obj/item/clothing/shoes/swat(get_turf(point))
		new /obj/item/clothing/suit/armor/carapace(get_turf(point))
		new /obj/item/clothing/head/helmet/carapace(get_turf(point))
		new /obj/structure/closet/crate(get_turf(point))

/obj/effect/landmark/supplycommand/New()
	invisibility = 101
	var/turf/center = get_turf(src)
	for(var/turf/T in range(5, center))
		for(var/atom/A in T.contents)
			if(A == src)
				continue
			else if(isturf(A))
				continue
			else if(isliving(A))
				var/mob/living/M = A
				M.gib()
			else
				qdel(A)
	for(var/turf/T in range(5, center))
		if(get_dist(T, center) == 5)
			var/obj/structure/barricade/metal/B = new /obj/structure/barricade/metal(T)
			if(center.x == B.x)
				qdel(B)
			else if(center.y - B.y == -5)
				B.dir = NORTH
			else if(center.y - B.y == 5)
				B.dir = SOUTH
			else if(center.x - B.x == -5)
				B.dir = EAST
			else if(center.x - B.x == 5)
				B.dir = WEST
		if(get_dist(T, center) >= 4)
			T.ChangeTurf(/turf/simulated/floor)
	new /obj/machinery/computer/supplydrop(center)
	new /obj/structure/sign/aquilla(get_step(center, EAST))
	new /obj/structure/sign/aquilla(get_step(center, WEST))
	new /obj/effect/light_emitter(center)
	for(var/turf/T in range(3, center))
		if(get_dist(T, center) == 3)
			if(T.x != center.x)
				T.ChangeTurf(/turf/simulated/wall/polar2)
			else
				T.ChangeTurf(/turf/simulated/floor/engine)
				new /obj/machinery/door/unpowered/supplydrop(T)
		else
			T.ChangeTurf(/turf/simulated/floor/engine)
	qdel(src)