/obj/structure/tree
	name = "Tree"
	desc = "Maybe that is a tree"
	icon = 'icons/obj/tree.dmi'
	density = 1
	layer = 3.2//Just above doors
	//pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = 1.0
	flags = ON_BORDER
	var/health = 14.0
	var/ini_dir = null
	var/state = 0
	var/reinf = 0
//	var/silicate = 0 // number of units of silicate
//	var/icon/silicateIcon = null // the silicated icon


/obj/structure/tree/bullet_act(var/obj/item/projectile/Proj)
	if((Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		health -= Proj.damage
	..()
	if(health <= 0)
		new /obj/item/stack/sheet/mineral/wood(loc)
		new /obj/item/stack/sheet/mineral/wood(loc)
		qdel(src)
	return


/obj/structure/tree/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			new /obj/item/stack/sheet/mineral/wood(loc)
			if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
			qdel(src)
			return
		if(3.0)
			if(prob(50))
				new /obj/item/stack/sheet/mineral/wood(loc)
				if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
				qdel(src)
				return


/obj/structure/tree/blob_act()
	new /obj/item/stack/sheet/mineral/wood(loc)
	if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
	qdel(src)


/obj/structure/tree/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return 1
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return 0	//full tile window, you can't move into it!
	if(get_dir(loc, target) == dir)
		return !density
	else
		return 1


/obj/structure/tree/CheckExit(atom/movable/O as mob|obj, target as turf)
	if(istype(O) && O.checkpass(PASSGLASS))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1


/obj/structure/tree/hitby(AM as mob|obj)
	..()
	visible_message("<span class='danger'>[src] was hit by [AM].</span>")
	var/tforce = 0
	if(ismob(AM))
		tforce = 40
	else if(isobj(AM))
		var/obj/item/I = AM
		tforce = I.throwforce
	if(reinf) tforce *= 0.25
	playsound(loc, 'sound/effects/woodchop.ogg', 100, 1)
	health = max(0, health - tforce)
	if(health <= 7 && !reinf)
		anchored = 0
		update_nearby_icons()
		step(src, get_dir(AM, src))
	if(health <= 0)
		new /obj/item/stack/sheet/mineral/wood(loc)
		if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
		qdel(src)

/obj/structure/tree/attack_tk(mob/user as mob)
	user.visible_message("<span class='notice'>Something knocks on the[src].</span>")
	add_fingerprint(user)
	playsound(loc, 'sound/effects/woodchop.ogg', 50, 1)

/obj/structure/tree/attack_hand(mob/user as mob)
	if(!can_be_reached(user))
		return
	if(HULK in user.mutations)
		user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!"))
		user.visible_message("<span class='danger'>[user] smashes through [src]!</span>")
		var/obj/item/stack/sheet/mineral/wood/S = new (loc)
		S.add_fingerprint(user)
		if(reinf)
			var/obj/item/stack/sheet/mineral/wood/R = new (loc)
			R.add_fingerprint(user)
		qdel(src)
	else
		user.changeNext_move(8)
		user.visible_message("<span class='notice'>[user] knocks on the [src].</span>")
		add_fingerprint(user)
		playsound(loc, 'sound/effects/woodchop.ogg', 50, 1)


/obj/structure/tree/attack_paw(mob/user as mob)
	return attack_hand(user)


/obj/structure/tree/proc/attack_generic(mob/user as mob, damage = 0)	//used by attack_alien, attack_animal, and attack_slime
	if(!can_be_reached(user))
		return
	user.changeNext_move(8)
	health -= damage
	if(health <= 0)
		user.visible_message("<span class='danger'>[user] smashes through the [src]!</span>")
		new /obj/item/stack/sheet/mineral/wood(loc)
		if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
		qdel(src)
	else	//for nicer text~
		user.visible_message("<span class='danger'>[user] smashes into [src]!</span>")
		playsound(loc, 'sound/effects/woodchop.ogg', 100, 1)


/obj/structure/tree/attack_alien(mob/user as mob)
	if(islarva(user)) return
	attack_generic(user, 15)

/obj/structure/tree/attack_animal(mob/user as mob)
	if(!isanimal(user)) return
	var/mob/living/simple_animal/M = user
	if(M.melee_damage_upper <= 0) return
	attack_generic(M, M.melee_damage_upper)


/obj/structure/tree/attack_slime(mob/living/carbon/slime/user as mob)
	if(!user.is_adult) return
	attack_generic(user, rand(10, 15))

/obj/structure/tree/proc/can_be_reached(mob/user)
	if(!is_fulltile())
		if(get_dir(user,src) & dir)
			for(var/obj/O in loc)
				if(!O.CanPass(user, user.loc, 1, 0))
					return 0
	return 1

/obj/structure/tree/proc/hit(var/damage, var/sound_effect = 1)
	if(reinf) damage *= 0.5
	health = max(0, health - damage)
	if(sound_effect)
		playsound(loc, 'sound/effects/woodchop.ogg', 75, 1)
	if(health <= 0)
		if(dir == SOUTHWEST)
			var/index = null
			index = 0
			while(index < 2)
				new /obj/item/stack/sheet/mineral/wood(loc)
				if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
				index++
		else
			new /obj/item/stack/sheet/mineral/wood(loc)
			if(reinf) new /obj/item/stack/sheet/mineral/wood(loc)
		qdel(src)
		return


/obj/structure/tree/New(Loc,re=0)
	..()

	if(re)	reinf = re

	ini_dir = dir
	if(reinf)
		icon_state = "tree_1"
		desc = "Yep! That is a tree alright."
		name = "A tree"
		state = 2*anchored
		health = 40
		if(opacity)
			icon_state = "tree_1"
	else
		icon_state = "tree_2"

	air_update_turf(1)
	update_nearby_icons()

	return


/obj/structure/tree/Destroy()
	density = 0
	air_update_turf(1)
	playsound(src, 'sound/effects/treefall.ogg', 70, 1)
	update_nearby_icons()
	..()


/obj/structure/tree/CanAtmosPass(turf/T)
	if(get_dir(loc, T) == dir)
		return !density
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return !density
	return 1

//checks if this window is full-tile one
/obj/structure/tree/proc/is_fulltile()
	if(dir in list(5,6,9,10))
		return 1
	return 0

//This proc is used to update the icons of nearby windows.
/obj/structure/tree/proc/update_nearby_icons()
	update_icon()
	for(var/direction in cardinal)
		for(var/obj/structure/tree/W in get_step(src,direction) )
			W.update_icon()

//merges adjacent full-tile windows into one (blatant ripoff from game/smoothwall.dm)
/obj/structure/tree/update_icon()
	//A little cludge here, since I don't know how it will work with slim windows. Most likely VERY wrong.
	//this way it will only update full-tile ones
	//This spawn is here so windows get properly updated when one gets deleted.
	spawn(2)
		if(!src) return
		if(!is_fulltile())
			return
		var/junction = 0 //will be used to determine from which side the window is connected to other windows
		if(anchored)
			for(var/obj/structure/tree/W in orange(src,1))
				if(W.anchored && W.density	&& W.is_fulltile()) //Only counts anchored, not-destroyed fill-tile windows.
					if(abs(x-W.x)-abs(y-W.y) ) 		//doesn't count windows, placed diagonally to src
						junction |= get_dir(src,W)
		if(opacity)
			icon_state = "tree_![junction]"
		else
			if(reinf)
				icon_state = "tree_2[junction]"
			else
				icon_state = "tree_3[junction]"

		return

/obj/structure/tree/temperature_expose(datum/gas_mixture2/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > T0C + 800)
		hit(round(exposed_volume / 100), 0)
	..()



/obj/structure/tree/basic
	icon_state = "tree_1"

/obj/structure/tree/reinforced //lol what
	name = "Tree"
	icon_state = "tree_2"
	reinf = 1

/obj/structure/tree/reinforced/tinted
	name = "Tree"
	icon_state = "tree_3"
	opacity = 1

/obj/structure/tree/reinforced/tinted/frosted
	name = "Tree"
	icon_state = "tree_4"
