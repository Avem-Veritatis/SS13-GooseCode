
/obj/item/clothing/suit/armor
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/seclite,/obj/item/weapon/melee/telebaton)
	body_parts_covered = CHEST

	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	var/astartes = 0


/obj/item/clothing/suit/armor/vest
	name = "armor vest"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/vest/jacket
	name = "military jacket"
	desc = "An old military jacket, it has armoring."
	icon_state = "militaryjacket"
	item_state = "militaryjacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/hos
	name = "armored coat"
	desc = "A greatcoat enchanced with a special alloy for some protection and style."
	icon_state = "arbit"
	item_state = "hos"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list(melee = 65, bullet = 30, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/armor/hos/comissar2
	name = "comissar coat"
	desc = "A large coat with comissar stripes and heavy reinforcements."
	icon_state = "comissar3"
	item_state = "comissar2"
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 50, rad = 50)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	flags = THICKMATERIAL

/obj/item/clothing/suit/armor/hos/commisar2/festive
	name = "comissar festive coat"
	icon_state = "comissar2"

/obj/item/clothing/suit/armor/vest/warden
	name = "warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_jacket"
	item_state = "warden_jacket"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS

/obj/item/clothing/suit/armor/vest/capcarapace
	name = "captain's carapace"
	desc = "Tissue paper is better than this... you idiot."
	icon_state = "capcarapace"
	item_state = "armor"
	body_parts_covered = CHEST|GROIN
	slowdown = 5
	armor = list(melee = -100, bullet = -100, laser = -100, energy = -100, bomb = -100, bio = -100, rad = -100)

/obj/item/clothing/suit/armor/lc
	name = "Nice Coat"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon_state = "lccoat"
	item_state = "lccoat"
	blood_overlay_type = "armor"
	flags = STOPSPRESSUREDMAGE | THICKMATERIAL
	body_parts_covered = CHEST|ARMS|GROIN
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/shocktrooper
	name = "Shock Trooper Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon_state = "storm"
	item_state = "storm"
	blood_overlay_type = "armor"
	flags = STOPSPRESSUREDMAGE | THICKMATERIAL
	body_parts_covered = CHEST|ARMS|GROIN
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/bodyguard
	name = "Armored Robes"
	desc = "Armoured Robes of those Loyal to the inquisition"
	icon_state = "cultrobes"
	item_state = "cultrobes"
	blood_overlay_type = "armor"
	flags = STOPSPRESSUREDMAGE | THICKMATERIAL
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 70, bullet = 48, laser = 48,energy = 40, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/riot
	name = "riot suit"
	desc = "A suit of armor with heavy padding to protect against melee attacks. Looks like it might impair movement."
	icon_state = "riot"
	item_state = "swat_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 1
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/nob
	name = "Armor"
	desc = "Bits of scrap left layin around. It'll do. It'll do."
	icon_state = "o_armor1"
	item_state = "o_armor1"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 1
	armor = list(melee = 80, bullet = 10, laser = 50, energy = 50, bomb = 0, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/bulletproof
	name = "bulletproof vest"
	desc = "A vest that excels in protecting the wearer against high-velocity solid projectiles."
	icon_state = "bulletproof"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/laserproof
	name = "ablative armor vest"
	desc = "A vest that excels in protecting the wearer against energy projectiles."
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	blood_overlay_type = "armor"
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)
	reflect_chance = 40

/obj/item/clothing/suit/armor/laserproof/IsReflect(var/def_zone)
	var/hit_reflect_chance = reflect_chance
	if(!(def_zone in list("chest", "groin"))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		hit_reflect_chance = 0
	if (prob(hit_reflect_chance))
		return 1

/obj/item/clothing/suit/armor/swat
	name = "swat suit"
	desc = "A heavily armored suit that protects against moderate damage. Used in special operations."
	icon_state = "deathsquad"
	item_state = "swat_suit"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)
	slowdown = 1
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 0, rad = 0)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

