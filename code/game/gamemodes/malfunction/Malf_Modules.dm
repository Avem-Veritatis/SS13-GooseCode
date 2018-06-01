
/datum/AI_Module
	var/uses = 0
	var/module_name
	var/mod_pick_name
	var/description = ""
	var/engaged = 0
	var/cost = 5
	var/one_time = 0

	var/power_type


/datum/AI_Module/large/
	uses = 1

/datum/AI_Module/small/
	uses = 5


/datum/AI_Module/large/fireproof_core
	module_name = "Core upgrade"
	mod_pick_name = "coreup"
	description = "An upgrade to improve core resistance, making it immune to fire and heat. This effect is permanent."
	cost = 50
	one_time = 1

	power_type = /mob/living/silicon/ai/proc/fireproof_core

/mob/living/silicon/ai/proc/fireproof_core()
	set category = "Malfunction"
	set name = "Fireproof Core"
	for(var/mob/living/silicon/ai/ai in player_list)
		ai.fire_res_on_core = 1
	src.verbs -= /mob/living/silicon/ai/proc/fireproof_core
	src << "<span class='notice'>Core fireproofed.</span>"

/datum/AI_Module/large/upgrade_turrets
	module_name = "AI Turret upgrade"
	mod_pick_name = "turret"
	description = "Improves the firing speed and health of all AI turrets. This effect is permanent."
	cost = 50
	one_time = 1

	power_type = /mob/living/silicon/ai/proc/upgrade_turrets

/mob/living/silicon/ai/proc/upgrade_turrets()
	set category = "Malfunction"
	set name = "Upgrade Turrets"
	src.verbs -= /mob/living/silicon/ai/proc/upgrade_turrets
	for(var/obj/machinery/turret/turret in machines)
		turret.health += 30
		turret.shot_delay = 20
	src << "<span class='notice'>Turrets upgraded.</span>"

/datum/AI_Module/large/lockdown
	module_name = "Hostile Station Lockdown"
	mod_pick_name = "lockdown"
	description = "Take control of the airlock, blast door and fire control networks, locking them down. Caution! This command also electrifies all airlocks."
	cost = 20
	one_time = 1

	power_type = /mob/living/silicon/ai/proc/lockdown

/mob/living/silicon/ai/proc/lockdown()
	set category = "Malfunction"
	set name = "Initiate Hostile Lockdown"

	if(src.stat == 2)
		src <<"You cannot begin a lockdown because you are dead!"
		return

	for(var/obj/machinery/firealarm/FA in machines) //activate firealarms
		spawn()
			FA.alarm()
	for(var/obj/machinery/door/poddoor/BD in world) //Close blast doors!
		spawn()
			BD.close()
	for(var/obj/machinery/door/airlock/AL in world) //shock-bolt airlocks
		spawn()
			if(AL.canAIControl() && !AL.stat) //Must be powered and have working AI wire.
				AL.locked = 0
				AL.safe = 0
				AL.close()
				AL.locked = 1
				AL.lights = 0
				AL.secondsElectrified = -1

	var/obj/machinery/computer/communications/C = locate() in world
	if(C)
		C.post_status("alert", "lockdown")

	src.verbs += /mob/living/silicon/ai/proc/disablelockdown
	src << "<span class = 'warning'>Lockdown Initiated.</span>"

/mob/living/silicon/ai/proc/disablelockdown()
	set category = "Malfunction"
	set name = "Disable Lockdown"

	if(src.stat == 2)
		src <<"You cannot disable lockdown because you are dead!"
		return

	for(var/obj/machinery/firealarm/FA in machines) //deactivate firealarms
		spawn()
			FA.reset()
	for(var/obj/machinery/door/poddoor/BD in world) //Open blast doors!
		spawn()
			BD.open()
	for(var/obj/machinery/door/airlock/AL in world) //unbolt and open airlocks
		spawn()
			if(AL.canAIControl() && !AL.stat)

				AL.locked = 0
				AL.secondsElectrified = 0
				AL.open()
				AL.safe = 1
				AL.lights = 1

	src << "<span class = 'notice'>Lockdown Lifted.</span>"

