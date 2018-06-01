/obj/item/weapon/implant/digital
	name = "digital weapon"
	desc = "Use this blast an unsuspecting victim with a single powerful laser shot."
	item_color = "r"
	var/activation_emote = "flipoff"
	var/uses = 1.0

	trigger(emote, mob/living/carbon/source as mob)
		if (src.uses < 1)	return 0
		if (emote == src.activation_emote)
			src.uses--
			source << "\red You activate your digital weapon."
			var/turf/T = source.loc
			var/turf/U = get_step(source, source.dir)
			if(!isturf(U) || !isturf(T))
				return
			var/obj/item/projectile/beam/digital/A = new /obj/item/projectile/beam/digital(source.loc)
			A.current = U
			A.yo = U.y - T.y
			A.xo = U.x - T.x
			A.process()
			return

	implanted(mob/living/carbon/source)
		source.mind.store_memory("Digital weapon can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate.", 0, 0)
		source << "The digital weapon can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate."
		return 1


	get_data()
		var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Digital Weapon<BR>
<b>Life:</b> 1 use<BR>
<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
<HR>
<b>Implant Details:</b> <BR>
<b>Function:</b> A single use concealed gun of some kind.<BR>
No Implant Specifics"}
		return dat

/obj/item/weapon/implanter/digital
	name = "Digital Weapon Implant"

/obj/item/weapon/implanter/digital/New()
	imp = new /obj/item/weapon/implant/digital(src)
	..()
	update_icon()