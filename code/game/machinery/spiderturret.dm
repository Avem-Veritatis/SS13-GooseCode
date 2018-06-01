/obj/machinery/spiderturret
	name = "Imperial Spider Turret"
	desc = "Imperial Spider Turret. Constructed with simple componants and eager to prove itself on the battlefield."
	density = 1
	anchored = 1
	var/state = 0 //Like stat on mobs, 0 is alive, 1 is damaged, 2 is dead
	var/list/factions = list("Mechanicus", "Station", "imperium", "Inquisitor")
	var/atom/cur_target = null
	var/scan_range = 9 //You will never see them coming
	var/health = 200 //Because it lacks a cover, and is mostly to keep people from touching the syndie shuttle.
	var/firesound = 'sound/weapons/Gunshot.ogg'
	var/ordinance = /obj/item/projectile/bullet  //controlls for offspring variants
	var/boxedver = null
	var/onbutton = 1
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndieturret0"

/obj/machinery/spiderturret/New()
	..()
	take_damage(0) //check your health

/obj/machinery/spiderturret/ex_act(severity)
	switch(severity)
		if(1)
			die()
		if(2)
			take_damage(100)
		if(3)
			take_damage(50)
	return

/obj/machinery/spiderturret/emp_act() //Can't emp an mechanical turret.
	return

/obj/machinery/spiderturret/update_icon()
	if(state > 2 || state < 0) //someone fucked up the vars so fix them
		take_damage(0)
	icon_state = "syndieturret" + "[state]"
	return


/obj/machinery/spiderturret/proc/take_damage(damage)
	health -= damage
	switch(health)
		if(101 to INFINITY)
			state = 0
		if(1 to 100)
			state = 1
		if(-INFINITY to 0)
			if(state != 2)
				die()
				return
			state = 2
	update_icon()
	return


/obj/machinery/spiderturret/bullet_act(var/obj/item/projectile/Proj)
	take_damage(Proj.damage)
	return

/obj/machinery/spiderturret/proc/die()
	state = 2
	update_icon()

/*
Interaction begins
*/

