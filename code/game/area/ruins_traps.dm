/*
These are traps found in ruins. Includes arcane runes, rigged equipment, alarms, sensors, tripwires, teleport traps, lots of things.
DrakeMarshall

Necron Traps

Lockdown Doors and Proximity Pylons (Seals People in the Catacombs)
Scarab Production Plant (Produces Scarabs on Activation)
Sleeping Necron (An Inactive Necron Warrior/Scarab that awakes if you come too close)
Teleport Traps (Come near it, get teleported away)
Teleport Labrynth (Randomly generated bit of maze that transports you to random other locations in that modular maze, tends to be somewhere in the center so it is difficult to escape and confusing.)
Shifting Labrynth (Random labrynth that actually changes when a player moves through it.)
Necron Mine (Just a reskinned explosive, don't step on it)
Gauss Pylon (The maze contains a gauss pylon. Anyone who is unlucky eneough to trigger this gets a slight warning of an electric surge and shaking screen before the gauss pylon demolishes there location.)
Incineration Lockdown (Locks down blast doors... Then floods the room with fire.)
Sleep Gas (Motion Triggered Sleep Gas Flooding of a Corridor, N2O+CO2)
Nightmare Mine (A mine that gives you hallucinations and insanity instead of blowing up)

Okay well a lot of that above stuff is not a thing but there are lots of other things in here.
Anyway, TODO, make traps trigger a taunting voice to give the tombs a central AI

*/

/obj/machinery/door/poddoor/necron
	name = "lockdown door"
	desc = "A sturdy necron lockdown door."
	icon = 'icons/mob/necron.dmi'
	icon_state = "open"
	density = 0
	opacity = 0

/obj/machinery/door/poddoor/necron/HasProximity(atom/movable/AM as mob|obj)
	if(kill_tombs) return
	if(iscarbon(AM))
		if(prob(1) && prob(50))
			lockdown()

/obj/machinery/door/poddoor/necron/closed
	icon_state = "closed"
	density = 1
	opacity = 1

/obj/machinery/door/poddoor/necron/proc/lockdown()
	if(kill_tombs) return
	spawn()
		close(1)
		spawn(600)
			open(1)
	return

/obj/effect/mine/necron
	name = ""
	desc = "I better stay away from that thing."
	density = 1
	anchored = 1
	layer = 2.3
	icon = 'icons/mob/necron.dmi'
	icon_state = "mine"

/obj/effect/mine/necron/New()
		..()
		icon_state = "mine"

/obj/effect/mine/necron/Bumped(mob/M as mob|obj)
	if(triggered) return
	if(!istype(M)) return
	if(istype(M, /mob/dead)) return
	if(isliving(M, /mob/living))
		if(iscarbon(M))
			if(triggerproc == "explode") //Only alerts people if it is an exploding mine.
				for(var/mob/O in viewers(world.view, src.loc))
					O << "<font color='red'>[M] triggered the [src]</font>"
			if(triggerproc == "triggerrandom")
				for(var/mob/living/O in viewers(world.view, src.loc))
					shake_camera(O, 20, 1)
					O << "\red The room shakes as the walls shift!"
			triggered = 1
			call(src,triggerproc)(M)

/obj/effect/mine/proc/triggerlockdown(obj)
	for(var/obj/machinery/door/poddoor/necron/D in range(10,src))
		D.lockdown()
	qdel(src)

/obj/effect/mine/proc/triggerincinerate(obj)
	density = 0
	for(var/obj/machinery/door/poddoor/necron/D in range(10,src))
		D.lockdown()
	sleep(20)
	var/turf/center = get_turf(src)
	for(var/turf/target in view(7, center))
		new /obj/effect/hotspot(target)
		target.temperature = 500
		//H.life = 600
	qdel(src)

/obj/effect/mine/proc/triggergausspylon(obj)
	for(var/obj/structure/gausspylon/G in range(128,src))
		G.fire(list(obj))
	qdel(src)

/obj/effect/mine/proc/triggerteleport(obj) //...what if a second level of the tombs could be made...? lol. Also TODO make teleports do something less problematic.
	do_teleport(obj, get_turf(obj), 20, asoundin = 'sound/effects/phasein.ogg')
	qdel(src)

