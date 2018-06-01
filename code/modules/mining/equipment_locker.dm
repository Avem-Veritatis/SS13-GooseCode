/**********************Ore Redemption Unit**************************/
//Turns all the various mining machines into a single unit to speed up mining and establish a point system

/obj/machinery/mineral/ore_redemption
	name = "ore redemption machine"
	desc = "A machine that accepts ore and instantly transforms it into workable material sheets, but cannot produce alloys such as Plasteel. Points for ore are generated based on type and can be redeemed at a mining equipment vendor."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "ore_redemption"
	density = 1
	anchored = 1.0
	input_dir = WEST
	output_dir = SOUTH
	req_access = list(access_mineral_storeroom)
	var/stk_types = list()
	var/stk_amt   = list()
	var/stack_list[0] //Key: Type.  Value: Instance of type.
	var/obj/item/weapon/card/id/inserted_id
	var/points = 0
	var/list/ore_values = list(("sand" = 1), ("iron" = 1), ("gold" = 20), ("silver" = 20), ("uranium" = 20), ("bananium" = 30), ("diamond" = 40), ("plasma" = 40))

/obj/machinery/mineral/ore_redemption/proc/process_sheet(obj/item/weapon/ore/O)
	var/obj/item/stack/sheet/processed_sheet = SmeltMineral(O)
	if(processed_sheet)
		if(!(processed_sheet in stack_list)) //It's the first of this sheet added
			var/obj/item/stack/sheet/s = new processed_sheet(src,0)
			s.amount = 0
			stack_list[processed_sheet] = s
		var/obj/item/stack/sheet/storage = stack_list[processed_sheet]
		storage.amount += 1 //Stack the sheets
		O.loc = null //Let the old sheet garbage collect

/obj/machinery/mineral/ore_redemption/process()
	var/turf/T = get_turf(get_step(src, input_dir))
	var/i
	if(T)
		if(locate(/obj/item/weapon/ore) in T)
			for (i = 0; i < 10; i++)
				var/obj/item/weapon/ore/O = locate() in T
				if(O)
					process_sheet(O)
				else
					break
		else
			var/obj/structure/ore_box/B = locate() in T
			if(B)
				for (i = 0; i < 10; i++)
					var/obj/item/weapon/ore/O = locate() in B.contents
					if(O)
						process_sheet(O)
					else
						break

/obj/machinery/mineral/ore_redemption/attackby(var/obj/item/weapon/W, var/mob/user)
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/I = usr.get_active_hand()
		if(istype(I) && !istype(inserted_id))
			usr.drop_item()
			I.loc = src
			inserted_id = I
			interact(user)

/obj/machinery/mineral/ore_redemption/proc/SmeltMineral(var/obj/item/weapon/ore/O)
	if(O.refined_type)
		var/obj/item/stack/sheet/M = O.refined_type
		points += O.points
		return M
	qdel(O)//No refined type? Purge it.
	return

/obj/machinery/mineral/ore_redemption/attack_hand(user as mob)
	if(..())
		return
	interact(user)

/obj/machinery/mineral/ore_redemption/interact(mob/user)
	var/obj/item/stack/sheet/s
	var/dat

	dat += text("<b>Ore Redemption Machine</b><br><br>")
	dat += text("This machine only accepts ore. Gibtonite and Slag are not accepted.<br><br>")
	dat += text("Current unclaimed points: [points]<br>")

	if(istype(inserted_id))
		dat += text("You have [inserted_id.mining_points] mining points collected. <A href='?src=\ref[src];choice=eject'>Eject ID.</A><br>")
		dat += text("<A href='?src=\ref[src];choice=claim'>Claim points.</A><br>")
	else
		dat += text("No ID inserted.  <A href='?src=\ref[src];choice=insert'>Insert ID.</A><br>")

	for(var/O in stack_list)
		s = stack_list[O]
		if(s.amount > 0)
			dat += text("[capitalize(s.name)]: [s.amount] <A href='?src=\ref[src];release=[s.type]'>Release</A><br>")

	dat += text("<HR><b>Mineral Value List:</b><BR>[get_ore_values()]")

	user << browse("[dat]", "window=console_stacking_machine")

	return

