/*
Aluminum Tube
*/
/obj/item/aluminumtube													//stage 1
	name = "Aluminum Tube"
	desc = "A tube. Made from Aluminum. Historically speaking, the owner of this object is attempting to construct a nuclear bomb. But don't ask me. I know nothing about science or engineering. All I can tell you is that this looks like something a Cybernetica Acolyte might want to use his/her 'USB interface device' on. I'm just sayin..."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "3"

/obj/item/aluminumtube/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/USBinterface))
		user << "You begin carving circuitry into the tube."
		playsound(src.loc, "sound/items/welder2.ogg", 50, 0, 4)
		if(do_after(user, 60))
			qdel(W)
			new /obj/item/aluminumtube2(user.loc)
			qdel(src)
			return
		else
			user.visible_message("<span class='notice'>[user] stops unexpectedly.</span>", "<span class='notice'>Your focus is interupted and you abandon the tube.</span>")
	add_fingerprint(user)

/obj/item/aluminumtube2													//stage 2
	name = "Device"
	desc = "No idea what this used to be but some one has been working on this. It appears to have a slot where a power cell should fit."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "20"

/obj/item/aluminumtube2/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/stock_parts/cell))
		user << "You begin intergrating the power source."
		playsound(src.loc, "sound/items/welder2.ogg", 50, 0, 4)
		if(do_after(user, 60))
			qdel(W)
			new /obj/item/aluminumtube3(user.loc)
			qdel(src)
			return
		else
			user.visible_message("<span class='notice'>[user] stops unexpectedly.</span>", "<span class='notice'>Your focus is interupted and you abandon the device.</span>")
	add_fingerprint(user)

/obj/item/aluminumtube3													//stage 2
	name = "Device"
	desc = "A prototype mechadendrite. At this stage it can accept a Cable Layer, an AutoCannon or a Hydraulic Clamp."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "21"

/obj/item/aluminumtube3/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp))
		user << "You begin intergrating the clamp."
		playsound(src.loc, "sound/items/welder2.ogg", 50, 0, 4)
		if(do_after(user, 60))
			qdel(W)
			new /obj/item/aluminumtube4/clamp(user.loc)					//SOME ONE IS GONNA GET CLAMPED!
			qdel(src)
			return
		else
			user.visible_message("<span class='notice'>[user] stops unexpectedly.</span>", "<span class='notice'>Your focus is interupted and you abandon the device.</span>")

	if(istype(W,/obj/item/mecha_parts/mecha_equipment/tool/cable_layer))
		user << "You begin intergrating the device."
		playsound(src.loc, "sound/items/welder2.ogg", 50, 0, 4)
		if(do_after(user, 60))
			qdel(W)
			new /obj/item/aluminumtube4/turr(user.loc)
			qdel(src)
			return
		else
			user.visible_message("<span class='notice'>[user] stops unexpectedly.</span>", "<span class='notice'>Your focus is interupted and you abandon the device.</span>")

	if(istype(W,/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg))
		user << "You begin intergrating the autocannon."
		playsound(src.loc, "sound/items/welder2.ogg", 50, 0, 4)
		if(do_after(user, 60))
			qdel(W)
			new /obj/item/aluminumtube4/AC(user.loc)
			qdel(src)
			return
		else
			user.visible_message("<span class='notice'>[user] stops unexpectedly.</span>", "<span class='notice'>Your focus is interupted and you abandon the device.</span>")
	add_fingerprint(user)

/obj/item/aluminumtube4/												//stage 3
	name = "Error Item"
	desc = "This is a placeholder item which contains variables. If you see this in game it probably means an admin is screwing around. In any case it is Lidoe's fault."
	var/mechactive = 0

/*
It's a series of tubes!
*/

/obj/item/aluminumtube4/clamp											//clamp option
	name = "Mechadendrite Clamp"
	desc = "A prototype mechadendrite. At this stage it is ready to activate. It goes on your backslot. Be warned, once it is activated it will be forever attached to you.."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "22"

/obj/item/aluminumtube4/clamp/attack_self(mob/user)
	mechactive = 1
	if(mechactive)
		user.equip_to_slot(new /obj/item/weapon/storage/backpack/mechaclamp, slot_back)
		user.drop_item()
		qdel(src)

/obj/item/aluminumtube4/turr											//turret option
	name = "Complex Construction Mechadendrite"
	desc = "A prototype mechadendrite. At this stage it is ready to activate. It goes on your mask slot. Be warned, once it is activated it will be forever attached to you.."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "24"

/obj/item/aluminumtube4/turr/attack_self(mob/user)
	mechactive = 1
	if(mechactive)
		user.equip_to_slot(new /obj/item/clothing/mask/gas/TRAP, slot_wear_mask)
		user.drop_item()
		qdel(src)

/obj/item/aluminumtube4/AC											//AC option
	name = "Mechadendrite AutoCannon"
	desc = "A prototype mechadendrite. At this stage it is ready to activate. It goes on your beltslot. Be warned, once it is activated it will be forever attached to you.."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "23"

/obj/item/aluminumtube4/AC/attack_self(mob/user)
	mechactive = 1
	if(mechactive)
		user.equip_to_slot(new /obj/item/weapon/storage/belt/MDAC, slot_belt)
		user.drop_item()
		qdel(src)

/obj/item/weapon/melee/clamp   												  //The clamp itself
	name = "Clamp"
	desc = "They won't know what clamped them!"
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "mecha_clamp"
	force = 15
	throw_range = 4
	throwforce = 10
	w_class = 1
	flags = NODROP

/obj/item/weapon/melee/clamp/cyborg
	flags = 0

/obj/item/weapon/melee/clamp/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	if(istype(A,/obj/structure/window) || istype(A,/obj/structure/grille)) //destroys windows and grilles in one hit
		if(istype(A,/obj/structure/window)) //should just make a window.Break() proc but couldn't bother with it
			var/obj/structure/window/W = A

			new /obj/item/weapon/shard( W.loc )
			if(W.reinf) new /obj/item/stack/rods( W.loc)

			if (W.dir == SOUTHWEST)
				new /obj/item/weapon/shard( W.loc )
				if(W.reinf) new /obj/item/stack/rods( W.loc)
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
	if(istype(A, /mob/living/carbon))
		var/mob/M =	A
		step_away(M,src,15)
		step_away(M,src,15)
		step_away(M,src,15)
		user.visible_message("<span class='notice'>[user] throws [M] with ease!</span>", "<span class='notice'>You throw [M] with your clamp!</span>")

	if(istype(A,/turf/)||istype(A,/obj/structure/)||istype(A,/obj/machinery/door/)||istype(A,/obj/effect/fake_floor))
		A.ex_act(2)
		playsound(loc, 'sound/weapons/smash.ogg', 50, 1, -1)
		user.visible_message("<span class='notice'>[user] destroys the [A] with a metal clamp!</span>", "<span class='notice'>You made short work of that [A] with your clamp!</span>")
	..()

/obj/item/weapon/melee/clamp/dropped()
	qdel(src)

/obj/item/aluminumtube4/surgical
	name = "Surgical Mechadendrite"
	desc = "A prototype mechadendrite. At this stage it is ready to activate. It goes on your undersuit slot. Be warned, once it is activated it will be forever attached to you..."
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "25"

/obj/item/aluminumtube4/surgical/attack_self(mob/user)
	mechactive = 1
	if(mechactive)
		user.equip_to_slot(new /obj/item/clothing/under/surgerycybernetic, slot_w_uniform)
		user.drop_item()
		qdel(src)