/obj/effect/mine/proc/triggerrandom(obj)
	src.density = 0
	var/turf/simulated/T = get_turf(src)
	if(istype(T, /turf/simulated/floor/necron))
		var/turf/simulated/floor/necron/N = T
		N.pulse()
		for(var/turf/simulated/S in orange(8, N))
			if(prob(1) && get_dist(S, N) > 3)
				new /obj/effect/landmark/necron_ruins(S)
	qdel(src)

/obj/effect/mine/proc/triggerenemies(obj)
	src.density = 0
	var/turf/simulated/T = get_turf(src)
	for(var/turf/simulated/wall/necron/N in range(1, T))
		N.pulse()
	for(var/turf/simulated/S in orange(7, T))
		if(prob(15) && get_dist(S, T) > 4)
			var/mob/living/simple_animal/hostile/scarab/SN = new /mob/living/simple_animal/hostile/scarab(S)
			SN.Goto(get_turf(src), SN.move_to_delay)
	qdel(src)

/obj/effect/mine/necron/lockdown
	triggerproc = "triggerlockdown"

/obj/effect/mine/necron/incinerator
	triggerproc = "triggerincinerate"

/obj/effect/mine/necron/teleport
	triggerproc = "triggerteleport"

/obj/effect/mine/necron/gauss
	triggerproc = "triggergausspylon"

/obj/effect/mine/necron/sleepgas
	triggerproc = "triggern2o"

/obj/effect/mine/necron/randomize
	triggerproc = "triggerrandom"

/obj/effect/mine/necron/enemies
	triggerproc = "triggerenemies"

/obj/effect/mine/necron/sleepgas/HasProximity(atom/movable/AM as mob|obj)
	Bumped(AM)

/obj/effect/mine/necron/teleport/HasProximity(atom/movable/AM as mob|obj)
	Bumped(AM)

/obj/effect/mine/necron/randomize/HasProximity(atom/movable/AM as mob|obj)
	Bumped(AM)

/obj/item/mob_holder //Can be used for scarabs and maybe also for something else as some wierd antagonist capability
	var/mob/living/contained

/obj/item/mob_holder/on_found(mob/user as mob)
	if(kill_tombs) return
	if(contained)
		user << "\red [contained] climbs out of the container!"
		contained.loc = get_turf(src)
		contained.status_flags &= ~GODMODE
		contained.canmove = 1
		qdel(src)

/obj/item/mob_holder/proc/hold_mob(var/mob/living/M)
	if(!M)
		return
	contained = M
	src.name = contained.name
	src.icon = contained.icon
	src.icon_state = contained.icon_state
	src.desc = contained.desc
	contained.loc = src
	contained.status_flags |= GODMODE
	contained.canmove = 0
	contained.cancel_camera()

/obj/item/mob_holder/scarab/New()
	..()
	if(ticker && ticker.mode)
		sleep(30)
		var/mob/living/S = new /mob/living/simple_animal/hostile/scarab(src.loc)
		sleep(30)
		if(S)
			hold_mob(S)
		else
			qdel(src)
	else
		sleep(1200)
		new /obj/item/mob_holder/scarab(src.loc)
		qdel(src)
	return

/mob/living/simple_animal/hostile/necron/sleeping
	name = "sentinel"
	stop_automated_movement = 1
	vision_range = 2
	aggro_vision_range = 8
	idle_vision_range = 2
	maxHealth = 150
	health = 150
	wander = 0
	//var/asleep = 1

/mob/living/simple_animal/hostile/necron/sleeping/GiveTarget(var/new_target)
	if(kill_tombs) return
	target = new_target
	if(target != null)
		Aggro()
		stance = HOSTILE_STANCE_ATTACK
		src.visible_message("\red The [src]'s eys light up as it sluggishly comes to life!")
	return

/mob/living/simple_animal/hostile/necron/sleeping/lychguard
	icon_state = "lychguard"
	icon_living = "lychguard"
	icon_dead = "necron_dead"
	ranged = 0
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 70
	melee_damage_upper = 90
	maxHealth = 800
	health = 800
	attacktext = "slashes"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	environment_smash = 1
	wander = 0
	idle_vision_range = 7