/obj/machinery/mineral/ore_redemption/proc/get_ore_values()
	var/dat = "<table border='0' width='300'>"
	for(var/ore in ore_values)
		var/value = ore_values[ore]
		dat += "<tr><td>[capitalize(ore)]</td><td>[value]</td></tr>"
	dat += "</table>"
	return dat

/obj/machinery/mineral/ore_redemption/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"])
		if(istype(inserted_id))
			if(href_list["choice"] == "eject")
				inserted_id.loc = loc
				inserted_id.verb_pickup()
				inserted_id = null
			if(href_list["choice"] == "claim")
				if(access_mining_station in inserted_id.access)
					inserted_id.mining_points += points
					points = 0
				else
					usr << "<span class='warning'>Required access not found.</span>"
		else if(href_list["choice"] == "insert")
			var/obj/item/weapon/card/id/I = usr.get_active_hand()
			if(istype(I))
				usr.drop_item()
				I.loc = src
				inserted_id = I
			else usr << "<span class='warning'>No valid ID.</span>"
	if(href_list["release"] && istype(inserted_id))
		if(check_access(inserted_id))
			if(!(text2path(href_list["release"]) in stack_list)) return
			var/obj/item/stack/sheet/inp = stack_list[text2path(href_list["release"])]
			var/obj/item/stack/sheet/out = new inp.type()
			var/desired = input("How much?", "How much to eject?", 1) as num
			out.amount = min(desired,50,inp.amount)
			if(out.amount >= 1)
				inp.amount -= out.amount
				unload_mineral(out)
		else
			usr << "<span class='warning'>Required access not found.</span>"
	updateUsrDialog()
	return

/obj/machinery/mineral/ore_redemption/ex_act()
	return //So some chucklefuck doesn't ruin miners reward with an explosion

/**********************Mining Equipment Vendor**************************/

/obj/machinery/mineral/equipment_vendor
	name = "mining equipment vendor"
	desc = "An equipment vendor for miners, points collected at an ore redemption machine can be spent here."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "mining"
	density = 1
	anchored = 1.0
	var/obj/item/weapon/card/id/inserted_id
	var/list/prize_list = list(
		new /datum/data/mining_equipment("Chili",               /obj/item/weapon/reagent_containers/food/snacks/hotchili,          100),
		new /datum/data/mining_equipment("Cigar",               /obj/item/clothing/mask/cigarette/cigar/havana,                    100),
		new /datum/data/mining_equipment("Whiskey",             /obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,    150),
		new /datum/data/mining_equipment("Soap",                /obj/item/weapon/soap/nanotrasen, 						           150),
		new /datum/data/mining_equipment("Gar Mesons",			/obj/item/clothing/glasses/meson/gar, 							   200),
		new /datum/data/mining_equipment("Alien Toy",           /obj/item/clothing/mask/facehugger/toy, 		                   500),
		new /datum/data/mining_equipment("Laser Pointer",       /obj/item/device/laser_pointer, 				                   500),
		new /datum/data/mining_equipment("Stimulant Pills",     /obj/item/weapon/storage/pill_bottle/stimulant, 				   350),
		new /datum/data/mining_equipment("Sonic Jackhammer",    /obj/item/weapon/pickaxe/jackhammer,                               500),
		new /datum/data/mining_equipment("Mining Drone",        /mob/living/simple_animal/hostile/mining_drone/,                   500),
		new /datum/data/mining_equipment("Resonator",           /obj/item/weapon/resonator,                                        750),
		new /datum/data/mining_equipment("Kinetic Accelerator", /obj/item/weapon/gun/energy/kinetic_accelerator,                  1000),
		new /datum/data/mining_equipment("Brass Knuckles", 		/obj/item/weapon/brassknuckles,        					          2000),
		new /datum/data/mining_equipment("Jetpack",             /obj/item/weapon/tank/jetpack/carbondioxide/mining,               2000),
		new /datum/data/mining_equipment("Jaunter",             /obj/item/device/wormhole_jaunter,                                 200),
		new /datum/data/mining_equipment("Lazarus Injector",    /obj/item/weapon/lazarus_injector,                                1000),
		new /datum/data/mining_equipment("Point Card",    		/obj/item/weapon/card/mining_point_card,               			   500),
		new /datum/data/mining_equipment("Space Cash",    		/obj/item/weapon/spacecash/c1000,                    			  5000),
		)

