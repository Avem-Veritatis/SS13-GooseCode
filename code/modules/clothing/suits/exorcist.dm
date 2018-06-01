/*
I am vaguely wondering why I am actually making this
But it doesn't take particularly long and it could play a role in the space hulk
I don't think this would be RTD related cuz its a terminator suit
But it can do something
-Drake
*/

/obj/item/clothing/shoes/magboots/exorcist
	desc = "Exorcist Cataphractii Boots"
	name = "Exorcist Cataphractii Boots"
	icon_state = "exorcist_boots"
	magboot_state = "exorcist_boots"
	slowdown_off = SHOES_SLOWDOWN
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE

/obj/item/weapon/tank/oxygen/exorcist
	name = "Exorcist Cataphractii Power Unit"
	desc = "The back unit containing oxygen and power storage for a Cataphractii Pattern Terminator suit."
	icon_state = "exorcist_back"
	item_state = "exorcist_back"
	volume = 2000
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/clothing/head/helmet/exorcist
	name = "Exorcist Cataphractii Helmet"
	desc = "Helm of an Exorcist Terminator"
	icon_state = "exorcist_helmet"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR||!CANSTUN|!CANWEAKEN
	item_state = "exorcist_helmet"
	armor = list(melee = 90, bullet = 85, laser = 75, energy = 100, bomb = 70, bio = 100, rad = 95)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/clothing/suit/armor/exorcist
	name = "Exorcist Cataphractii Suit"
	desc = "Exorcist Cataphractii Pattern Tactical Dreadnought Armor"
	icon_state = "exorcist_cataphractii"
	item_state = "exorcist_cataphractii"
	w_class = 4//bulky item
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/gun/projectile/automatic/bolter)
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	blood_overlay_type = "armor"
	slowdown = 0
	armor = list(melee = 95, bullet = 90, laser = 85, energy = 100, bomb = 85, bio = 100, rad = 95)

	verb/togglegun()
		set name = "Toggle Combi-Bolter"
		set category = "Terminator"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(istype(usr.l_hand, /obj/item/weapon/gun/energy/combibolter)) //Not the nicest way to do it, but eh
			qdel(usr.l_hand)
			usr.visible_message("<span class='warning'>[usr] retracts the combi-bolter.</span>", "<span class='notice'>You retract your combi-bolter.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
			usr.update_inv_hands()
			return
		if(istype(usr.r_hand, /obj/item/weapon/gun/energy/combibolter)) //Not the nicest way to do it, but eh
			qdel(usr.r_hand)
			usr.visible_message("<span class='warning'>[usr] retracts the combi-bolter.</span>", "<span class='notice'>You retract your combi-bolter.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
			usr.update_inv_hands()
			return
		else
			usr.visible_message("<span class='warning'>[usr] raises the combi-bolter.</span>", "<span class='notice'>You ready your combi-bolter.</span>", "<span class='warning>You hear mechanical joints rumbling.</span>")
			usr.put_in_hands(new /obj/item/weapon/gun/energy/combibolter(usr))
			return

/obj/item/clothing/gloves/exorcist
	desc = "Exorcist Cataphractii Gloves."
	name = "Exorcist Cataphractii Gloves"
	icon_state = "exorcist_gloves"
	item_state = "exorcist_gloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/ammo_casing/energy/bolter
	projectile_type = /obj/item/projectile/bullet/gyro
	select_name = "bolter"
	e_cost = 300

/obj/item/weapon/gun/energy/combibolter
	name = "Combi-Bolter"
	desc = "A massive twin-linked bolter."
	icon_state = "combibolter"
	item_state = "stormbolter"
	w_class = 4.0
	m_amt = 2000
	origin_tech = "combat=10"
	ammo_type = list(/obj/item/ammo_casing/energy/bolter)
	cell_type = "/obj/item/weapon/stock_parts/cell/super"
	slot_flags = 0
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	var/charge_tick = 0

	New()
		..()
		processing_objects.Add(src)

	Destroy()
		processing_objects.Remove(src)
		..()

	process()
		charge_tick++
		if(charge_tick < 4) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(25)
		return 1

	update_icon()
		return

	dropped()
		qdel(src)

	afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //Three round burst of bolts.
		spawn(0)
			..()
		spawn(3)
			..()
		spawn(6)
			..()
		spawn(9)
			..()