/obj/item/weapon/dnainjector/h2m/lol //If someone does this... I laugh.
	name = "Genetic Upgrade"
	desc = "Makes you godzilla!"

/obj/effect/mine/proc/triggern2o(obj)
 	//atmos_spawn_air(SPAWN_N2O, 360)
 	qdel(src)

/obj/effect/landmark/wall_destination
	name = "Wall Destination"
	icon = 'icons/mob/screen_gen.dmi'
	anchored = 1.0

/obj/effect/landmark/wall_destination/New()
	..()
	invisibility = 100 //Not 101 because we need to access it in orange()! Damned 101 setting...

/obj/effect/landmark/wall_destination_lockdown
	name = "Wall Destination"
	icon = 'icons/mob/screen_gen.dmi'
	anchored = 1.0

/obj/effect/landmark/wall_destination_lockdown/New()
	..()
	invisibility = 100

/obj/effect/landmark/wall_destination_open
	name = "Wall Destination"
	icon = 'icons/mob/screen_gen.dmi'
	anchored = 1.0

/obj/effect/landmark/wall_destination_open/New()
	..()
	invisibility = 100

/obj/effect/fake_floor/fake_wall/r_wall/tomb
	name = "wall"
	desc = "A glowing, alien green wall."
	icon = 'icons/mob/tombs.dmi'
	icon_state = "wall0"
	base_icon_state = "wall"
	explosion_recursions = 100
	var/datum/fake_area/movement_area
	var/mobile = 0

/obj/effect/fake_floor/fake_wall/r_wall/tomb/New()
	src.movement_area = new()
	src.movement_area.add_turf(src)
	..()
	var/turf/location = get_turf(src)
	if(!istype(location.loc, /area/necron_catacombs))
		spawn(1) update_smoothing()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/relativewall()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/relativewall_neighbours()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/proc/update_smoothing() //Relativewall, but not called on initialization. Death to lag.
	if(kill_tombs) return
	var/junction = 0
	for(var/turf/simulated/wall/W in orange(1, get_turf(src)))
		if(abs(src.x-W.x)-abs(src.y-W.y))
			junction |= get_dir(src,W)
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, get_turf(src)))
		if(!W.mobile)
			if(abs(src.x-W.x)-abs(src.y-W.y))
				junction |= get_dir(src,W)
	src.icon_state = "[base_icon_state][junction]"

/obj/effect/fake_floor/fake_wall/r_wall/tomb/proc/shuffle() //This is an issue...
	if(kill_tombs) return
	if(mobile) return
	mobile = 1
	for(var/turf/simulated/wall/necron/W in orange(get_turf(src),1))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, get_turf(src)))
		W.update_smoothing()
	var/list/possible = list()
	for(var/obj/effect/landmark/wall_destination/destination in orange(2, get_turf(src)))
		//world << "\red Possibly viable destination located."
		var/viable = 1
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in get_turf(destination))
			viable = 0
		if(viable)
			possible.Add(destination)
	if(!possible.len)
		//world << "\red No viable destinations in range, returning..."
		return
	var/turf/destination = get_turf(pick(possible))
	var/timeout = 0
	while(src.loc != destination && timeout < 25)
		//world << "\red Moving the turf..."
		timeout += 1
		sleep(2)
		movement_area.move(get_dir(src, get_step_to(src, destination)), 1) //Apparently get_step_to is being a problem... Maybe a less sophisticated use of get_dir() will work nearly as well?
	mobile = 0
	update_smoothing()
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		W.update_smoothing()

