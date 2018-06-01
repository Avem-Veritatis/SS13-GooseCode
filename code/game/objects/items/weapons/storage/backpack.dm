/* Backpacks
 * Contains:
 *		Backpack
 *		Backpack Types
 *		Satchel Types
 */

/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	item_state = "backpack"
	w_class = 4.0
	slot_flags = SLOT_BACK	//ERROOOOO
	max_w_class = 3
	max_combined_w_class = 21

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	playsound(get_turf(src), interaction_sound, 50, 1, -5)
	..()

/*
 * Backpack Types
 */

/obj/item/weapon/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=4"
	icon_state = "holdingpack"
	max_w_class = 5
	max_combined_w_class = 35

	New()
		..()
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(crit_fail)
			user << "<span class = 'notice'>The Bluespace generator isn't working.</span>"
			return
		if(istype(W, /obj/item/weapon/storage/backpack/holding) && !W.crit_fail)
			var/confirm = input("Are you sure you want to do that?", "Put in Bag of Holding") in list("Yes", "No")
			if(confirm == "No"||!Adjacent(user))
				return
			investigate_log("has become a singularity. Caused by [user.key]","singulo")
			user << "<span class='notice'> The Bluespace interfaces of the two devices catastrophically malfunction!</span>"
			qdel(W)
			var/obj/machinery/singularity/singulo = new /obj/machinery/singularity (get_turf(src))
			singulo.energy = 300 //should make it a bit bigger~
			message_admins("[key_name_admin(user)] detonated a [src.name].")
			log_game("[key_name(user)] detonated a [src.name].")
			qdel(src)
			return
		..()

	proc/failcheck(mob/user as mob)
		if (prob(src.reliability)) return 1 //No failure
		if (prob(src.reliability))
			user << "<span class='notice'> The Bluespace portal resists your attempt to add another item.</span>" //light failure
		else
			user << "<span class='notice'> The Bluespace generator malfunctions!</span>"
			for (var/obj/O in src.contents) //it broke, delete what was in it
				qdel(O)
			crit_fail = 1
			icon_state = "brokenpack"

/obj/item/weapon/storage/backpack/holding/belt //It is here instead of belts so it works with all the BoH code.
	name = "belt of holding"
	desc = "An experimental belt that opens into a small, localized pocket of Blue Space."
	icon_state = "holdingbelt"
	item_state = "holdingbelt"
	max_w_class = 3 //It is a backpack for your belt!
	slot_flags = SLOT_BELT

/obj/item/weapon/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = 4.0
	storage_slots = 20
	max_w_class = 3
	max_combined_w_class = 400 // can store a ton of shit!

/obj/item/weapon/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"
	item_state = "backpack"

/obj/item/weapon/storage/backpack/warlock
	name = "Bag"
	desc = "Thats my bag baby yeah...."
	icon_state = "warlock"
	item_state = "warlock"

/obj/item/weapon/storage/backpack/impguard
	name = "Backpack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity... for the EMPRAH!"
	icon_state = "impbag"
	item_state = "impbag"

/obj/item/weapon/storage/backpack/stormtropper
	name = "Backpack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity... for the EMPRAH!"
	icon_state = "stormp"
	item_state = "stormp"


/obj/item/weapon/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "It's a honking backpack made by Honk! Co."
	icon_state = "clownpack"
	item_state = "clownpack"
	interaction_sound = 'sound/items/bikehorn.ogg'

/obj/item/weapon/storage/backpack/mime
	name = "Parcel Parceaux"
	desc = "A silent backpack made for those silent workers. Silence Co."
	icon_state = "mimepack"
	item_state = "mimepack"
	interaction_sound = 'sound/misc/null.ogg'

/obj/item/weapon/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for Imperial officers."
	icon_state = "captainpack"
	item_state = "captainpack"

/obj/item/weapon/storage/backpack/industrial	//adeptus mechanicus
	name = "Explorator Storage Unit"
	desc = "A bionic storage unit used by explorators. Contains a variety of tools and ample general storage space."
	icon_state = "sheetcult"
	item_state = "sheetcult"
	flags = STOPSPRESSUREDMAGE|NODROP
	storage_slots = 10 //Can hold more stuff than your average backpack.
	max_w_class = 3
	max_combined_w_class = 40
	var/can_toggle = 1
	var/is_toggled = 1

	verb/toggleallen()
		set name = "Equip Allen Wrench"
		set category = "Tools"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This tool cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/device/allenwrench)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] quickly hides an ancient tool of incredible power.</span>", "<span class='notice'>You put away the wrench of Saint Allen.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/device/allenwrench)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] quickly hides an ancient tool of incredible power.</span>", "<span class='notice'>You put away the wrench of Saint Allen.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You put away the Wrench of Saint Allen."
			src.is_toggled = 1
		else
			usr << "You pull out a Wrench of Saint Allen."
			usr.put_in_hands(new /obj/item/device/allenwrench(usr))
			src.is_toggled = 2

/obj/item/weapon/storage/backpack/mechaclamp	//adeptus mechanicus
	name = "Mechadendrite pack"
	desc = "It's a clamp with a neat little storage compartment in the back."
	icon_state = "mechaclamp"
	item_state = "mechaclamp"
	flags = STOPSPRESSUREDMAGE|NODROP
	var/can_toggle = 1
	var/is_toggled = 1

	verb/toggleclamp()
		set name = "Equip Clamp"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This tool cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/weapon/melee/clamp )) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] unhinges the mechdendrite clamp and allows it to move of it's own accord.</span>", "<span class='notice'>You brush your cybernetic clamp aside.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/weapon/melee/clamp )) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] unhinges the mechdendrite clamp and allows it to move of it's own accord.</span>", "<span class='notice'>You brush your cybernetic clamp aside.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You brush your cybernetic clamp aside."
			src.is_toggled = 1
		else
			usr << "You bring your cybernetic clamp out in front of you and get ready to use it."
			usr.put_in_hands(new /obj/item/weapon/melee/clamp (usr))
			src.is_toggled = 2

