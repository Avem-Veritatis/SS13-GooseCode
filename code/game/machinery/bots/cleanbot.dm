//Cleanbot assembly
/obj/item/weapon/bucket_sensor
	desc = "It's a bucket. With a sensor attached."
	name = "proxy bucket"
	icon = 'icons/obj/aibots.dmi'
	icon_state = "bucket_proxy"
	force = 3.0
	throwforce = 5.0
	throw_speed = 2
	throw_range = 5
	w_class = 3.0
	var/created_name = "Cleanbot"


//Cleanbot
/obj/machinery/bot/cleanbot
	name = "\improper Cleanbot"
	desc = "A little cleaning robot, he looks so excited!"
	icon = 'icons/obj/aibots.dmi'
	icon_state = "cleanbot0"
	layer = 5.0
	density = 0
	anchored = 0
	//weight = 1.0E7
	health = 25
	maxhealth = 25
	var/cleaning = 0
	var/blood = 1
	var/list/target_types = list()
	var/obj/effect/decal/cleanable/target
	var/obj/effect/decal/cleanable/oldtarget
	var/oldloc = null
	req_access = list(access_janitor)
	var/path[] = new()
	var/patrol_path[] = null
	var/beacon_freq = 1445		// navigation beacon frequency
	var/closest_dist
	var/closest_loc
	var/failed_steps
	var/should_patrol
	var/next_dest
	var/next_dest_loc

/obj/machinery/bot/cleanbot/New()
	..()
	src.get_targets()
	src.icon_state = "cleanbot[src.on]"

	should_patrol = 1

	src.botcard = new /obj/item/weapon/card/id(src)
	var/datum/job/janitor/J = new/datum/job/janitor
	src.botcard.access = J.get_access()

	if(radio_controller)
		radio_controller.add_object(src, beacon_freq, filter = RADIO_NAVBEACONS)


/obj/machinery/bot/cleanbot/turn_on()
	. = ..()
	src.icon_state = "cleanbot[src.on]"
	src.updateUsrDialog()

/obj/machinery/bot/cleanbot/turn_off()
	..()
	src.target = null
	src.oldtarget = null
	src.oldloc = null
	src.icon_state = "cleanbot[src.on]"
	src.path = new()
	src.updateUsrDialog()

/obj/machinery/bot/cleanbot/attack_hand(mob/user as mob)
	. = ..()
	if (.)
		return
	usr.set_machine(src)
	interact(user)