/obj/item/clothing/suit/armor/swat/officer
	name = "officer jacket"
	desc = "An armored jacket used in special operations."
	icon_state = "detective"
	item_state = "det_suit"
	blood_overlay_type = "coat"
	flags_inv = 0


/obj/item/clothing/suit/armor/vest/det_suit
	name = "armor"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	allowed = list(/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/device/flashlight,/obj/item/weapon/gun/energy,/obj/item/weapon/gun/projectile,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/lighter,/obj/item/device/detective_scanner,/obj/item/device/taperecorder)



//Reactive armor
//When the wearer gets hit, this armor will teleport the user a short distance away (to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive
	name = "reactive teleport armor"
	desc = "Someone seperated our Research Director from his own head!"
	var/active = 0.0
	icon_state = "reactiveoff"
	item_state = "reactiveoff"
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/reactive/IsShield()
	if(active)
		return 1
	return 0

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		user << "<span class='notice'>[src] is now active.</span>"
		src.icon_state = "reactive"
		src.item_state = "reactive"
	else
		user << "<span class='notice'>[src] is now inactive.</span>"
		src.icon_state = "reactiveoff"
		src.item_state = "reactiveoff"
		src.add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	active = 0
	src.icon_state = "reactiveoff"
	src.item_state = "reactiveoff"
	..()

/*
Lord Inquisitor Armor
*/

/obj/item/clothing/suit/armor/LIOX
	name = "Emergency Temporal Transport"
	desc = "A device which grants it's user an alternative to taking damage."
	var/active = 0.0
	icon_state = "LIOXoff"
	item_state = "LIOXoff"
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 10, bomb = 10, bio = 10, rad = 10)
	action_button_name = "Toggle Shield"

/obj/item/clothing/suit/armor/LIOX/IsShield()
	if(active)
		return 1
	return 0

/obj/item/clothing/suit/armor/LIOX/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		user << "<span class='notice'>[src] is now active.</span>"
		src.icon_state = "LIOX"
		src.item_state = "LIOX"
	else
		user << "<span class='notice'>[src] is now inactive.</span>"
		src.icon_state = "LIOXoff"
		src.item_state = "LIOXoff"
		src.add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/LIOX/emp_act(severity)
	active = 0
	src.icon_state = "LIOXoff"
	src.item_state = "LIOXoff"
	..()


/obj/item/clothing/suit/armor/centcom
	name = "\improper Centcom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state = "centcom"
	w_class = 4//bulky item
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)
	flags = THICKMATERIAL
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "heavy"
	item_state = "swat_suit"
	w_class = 4//bulky item
	gas_transfer_coefficient = 0.90
	flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list(melee = 50, bullet = 70, laser = 45, energy = 10, bomb = 10, bio = 10, rad = 0)

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/tdome/red
	name = "thunderdome suit"
	desc = "Reddish armor."
	icon_state = "tdred"
	item_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "thunderdome suit"
	desc = "Pukish armor."	//classy.
	icon_state = "tdgreen"
	item_state = "tdgreen"

//Power Armor

/obj/item/clothing/suit/armor/umpowerarmor
	name = "Ultra Marine Power Armor"
	desc = "Ultra Marine Armor"
	icon_state = "um_armor"
	item_state = "um_armor"
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
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)
	astartes = 1

/obj/item/clothing/suit/armor/umpowerarmor/captain
	name = "Ultra Marine Captain Power Armor"
	desc = "Ultra Marine Captain Armor"
	icon_state = "umcap"
	item_state = "umcpt_armor"
	armor = list(melee = 85, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 90, rad = 95) //Very small stats bonus.

/obj/item/clothing/suit/armor/umpowerarmor/apoth
	name = "Ultra Marine Apothecary Power Armor"
	desc = "Ultra Marine Apothecary Armor"
	icon_state = "um_apotharmor"
	item_state = "um_apotharmor"

/obj/item/clothing/suit/armor/umpowerarmor/tech
	name = "Ultra TechMarine Power Armor"
	desc = "Ultra TechMarine Armor"
	icon_state = "um_techarmor"
	item_state = "um_techarmor"

