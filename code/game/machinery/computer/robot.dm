//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31


/obj/machinery/computer/robotics
	name = "robotics control console"
	desc = "Used to remotely lockdown or detonate linked Cyborgs."
	icon = 'icons/obj/computer.dmi'
	icon_state = "robot"
	req_access = list(access_robotics)
	circuit = /obj/item/weapon/circuitboard/robotics
	var/temp = null

/obj/machinery/computer/robotics/proc/can_control(var/mob/user, var/mob/living/silicon/robot/R)
	if(!istype(R))
		return 0
	if(istype(user, /mob/living/silicon/ai))
		if (R.connected_ai != user)
			return 0
	if(istype(user, /mob/living/silicon/robot))
		if (R != user)
			return 0
	if(R.scrambledcodes)
		return 0
	return 1

/obj/machinery/computer/robotics/attack_hand(var/mob/user as mob)
	if(..())
		return
	interact(user)

/obj/machinery/computer/robotics/interact(var/mob/user as mob)
	if (src.z > 6)
		user << "\red <b>Unable to establish a connection</b>: \black You're too far away from the station!"
		return
	user.set_machine(src)
	var/dat
	var/robots = 0
	for(var/mob/living/silicon/robot/R in mob_list)
		if(!can_control(user, R))
			continue
		robots++
		dat += "[R.name] |"
		if(R.stat)
			dat += " Not Responding |"
		else if (!R.canmove)
			dat += " Locked Down |"
		else
			dat += " Operating Normally |"
		if (!R.canmove)
		else if(R.cell)
			dat += " Battery Installed ([R.cell.charge]/[R.cell.maxcharge]) |"
		else
			dat += " No Cell Installed |"
		if(R.module)
			dat += " Module Installed ([R.module.name]) |"
		else
			dat += " No Module Installed |"
		if(R.connected_ai)
			dat += " Slaved to [R.connected_ai.name] |"
		else
			dat += " Independent from AI |"
		if (istype(user, /mob/living/silicon))
			if(issilicon(user) && is_special_character(user) && !R.emagged)
				dat += "<A href='?src=\ref[src];magbot=\ref[R]'>(<font color=blue><i>Hack</i></font>)</A> "
		dat += "<A href='?src=\ref[src];stopbot=\ref[R]'>(<font color=green><i>[R.canmove ? "Lockdown" : "Release"]</i></font>)</A> "
		dat += "<A href='?src=\ref[src];killbot=\ref[R]'>(<font color=red><i>Destroy</i></font>)</A>"
		dat += "<BR>"

	if(!robots)
		dat += "No Cyborg Units detected within access parameters."

	var/datum/browser/popup = new(user, "computer", "Cyborg Control Console", 400, 500)
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	return

/obj/machinery/computer/robotics/Topic(href, href_list)
	if(..())
		return

	if (href_list["temp"])
		src.temp = null

	else if (href_list["killbot"])
		if(src.allowed(usr))
			var/mob/living/silicon/robot/R = locate(href_list["killbot"])
			if(can_control(usr, R))
				var/choice = input("Are you certain you wish to detonate [R.name]?") in list("Confirm", "Abort")
				if(choice == "Confirm" && can_control(usr, R) && !..())
					if(R.mind && R.mind.special_role && R.emagged)
						R << "Extreme danger.  Termination codes detected.  Scrambling security codes and automatic AI unlink triggered."
						R.ResetSecurityCodes()
					else
						message_admins("\blue [key_name_admin(usr)] detonated [R.name]!")
						log_game("\blue [key_name(usr)] detonated [R.name]!")
						R.self_destruct()
		else
			usr << "\red Access Denied."

	else if (href_list["stopbot"])
		if(src.allowed(usr))
			var/mob/living/silicon/robot/R = locate(href_list["stopbot"])
			if(can_control(usr, R))
				var/choice = input("Are you certain you wish to [R.canmove ? "lock down" : "release"] [R.name]?") in list("Confirm", "Abort")
				if(choice == "Confirm" && can_control(usr, R) && !..())
					message_admins("\blue [key_name_admin(usr)] [R.canmove ? "locked down" : "released"] [R.name]!")
					log_game("[key_name(usr)] [R.canmove ? "locked down" : "released"] [R.name]!")
					R.SetLockdown(!R.lockcharge)
					R << "[!R.lockcharge ? "<span class='notice'>Your lockdown has been lifted!" : "<span class='alert'>You have been locked down!"]</span>"

		else
			usr << "\red Access Denied."

	else if (href_list["magbot"])
		if(issilicon(usr) && is_special_character(usr))
			var/mob/living/silicon/robot/R = locate(href_list["magbot"])
			if(istype(R) && !R.emagged && R.connected_ai == usr && !R.scrambledcodes && can_control(usr, R))
				log_game("[key_name(usr)] emagged [R.name] using robotic console!")
				R.SetEmagged(1)
				if(R.mind.special_role)
					R.verbs += /mob/living/silicon/robot/proc/ResetSecurityCodes

	src.updateUsrDialog()
	return
