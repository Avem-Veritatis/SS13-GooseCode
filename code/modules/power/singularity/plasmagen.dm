//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

/* new portable generator - work in progress

/obj/machinery/power/plasmagen
	name = "portable generator"
	desc = "A portable generator used for emergency backup power."
	icon = 'generator.dmi'
	icon_state = "off"
	density = 1
	anchored = 0
	directwired = 0
	var/t_status = 0
	var/t_per = 5000
	var/filter = 1
	var/tank = null
	var/turf/inturf
	var/starter = 0
	var/rpm = 0
	var/rpmtarget = 0
	var/capacity = 1e6
	var/turf/outturf
	var/lastgen


/obj/machinery/power/plasmagen/process()
ideally we're looking to generate 5000

/obj/machinery/power/plasmagen/attackby(obj/item/weapon/W, mob/user)
tank [un]loading stuff

/obj/machinery/power/plasmagen/attack_hand(mob/user)
turn on/off

/obj/machinery/power/plasmagen/examine()
display round(lastgen) and plasmatank amount

*/

//Previous code been here forever, adding new framework for portable generators


//Baseline portable generator. Has all the default handling. Not intended to be used on it's own (since it generates unlimited power).
/obj/machinery/power/plasmagen
	name = "Imperial Plasma Generator"
	desc = "An Imperial Plasma Generator"
	icon = 'icons/obj/power2.dmi'
	icon_state = "OFF"
	density = 1
	anchored = 0
	directwired = 0
	use_power = 0

	var/active = 0
	var/power_gen = 200000
	var/power_output = 2

/obj/machinery/power/plasmagen/proc/handleInactive()
	return

/obj/machinery/power/plasmagen/process()
	if(active && anchored && powernet)
		add_avail(power_gen * power_output)
		src.updateDialog()

	else
		active = 0
		icon_state = initial(icon_state)
		handleInactive()

/obj/machinery/power/plasmagen/attack_hand(mob/user as mob)
	if(..())
		return
	if(!anchored)
		return

/obj/machinery/power/plasmagen/examine()
	set src in oview(1)
	..()
	if(active)
		usr << "It is running."
	else
		usr << "It isn't running."

/obj/machinery/power/plasmagen/pgen
	name = "Imperial Plasma Generator"
	var/sheet_path = /obj/item/stack/sheet/mineral/plasma
	var/board_path = "/obj/item/weapon/circuitboard/pgen"
	var/sheet_left = 0 // How much is left of the sheet
	var/heat = 0
	var/genstatus = "MAX OUTPUT 400k - DO NOT INCREASE!"

/obj/machinery/power/plasmagen/pgen/initialize()
	..()
	if(anchored)
		connect_to_network()

/obj/machinery/power/plasmagen/pgen/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src)
	component_parts += new /obj/item/stack/cable_coil(src, 1)
	component_parts += new /obj/item/stack/cable_coil(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/capacitor(src)

/obj/machinery/power/plasmagen/pgen/Destroy()
	explosion(src.loc, 8, 8, 8, 8)
	..()

/obj/machinery/power/plasmagen/pgen/examine()
	..()
	usr << "\blue This is an imperial plasma generator. Only the Omnissiah knows how to it works. It is best to treat it with respect."

/obj/machinery/power/plasmagen/pgen/handleInactive()

	if (heat > 0)
		heat = max(heat - 2, 0)
		src.updateDialog()

/obj/machinery/power/plasmagen/pgen/proc/overheat()
	explosion(src.loc, 8, 8, 8, 8)

/obj/machinery/power/plasmagen/pgen/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O, sheet_path))
		user << "\blue That does not fit in there."

		updateUsrDialog()
		return
	else if (istype(O, /obj/item/weapon/card/emag))
		emagged = 1
		emp_act(1)
	else if(!active)

		if(exchange_parts(user, O))
			return

		if(istype(O, /obj/item/weapon/wrench))

			if(!anchored && !isinspace())
				connect_to_network()
				user << "\blue You secure the generator to the floor."
				anchored = 1
			else if(anchored)
				disconnect_from_network()
				user << "\blue You unsecure the generator from the floor."
				anchored = 0

			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)

		else if(istype(O, /obj/item/weapon/screwdriver))
			panel_open = !panel_open
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
			if(panel_open)
				user << "\blue You open the access panel."
			else
				user << "\blue You close the access panel."
		else if(istype(O, /obj/item/weapon/crowbar) && panel_open)
			default_deconstruction_crowbar(O)

/obj/machinery/power/plasmagen/pgen/attack_hand(mob/user as mob)
	..()
	if (!anchored)
		return

	interact(user)

/obj/machinery/power/plasmagen/pgen/attack_ai(mob/user as mob)
	interact(user)

/obj/machinery/power/plasmagen/pgen/attack_paw(mob/user as mob)
	interact(user)

/obj/machinery/power/plasmagen/pgen/interact(mob/user)
	if (get_dist(src, user) > 1 )
		if (!istype(user, /mob/living/silicon/ai))
			user.unset_machine()
			user << browse(null, "window=plasmagen")
			return

	user.set_machine(src)

	var/dat = text("<b>[name]</b><br>")
	if (active)
		dat += text("Generator: <A href='?src=\ref[src];action=disable'>On</A><br>")
	else
		dat += text("Generator: <A href='?src=\ref[src];action=enable'>Off</A><br>")
	dat += text("STATUS: [genstatus]")
	dat += text("Power output: <A href='?src=\ref[src];action=lower_power'>-</A> [power_gen * power_output] <A href='?src=\ref[src];action=higher_power'>+</A><br>")
	dat += text("Power current: [(powernet == null ? "Unconnected" : "[avail()]")]<br>")
	dat += text("Heat: [heat]<br>")
	dat += "<br><A href='?src=\ref[src];action=close'>Close</A>"
	user << browse("[dat]", "window=plasmagen")
	onclose(user, "plasmagen")

/obj/machinery/power/plasmagen/pgen/Topic(href, href_list)
	if(..())
		return

	src.add_fingerprint(usr)
	if(href_list["action"])
		if(href_list["action"] == "enable")
			if(!active)
				active = 1
				icon_state = "ON"
				src.updateUsrDialog()
				SetLuminosity(10)
		if(href_list["action"] == "disable")
			if (active)
				active = 0
				icon_state = "OFF"
				SetLuminosity(0)
				src.updateUsrDialog()
		if(href_list["action"] == "lower_power")
			if (power_output > 1)
				boom()
				power_output--
				src.updateUsrDialog()
		if (href_list["action"] == "higher_power")
			if (power_output < 4 || emagged)
				boom()
				power_output++
				src.updateUsrDialog()
		if (href_list["action"] == "close")
			usr << browse(null, "window=plasmagen")
			usr.unset_machine()

/obj/machinery/power/plasmagen/pgen/proc/boom()			//It's a proc and it's gonna freak you out!
	if(active)
		SetLuminosity(20)								//man thats bright
		sleep(120)
		icon_state = "overload"
		heat = "SENSOR ERROR"
		genstatus = "CAPACITOR OVERLOAD. PLEASE SERVICE SOON!"
		sleep(120)
		Destroy()
	return
