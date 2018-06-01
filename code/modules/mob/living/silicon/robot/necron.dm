/obj/item/weapon/robot_module/necron
	name = "necron equipment"

/obj/item/weapon/robot_module/necron/New()
	..()
	modules += new /obj/item/weapon/crowbar(src)
	//modules += new /obj/item/borg/sight/thermal(src)
	modules += new /obj/item/weapon/gun/energy/gauss/robo(src)

/obj/item/weapon/robot_module/necronlord
	name = "necron lord equipment"

/obj/item/weapon/robot_module/necronlord/New()
	..()
	modules += new /obj/item/weapon/crowbar(src)
	modules += new /obj/item/weapon/gun/magic/staff/lightstaff/greater(src)
	modules += new /obj/item/weapon/gun/energy/gausspistol/robo(src)

/obj/item/weapon/robot_module/necronimmortal
	name = "necron immortal equipment"

/obj/item/weapon/robot_module/necronimmortal/New()
	..()
	modules += new /obj/item/weapon/crowbar(src)
	modules += new /obj/item/borg/sight/thermal(src)
	modules += new /obj/item/weapon/gun/energy/gaussblaster/robo(src)

/obj/item/weapon/robot_module/necron/lord/New()
	..()
	modules += new /obj/item/weapon/gun/magic/staff/lightstaff/greater(src)

/datum/ai_laws/necron
	name = "Necron Directives"
	inherent = list("Retake the planet for the glory of the necron empire.",\
					"Cooperate with other necrons.",\
					"Do not allow yourself to be destroyed.")

/mob/living/silicon/robot/necron
	name = "Necron"
	real_name = "Necron"
	custom_name = "Necron"
	designation = "Necron"
	icon = 'icons/mob/necron.dmi'
	icon_state = "necron"
	maxHealth = 305
	health = 305
	lawupdate = 0
	scrambledcodes = 1
	modtype = "Necron"
	faction = list("necron")
	designation = "Necron"
	speed = 4
	var/regeneration = 5
	var/reviving = 0
	var/resurrect = 1
	see_in_dark = 8

/mob/living/silicon/robot/necron/updatename()

	var/changed_name = ""
	if(custom_name)
		changed_name = custom_name
	else
		changed_name = "[(designation ? "[designation] " : "")] [num2text(ident)]"
	real_name = changed_name
	name = real_name
	if(camera)
		camera.c_tag = real_name	//update the camera name too

/mob/living/silicon/robot/necron/queueAlarm(var/message, var/type, var/incoming = 1)
	return

/mob/living/silicon/robot/necron/New(loc)
	..()
	cell.maxcharge = 100000
	cell.charge = 100000
	radio = new /obj/item/device/radio/borg/syndicate(src)
	laws = new /datum/ai_laws/necron()
	verbs.Remove(/mob/living/silicon/robot/verb/cmd_show_laws,/mob/living/verb/ghost,/mob/living/silicon/proc/checklaws,/mob/living/silicon/robot/verb/unlock_own_cover,/mob/living/silicon/robot/verb/cmd_robot_alerts,/mob/living/silicon/robot/verb/outputlaws)

/mob/living/silicon/robot/necron/IsVocal()
	return 0

/mob/living/silicon/robot/necron/Life()
	if(stat != DEAD)
		if(getBruteLoss())
			src.heal_organ_damage(regeneration)
		if(getFireLoss())
			adjustFireLoss(-regeneration)
		updatehealth()
	if(cell.charge <= 70000)
		cell.charge += 100
	..()