/obj/item/weapon/storage/backpack/mechaclamp/dropped()
	qdel(src)

/obj/item/weapon/storage/backpack/sister		//adeptus soritas bag
	name = "A sister of battle's bag"
	desc = "It holds fire because, thats my bag baby. Yeah...."
	icon_state = "sister"
	item_state = "sister"

/obj/item/weapon/storage/backpack/sister/wing		//adeptus soritas bag
	name = "A sister of battle's bag"
	desc = "It holds fire because, thats my bag baby. Yeah...."
	icon_state = "sister2"
	item_state = "sister2"

	dropped()
		qdel(src)

/obj/item/weapon/storage/backpack/inq		//Inquisitor
	name = "Inquisitor bag"
	desc = "It appears to be made out of some high quality stuff."
	icon_state = "inq"
	item_state = "inq"

/*
 * Ork Bag
 */
/obj/item/weapon/storage/backpack/oddbag/
	name = "Bag of loot."
	desc = "Dis bag has pockets for storing more den da rest."
	icon_state = "nobbag"

/obj/item/weapon/storage/backpack/oddbag/full
	New()
		..()
		new /obj/item/weapon/gun/projectile/shoota( src )
		new /obj/item/weapon/taperoll( src )

/obj/item/weapon/storage/backpack/nobbag
	name = "Bag of loot."
	desc = "Why does the warboss get all da gud loot?."
	icon_state = "nobbag"

/obj/item/weapon/storage/backpack/nobbag/full
	New()
		..()
		new /obj/item/weapon/twohanded/bigchoppa( src )
		new	/obj/item/weapon/shield/nob( src )
		new /obj/item/clothing/suit/armor/nob( src )
		new /obj/item/clothing/under/rank/ork/under( src )

/obj/item/weapon/storage/backpack/kombag
	name = "Bag of loot."
	desc = "Dis bag aint red. Dis bag slow me down."
	icon_state = "nobbag"

/obj/item/weapon/storage/backpack/kombag/full
	New()
		..()
		new /obj/item/weapon/twohanded/spear/sharpstikk( src )
		new /obj/item/weapon/paint/red( src ) //Some new things. Red paint and a sharp stikk.
		new /obj/item/weapon/gun/projectile/shotgun/shotta( src )
		new	/obj/item/device/chameleon( src )
		new /obj/item/weapon/grenade/stickbomb( src )
		new /obj/item/clothing/under/rank/ork/under( src )

/obj/item/weapon/storage/backpack/corsair
	name = "Corsair Backpack"
	desc = "A wraithbone studded backpack for an eldar corsair."
	icon_state = "corsair"

/*
 * Satchel Types
 */

/obj/item/weapon/storage/backpack/satchel
	name = "leather satchel"
	desc = "It's a very fancy satchel made with fine leather."
	icon_state = "satchel"

/obj/item/weapon/storage/backpack/satchel/withwallet
	New()
		..()
		new /obj/item/weapon/storage/wallet/random( src )

/obj/item/weapon/storage/backpack/necron
	name = "storage pack"
	desc = "You wear this on your back and put items into it."
	icon_state = "necron"

/obj/item/weapon/storage/backpack/satchel_norm
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel_eng
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of station life."
	icon_state = "sheetcult"
	item_state = "sheetcult"
	flags = STOPSPRESSUREDMAGE|NODROP
	var/can_toggle = 1
	var/is_toggled = 1

	verb/toggleallen()
		set name = "Equip Allen Wrench"
		set category = "Tools"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This tool cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/device/allenwrench)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] quickly hides an ancient tool of incredible power.</span>", "<span class='notice'>You put away the wrench of Saint Allen.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/device/allenwrench)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] quickly hides an ancient tool of incredible power.</span>", "<span class='notice'>You put away the wrench of Saint Allen.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			usr << "You put away the Wrench of Saint Allen."
			src.is_toggled = 1
		else
			usr << "You pull out a Wrench of Saint Allen."
			usr.put_in_hands(new /obj/item/device/allenwrench(usr))
			src.is_toggled = 2

/obj/item/weapon/storage/backpack/satchel_med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/satchel_vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"

/obj/item/weapon/storage/backpack/satchel_chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"

/obj/item/weapon/storage/backpack/satchel_gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"

/obj/item/weapon/storage/backpack/satchel_tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"

/obj/item/weapon/storage/backpack/satchel_robo
	name = "roboticist satchel"
	desc = "A satchel made with static-free materials for roboticists."
	icon_state = "satchel-robo"

/obj/item/weapon/storage/backpack/satchel_sec
	name = "security satchel"
	desc = "A robust satchel used by security staff."
	icon_state = "satchel-sec"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/satchel_hyd
	name = "hydroponics satchel"
	desc = "A completely biodegradable satchel used by avid botanists."
	icon_state = "satchel_hyd"

/obj/item/weapon/storage/backpack/satchel_cap
	name = "captain's satchel"
	desc = "An exclusive satchel for Imperial officers."
	icon_state = "satchel-cap"
	item_state = "captainpack"
