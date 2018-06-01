// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	return

/atom/proc/attackby(obj/item/I, mob/user)
	return

/atom/movable/attackby(obj/item/I, mob/user)
	if(I && !(I.flags & NOBLUDGEON))
		visible_message("<span class='danger'>[src] has been hit by [user] with [I].</span>")

/mob/living/attackby(obj/item/I, mob/user)
	user.changeNext_move(8)
	I.attack(src, user)

/mob/living/proc/attacked_by(obj/item/I, mob/living/user, def_zone)
	apply_damage(I.force, I.damtype)
	if(I.damtype == "brute")
		if(prob(33) && I.force)
			var/turf/location = src.loc
			if(istype(location, /turf/simulated))
				location.add_blood_floor(src)

	var/showname = "."
	if(user)
		showname = " by [user]!"
	if(!(user in viewers(I, null)))
		showname = "."

	if(I.attack_verb && I.attack_verb.len)
		src.visible_message("<span class='danger'>[src] has been [pick(I.attack_verb)] with [I][showname]</span>",
		"<span class='userdanger'>[src] has been [pick(I.attack_verb)] with [I][showname]</span>")
	else if(I.force)
		src.visible_message("<span class='danger'>[src] has been attacked with [I][showname]</span>",
		"<span class='userdanger'>[src] has been attacked with [I][showname]</span>")
	if(!showname && user)
		if(user.client)
			user << "<span class='userdanger'>You attack [src] with [I].</span>"

// Proximity_flag is 1 if this afterattack was called on something adjacent, in your square, or on your person.
// Click parameters is the params string from byond Click() code, see that documentation.
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	return


obj/item/proc/get_clamped_volume()
	if(force && w_class)
		return Clamp((force + w_class) * 4, 30, 100)	//Add the item's force to its weight class and multiply by 4, then clamp the value between 30 and 100
	else if(!force && w_class)
		return Clamp(w_class * 6, 10, 100)	//Multiply the item's weight class by 6, then clamp the value between 10 and 100

/obj/item/proc/attack(mob/living/M, mob/living/user, def_zone)

	if(!istype(M))	//not sure if this is the right thing...
		return

	if(hitsound)
		playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	else
		playsound(loc, 'sound/weapons/tap.ogg', get_clamped_volume(), 1, -1)

	user.lastattacked = M
	M.lastattacker = user

	add_logs(user, M, "attacked", object=src.name, addition="(INTENT: [uppertext(user.a_intent)]) (DAMTYE: [uppertext(damtype)])")

	M.attacked_by(src, user, def_zone)
	//add_fingerprint(user)	//Their fingerprints should be on it anyway at this point.
	return 1