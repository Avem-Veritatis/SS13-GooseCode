/**********************Mineral ores**************************/

/obj/item/weapon/ore
	name = "Rock"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore"
	var/points = 0 //How many points this ore gets you from the ore redemption machine
	var/refined_type = null //What this ore defaults to being refined into

/obj/item/weapon/ore/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/W = I
		if(W.remove_fuel(15))
			new refined_type(get_turf(src.loc))
			qdel(src)
		else
			user << "<span class='info'>Not enough fuel to smelt [src].</span>"
	..()

/obj/item/weapon/ore/uranium
	name = "Uranium ore"
	icon_state = "Uranium ore"
	origin_tech = "materials=5"
	points = 18
	refined_type = /obj/item/stack/sheet/mineral/uranium

/obj/item/weapon/ore/iron
	name = "Iron ore"
	icon_state = "iron ore"
	origin_tech = "materials=1"
	points = 1
	refined_type = /obj/item/stack/sheet/metal

/obj/item/weapon/ore/glass
	name = "Sand"
	icon_state = "Glass ore"
	origin_tech = "materials=1"
	points = 1
	refined_type = /obj/item/stack/sheet/glass

	attack_self(mob/living/user as mob) //It's magic I ain't gonna explain how instant conversion with no tool works. -- Urist
		var/location = get_turf(user)
		var/sandAmt = 1 // The sand we're holding
		for(var/obj/item/weapon/ore/glass/sandToConvert in location) // The sand on the floor
			sandAmt += 1
			qdel(sandToConvert)
		var/obj/item/stack/sheet/mineral/newSandstone = new /obj/item/stack/sheet/mineral/sandstone(location)
		newSandstone.amount = sandAmt
		qdel(src)

/obj/item/weapon/ore/plasma
	name = "Plasma ore"
	icon_state = "Plasma ore"
	origin_tech = "materials=2"
	points = 36
	refined_type = /obj/item/stack/sheet/mineral/plasma

/obj/item/weapon/ore/plasma/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/W = I
		if(W.welding)
			user << "<span class='info'>You can't hit a high enough temperature to smelt [src] properly.</span>"
	else
		..()


/obj/item/weapon/ore/silver
	name = "Silver ore"
	icon_state = "Silver ore"
	origin_tech = "materials=3"
	points = 18
	refined_type = /obj/item/stack/sheet/mineral/silver

/obj/item/weapon/ore/gold
	name = "Gold ore"
	icon_state = "Gold ore"
	origin_tech = "materials=4"
	points = 18
	refined_type = /obj/item/stack/sheet/mineral/gold

/obj/item/weapon/ore/diamond
	name = "Diamond ore"
	icon_state = "Diamond ore"
	origin_tech = "materials=6"
	points = 36
	refined_type = /obj/item/stack/sheet/mineral/diamond

/obj/item/weapon/ore/clown
	name = "Bananium ore"
	icon_state = "Clown ore"
	origin_tech = "materials=4"
	points = 27
	refined_type = /obj/item/stack/sheet/mineral/clown

/obj/item/weapon/ore/slag
	name = "Slag"
	desc = "Completely useless"
	icon_state = "slag"

/obj/item/weapon/twohanded/required/gibtonite
	name = "Gibtonite ore"
	desc = "Extremely explosive if struck with mining equipment, Gibtonite is often used by miners to speed up their work by using it as a mining charge. This material is illegal to possess by unauthorized personnel under space law."
	icon = 'icons/obj/mining.dmi'
	icon_state = "Gibtonite ore"
	item_state = "Gibtonite ore"
	w_class = 4
	throw_range = 0
	anchored = 1 //Forces people to carry it by hand, no pulling!
	var/primed = 0
	var/det_time = 100
	var/quality = 1 //How pure this gibtonite is, determines the explosion produced by it and is derived from the det_time of the rock wall it was taken from, higher value = better

/obj/item/weapon/twohanded/required/gibtonite/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/pickaxe) || istype(I, /obj/item/weapon/resonator))
		GibtoniteReaction(user)
		return
	if(istype(I, /obj/item/device/mining_scanner) && primed)
		primed = 0
		user.visible_message("<span class='notice'>The chain reaction was stopped! ...The ore's quality went down.</span>")
		icon_state = "Gibtonite ore"
		quality = 1
		return
	..()

/obj/item/weapon/twohanded/required/gibtonite/bullet_act(var/obj/item/projectile/P)
	if(istype(P, /obj/item/projectile/kinetic))
		GibtoniteReaction(P.firer)
	..()

/obj/item/weapon/twohanded/required/gibtonite/ex_act()
	GibtoniteReaction(triggered_by_explosive = 1)

