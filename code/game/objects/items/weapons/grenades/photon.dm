/obj/item/weapon/grenade/photon
	name = "photon grenade"
	desc = "A Tau grenade used by the fire caste to effectively incapacitate opponents."
	icon_state = "photon"
	item_state = "flashbang"
	origin_tech = "materials=2;combat=1"
	var/banglet = 0

/obj/item/weapon/grenade/photon/prime()
	update_mob()
	var/flashbang_turf = get_turf(src)
	for(var/obj/structure/closet/L in view(7, flashbang_turf))
		for(var/mob/living/M in L)
			bang(get_turf(M), M)

	for(var/mob/living/M in view(7, flashbang_turf))
		bang(get_turf(M), M)

	for(var/obj/effect/blob/B in view(8,flashbang_turf))     		//Blob damage here
		var/damage = round(60/(get_dist(B,get_turf(src))+1))
		B.health -= damage
		B.update_icon()

	explosion(src.loc, 0, 0, 1, flame_range = 1)

	qdel(src)

/obj/item/weapon/grenade/photon/proc/bang(var/turf/T , var/mob/living/M)
	var/eye_safety = 0
	var/distance = max(1, get_dist(src, T))
	var/takes_eye_damage = 0
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		eye_safety = C.eyecheck()
		if(ishuman(C))
			takes_eye_damage = 1
		if(ismonkey(C))
			takes_eye_damage = 1
	M << "<span class='warning'>BANG</span>"
	playsound(src.loc, 'sound/effects/bang.ogg', 25, 1)
	M.drop_item()
	M.Dizzy(20)
	M.confused += 20
	shake_camera(M, 100, 1)
	M.Stun(max(20/distance, 4))
	M.Weaken(max(20/distance, 4))
	if(eye_safety < 2)
		flick("e_flash", M.flash)
		M.eye_stat += rand(1, 3)
		if (M.eye_stat >= 20 && takes_eye_damage)
			M << "<span class='warning'>Your eyes start to burn badly!</span>"
			M.disabilities |= NEARSIGHTED
			if (prob(M.eye_stat - 20 + 1))
				M << "<span class='warning'>You can't see anything!</span>"
				M.sdisabilities |= BLIND
	M.ear_damage += rand(5, 10)
	M.ear_deaf = max(M.ear_deaf,15)
	if (M.ear_damage >= 15)
		M << "<span class='warning'>Your ears start to ring badly!</span>"
		if (prob(M.ear_damage - 10 + 5))
			M << "<span class='warning'>You can't hear anything!</span>"
			M.sdisabilities |= DEAF
		else
			if (M.ear_damage >= 5)
				M << "<span class='warning'>Your ears start to ring!</span>"