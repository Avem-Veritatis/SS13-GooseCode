/obj/effect/landmark/valhallan
	name = "Valhallan Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/valhallantank
	name = "Leman Russ Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/valhallanchimera
	name = "Chimera Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/elysian
	name = "Elysian Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/dropsentinel
	name = "Drop Sentinel Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/kreig
	name = "Death Korps Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/kreigsentinel
	name = "Krieg Sentinel Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/kreigchimera
	name = "Chimera Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/cadian
	name = "Cadian Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/cadianchimera
	name = "Chimera Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/cadianweapons
	name = "Cadian Weapons Spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/proc/valhallan_support()
	for(var/obj/effect/landmark/valhallan/V in world)
		var/mob/living/carbon/human/guard = new /mob/living/carbon/human/valhallan(get_turf(V))
		request_ghost("A Valhallan Ice Warrior has been deployed. Do you wish to be considered for this role?", "Valhallan Request", guard)
	for(var/obj/effect/landmark/valhallantank/VT in world)
		new /obj/mecha/combat/lemanruss(get_turf(VT))
	for(var/obj/effect/landmark/valhallanchimera/VC in world)
		new /obj/mecha/combat/chimera/valhallan/loaded(get_turf(VC))

/proc/elysian_support()
	for(var/obj/effect/landmark/elysian/E in world)
		var/mob/living/carbon/human/guard = new /mob/living/carbon/human/elysian(get_turf(E))
		request_ghost("An Elysian Drop Troop has been deployed. Do you wish to be considered for this role?", "Elysian Request", guard)
	for(var/obj/effect/landmark/dropsentinel/D in world)
		new /obj/mecha/combat/sentinel/drop(get_turf(D))

/proc/kreig_support()
	var/officer = 0
	for(var/obj/effect/landmark/kreig/K in world)
		if(!officer)
			officer = 1
			var/mob/living/carbon/human/guard = new /mob/living/carbon/human/kriegofficer(get_turf(K))
			request_ghost("A guard of the Death Korps Krieg has been deployed. Do you wish to be considered for this role?", "Krieg Request", guard)
		else
			var/mob/living/carbon/human/guard = new /mob/living/carbon/human/krieg(get_turf(K))
			request_ghost("A guard of the Death Korps Krieg has been deployed. Do you wish to be considered for this role?", "Krieg Request", guard)
	for(var/obj/effect/landmark/kreigsentinel/S in world)
		new /obj/mecha/combat/sentinel/kreig2(get_turf(S))
	for(var/obj/effect/landmark/kreigchimera/KC in world)
		new /obj/mecha/combat/chimera/kreig/loaded(get_turf(KC))

/proc/cadian_support()
	for(var/obj/effect/landmark/cadian/C in world)
		var/mob/living/carbon/human/guard = new /mob/living/carbon/human/cadian(get_turf(C))
		request_ghost("A Cadian Shock Trooper has been deployed. Do you wish to be considered for this role?", "Cadian Request", guard)
	for(var/obj/effect/landmark/cadianweapons/W in world)
		new /obj/item/weapon/gun/magic/staff/misslelauncher(get_turf(W))
		new /obj/item/weapon/gun/magic/staff/misslelauncher(get_turf(W))
		new /obj/item/weapon/gun/projectile/automatic/bolter(get_turf(W))
		new /obj/item/weapon/gun/projectile/automatic/bolter(get_turf(W))
	for(var/obj/effect/landmark/cadianchimera/CC in world)
		new /obj/mecha/combat/chimera/AC/loaded(get_turf(CC))

/proc/request_ghost(var/text, var/title, var/mob/living/M)
	spawn(0)
		for(var/mob/dead/observer/O in player_list)
			if(O.client)
				question_ghost(O.client, text, title, M)

/proc/question_ghost(var/client/C, var/text, var/title, var/mob/living/M)
	spawn(0)
		if(!C)	return
		var/response = alert(C, text, title, "Yes.", "No.")
		if(!C || M.ckey)
			return
		if(response == "Yes.")
			M.accept_candidate(C)

/mob/living/proc/accept_candidate(var/client/candidate)
	if(!candidate)
		return
	src.mind = candidate.mob.mind
	src.ckey = candidate.ckey