/datum/data/mining_equipment/
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0

/datum/data/mining_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost

/obj/machinery/mineral/equipment_vendor/attack_hand(user as mob)
	if(..())
		return
	interact(user)

/obj/machinery/mineral/equipment_vendor/interact(mob/user)
	var/dat
	dat += text("<b>Mining Equipment vendor</b><br><br>")

	if(istype(inserted_id))
		dat += "You have [inserted_id.mining_points] mining points collected. <A href='?src=\ref[src];choice=eject'>Eject ID.</A><br>"
	else
		dat += "No ID inserted.  <A href='?src=\ref[src];choice=insert'>Insert ID.</A><br>"

	dat += "<HR><b>Equipment point cost list:</b><BR><table border='0' width='200'>"
	for(var/datum/data/mining_equipment/prize in prize_list)
		dat += "<tr><td>[prize.equipment_name]</td><td>[prize.cost]</td><td><A href='?src=\ref[src];purchase=\ref[prize]'>Purchase</A></td></tr>"
	dat += "</table>"

	user << browse("[dat]", "window=mining_equipment_vendor")
	return

/obj/machinery/mineral/equipment_vendor/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"])
		if(istype(inserted_id))
			if(href_list["choice"] == "eject")
				inserted_id.loc = loc
				inserted_id.verb_pickup()
				inserted_id = null
		else if(href_list["choice"] == "insert")
			var/obj/item/weapon/card/id/I = usr.get_active_hand()
			if(istype(I))
				usr.drop_item()
				I.loc = src
				inserted_id = I
			else usr << "\red No valid ID."
	if(href_list["purchase"])
		if(istype(inserted_id))
			var/datum/data/mining_equipment/prize = locate(href_list["purchase"])
			if (!prize || !(prize in prize_list))
				return
			if(prize.cost > inserted_id.mining_points)
			else
				inserted_id.mining_points -= prize.cost
				new prize.equipment_path(src.loc)
	updateUsrDialog()
	return

/obj/machinery/mineral/equipment_vendor/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/mining_voucher))
		RedeemVoucher(I, user)
		return
	if(istype(I,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/C = usr.get_active_hand()
		if(istype(C) && !istype(inserted_id))
			usr.drop_item()
			C.loc = src
			inserted_id = C
			interact(user)
		return
	..()

/obj/machinery/mineral/equipment_vendor/proc/RedeemVoucher(obj/item/weapon/mining_voucher/voucher, mob/redeemer)
	var/selection = input(redeemer, "Pick your equipment", "Mining Voucher Redemption") as null|anything in list("Resonator", "Kinetic Accelerator", "Mining Drone")
	if(!selection || !Adjacent(redeemer) || voucher.gc_destroyed || voucher.loc != redeemer)
		return
	switch(selection)
		if("Resonator")
			new /obj/item/weapon/resonator(src.loc)
		if("Kinetic Accelerator")
			new /obj/item/weapon/gun/energy/kinetic_accelerator(src.loc)
		if("Mining Drone")
			new /mob/living/simple_animal/hostile/mining_drone(src.loc)
			new /obj/item/weapon/weldingtool/hugetank(src.loc)
	qdel(voucher)

/obj/machinery/mineral/equipment_vendor/ex_act()
	return

/**********************Mining Equipment Vendor Items**************************/

/**********************Mining Equipment Voucher**********************/

/obj/item/weapon/mining_voucher
	name = "mining voucher"
	desc = "A token to redeem a piece of equipment. Use it on a mining equipment vendor."
	icon = 'icons/obj/items.dmi'
	icon_state = "mining_voucher"
	w_class = 1

/**********************Mining Point Card**********************/

/obj/item/weapon/card/mining_point_card
	name = "mining point card"
	desc = "A small card preloaded with mining points. Swipe your ID card over it to transfer the points, then discard."
	icon_state = "data"
	var/points = 500

/obj/item/weapon/card/mining_point_card/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/card/id))
		if(points)
			var/obj/item/weapon/card/id/C = I
			C.mining_points += points
			user << "<span class='info'>You transfer [points] points to [C].</span>"
			points = 0
		else
			user << "<span class='info'>There's no points left on [src].</span>"
	..()