/obj/item/weapon/twohanded/required/gibtonite/proc/GibtoniteReaction(mob/user, triggered_by_explosive = 0)
	if(!primed)
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,1)
		primed = 1
		icon_state = "Gibtonite active"
		var/turf/bombturf = get_turf(src)
		var/area/A = get_area(bombturf)
		var/notify_admins = 0
		if(z != 5)//Only annoy the admins ingame if we're triggered off the mining zlevel
			notify_admins = 1
		if(notify_admins)
			if(triggered_by_explosive)
				message_admins("An explosion has triggered a [name] to detonate at <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[bombturf.x];Y=[bombturf.y];Z=[bombturf.z]'>[A.name] (JMP)</a>.")
			else
				message_admins("[key_name(usr)]<A HREF='?_src_=holder;adminmoreinfo=\ref[usr]'>?</A> has triggered a [name] to detonate at <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[bombturf.x];Y=[bombturf.y];Z=[bombturf.z]'>[A.name] (JMP)</a>.")
		if(triggered_by_explosive)
			log_game("An explosion has primed a [name] for detonation at [A.name]([bombturf.x],[bombturf.y],[bombturf.z])")
		else
			user.visible_message("<span class='warning'>[user] strikes the [src], causing a chain reaction!</span>")
			log_game("[key_name(usr)] has primed a [name] for detonation at [A.name]([bombturf.x],[bombturf.y],[bombturf.z])")
		spawn(det_time)
		if(primed)
			if(quality == 3)
				explosion(src.loc,2,4,9,adminlog = notify_admins)
			if(quality == 2)
				explosion(src.loc,1,2,5,adminlog = notify_admins)
			if(quality == 1)
				explosion(src.loc,-1,1,3,adminlog = notify_admins)
			qdel(src)

/obj/item/weapon/ore/New()
	pixel_x = rand(0,16)-8
	pixel_y = rand(0,8)-8

/obj/item/weapon/ore/ex_act()
	return

/*****************************Coin********************************/

/obj/item/weapon/coin
	icon = 'icons/obj/economy.dmi'
	name = "coin"
	icon_state = "coin__heads"
	flags = CONDUCT
	force = 1
	throwforce = 0
	w_class = 1.0
	var/string_attached
	var/list/sideslist = list("heads","tails")
	var/luckyside = "heads"
	var/unluckyside = "tails"
	var/cmineral = null
	var/cooldown = 0

/obj/item/weapon/coin/New()
	pixel_x = rand(0,16)-8
	pixel_y = rand(0,8)-8

	icon_state = "coin_[cmineral]_heads"
	if(cmineral)
		name = "[cmineral] coin"

/obj/item/weapon/coin/gold
	cmineral = "gold"

/obj/item/weapon/coin/silver
	cmineral = "silver"

/obj/item/weapon/coin/diamond
	cmineral = "diamond"

/obj/item/weapon/coin/iron
	cmineral = "iron"

/obj/item/weapon/coin/plasma
	cmineral = "plasma"

/obj/item/weapon/coin/uranium
	cmineral = "uranium"

/obj/item/weapon/coin/clown
	cmineral = "bananium"

/obj/item/weapon/coin/adamantine
	cmineral = "adamantine"

/obj/item/weapon/coin/mythril
	cmineral = "mythril"

/obj/item/weapon/coin/twoheaded
	cmineral = "iron"
	desc = "Hey, this coin's the same on both sides!"
	sideslist = list("heads")
	unluckyside = "heads"


/obj/item/weapon/coin/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/stack/cable_coil) )
		var/obj/item/stack/cable_coil/CC = W
		if(string_attached)
			user << "\blue There already is a string attached to this coin."
			return

		if(CC.amount <= 0)
			user << "\blue This cable coil appears to be empty."
			qdel(CC)
			return

		overlays += image('icons/obj/economy.dmi',"coin_string_overlay")
		string_attached = 1
		user << "\blue You attach a string to the coin."
		CC.use(1)
	else if(istype(W,/obj/item/weapon/wirecutters))
		if(!string_attached)
			..()
			return

		var/obj/item/stack/cable_coil/CC = new/obj/item/stack/cable_coil(user.loc)
		CC.amount = 1
		CC.update_icon()
		overlays = list()
		string_attached = null
		user << "\blue You detach the string from the coin."
	else ..()

/obj/item/weapon/coin/attack_self(mob/user as mob)
	if(cooldown < world.time - 15)
		var/coinflip = pick(sideslist)
		if(prob(abs(user.luck)/2))
			if(user.luck > 0)
				coinflip = luckyside
			else
				coinflip = unluckyside
		cooldown = world.time
		flick("coin_[cmineral]_flip", src)
		icon_state = "coin_[cmineral]_[coinflip]"
		playsound(user.loc, 'sound/items/coinflip.ogg', 50, 1)
		if(do_after(user, 15))
			user.visible_message("<span class='notice'>[user] has flipped [src]. It lands on [coinflip].</span>", \
								 "<span class='notice'>You flip [src]. It lands on [coinflip].</span>", \
								 "<span class='notice'>You hear the clattering of loose change.</span>")