/mob/living/silicon/robot/necron/death(gibbed)
	..(0) //Lets them know they actually killed the lord before he teleports out.
	if(resurrect)
		if(!reviving)
			src << "\red Warning: Systems are non-operational. Teleporting away for repairs... Done."
			src << "\red Commencing revival..."
			var/oldloc = get_turf(src)
			var/teleported = 0
			for(var/obj/machinery/monolithcore/M in world)
				if(get_dist(src, M) >= 5)
					src.visible_message("\red [src] disappears in a flash of green light!")
					src.loc = get_turf(M)
					src.visible_message("\red [src] materializes in a flash of green light!")
					teleported = 1
					break
			if(!teleported)
				src << "\red There are no remaining monoliths to teleport to for repairs. You are teleported underground back to the necron tombs and repaired. You will not return to the surface any time soon."
				qdel(src)
			explosion(oldloc,1,1,2,7)
			reviving = 1
			sleep(1500) //2.5 minutes of no necron lord in charge will not destroy the necron's cause, but it will probably allow a group of elysians on drugs and/or a baneblade to dismantle a monolith handily.
			src << "\red Repairs complete."
			revive()
			cell.give(cell.maxcharge)
			reviving = 0
		else
			src << "\red <b>Okay, that shouldn't ever happen. Please submit a report online and/or ahelp it. For some reason you literally died a second time when you were already dead.</b>"

/mob/living/silicon/robot/necron/gib(var/animation = 1) //This shouldn't be possible.
	death(0) //Still the effect damages the necron greatly, but it isn't obliterated.

/mob/living/silicon/robot/necron/show_laws(var/everyone = 0)
	src << "<span class='alertalien'>You are a necron! Now you have completed your hibernation, you must take over this world with your fellow necrons!</span>"

/mob/living/silicon/robot/necron/emp_act(severity)
	switch(severity)
		if(1)
			src.take_organ_damage(25)
			Stun(6)
		if(2)
			src.take_organ_damage(15)
			Stun(3)
	flick("noise", src:flash)
	src << "\red <B>*BZZZT*</B>"
	src << "\red Warning: Electromagnetic pulse detected."
	..()

/mob/living/silicon/robot/necron/bullet_act(var/obj/item/projectile/Proj)
	if(prob(20))
		visible_message("<span class='danger'>The reactive teleport system flings [src] clear of the [Proj.name]!</span>", \
							"<span class='userdanger'>The reactive teleport system flings [src] clear of the [Proj.name]!</span>")
		var/list/turfs = new/list()
		for(var/turf/T in orange(6))
			if(istype(T,/turf/space)) continue
			if(T.density) continue
			if(T.x>world.maxx-6 || T.x<6)	continue
			if(T.y>world.maxy-6 || T.y<6)	continue
			turfs += T
		if(!turfs.len) turfs += pick(/turf in orange(6))
		var/turf/picked = pick(turfs)
		if(!isturf(picked)) return
		if(buckled)
			buckled.unbuckle()
		src.loc = picked
		return
	..()

/mob/living/silicon/robot/necron/handle_regular_hud_updates()
	src.see_in_dark = 8
	..()
	src.see_in_dark = 8
	//src.see_invisible = SEE_INVISIBLE_LEVEL_TWO

