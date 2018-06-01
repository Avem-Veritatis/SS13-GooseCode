/*
I am moving all the weapons with complex combat code out of weaponry.dm and here to make it more managable.
Note that the "combat overhaul" is more just adding a bunch of special moves to these weapons.
But ideally this will create an actual concept of melee dueling.
*/

/obj/item/weapon/complexknife/combatknife
	name = "Combat Knife"
	desc = "Imperial Combat Knife, standard issue. Used for opening ration cans. Yum."
	icon_state = "cknife"
	item_state = "knife"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 20
	throwforce = 25
	w_class = 3
	attack_speedmod = -1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "cut")

/obj/item/weapon/melee/collapsiblesword
	name = "collapsible sword"
	desc = "A compact five pound razor. Can be concealed when folded."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "cs"
	item_state = "telebaton_0"
	slot_flags = SLOT_BELT
	w_class = 2
	force = 3
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)
	var/on = 0

/obj/item/weapon/melee/collapsiblesword/attack_self(mob/user as mob)
	on = !on
	if(on)
		user.visible_message("<span class ='warning'>With a flick of their wrist, [user] produces a hidden sword.</span>",\
		"<span class ='warning'>You extend the blade.</span>",\
		"You hear an ominous click.")
		icon_state = "katana"
		item_state = "katana"
		w_class = 4 //doesnt fit in backpack when its on for balance
		force = 30 //seclite damage
		attack_verb = list("slashed", "stabbed", "cut", "wounded")
	else
		user.visible_message("<span class ='notice'>[user] puts the sword away.</span>",\
		"<span class ='notice'>You collapse the sword.</span>",\
		"You hear a click.")
		icon_state = "cs"
		item_state = "telebaton_0" //no sprite in other words
		slot_flags = SLOT_BELT
		w_class = 2
		force = 3 //not so robust now
		attack_verb = list("hit", "poked")

	playsound(src.loc, 'sound/weapons/sling.ogg', 50, 1)
	add_fingerprint(user)

/obj/item/weapon/melee/collapsiblesword/attack(mob/target as mob, mob/living/user as mob)
	if(on)
		if ((CLUMSY in user.mutations) && prob(50))
			user << "<span class ='danger'>You cut yourself.</span>"
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
				playsound(get_turf(src), "bladeslice", 50, 1, -1)
		if (user.a_intent == "disarm")
			if(user.next_click <= world.time)
				user.changeNext_move(CLICK_CD_MELEE)
				var/obj/item/D = target.get_active_hand()
				if(D && D.complex_block)
					if(!D.handle_block(src, user, target))
						return
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				target.Weaken(3)
				target.drop_items()
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[target] has been knocked down with \the [src] by [user]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
		if (user.a_intent == "grab")
			if(user.next_click <= world.time)
				user.changeNext_move(CLICK_CD_MELEE)
				var/obj/item/D = target.get_active_hand()
				if(D && D.complex_block)
					if(!D.handle_block(src, user, target, -40))
						return
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				if(ishuman(target))
					var/mob/living/carbon/human/H = target
					if(H.reagents_speedmod <= 10)
						H.reagents_speedmod += 5
				else
					target.Weaken(1)
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[user] sweeps at [target]'s legs with \the [src]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
		if (user.a_intent == "help")
			if(user.next_click <= world.time)
				user.changeNext_move(CLICK_CD_MELEE)
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				step_away(target,user,10)
				var/mob/living/carbon/human/H = user
				var/mob/living/carbon/human/T = target
				if(H.inertial_speed != null)
					if(CANPUSH & target.status_flags)
						step_away(target,user,10)
					var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
					var/hit_area = parse_zone(affecting.name)
					var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
					T.apply_damage(src.force/2, src.damtype, affecting, armor , src)
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[user] knocks [target] back with \the [src]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
		return
	else
		return ..()

/obj/item/weapon/complexsword/DKsword
	name = "Officer Sword"
	desc = "Ceremonial Sword of a Krieg officer. There is no better display of stamped steel in all the galaxy. This one appears fresh off the press."
	icon_state = "DKsword"
	item_state = "DKsword"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/complexsword/IGsword
	name = "Guardsman's Sword"
	desc = "The sword of an imperial guardsman."
	icon_state = "igsword"
	item_state = "katana"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 25
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/complexsword/IGsword/chaos
	name = "Crude Blade"
	desc = "Looks like it belongs to a Cultist"
	icon_state = "igswordb"
	force = 27

/obj/item/weapon/complexsword/IGsword/practice
	name = "Practive Sword"
	desc = "An imperial guard's sword, with the edges deliberately dulled."
	force = 0

