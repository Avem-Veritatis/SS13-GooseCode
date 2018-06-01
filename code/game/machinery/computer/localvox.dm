/obj/machinery/computer/localvox		//this is a computer that can reset the round. That game physically ends when the antag clicks 'call for pickup'
	name = "Local Vox Communications"
	desc = "It appears to be a long range communication device."
	icon_state = "ob1"
	icon = 'icons/obj/machines/Orbitalcomand.dmi'
	var/pickingup = 1

/obj/machinery/computer/localvox/attack_hand(mob/user as mob)
	user.set_machine(src)
	var/dat = ""
	dat += "<center>Sector: <b>Hades Majorus</b></center>"
	dat += "<center>Subsector: <b>Thanatos Glacial</b></center>"
	dat += "<center>System: <b>ArchAngel</b></center>"
	dat += "<center>Radar Contacts: <b>6</b></center>"
	dat += "<center>Engines:<b>Online</b></center>."
	dat += "<center>Fuel Cells:<b>97%</b></center>"
	dat += "Ready for command."
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")