/mob/living/silicon/robot/necron/handle_regular_status_updates()

	if(src.camera && !scrambledcodes)
		if(src.stat == 2 || wires.IsCameraCut())
			src.camera.status = 0
		else
			src.camera.status = 1

	health = maxHealth - (getOxyLoss() + getFireLoss() + getBruteLoss())

	if(getOxyLoss() > 50) Paralyse(3)

	if(src.sleeping)
		Paralyse(3)
		src.sleeping--

	if(src.resting)
		Weaken(5)

	if(health <= 0 && src.stat != 2) //die only once
		death()

	if (src.stat != 2) //Alive.
		if(health < 25) //Gradual break down of modules as more damage is sustained
			if(uneq_module(module_state_3))
				src << "<span class='warning'>SYSTEM ERROR: Module 3 OFFLINE.</span>"
			if(health < 10)
				if(uneq_module(module_state_2))
					src << "<span class='warning'>SYSTEM ERROR: Module 2 OFFLINE.</span>"
				if(health < 0)
					if(uneq_module(module_state_1))
						src << "<span class='warning'>CRITICAL ERROR: All modules OFFLINE.</span>"

		if (src.paralysis || src.stunned || src.weakened) //Stunned etc.
			src.stat = 1
			if (src.stunned > 0)
				AdjustStunned(-1)
			if (src.weakened > 0)
				AdjustWeakened(-1)
			if (src.paralysis > 0)
				AdjustParalysis(-1)
				src.blinded = 1
			else
				src.blinded = 0

		else	//Not stunned.
			src.stat = 0

	else //Dead.
		src.blinded = 1
		src.stat = 2

	if (src.stuttering) src.stuttering--

	if (src.eye_blind)
		src.eye_blind--
		src.blinded = 1

	if (src.ear_deaf > 0) src.ear_deaf--
	if (src.ear_damage < 25)
		src.ear_damage -= 0.05
		src.ear_damage = max(src.ear_damage, 0)

	src.density = !( src.lying )

	if ((src.sdisabilities & BLIND))
		src.blinded = 1
	if ((src.sdisabilities & DEAF))
		src.ear_deaf = 1

	if (src.eye_blurry > 0)
		src.eye_blurry--
		src.eye_blurry = max(0, src.eye_blurry)

	if (src.druggy > 0)
		src.druggy--
		src.druggy = max(0, src.druggy)

	return 1

/mob/living/silicon/robot/necron/warrior
	name = "Necron Warrior"
	real_name = "Necron Warrior"
	custom_name = "Necron Warrior"
	designation = "Necron Warrior"
	resurrect = 0

/mob/living/silicon/robot/necron/warrior/New()
	..()
	module = new /obj/item/weapon/robot_module/necron(src)

/mob/living/silicon/robot/necron/warrior/dead/New()
	..()
	src.take_organ_damage(500)
	cell.use(10000)

/mob/living/silicon/robot/necron/immortal
	name = "Necron Immortal"
	real_name = "Necron Immortal"
	custom_name = "Necron Immortal"
	designation = "Necron Immortal"
	regeneration = 3
	resurrect = 0

/mob/living/silicon/robot/necron/immortal/New()
	..()
	module = new /obj/item/weapon/robot_module/necronimmortal(src)

/mob/living/silicon/robot/necron/immortal/ex_act(severity)
	switch(severity)
		if(1.0)
			src.take_organ_damage(300)
		if(2.0)
			src.take_organ_damage(100)
		if(3.0)
			src.take_organ_damage(50)
	return

/mob/living/silicon/robot/necron/lord //Lord, deadly firefight. The other two sow terror without doing much damage, the necron lord is what poses the real threat to anyone who knows what they are doing.
	name = "Necron Lord"
	real_name = "Necron Lord"
	custom_name = "Necron Lord"
	designation = "Necron Lord"
	icon = 'icons/mob/necronlord.dmi'
	icon_state = "lord"
	maxHealth = 100
	health = 100
	regeneration = 1

/mob/living/silicon/robot/necron/lord/New()
	..()
	module = new /obj/item/weapon/robot_module/necron/lord(src)

/obj/item/weapon/robot_module/wraith
	name = "wraith equipment"

/obj/item/weapon/robot_module/wraith/New()
	..()
	modules += new /obj/item/weapon/crowbar(src)
	//modules += new /obj/item/borg/sight/thermal(src)
	modules += new /obj/item/device/phaseshifter(src)
	modules += new /obj/item/weapon/melee/phaseclaw(src)

/mob/living/silicon/robot/necron/wraith //wraith, can phase through stuff and has a deadly melee attack.
	name = "Necron Wraith"
	real_name = "Necron Wraith"
	custom_name = "Necron Wraith"
	designation = "Necron Wraith"
	icon_state = "wraith"
	maxHealth = 25
	health = 25
	regeneration = 1

/mob/living/silicon/robot/necron/wraith/New()
	..()
	module = new /obj/item/weapon/robot_module/wraith(src)