/obj/item/clothing/suit/armor/rgpowerarmor
	name = "Raven Guard Power Armor"
	desc = "Raven Guard Armor"
	icon_state = "rg_armor"
	item_state = "rg_armor"
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
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)
	astartes = 1

/obj/item/clothing/suit/armor/rgpowerarmor/apoth
	name = "Raven Guard Apothecary Power Armor"
	desc = "Raven Guard Apothecary Armor"
	icon_state = "rg_apotharmor"
	item_state = "rg_apotharmor"

/obj/item/clothing/suit/armor/rgpowerarmor/tech
	name = "Raven Guard TechMarine Power Armor"
	desc = "Raven Guard TechMarine Armor"
	icon_state = "rg_techarmor"
	item_state = "rg_techarmor"

/obj/item/clothing/suit/armor/rgpowerarmor/shadowcaptain
	name = "Shadow Captain Armor"
	desc = "Raven Guard Armor"
	icon_state = "rgcpt_armor"
	item_state = "rgcpt_armor"
	astartes = 0 //Can't add apothecary / tech overlays

/obj/item/clothing/suit/armor/bpimperialarmor
	name = "Armor"
	desc = "Imperial guard armor, still covered with the blood of the Imperial guard it was taken from."
	icon_state = "bpimperialarmor"
	item_state = "bpimperialarmor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/bpimperialarmor2
	name = "Armor"
	desc = "Imperial guard armor, still covered with the blood of the Imperial guard it was taken from."
	icon_state = "bpimperialarmor2"
	item_state = "bpimperialarmor2"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/imperialarmor
	name = "Basic Flak Armor"
	desc = "Imperial guard flak armor. It looks heavily padded."
	icon_state = "imperialarmor"
	item_state = "imperialarmor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/imperialarmor/reinforced
	name = "Reinforced Flak Armor"
	desc = "Imperial guard flak armor. It looks very heavily padded."
	icon_state = "flakarmor"
	item_state = "flakarmor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 65, bullet = 45, laser = 50, energy = 50, bomb = 40, bio = 0, rad = 5)

/obj/item/clothing/suit/armor/carapace
	name = "carapace armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "carapace"
	item_state = "carapace"
	w_class = 4
	gas_transfer_coefficient = 0.90
	flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list(melee = 85, bullet = 65, laser = 70, energy = 70, bomb = 55, bio = 50, rad = 60)

/obj/item/clothing/suit/armor/subflak
	name = "Sub-Flak Armor"
	desc = "Padded sub-flak armor."
	icon_state = "subflak"
	item_state = "subflak"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 35, bullet = 15, laser = 35, energy = 15, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/DKcoat
	name = "Heavy Greatcoat"
	desc = "The heavy greatcoat is the most distinctive part of the Death Korps uniform, a warm and waterproof coat made locally on Krieg of thick cloth in a variety of colours. Double-breasted with brass buttons, the greatcoat itself can provide limited protection. Plasteel shoulder pads are buckled to the greatcoat and embossed with rank insignia in the case of Watchmasters and higher ranks."
	icon_state = "greatcoat"
	item_state = "greatcoat"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 90, rad = 90)

/obj/item/clothing/suit/armor/DKcoat/officer
	icon_state = "kriegofficer"
	item_state = "kriegofficer"
	armor = list(melee = 65, bullet = 45, laser = 65, energy = 25, bomb = 35, bio = 100, rad = 100)

/obj/item/clothing/suit/armor/valhalla
	name = "Valhallan Greatcoat"
	desc = "A heavily armored, extremely warm, and waterproof coat that forms the standard armor of the valhallan ice warriors."
	icon_state = "valhalla"
	item_state = "valhalla"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT //A bit much, but basically the upshot is these protect you from even severe cold.
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	armor = list(melee = 70, bullet = 55, laser = 45, energy = 50, bomb = 40, bio = 100, rad = 95)

