//TODO: Make vents not work by pipes but rather just connect the outpost Z level with the under shafts, filtering in clean air periodically and sending things like fires down into the shafts underneath.
//Note that the vents can also filter up toxins if an option is changed on the motor found in the under maint.
//The pipes in this code are very basic. They are here in case something absolutely needs to have a piping system.
//They aren't super optimized or user friendly. The main atmospherics system will not be built upon these, nor will people be able to lay down new pipes.

obj/machinery/atmospherics/pipe
	icon = 'icons/obj/pipes.dmi'
	name = "Atmospheric Shit (Error)"
	desc = "Should never exist... Report heresy to your nearest coder or forums page."
	layer = 2.4 //under wires with their 2.44
	use_power = 0
	unsecuring_tool = null //Can't be unsecured
	var/datum/gas_mixture2/G
	var/list/connected = list()
	var/list/inputs = list()
	var/list/outputs = list()
	var/datum/gas_spread/releasing

obj/machinery/atmospherics/pipe/New()
	..()
	processing_objects.Add(src)
	for(var/direction in inputs)
		var/turf/T = get_step(src, direction)
		for(var/obj/machinery/atmospherics/pipe/P in T)
			connected.Add(P)
	for(var/direction in outputs)
		var/turf/T = get_step(src, direction)
		for(var/obj/machinery/atmospherics/pipe/P in T)
			connected.Add(P)
	update_icon()

obj/machinery/atmospherics/pipe/update_icon()
	if(inputs.len + outputs.len == 2)
		icon_state = "intact"
		dir = 0
		for(var/direction in inputs)
			dir |= direction
		for(var/direction in outputs)
			dir |= direction
	if(inputs.len + outputs.len == 3)
		icon_state = "manifold"
		for(var/direction in inputs)
			dir &= ~direction
		for(var/direction in outputs)
			dir &= ~direction
	return

obj/machinery/atmospherics/pipe/process()
	spawn(1)
		var/has_output = 0
		for(var/obj/machinery/atmospherics/pipe/P in connected)
			if(get_dir(src, P) in outputs)
				has_output = 1
				P.G = P.G.merge_gas(src.G)
				src.G = new /datum/gas_mixture2()
		if(!has_output)
			if(src.G.get_pressure()) //Leak the pipe if nothing is stopping this from happening.
				if(!releasing)
					releasing = new /datum/gas_spread()
					releasing.spread(get_turf(src))
				releasing.air.merge_gas(src.G)
				src.G = new /datum/gas_mixture2()

obj/machinery/atmospherics/pipe/valve
	var/open = 0
	name = "manual valve"
	icon = 'icons/obj/atmospherics/relief_valve.dmi'
	icon_state = "valve_closed"

obj/machinery/atmospherics/pipe/valve/update_icon()
	if(inputs.len + outputs.len == 2)
		if(open)
			icon_state = "valve_open"
		else
			icon_state = "valve_closed"
		dir = 0
		for(var/direction in inputs)
			dir |= direction
		for(var/direction in outputs)
			dir |= direction
	return

obj/machinery/atmospherics/pipe/valve/process()
	if(open)
		..()

obj/machinery/atmospherics/pipe/valve/attack_hand()
	open = !open
	update_icon()
	if(usr)
		usr << "You turn the [src]."

obj/machinery/atmospherics/pipe/canister_connector
	var/obj/connected_device
	var/input = 1
	icon_state = "connector"

obj/machinery/atmospherics/pipe/valve/update_icon()
	if(inputs.len + outputs.len == 1)
		icon_state = "connector"
		dir = 0
		for(var/direction in inputs)
			dir |= direction
		for(var/direction in outputs)
			dir |= direction
	return

obj/machinery/atmospherics/pipe/canister_connector/process()
	spawn(1)
		if(input)
			src.connected_device:air_contents:merge_gas(src.G)
			src.G = new /datum/gas_mixture2()
		else
			for(var/obj/machinery/atmospherics/pipe/P in connected)
				if(get_dir(src, P) in outputs)
					P.G = P.G.merge_gas(src:connected_device:air_contents.remove(100))

obj/machinery/atmospherics/pipe/injector
	name = "air injector"
	desc = "A pipe that injects air into the surrounding area."
	icon = 'icons/obj/atmospherics/outlet_injector.dmi'
	icon_state = "off"

obj/machinery/atmospherics/pipe/injector/update_icon()
	if(inputs.len == 1)
		icon_state = "off"
		if(releasing != null)
			icon_state = "on"
		dir = 0
		for(var/direction in inputs)
			dir |= direction
	return

obj/machinery/atmospherics/pipe/injector/process()
	spawn(1)
		if(src.G.get_pressure())
			if(!releasing)
				releasing = new /datum/gas_spread()
				releasing.spread(get_turf(src))
				update_icon()
			releasing.air.merge_gas(src.G)
			src.G = new /datum/gas_mixture2()
		else
			if(releasing)
				src.releasing = null
				update_icon()