/obj/item/weapon/chainsword/ultramarine_chainsword
	name = "chainsword"
	desc = "The Emporer's wrath made manifest."
	icon_state = "chainsword_ultramarine"
	item_state = "chainsword_ultramarine"

/obj/item/weapon/chainsword/ultramarine_chainsword/glow
	name = "chainsword"
	desc = "The Emporer's wrath made manifest."
	icon_state = "chainswordglow"
	item_state = "chainsword_ultramarine"

	dropped()
		qdel(src)

/obj/item/weapon/chainsword/chaos_chainsword
	name = "chainsword"
	desc = "A blood red chainsword."
	icon_state = "chainswordchaos"
	item_state = "mercychainswordig0"

/obj/item/weapon/chainsword/ksons_chainsword
	name = "chainsword"
	desc = "A blood red chainsword."
	icon_state = "ksonssword"
	item_state = "chainsword_ultramarine"

/obj/item/weapon/chainsword/chainchoppa
	name = "Chain Choppa"
	desc = "Dis choppa da best choppa!"
	icon_state = "chainchoppa"
	item_state = "choppa"
	force = 55
	piercingpower = 30

/obj/item/weapon/chainsword/generic_chainsword
	name = "chainsword"
	desc = "A lightweight blade with rotating monomolecular teeth that can cut through power armor."
	icon_state = "chainsword_generic"
	item_state = "mercychainswordig0"

/obj/item/weapon/chainsword/frostblade
	name = "frost blade"
	desc = "A chainsword of incredible quality, this weapon may surpass a power sword."
	icon_state = "frostblade"
	item_state = "mercychainswordig0"
	hitsound = 'sound/weapons/chainsword.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 65
	throwforce = 35
	w_class = 3
	parryprob = 160
	parryduration = 7
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")

/obj/item/weapon/chainsword/chainaxe
	name = "Chain Axe"
	desc = "The vile forces of chaos are excellent lumberjacks"
	icon_state = "chainaxe"
	item_state = "chainaxe"
	hitsound = 'sound/weapons/chainsword.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")
	parryprob = 80
	parryduration = 3  //Weak parry, on the other hand it pierces armor better than a power sword.
	piercingpower = 25      //This is because it is an axe.
	attack_speedmod = 2 //It also has slower attacks.

/obj/item/weapon/chainsword/chainaxe/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(ishuman(M))
		new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/chainsword/chainaxe2
	name = "Chain Axe"
	desc = "The vile forces of chaos are excellent lumberjacks"
	icon_state = "chainaxe2"
	item_state = "chainaxe2"
	hitsound = 'sound/weapons/chainsword.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")
	parryprob = 80
	parryduration = 3
	piercingpower = 25
	attack_speedmod = 2

/obj/item/weapon/chainsword/chainaxe2/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(ishuman(M))
		new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/complexsword/plagueknife
	name = "Plague Knife"
	desc = "An arcane weapon wielded by the followers of Nurgle."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "daemon9"
	item_state = "cultblade"
	flags = CONDUCT
	w_class = 4
	force = 25
	throwforce = 20
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1

/obj/item/weapon/complexsword/plagueknife/attack(mob/living/target as mob, mob/living/carbon/human/user as mob)
	new /obj/effect/gibspawner/blood(target.loc)
	if(target.reagents)
		target.reagents.add_reagent("plague", 2)
	return ..()

/obj/item/weapon/complexsword/cultblade
	name = "Cult Blade"
	desc = "An arcane weapon wielded by the followers of Nurgle"
	icon_state = "cultblade"
	item_state = "cultblade"
	flags = CONDUCT
	w_class = 4
	force = 30
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1

/obj/item/weapon/complexsword/cultblade/attack(mob/living/target as mob, mob/living/carbon/human/user as mob)
	if(iscultist(user))
		new /obj/effect/gibspawner/blood(target.loc)
		return ..()
	else
		user.Paralyse(5)
		user << "\red An unexplicable force powerfully repels the sword from [target]!"
		var/organ = ((user.hand ? "l_":"r_") + "arm")
		var/obj/item/organ/limb/affecting = user.get_organ(organ)
		if(affecting.take_damage(rand(force/2, force))) //random amount of damage between half of the blade's force and the full force of the blade.
			user.update_damage_overlays(0)
	return

/obj/item/weapon/complexsword/cultblade/pickup(mob/living/user as mob)
	if(!iscultist(user) && !istype(user, /mob/living/carbon/human/simulation_enemy_cultist))
		user << "\red An overwhelming feeling of dread comes over you as you pick up the cultist's sword. It would be wise to be rid of this blade quickly."
		user.Dizzy(120)

