#define EMPTY 0
#define WIRED 1
#define READY 2

/obj/item/weapon/grenade/chem_grenade
	name = "grenade"
	desc = "A do it yourself grenade casing!"
	icon_state = "chemg"
	item_state = "flashbang"
	w_class = 2
	force = 2
	var/stage = EMPTY
	var/list/beakers = list()
	var/list/allowed_containers = list(/obj/item/weapon/reagent_containers/glass/beaker, /obj/item/weapon/reagent_containers/glass/bottle)
	var/affected_area = 3
	var/obj/item/device/assembly_holder/nadeassembly = null
	var/assemblyattacher
	var/max_beakers = 2 //by default its 2 -Drake

/obj/item/weapon/grenade/chem_grenade/New()
	create_reagents(1000)
	name = "[initial(name)] casing" // By adding the " casing" part here we can use initial(name) to get the final name, making it nice to say "large grenade" when it is a large grenade.


/obj/item/weapon/grenade/chem_grenade/examine()
	set src in usr
	display_timer = (stage == READY && !nadeassembly)	//show/hide the timer based on assembly state
	..()


/obj/item/weapon/grenade/chem_grenade/attack_self(mob/user)
	if(stage == READY &&  !active)
		if(nadeassembly)
			nadeassembly.attack_self(user)
		else if(clown_check(user))
			var/turf/bombturf = get_turf(src)
			var/area/A = get_area(bombturf)
			log_game("[key_name(usr)] has primed a [name] for detonation at [A.name] ([bombturf.x],[bombturf.y],[bombturf.z]).")
			user << "<span class='warning'>You prime the [name]! [det_time / 10] second\s!</span>"
			active = 1
			icon_state = initial(icon_state) + "_active"
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()

			spawn(det_time)
				prime()