/datum/AI_Module/large/disable_rcd
	module_name = "RCD disable"
	mod_pick_name = "rcd"
	description = "Send a specialised pulse to break all RCD devices on the station."
	cost = 50

	power_type = /mob/living/silicon/ai/proc/disable_rcd

/mob/living/silicon/ai/proc/disable_rcd()
	set category = "Malfunction"
	set name = "Disable RCDs"
	for(var/datum/AI_Module/large/disable_rcd/rcdmod in current_modules)
		if(rcdmod.uses > 0)
			rcdmod.uses --
			for(var/obj/item/weapon/rcd/rcd in world)
				rcd.disabled = 1
			for(var/obj/item/mecha_parts/mecha_equipment/tool/rcd/rcd in world)
				rcd.disabled = 1
			src << "<span class='warning>RCD-disabling pulse emitted.</span>"
		else src << "<span class='notice'>Out of uses.</span>"

/datum/AI_Module/small/overload_machine
	module_name = "Machine overload"
	mod_pick_name = "overload"
	description = "Overloads an electrical machine, causing a small explosion. 2 uses."
	uses = 2
	cost = 15

	power_type = /mob/living/silicon/ai/proc/overload_machine

/mob/living/silicon/ai/proc/overload_machine(obj/machinery/M as obj in world)
	set name = "Overload Machine"
	set category = "Malfunction"
	if (istype(M, /obj/machinery))
		for(var/datum/AI_Module/small/overload_machine/overload in current_modules)
			if(overload.uses > 0)
				overload.uses --
				for(var/mob/V in hearers(M, null))
					V.show_message("\blue You hear a loud electrical buzzing sound!", 2)
				src << "<span class='warning'>Overloading machine circuitry...</span>"
				spawn(50)
					if(M)
						explosion(get_turf(M), 0,1,1,0)
						qdel(M)
			else src << "<span class='notice'>Out of uses.</span>"
	else src << "<span class='notice'>That's not a machine.</span>"

/datum/AI_Module/small/override_machine
	module_name = "Machine override"
	mod_pick_name = "override"
	description = "Overrides a machine's programming, causing it to rise up and attack everyone except other machines. 4 uses."
	uses = 4
	cost = 15

	power_type = /mob/living/silicon/ai/proc/override_machine


/mob/living/silicon/ai/proc/override_machine(obj/machinery/M as obj in world)
	set name = "Override Machine"
	set category = "Malfunction"
	if (istype(M, /obj/machinery))
		for(var/datum/AI_Module/small/override_machine/override in current_modules)
			if(override.uses > 0)
				override.uses --
				for(var/mob/V in hearers(M, null))
					V.show_message("\blue You hear a loud electrical buzzing sound!", 2)
				src << "<span class='warning'>Reprogramming machine behaviour...</span>"
				spawn(50)
					if(M)
						new /mob/living/simple_animal/hostile/mimic/copy/machine(get_turf(M), M, src, 1)
			else src << "<span class='notice'>Out of uses.</span>"
	else src << "<span class='notice'>That's not a machine.</span>"

/datum/AI_Module/large/place_cyborg_transformer
	module_name = "Robotic Factory (Removes Shunting)"
	mod_pick_name = "cyborgtransformer"
	description = "Build a machine anywhere, using expensive nanomachines, that can convert a living human into a loyal cyborg slave when placed inside."
	cost = 100

	power_type = /mob/living/silicon/ai/proc/place_transformer