/*
Eldar PSword
*/

/obj/item/weapon/powersword/eldar
	name = "Power Sword"
	desc = "The last thing a Mon'Keigh will ever see."
	icon_state = "ps_off"
	icon_on = "ps_on"
	icon_off = "ps_off"
	switchsound = 'sound/effects/eldar2.ogg'
	slot_flags = SLOT_BELT
	flags = CONDUCT | NOSHIELD
	force = 30.0
	throwforce = 7
	w_class = 3
	origin_tech = "combat=8"
	attack_verb = list("stabbed", "slashed", "torn", "cut")

//um powersword

/obj/item/weapon/powersword/umpsword
	name = "UltraMarine Power Sword"
	desc = "A very rare weapon seen only among the UltraMarine elite."
	icon_state = "umpsword_off"
	item_state = "claymore"
	icon_on = "umpsword_on"
	icon_off = "umpsword_off"
	item_on = "psword"
	item_off = "claymore"
	switchsound = 'sound/effects/eldar2.ogg'
	slot_flags = SLOT_BELT
	flags = CONDUCT | NOSHIELD
	force = 40.0
	throwforce = 7
	w_class = 3
	origin_tech = "combat=8"
	attack_verb = list("stabbed", "slashed", "torn", "cut")

/obj/item/weapon/powersword/umpsword/rg
	name = "Raven Guard Powersword"
	desc = "A very rare weapon seen only among the Raven Guard elite."

/obj/item/weapon/powersword/pknife
	name = "Power Knife"
	desc = "The last thing a heretic will ever see."
	icon_state = "pknife_off"
	item_state = "pknife_off"
	icon_on = "pknife_on"
	icon_off = "pknife_off"
	item_on = "pknife_on"
	item_off = "pknife_off"
	slot_flags = SLOT_BELT
	flags = CONDUCT | NOSHIELD
	force = 25.0
	throwforce = 7
	w_class = 3
	origin_tech = "combat=4"
	attack_verb = list("stabbed", "slashed", "torn", "cut")
	attack_speedmod = -1 //Faster attacks, not as good at parrying.
	parryprob = 80

/obj/item/weapon/powersword/munitorium
	name = "Power Sword"
	desc = "A munitorium pattern power sword."
	icon_state = "munitoriumpsword_off"
	icon_on = "munitoriumpsword_on"
	icon_off = "munitoriumpsword_off"
	switchsound = 'sound/effects/phasein.ogg'
	force = 40.0
	throwforce = 15
	origin_tech = "combat=6"
	stunforce = 10
	parryprob = 150
	parrycooldown = 2
	parryduration = 6

/obj/item/weapon/powersword/paxe
	name = "Ancient Axe"
	desc = "A really old looking axe."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "paxe_off"
	icon_on = "paxe_on"
	icon_off = "paxe_off"
	switchsound = 'sound/effects/phasein.ogg'
	force = 40.0
	throwforce = 15
	origin_tech = "combat=6"
	stunforce = 10
	parryprob = 80
	parryduration = 3
	piercingpower = 40
	attack_speedmod = 2

/obj/item/weapon/powersword/mace //This is a real artifact in lore, and it seems fitting to have it on this server.
	name = "Mace of Absolution"
	desc = "The mace of absolution!"
	icon_state = "maceabs"
	icon_on = "maceabs_on"
	icon_off = "maceabs"
	switchsound = 'sound/effects/phasein.ogg'
	force = 40.0
	throwforce = 15
	origin_tech = "combat=6"
	stunforce = 10
	parryprob = 80
	parryduration = 3
	piercingpower = 40
	attack_speedmod = 2

/obj/item/weapon/powersword/burning
	name = "Burning Blade"
	desc = "A Loi Pattern Burning Blade. Initially a malfunctioning power sword, the overheating of the blade has been put to use in combat. Good at burning heretics."
	icon_state = "burningblade_off"
	icon_on = "burningblade_on"
	icon_off = "burningblade_off"
	item_on = "cutlass1"
	force = 45
	stunforce = 10
	piercingpower = 35

/obj/item/weapon/powersword/burning/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(user.a_intent == "harm" && status)
		M.fire_stacks += 2
		M.IgniteMob()
		M.take_organ_damage(0, 10) //Yes, this is additional fire damage since it is a burning blade. But also notice how this ignores armor.

/*
 * Two handed complex weapons here.
 */