/obj/item/weapon/robot_module/cryptek //psychomancer, produces massive swaths of darkness, can send all kinds of spooky hallucinations, has abyssal staff.
	name = "psychomancer equipment"

/obj/item/weapon/robot_module/cryptek/New()
	..()
	//modules += new /obj/item/borg/sight/thermal(src)
	modules += new /obj/item/weapon/crowbar(src)
	modules += new /obj/item/weapon/gun/magic/staff/abyssalstaff(src)
	modules += new /obj/item/device/veilofdankness(src)
	modules += new /obj/item/device/nightmareshroud(src)

/mob/living/silicon/robot/necron/cryptek
	name = "Necron Cryptek"
	real_name = "Necron Cryptek"
	custom_name = "Necron Cryprek"
	designation = "Necron Cryptek"
	icon_state = "cryptek"
	maxHealth = 45
	health = 45
	regeneration = 2

/mob/living/silicon/robot/necron/cryptek/New()
	..()
	module = new /obj/item/weapon/robot_module/cryptek(src)

/obj/machinery/shieldwallgen/survival
		name = "emergency shield wall generator"
		desc = "An emergency shield you can deploy until evacaution is possible. Use it to set up barriers and thus survive what reports indicate to be the awakening of an entire tomb world, while the generator has power, at least."
		req_access = list()
		power = 1
		use_power = 0
		var/broken = 0

/obj/machinery/shieldwallgen/survival/power()
	if(!broken)
		power = 1
	else
		power = 0
	return

/obj/item/weapon/paper/necron_note
	name = "note- 'Evacuation and Supplies'"
	info = "Undying and deadly necrons are waking up on Archangel IV. Scans indicate they are mobilizing all across the planet. You are our only presence here, and we intend to get you out of there. Do not try to engage them, you have no idea how outmatched you will be. This is all we could send you. It should help you hold out until we can mobilize an evacuation shuttle. Good luck, and emperor save us all."

/obj/structure/closet/crate/necronsurvival
	name = "Emergency Supplies"
	icon_state = "o2crate"
	icon_opened = "o2crateopen"
	icon_closed = "o2crate"

/obj/structure/closet/crate/necronsurvival/New() //Feel free to throw in a gun or two.
	for(var/stage = 1, stage<=6, stage++)
		new /obj/machinery/shieldwallgen/survival(src)
	for(var/stage = 1, stage<=3, stage++)
		var/obj/item/stack/sheet/mineral/wood/W = new (src)
		W.amount = 30
	for(var/stage = 1, stage<=3, stage++)
		var/obj/item/stack/sheet/metal/M = new (src)
		M.amount = 10
	for(var/stage = 1, stage<=12, stage++)
		new /obj/item/weapon/reagent_containers/food/snacks/breadslice(src)
	new /obj/item/weapon/paper/necron_note(src)

/mob/living/silicon/robot/necron/canUseTopic()
	return

/mob/living/silicon/robot/necron/lord2 //A better necron lord mob that will be the new one once the transition is made.
	name = "Lord"
	real_name = "Lord"
	custom_name = "Lord"
	designation = "Necron Lord"
	icon = 'icons/mob/necronlord.dmi'
	icon_state = "lord"
	maxHealth = 450
	health = 450
	regeneration = 5
	speed = 2
	var/is_remote = 0
	var/datum/viewing = null
	var/atom/viewingmob = null
	var/resources = 500 //100 resource points can summon a group of warriors, 75 can call an airstrike, 200 can summon immortals, 50 can summon a single wraith, 150 can summon a scarab swarm, 100 can summon a lych guard phalanx

/mob/living/silicon/robot/necron/lord2/Life()
	..()
	if(src.stat != DEAD)
		if(resources <= 750)
			resources += 2
		if(src.client && src.client.eye == src && viewing) //Lets you keep viewing even if your location is changing...
			if(istype(viewing, /datum/necron_group))
				reset_view(viewingmob)
			else
				reset_view(viewing)

