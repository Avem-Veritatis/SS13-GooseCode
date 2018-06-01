/obj/item/weapon/melee/chainofcommand
	name = "chain of command"
	desc = "A tool used by great men to placate the frothing masses."
	icon_state = "chain"
	item_state = "chain"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 7
	w_class = 3
	origin_tech = "combat=4"
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/effects/woodhit.ogg'

/obj/item/weapon/melee/chainofcommand/suicide_act(mob/user)
		user.visible_message("<span class='suicide'>[user] is strangling \himself with the [src.name]! It looks like \he's trying to commit suicide.</span>")
		return (OXYLOSS)

/obj/item/weapon/melee/chainofcommand/longchain
	name = "long chain"
	desc = "A long metal chain. A brutal way of dispatching enemies."
	icon_state = "longchain"
	item_state = "chain"
	hitsound = 'sound/effects/woodhit.ogg'
	force = 12
	attack_verb = list("flogged", "whipped", "lashed", "brutalised")

/obj/item/weapon/melee/chainofcommand/cwhip
	name = "Whip"
	desc = "This whip teaches what words can not."
	icon_state = "whip"
	item_state = "chain"
	hitsound = 'sound/effects/commissar.ogg'
	force = 5
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")

/obj/item/weapon/melee/chainofcommand/cwhip/attack_self(mob/user, slot)
	playsound(loc, 'sound/ambience/comisar2.ogg', 75, 0)
	..()


/obj/item/weapon/melee/classic_baton
	name = "police baton"
	desc = "A wooden truncheon for beating criminal scum."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "baton"
	item_state = "classic_baton"
	slot_flags = SLOT_BELT
	force = 10

/obj/item/weapon/melee/classic_baton/attack(mob/M, mob/living/user)
	add_fingerprint(user)
	if((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>You club yourself over the head!</span>"
		user.Weaken(3 * force)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(2 * force, BRUTE, "head")
			H.forcesay(hit_appends)
		else
			user.take_organ_damage(2 * force)
		return
	add_logs(user, M, "attacked", object="[src.name]")

	if(isrobot(M)) // Don't stun borgs, fix for issue #2436
		..()
		return
	if(!isliving(M)) // Don't stun nonhuman things
		return

	if(user.a_intent == "harm")
		if(!..()) return
		if(M.stuttering < 7 && !(HULK in M.mutations))
			M.stuttering = 7
		M.Stun(7)
		M.Weaken(7)
		M.visible_message("<span class='danger'>[M] has been beaten with [src] by [user]!</span>", \
							"<span class='userdanger'>[M] has been beaten with [src] by [user]!</span>")
	else
		playsound(loc, 'sound/effects/woodhit.ogg', 75, 1, -1)
		M.Stun(7)
		M.Weaken(7)
		M.visible_message("<span class='danger'>[M] has been stunned with [src] by [user]!</span>", \
							"<span class='userdanger'>[M] has been stunned with [src] by [user]!</span>")

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.forcesay(hit_appends)


/obj/item/weapon/melee/telebaton
	name = "telescopic baton"
	desc = "A compact yet robust personal defense weapon. Can be concealed when folded."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "telebaton_0"
	item_state = "telebaton_0"
	slot_flags = SLOT_BELT
	w_class = 2
	force = 3
	var/cooldown = 0
	var/on = 0

/obj/item/weapon/melee/telebaton/attack_self(mob/user as mob)
	on = !on
	if(on)
		user.visible_message("<span class ='warning'>With a flick of their wrist, [user] extends their telescopic baton.</span>",\
		"<span class ='warning'>You extend the baton.</span>",\
		"You hear an ominous click.")
		icon_state = "telebaton_1"
		item_state = "nullrod"
		w_class = 4 //doesnt fit in backpack when its on for balance
		force = 10 //seclite damage
		attack_verb = list("smacked", "struck", "cracked", "beaten")
	else
		user.visible_message("<span class ='notice'>[user] collapses their telescopic baton.</span>",\
		"<span class ='notice'>You collapse the baton.</span>",\
		"You hear a click.")
		icon_state = "telebaton_0"
		item_state = "telebaton_0" //no sprite in other words
		slot_flags = SLOT_BELT
		w_class = 2
		force = 3 //not so robust now
		attack_verb = list("hit", "poked")

	playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)
	add_fingerprint(user)

/obj/item/weapon/melee/telebaton/attack(mob/target as mob, mob/living/user as mob)
	if(on)
		if ((CLUMSY in user.mutations) && prob(50))
			user << "<span class ='danger'>You club yourself over the head.</span>"
			user.Weaken(3 * force)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.apply_damage(2*force, BRUTE, "head")
			else
				user.take_organ_damage(2*force)
			return
		if (user.a_intent == "harm")
			if(!..()) return
			if(!isrobot(target))
				playsound(get_turf(src), "swing_hit", 50, 1, -1)
		else
			if(cooldown <= 0)
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				target.Weaken(3)
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[target] has been knocked down with \the [src] by [user]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
				cooldown = 1
				spawn(30)
					cooldown = 0
		return
	else
		return ..()

/*
Bloodpact
*/
/obj/item/weapon/melee/kbsword
	name = "Khornite Sacrificial blade"
	desc = "Only has a limited number of uses. Click me!"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "bpblade"
	item_state = "bpblade"
	slot_flags = SLOT_BELT
	w_class = 2
	force = 15
	var/numberuses = 3

/obj/item/weapon/melee/kbsword/attack_self(mob/user as mob)
	if(numberuses > 0)
		user.visible_message("<span class ='warning'>[user] Cuts into his own flesh and begins painting a symbol upon the floor with his blood.</span>",\
		"<span class ='warning'>You call for aid... You hope there are GHOSTS in the warp that will accept the call.</span>",\
		"You hear blood dripping.")
		if(do_after(user, 100))
			user.visible_message("<span class ='warning'>[user] Is done with the rune.</span>",\
			"<span class ='warning'>Now all you have to do is activate it.</span>",\
			"Your blind. You can't see shit.")
			numberuses --
			new /obj/effect/decal/cleanable/kbsummonrune(user.loc)
		else
			user.visible_message("<span class ='danger'>[user] has been interupted!</span>")
	else
		user.visible_message("<span class ='notice'>[user] gets ready to slash open his own flesh.. but pauses a moment.",\
		"<span class ='notice'>You sense that this item is no longer connected to the warp</span>",\
		"You hear people playing with knives.")
		return

/*
HOP
*/

/obj/item/weapon/melee/hopsword
	name = "Imperial Ornamental Blade"
	desc = "Forged from pure steel six lightyears from the sector capital. A true work of art."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "hopblade"
	item_state = "DKsword"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 20
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