/obj/item/weapon/twohanded/dualsaber
	icon_state = "dualsaber0"
	name = "double-bladed energy sword"
	desc = "Handle with care."
	force = 3
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	force_unwielded = 3
	force_wielded = 45
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	hitsound = "swing_hit"
	flags = NOSHIELD
	origin_tech = "magnets=3;syndicate=4"
	item_color = "green"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	var/hacked = 0
	reflect_chance = 0
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	parryprob = 200
	parryduration = 7

/obj/item/weapon/twohanded/dualsaber/New()
	item_color = pick("red", "blue", "green", "purple")

/obj/item/weapon/twohanded/dualsaber/update_icon()
	if(wielded)
		icon_state = "dualsaber[item_color][wielded]"
	else
		icon_state = "dualsaber0"
	clean_blood()//blood overlays get weird otherwise, because the sprite changes.
	return

/obj/item/weapon/twohanded/dualsaber/attack(target as mob, mob/living/user as mob)
	..()
	if((CLUMSY in user.mutations) && (wielded) && prob(40))
		impale(user)
		return
	if((wielded) && prob(50))
		spawn(0)
			for(var/i in list(1,2,4,8,4,2,1,2,4,8,4,2))
				user.dir = i
				sleep(1)

/obj/item/weapon/twohanded/dualsaber/proc/impale(mob/living/user as mob)
	user << "<span class='warning'>You twirl around a bit before losing your balance and impaling yourself on the [src].</span>"
	if (force_wielded)
		user.take_organ_damage(20,25)
	else
		user.adjustStaminaLoss(25)

/obj/item/weapon/twohanded/dualsaber/IsShield()
	if(wielded)
		return 1
	else
		return 0

/obj/item/weapon/twohanded/dualsaber/wield() //Specific wield () hulk checks due to reflect_chance var for balance issues and switches hitsounds.
	..()
	var/mob/living/M = loc
	if(istype(loc, /mob/living))
		if (HULK in M.mutations)
			loc << "<span class='warning'>You lack the grace to wield this to its full extent.</span>"
	hitsound = 'sound/weapons/blade1.ogg'
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)


/obj/item/weapon/twohanded/dualsaber/unwield() //Specific unwield () to switch hitsounds.
	..()
	hitsound = "swing_hit"
	woundtypes = null

/obj/item/weapon/twohanded/dualsaber/IsReflect()
	if(wielded)
		var/mob/living/M = loc
		if(istype(loc, /mob/living))
			if (HULK in M.mutations)
				return
			return 1

/obj/item/weapon/twohanded/dualsaber/green
	New()
		item_color = "green"

/obj/item/weapon/twohanded/dualsaber/red
	New()
		item_color = "red"

/obj/item/weapon/twohanded/dualsaber/khorne
	New()
		item_color = "khorne"

/obj/item/weapon/twohanded/dualsaber/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(src, /obj/item/weapon/twohanded/dualsaber/khorne)) return
	if(istype(W, /obj/item/device/multitool))
		if(hacked == 0)
			hacked = 1
			user << "<span class='warning'>2XRNBW_ENGAGE</span>"
			item_color = "rainbow"
			update_icon()
		else
			user << "<span class='warning'>It's starting to look like a triple rainbow - no, nevermind.</span>"

/obj/item/weapon/twohanded/pchainsword
	icon_state = "pcsword0"
	name = "Eviscerator"
	desc = "This fine piece of craftmanship was assembled for the Ecclesiarchy by an Adeptus Soritas. Engraved into the handle are the words 'Your Sisters gift you with a cure for the Plague of Unbelief'. This is a two handed weapon and does very little damage when not properly held."
	force = 1
	w_class = 4.0
	slot_flags = SLOT_BACK
	force_unwielded = 1
	force_wielded =  35
	throwforce = 20
	throw_speed = 3
	flags = NOSHIELD
	hitsound = 'sound/weapons/chainsword.ogg'
	attack_verb = list("nudged", "poked", "bonked", "tapped", "pushed")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1

/obj/item/weapon/twohanded/pchainsword/attack(mob/living/M as mob, mob/living/user as mob)
	if(istype(M, /mob/living/simple_animal/hostile/retaliate/daemon))
		if(M.stat != 2)
			var/mob/living/simple_animal/hostile/retaliate/daemon/D = M
			D.adjustBruteLoss(20) //Additional damage to daemons.
	..()

/obj/item/weapon/twohanded/pchainsword/update_icon()
	icon_state = "pcsword[wielded]"
	item_state = "pcsword[wielded]"
	hitsound = 'sound/weapons/chainsword.ogg'
	attack_verb = list("sawed" , "mutilated" , "lacerated" , "ripped" , "torn")
	return

