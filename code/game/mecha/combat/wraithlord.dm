/obj/mecha/combat/wraithlord
	desc = "Wraithlords are giant Wraith-constructs made of wraithbone and inhabited by the souls of dead Eldar heroes. Intended for soulstones. Once you get in- you can only be removed by a soulstone."
	name = "Wraithlord"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "wraithlord"
	//pixel_x = -10
	step_in = 6
	health = 1500 //No more 200,000 health levels...
	deflect_chance = 50
	damage_absorption = list("brute"=0.3,"fire"=0.3,"bullet"=0.3,"laser"=0.3,"energy"=0.3,"bomb"=0.3)
	max_temperature = 65000
	infra_luminosity = 3
	operation_req_access = list(access_hos)
	wreckage = /obj/structure/mecha_wreckage/wraithlord
	add_req_access = 0
	internal_damage_threshold = 5
	force = 45
	max_equip = 6
	stepsound = 'sound/mecha/wraithlordwalk.ogg'

/obj/mecha/combat/wraithlord/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/brightlance(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/shur(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	nominalsound = pick('sound/mecha/wraithlord1.ogg', 'sound/mecha/wraithlord2.ogg')
	noescape = 1
	return

/obj/mecha/combat/wraithlord/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999
	src.verbs -= /obj/mecha/verb/eject

/obj/mecha/combat/wraithlord/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/device/mmi))
		user << "Yeah there is really no way to put that in here. It's just not going to fit. (thats what SHE said)"
		return //MMI's should not work for wraithlords.
	if(istype(W, /obj/item/device/soulstone))
		if(occupant)
			user << "A soul is already in there!"
			return
		for(var/mob/living/simple_animal/shade/A in W)
			A.reset_view(src)
			occupant = A
			A.loc = src //should allow relaymove
			A.canmove = 1
			W.loc = src
			src.verbs -= /obj/mecha/verb/eject
			src.Entered(W) //Not sure what this is for...
			src.Move(src.loc)
			src.icon_state = initial(icon_state)
			dir = dir_in
			src.log_message("[A] moved in as pilot.")
			user << "You press the [W] into the [src]."
			qdel(W)
			return
	..()