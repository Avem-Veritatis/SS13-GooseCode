/obj/mecha/combat/crisessuit
	desc = "The XV8 is the standard-issue suit used by the Fire Caste, though other variants exist. The Crisis suit is packed with advanced technology, including a jetpack, recoil absorbers and targeting sensors. Information gathered from the Crisis' sensor suite can be transmitted to command units, providing them with updated battlefield intelligence."
	name = "XV8 Crises Suit"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "crises"
	//pixel_x = -10 //And now we don't need this!
	bound_width = 64 //It's feet stand over two tiles.
	step_in = 1
	health = 1500 //No more 200,000 health levels...
	deflect_chance = 25
	damage_absorption = list("brute"=0.3,"fire"=0.3,"bullet"=0.4,"laser"=0.5,"energy"=0.3,"bomb"=1)
	max_temperature = 65000
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/crises
	add_req_access = 0
	internal_damage_threshold = 5
	force = 45
	max_equip = 6

/obj/mecha/combat/crisessuit/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/taurapid(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/flamer(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	nominalsound = pick('sound/mecha/tauprotection.ogg')
	return

/obj/mecha/combat/crisessuit/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999

/obj/mecha/combat/crisessuit/verb/tau_move_inside() 							//just a rehash of move_inside to stop the humans from entering a Crises Suit
	set category = "Object"
	set name = "Enter Exosuit"
	set src in oview(1)
	if (!istau(usr))
		usr << "\blue <B>You have no idea how to get inside a [src.name].</B>"
		return
	else
		move_inside(usr)