/obj/item/weapon/grenade/chem_grenade/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/screwdriver))
		if(stage == WIRED)
			if(beakers.len)
				stage_change(READY)
				user << "<span class='notice'>You lock the [initial(name)] assembly.</span>"
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, -3)
			else
				user << "<span class='notice'>You need to add at least one beaker before locking the [initial(name)] assembly.</span>"
		else if(stage == READY && !nadeassembly)
			det_time = det_time == 50 ? 30 : 50	//toggle between 30 and 50
			user << "<span class='notice'>You modify the time delay. It's set for [det_time / 10] second\s.</span>"
		else if(stage == EMPTY)
			user << "<span class='notice'>You need to add an activation mechanism.</span>"

	else if(stage == WIRED && is_type_in_list(I, allowed_containers))
		if(beakers.len == max_beakers)
			user << "<span class='notice'>[src] can not hold more containers.</span>"
			return
		else
			if(I.reagents.total_volume)
				user << "<span class='notice'>You add [I] to the [initial(name)] assembly.</span>"
				user.drop_item()
				I.loc = src
				beakers += I
			else
				user << "<span class='notice'>[I] is empty.</span>"

	else if(stage == EMPTY && istype(I, /obj/item/device/assembly_holder))
		var/obj/item/device/assembly_holder/A = I
		if(!A.secured)
			return
		if(isigniter(A.a_left) == isigniter(A.a_right))	//Check if either part of the assembly has an igniter, but if both parts are igniters, then fuck it
			return

		user.drop_item()
		nadeassembly = A
		A.master = src
		A.loc = src
		assemblyattacher = user.ckey

		stage_change(WIRED)
		user << "<span class='notice'>You add [A] to the [initial(name)] assembly!</span>"

	else if(stage == EMPTY && istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		C.use(1)
		det_time = 50 // In case the cable_coil was removed and readded.
		stage_change(WIRED)
		user << "<span class='notice'>You rig the [initial(name)] assembly.</span>"

	else if(stage == READY && istype(I, /obj/item/weapon/wirecutters))
		stage_change(WIRED)
		user << "<span class='notice'>You unlock the [initial(name)] assembly.</span>"

	else if(stage == WIRED && istype(I, /obj/item/weapon/wrench))
		if(beakers.len)
			for(var/obj/O in beakers)
				O.loc = get_turf(src)
			beakers = list()
			user << "<span class='notice'>You open the [initial(name)] assembly and remove the payload.</span>"
			return // First use of the wrench remove beakers, then use the wrench to remove the activation mechanism.
		if(nadeassembly)
			nadeassembly.loc = get_turf(src)
			nadeassembly.master = null
			nadeassembly = null
		else // If "nadeassembly = null && stage == WIRED", then it most have been cable_coil that was used.
			new /obj/item/stack/cable_coil(get_turf(src),1)
		stage_change(EMPTY)
		user << "<span class='notice'>You remove the activation mechanism from the [initial(name)] assembly.</span>"


/obj/item/weapon/grenade/chem_grenade/proc/stage_change(var/N)
	stage = N
	if (stage == EMPTY)
		name = "[initial(name)] casing"
		desc = initial(desc)
		icon_state = initial(icon_state)
	else if (stage == WIRED)
		name = "unsecured [initial(name)]"
		desc = "An unsecured [initial(name)] assembly."
		icon_state = "[initial(icon_state)]_ass"
	else if (stage == READY)
		name = initial(name)
		desc = "A custom made [initial(name)]."
		icon_state = "[initial(icon_state)]_locked"


//assembly stuff
/obj/item/weapon/grenade/chem_grenade/receive_signal()
	prime()

/obj/item/weapon/grenade/chem_grenade/HasProximity(atom/movable/AM)
	if(nadeassembly)
		nadeassembly.HasProximity(AM)

/obj/item/weapon/grenade/chem_grenade/Crossed(atom/movable/AM)
	if(nadeassembly)
		nadeassembly.Crossed(AM)

/obj/item/weapon/grenade/chem_grenade/on_found(mob/finder)
	if(nadeassembly)
		nadeassembly.on_found(finder)

/obj/item/weapon/grenade/chem_grenade/hear_talk(mob/living/M, msg)
	if(nadeassembly)
		nadeassembly.hear_talk(M, msg)



/obj/item/weapon/grenade/chem_grenade/prime()
	if(stage != READY)
		return

	var/has_reagents
	for(var/obj/item/I in beakers)
		if(I.reagents.total_volume)
			has_reagents = 1

	if(!has_reagents)
		playsound(loc, 'sound/items/Screwdriver2.ogg', 50, 1)
		return

	if(nadeassembly)
		var/mob/M = get_mob_by_ckey(assemblyattacher)
		var/mob/last = get_mob_by_ckey(nadeassembly.fingerprintslast)
		var/turf/T = get_turf(src)
		var/area/A = get_area(T)
		log_game("grenade primed by an assembly, attached by [M.key]/[M] and last touched by [last.key]/[last] ([nadeassembly.a_left.name] and [nadeassembly.a_right.name]) at [A.name] ([T.x], [T.y], [T.z])")

	playsound(loc, 'sound/effects/bamf.ogg', 50, 1)

	update_mob()

	mix_reagents()

	if(reagents.total_volume)	//The possible reactions didnt use up all reagents.
		var/datum/effect/effect/system/steam_spread/steam = new /datum/effect/effect/system/steam_spread()
		steam.set_up(10, 0, get_turf(src))
		steam.attach(src)
		steam.start()

	for(var/atom/A in view(affected_area, loc))
		if(A == src)
			continue
		reagents.reaction(A, 1, 10)

	invisibility = INVISIBILITY_MAXIMUM		//Why am i doing this?
	spawn(70)		   //To make sure all reagents can work
		qdel(src)	   //correctly before deleting the grenade.

/obj/item/weapon/grenade/chem_grenade/proc/mix_reagents()
	for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
		G.reagents.trans_to(src, G.reagents.total_volume)

/obj/item/weapon/grenade/chem_grenade/mini
	name = "Small Grenade"
	desc = "A small grenade casing."
	icon_state = "mini"
	origin_tech = "combat=1;materials=1"
	affected_area = 1
	max_beakers = 1

//Large chem grenades accept slime cores and use the appropriately. //No they don't. Not yet. Now they do. -Drake
/obj/item/weapon/grenade/chem_grenade/large
	name = "large grenade"
	desc = "An oversized grenade casing."
	icon_state = "large_grenade"
	allowed_containers = list(/obj/item/weapon/reagent_containers/glass,/obj/item/weapon/reagent_containers/food/condiment,
								/obj/item/weapon/reagent_containers/food/drinks, /obj/item/slime_extract)
	origin_tech = "combat=3;materials=3"
	affected_area = 5
	max_beakers = 3

/obj/item/weapon/grenade/chem_grenade/large/mix_reagents()
	var/corenum = 0
	for(var/obj/item/slime_extract/S in beakers)
		corenum += S.Uses //Keeps track of the number of uses, not just the number of cores.
	for(var/obj/item/slime_extract/S in beakers)
		while(S.Uses) //This way we can mix reagents into enhanced cores piece by piece to get our full three uses out of them. -Drake
			for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
				G.reagents.trans_to(S, G.reagents.total_volume/corenum)  //Since it is divided by the number of cores the reagents are evenly distrubuted. -Drake

			//If there is still a core (sometimes it's used up)
			//and there are reagents left, behave normally

			if(S && S.reagents && S.reagents.total_volume)
				S.reagents.trans_to(src,S.reagents.total_volume)
			//return //Lets only call this once all the cores are handled -Drake
	if(corenum)
		return
	..()

	//I tried to just put it in the allowed_containers list but
	//if you do that it must have reagents.  If you're going to
	//make a special case you might as well do it explicitly. -Sayu
/obj/item/weapon/grenade/chem_grenade/large/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/slime_extract) && stage == WIRED)
		user << "<span class='notice'>You add [I] to the [initial(name)] assembly.</span>"
		user.drop_item()
		I.loc = src
		beakers += I
	else
		return ..()

