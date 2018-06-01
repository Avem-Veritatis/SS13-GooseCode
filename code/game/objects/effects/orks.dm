/obj/structure/human/ork
	icon = 'icons/mob/ork.dmi'

/*
 * Construction
 */
/obj/structure/human/ork/construction
	name = "crude barricade"
	desc = "Is this a wall or just a garbage pile?."
	icon_state = "B1"
	density = 1
	opacity = 1
	anchored = 1
	var/health = 500

/obj/structure/human/ork/construction/New(location)
	..()
	air_update_turf(1)
	return

/obj/structure/human/ork/construction/Destroy()
	density = 0
	air_update_turf(1)
	..()
	return

/obj/structure/human/ork/construction/Move()
	var/turf/T = loc
	..()
	move_update_air(T)

/obj/structure/human/ork/construction/CanAtmosPass()
	return !density

/obj/structure/human/ork/construction/wall
	name = "resin wall"
	desc = "Purple slime solidified into a wall."
	icon_state = "B2"	//same as resin =O
///obj/structure/human/ork/construction/wall/BlockSuperconductivity()
//	return 1

/obj/structure/human/ork/construction/window
	name = "resin membrane"
	desc = "Purple slime just thin enough to let light pass through."
	icon_state = "B3"
	opacity = 0
	health = 500

/obj/structure/human/ork/construction/piloguns
	name = "Pile of Guns"
	desc = "Click me."
	icon_state = "B4"

/obj/structure/human/ork/construction/piloguns/attack_hand(mob/user)
	if(istype(loc, /mob/living/carbon/human/ork))
		visible_message("\green <B>[src] sifts through the debri.</B>")
		new /obj/structure/closet/ork/piloguns(src.loc)
		qdel(src)

/obj/structure/human/ork/construction/proc/healthcheck()
	if(health <=0)
		qdel(src)


