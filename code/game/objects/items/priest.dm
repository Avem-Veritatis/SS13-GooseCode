
/obj/item/weapon/bible
	name = "Bible"
	desc = "The definitive record of the testament Ecclesiarchy."
	icon = 'icons/obj/priest.dmi'
	icon_state ="book_imperial_truth"
	throw_speed = 2
	throw_range = 5
	w_class = 3.0
	var/interaction_sound
	var/mob/affecting = null
	var/deity_name = "The God Emperor"
	interaction_sound = "pageturn"//bibles sound like paper when opening/dropping/picking up

/obj/item/weapon/bible/New()
	..()
	new /obj/item/weapon/biblepage(src)	//it has blank pages
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)
	new /obj/item/weapon/biblepage(src)

/obj/item/weapon/bible/proc/bless(mob/living/carbon/M as mob)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/heal_amt = 10
		for(var/obj/item/organ/limb/affecting in H.organs)
			if(affecting.heal_damage(heal_amt, heal_amt, 0))
				H.update_damage_overlays(0)
	return

/obj/item/weapon/bible/attack(mob/living/M as mob, mob/living/user as mob)

	var/chaplain = 0
	if(user.mind && (user.mind.assigned_role == "Preacher"))
		chaplain = 1

	add_logs(user, M, "attacked", object="[src.name]")

	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "\red You don't have the dexterity to do this!"
		return
	if(!chaplain)
		user << "\red The book sizzles in your hands."
		user.take_organ_damage(0,10)
		return

//	if(..() == BLOCKED)
//		return

	if (M.stat !=2)
		if(M.mind && (M.mind.assigned_role == "Chaplain"))
			user << "\red You can't heal yourself!"
			return
		/*if((M.mind in ticker.mode.cult) && (prob(20)))
			M << "\red The power of [src.deity_name] clears your mind of heresy!"
			user << "\red You see how [M]'s eyes become clear, the cult no longer holds control over him!"
			ticker.mode.remove_cultist(M.mind)*/
		if ((istype(M, /mob/living/carbon/human) && prob(60)))
			bless(M)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				var/message_halt = 0
				for(var/obj/item/organ/limb/affecting in H.organs)
					if(message_halt == 0)
						for(var/mob/O in viewers(M, null))
							O.show_message(text("\red <B>[] heals [] with the power of [src.deity_name]!</B>", user, M), 1)
						M << "\red May the power of [src.deity_name] compel you to be healed!"
						playsound(src.loc, "punch", 25, 1, -1)
						message_halt = 1
					else
						src << "<span class='warning'>[src.deity_name] refuses to heal this metalic taint!</span>"
						return




		else
			if(ishuman(M) && !istype(M:head, /obj/item/clothing/head/helmet))
				M.adjustBrainLoss(10)
				M << "\red You feel dumber."
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red <B>[] beats [] over the head with []!</B>", user, M, src), 1)
			playsound(src.loc, "punch", 25, 1, -1)

	else if(M.stat == 2)
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red <B>[] smacks []'s lifeless corpse with [].</B>", user, M, src), 1)
		playsound(src.loc, "punch", 25, 1, -1)
	return

/obj/item/weapon/storage/bible/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity) return
	var/chaplain = 0
	if(user.mind && (user.mind.assigned_role == "Preacher"))
		chaplain = 1
	if(istype(A, /mob/living/simple_animal/hostile/retaliate/daemon))
		var/mob/living/simple_animal/hostile/retaliate/daemon/D = A
		if(D.stat != DEAD)
			D.adjustBruteLoss(10)
			if(chaplain)
				D.adjustBruteLoss(15) //Some additonal damage.
			user.visible_message("\red [user] strikes \the [D] with the [src]!")
		return

	if (istype(A, /turf/simulated/floor))
		user << "\blue You hit the floor with the bible."
		if(user.mind && (user.mind.assigned_role == "Chaplain"))
			call(/obj/effect/rune/proc/revealrunes)(src)
	if(user.mind && (user.mind.assigned_role == "Chaplain"))
		if(A.reagents && A.reagents.has_reagent("water")) //blesses all the water in the holder
			user << "\blue You bless [A]."
			var/water2holy = A.reagents.get_reagent_amount("water")
			A.reagents.del_reagent("water")
			A.reagents.add_reagent("holywater",water2holy)
		if(A.reagents && A.reagents.has_reagent("unholywater")) //yeah yeah, copy pasted code - sue me
			user << "\blue You purify [A]."
			var/unholy2clean = A.reagents.get_reagent_amount("unholywater")
			A.reagents.del_reagent("unholywater")
			A.reagents.add_reagent("cleaner",unholy2clean)		//it cleans their soul, get it? I'll get my coat...

/obj/item/weapon/storage/bible/attackby(obj/item/weapon/W as obj, mob/user as mob)
	playsound(src.loc, interaction_sound, 50, 1, -5)
	..()

