/datum/curse_effect
	var/name = "generic curse"    //Name
	var/desc = "doesn't exist"    //Help text
	var/charge = 0                //How much energy the curse uses, in spells determines charge time, in objects determines charge time for infusing the object with a curse.
	var/max_uses = 10             //How many times the curse will activate until it wears off. Set to -1 or 0 for infinite.
	var/uses = 0
	var/trigger = "NOTHING"
	var/list/compatible_mobs = list(/mob/living)
	proc/curse_init(var/obj/item/O)    //What the curse does to an object upon laying the curse on it.
		O.curses.Add(src)
	proc/curse_act(var/mob/living/M) //What the curse does to a human upon laying the curse on the human or activating it from an object.
		M.curses.Add(src)
	proc/neutralize_obj(var/obj/item/O)
		O.curses.Remove(src)
	proc/neutralize_mob(var/mob/living/M)
		M.curses.Remove(src)

/datum/curse_effect/New()
	uses = max_uses

/obj/item
	var/list/curses = list()

/mob
	var/list/curses = list()

/obj/item/attack_hand(mob/user as mob)
	if(curses)
		for(var/datum/curse_effect/C in curses)
			if(C.trigger == "ATTACK_HAND")
				if(!(C in user.curses))
					C.curse_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
	..()

/obj/item/attack_self(mob/user as mob)
	if(curses)
		for(var/datum/curse_effect/C in curses)
			if(C.trigger == "ATTACK_SELF")
				if(!(C in user.curses))
					C.curse_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
	..()

/obj/item/equipped(mob/user as mob)
	if(curses)
		for(var/datum/curse_effect/C in curses)
			if(C.trigger == "EQUIP")
				if(!(C in user.curses))
					C.curse_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
	..()

/obj/item/on_found(mob/user as mob)
	if(curses)
		for(var/datum/curse_effect/C in curses)
			if(C.trigger == "FOUND")
				if(!(C in user.curses))
					C.curse_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
	..()

/obj/item/attack(mob/living/M as mob, mob/user as mob)
	if(curses)
		for(var/datum/curse_effect/C in curses)
			if(C.trigger == "ATTACK")
				if(!(C in user.curses))
					C.curse_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
			if(C.trigger == "ATTACK_OTHER")
				if(!(C in M.curses))
					C.curse_act(M)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							curses.Remove(C)
	..()

/obj/effect/proc_holder/spell/aoe_turf/curse
	name = "curse"
	desc = "This spell allows you to imbue people and items with curses and blessings."
	school = "transmutation"
	charge_type = "recharge"
	charge_max = 150
	charge_counter = 0
	clothes_req = 0
	stat_allowed = 0
	invocation = "N'aa izet rehl"
	invocation_type = "whisper"
	range = 3
	cooldown_min = 30 //30 deciseconds reduction per rank
	selection_type = "range"
	var/curse_path = null
	var/datum/curse_effect/curse_type = null
	var/change_curse = 0 //If the curse changes with each casting. Used for wizards.

/obj/effect/proc_holder/spell/aoe_turf/curse/proc/set_curse(curse)
	curse_path = curse
	curse_type = new curse_path
	name = curse_type.name
	desc = curse_type.desc
	charge_max = curse_type.charge

/obj/effect/proc_holder/spell/aoe_turf/curse/New()
	if(curse_path)
		curse_type = new curse_path
		name = curse_type.name
		desc = curse_type.desc
		charge_max = curse_type.charge
		charge_counter = charge_max

/obj/effect/proc_holder/spell/aoe_turf/curse/cast(list/targets, mob/user = usr)
	var/list/possible_targets = list()
	for(var/turf/T in targets)
		for(var/obj/item/O in T.contents)
			possible_targets += O
		for(var/mob/living/M in T.contents)
			possible_targets += M
	if(!possible_targets.len)
		user << "<span class='notice'>No target found in range.</span>"
		return
	var/target = null
	var/choice = input("Choose the target for the spell.", "Targeting") in possible_targets
	//if(choice in view_or_range(range, user, selection_type)) target = choice
	target = choice
	if(!(target in oview(range,user)))//If they are not  in overview after selection.
		user << "<span class='notice'>They are too far away!</span>"
		return
	if(istype(target,/obj/item))
		var/obj/item/O = target
		curse_type.curse_init(O)
	if(istype(target,/mob/living))
		var/mob/living/M = target
		curse_type.curse_act(M)
	if(change_curse)
		set_curse(pick(/datum/curse_effect/undroppable,/datum/curse_effect/ignite,/datum/curse_effect/horseman,/datum/curse_effect/stone,/datum/curse_effect/blind))

/obj/effect/proc_holder/spell/aoe_turf/curse/wizard
	change_curse = 1