/obj/item/clothing/suit/armor/spowerarmor
	name = "Salamander Power Armor"
	desc = "Salamander Marine Armor"
	icon_state = "sl_armor"
	item_state = "sl_armor"
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
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)
	astartes = 1

/obj/item/clothing/suit/armor/spowerarmor/captain
	name = "Salamander Marine Captain Power Armor"
	desc = "Salamander Marine Captain Armor"
	icon_state = "slcpt_armor"
	item_state = "slcpt_armor"
	armor = list(melee = 85, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 90, rad = 95) //Very small stats bonus.

/obj/item/clothing/suit/armor/spowerarmor/apoth
	name = "Salamander Marine Apothecary Power Armor"
	desc = "Salamander Marine Apothecary Armor"
	icon_state = "sl_apotharmor"
	item_state = "sl_apotharmor"

/obj/item/clothing/suit/armor/spowerarmor/tech
	name = "Salamander TechMarine Power Armor"
	desc = "Salamander TechMarine Armor"
	icon_state = "sl_techarmor"
	item_state = "sl_techarmor"

/obj/item/clothing/suit/armor/sister
	name = "Sister of Battle Armor"
	desc = "Oh god... oh god.... where did you get this?"
	icon_state = "sister"
	item_state = "sister"
	blood_overlay_type = "armor"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	body_parts_covered = CHEST|ARMS|GROIN
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)

/obj/item/clothing/suit/armor/KBpowerarmor
	name = "Khorne Berserker Armor"
	desc = "Khorne Berserker Armor"
	icon_state = "KBpowerarmor"
	item_state = "KBpowerarmor"
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
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)

//inquisitor

/obj/item/clothing/suit/armor/inq
	name = "Inquisitor Suit"
	desc = "A stylish way to scare the shit out of people."
	icon_state = "inq"
	icon_state = "inq"
	blood_overlay_type = "armor"
	flags = STOPSPRESSUREDMAGE | THICKMATERIAL
	body_parts_covered = CHEST|ARMS|GROIN
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/inq/alt
	icon_state = "inqalt"

/obj/item/clothing/suit/armor/inq/old
	icon_state = "inqold"

/obj/item/clothing/suit/armor/inq/cape
	icon_state = "inqcapeo"

/obj/item/clothing/suit/armor/inq/alt/cape
	icon_state = "inqaltcape"

/obj/item/clothing/suit/armor/inq/old/cape
	icon_state = "inqcape"

/obj/item/clothing/suit/armor/inq/random/New()
	..()
	icon_state = pick("inq", "inqalt", "inqold", "inqcape", "inqcapeo", "inqaltcape")

/obj/item/clothing/suit/armor/fwarmor
	name = "Fire Caste Armor"
	desc = "Well, at least it protects from the cold... mostly."
	icon_state = "FWarmor"
	item_state = "FWarmor"
	blood_overlay_type = "armor"
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 75, bullet = 65, laser = 75, energy = 85, bomb = 55, bio = 55, rad = 55) //The basic warrior armor should have increased protection if it is to compete with the stealth suit, so a slight buff is in order -Drake

/obj/item/clothing/suit/armor/tau/fwbarmor
	name = "Fire Warrior Breacher Armor"
	desc = "Well, at least it protects from the cold... mostly."
	icon_state = "tbrea"
	item_state = "tbrea"
	blood_overlay_type = "armor"
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	armor = list(melee = 80, bullet = 70, laser = 75, energy = 85, bomb = 55, bio = 55, rad = 55) //The basic warrior armor should have increased protection if it is to compete with the stealth suit, so a slight buff is in order -Drake

//1k sons
/obj/item/clothing/suit/armor/thousandarmor
	name = "Chaos Power Armor"
	desc = "Chaos Power Armor"
	icon_state = "1k_rubricarmor"
	item_state = "1k_rubricarmor"
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
	slowdown = 1
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)

/obj/item/clothing/suit/armor/thousandarmor/sorc
	name = "Chaos Power Armor"
	desc = "Chaos Power Armor"
	icon_state = "1k_sorcarmor"
	item_state = "1k_sorcarmor"

