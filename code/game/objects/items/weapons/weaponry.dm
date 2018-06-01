/obj/item/weapon/banhammer
	desc = "A banhammer"
	name = "banhammer"
	icon = 'icons/obj/items.dmi'
	icon_state = "toyhammer"
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 1.0
	throw_speed = 3
	throw_range = 7
	attack_verb = list("banned")

/obj/item/weapon/banhammer/suicide_act(mob/user)
		user.visible_message("<span class='suicide'>[user] is hitting \himself with the [src.name]! It looks like \he's trying to ban \himself from life.</span>")
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)

/obj/item/weapon/banhammer/attack(mob/M, mob/user)
	M << "<font color='red'><b> You have been banned FOR NO REISIN by [user]<b></font>"
	user << "<font color='red'> You have <b>BANNED</b> [M]</font>"
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much

/obj/item/weapon/brassknuckles
	name = "brass knuckles"
	desc = "A pair of shiny, easily concealed brass knuckles. A miner's go-to bar fight weapon."
	icon_state = "brassknuckles"
	item_state = "brassknuckles"
	w_class = 1
	force = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 7
	attack_verb = list("beaten", "punched", "slammed", "smashed")
	hitsound = 'sound/weapons/punch3.ogg'

/obj/item/weapon/baseballbat
	name = "wooden bat"
	desc = "HOME RUN!"
	icon_state = "woodbat"
	item_state = "woodbat"
	w_class = 3.0
	force = 13
	throw_speed = 3
	throw_range = 7
	throwforce = 7
	attack_verb = list("smashed", "beaten", "slammed", "smacked", "striked", "battered", "bonked")
	hitsound = 'sound/weapons/genhit3.ogg'

/obj/item/weapon/baseballbat/metal
	name = "metal bat"
	desc = "A shiny metal bat."
	icon_state = "metalbat"
	item_state = "metalbat"
	w_class = 3.0
	m_amt = 18750 //5 sheets of metal per bat in the autolathe

/obj/item/weapon/butterfly
	name = "butterfly knife"
	desc = "A basic metal blade concealed in a lightweight plasteel grip. Small enough when folded to fit in a pocket."
	icon_state = "butterflyknife"
	item_state = null
	hitsound = null
	var/active = 0
	w_class = 2
	force = 2
	throw_speed = 3
	throw_range = 4
	throwforce = 7
	attack_verb = list("patted", "tapped")

/obj/item/butterflyconstruction
	name = "unfinished concealed knife"
	desc = "An unfinished concealed knife, it looks like the screws need to be tightened."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterflystep1"

/obj/item/butterflyconstruction/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/screwdriver))
		user << "You finish the concealed blade weapon."
		new /obj/item/weapon/butterfly(user.loc)
		del(src)
		return

/obj/item/butterflyblade
	name = "knife blade"
	desc = "A knife blade. Unusable as a weapon without a grip."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly2"
/obj/item/butterflyhandle
	name = "concealed knife grip"
	desc = "A plasteel grip with screw fittings for a blade."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly1"


/obj/item/butterflyhandle/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/butterflyblade))
		user << "You attach the two concealed blade parts."
		new /obj/item/butterflyconstruction(user.loc)
		del(W)
		del(src)
		return

/obj/item/weapon/butterfly/switchblade
	name = "/proper switchblade"
	desc = "A classic switchblade with gold engraving. Just holding it makes you feel like a gangster."
	icon_state = "switchblade"

/obj/item/weapon/butterfly/attack_self(mob/user)
	active = !active
	if(active)
		user << "<span class='notice'>You flip out your [src].</span>"
		playsound(user, 'sound/weapons/flipblade.ogg', 15, 1)
		force = 15 //this is as much as a null rod or butcher cleaver and those just as rare or hard to obtain
		hitsound = 'sound/weapons/bladeslice.ogg'
		icon_state += "_open"
		w_class = 3
		attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	else
		user << "<span class='notice'>The [src] can now be concealed.</span>"
		force = initial(force)
		hitsound = initial(hitsound)
		icon_state = initial(icon_state)
		w_class = initial(w_class)
		attack_verb = initial(attack_verb)
	add_fingerprint(user)

/*
nullrod
*/

/obj/item/weapon/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of chaos's followers."
	icon_state = "nullrod"
	item_state = "nullrod"
	slot_flags = SLOT_BELT | SLOT_POCKET
	force = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	w_class = 1

/obj/item/weapon/nullrod/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/nullrod/conduit //The perfect artifact for facing daemons. Does a massive bonus damage to them, 200 total per hit.
	name = "conduit blade"
	icon_state = "conduit"
	force = 45
	piercingpower = 15
	attack_speedmod = 0
	complex_block = 1
	complex_click = 1
	can_parry = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "stabbed", "pierced", "impaled")
	parryprob = 120
	parryduration = 8

/obj/item/weapon/nullrod/conduit/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/nullrod/conduit/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		H.seer = 1

/obj/item/weapon/nullrod/conduit/dropped()
	..()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.seer = 0

/obj/item/weapon/nullrod/conduit/equipped()
	..()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.seer = 0