/obj/item/weapon/card/mining_point_card/examine()
	..()
	usr << "There's [points] points on the card."

/**********************Jaunter**********************/

/obj/item/device/wormhole_jaunter
	name = "wormhole jaunter"
	desc = "A single use device harnessing outdated wormhole technology, Nanotrasen has since turned its eyes to blue space for more accurate teleportation. The wormholes it creates are unpleasant to travel through, to say the least."
	icon = 'icons/obj/items.dmi'
	icon_state = "Jaunter"
	item_state = "electronic"
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 5
	origin_tech = "bluespace=2"

/obj/item/device/wormhole_jaunter/attack_self(mob/user as mob)
	if(prob(2))
		user << "<span class='notice'>You're having difficulties getting the [src.name] to work.</span>"
		return
	else
		user.visible_message("<span class='notice'>[user.name] activates the [src.name]!</span>")
		var/list/L = list()
		for(var/obj/item/device/radio/beacon/B in world)
			var/turf/T = get_turf(B)
			if(T.z == 1)
				L += B
		if(!L.len)
			user << "<span class='notice'>The [src.name] failed to create a wormhole.</span>"
			return
		var/chosen_beacon = pick(L)
		var/obj/effect/portal/wormhole/jaunt_tunnel/J = new /obj/effect/portal/wormhole/jaunt_tunnel(get_turf(src), chosen_beacon, lifespan=100)
		J.target = chosen_beacon
		try_move_adjacent(J)
		playsound(src,'sound/effects/sparks4.ogg',50,1)
		qdel(src)

/obj/effect/portal/wormhole/jaunt_tunnel
	name = "jaunt tunnel"
	icon = 'icons/effects/effects.dmi'
	icon_state = "bhole3"
	desc = "A stable hole in the universe made by a wormhole jaunter. Turbulent doesn't even begin to describe how rough passage through one of these is, but at least it will always get you somewhere near a beacon."

/obj/effect/portal/wormhole/jaunt_tunnel/New()
	..()
	spawn(20)
		if(!src.target)
			var/list/L = list()
			for(var/obj/item/device/radio/beacon/B in world)
				var/turf/T = get_turf(B)
				if(T.z == 1)
					L += B
			if(!L.len) return
			src.target = pick(L)
	spawn(100)
		qdel(src)

/obj/effect/portal/wormhole/jaunt_tunnel/teleport(atom/movable/M)
	if(istype(M, /obj/effect))
		return
	if(istype(M, /atom/movable))
		if(do_teleport(M, target, 6))
			if(isliving(M))
				var/mob/living/L = M
				L.Weaken(3)
				if(ishuman(L))
					shake_camera(L, 20, 1)
					spawn(20)
						if(L)
							L.visible_message("<span class='danger'>[L.name] vomits from travelling through the [src.name]!</span>")
							L.nutrition -= 20
							L.adjustToxLoss(-3)
							var/turf/T = get_turf(L)
							T.add_vomit_floor(L)
							playsound(L, 'sound/effects/splat.ogg', 50, 1)