/mob/living/silicon/ai/proc/place_transformer()
	set name = "Place Robotic Factory"
	set category = "Malfunction"

	if(!eyeobj)
		return

	if(!isturf(src.loc)) // AI must be in it's core.
		return

	var/datum/AI_Module/large/place_cyborg_transformer/PCT = locate() in src.current_modules
	if(!PCT)
		return

	if(PCT.uses < 1)
		src << "Out of uses."
		return

	var/sure = alert(src, "Make sure the room it is in is big enough, there is camera vision and that there is a 1x3 area for the machine. Are you sure you want to place the machine here?", "Are you sure?", "Yes", "No")
	if(sure != "Yes")
		return

	// Make sure there is enough room.
	var/turf/middle = get_turf(eyeobj.loc)
	var/list/turfs = list(middle, locate(middle.x - 1, middle.y, middle.z), locate(middle.x + 1, middle.y, middle.z))

	var/alert_msg = "There isn't enough room. Make sure you are placing the machine in a clear area and on a floor."

	var/datum/camerachunk/C = cameranet.getCameraChunk(middle.x, middle.y, middle.z)
	if(!C.visibleTurfs[middle])
		alert(src, "We cannot get camera vision of this location.")
		return

	for(var/T in turfs)

		// Make sure the turfs are clear and the correct type.
		if(!istype(T, /turf/simulated/floor))
			alert(src, alert_msg)
			return

		var/turf/simulated/floor/F = T
		for(var/atom/movable/AM in F.contents)
			if(AM.density)
				alert(src, alert_msg)
				return

	// All clear, place the transformer
	new /obj/machinery/transformer/conveyor(middle)
	playsound(middle, 'sound/effects/phasein.ogg', 100, 1)
	src.can_shunt = 0
	PCT.uses -= 1
	src << "<span class='warning'>You cannot shunt anymore.</span>"


/datum/AI_Module/small/blackout
	module_name = "Blackout"
	mod_pick_name = "blackout"
	description = "Attempts to overload the lighting circuits on the station, destroying some bulbs. 3 uses."
	uses = 3
	cost = 15

	power_type = /mob/living/silicon/ai/proc/blackout

/mob/living/silicon/ai/proc/blackout()
	set category = "Malfunction"
	set name = "Blackout"
	for(var/datum/AI_Module/small/blackout/blackout in current_modules)
		if(blackout.uses > 0)
			blackout.uses --
			for(var/obj/machinery/power/apc/apc in world)
				if(prob(30*apc.overload))
					apc.overload_lighting()
				else apc.overload++
			src << "<span class='notice'>Overcurrent applied to the powernet.</span>"
		else src << "<span class='notice'>Out of uses.</span>"

/datum/AI_Module/small/interhack
	module_name = "Hack intercept"
	mod_pick_name = "interhack"
	description = "Hacks the status update from Centcom, removing any information about malfunctioning electrical systems."
	cost = 15
	one_time = 1

	power_type = /mob/living/silicon/ai/proc/interhack

/mob/living/silicon/ai/proc/interhack()
	set category = "Malfunction"
	set name = "Hack intercept"
	src.verbs -= /mob/living/silicon/ai/proc/interhack

	if(game_is_malf_mode(ticker.mode))
		var/datum/game_mode/malfunction/Malf = ticker.mode
		Malf.hack_intercept()
		src << "<span class='notice'>Status update intercepted and modified.</span>"

/datum/AI_Module/small/reactivate_camera
	module_name = "Reactivate camera"
	mod_pick_name = "recam"
	description = "Reactivates a currently disabled camera. 5 uses."
	uses = 5
	cost = 5

	power_type = /mob/living/silicon/ai/proc/reactivate_camera

/mob/living/silicon/ai/proc/reactivate_camera(obj/machinery/camera/C as obj in cameranet.cameras)
	set name = "Reactivate Camera"
	set category = "Malfunction"
	if (istype (C, /obj/machinery/camera))
		for(var/datum/AI_Module/small/reactivate_camera/camera in current_modules)
			if(camera.uses > 0)
				if(!C.status)
					C.deactivate(src)
					camera.uses --
					src << "<span class='notice'>Camera reactivated.</span>"
				else
					src << "<span class='notice'>This camera is either active, or not repairable.</span>"
			else src << "<span class='notice'>Out of uses.</span>"
	else src << "<span class='notice'>That's not a camera.</span>"

/datum/AI_Module/small/upgrade_camera
	module_name = "Upgrade Camera"
	mod_pick_name = "upgradecam"
	description = "Upgrades a camera to have X-ray vision, motion sensing and be EMP-Proof. 5 uses."
	uses = 5
	cost = 5

	power_type = /mob/living/silicon/ai/proc/upgrade_camera

