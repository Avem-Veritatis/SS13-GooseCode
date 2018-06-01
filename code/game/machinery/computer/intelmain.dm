

/obj/machinery/computer/intelmain
	name = "Radar Console"
	desc = "This can be used for various important functions."
	icon = 'icons/obj/machines/radar.dmi'
	icon_state = "console"


	var/identity = "Unassigned"
	var/msg
	var/imessage
	var/omessage


/obj/machinery/computer/intelmain/attackby(I as obj, user as mob)
	return																		//lets get this out of the way. I don't want players taking a screwdriver to it and making it dissapear.

/obj/machinery/computer/intelmain/attack_hand(mob/user as mob)	//Starting menu
	if(is_blind(usr))
		return
	if(in_range(usr, src))
		if(ishuman(usr))
			usr << browse("<HTML><HEAD><TITLE>Transmission Intercept Log</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

		else
			usr << "<span class='notice'>What even are you?</span>"

	else
		usr << "<span class='notice'>It is too far away.</span>"

/obj/machinery/computer/intelmain/proc/recievemessage(intercept)

	msg += "<BR>[world.time]"
	msg += intercept

/proc/radarintercept(var/intercept)
	for(var/obj/machinery/computer/intelmain/I in world)
		I.recievemessage(intercept)