/obj/item/weapon/bible/attack_self(mob/user as mob)

/obj/item/weapon/bible/proc/can_use(mob/user)
	if(user && ismob(user))
		if(user.stat || user.restrained() || user.paralysis || user.stunned || user.weakened)
			return 0
		if(loc == user)
			return 1
	return 0

/obj/item/weapon/bible/verb/blank_page()
	set category = "Priest"
	set name = "Tear out blank page"
	set src in usr

	if(issilicon(usr))
		return

	if (can_use(usr))
		var/obj/item/weapon/biblepage/O = locate() in src
		if(O)
			if (istype(loc, /mob))
				var/mob/M = loc
				if(M.get_active_hand() == null)
					M.put_in_hands(O)
					usr << "<span class='notice'>You remove \the [O] from \the back of the [src].</span>"
					usr.visible_message("[usr] removes a blank page from the back of his most ancient and holy book.")
					return
			O.loc = get_turf(src)
			playsound(loc, 'sound/effects/papertear.ogg', 50, 0)
		else
			usr << "<span class='notice'>This bible has no more blank pages.</span>"
	else
		usr << "<span class='notice'>You cannot do this while restrained.</span>"

//wax

/obj/item/weapon/wax
	name = "Wax Preform"
	desc = "Used by the ecclesiarchy in many of their rituals."
	icon = 'icons/obj/priest.dmi'
	icon_state ="wax"
	throw_speed = 2
	throw_range = 1
	w_class = 3.0

//writ

/obj/item/weapon/writ
	name = "Holy Writ"
	desc = "This writ displays prayers to the Emperor."
	icon = 'icons/obj/priest.dmi'
	icon_state ="writ"
	throw_speed = 2
	throw_range = 1
	w_class = 3.0
	var/praying = 0
	var/why

/obj/item/weapon/writ/attackby(obj/item/weapon/P as obj, mob/user as mob)

	if(is_blind(user))
		return

	if(istype(P, /obj/item/weapon/wax))
		var/obj/item/clothing/tie/U = new /obj/item/clothing/tie/medal/gold/sealofpurity((user.loc))
		U.name = why
		qdel(src)
		return

/obj/item/weapon/writ/attack_self(mob/user as mob)
	if(praying) return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.purity >= 0) //I would say this would be an issue with meta, only people can just use the "Me" verb to fake it. So this is ideal.
			H.visible_message("[H] chants the prayers on the [src].")
			praying = 1
			var/chaplain = 0
			if(user.mind && (user.mind.assigned_role == "Preacher"))
				chaplain = 1
			if(chaplain)
				H << "\red The emperor's light shows you a glimpse into the spiritual world!" //Better than making the preacher constantly a seer, I would think.
				H.seer = 1
				spawn(100)
					H.seer = 0
			for(var/mob/living/simple_animal/hostile/retaliate/daemon/D in view(7, H))
				if(D.stat != DEAD)
					D.visible_message("[D] hisses!")
					D.adjustBruteLoss(5)
			spawn(20)
				praying = 0

//blank page

/obj/item/weapon/biblepage
	name = "Blank Page"
	desc = "A blank page from the back of a very holy book."
	icon = 'icons/obj/priest.dmi'
	icon_state ="paper"
	throw_speed = 2
	throw_range = 1
	w_class = 3.0
	var/why = "Seal of purity"

/obj/item/weapon/biblepage/attackby(obj/item/weapon/P as obj, mob/user as mob)

	if(is_blind(user))
		return

	if(istype(P, /obj/item/weapon/pen) || istype(P, /obj/item/toy/crayon))
		var/n_name = docopytext(sanitize(input(user, "What would you like to label this holy writ?", "Seal of purity", null) as text), 1, MAX_NAME_LEN)
		if((in_range(src,user) && user.stat == CONSCIOUS))
			why = "[n_name]"
		if(n_name)
			playsound(src.loc, "sound/effects/chant.ogg", 50, 0, 4)
			user.visible_message("<span class='notice'>[user] begins chanting and writing holy incantations on the strip of paper.</span>", "<span class='notice'>You summon all of your faith and direct it at the slip of paper. This will take a moment and it requires ALL of your attention.</span>")
			if(do_after(user, 260))
				user.say(pick("Through the tempest... and the lightning... Emperor deliver us...", "Emperor... Grant us protection from evil... In thy Name..", "If we must die... We shall welcome death!", "Our faith... conquers all."))
				user.visible_message("<span class='notice'>[user] has finished a writ of purity and protection.</span>", "<span class='notice'>You have completed a sacred writ! It is a masterpiece.</span>")
				sleep(5)
				var/obj/item/weapon/writ/g = new /obj/item/weapon/writ((user.loc))
				g.why = n_name
				qdel(src)
				return
			else
				user.visible_message("<span class='notice'>[user] stops in mid sentence.</span>", "<span class='notice'>Your focus is interupted and you abandon the strip of paper.</span>")
		add_fingerprint(user)


