/* Types of tanks!
 * Contains:
 *		Oxygen
 *		Anesthetic
 *		Air
 *		Plasma
 *		Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/weapon/tank/oxygen
	name = "oxygen tank"
	desc = "A tank of oxygen."
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE


	New()
		..()
		src.air_contents.oxygen = src.volume
		return


	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 10*ONE_ATMOSPHERE)
			usr << text("\red <B>The meter on the [src.name] indicates you are almost out of air!</B>")
			playsound(usr, 'sound/effects/alert.ogg', 50, 1)


/obj/item/weapon/tank/oxygen/yellow
	desc = "A tank of oxygen, this one is yellow."
	icon_state = "oxygen_f"

/obj/item/weapon/tank/oxygen/red
	desc = "A tank of oxygen, this one is red."
	icon_state = "oxygen_fr"

/obj/item/weapon/tank/oxygen/umback
	name = "Ultramarine Powersource"
	desc = "An Ultramarine BATPACK"
	icon_state = "umback"
	item_state = "umback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/weapon/tank/oxygen/ksons
	name = "Thousand Sons Powersource"
	desc = "Thousand Sons Powersource"
	icon_state = "ksonsback"
	item_state = "ksonsback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/weapon/tank/oxygen/rgback
	name = "RavenGuard Powersource"
	desc = "An Raven Guard BATPACK"
	icon_state = "rgback"
	item_state = "rgback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/weapon/tank/oxygen/rgback/verb/activatejetpack()
	set name = "Activate Jetpack"
	set category = "Raven Guard"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	activate()
	playsound(loc, 'sound/effects/bin_close.ogg', 75, 0)

/obj/item/weapon/tank/oxygen/rgback/proc/activate()
	usr.equip_to_slot(new /obj/item/weapon/tank/oxygen/jump/rg, slot_back)
	usr.drop_item()
	qdel(src)

/obj/item/weapon/tank/oxygen/smback
	name = "Salamander Powersource"
	desc = "A Salamander BATPACK"
	icon_state = "smback"
	item_state = "smback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP

/obj/item/weapon/tank/oxygen/KBback
	name = "RAWR!!"
	desc = "A Batpack FOR THE BLOOD GOD"
	icon_state = "KBback"
	item_state = "KBback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP


/*
 * Anesthetic
 */
/obj/item/weapon/tank/anesthetic
	name = "anesthetic tank"
	desc = "A tank with an N2O/O2 gas mix."
	icon_state = "anesthetic"
	item_state = "an_tank"

/obj/item/weapon/tank/anesthetic/New()
	..()

	src.air_contents.oxygen = 300*ONE_ATMOSPHERE
	src.air_contents.sleepgas = 300*ONE_ATMOSPHERE
	return

/*
 * Air
 */
/obj/item/weapon/tank/air
	name = "air tank"
	desc = "Mixed anyone?"
	icon_state = "oxygen"


	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 1 && loc==usr)
			usr << "\red <B>The meter on the [src.name] indicates you are almost out of air!</B>"
			usr << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/air/New()
	..()

	src.air_contents.oxygen = src.volume
	return


/*
 * Plasma
 */
/obj/item/weapon/tank/plasma
	name = "promethium tank"
	desc = "Contains promethium. Warning: EXTREMELY flammable."
	icon_state = "promethium"
	flags = CONDUCT
	slot_flags = null	//they have no straps!


/obj/item/weapon/tank/plasma/New()
	..()
	src.air_contents.promethium = 600*ONE_ATMOSPHERE
	return

/obj/item/weapon/tank/plasma/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

	if (istype(W, /obj/item/weapon/flamethrower))
		var/obj/item/weapon/flamethrower/F = W
		if ((!F.status)||(F.ptank))	return
		src.master = F
		F.ptank = src
		user.unEquip(src)
		src.loc = F
	return

/obj/item/weapon/tank/plasma/full/New()
	..()
	src.air_contents.promethium = 600*ONE_ATMOSPHERE
	return

/*
 * Emergency Oxygen
 */
/obj/item/weapon/tank/emergency_oxygen
	name = "emergency oxygen tank"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = 2.0
	force = 4.0
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 100 //100 breaths of air.


	New()
		..()
		src.air_contents.oxygen = src.volume
		return


	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 0.2 && loc==usr)
			usr << text("\red <B>The meter on the [src.name] indicates you are almost out of air!</B>")
			usr << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/emergency_oxygen/engi
	name = "extended-capacity emergency oxygen tank"
	icon_state = "emergency_engi"
	volume = 175

/obj/item/weapon/tank/emergency_oxygen/double
	name = "double emergency oxygen tank"
	icon_state = "emergency_engi"
	volume = 350

/obj/item/weapon/tank/emergency_oxygen/double/DK
	name = "Krieg Oxygen Tank"
	desc = "A regulator unit, is carried inside a leather satchel buckled to his webbing and is easily the most complex piece. A battery-powered fan draws in air, which is passed through particle filters and air-quality samplers, before being pumped up through an air pipe into the guardsman's gasmask."
	icon_state = "koxygen"
	volume = 600

/obj/item/weapon/tank/oxygen/pmback
	name = "Plague Marine Powersource"
	desc = "A Plague Marine BATPACK"
	icon_state = "pmback"
	item_state = "pmback"
	volume = 800
	flags = STOPSPRESSUREDMAGE|NODROP