/obj/effect/fake_floor/fake_wall/r_wall/tomb/proc/lockdown() //A way to use the moving walls as lockdown doors. This will be interesting. -Drake
	if(kill_tombs) return
	if(mobile) return
	mobile = 1
	for(var/turf/simulated/wall/necron/W in orange(get_turf(src),1))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, get_turf(src)))
		W.update_smoothing()
	var/list/possible = list()
	for(var/obj/effect/landmark/wall_destination_lockdown/destination in orange(1, get_turf(src)))
		var/viable = 1
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in get_turf(destination))
			viable = 0
		if(viable)
			possible.Add(destination)
	if(!possible.len)
		return
	var/turf/destination = get_turf(pick(possible))
	var/timeout = 0
	while(src.loc != destination && timeout < 25)
		timeout += 1
		sleep(2)
		movement_area.move(get_dir(src, get_step_to(src, destination)), 1)
	mobile = 0
	update_smoothing()
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		W.update_smoothing()
	sleep(600)
	if(mobile) return
	mobile = 1
	for(var/turf/simulated/wall/necron/W in orange(get_turf(src),1))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, get_turf(src)))
		W.update_smoothing()
	var/list/possible2 = list()
	for(var/obj/effect/landmark/wall_destination_open/pdestination in orange(1, get_turf(src)))
		var/viable = 1
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in get_turf(pdestination))
			viable = 0
		if(viable)
			possible2.Add(pdestination)
	if(!possible2.len)
		return
	var/turf/fdestination = get_turf(pick(possible2))
	var/timeout2 = 0
	while(src.loc != fdestination && timeout2 < 25)
		timeout2 += 1
		sleep(2)
		movement_area.move(get_dir(src, get_step_to(src, fdestination)), 1)
	mobile = 0
	update_smoothing()
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		W.update_smoothing()

/obj/effect/fake_floor/fake_wall/r_wall/tomb/proc/moveright()
	if(kill_tombs) return
	if(mobile) return
	mobile = 1
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		W.update_smoothing()
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	sleep(2)
	movement_area.move(WEST, 1)
	mobile = 0
	update_smoothing()
	for(var/turf/simulated/wall/necron/W in orange(1, src))
		W.update_smoothing()
	for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/W in orange(1, src))
		W.update_smoothing()

/obj/effect/fake_floor/fake_wall/r_wall/tomb/ex_act(exforce)
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/blob_act()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/thermitemelt(mob/user as mob)
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	return attack_hand(user)

/obj/effect/fake_floor/fake_wall/r_wall/tomb/attack_paw()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/attack_animal()
	return

/obj/effect/fake_floor/fake_wall/r_wall/tomb/attack_hand()
	return

/obj/effect/step_trigger/shuffle/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in range(7, src))
			if(prob(5))
				spawn(0) T.shuffle()
		if(prob(2)) //Moving around in these areas will shift walls, but also might attract the odd scarab.
			for(var/turf/simulated/S in orange(11, src))
				if(!S.density)
					if(prob(17) && get_dist(S, src) > 7)
						var/mob/living/simple_animal/hostile/scarab/SN = new /mob/living/simple_animal/hostile/scarab(S)
						SN.Goto(get_turf(src), SN.move_to_delay)
						break

/obj/effect/landmark/shuffle
	name = "Shuffle Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/shuffle/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/shuffle(src.loc)
	qdel(src)

/obj/effect/landmark/lockdown
	name = "Lockdown Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/lockdown/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/lockdown(src.loc)
	qdel(src)

/obj/effect/landmark/incinerate
	name = "Incinerate Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/incinerate/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/incinerate(src.loc)
	qdel(src)

/obj/effect/step_trigger/scarabs //A full scarab swarm is triggered when you go here.
	var/triggered = 0

/obj/effect/step_trigger/scarabs/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(triggered) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		triggered = 1
		if(prob(10))
			A << pick("<span class='tombs'>According to my scans, your meat creature biology is equipped with an immune system. Consider these my antibodies.</span>","<span class='tombs'>Here, let me direct some friends to your location.</span>","<span class='tombs'>Now is not a very fortunate time to be an organic.</span>","<span class='tombs'>I'm seeing a lot more of your breed of meat creature lately. Let's get an up close look at how some of your internal organs are arranged.</span>","<span class='tombs'>An autoimmune response... We apologize for the inconvenience.</span>","<span class='tombs'>If by any chance you happen to be feeling lonely, I can give you some friends...</span>","<span class='tombs'>Mind the scarabs. Or don't. We have thousands of them on call.</span>","<span class='tombs'>I've herded a few maintenance units your way. I hope you don't mind.</span>")
		var/turf/simulated/T = get_turf(src)
		for(var/turf/simulated/wall/necron/N in range(1, T))
			N.pulse()
		for(var/turf/simulated/S in orange(11, T))
			if(!S.density)
				if(prob(12) && get_dist(S, T) > 7)
					var/mob/living/simple_animal/hostile/scarab/SN = new /mob/living/simple_animal/hostile/scarab(S)
					SN.Goto(get_turf(src), SN.move_to_delay)
		qdel(src)

