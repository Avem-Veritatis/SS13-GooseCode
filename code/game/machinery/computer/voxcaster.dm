//Very simple stuff. I almost feel bad about how crappy it is but I was never that good at style. I'm sure we can do more with it later.

/obj/machinery/computer/voxcaster
	name = "Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "Apple Macintoshb"
	desc = "A communication device."
	density = 1
	anchored = 1.0
	use_power = 0
	var/identity = "Unassigned"
	var/msg
	var/imessage
	var/omessage
//message alerts
	var/oldicon = "Apple Macintoshb"
	var/icon_alert = ""

/obj/machinery/computer/voxcaster/attack_hand(mob/user as mob)	//Starting menu
	if(is_blind(usr))
		return
	if(in_range(usr, src))
		if(ishuman(usr))
			usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
			omessage += "[identity]: "
			omessage += strip_html_simple(input("Enter Something to Say","Say Something","") as text, 100)
			omessage += "<BR>"
			sendmesage()
			update_screen()
			omessage = ""
		else
			usr << "<span class='notice'>What even are you?</span>"

	else
		usr << "<span class='notice'>It is too far away.</span>"

/obj/machinery/computer/voxcaster/proc/sendmesage()
	for (var/obj/machinery/computer/voxcaster/V in world)
		V.imessage = omessage
		V.recievemessage()

/obj/machinery/computer/voxcaster/proc/recievemessage()
	icon_state = icon_alert
	msg += imessage

/obj/machinery/computer/voxcaster/proc/update_screen()
	icon_state = oldicon
	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")


/*
Variants - All connected together
*/

/obj/machinery/computer/voxcaster/cargo
	name = "Long Range Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "Apple3"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='maroon'>•Imperial Relay 7782</FONT>"
	icon_alert = "Apple3a"
	oldicon = "Apple3"

/obj/machinery/computer/voxcaster/ork
	name = "TALKY THING"
	icon = 'icons/obj/computer.dmi'
	icon_state = "ork"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='red'>•DA STATUS REPORTA</FONT>"
	icon_alert = "orka"
	oldicon = "ork"

/obj/machinery/computer/voxcaster/eldar
	name = "Tri-Thalion Media Relay"
	icon = 'icons/obj/computer.dmi'
	icon_state = "eldar"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='blue'>•Unknown Signal</FONT>"
	icon_alert = "eldara"
	oldicon = "eldar"

/obj/machinery/computer/voxcaster/tau
	name = "Subspace Zero Signal Transmitter"
	icon = 'icons/obj/computer.dmi'
	icon_state = "tau"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='green'>•Tau Empire</FONT>"
	icon_alert = "taua"
	oldicon = "tau"

/obj/machinery/computer/voxcaster/ksons
	name = "Warp Transmitter"
	icon = 'icons/obj/computer.dmi'
	icon_state = "ksons"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<span class='tzeench'>•Unknown Signal</span>"
	icon_alert = "ksonsa"
	oldicon = "ksons"

/*
//Imperial Factions Voxcaster
//reinventing the wheel because I want no chance that the two networks will intermingle
*/

/obj/machinery/computer/imperialvoxcaster
	name = "Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "Apple Macintoshb"
	desc = "A communication device."
	density = 1
	anchored = 1.0
	use_power = 0
	var/identity = "Unassigned"
	var/msg
	var/imessage
	var/omessage
//message alerts
	var/oldicon = "Apple Macintoshb"
	var/icon_alert = ""

/obj/machinery/computer/imperialvoxcaster/attack_hand(mob/user as mob)	//Starting menu
	if(is_blind(usr))
		return
	if(in_range(usr, src))
		if(ishuman(usr))
			usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
			omessage += "[identity]: "
			omessage += strip_html_simple(input("Enter Something to Say","Say Something","") as text, 100)
			omessage += "<BR>"
			sendmesage()
			update_screen()
			omessage = ""
		else
			usr << "<span class='notice'>What even are you?</span>"

	else
		usr << "<span class='notice'>It is too far away.</span>"

/obj/machinery/computer/imperialvoxcaster/proc/sendmesage()
	for (var/obj/machinery/computer/imperialvoxcaster/V in world)
		V.imessage = omessage
		V.recievemessage()

/obj/machinery/computer/imperialvoxcaster/proc/recievemessage()
	icon_state = icon_alert
	msg += imessage

/obj/machinery/computer/imperialvoxcaster/proc/update_screen()
	icon_state = oldicon
	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Imperial faction variants
*/

/obj/machinery/computer/imperialvoxcaster/aafour
	name = "Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "hopstation"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='maroon'>•Imperial Outpost ArchAngel IV</FONT>"
	icon_alert = "hopstationa"
	oldicon = "hopstation"

/obj/machinery/computer/imperialvoxcaster/transport
	name = "Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "eldar"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='blue'>•Imperial Escort 'Zanker'</FONT>"
	icon_alert = "eldara"
	oldicon = "eldar"

/obj/machinery/computer/imperialvoxcaster/sob
	name = "Voxcaster Terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "hopstation"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='red'>•Imperial Relay: ArchAngel II</FONT>"
	icon_alert = "hopstationa"
	oldicon = "hopstation"

/obj/machinery/computer/imperialvoxcaster/inq
	name = "Voxcaster Channel Tap"
	icon = 'icons/obj/computer.dmi'
	icon_state = "tau"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='green'>•Imperial Cruiser 'Stargazer'</FONT>"
	icon_alert = "taua"
	oldicon = "tau"

/obj/machinery/computer/imperialvoxcaster/inqaa
	name = "Voxcaster Channel Tap"
	icon = 'icons/obj/computer.dmi'
	icon_state = "tau"
	density = 1
	anchored = 1.0
	use_power = 0
	identity = "<FONT COLOR='grey'>•Ordo Hereticus 'AA4'</FONT>"
	icon_alert = "taua"
	oldicon = "tau"