/obj/item/weapon/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	slot_flags = SLOT_BELT
	force = 2
	throwforce = 1
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/sord/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return(BRUTELOSS)

/obj/item/weapon/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)

/obj/item/weapon/claymore/IsShield()
	return 1

/obj/item/weapon/claymore/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return(BRUTELOSS)

/obj/item/weapon/claymore/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(prob(20)) new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/katana
	name = "katana"
	desc = "Woefully underpowered in D20"
	icon_state = "katana"
	item_state = "katana"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)

/obj/item/weapon/katana/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(prob(20) && ishuman(M)) new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/katana/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</span>")
	return(BRUTELOSS)

/obj/item/weapon/katana/IsShield()
		return 1

obj/item/weapon/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags = CONDUCT
	force = 9
	throwforce = 10
	w_class = 3
	m_amt = 1875
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")

obj/item/weapon/wirerod/attackby(var/obj/item/I, mob/user as mob)
	..()
	if(istype(I, /obj/item/weapon/shard))
		var/obj/item/weapon/twohanded/spear/S = new /obj/item/weapon/twohanded/spear

		user.unEquip(I)
		user.unEquip(src)

		user.put_in_hands(S)
		user << "<span class='notice'>You fasten the glass shard to the top of the rod with the cable.</span>"
		qdel(I)
		qdel(src)

	else if(istype(I, /obj/item/weapon/wirecutters))
		var/obj/item/weapon/melee/baton/cattleprod/P = new /obj/item/weapon/melee/baton/cattleprod

		user.unEquip(I)
		user.unEquip(src)

		user.put_in_hands(P)
		user << "<span class='notice'>You fasten the wirecutters to the top of the rod with the cable, prongs outward.</span>"
		qdel(I)
		qdel(src)

/obj/item/weapon/umbanner
	name = "UltraMarine Banner"
	icon_state = "umbanner"
	item_state = "umbanner"
	desc = "Hmmm, yep... that sure looks like a banner.."
	force = 10
	w_class = 4.0
	slot_flags = SLOT_BACK
	throwforce = 20
	throw_speed = 3
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	flags = NOSHIELD|HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR
	hitsound = 'sound/weapons/genhit3.ogg'
	attack_verb = list("attacked", "violated", "smacked", "swatted", "bonked")

/obj/item/weapon/umbanner/attack(mob/M, mob/user)
	M << "<font color='red'><b> You have been assaulted by [user] for wasting his time.<b></font>"
	user << "<font color='red'> You warned him for wasting your time. [M]</font>"
	playsound(loc, 'sound/effects/notime.ogg', 50) //keep it at 15% volume so people don't jump out of their skin too much

/*
Powersword
*/

/obj/item/weapon/psword
	name = "Power Sword"
	desc = "An advanced weapon of melee destruction"
	icon_state = "psword"
	item_state = "psword"
	force = 40.0
	throwforce = 25.0
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = 3.0
	flags = CONDUCT | NOSHIELD
	slot_flags = SLOT_BELT
	origin_tech = "combat=3"
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")

/obj/item/weapon/psword/attack_self(mob/user, slot)
	playsound(loc, 'sound/effects/inq.ogg', 75, 0)
	..()

/obj/item/weapon/choppa
	name = "Choppa"
	desc = "Too blunt to be a sword. Is this a metal pipe?"
	icon_state = "choppa"
	item_state = "choppa"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 20
	throwforce = 10
	w_class = 3
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")

/obj/item/weapon/torture
	name = "Information Extractor"
	desc = "Useful for finding out the truth..."
	icon_state = "torture_off"
	item_state = "pk_off"
	hitsound = 'sound/items/Wirecutter.ogg'
	slot_flags = SLOT_BELT
	flags = CONDUCT | NOSHIELD
	force = 5.0
	throwforce = 2
	w_class = 3
	origin_tech = "combat=1"
	attack_verb = list("tortured")
	var/status = 0

/obj/item/weapon/torture/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is putting the red hot [name] in \his mouth! It looks like \he's trying to commit suicide.</span>")
	return (FIRELOSS)

/obj/item/weapon/torture/New()
	..()
	update_icon()
	return

/obj/item/weapon/torture/update_icon()
	if(status)
		icon_state = "torture_on"
	else
		icon_state = "torture_off"

/obj/item/weapon/torture/attack_self(mob/user)
	status = !status
	user << "<span class='notice'>[src] is now [status ? "red hot" : "cooling off"].</span>"
	update_icon()

/obj/item/weapon/torture/attack(mob/M, mob/user)
	if(status && (CLUMSY in user.mutations) && prob(50))
		user << "<span class='danger'>You accidentally burn yourself with [src]!</span>"
		user.Weaken(1)
		return

	if(isrobot(M))
		return
	if(!isliving(M))
		return

	var/mob/living/L = M

	if(user.a_intent == "harm" && status)
		..()
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			new /obj/effect/gibspawner/blood(H.loc)
			if(H.reagents_speedmod < 10)
				H.reagents_speedmod += 5
		L.emote("scream")
		L.damageoverlaytemp = 60
		L.Dizzy(1)
		if(prob(5))
			shake_camera(L, 20, 1)