/obj/effect/proc_holder/spell/aoe_turf/curse/wizard/New()
	curse_path = pick(/datum/curse_effect/undroppable,/datum/curse_effect/ignite,/datum/curse_effect/horseman,/datum/curse_effect/stone,/datum/curse_effect/blind)
	..()

/datum/curse_effect/undroppable //Basic curse. Simply modifies objects, doesn't require a curse_act on mobs.
	name = "Undroppable Item"
	desc = "Curses the item so that any victim who tries to pick it up will not be able to drop it, as it will be stuck to them."
	charge = 200
	compatible_mobs = list()
	curse_init(var/obj/O)
		O.flags |= NODROP //Makes it undroppable. Simple but highly irritating curse.
		..()
	neutralize_obj(var/obj/O)
		O.flags &= ~NODROP
		..()

/datum/curse_effect/obliterate
	name = "Banish"
	desc = "Banish something from this plane of existence."
	charge = 600
	compatible_mobs = list(/mob/living)
	curse_init(var/obj/O)
		O.obliviate()
	curse_act(var/mob/living/M)
		M.obliviate()

/datum/curse_effect/ignite //Basic curse.
	name = "Fire Curse"
	desc = "A curse that sets people on fire."
	charge = 100
	trigger = "EQUIP" //Includes pick up. Note to self, never use ATTACK_HAND. It doesn't work.
	curse_act(var/mob/living/M)
		M << "\red You burst into flames!"
		M.fire_stacks += 5
		M.IgniteMob()
		..()

/datum/curse_effect/horseman
	name = "The Curse of the Horseman"
	desc = "NEEIGH"
	charge = 250
	trigger = "EQUIP"
	compatible_mobs = list(/mob/living/carbon/human)
	curse_act(var/mob/living/carbon/human/M)
		M <<"<font size='15' color='red'><b>HOR-SIE HAS RISEN</b></font>"
		var/obj/item/clothing/mask/horsehead/magichead = new /obj/item/clothing/mask/horsehead
		magichead.flags |= NODROP		//curses!
		magichead.flags_inv = null	//so you can still see their face
		magichead.voicechange = 1	//NEEEEIIGHH
		if(!M.unEquip(M.wear_mask))
			qdel(M.wear_mask)
		M.equip_to_slot_if_possible(magichead, slot_wear_mask, 1, 1)
		..()
	neutralize_mob(var/mob/living/carbon/human/M) //This one needs a neutralize because it is a permanent effect otherwise. Ignite will probably be neutralized in more mundane ways anyway.
		if(!M.unEquip(M.wear_mask))
			qdel(M.wear_mask)
		M << "\red You hear the sound of a thousand neighs fading from your head..."
		..()

/datum/curse_effect/stone
	name = "Petrification Curse"
	desc = "A curse that turns people to stone, though only breifly."
	charge = 400
	trigger = "EQUIP"
	curse_act(var/mob/living/M)
		M <<"<span class='warning'>You suddenly feel very solid!</span>"
		var/obj/structure/closet/statue/S = new /obj/structure/closet/statue(M.loc, M)
		S.timer = 20
		M.drop_item()
		..()

/datum/curse_effect/blind
	name = "Blindness Curse"
	desc = "A curse that robs a victim of their sight, for a time."
	charge = 200
	trigger = "EQUIP"
	curse_act(var/mob/living/M)
		M <<"<span class='warning'>You go blind!</span>"
		M.eye_blind = 10
		..()

proc/get_curse(effect)
	var/path = null
	switch(effect)
		if("nodrop")
			path = /datum/curse_effect/undroppable
		if("fire")
			path = /datum/curse_effect/ignite
		if("stone")
			path = /datum/curse_effect/stone
		if("blind")
			path = /datum/curse_effect/blind
		if("horseman")
			path = /datum/curse_effect/horseman
	if(path)
		var/obj/effect/proc_holder/spell/aoe_turf/curse/curse = new /obj/effect/proc_holder/spell/aoe_turf/curse
		curse.set_curse(path)
		return curse
	return 0

/obj/effect/proc_holder/spell/aoe_turf/curse/fire
	curse_path = /datum/curse_effect/ignite

/obj/effect/proc_holder/spell/aoe_turf/curse/nodrop
	curse_path = /datum/curse_effect/undroppable

/obj/effect/proc_holder/spell/aoe_turf/curse/stone
	curse_path = /datum/curse_effect/stone

/obj/effect/proc_holder/spell/aoe_turf/curse/horseman
	curse_path = /datum/curse_effect/horseman

/obj/effect/proc_holder/spell/aoe_turf/curse/blind
	curse_path = /datum/curse_effect/blind

/obj/effect/proc_holder/spell/aoe_turf/curse/obliviate //This is a special curse spell, will NOT crop up in the wizard curse spell.
	curse_path = /datum/curse_effect/obliterate

/obj/item/weapon/storage/toolbox/emergency/cursed/New()
	curses += new /datum/curse_effect/ignite