/obj/effect/step_trigger/wraith
	var/triggered = 0

/obj/effect/step_trigger/wraith/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(triggered) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		triggered = 1
		var/turf/T = get_turf(src)
		if(prob(10) && istype(get_area(T), /area/necron_catacombs))
			A << pick("<span class='tombs'>Lonely in there? Don't worry, I'll direct a friend your way.</span>","<span class='tombs'>I'm sending a servant to meet you, my much esteemed guest.</span>","<span class='tombs'>You know... Meat creature grave robbers should really expect company more often. It's not as if I need to sleep. I'm always happy to entertain new guests.</span>","<span class='tombs'>Wait there for a moment, there's someone who wants to meet you.</span>","<span class='tombs'>Please standby while a maintenance unit addresses the imperfection in my system.</span>","<span class='tombs'>I am curious to see more of how the biology of a meat creature reacts to internal bleeding.</span>","<span class='tombs'>Keep going... I'm afraid you have no choice.</span>","<span class='tombs'>I'm afraid grave robbing doesn't pay.</span>")
		for(var/turf/simulated/S in orange(9, T))
			if(get_dist(S, T) > 7)
				var/mob/living/simple_animal/hostile/necronwraith/SN = new /mob/living/simple_animal/hostile/necronwraith(S)
				SN.asleep = 0
				SN.GiveTarget(A)
				break
		if(prob(10))
			for(var/obj/machinery/door/poddoor/necron/D in range(7,T))
				spawn(2*get_dist(src, D)) D.lockdown()
			for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/FW in range(7, T))
				spawn(2*get_dist(src, FW)) FW.lockdown()
		qdel(src)

/obj/effect/step_trigger/randomize
	var/triggered = 0

/obj/effect/step_trigger/randomize/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(triggered) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		triggered = 1
		if(prob(10))
			A << pick("<span class='tombs'>I am having far too much fun toying with you...</span>","<span class='tombs'>Let me rearrange things for you.</span>","<span class='tombs'>Foolish meat creature... I'm everywhere. I surround you. You are utterly in my power.</span>","<span class='tombs'>I'm thinking about remodelling this room... There we go.</span>","<span class='tombs'>Now don't get too familiar with this place. After all, it isn't your home, intruder.</span>","<span class='tombs'>This is incredibly entertaining. I wish more people tried to rob my domain.</span>","<span class='tombs'>Lets change things up, hm?</span>","<span class='tombs'>I think I'll redesign this a bit.</span>")
		var/turf/simulated/center = get_turf(src)
		if(istype(center, /turf/simulated/floor/necron))
			var/turf/simulated/floor/necron/N = center
			N.pulse()
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in range(7, src))
			spawn(2*get_dist(center, T)) //An artificial way to delay the movement until the pulse hits.
				T.shuffle()
		qdel(src)

/obj/effect/landmark/randomize
	name = "Randomize Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/randomize/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/randomize(src.loc)
	qdel(src)

/obj/effect/step_trigger/crusher
	var/triggered = 0

/obj/effect/step_trigger/crusher/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(triggered) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		if(prob(10))
			A << pick("<span class='tombs'>Think fast...</span>","<span class='tombs'>Hello again my guest. Hold still for a moment...</span>","<span class='tombs'>You probably should get out of the way.</span>","<span class='tombs'>Hm... I think I'll collapse this room. We don't really need it for anything. Oh, are you in there? Oops.</span>","<span class='tombs'>I hope you appreciate the irony of being entombed in my domain...</span>","<span class='tombs'>Time to swat a meat creature out of the way.</span>","<span class='tombs'>It looks like there's only refuse in this area. I'll just clean it up...</span>","<span class='tombs'>I trust our esteemed guest knows to mind the wall... It's an old trick.</span>")
		triggered = 1
		var/turf/simulated/center = get_turf(src)
		if(istype(center, /turf/simulated/floor/necron))
			var/turf/simulated/floor/necron/N = center
			N.pulse()
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in range(7, src))
			spawn(0)
				T.moveright()
		qdel(src)

