/obj/item/device/reportgen
	name = "Single Use Command Signal Duplicator"
	desc = "For creating fake transmissions for the outpost command staff. They will appear to come from Imperial Command."
	icon = 'icons/obj/device.dmi'
	icon_state	= "locator"
	w_class		= 1.0
	item_state	= "locator"
	throw_speed	= 4
	throw_range	= 20

/obj/item/device/reportgen/attack_self(mob/user)

	var/input = input(usr, "Please enter anything you want. Anything. Serious.", "What?", "") as message|null
	if(!input)
		return
	var/confirm = alert(src, "Do you want to announce the contents of the report to the crew?", "Announce", "Yes", "No")
	if(confirm == "Yes")
		priority_announce(input, null, 'sound/AI/commandreport.ogg');
		for (var/obj/machinery/computer/communications/C in machines)
			if(! (C.stat & (BROKEN|NOPOWER) ) )
				var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
				P.name = "paper- '[command_name()] Update.'"
				P.info = input
				C.messagetitle.Add("[command_name()] Update")
				C.messagetext.Add(P.info)
	else
		priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", 'sound/AI/commandreport.ogg');
		for (var/obj/machinery/computer/communications/C in machines)
			if(! (C.stat & (BROKEN|NOPOWER) ) )
				var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
				P.name = "paper- 'Classified [command_name()] Update.'"
				P.info = input
				C.messagetitle.Add("Classified [command_name()] Update")
				C.messagetext.Add(P.info)

	log_admin("[key_name(src)] has activated a traitor item and entered a fake command report for the outpost. It reads: [input]")
	message_admins("[key_name(src)]has activated a traitor item and entered a fake command report for the outpost.", 1)
	qdel(src)