/obj/machinery/bot/cleanbot/interact(mob/user as mob)
	var/dat
	dat += hack(user)
	dat += text({"
<TT><B>Automatic Station Cleaner v1.0</B></TT><BR><BR>
Status: []<BR>
Behaviour controls are [src.locked ? "locked" : "unlocked"]<BR>
Maintenance panel panel is [src.open ? "opened" : "closed"]"},
text("<A href='?src=\ref[src];operation=start'>[src.on ? "On" : "Off"]</A>"))
	if(!src.locked || issilicon(user))
		dat += text({"<BR>Cleans Blood: []<BR>"}, text("<A href='?src=\ref[src];operation=blood'>[src.blood ? "Yes" : "No"]</A>"))
		dat += text({"<BR>Patrol station: []<BR>"}, text("<A href='?src=\ref[src];operation=patrol'>[src.should_patrol ? "Yes" : "No"]</A>"))
	//	dat += text({"<BR>Beacon frequency: []<BR>"}, text("<A href='?src=\ref[src];operation=freq'>[src.beacon_freq]</A>"))
/*	if(src.open && !src.locked)
		dat += text({"
Odd looking screw twiddled: []<BR>
Weird button pressed: []"},
text("<A href='?src=\ref[src];operation=screw'>[src.screwloose ? "Yes" : "No"]</A>"),
text("<A href='?src=\ref[src];operation=oddbutton'>[src.oddbutton ? "Yes" : "No"]</A>"))*/

	user << browse("<HEAD><TITLE>Cleaner v1.0 controls</TITLE></HEAD>[dat]", "window=autocleaner")
	onclose(user, "autocleaner")
	return

/obj/machinery/bot/cleanbot/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	switch(href_list["operation"])
		if("start")
			if (src.on && !src.emagged)
				turn_off()
			else
				turn_on()
		if("blood")
			src.blood =!src.blood
			src.get_targets()
			src.updateUsrDialog()
		if("patrol")
			src.should_patrol =!src.should_patrol
			src.patrol_path = null
			src.updateUsrDialog()
		if("freq")
			var/freq = text2num(input("Select frequency for  navigation beacons", "Frequency", num2text(beacon_freq / 10))) * 10
			if (freq > 0)
				src.beacon_freq = freq
			src.updateUsrDialog()
/*		if("screw")
			src.screwloose = !src.screwloose
			usr << "<span class='notice>You twiddle the screw.</span>"
			src.updateUsrDialog()
		if("oddbutton")
			src.oddbutton = !src.oddbutton
			usr << "<span class='notice'>You press the weird button.</span>"
			src.updateUsrDialog() */
		if("hack")
			if(!src.emagged)
				src.emagged = 2
				src.hacked = 1
				usr << "<span class='warning'>You corrupt [src]'s cleaning software.</span>"
			else if(!src.hacked)
				usr << "<span class='userdanger'>[src] does not seem to respond to your repair code!</span>"
			else
				src.hacked = 0
				src.emagged = 0
				usr << "<span class='notice'>[src]'s software has been reset!</span>"
			src.updateUsrDialog()

/obj/machinery/bot/cleanbot/attackby(obj/item/weapon/W, mob/user as mob)
	if (istype(W, /obj/item/weapon/card/id)||istype(W, /obj/item/device/pda))
		if(src.allowed(usr) && !open && !emagged)
			src.locked = !src.locked
			user << "<span class='notice'>You [ src.locked ? "lock" : "unlock"] the [src] behaviour controls.</span>"
		else
			if(emagged)
				user << "<span class='warning'>ERROR</span>"
			if(open)
				user << "<span class='warning'>Please close the access panel before locking it.</span>"
			else
				user << "<span class='notice'>This [src] doesn't seem to respect your authority.</span>"
	else
		return ..()

/obj/machinery/bot/cleanbot/Emag(mob/user as mob)
	..()
	if(open && !locked)
		if(user) user << "<span class='notice'>[src] buzzes and beeps.</span>"
		src.emagged = 2

/obj/machinery/bot/cleanbot/process()
	set background = BACKGROUND_ENABLED

	if(!src.on)
		return
	if(src.cleaning)
		return
	var/list/cleanbottargets = list()

	if(!src.emagged && prob(5))
		visible_message("[src] makes an excited beeping booping sound!")

	if(src.emagged && prob(10)) //Wets floors randomly
		if(istype(loc,/turf/simulated))
			var/turf/simulated/T = src.loc
			T.MakeSlippery()

	if(src.emagged && prob(5)) //Spawns foam!
		visible_message("<span class='danger'>[src] whirs and bubbles violently, before releasing a plume of froth!</span>")
		new /obj/effect/effect/foam(src.loc)
		
	if(!src.target || src.target == null)
		for (var/obj/effect/decal/cleanable/D in view(7,src))
			for(var/T in src.target_types)
				if(!(D in cleanbottargets) && (D.type == T || D.parent_type == T) && D != src.oldtarget)
					src.oldtarget = D
					src.target = D
					return

	if(!src.target || src.target == null)
		if(src.loc != src.oldloc)
			src.oldtarget = null

		if (!should_patrol)
			return

		if (!patrol_path || patrol_path.len < 1)
			var/datum/radio_frequency/frequency = radio_controller.return_frequency(beacon_freq)

			if(!frequency) return

			closest_dist = 9999
			closest_loc = null
			next_dest_loc = null

			var/datum/signal/signal = new()
			signal.source = src
			signal.transmission_method = 1
			signal.data = list("findbeacon" = "patrol")
			frequency.post_signal(src, signal, filter = RADIO_NAVBEACONS)
			spawn(5)
				if (!next_dest_loc)
					next_dest_loc = closest_loc
				if (next_dest_loc)
					src.patrol_path = AStar(src.loc, next_dest_loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance_cardinal, 0, 120, id=botcard, exclude=null)
					if(!patrol_path)
						patrol_path = list()
		else
			patrol_move()

		return

	if(target && path.len == 0)
		spawn(0)
			if(!src || !target) return
			src.path = AStar(src.loc, src.target.loc, /turf/proc/AdjacentTurfs, /turf/proc/Distance, 0, 30)
			if(!src.path)
				src.path = list()
			if(src.path.len == 0)
				src.oldtarget = src.target
				src.target = null
		return
	if(src.path.len > 0 && src.target && (src.target != null))
		step_to(src, src.path[1])
		src.path -= src.path[1]
	else if(src.path.len == 1)
		step_to(src, target)

	if(src.target && (src.target != null))
		patrol_path = null
		if(src.loc == src.target.loc)
			clean(src.target)
			src.path = new()
			src.target = null
			return

	src.oldloc = src.loc

/obj/machinery/bot/cleanbot/proc/patrol_move()
	if (src.patrol_path.len <= 0)
		return

	var/next = src.patrol_path[1]
	src.patrol_path -= next
	if (next == src.loc)
		return

	var/moved = step_towards(src, next)
	if (!moved)
		failed_steps++
	if (failed_steps > 4)
		patrol_path = null
		next_dest = null
		failed_steps = 0
	else
		failed_steps = 0

/obj/machinery/bot/cleanbot/receive_signal(datum/signal/signal)
	var/recv = signal.data["beacon"]
	var/valid = signal.data["patrol"]
	if(!recv || !valid)
		return

	var/dist = get_dist(src, signal.source.loc)
	if (dist < closest_dist && signal.source.loc != src.loc)
		closest_dist = dist
		closest_loc = signal.source.loc
		next_dest = signal.data["next_patrol"]

	if (recv == next_dest)
		next_dest_loc = signal.source.loc
		next_dest = signal.data["next_patrol"]

/obj/machinery/bot/cleanbot/proc/get_targets()
	src.target_types = new/list()

	target_types += /obj/effect/decal/cleanable/oil
	target_types += /obj/effect/decal/cleanable/vomit
	target_types += /obj/effect/decal/cleanable/robot_debris
	target_types += /obj/effect/decal/cleanable/crayon
	target_types += /obj/effect/decal/cleanable/molten_item
	target_types += /obj/effect/decal/cleanable/tomato_smudge
	target_types += /obj/effect/decal/cleanable/egg_smudge
	target_types += /obj/effect/decal/cleanable/pie_smudge
	target_types += /obj/effect/decal/cleanable/flour
	target_types += /obj/effect/decal/cleanable/ash
	target_types += /obj/effect/decal/cleanable/greenglow
	target_types += /obj/effect/decal/cleanable/dirt

	if(src.blood)
		target_types += /obj/effect/decal/cleanable/xenoblood/
		target_types += /obj/effect/decal/cleanable/xenoblood/xgibs
		target_types += /obj/effect/decal/cleanable/blood/
		target_types += /obj/effect/decal/cleanable/blood/gibs/
		target_types += /obj/effect/decal/cleanable/trail_holder

/obj/machinery/bot/cleanbot/proc/clean(var/obj/effect/decal/cleanable/target)
	src.anchored = 1
	src.icon_state = "cleanbot-c"
	visible_message("<span class='danger'>[src] begins to clean up [target]</span>")
	src.cleaning = 1
	spawn(50)
		src.cleaning = 0
		qdel(target)
		src.icon_state = "cleanbot[src.on]"
		src.anchored = 0
		src.target = null

/obj/machinery/bot/cleanbot/explode()
	src.on = 0
	src.visible_message("<span class='danger'><B>[src] blows apart!</B></span>", 1)
	var/turf/Tsec = get_turf(src)

	new /obj/item/weapon/reagent_containers/glass/bucket(Tsec)

	new /obj/item/device/assembly/prox_sensor(Tsec)

	if (prob(50))
		new /obj/item/robot_parts/l_arm(Tsec)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/obj/item/weapon/bucket_sensor/attackby(var/obj/item/W, mob/user as mob)
	..()
	if(istype(W, /obj/item/robot_parts/l_arm) || istype(W, /obj/item/robot_parts/r_arm))
		user.drop_item()
		qdel(W)
		var/turf/T = get_turf(src.loc)
		var/obj/machinery/bot/cleanbot/A = new /obj/machinery/bot/cleanbot(T)
		A.name = src.created_name
		user << "<span class='notice'>You add the robot arm to the bucket and sensor assembly. Beep boop!</span>"
		user.unEquip(src, 1)
		qdel(src)

	else if (istype(W, /obj/item/weapon/pen))
		var/t = copytext(stripped_input(user, "Enter new robot name", src.name, src.created_name),1,MAX_NAME_LEN)
		if (!t)
			return
		if (!in_range(src, usr) && src.loc != usr)
			return
		src.created_name = t