/obj/item/weapon/twohanded/chainswordig/inq
	icon_state = "chainswordinq0"
	name = "mercy chainsword"
	desc = "A high quality, lightly adorned, jet black chainsword. Has an imperial aquila on the hilt, and a small inquisitorial insignia on the handle."
	force = 40
	force_unwielded = 40

/obj/item/weapon/twohanded/chainswordig/inq/update_icon()
	icon_state = "chainswordinq[wielded]"
	return

/obj/item/weapon/twohanded/chainswordig/um
	icon_state = "mercychainswordmar0"
	name = "mercy chainsword"
	desc = "A two handed variant of the chain sword used by the ultramarines."

/obj/item/weapon/twohanded/chainswordig/um/update_icon()
	icon_state = "mercychainswordmar[wielded]"
	return

/obj/item/weapon/twohanded/chainswordig/sm
	icon_state = "mercychainswordsm0"
	name = "mercy chainsword"
	desc = "A two handed variant of the chain sword used by the salamander marines."

/obj/item/weapon/twohanded/chainswordig/sm/update_icon()
	icon_state = "mercychainswordsm[wielded]"
	return

/obj/item/weapon/twohanded/required/pike
	name = "pike"
	desc = "A huge pike useful for defense."
	icon_state = "pike"
	item_state = "pike"
	w_class = 4
	throw_range = 0
	force = 25
	piercingpower = 30
	attack_speedmod = 3
	complex_block = 1
	complex_click = 1
	can_parry = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "stabbed", "pierced", "impaled")
	parryprob = 150
	parryduration = 12
	woundtypes = list(/datum/wound/puncture)

/*
TODO:
Make melee weapons attack on bumping into somebody with inertia.
Make fastknife let you run around/through person when you hit them.
Make a warp conduit blade that is really effective against daemons and has null rod banishing powers.
*/

/obj/item/weapon/fastknife
	name = "Combat Razor"
	desc = "A wickedly sharp curved knife with deadly balance."
	icon_state = "fastknife"
	item_state = "knife"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 30
	throwforce = 50
	w_class = 2
	attack_speedmod = -2
	piercingpower = 15
	attack_verb = list("slashed", "sliced", "cut", "rended", "impaled")
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)

/obj/item/weapon/fastknife/attack(mob/target as mob, mob/living/user as mob)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(istype(H.get_inactive_hand(), /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = H.get_inactive_hand()
			if(G.state >= GRAB_NECK)
				if(G.affecting == T)
					spawn(0)
						add_logs(user, target, "tried to slit the throat of")
						H.visible_message("<span class='danger'><b>[H] begins to slit [T]'s throat!</b></span>")
						T.silent += 3 //Shhhh...
						var/check = 40
						while(check && src && H && T && H.get_inactive_hand() == G && G.state >= GRAB_NECK && G.affecting == T && H.get_active_hand() == src)
							check--
							sleep(10)
						if(!check)
							add_logs(user, target, "sucessfully slit the throat of")
							playsound(loc, 'sound/weapons/bladeslice.ogg', 75, 0)
							new /obj/effect/gibspawner/blood(T.loc)
							H.visible_message("<span class='danger'><b>[H] has slit [T]'s throat!</b></span>")
							T.apply_damage(25,"brute","head")
							T.adjustOxyLoss(1000)
							return
						else
							H << "\red You fail to slit [target]'s throat."
							return
		if(prob(50)) new /obj/effect/gibspawner/blood(T.loc)
	return ..()

/obj/item/weapon/thunderhammer
	name = "Thunder Hammer"
	desc = "A hammer that Energizes its power field upon impact making for a Devastating blow."
	icon_state = "thunderhammer"
	item_state = "thunderhammer"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 55
	throwforce = 50
	throw_range = 4
	w_class = 4
	attack_speedmod = 4
	//var/charged = 5
	origin_tech = "combat=5;powerstorage=5"

/obj/item/weapon/thunderhammer/proc/shock(mob/living/target as mob)
	target.take_organ_damage(0,50)
	target.visible_message("\red You hear a heavy powerful pulse")
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 1, 4)
	return


/obj/item/weapon/thunderhammer/attack(mob/M as mob, mob/user as mob)
	..()
	playsound(src.loc, "emitter2", 50, 1)
	if(istype(M, /mob/living))
		shock(M)
	if(!istype(M, /mob/living/carbon/human/whitelisted))
		M.Stun(1)