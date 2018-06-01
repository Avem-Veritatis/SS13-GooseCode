/obj/item/weapon/retractor
	name = "retractor"
	desc = "Retracts stuff."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "retractor"
	m_amt = 6000
	g_amt = 3000
	flags = CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"


/obj/item/weapon/hemostat
	name = "hemostat"
	desc = "You think you have seen this before."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "hemostat"
	m_amt = 5000
	g_amt = 2500
	flags = CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"
	attack_verb = list("attacked", "pinched")


/obj/item/weapon/cautery
	name = "cautery"
	desc = "This stops bleeding."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "cautery"
	m_amt = 2500
	g_amt = 750
	flags = CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"
	attack_verb = list("burnt")


/obj/item/weapon/surgicaldrill
	name = "surgical drill"
	desc = "You can drill using this item. You dig?"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "drill"
	hitsound = 'sound/weapons/circsawhit.ogg'
	m_amt = 10000
	g_amt = 6000
	flags = CONDUCT
	force = 15.0
	w_class = 3.0
	origin_tech = "materials=1;biotech=1"
	attack_verb = list("drilled")

/obj/item/weapon/scalpel/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is pressing [src] to \his temple and activating it! It looks like \he's trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is pressing [src] to \his chest and activating it! It looks like \he's trying to commit suicide.</span>"))
	return (BRUTELOSS)


/obj/item/weapon/scalpel
	name = "scalpel"
	desc = "Cut, cut, and once more cut."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "scalpel"
	flags = CONDUCT
	force = 10.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	m_amt = 4000
	g_amt = 1000
	origin_tech = "materials=1;biotech=1"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/weapon/scalpel/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is slitting \his wrists with [src]! It looks like \he's trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting \his throat with [src]! It looks like \he's trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting \his stomach open with [src]! It looks like \he's trying to commit seppuku.</span>"))
	return (BRUTELOSS)


/obj/item/weapon/circular_saw
	name = "circular saw"
	desc = "For heavy duty cutting."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "saw"
	hitsound = 'sound/weapons/circsawhit.ogg'
	throwhitsound =  'sound/weapons/pierce.ogg'
	flags = CONDUCT
	force = 15.0
	w_class = 3.0
	throwforce = 9.0
	throw_speed = 2
	throw_range = 5
	m_amt = 10000
	g_amt = 6000
	origin_tech = "materials=1;biotech=1"
	attack_verb = list("attacked", "slashed", "sawed", "cut")

/obj/item/weapon/circular_saw/attack(mob/user, mob/living/carbon/target)
	if(ishuman(target))
		if(target.stat == DEAD)
			var/obj/item/organ/heart/A
			A = locate() in target.internal_organs
			if(A)
				user.visible_message("<span class='notice'>[user] cuts out [target]'s heart!</span>")

				target.internal_organs -= A
				A = null
				new /obj/item/organ/heart(target.loc)
			else
				user.visible_message("<span class='notice'>[user] can not seem to find a heart inside of [target]'s chest.</span>")
			return
	..()


/obj/item/weapon/surgical_drapes
	name = "surgical drapes"
	desc = "Surgical drapes provide optimal safety and infection control."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "surgical_drapes"
	w_class = 1.0
	origin_tech = "biotech=1"
	attack_verb = list("slapped")

/obj/item/weapon/surgical_drapes/attack(mob/living/M, mob/user)
	if(!attempt_initiate_surgery(src, M, user))
		..()

/obj/item/weapon/surgical_drapes/cyber/dropped()
	qdel(src)

/obj/item/weapon/retractor/cyber/dropped()
	qdel(src)

/obj/item/weapon/hemostat/cyber/dropped()
	qdel(src)

/obj/item/weapon/cautery/cyber/dropped()
	qdel(src)

/obj/item/weapon/surgicaldrill/cyber/dropped()
	qdel(src)

/obj/item/weapon/scalpel/cyber/dropped()
	qdel(src)

/obj/item/weapon/circular_saw/cyber/dropped()
	qdel(src)