/obj/item/weapon/grenade/chem_grenade/large/huge
	name = "heavy grenade"
	desc = "A massive grenade that will probably deliver a significant payload."
	icon_state = "heavy"
	allowed_containers = list(/obj/item/weapon/reagent_containers/glass,/obj/item/weapon/reagent_containers/food/condiment,
								/obj/item/weapon/reagent_containers/food/drinks,/obj/item/slime_extract,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/pill)
	origin_tech = "combat=5;materials=4"
	affected_area = 8
	max_beakers = 4

/obj/item/weapon/grenade/chem_grenade/metalfoam
	name = "metal foam grenade"
	desc = "Used for emergency sealing of air breaches."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("aluminium", 30)
		B2.reagents.add_reagent("foaming_agent", 10)
		B2.reagents.add_reagent("pacid", 10)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/incendiary
	name = "incendiary grenade"
	desc = "Used for clearing rooms of living things."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("aluminium", 25)
		B2.reagents.add_reagent("plasma", 25)
		B2.reagents.add_reagent("sacid", 25)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/incendiary/prime()
	src.visible_message("\red [src] starts spinning rapidly as it releases a spray of fuel!")
	src.SpinAnimation()
	spawn(10)
		..()

/obj/item/weapon/grenade/chem_grenade/antiweed
	name = "weedkiller grenade"
	desc = "Used for purging large areas of invasive plant species. Contents under pressure. Do not directly inhale contents."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("plantbgone", 25)
		B1.reagents.add_reagent("potassium", 25)
		B2.reagents.add_reagent("phosphorus", 25)
		B2.reagents.add_reagent("sugar", 25)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/cleaner
	name = "cleaner grenade"
	desc = "BLAM!-brand foaming space cleaner. In a special applicator for rapid cleaning of wide areas."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("fluorosurfactant", 40)
		B2.reagents.add_reagent("water", 40)
		B2.reagents.add_reagent("cleaner", 10)

		beakers += B1
		beakers += B2
		icon_state = "grenade"


/obj/item/weapon/grenade/chem_grenade/teargas
	name = "teargas grenade"
	desc = "Used for nonlethal riot control. Contents under pressure. Do not directly inhale contents."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("condensedcapsaicin", 25)
		B1.reagents.add_reagent("potassium", 25)
		B2.reagents.add_reagent("phosphorus", 25)
		B2.reagents.add_reagent("sugar", 25)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/plague
	name = "Blight Grenade"
	desc = "Releases deadly strains to the surrounding area."
	stage = READY

	New()
		..()
		var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
		var/obj/item/weapon/reagent_containers/glass/beaker/B2 = new(src)

		B1.reagents.add_reagent("plague", 25)
		B1.reagents.add_reagent("potassium", 25)
		B2.reagents.add_reagent("phosphorus", 25)
		B2.reagents.add_reagent("sugar", 25)

		beakers += B1
		beakers += B2
		icon_state = "grenade"

/obj/item/weapon/grenade/chem_grenade/large/huge/warp //Mostly proof of concept of new grenade code that actually makes slime core stuff work.
	name = "Warp Grenade"
	desc = "A rather strange grenade that will send anybody caught in the blast somewhere else, then explode at the destination."
	stage = READY

/obj/item/weapon/grenade/chem_grenade/large/huge/warp/New()
	..()
	var/obj/item/slime_extract/bluespace/B1 = new(src)
	var/obj/item/slime_extract/oil/B2 = new(src)
	var/obj/item/slime_extract/oil/B3 = new(src)
	var/obj/item/weapon/reagent_containers/glass/bottle/plasma/B4 = new(src)
	beakers += B1
	beakers += B2
	beakers += B3
	beakers += B4
	icon_state = "heavy_locked"

/obj/item/weapon/grenade/chem_grenade/mini/promethium
	name = "Promethium Charge"
	desc = "A small grenade that can be used to melt walls."
	stage = READY

/obj/item/weapon/grenade/chem_grenade/mini/promethium/New()
	..()
	var/obj/item/weapon/reagent_containers/glass/beaker/B1 = new(src)
	B1.reagents.add_reagent("thermite", 10)
	B1.reagents.add_reagent("burn", 10)
	beakers += B1
	icon_state = "mini_locked"

#undef EMPTY
#undef WIRED
#undef READY