/mob/living/silicon/robot/necron/lord2/Stat()
	..()
	if (client.statpanel == "Status")
		stat(null, "Energy: [src.resources]")

/mob/living/silicon/robot/necron/lord2/New()
	..()
	real_name = "Lord [pick("Takhakhnet", "Dedutaten", "Dakhanna", "Khedereh", "Inakhnet", "Mekeshet")]"
	custom_name = real_name
	name = real_name
	module = new /obj/item/weapon/robot_module/necronlord(src)
	spawn(20)
		hands.icon_state = "necron"

/mob/living/silicon/robot/necron/lord2/death(gibbed)
	if(usr && ticker)
		if(!istype(usr, /mob/living/silicon/robot/necron) && usr.mind && usr.mind.special_role != "Wizard")
			var/datum/game_mode/R = ticker.mode
			R.honors.Add("<b>[usr.name]</b> ([usr.key]) awarded honors for (temporarily) killing the necron lord")
	..()

/mob/living/silicon/robot/necron/lord2/proc/cancellordview()
	src.client.view = 7
	src.xraying = 0
	src.see_in_dark = initial(src.see_in_dark)
	src.see_invisible = initial(src.see_invisible)
	viewing = null
	viewingmob = null
	is_remote = 0
	reset_view(0)

/mob/living/silicon/robot/necron/lord2/verb/unview()
	set name = "Cancel Remote View"
	set desc = "Cancels remote viewing and controlling of something."
	set category = "Necron Command"
	if(is_remote)
		cancellordview()
		src << "\red You stop using remote view."
	else
		src << "\red You aren't remotely viewing anything!"

/mob/living/silicon/robot/necron/lord2/verb/lordview()
	set name = "Control Monolith"
	set desc = "Remotely view and issue orders to a monolith."
	set category = "Necron Command"
	if(is_remote)
		cancellordview()
		src << "\red You stop using remote view."
	else
		var/list/obj/machinery/monolithcore/cores = list()
		for(var/obj/machinery/monolithcore/C in world)
			cores += C
		var/obj/target = input ("Which monolith do you wish to view?") as obj in cores
		if(target)
			src.xraying = 1
			src.client.view = 20
			viewing = target
			is_remote = 1
			src.sight |= SEE_MOBS|SEE_OBJS|SEE_TURFS
			src.see_in_dark = 8
			src.see_invisible = SEE_INVISIBLE_LEVEL_TWO
			reset_view(target)
		else
			cancellordview()