/obj/item/clothing/suit/armor/thousandarmor/captain
	name = "Chaos Power Armor"
	desc = "Chaos Power Armor"
	icon_state = "1k_leadarmor"
	item_state = "1k_leadarmor"

//plague marine
/obj/item/clothing/suit/armor/pmpowerarmor
	name = "Plague Marine Power Armor"
	desc = "It is a rotted piece of filth, covered in puss and slime."
	icon_state = "pmpowerarmor"
	item_state = "pmpowerarmor"
	w_class = 4//bulky item
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/syringe/plague, /obj/item/weapon/gun/projectile/shotgun/combat/plague)
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	blood_overlay_type = "armor"
	slowdown = 2
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 100, bomb = 80, bio = 80, rad = 95)

//Tau Armor

/obj/item/clothing/head/tstealthsuit
	 name = "XV25 stealth suit Helmet"
	 desc = "Designed for stealth. . . not that you'll be stealthy."
	 icon_state = "XV25"
	 flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	 item_state = "XV25"
	 armor = list(melee = 60, bullet = 45, laser = 55,energy = 65, bomb = 25, bio = 0, rad = 15)
	 flags_inv = HIDEEARS|HIDEEYES
	 cold_protection = HEAD
	 min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	 heat_protection = HEAD
	 max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT

/obj/item/clothing/suit/armor/tstealthsuit
	name = "XV25 Stealthsuit"
	desc = "The XV25 Stealthsuit is one of the smallest of all the various Tau Battlesuits, and is designed for use in operations requiring a high degree of stealth."
	icon_state = "XV25"
	item_state = "XV25"
	blood_overlay_type = "armor"
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	body_parts_covered = CHEST|ARMS|GROIN
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)
	var/stealth = 0
	var/injector = 0

/obj/item/clothing/suit/armor/tstealthsuit/verb/Stimulant_Injector()
	set name = "Stimulant Injector"
	set desc = "Inject a secret chemical that will counteract all movement-impairing effect."
	set category = "XV25 Stealth Suit"
	set popup_menu = 0
	set src in usr													//It's all about the usr. You looking for src? It's right here in usr.
	if(!usr.canmove || usr.stat || usr.restrained())				//This is a train with three stops. First stop is if usr can't move, is dead or restrained. That train stop ends in a return (Meaning we just forget about it)
		return
	if(!injector)													//if injector = 0, this is where we go.
		injector = 1												//While we are here we'll just change injector to yes.
		usr << "<span class='notice'>Adrenaline rushes through you.</span>"	//fluff text
		var/mob/living/carbon/C = usr								//New abstract concept! A person named C! And it is usr.
		C.SetParalysis(0)
		C.SetStunned(0)
		C.SetWeakened(0)
		C.lying = 0
		C.update_canmove()
		C.reagents.add_reagent("tricordrazine", 20)					//We do a bunch of stuff to em
		C.setToxLoss(-3)
		C.setOxyLoss(-3)
		C.setCloneLoss(-3)
		C.radiation = (-3)
		spawn(600)													//spawn makes a new sepperate process, this one will activate after 600 (which is 60 seconds)
			usr << "<span class='notice'>Stimulant Injector Ready.</span>"	//fluff text
			injector = 0											//change injector to no.
	if(injector)													//if injector = yes, this is our third and final train stop.
		usr << "<span class='notice'>Stimulant injector is not ready.</span>"
		return

/obj/item/clothing/suit/armor/tstealthsuit/verb/stealth()
	set category = "XV25 Stealth Suit"
	set desc = "Stealth suit makes you invisible... for the greater good!"
	set popup_menu = 0
	set src in usr
	name = "Stealth"
	desc = "Utilize the stealth suit's capability."
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!stealth) //Didn't want to give them full stealth already strong enough as it is I'd say
		stealth = 1
		usr.alpha = 8
		usr << "\blue You are now harder to spot."
		return
	if(stealth)
		stealth = 0
		usr.alpha = 255
		usr << "\blue You are now visible."
		return