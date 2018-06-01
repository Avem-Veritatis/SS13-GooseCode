/datum/wires/vending
	holder_type = /obj/machinery/vending
	wire_count = 8

var/const/VENDING_WIRE_THROW = 1
var/const/VENDING_WIRE_CONTRABAND = 2
var/const/VENDING_WIRE_ELECTRIFY = 4
var/const/VENDING_WIRE_IDSCAN = 8
var/const/VENDING_WIRE_SLOGANS = 16
var/const/VENDING_WIRE_THROWBOOST = 32
var/const/VENDING_WIRE_POISON = 64
var/const/VENDING_WIRE_RIGGED = 128 //I made the wiring on vendors a little bit more evil. This is partially just because it will be fun, but partially because now contraband, including rare chems, is a little harder to get.

/datum/wires/vending/CanUse(var/mob/living/L)
	var/obj/machinery/vending/V = holder
	if(!istype(L, /mob/living/silicon))
		if(V.seconds_electrified)
			if(V.shock(L, 100))
				return 0
	if(V.panel_open)
		return 1
	return 0

/datum/wires/vending/Interact(var/mob/living/user)
	if(CanUse(user))
		var/obj/machinery/vending/V = holder
		V.attack_hand(user)

/datum/wires/vending/GetInteractWindow()
	var/obj/machinery/vending/V = holder
	. += ..()
	. += "<BR>The orange light is [V.seconds_electrified ? "on" : "off"].<BR>"
	. += "The red light is [V.shoot_inventory ? "off" : "blinking"].<BR>"
	. += "The green light is [V.extended_inventory ? "on" : "off"].<BR>"
	. += "A [V.scan_id ? "purple" : "yellow"] light is on.<BR>"

/datum/wires/vending/UpdatePulsed(var/index)
	var/obj/machinery/vending/V = holder
	switch(index)
		if(VENDING_WIRE_THROW)
			V.shoot_inventory = !V.shoot_inventory
		if(VENDING_WIRE_CONTRABAND)
			V.extended_inventory = !V.extended_inventory
		if(VENDING_WIRE_ELECTRIFY)
			V.seconds_electrified = 30
		if(VENDING_WIRE_IDSCAN)
			V.scan_id = !V.scan_id
		if(VENDING_WIRE_SLOGANS)
			V.heretical = !V.heretical
		if(VENDING_WIRE_THROWBOOST)
			if(prob(5))
				V.seconds_electrified = 5
			V.throwfast = !V.throwfast
		if(VENDING_WIRE_POISON)
			V.toxic = !V.toxic
		if(VENDING_WIRE_RIGGED)
			if(prob(5)) //Small risk that you blow the device out even with a multitool.
				V.rigged = 0
				V.malfunction()
				explosion(V.loc, 0, 0, 3, 5, flame_range = 4)
			else
				spawn(300)
					V.rigged = !V.rigged

/datum/wires/vending/UpdateCut(var/index, var/mended) //Slogan overrides and toxification are both software hacks. They aren't determined by something as crude as cutting a wire.
	var/obj/machinery/vending/V = holder
	switch(index)
		if(VENDING_WIRE_THROW)
			V.shoot_inventory = !mended
		if(VENDING_WIRE_CONTRABAND)
			V.extended_inventory = 0
		if(VENDING_WIRE_ELECTRIFY)
			if(mended)
				V.seconds_electrified = 0
			else
				V.seconds_electrified = -1
		if(VENDING_WIRE_IDSCAN)
			V.scan_id = 1
		if(VENDING_WIRE_THROWBOOST)
			if(prob(60))
				V.seconds_electrified = 5
			V.throwfast = !mended
		if(VENDING_WIRE_RIGGED)
			if(prob(40))
				V.rigged = 0
				V.malfunction()
				explosion(V.loc, 0, 0, 3, 5, flame_range = 4)
			else
				spawn(300)
					V.rigged = !mended