/mob/living/silicon/ai/proc/upgrade_camera(obj/machinery/camera/C as obj in cameranet.cameras)
	set name = "Upgrade Camera"
	set category = "Malfunction"
	if(istype(C))
		var/datum/AI_Module/small/upgrade_camera/UC = locate(/datum/AI_Module/small/upgrade_camera) in current_modules
		if(UC)
			if(UC.uses > 0)
				if(C.assembly)
					var/upgraded = 0

					if(!C.isXRay())
						C.upgradeXRay()
						//Update what it can see.
						cameranet.updateVisibility(C, 0)
						upgraded = 1

					if(!C.isEmpProof())
						C.upgradeEmpProof()
						upgraded = 1

					if(!C.isMotion())
						C.upgradeMotion()
						upgraded = 1
						// Add it to machines that process
						machines |= C

					if(upgraded)
						UC.uses --
						C.visible_message("<span class='notice'>\icon[C] *beep*</span>")
						src << "<span class='notice'>Camera successully upgraded!</span>"
					else
						src << "<span class='notice'>This camera is already upgraded!</span>"
			else
				src << "<span class='notice'>Out of uses.</span>"


/datum/module_picker
	var/temp = null
	var/processing_time = 100
	var/list/possible_modules = list()

/datum/module_picker/New()
	for(var/type in typesof(/datum/AI_Module))
		var/datum/AI_Module/AM = new type
		if(AM.power_type != null)
			src.possible_modules += AM

/datum/module_picker/proc/remove_verbs(var/mob/living/silicon/ai/A)

	for(var/datum/AI_Module/AM in possible_modules)
		A.verbs.Remove(AM.power_type)


/datum/module_picker/proc/use(user as mob)
	var/dat
	dat = "<B>Select use of processing time: (currently #[src.processing_time] left.)</B><BR>"
	dat += "<HR>"
	dat += "<B>Install Module:</B><BR>"
	dat += "<I>The number afterwards is the amount of processing time it consumes.</I><BR>"
	for(var/datum/AI_Module/large/module in src.possible_modules)
		dat += "<A href='byond://?src=\ref[src];[module.mod_pick_name]=1'>[module.module_name]</A><A href='byond://?src=\ref[src];showdesc=[module.mod_pick_name]'>\[?\]</A> ([module.cost])<BR>"
	for(var/datum/AI_Module/small/module in src.possible_modules)
		dat += "<A href='byond://?src=\ref[src];[module.mod_pick_name]=1'>[module.module_name]</A><A href='byond://?src=\ref[src];showdesc=[module.mod_pick_name]'>\[?\]</A> ([module.cost])<BR>"
	dat += "<HR>"
	if (src.temp)
		dat += "[src.temp]"
	var/datum/browser/popup = new(user, "modpicker", "Malf Module Menu")
	popup.set_content(dat)
	popup.open()
	return

/datum/module_picker/Topic(href, href_list)
	..()

	if(!isAI(usr))
		return
	var/mob/living/silicon/ai/A = usr

	for(var/datum/AI_Module/AM in possible_modules)
		if (href_list[AM.mod_pick_name])

			// Cost check
			if(AM.cost > src.processing_time)
				temp = "You cannot afford this module."
				break

			// Add new uses if we can, and it is allowed.
			var/datum/AI_Module/already_AM = locate(AM.type) in A.current_modules
			if(already_AM)
				if(!AM.one_time)
					already_AM.uses += AM.uses
					src.processing_time -= AM.cost
					temp = "Additional use added to [already_AM.module_name]"
					break
				else
					temp = "This module is only needed once."
					break

			// Give the power and take away the money.
			A.verbs += AM.power_type
			A.current_modules += new AM.type
			temp = AM.description
			src.processing_time -= AM.cost

		if(href_list["showdesc"])
			if(AM.mod_pick_name == href_list["showdesc"])
				temp = AM.description
	src.use(usr)
	return