/obj/effect/landmark/crusher
	name = "Crusher Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/crusher/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/crusher(src.loc)
	qdel(src)

/obj/effect/step_trigger/lockdown/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		if(prob(10))
			A << pick("<span class='tombs'>Going somewhere?</span>","<span class='tombs'>Not so fast.</span>","<span class='tombs'>Wait here for a bit.</span>","<span class='tombs'>For a grave robber your work is remarkably sloppy. I could crush you in this room if I wanted. Do better next time.</span>","<span class='tombs'>I hope you don't mind waiting here for a bit. I have something else I want to check on.</span>","<span class='tombs'>You know, I could just keep you here. Forever. Your skeleton would make a nice decoration. It would go perfectly with our design theme.</span>","<span class='tombs'>Hm... Should I vent burning exhaust in your room? Hm... No I don't think I will this time. Probably a waste of energy.</span>","<span class='tombs'>You should probably try being a little more sneaky if you want to steal something.</span>")
		var/turf/center = get_turf(src)
		if(istype(center, /turf/simulated/floor/necron))
			var/turf/simulated/floor/necron/N = center
			N.pulse()
		for(var/obj/machinery/door/poddoor/necron/D in range(7,src))
			spawn(2*get_dist(src, D)) D.lockdown()
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in range(7, src))
			spawn(2*get_dist(src, T)) T.lockdown()
		qdel(src)

/obj/effect/step_trigger/incinerate/Trigger(var/atom/movable/A)
	if(kill_tombs) return
	if(ishuman(A) || isalien(A) || isrobot(A))
		var/turf/center = get_turf(src)
		if(istype(center, /turf/simulated/floor/necron))
			var/turf/simulated/floor/necron/N = center
			N.pulse()
		for(var/obj/machinery/door/poddoor/necron/D in range(7,src))
			spawn(2*get_dist(src, D)) D.lockdown()
		for(var/obj/effect/fake_floor/fake_wall/r_wall/tomb/T in range(7, src))
			spawn(2*get_dist(src, T)) T.lockdown()
		if(prob(10))
			A << pick("<span class='tombs'>I'm just going to vent some burning fuel in here... I hope you don't mind, intruder.</span>","<span class='tombs'>Now to see how our guests react to uncomfortably high temperatures...</span>","<span class='tombs'>This isn't called a tomb for nothing... Although organics tend to get cremated.</span>","<span class='tombs'>You walked right into that one.</span>","<span class='tombs'>Hm... While I'm holding you here, how about I vent the forge?</span>","<span class='tombs'>Going somewhere?</span>","<span class='tombs'>Organic tissue is so fragile. It must be inconvenient to a lively grave robber like yourself. Let me relieve you of it...</span>","<span class='tombs'>Drawing this out is proving a welcoming distraction... What will I do when you are gone, intruder?</span>")
		spawn(30)
			for(var/turf/target in view(14, center))
				if(!locate(/obj/effect/hotspot) in target && !target.density)
					new /obj/effect/hotspot(target)
					target.temperature = 2000 //Lets up the heat a little bit!
		qdel(src)

/obj/effect/landmark/incinerator
	name = "Incinerator Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/incinerator/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	new /obj/effect/step_trigger/incinerate(src.loc)
	qdel(src)

/obj/effect/step_trigger/gauss/Trigger(var/atom/movable/A)
	if(ishuman(A) || isalien(A) || isrobot(A))
		if(prob(5))
			A << pick("<span class='tombs'>Run, run, as fast as you can... You can't run from me... Because I'm EVERYWHERE.</span>","<span class='tombs'>Hello again my guest. Hold still for a moment...</span>","<span class='tombs'>If you look closely you might now see a light at the end of the tunnel... Oh wait, that's a gauss weapon.</span>","<span class='tombs'>You can hardly hide from me.</span>","<span class='tombs'>Do please enjoy our hospitality. There's a rather large death ray operating just for you. I hope you feel special, meat creature.</span>","<span class='tombs'>Lets play a game of hide and seek. You hide first.</span>","<span class='tombs'>If I were you, I would duck right now. It would be boring if you ended our fun by dying on me so soon.</span>","<span class='tombs'>This is the most entertainment I've had in centuries...</span>")
		for(var/obj/structure/gausspylon/G in range(128,src))
			G.fire(list(src.loc))
		qdel(src)