/**********************Resonator**********************/

/obj/item/weapon/resonator
	name = "resonator"
	icon = 'icons/obj/items.dmi'
	icon_state = "resonator"
	item_state = "resonator"
	desc = "A handheld device that creates small fields of energy that resonate until they detonate, crushing rock. It can also be activated without a target to create a field at the user's location, to act as a delayed time trap. It's more effective in a vaccuum."
	w_class = 3
	force = 10
	throwforce = 10
	var/cooldown = 0

/obj/item/weapon/resonator/proc/CreateResonance(var/target, var/creator)
	if(cooldown <= 0)
		playsound(src,'sound/effects/stealthoff.ogg',50,1)
		var/obj/effect/resonance/R = new /obj/effect/resonance(get_turf(target))
		R.creator = creator
		cooldown = 1
		spawn(20)
			cooldown = 0

/obj/item/weapon/resonator/attack_self(mob/user as mob)
	CreateResonance(src, user)
	..()

/obj/item/weapon/resonator/afterattack(atom/target, mob/user, proximity_flag)
	if(target in user.contents)
		return
	if(proximity_flag)
		CreateResonance(target, user)

/obj/effect/resonance
	name = "resonance field"
	desc = "A resonating field that significantly damages anything inside of it when the field eventually ruptures."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield1"
	layer = 4.1
	mouse_opacity = 0
	var/resonance_damage = 30
	var/creator = null

