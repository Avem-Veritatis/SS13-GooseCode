/obj/mecha/combat/sentinel
	desc = "A lightweight, recon vehicle. Popular among the imperial guard."
	name = "Sentinel"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "sentinel"
	step_in = 2
	dir_in = 1 //Facing North.
	health = 250
	deflect_chance = 5
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 25000
	infra_luminosity = 6
	var/overload = 0
	var/overload_coeff = 2
	wreckage = /obj/structure/mecha_wreckage/sentinel
	internal_damage_threshold = 35
	max_equip = 3
	step_energy_drain = 3

/obj/mecha/combat/sentinel/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/sentlas(src)
	ME.attach(src)
	var/obj/item/mecha_parts/mecha_equipment/ME2 = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME2.attach(src)
	return

/obj/mecha/combat/sentinel/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999

/obj/mecha/combat/sentinel/verb/overload()
	set category = "Exosuit Interface"
	set name = "Toggle leg actuators overload"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	if(overload)
		overload = 0
		step_in = initial(step_in)
		step_energy_drain = initial(step_energy_drain)
		src.occupant_message("<font color='blue'>You disable leg actuators overload.</font>")
	else
		overload = 1
		step_in = min(1, round(step_in/2))
		step_energy_drain = step_energy_drain*overload_coeff
		src.occupant_message("<font color='red'>You enable leg actuators overload.</font>")
	src.log_message("Toggled leg actuators overload.")
	return

/obj/mecha/combat/sentinel/dyndomove(direction)
	if(!..()) return
	if(overload)
		health--
		if(health < initial(health) - initial(health)/3)
			overload = 0
			step_in = initial(step_in)
			step_energy_drain = initial(step_energy_drain)
			src.occupant_message("<font color='red'>Leg actuators damage threshold exceded. Disabling overload.</font>")
	return


/obj/mecha/combat/sentinel/get_stats_part()
	var/output = ..()
	output += "<b>Leg actuators overload: [overload?"on":"off"]</b>"
	return output

/obj/mecha/combat/sentinel/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_leg_overload=1'>Toggle leg actuators overload</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/sentinel/Topic(href, href_list)
	..()
	if (href_list["toggle_leg_overload"])
		src.overload()
	return

/*
Variants
*/

/obj/mecha/combat/sentinel/dk
	desc = "A lightweight, recon vehicle. Popular among the imperial guard."
	name = "Sentinel"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "sentinel2"

/obj/mecha/combat/sentinel/dk/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/sentlas(src)
	ME.attach(src)
	var/obj/item/mecha_parts/mecha_equipment/ME2 = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME2.attach(src)
	return

/obj/mecha/combat/sentinel/drop
	desc = "An Elysian Pattern \"Drop Sentinel\" that can function as a light armored unit and can be used in a drop."
	name = "Drop Sentinel"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "dropsentinel"

/obj/mecha/combat/sentinel/drop/New()
	..()
	src.visible_message("\red <b>[src] falls from the sky!</b>")

/obj/mecha/combat/sentinel/drop/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/bettersentlas(src)
	ME.attach(src)
	var/obj/item/mecha_parts/mecha_equipment/ME2 = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME2.attach(src)
	return

/obj/mecha/combat/sentinel/kreig2
	desc = "A lightweight, recon vehicle. Popular among the imperial guard."
	name = "Sentinel"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "oldsentinel"
	color = "#505050"

/obj/mecha/combat/sentinel/kreig2/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/bettersentlas(src)
	ME.attach(src)
	var/obj/item/mecha_parts/mecha_equipment/ME2 = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME2.attach(src)
	return