/obj/effect/landmark/necron_trap
	name = "Possible Necron Trap"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x3"
	anchored = 1.0

/obj/effect/landmark/necron_trap/New()
	var/turf/location = get_turf(src)
	if(!istype(get_area(location), /area/necron_catacombs)) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	var/seed = rand(1, 35)
	switch(seed)
		if(1)
			new /obj/effect/step_trigger/scarabs(get_turf(src))
		if(2)
			new /mob/living/simple_animal/hostile/scarab/sleeping(get_turf(src))
		if(3)
			new /mob/living/simple_animal/hostile/necron/sleeping(get_turf(src))
		if(4)
			new /mob/living/simple_animal/hostile/necron/sleeping/lychguard(get_turf(src))
		if(5)
			new /obj/effect/step_trigger/lockdown(get_turf(src))
		if(6)
			new /obj/effect/step_trigger/incinerate(get_turf(src))
		if(7)
			new /obj/effect/step_trigger/gauss(get_turf(src))
		if(8)
			if(prob(15))
				new /obj/effect/landmark/necron_find(get_turf(src))
		if(9)
			new /obj/effect/step_trigger/wraith(get_turf(src))
		if(10)
			if(prob(35))
				new /mob/living/simple_animal/hostile/grabber(get_turf(src))
	qdel(src)

/obj/effect/landmark/corpse/explorator
	name = "Magos Sidonius"
	corpseradio = /obj/item/device/radio/headset/heads/ce
	corpseuniform = /obj/item/clothing/under/rank/chief_engineer
	corpseback = /obj/item/weapon/storage/backpack/mechaclamp
	corpseshoes = /obj/item/clothing/shoes/sneakers/red
	corpsebelt = /obj/item/weapon/storage/belt/MDAC
	corpsegloves = /obj/item/clothing/gloves/black
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig/elite
	corpsesuit = /obj/item/clothing/suit/space/rig/elite
	corpsemask = /obj/item/clothing/mask/gas/TRAP
	corpsepocket1 = /obj/item/weapon/gun/projectile/automatic/hellpistol
	corpsepocket2 = /obj/item/xenos_claw
	corpsebrute = 300
	corpseoxy = 300
	corpseid = 1
	corpseidjob = "Explorator"
	corpseidaccess = "Adeptus Magos"

/mob/living/simple_animal/hostile/tombservitor
	name = "Explorator Servitor"
	desc = "A servitor used in an explorator team."
	icon = 'icons/mob/robots.dmi'
	icon_state = "tombs1"
	icon_living = "tombs1"
	icon_dead = "tombs1"
	health = 100
	maxHealth = 100
	melee_damage_lower = 10
	melee_damage_upper = 35
	attacktext = "drills"
	factions = list("necron")
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	wander = 0

/mob/living/simple_animal/hostile/tombservitor/adjustBruteLoss()
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	return ..()

/mob/living/simple_animal/hostile/tombservitor/Die()
	var/mob/living/silicon/robot/R = new /mob/living/silicon/robot(get_turf(src))
	R.name = src.name
	R.icon_state = src.icon_state
	R.death(0)
	qdel(src)
	return

/mob/living/simple_animal/hostile/tombservitor/s2
	icon_state = "tombs2"
	icon_living = "tombs2"
	icon_dead = "tombs2"
	attacktext = "bludgeons"
	health = 150
	maxHealth = 150
	melee_damage_lower = 15
	melee_damage_upper = 15
	move_to_delay = 4

/mob/living/simple_animal/hostile/tombservitor/s3
	icon_state = "tombs3"
	icon_living = "tombs3"
	icon_dead = "tombs3"
	attacktext = "crushes"
	health = 300
	maxHealth = 300
	melee_damage_lower = 25
	melee_damage_upper = 55
	move_to_delay = 6