/obj/effect/resonance/New()
	var/turf/proj_turf = get_turf(src)
	if(!istype(proj_turf))
		return
	if(istype(proj_turf, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = proj_turf
		playsound(src,'sound/effects/sparks4.ogg',50,1)
		M.gets_drilled()
		spawn(5)
			qdel(src)
	else
		var/datum/gas_mixture2/environment = proj_turf.get_air()
		var/pressure = environment.get_pressure()
		if(pressure < 50)
			name = "strong resonance field"
			resonance_damage = 60
		spawn(50)
			playsound(src,'sound/effects/sparks4.ogg',50,1)
			if(creator)
				for(var/mob/living/L in src.loc)
					add_logs(creator, L, "used a resonator field on", object="resonator")
					L << "<span class='danger'>The [src.name] ruptured with you in it!</span>"
					L.adjustBruteLoss(resonance_damage)
			else
				for(var/mob/living/L in src.loc)
					L << "<span class='danger'>The [src.name] ruptured with you in it!</span>"
					L.adjustBruteLoss(resonance_damage)
			qdel(src)

/**********************Facehugger toy**********************/

/obj/item/clothing/mask/facehugger/toy
	desc = "A toy often used to play pranks on other miners by putting it in their beds. It takes a bit to recharge after latching onto something."
	throwforce = 0
	sterile = 1
	tint = 3 //Makes it feel more authentic when it latches on

/obj/item/clothing/mask/facehugger/toy/examine()//So that giant red text about probisci doesn't show up.
	if(desc)
		usr << desc

/obj/item/clothing/mask/facehugger/toy/Die()
	return

/**********************Mining drone**********************/

/mob/living/simple_animal/hostile/mining_drone/
	name = "nanotrasen minebot"
	desc = "The instructions printed on the side read: This is a small robot used to support miners, can be set to search and collect loose ore, or to help fend off wildlife. A mining scanner can instruct it to drop loose ore. Field repairs can be done with a welder."
	icon = 'icons/obj/aibots.dmi'
	icon_state = "mining_drone"
	icon_living = "mining_drone"
	status_flags = CANSTUN|CANWEAKEN|CANPUSH
	stop_automated_movement_when_pulled = 1
	mouse_opacity = 1
	factions = list("neutral")
	a_intent = "harm"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	wander = 0
	idle_vision_range = 5
	move_to_delay = 10
	retreat_distance = 1
	minimum_distance = 2
	health = 125
	maxHealth = 125
	melee_damage_lower = 15
	melee_damage_upper = 15
	environment_smash = 0
	attacktext = "drills"
	attack_sound = 'sound/weapons/circsawhit.ogg'
	ranged = 1
	ranged_message = "shoots"
	ranged_cooldown_cap = 3
	projectiletype = /obj/item/projectile/kinetic
	projectilesound = 'sound/weapons/Gunshot4.ogg'
	wanted_objects = list(/obj/item/weapon/ore/diamond, /obj/item/weapon/ore/gold, /obj/item/weapon/ore/silver,
						  /obj/item/weapon/ore/plasma,  /obj/item/weapon/ore/uranium,    /obj/item/weapon/ore/iron,
						  /obj/item/weapon/ore/clown)

/mob/living/simple_animal/hostile/mining_drone/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/W = I
		if(W.welding && !stat)
			if(stance != HOSTILE_STANCE_IDLE)
				user << "<span class='info'>[src] is moving around too much to repair!</span>"
				return
			if(maxHealth == health)
				user << "<span class='info'>[src] is at full integrity.</span>"
			else
				health += 10
				user << "<span class='info'>You repair some of the armor on [src].</span>"
			return
	if(istype(I, /obj/item/device/mining_scanner))
		user << "<span class='info'>You instruct [src] to drop any collected ore.</span>"
		DropOre()
		return
	..()

/mob/living/simple_animal/hostile/mining_drone/Die()
	..()
	visible_message("<span class='danger'>[src] is destroyed!</span>")
	new /obj/effect/decal/cleanable/robot_debris(src.loc)
	DropOre()
	qdel(src)
	return

/mob/living/simple_animal/hostile/mining_drone/New()
	..()
	SetCollectBehavior()

/mob/living/simple_animal/hostile/mining_drone/attack_hand(mob/living/carbon/human/M)
	if(M.a_intent == "help")
		switch(search_objects)
			if(0)
				SetCollectBehavior()
				M << "<span class='info'>[src] has been set to search and store loose ore.</span>"
			if(2)
				SetOffenseBehavior()
				M << "<span class='info'>[src] has been set to attack hostile wildlife.</span>"
		return
	..()

/mob/living/simple_animal/hostile/mining_drone/proc/SetCollectBehavior()
	idle_vision_range = 9
	search_objects = 2
	wander = 1
	ranged = 0
	minimum_distance = 1
	retreat_distance = null
	icon_state = "mining_drone"

/mob/living/simple_animal/hostile/mining_drone/proc/SetOffenseBehavior()
	idle_vision_range = 7
	search_objects = 0
	wander = 0
	ranged = 1
	retreat_distance = 1
	minimum_distance = 2
	icon_state = "mining_drone_offense"

/mob/living/simple_animal/hostile/mining_drone/AttackingTarget()
	if(istype(target, /obj/item/weapon/ore))
		CollectOre()
		return
	..()

/mob/living/simple_animal/hostile/mining_drone/proc/CollectOre()
	var/obj/item/weapon/ore/O
	for(O in src.loc)
		O.loc = src
	for(var/dir in alldirs)
		var/turf/T = get_step(src,dir)
		for(O in T)
			O.loc = src
	return

/mob/living/simple_animal/hostile/mining_drone/proc/DropOre()
	if(!contents.len)
		return
	for(var/obj/item/weapon/ore/O in contents)
		contents -= O
		O.loc = src.loc
	return

/mob/living/simple_animal/hostile/mining_drone/adjustBruteLoss()
	if(search_objects)
		SetOffenseBehavior()
	..()

/**********************Lazarus Injector**********************/

/obj/item/weapon/lazarus_injector
	name = "lazarus injector"
	desc = "An injector with a cocktail of nanomachines and chemicals, this device can seemingly raise animals from the dead, making them become friendly to the user. Unfortunately, the process is useless on higher forms of life and incredibly costly, so these were hidden in storage until an executive thought they'd be great motivation for some of their employees."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "lazarus_hypo"
	item_state = "hypo"
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 5
	var/loaded = 1
	var/malfunctioning = 0

/obj/item/weapon/lazarus_injector/afterattack(atom/target, mob/user, proximity_flag)
	if(!loaded)
		return
	if(istype(target, /mob/living) && proximity_flag)
		if(istype(target, /mob/living/simple_animal))
			var/mob/living/simple_animal/M = target
			if(M.stat == DEAD)
				M.factions = list("neutral")
				M.revive()
				if(istype(target, /mob/living/simple_animal/hostile))
					var/mob/living/simple_animal/hostile/H = M
					if(malfunctioning)
						M.factions = list("lazarus")
						H.friends += user
						H.attack_same = 1
						log_game("[user] has revived hostile mob [target] with a malfunctioning lazarus injector")
					else
						H.attack_same = 0
				loaded = 0
				user.visible_message("<span class='notice'>[user] injects [M] with [src], reviving it.</span>")
				playsound(src,'sound/effects/refill.ogg',50,1)
				icon_state = "lazarus_empty"
				return
			else
				user << "<span class='info'>[src] is only effective on the dead.</span>"
				return
		else
			user << "<span class='info'>[src] is only effective on lesser beings.</span>"
			return

/obj/item/weapon/lazarus_injector/emp_act()
	if(!malfunctioning)
		malfunctioning = 1

/obj/item/weapon/lazarus_injector/examine()
	..()
	if(!loaded)
		usr << "<span class='info'>[src] is empty.</span>"
	if(malfunctioning)
		usr << "<span class='info'>The display on [src] seems to be flickering.</span>"

/**********************Mining Scanner**********************/
/obj/item/device/mining_scanner
	desc = "A scanner that checks surrounding rock for useful minerals, it can also be used to stop gibtonite detonations. Requires you to wear mesons to work properly."
	name = "mining scanner"
	icon_state = "mining"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT
	slot_flags = SLOT_BELT
	var/cooldown = 0

/obj/item/device/mining_scanner/attack_self(mob/user)
	if(!user.client)
		return
	if(!cooldown)
		cooldown = 1
		spawn(40)
			cooldown = 0
		var/client/C = user.client
		var/list/L = list()
		var/turf/simulated/mineral/M
		for(M in range(7, user))
			if(M.scan_state)
				L += M
		if(!L.len)
			user << "<span class='info'>[src] reports that nothing was detected nearby.</span>"
			return
		else
			for(M in L)
				var/turf/T = get_turf(M)
				var/image/I = image('icons/turf/walls.dmi', loc = T, icon_state = M.scan_state, layer = 18)
				C.images += I
				spawn(30)
					if(C)
						C.images -= I

//Debug item to identify all ore spread quickly
/obj/item/device/mining_scanner/admin

/obj/item/device/mining_scanner/admin/attack_self(mob/user)
	for(var/turf/simulated/mineral/M in world)
		if(M.scan_state)
			M.icon_state = M.scan_state
	del(src)

/**********************Xeno Warning Sign**********************/
/obj/structure/sign/xeno_warning_mining
	name = "DANGEROUS ALIEN LIFE"
	desc = "A sign that warns would be travellers of hostile alien life in the vicinity."
	icon = 'icons/obj/mining.dmi'
	icon_state = "xeno_warning"

/**********************Mining Jetpack**********************/
/obj/item/weapon/tank/jetpack/carbondioxide/mining
	name = "mining jetpack"
	icon_state = "jetpack-mining"
	item_state = "jetpack-mining"
	desc = "A tank of compressed carbon dioxide for miners to use as propulsion in local space. Should not be used for internals."
