/obj/item/weapon/grenade/syndieminibomb
	desc = "An explosive device used by the blood pact of khorne."
	name = "blood pact grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "syndicate"
	item_state = "flashbang"
	origin_tech = "materials=3;magnets=4;syndicate=4"

/obj/item/weapon/grenade/syndieminibomb/prime()
	update_mob()
	explosion(src.loc,2,4,5,flame_range = 6, shrapnel_count = 200) //Big shrapnel intensive blast.
	qdel(src)

/obj/item/weapon/grenade/syndieminibomb/suicide_act(var/mob/user)
	. = (BRUTELOSS)
	user.visible_message("<span class='suicide'>[user] primes the [src] and holds it above \his head! It looks like \he's going out with a bang!</span>")
	var/message_say = "FOR THE EMPEROR!"
	if(isork(user))
		message_say = "FER GORK AN' MORK!"
	if(user.mind)
		if(user.mind.special_role)
			var/role = lowertext(user.mind.special_role)
			if(role == "traitor")
				message_say = "FOR SLAANESH!"
			else if(role == "Heretic")
				message_say = "FOR SLAANESH!"
			else if(role == "syndicate")
				message_say = "BLOOD FOR THE BLOOD GOD!"
			else if(role == "changeling")
				message_say = "FOR THE EMPEROR!"
			else if(role == "wizard")
				message_say = "FOR THE ELDAR!"
			else if(role == "cultist")
				message_say = "FOR NURGLE!"
			else if(role == "Genestealer Cult Member")
				message_say = "MY LIFE FOR THE HIVE!"
	if(message_say == "FOR THE EMPEROR!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user && M.mind && (M.mind.special_role == "Heretic" || M.mind.special_role == "syndicate" || M.mind.special_role == "cultist"))
				award(user, "FOR THE EMPEROR!")
	if(message_say == "FER GORK AN' MORK!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(!isork(M))
				award(user, "<b>FER GORK AN' MORK!</b>")
	if(message_say == "BLOOD FOR THE BLOOD GOD!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user)
				award(user, "<span class='khorne'>SKULLS FOR THE SKULL THRONE!</span>")
	user.say(message_say)
	message_admins("[key_name(user, user.client)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) suicided with grenade at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
	src.loc = get_turf(user)
	user.gib()
	src.prime()
	return .

/obj/item/weapon/grenade/stickbomb
	desc = "An ornate tribal totem used by orks to mark fertility and... oh wait. It's a bomb."
	name = "Stikkbomb"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "stickbomb"
	item_state = "stickbomb"
	origin_tech = "materials=3;magnets=4;syndicate=4"

/obj/item/weapon/grenade/stickbomb/prime()
	update_mob()
	explosion(src.loc,1,1,3,flame_range = 2, shrapnel_count = 6)
	qdel(src)

/obj/item/weapon/grenade/stickbomb/suicide_act(var/mob/user)
	. = (BRUTELOSS)
	user.visible_message("<span class='suicide'>[user] primes the [src] and holds it above \his head! It looks like \he's going out with a bang!</span>")
	var/message_say = "FOR THE EMPEROR!"
	if(isork(user))
		message_say = "FER GORK AN' MORK!"
	if(user.mind)
		if(user.mind.special_role)
			var/role = lowertext(user.mind.special_role)
			if(role == "traitor")
				message_say = "FOR SLAANESH!"
			else if(role == "Heretic")
				message_say = "FOR SLAANESH!"
			else if(role == "syndicate")
				message_say = "BLOOD FOR THE BLOOD GOD!"
			else if(role == "changeling")
				message_say = "FOR THE EMPEROR!"
			else if(role == "wizard")
				message_say = "FOR THE ELDAR!"
			else if(role == "cultist")
				message_say = "FOR NURGLE!"
			else if(role == "Genestealer Cult Member")
				message_say = "MY LIFE FOR THE HIVE!"
	if(message_say == "FOR THE EMPEROR!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user && M.mind && (M.mind.special_role == "Heretic" || M.mind.special_role == "syndicate" || M.mind.special_role == "cultist"))
				award(user, "FOR THE EMPEROR!")
			if(M != user && isork(M))
				award(user, "<b>Fighting fire With Fire</b>")
	if(message_say == "FER GORK AN' MORK!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(!isork(M))
				award(user, "<b>FER GORK AN' MORK!</b>")
	if(message_say == "BLOOD FOR THE BLOOD GOD!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user)
				award(user, "<span class='khorne'>SKULLS FOR THE SKULL THRONE!</span>")
	user.say(message_say)
	message_admins("[key_name(user, user.client)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) suicided with grenade at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
	src.loc = get_turf(user)
	user.gib()
	src.prime()
	return .

/obj/item/weapon/grenade/imperial
	desc = "The fuck do you think it is?"
	name = "Imperial Fragmentation Grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "frag"
	item_state = "frag"
	origin_tech = "materials=3;magnets=4;syndicate=4"

/obj/item/weapon/grenade/imperial/prime()
	update_mob()
	explosion(src.loc,0,0,0.5,flame_range = 2, shrapnel_count = 200) //Basically no actual explosion blast, just a huge spray of shrapnel.
	qdel(src)

/obj/item/weapon/grenade/imperial/suicide_act(var/mob/user)
	. = (BRUTELOSS)
	user.visible_message("<span class='suicide'>[user] primes the [src] and holds it above \his head! It looks like \he's going out with a bang!</span>")
	var/message_say = "FOR THE EMPEROR!"
	if(isork(user))
		message_say = "FER GORK AN' MORK!"
	if(user.mind)
		if(user.mind.special_role)
			var/role = lowertext(user.mind.special_role)
			if(role == "traitor")
				message_say = "FOR SLAANESH!"
			else if(role == "Heretic")
				message_say = "FOR SLAANESH!"
			else if(role == "syndicate")
				message_say = "BLOOD FOR THE BLOOD GOD!"
			else if(role == "changeling")
				message_say = "FOR THE EMPEROR!"
			else if(role == "wizard")
				message_say = "FOR THE ELDAR!"
			else if(role == "cultist")
				message_say = "FOR NURGLE!"
			else if(role == "Genestealer Cult Member")
				message_say = "MY LIFE FOR THE HIVE!"
	if(message_say == "FOR THE EMPEROR!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user && M.mind && (M.mind.special_role == "Heretic" || M.mind.special_role == "syndicate" || M.mind.special_role == "cultist"))
				award(user, "FOR THE EMPEROR!")
	if(message_say == "FER GORK AN' MORK!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(!isork(M))
				award(user, "<b>FER GORK AN' MORK!</b>")
	if(message_say == "BLOOD FOR THE BLOOD GOD!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user)
				award(user, "<span class='khorne'>SKULLS FOR THE SKULL THRONE!</span>")
	user.say(message_say)
	message_admins("[key_name(user, user.client)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) suicided with grenade at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
	src.loc = get_turf(user)
	user.gib()
	src.prime()
	return .

/obj/item/weapon/grenade/krak
	desc = "The fuck do you think it is?"
	name = "Imperial Krak Grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "krak"
	item_state = "frag"
	origin_tech = "materials=3;magnets=4;syndicate=4"
	throw_range = 4

/obj/item/weapon/grenade/krak/prime()
	update_mob()
	explosion(src.loc,2,2,2,flame_range = 2)
	spawn(1) explosion(src.loc,1,1,1,flame_range = 0) //Heavy hitter in the epicenter of the blast.
	spawn(2) explosion(src.loc,1,1,1,flame_range = 0)
	qdel(src)

/obj/item/weapon/grenade/krak/suicide_act(var/mob/user)
	. = (BRUTELOSS)
	user.visible_message("<span class='suicide'>[user] primes the [src] and holds it above \his head! It looks like \he's going out with a bang!</span>")
	var/message_say = "FOR THE EMPEROR!"
	if(isork(user))
		message_say = "FER GORK AN' MORK!"
	if(user.mind)
		if(user.mind.special_role)
			var/role = lowertext(user.mind.special_role)
			if(role == "traitor")
				message_say = "FOR SLAANESH!"
			else if(role == "Heretic")
				message_say = "FOR SLAANESH!"
			else if(role == "syndicate")
				message_say = "BLOOD FOR THE BLOOD GOD!"
			else if(role == "changeling")
				message_say = "FOR THE EMPEROR!"
			else if(role == "wizard")
				message_say = "FOR THE ELDAR!"
			else if(role == "cultist")
				message_say = "FOR NURGLE!"
			else if(role == "Genestealer Cult Member")
				message_say = "MY LIFE FOR THE HIVE!"
	if(message_say == "FOR THE EMPEROR!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user && M.mind && (M.mind.special_role == "Heretic" || M.mind.special_role == "syndicate" || M.mind.special_role == "cultist"))
				award(user, "FOR THE EMPEROR!")
	if(message_say == "FER GORK AN' MORK!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(!isork(M))
				award(user, "<b>FER GORK AN' MORK!</b>")
	if(message_say == "BLOOD FOR THE BLOOD GOD!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user)
				award(user, "<span class='khorne'>SKULLS FOR THE SKULL THRONE!</span>")
	user.say(message_say)
	message_admins("[key_name(user, user.client)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) suicided with grenade at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
	src.loc = get_turf(user)
	user.gib()
	src.prime()
	return .

/obj/item/weapon/grenade/plasma
	desc = "The fuck do you think it is?"
	name = "Plasma Grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "plasma"
	item_state = "frag"
	origin_tech = "materials=3;magnets=4;syndicate=4"

/obj/item/weapon/grenade/plasma/prime()
	update_mob()
	var/turf/T = get_turf(src)
	new /obj/effect/plasmacore(T)
	explosion(T, 4, 5, 6, 12, flame_range = 8)
	spawn(2) explode(T,3,3,3,0)
	spawn(4) explode(T,2,2,2,0)
	spawn(6) explode(T,1,1,1,0)
	qdel(src)

/obj/item/weapon/grenade/plasma/suicide_act(var/mob/user)
	. = (BRUTELOSS)
	user.visible_message("<span class='suicide'>[user] primes the [src] and holds it above \his head! It looks like \he's going out with a bang!</span>")
	var/message_say = "FOR THE EMPEROR!"
	if(isork(user))
		message_say = "FER GORK AN' MORK!"
	if(user.mind)
		if(user.mind.special_role)
			var/role = lowertext(user.mind.special_role)
			if(role == "traitor")
				message_say = "FOR SLAANESH!"
			else if(role == "Heretic")
				message_say = "FOR SLAANESH!"
			else if(role == "syndicate")
				message_say = "BLOOD FOR THE BLOOD GOD!"
			else if(role == "changeling")
				message_say = "FOR THE EMPEROR!"
			else if(role == "wizard")
				message_say = "FOR THE ELDAR!"
			else if(role == "cultist")
				message_say = "FOR NURGLE!"
			else if(role == "Genestealer Cult Member")
				message_say = "MY LIFE FOR THE HIVE!"
	if(message_say == "FOR THE EMPEROR!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user && M.mind && (M.mind.special_role == "Heretic" || M.mind.special_role == "syndicate" || M.mind.special_role == "cultist"))
				award(user, "FOR THE EMPEROR!")
	if(message_say == "FER GORK AN' MORK!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(!isork(M))
				award(user, "<b>FER GORK AN' MORK!</b>")
	if(message_say == "BLOOD FOR THE BLOOD GOD!")
		for(var/mob/living/M in range(2, get_turf(user)))
			if(M != user)
				award(user, "<span class='khorne'>Ashes for the Ash God</span>")
	user.say(message_say)
	message_admins("[key_name(user, user.client)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) suicided with grenade at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
	src.loc = get_turf(user)
	user.gib()
	src.prime()
	return .

/obj/item/weapon/grenade/plasma/lesser/prime() //Xenos plasma grenades are more plentiful but not quite as destructive. I don't really want a large quantity of deparment levelling grenades in the hands of anybody on a regular round...
	update_mob()                                 //Still quite powerful but more on the level of a blood pact grenade than a full plasma blast.
	var/turf/T = get_turf(src)
	new /obj/effect/plasmacore(T)
	explosion(T, 2, 3, 4, 5, flame_range = 6)
	spawn(4) explode(T,1,2,3,0)
	qdel(src)

/obj/item/weapon/grenade/vortex
	desc = "A grenade that literally tears a hole into the warp, attracting daemons and sending nearby things into the depths of the warp."
	name = "Vortex Grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "vortex"
	item_state = "frag"
	origin_tech = "materials=3;magnets=4;syndicate=12"

/obj/item/weapon/grenade/vortex/prime()
	update_mob()
	warp_blast(get_turf(src))
	qdel(src)