/obj/machinery/spiderturret/attackby(I as obj, user as mob)
	if(istype(I, /obj/item/device/turretprobe))
		playsound(src.loc, 'sound/items/timer.ogg', 50, 1)
		sleep 5
		playsound(src.loc, 'sound/items/timer.ogg', 50, 1)
		interact(user)
		usr.visible_message("<span class='warning'>  [usr] uses a device to interface with the turret.</span>", "<span class='notice'>Lets have a look</span>", "<span class='warning>What was that sound?</span>")

		var/dat = {"<br>Choose a Function<br>
		<a href='?src=\ref[src];REPACK=1'>Repackage Turret</a><br>
		<a href='?src=\ref[src];REPAIR=1'>Repair the Turret</a><br>
		<a href='?src=\ref[src];TOGGLE=1'>Toggle On/Off</a> |
		<a href='?src=\ref[user];mach_close=computer'>Nothing</a>"}

		user << browse(dat, "window=computer;size=575x450")
		onclose(user, "computer")
		return
	else
		usr.visible_message("<span class='notice'>I think you need a Tech Priest to take a look at this.</span>")
		return

/obj/machinery/spiderturret/Topic(href, href_list)
	if(..())
		return

	var/mob/living/user = usr

	user.set_machine(src)

	if(href_list["REPACK"])
		usr.visible_message("<span class='warning'>  [usr] begins repackaging the turret.</span>", "<span class='notice'>You monitor the turret as it folds itself up.</span>", "<span class='warning>What was that sound?</span>")
		sleep 30
		new boxedver(src.loc)
		usr.visible_message("<span class='notice'>[usr] repackages the turret.</span>")
		qdel(src)
	else if(href_list["REPAIR"])
		usr.visible_message("<span class='warning'>  [usr] begins repairing the turret.</span>", "<span class='notice'>You begin to repair the turret.</span>", "<span class='warning>What was that sound?</span>")
		sleep 30
		health = 200
		update_icon()
		usr.visible_message("<span class='notice'>[usr] finishes the repairs.</span>")
	else if(href_list["TOGGLE"])
		if (onbutton)
			scan_range = 0
			onbutton = 0
			usr.visible_message("<span class='notice'>[usr] disables the turret's tracking system.</span>")
		else
			scan_range = 9
			usr.visible_message("<span class='notice'>[usr] enables the turret's tracking system.</span>")
	return

/*
Interaction Ends
*/

/obj/machinery/spiderturret/attack_hand(mob/user)
	return

/obj/machinery/spiderturret/attack_ai(mob/user)
	return attack_hand(user)


/obj/machinery/spiderturret/attack_alien(mob/user as mob)
	user.changeNext_move(8)
	user.visible_message("[user] slashes at [src]", "You slash at [src]")
	take_damage(15)
	return

/obj/machinery/spiderturret/proc/validate_target(atom/target)
	if(get_dist(target, src)>scan_range)
		return 0			//If greater than scanrange then forget about it
	if(istype(target, /mob))
		var/mob/M = target
		if(!M.stat)
			return 1
	else if(istype(target, /obj/mecha))
		var/obj/mecha/M = target
		if(M.occupant)
			return 1
	return 0


/obj/machinery/spiderturret/process()
	if(state == 2)
		return
	if(cur_target && !validate_target(cur_target))
		cur_target = null
	if(!cur_target)
		cur_target = get_target()
	if(cur_target)
		fire(cur_target)
	return


/obj/machinery/spiderturret/proc/get_target()
	var/list/pos_targets = list()
	var/target = null
	for(var/mob/living/M in view(scan_range,src))
		if(M.stat || length(factions & M.factions))
			continue			//if he is in our factions list then forget about it
		pos_targets += M
	for(var/obj/mecha/M in oview(scan_range, src))
		if(M.occupant)
			if(length(factions & M.occupant.factions))
				continue
		if(!M.occupant)
			continue //Don't shoot at empty mechs.
		pos_targets += M
	if(pos_targets.len)
		target = pick(pos_targets)
	return target


/obj/machinery/spiderturret/proc/fire(atom/target)
	if(!target)
		cur_target = null
		return
	src.dir = get_dir(src,target)
	var/turf/targloc = get_turf(target)
	if(!src)
		return
	var/turf/curloc = get_turf(src)
	if (!targloc || !curloc)
		return
	if (targloc == curloc)
		return
	playsound(src, firesound, 50, 1)
	var/obj/item/projectile/A = new ordinance(curloc)
	A.current = curloc
	A.yo = targloc.y - curloc.y
	A.xo = targloc.x - curloc.x
	spawn(0)
		A.process()
	return

/*
Variants
*/

/obj/machinery/spiderturret/lasgun
	name = "Las Spider Turret"
	desc = "Imperial Spider Turret. Constructed with simple componants and eager to prove itself on the battlefield."
	density = 1
	anchored = 1
	health = 200
	firesound = 'sound/weapons/Laser2.ogg'
	ordinance = /obj/item/projectile/bullet/lasgun
	icon = 'icons/obj/turrets3.dmi'
	icon_state = "syndieturret0"
	boxedver = /obj/structure/spiderturretbox/lasgun

/obj/machinery/spiderturret/plasma
	name = "Plasma Spider Turret"
	desc = "Imperial Spider Turret. Constructed with simple componants and eager to prove itself on the battlefield."
	density = 1
	anchored = 1
	health = 200
	firesound = 'sound/weapons/plasma.ogg'
	ordinance = /obj/item/projectile/energy/plasma
	icon = 'icons/obj/turrets4.dmi'
	icon_state = "syndieturret0"
	boxedver = /obj/structure/spiderturretbox/plasma

/obj/machinery/spiderturret/projectile
	name = "Projectile Spider Turret"
	desc = "Imperial Spider Turret. Constructed with simple componants and eager to prove itself on the battlefield."
	density = 1
	anchored = 1
	health = 200
	ordinance = /obj/item/projectile/bullet/weakbullet3
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndieturret0"
	boxedver = /obj/structure/spiderturretbox/projectile

/obj/machinery/spiderturret/taser
	name = "Taser Spider Turret"
	desc = "Imperial Spider Turret. Constructed with simple componants and eager to prove itself on the battlefield."
	density = 1
	anchored = 1
	health = 200
	ordinance = /obj/item/projectile/energy/electrode
	firesound = 'sound/weapons/taser.ogg'
	icon = 'icons/obj/turrets2.dmi'
	icon_state = "syndieturret0"
	boxedver = /obj/structure/spiderturretbox/taser