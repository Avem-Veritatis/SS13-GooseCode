/obj/item/weapon/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")


/obj/item/weapon/storage/belt/proc/can_use()
	if(!ismob(loc)) return 0
	var/mob/M = loc
	if(src in M.get_equipped_items())
		return 1
	else
		return 0

/obj/item/weapon/storage/belt/MouseDrop(obj/over_object as obj, src_location, over_location)
	var/mob/M = usr
	if(!istype(over_object, /obj/screen))
		return ..()
	playsound(src.loc, interaction_sound, 50, 1, -5)
	if (!M.restrained() && !M.stat && can_use())
		switch(over_object.name)
			if("r_hand")
				M.unEquip(src)
				M.put_in_r_hand(src)
			if("l_hand")
				M.unEquip(src)
				M.put_in_l_hand(src)
		src.add_fingerprint(usr)
		return

/obj/item/weapon/storage/belt/utility
	name = "toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	icon_state = "utilitybelt"
	item_state = "utility"
	can_hold = list(
		/obj/item/weapon/crowbar,
		/obj/item/weapon/screwdriver,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/wirecutters,
		/obj/item/weapon/wrench,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer)

/obj/item/weapon/storage/belt/utility/full/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))


/obj/item/weapon/storage/belt/utility/atmostech/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/device/t_scanner(src)

/obj/item/weapon/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medicalbelt"
	item_state = "medical"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/glass/bottle,
		/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/lighter/zippo,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/flashlight/pen
	)

/obj/item/weapon/storage/belt/medical/apothecary
	icon_state = "imperialbelt"
	item_state = "imperialbelt"

/obj/item/weapon/storage/belt/medical/apothecary/New()
	..()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)
	new /obj/item/weapon/reagent_containers/pill/smheal(src)

/obj/item/weapon/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "securitybelt"
	item_state = "security"//Could likely use a better one.
	storage_slots = 5
	max_w_class = 3 //Because the baton wouldn't fit otherwise. - Neerti
	can_hold = list(
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/melee/classic_baton,
		/obj/item/weapon/grenade/flashbang,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/weapon/reagent_containers/food/snacks/donut/normal,
		/obj/item/weapon/reagent_containers/food/snacks/donut/jelly,
		/obj/item/device/flashlight/seclite,
		/obj/item/weapon/melee/telebaton
		)

/obj/item/weapon/storage/belt/security/New()
	..()
	new /obj/item/device/flashlight/seclite(src)

/obj/item/weapon/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Designed for ease of access to the shards during a fight, as to not let a single enemy spirit slip away"
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	storage_slots = 6
	can_hold = list(
		/obj/item/device/soulstone
		)

/obj/item/weapon/storage/belt/soulstone/full/New()
	..()
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)
	new /obj/item/device/soulstone(src)


/obj/item/weapon/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	item_state = "champion"
	storage_slots = 1
	can_hold = list(
		/obj/item/clothing/mask/luchador
		)

/obj/item/weapon/storage/belt/military
	name = "military belt"
	desc = "A syndicate belt designed to be used by boarding parties. It can hold a large variety of weapons and gadgets."
	icon_state = "militarybelt"
	item_state = "military"

/obj/item/weapon/storage/belt/MDAC
	name = "Mechadendrite Autocannon Attachment"
	desc = "An incredible piece of technology which allows you to hold larger firearms. It also has a belt for storing things."
	icon_state = "23"
	item_state = "military"
	flags = NODROP
	flags = STOPSPRESSUREDMAGE|NODROP
	var/can_toggle = 1
	var/is_toggled = 1

	verb/toggleclamp()
		set name = "Equip AutoCannon"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This weapon cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/gun/projectile/AutoCannon )) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] unhinges the autocannon and retracts it to a storage state.</span>", "<span class='notice'>You release your grip on the autocannon.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/gun/projectile/AutoCannon )) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] unhinges the autocannon and retracts it to a storage state.</span>", "<span class='notice'>You release your grip on the autocannon.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You are no longer using the autocannon."
			src.is_toggled = 1
		else
			usr << "You bring your autocannon out in front of you and get ready to use it."
			usr.put_in_hands(new /obj/item/weapon/gun/projectile/AutoCannon (usr))
			src.is_toggled = 2

/obj/item/weapon/storage/belt/MDAC/dropped()
	qdel(src)

/obj/item/weapon/storage/belt/wands
	name = "wand belt"
	desc = "A belt designed to hold various rods of power. A veritable fanny pack of exotic magic."
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	storage_slots = 6
	can_hold = list(
		/obj/item/weapon/gun/magic/wand
		)

/obj/item/weapon/storage/belt/wands/full/New()
	..()
	new /obj/item/weapon/gun/magic/wand/death(src)
	new /obj/item/weapon/gun/magic/wand/resurrection(src)
	new /obj/item/weapon/gun/magic/wand/polymorph(src)
	new /obj/item/weapon/gun/magic/wand/teleport(src)
	new /obj/item/weapon/gun/magic/wand/door(src)
	new /obj/item/weapon/gun/magic/wand/fireball(src)

	for(var/obj/item/weapon/gun/magic/wand/W in contents) //All wands in this pack come in the best possible condition
		W.max_charges = initial(W.max_charges)
		W.charges = W.max_charges

/obj/item/weapon/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	item_state = "janibelt"
	storage_slots = 6
	max_w_class = 4 // Set to this so the  light replacer can fit.
	can_hold = list(
		/obj/item/weapon/grenade/chem_grenade/cleaner,
		/obj/item/device/lightreplacer,
		/obj/item/device/flashlight,
		/obj/item/weapon/reagent_containers/spray,
		/obj/item/weapon/soap,
		/obj/item/weapon/holosign_creator
		)

/obj/item/weapon/storage/belt/imperialbelt
	name = "Imperial Belt"
	desc = "Imperial Guard Belt, Can hold various things."
	icon_state = "imperialbelt"
	item_state = "imperialbelt"
	storage_slots = 5
	max_w_class = 3
	can_hold = list(
	 /obj/item/weapon/melee/baton,
	 /obj/item/weapon/melee/classic_baton,
	 /obj/item/weapon/grenade/flashbang,
	 /obj/item/weapon/reagent_containers/spray/pepper,
	 /obj/item/weapon/handcuffs,
	 /obj/item/device/flash,
	 /obj/item/clothing/glasses,
	 /obj/item/ammo_casing/shotgun,
	 /obj/item/ammo_box,
	 /obj/item/weapon/reagent_containers/food/snacks/donut/normal,
	 /obj/item/weapon/reagent_containers/food/snacks/donut/jelly,
	 /obj/item/device/flashlight/seclite,
	 /obj/item/weapon/melee/telebaton
	 )

/obj/item/weapon/storage/belt/imperialbelt/sob
	icon_state = "imperialbelt"
	item_state = "imperialbelt"

/obj/item/weapon/storage/belt/imperialbelt/sob/New()
	..()
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)
	new /obj/item/ammo_box/magazine/bpistolmag(src)