/obj/item/device/refractor
	name = "refractor field projector"
	icon_state = "refractor"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "syndicate=4;magnets=4"
	var/cooldown = 0

/obj/item/device/refractor/attack_self(mob/user as mob)
	if(cooldown)
		user << "\red The projector is still charging."
	else
		user.visible_message("\red [user] activates the refractor field projector!")
		cooldown = 1
		spawn(1200) cooldown = 0
		for(var/turf/simulated/floor/T in orange(4,user))
			if(prob(40))
				new /obj/effect/forcefield/refractor(T)

/obj/machinery/shieldgenr
		name = "refractor field projector"
		desc = "Used to secure an area from incoming projectiles, and create a zone where no projectiles may be fired."
		icon = 'icons/obj/objects.dmi'
		icon_state = "shieldoff"
		density = 1
		opacity = 0
		anchored = 0
		//pressure_resistance = 2*ONE_ATMOSPHERE
		req_access = list(access_engine)
		var/const/max_health = 100
		var/health = max_health
		var/active = 0
		var/malfunction = 0 //Malfunction causes parts of the shield to slowly dissapate
		var/list/deployed_shields = list()
		var/is_open = 0 //Whether or not the wires are exposed
		var/locked = 0
		var/shield_range = 4
		var/dna_lock = null

/obj/machinery/shieldgenr/Destroy()
	for(var/obj/effect/forcefield/refractor2/shield_tile in deployed_shields)
		qdel(shield_tile)
	..()


/obj/machinery/shieldgenr/proc/shields_up()
	if(active) return 0 //If it's already turned on, how did this get called?

	src.active = 1
	update_icon()

	for(var/turf/target_tile in range(shield_range, src))
		if (!(locate(/obj/effect/forcefield/refractor2) in target_tile))
			if (malfunction && prob(33) || !malfunction)
				deployed_shields += new /obj/effect/forcefield/refractor2(target_tile)

/obj/machinery/shieldgenr/proc/shields_down()
	if(!active) return 0 //If it's already off, how did this get called?

	src.active = 0
	update_icon()

	for(var/obj/effect/forcefield/refractor2/shield_tile in deployed_shields)
		qdel(shield_tile)
	deployed_shields.Cut()

/obj/machinery/shieldgenr/process()
	if(malfunction && active)
		if(deployed_shields.len && prob(5))
			qdel(pick(deployed_shields))

	return

/obj/machinery/shieldgenr/proc/checkhp()
	if(health <= 30)
		src.malfunction = 1
	if(health <= 0)
		qdel(src)
	update_icon()
	return

/obj/machinery/shieldgenr/ex_act(severity)
	switch(severity)
		if(1.0)
			src.health -= 75
			src.checkhp()
		if(2.0)
			src.health -= 30
			if (prob(15))
				src.malfunction = 1
			src.checkhp()
		if(3.0)
			src.health -= 10
			src.checkhp()
	return

/obj/machinery/shieldgenr/emp_act(severity)
	switch(severity)
		if(1)
			src.health /= 2 //cut health in half
			malfunction = 1
			locked = pick(0,1)
		if(2)
			if(prob(50))
				src.health *= 0.7 //chop off a third of the health //W- What... Tg coders... You imbecile *=0.3 isn't a third, that's chopping off 70%. Changing this.
				malfunction = 1
	checkhp()

/obj/machinery/shieldgenr/attack_hand(mob/user as mob)
	if(locked)
		user << "The machine is locked, you are unable to use it."
		return
	if(is_open)
		user << "The panel must be closed before operating this machine."
		return
	if( dna_lock )
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.uni_identity != dna_lock)
				user << "\red The [src] is configured to a facial print that is not yours."
				return
		else
			user << "\red The [src] is configured to a facial print that is not yours."
			return
	if (src.active)
		user.visible_message("\blue \icon[src] [user] deactivated the shield generator.", \
			"\blue \icon[src] You deactivate the shield generator.", \
			"You hear heavy droning fade out.")
		src.shields_down()
	else
		if(anchored)
			user.visible_message("\blue \icon[src] [user] activated the shield generator.", \
				"\blue \icon[src] You activate the shield generator.", \
				"You hear heavy droning.")
			src.shields_up()
		else
			user << "The device must first be secured to the floor."
	return

/obj/machinery/shieldgenr/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/card/emag))
		malfunction = 1
		update_icon()

	else if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 100, 1)
		if(is_open)
			user << "\blue You close the panel."
			is_open = 0
		else
			user << "\blue You open the panel and expose the wiring."
			is_open = 1

	else if(istype(W, /obj/item/stack/cable_coil) && malfunction && is_open)
		var/obj/item/stack/cable_coil/coil = W
		user << "\blue You begin to replace the wires."
		//if(do_after(user, min(60, round( ((maxhealth/health)*10)+(malfunction*10) ))) //Take longer to repair heavier damage
		if(do_after(user, 30))
			if(!src || !coil) return
			coil.use(1)
			health = max_health
			malfunction = 0
			user << "\blue You repair the [src]!"
			update_icon()

	else if(istype(W, /obj/item/weapon/wrench))
		if(locked)
			user << "The bolts are covered, unlocking this would retract the covers."
			return
		if(!anchored && !isinspace())
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'> You secure the [src] to the floor!</span>"
			anchored = 1
		else if(anchored)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'> You unsecure the [src] from the floor!</span>"
			if(active)
				user << "<span class='notice'> The [src] shuts off!</span>"
				src.shields_down()
			anchored = 0


	else if(istype(W, /obj/item/weapon/card/id) || istype(W, /obj/item/device/pda))
		if(src.allowed(user))
			src.locked = !src.locked
			user << "The controls are now [src.locked ? "locked." : "unlocked."]"
		else
			user << "\red Access denied."

	else
		..()


/obj/machinery/shieldgenr/update_icon()
	if(active)
		src.icon_state = malfunction ? "shieldonbr":"shieldon"
	else
		src.icon_state = malfunction ? "shieldoffbr":"shieldoff"
	return

/obj/machinery/shieldgenr/verb/facialscan()
	set name = "Facial Print Lock/Unlock"
	set desc = "Configure the refractor field generator to only be accessible by your facial print, or wipe the stored facial print from memory."
	set category = "Object"
	set src in oview(1)

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(dna_lock)
			if(H.dna.uni_identity == dna_lock)
				src.visible_message("<b>[src]</b> beeps \"Deleting facial imprint... Done. Device accessible to all users.\"")
				dna_lock = null
			else
				H << "\red The [src] already has a facial pattern stored. The device must scan the facial pattern of the current owner a second time to unlink with them."
			return
		src.visible_message("<b>[src]</b> beeps \"Scanning [H]...\"")
		if(do_after(H, 100))
			src.visible_message("<b>[src]</b> beeps \"Scan complete. The facial pattern of [H] is stored in memory.\"")
			dna_lock = H.dna.uni_identity
		else
			src.visible_message("<b>[src]</b> beeps \"Scanning [H] interrupted. Unable to get a complete scan. Process terminated.\"")