/obj/structure/human/ork/construction/bullet_act(obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	healthcheck()


/obj/structure/human/ork/construction/ex_act(severity)
	switch(severity)
		if(1.0)
			health -= 150
		if(2.0)
			health -= 100
		if(3.0)
			health -= 50
	healthcheck()


/obj/structure/human/ork/construction/blob_act()
	health -= 50
	healthcheck()


/obj/structure/human/ork/construction/hitby(atom/movable/AM)
	..()
	visible_message("<span class='danger'>[src] was hit by [AM].</span>")
	var/tforce = 0
	if(!isobj(AM))
		tforce = 10
	else
		var/obj/O = AM
		tforce = O.throwforce
	playsound(loc, 'sound/effects/clang.ogg', 100, 1)
	health -= tforce
	healthcheck()


/obj/structure/human/ork/construction/attack_hand(mob/user)
	if(HULK in user.mutations)
		user.visible_message("<span class='danger'>[user] destroys [src]!</span>")
		health = 0
		healthcheck()


/obj/structure/human/ork/construction/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/human/ork/construction/attackby(obj/item/I, mob/user)
	health -= I.force
	playsound(loc, 'sound/effects/clang.ogg', 100, 1)
	healthcheck()
	..()


/obj/structure/human/ork/construction/CanPass(atom/movable/mover, turf/orktarget, height=0, air_group=0)
	if(air_group) return 0
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return !opacity
	return !density

/*
 * Bannah
 */

#define NODERANGE 3

/obj/structure/human/ork/waagh
	gender = PLURAL
	name = "WAAAAAGH"
	desc = "WAAAAAAAAAAAAAAAAGH!!!!."
	icon_state = "null"
	anchored = 1
	density = 0
	var/health = 15
	var/obj/structure/human/ork/waagh/node/linked_node = null


/obj/structure/human/ork/waagh/New(pos, node)										//The bannah! Raise the bannah!
	..()
	linked_node = node
	if(istype(loc, /turf/space))
		qdel(src)
		return
	if(icon_state == "null")
		icon_state = pick("null", "null", "null")

	spawn(rand(150, 200))
		if(src)
			Life()


/obj/structure/human/ork/waagh/proc/Life()
	set background = BACKGROUND_ENABLED
	var/turf/U = get_turf(src)

	if(istype(U, /turf/space))
		qdel(src)
		return

	direction_loop:
		for(var/dirn in cardinal)
			var/turf/T = get_step(src, dirn)

			if (!istype(T) || T.density || locate(/obj/structure/human/ork/waagh) in T || istype(T, /turf/space))
				continue

			if(!linked_node || get_dist(linked_node, src) > linked_node.node_range)
				return

			for(var/obj/O in T)
				if(O.density)
					continue direction_loop

			new /obj/structure/human/ork/waagh(T, linked_node)


/obj/structure/human/ork/waagh/ex_act(severity)
	qdel(src)


/obj/structure/human/ork/waagh/attackby(obj/item/I, mob/user)
	if(I.attack_verb.len)
		visible_message("<span class='danger'>[src] has been [pick(I.attack_verb)] with [I] by [user].</span>")
	else
		visible_message("<span class='danger'>[src] has been attacked with [I] by [user]!</span>")

	var/damage = I.force / 4.0
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I
		if(WT.remove_fuel(0, user))
			damage = 15
			playsound(loc, 'sound/items/Welder.ogg', 100, 1)

	health -= damage
	healthcheck()


/obj/structure/human/ork/waagh/proc/healthcheck()
	if(health <= 0)
		qdel(src)


/obj/structure/human/ork/waagh/temperature_expose(datum/gas_mixture2/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		health -= 5
		healthcheck()


//Weed nodes
/obj/structure/human/ork/waagh/node
	name = "WAAAAAGH BANNA"
	desc = "WAAAAAAGH!!."
	icon_state = "orkbanner"
	luminosity = NODERANGE
	var/node_range = NODERANGE


/obj/structure/human/ork/waagh/node/New()
	..(loc, src)

#undef NODERANGE


/*
 * Bush
 */

//for the status var
#define BURST 0
#define BURSTING 1
#define GROWING 2
#define GROWN 3
#define MIN_GROWTH_TIME 1800	//time it takes to grow a hugger
#define MAX_GROWTH_TIME 3000

/obj/structure/human/ork/bush																				//bush
	name = "A bush"
	desc = "A large bush."
	icon_state = "bush"
	density = 0
	anchored = 1
	var/health = 100
	var/status = GROWING	//can be GROWING, GROWN or BURST; all mutually exclusive
	var/obj/structure/human/ork/bush

/obj/structure/human/ork/bush/New()																		//new bush, enters stage 2
//	new /mob/living/carbon/ork/gretchin(src)
	bush = loc
	..()
	spawn(rand(MIN_GROWTH_TIME, MAX_GROWTH_TIME))
		Grow()

/obj/structure/human/ork/bush/proc/Grow()																	//stage 2, calls spawn gretchin
	icon_state = "bush2"
	status = GROWN
	sleep 1000
	spawngretchin()

/obj/structure/human/ork/bush/proc/spawngretchin()
	new /mob/living/carbon/human/ork/gretchin/gret(src.loc)
	qdel (src)


/obj/structure/human/ork/starterbush																		//For getting players started
	name = "A bush"
	desc = "A large bush."
	icon_state = "bush"
	density = 0
	anchored = 1
	var/health = 100
	var/status = GROWING	//can be GROWING, GROWN or BURST; all mutually exclusive
	var/obj/structure/human/ork/starterbush

/obj/structure/human/ork/starterbush/New()																		//new bush, enters stage 2
	starterbush = loc
	..()
	spawn(rand(MIN_GROWTH_TIME, MAX_GROWTH_TIME))
		Grow()

/obj/structure/human/ork/starterbush/proc/Grow()																	//stage 2, calls spawn gretchin
	icon_state = "bush2"
	status = GROWN
	sleep 13000																								//no idea how long this is
	message_admins("Halfway Mark for Gretchin Spawn.")
	sleep 13000																								//no idea how long this is
	spawngretchin()																							//call it

/obj/structure/human/ork/starterbush/proc/spawngretchin()
	new /mob/living/carbon/human/ork/gretchin(src.loc)
	qdel (src)

#undef BURST
#undef BURSTING
#undef GROWING
#undef GROWN
#undef MIN_GROWTH_TIME
#undef MAX_GROWTH_TIME

///////////////////////////////////////////////////////////////////////////