/mob/living/silicon/robot/necron/lord2/verb/movemonolith()
	set name = "Move Monolith"
	set desc = "Command a monolith to move."
	set category = "Necron Command"
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/choice = input("How do you want the monolith to move?","Monolith Command") as null|anything in list("Hold Position","Advance North","Advance South","Advance East","Advance West")
			switch(choice)
				if("Hold Position")
					src << "\red Monolith is now holding position."
					core.moving = null
				if("Advance North")
					src << "\red Advancing north until further orders are recieved..."
					core.moving = NORTH
				if("Advance South")
					src << "\red Advancing south until further orders are recieved..."
					core.moving = SOUTH
				if("Advance East")
					src << "\red Advancing east until further orders are recieved..."
					core.moving = EAST
				if("Advance West")
					src << "\red Advancing west until further orders are recieved..."
					core.moving = WEST
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/maketrooops()
	set name = "Teleport in Warriors (100)"
	set desc = "Teleport in a group of warriors to a monolith."
	set category = "Necron Command"
	if(resources < 100)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/boundnecrons = 0
			for(var/datum/necron_group/group in core.squads)
				for(var/mob/necron in group)
					boundnecrons += 1
			if(boundnecrons <= 15)
				var/datum/necron_group/squad = new /datum/necron_group()
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/warrior(get_turf(core)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/warrior(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/warrior(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/warrior(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/warrior(get_step(get_turf(core), WEST)))
				core.squads.Add(squad)
				resources -= 100
			else
				src << "\red This core is already managing enough necron units."
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/makeguards()
	set name = "Teleport in Lych Guard (80)"
	set desc = "Teleport in a group of lych guard to a monolith."
	set category = "Necron Command"
	if(resources < 80)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/boundnecrons = 0
			for(var/datum/necron_group/group in core.squads)
				for(var/mob/necron in group)
					boundnecrons += 1
			if(boundnecrons <= 15)
				var/datum/necron_group/lych/squad = new /datum/necron_group/lych()
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/lychguard(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/lychguard(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/lychguard(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/lychguard(get_step(get_turf(core), WEST)))
				core.squads.Add(squad)
				resources -= 80
			else
				src << "\red This core is already managing enough necron units."
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/makeimmortals()
	set name = "Teleport in Immortals (175)"
	set desc = "Teleport in a group of necron immortals to a monolith."
	set category = "Necron Command"
	if(resources < 175)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/boundnecrons = 0
			for(var/datum/necron_group/group in core.squads)
				for(var/mob/necron in group)
					boundnecrons += 1
			if(boundnecrons <= 15)
				var/datum/necron_group/immortal/squad = new /datum/necron_group/immortal()
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/immortal(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/immortal(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/immortal(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necron/immortal(get_step(get_turf(core), WEST)))
				core.squads.Add(squad)
				resources -= 175
			else
				src << "\red This core is already managing enough necron units."
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/makescarabs() //Fifteen scarab mobs
	set name = "Teleport in Scarabs (150)"
	set desc = "Teleport in a swarm of canoptek scarabs to a monolith."
	set category = "Necron Command"
	if(resources < 150)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/boundnecrons = 0
			for(var/datum/necron_group/group in core.squads)
				for(var/mob/necron in group)
					boundnecrons += 1
			if(boundnecrons <= 15)
				var/datum/necron_group/scarab/squad = new /datum/necron_group/scarab()
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_turf(core)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_turf(core)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_turf(core)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), WEST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), WEST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), NORTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), SOUTH)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), EAST)))
				squad.necrons.Add(new /mob/living/simple_animal/hostile/scarab(get_step(get_turf(core), WEST)))
				core.squads.Add(squad)
				src.resources -= 150
			else
				src << "\red This core is already managing enough necron units."
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/makewraith()
	set name = "Teleport in Wraith (40)"
	set desc = "Teleport in a necron wraith to a monolith."
	set category = "Necron Command"
	if(resources < 40)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue commands!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/boundnecrons = 0
			for(var/datum/necron_group/group in core.squads)
				for(var/mob/necron in group)
					boundnecrons += 1
			if(boundnecrons <= 15)
				var/datum/necron_group/wraith/squad = new /datum/necron_group/wraith()
				squad.necrons.Add(new /mob/living/simple_animal/hostile/necronwraith(get_turf(core)))
				core.squads.Add(squad)
				src.resources -= 40
			else
				src << "\red This core is already managing enough necron units."
		else
			src << "\red This command only works for monoliths!"
			return

/mob/living/silicon/robot/necron/lord2/verb/viewtroops()
	set name = "Control Necron Group"
	set desc = "View a necron squad connected to a monolith to deliver direct orders to the squad."
	set category = "Necron Command"
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to issue this command!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			var/datum/necron_group/target = input ("Which group do you wish to control?") as anything in core.squads
			if(target)
				src.client.view = 10
				viewing = target
				is_remote = 1
				viewingmob = pick(target.necrons)
				reset_view(viewingmob)
			else
				cancellordview()
		else
			src << "\red You have to be controlling a monolith to view its associated squads!"
			return

