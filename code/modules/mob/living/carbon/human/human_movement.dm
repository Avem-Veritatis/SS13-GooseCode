/mob/living/carbon/human/movement_delay()
	if(!has_gravity(src))
		return -1	//It's hard to be slowed down in space by... anything
	else if(locate(/obj/item/weapon/twohanded/required/hbolter) in src) //Without stims or somebody pulling you it is hard to move around with one of these.
		return reagents_speedmod+14
	else if(istype(src.get_active_hand(), /obj/item/weapon/twohanded/required/bolterc) || istype(src.get_inactive_hand(), /obj/item/weapon/twohanded/required/bolterc)) //Without stims or somebody pulling you it is hard to move around with one of these.
		return reagents_speedmod+14
	else if(istype(src.get_active_hand(), /obj/item/weapon/twohanded/required/laserc) || istype(src.get_inactive_hand(), /obj/item/weapon/twohanded/required/laserc)) //Without stims or somebody pulling you it is hard to move around with one of these.
		return reagents_speedmod+14
	else if(locate(/obj/item/weapon/gun/projectile/automatic/exitus) in src) //Without stims or somebody pulling you it is hard to move around with one of these.
		var/obj/item/weapon/gun/projectile/automatic/exitus/E = locate(/obj/item/weapon/gun/projectile/automatic/exitus) in src
		if(E.zoom == 1)
			return reagents_speedmod+16
	else if(status_flags & GOTTAGOFAST)
		return reagents_speedmod-1

	. = 0
	var/health_deficiency = (100 - health + staminaloss)
	if(health_deficiency >= 40)
		. += (health_deficiency / 25)

	var/hungry = (500 - nutrition) / 5	//So overeat would be 100 and default level would be 80
	if(hungry >= 70)
		. += hungry / 50

	if(wear_suit)
		. += wear_suit.slowdown
	if(shoes)
		. += shoes.slowdown
	if(back)
		. += back.slowdown

	if(!istype(src, /mob/living/carbon/human/ork) && !istype(src, /mob/living/carbon/human/sob) && !istype(src, /mob/living/carbon/human/whitelisted))
		if(istype(src.get_active_hand(), /obj/item/weapon/twohanded/required/rotshield) || istype(src.get_inactive_hand(), /obj/item/weapon/twohanded/required/rotshield))
			. += 3
		if(istype(src.get_active_hand(), /obj/item/weapon/gun/energy/longlas) || istype(src.get_inactive_hand(), /obj/item/weapon/gun/energy/longlas)) //This one won't slow you down if it's on your back.
			. += 3
		if(istype(src.get_active_hand(), /obj/item/weapon/gun/projectile/automatic/bolter) || istype(src.get_inactive_hand(), /obj/item/weapon/gun/projectile/automatic/bolter))
			. += 3
		if(locate(/obj/item/weapon/gun/projectile/sbolter) in src)
			. += 5
		if(istype(src.get_active_hand(), /obj/item/weapon/gun/projectile/flamer) || istype(src.get_inactive_hand(), /obj/item/weapon/gun/projectile/flamer))
			. += 1
		if(locate(/obj/item/weapon/gun/projectile/meltagun) in src)
			. += 1
		if(locate(/obj/item/weapon/twohanded/required/hflamer) in src)
			. += 2
		if(locate(/obj/item/weapon/twohanded/required/multimelta) in src)
			. += 2

	if(FAT in mutations)
		. += 1.5
	if(bodytemperature < 283.222)
		. += (283.222 - bodytemperature) / 10 * 1.75

	if(reagents_speedmod)
		. += reagents_speedmod

	if(inertial_speed == null)
		inertial_speed = 0
	inertial_speed += 1 //Track if they have recently moved and at what speed.

	. += ..()
	. += config.human_delay

/mob/living/carbon/human/Process_Spacemove(var/check_drift = 0)
	//Can we act
	if(!canmove)	return 0

	//Do we have a working jetpack
	if(istype(back, /obj/item/weapon/tank/jetpack))
		var/obj/item/weapon/tank/jetpack/J = back
		if(((!check_drift) || (check_drift && J.stabilization_on)) && (!lying) && (J.allow_thrust(0.01, src)))
			inertia_dir = 0
			return 1
	//Do we have working magboots
	if(istype(shoes, /obj/item/clothing/shoes/magboots))
		var/obj/item/clothing/shoes/magboots/B = shoes
		if((B.flags & NOSLIP) && (!has_gravity(src.loc)))
			if(istype(src.loc,/turf/simulated/floor))
				return 1
			else
				for(var/obj/effect/fake_floor/F in range(1, get_turf(src))) //Fake floors still let us move like real ones do.
					return 1
	//If no working jetpack or magboots then use the other checks
	if(..())	return 1
	return 0


/mob/living/carbon/human/Process_Spaceslipping(var/prob_slip = 5)
	//If knocked out we might just hit it and stop.  This makes it possible to get dead bodies and such.
	if(stat)
		prob_slip = 0 // Changing this to zero to make it line up with the comment, and also, make more sense.

	//Do we have magboots or such on if so no slip
	if(istype(shoes, /obj/item/clothing/shoes/magboots) && (shoes.flags & NOSLIP))
		prob_slip = 0

	//Check hands and mod slip
	if(!l_hand)	prob_slip -= 2
	else if(l_hand.w_class <= 2)	prob_slip -= 1
	if (!r_hand)	prob_slip -= 2
	else if(r_hand.w_class <= 2)	prob_slip -= 1

	prob_slip = round(prob_slip)
	return(prob_slip)


/mob/living/carbon/human/slip(var/s_amount, var/w_amount, var/obj/O, var/lube)
	if(isobj(shoes) && (shoes.flags&NOSLIP) && !(lube&GALOSHES_DONT_HELP))
		return 0
	.=..()

/mob/living/carbon/human/CanPass(atom/movable/mover, turf/target, height=0, air_group=0) //A little bit of more robust fighting system...
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(!H.bumpattack_cooldown)
			var/obj/item/I = H.get_active_hand()
			if(istype(I, /obj/item/weapon/fastknife))
				H.bumpattack_cooldown = 1
				spawn(10) H.bumpattack_cooldown = 0
				I.attack(src, H)
				return 1
			if(istype(I, /obj/item/weapon/powersword)) //Requires agressive stance and has a cooldown for these weapons now.
				var/obj/item/weapon/powersword/P = I
				if(P.stance == "agressive")
					H.bumpattack_cooldown = 1
					spawn(10) H.bumpattack_cooldown = 0
					P.attack(src, H)
					return 0
			if(istype(I, /obj/item/weapon/chainsword))
				var/obj/item/weapon/powersword/C = I
				if(C.stance == "agressive")
					H.bumpattack_cooldown = 1
					spawn(10) H.bumpattack_cooldown = 0
					C.attack(src, H)
					return 0
	if(istype(mover, /obj/effect/harl))
		var/obj/effect/harl/dummy = mover
		dummy.master.attack(src, dummy.user)
		return 1
	return ..()