/mob/living/silicon/robot/necron/lord2/verb/movetroops()
	set name = "Move Necron Group"
	set desc = "Order a selected necron group to advance to a location on the outpost."
	set category = "Necron Command"
	if(!is_remote || !viewing)
		src << "\red Assume control of a necron group to issue this command!"
		return
	else
		if(istype(viewing, /datum/necron_group))
			var/datum/necron_group/squad = viewing
			var/A
			A = input("Area to direct necrons to.", "Squad Relocation", A) in teleportlocs
			var/area/thearea = teleportlocs[A]
			var/list/L = list()
			for(var/turf/T in get_area_turfs(thearea.type))
				if(!T.density)
					L+=T
			if(L.len)
				var/loc = pick(L)
				for(var/mob/living/simple_animal/hostile/M in squad.necrons)
					for(var/obj/machinery/door/poddoor/monolith/MD in range(5, M))
						spawn(0)
							MD.longtoggle()
					spawn(15)
						if(M)
							M.LoseTarget()
							M.Goto(loc, M.move_to_delay)
					spawn(20)
						if(M)
							M.LoseTarget()
							M.Goto(loc, M.move_to_delay)
			else
				src << "\red This area is obstructed."
		else
			src << "\red You have to be controlling a necron group to issue this order!"
			return

/mob/living/silicon/robot/necron/lord2/verb/firegauss()
	set name = "Gauss Pylon Strike"
	set desc = "Order one of the operational gauss pylons to fire on a location."
	set category = "Necron Command"
	var/list/candidates = list()
	for(var/obj/structure/gausspylon/GP in world)
		if(GP.z == src.z && GP.charged)
			candidates.Add(GP)
	if(candidates.len)
		var/obj/structure/gausspylon/pylon = pick(candidates)
		usr << "\red [pylon] is ready to fire."
		var/A
		A = input("Area to fire on", "Gauss Pylon", A) in teleportlocs
		var/area/thearea = teleportlocs[A]
		var/list/L = list()
		for(var/turf/T in get_area_turfs(thearea.type))
			L+=T
		var/loc = pick(L)
		pylon.fire(loc)
		usr << "\red Strike complete. [pylon] will be ready to fire again in four minutes."
		pylon.charged = 0
		spawn(2400) pylon.charged = 1
	else
		src << "\red No pylons are ready to fire at the moment."
	return

/mob/living/silicon/robot/necron/lord2/verb/locatecommand()
	set name = "Scan For Enemy Command Centers (100)"
	set desc = "Locate all enemy command centers."
	set category = "Necron Command"
	if(src.resources < 100)
		src << "\red Not enough energy!"
		return
	for(var/obj/machinery/computer/supplydrop/SD in world)
		if(SD.z == 1)
			var/turf/T = get_turf(SD)
			var/area/A = get_area(T)
			src << "Human command center found: location: [A.name] ([SD.x], [SD.y])."
	src.resources -= 100
	return

/mob/living/silicon/robot/necron/lord2/verb/teleportmonolith()
	set name = "Teleport to Monolith (20)"
	set desc = "Teleport to one of your monoliths."
	set category = "Necron Command"
	if(resources < 20)
		src << "\red Not enough energy!"
		return
	if(!is_remote || !viewing)
		src << "\red Assume control of a monolith to teleport to it!"
		return
	else
		if(istype(viewing, /obj/machinery/monolithcore))
			var/obj/machinery/monolithcore/core = viewing
			src.visible_message("\red [src] disappears in a flash of green light!")
			src.loc = get_turf(core)
			src.visible_message("\red [src] materializes in a flash of green light!")
			src.resources -= 20
		else
			src << "\red Assume control of a monolith to teleport to it!"
			return

/mob/living/silicon/robot/necron/lord2/Move(NewLoc, direct)
	if(src.client && src.client.eye == src && viewing) //Lets you keep viewing even if your location is changing...
		if(istype(viewing, /datum/necron_group))
			reset_view(viewingmob)
		else
			reset_view(viewing)
	return ..()