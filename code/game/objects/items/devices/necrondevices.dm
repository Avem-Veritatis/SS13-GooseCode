//Necron gadgets used by wraiths and crypteks. You will need to add the warp storm graphic to the nightmare shroud code, right now it has NarSie, and you will also need to add the sound. -DrakeMarshall

//TODO: Make the phase shifter actually a bit more powerful, but make it a big quest item in the tombs.

/obj/item/device/phaseshifter
	name = "phase shifter"
	icon = 'icons/mob/necron.dmi'
	icon_state = "phaseshifter"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "syndicate=12;magnets=12"
	var/active = 0
	var/mob/living/holder = null

/obj/item/device/phaseshifter/dropped()
	disrupt()

/obj/item/device/phaseshifter/equipped()
	disrupt()

/obj/item/device/phaseshifter/attack_self()
	toggle()

/obj/item/device/phaseshifter/proc/toggle()
	if(active)
		var/mob/living/M = usr
		M << "\red You deactivate the phase shifter."
		M.incorporeal_move = 0
		holder = null
		active = 0
	else
		var/mob/living/M = usr
		M << "\red You activate the phase shifter."
		award(M, "<span class='gold'>Tomb Raider</span>")
		M.incorporeal_move = 3
		holder = M
		active = 1

/obj/item/device/phaseshifter/proc/disrupt()
	if(holder && active)
		holder.incorporeal_move = 0
		holder = null
		active = 0
	else if(!holder && !active)
		return
	else
		if(usr) usr << "\red [src.name]: error: This should never happen. Would you mind letting a developer know how you triggered this? Direct them to line 51 of necrondevices.dm please."
		return

/obj/item/weapon/melee/phaseclaw
	name = "phase claw"
	desc = "Necron wraith claws that phase partially through the target, allowing them to bypass all armor and sever arteries and nerve with deadly precision."
	icon = 'icons/mob/necron.dmi'
	icon_state = "wraithclaw"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 75.0
	throwforce = 85
	w_class = 3
	origin_tech = "combat=20"
	attack_verb = list("sliced through", "cut through", "shredded")
	hitsound = 'sound/weapons/slash.ogg'

/obj/item/weapon/melee/phaseclaw/attack(mob/living/M as mob, mob/user as mob)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/gun/magic/staff/abyssalstaff
	name = "abyssal staff"
	desc = "An extremely high tech staff that confounds all technological understanding, the mark of a dreaded necron psychomancer."
	ammo_type = /obj/item/ammo_casing/magic/abyssal
	icon = 'icons/mob/necron.dmi'
	icon_state = "abyssalstaff"
	item_state = "staffofchaos" //I *could* make handheld icons customly for these, but it really shouldn't matter since only necrons will wield them, not humans.
	force = 30.0 //Not as good as light staff but still a melee weapon.
	max_charges = 12
	recharge_rate = 6 //Not super fast charging, but good eneough to use in combat to screw with people.

/obj/item/ammo_casing/magic/abyssal
	projectile_type = /obj/item/projectile/magic/abyssal

/obj/item/projectile/magic/abyssal //For cryptek abyssal staff.
	name = "abyssal bolt"
	icon_state = "dark2"
	damage = 15
	damage_type = BURN
	flag = "magic"
	on_hit(var/atom/target, var/blocked = 0)
		if(ishuman(target))
			var/mob/living/carbon/human/M = target
			M.adjustBrainLoss(20)
			M.hallucination += 20
			M.Dizzy(5)
			M.Stun(1)

/obj/item/device/veilofdankness
	name = "veil of darkness"
	icon = 'icons/mob/necron.dmi'
	icon_state = "veil"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "syndicate=4;magnets=12"

/obj/item/device/veilofdankness/attack_self()
	var/turf/T = usr.loc
	var/area/A = T.loc
	if(A)
		var/light_amount = 5
		if(A.lighting_use_dynamic)	light_amount = T.lighting_lumcount
		else						light_amount =  10
		if(light_amount > 2)
			usr << "\red You extinguish nearby light sources."
			for(var/obj/machinery/light/L in range(11, usr))
				L.on = 0
				if(prob(40))
					L.rigged = 1 //Some lights will break when you try turning the lights back on.
				L.update()
			for(var/obj/item/device/flashlight/F in range(11, usr))
				F.on = 0
				F.update_brightness(usr)
			for(var/obj/item/device/pda/P in range(11,usr))
				P.fon = 0
				P.SetLuminosity(0)
			for(var/mob/living/M in range(11, usr))
				for(var/obj/item/device/flashlight/F in M.contents)
					F.on = 0
					F.update_brightness(M)
				for(var/obj/item/device/pda/P in M.contents)
					P.fon = 0
					M.AddLuminosity(-P.f_lum)
		else
			usr << "\red Error: Area is already dark."
	else
		usr << "\red What on earth?! You aren't in an area? Report this to an admin please, this is some kind of wierd bug."

/obj/effect/fake_projectile
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	name = "plasma"
	desc = "plasma"
	density = 0
	anchored = 1
	opacity = 0

proc/fake_projectile(var/mob/living/carbon/T)
	var/list/turfs = list()
	for(var/turf/simulated/floor/F in oview(7,T))
		turfs += F
	var/turf/source = pick(turfs)
	var/obj/effect/fake_projectile/N = new /obj/effect/fake_projectile
	N.loc = source
	spawn
		var/turf/target = get_turf(T)
		while(1)
			sleep(1)
			step_towards(N, target)
			if(N.loc == target)
				del(N)

proc/fake_gauss(var/mob/living/carbon/T)
	var/list/turfs = list()
	for(var/turf/simulated/floor/F in oview(7,T))
		turfs += F
	var/turf/source = pick(turfs)
	var/turf/target = get_turf(T)
	spawn(0)
		source.Beam(target,"gauss",,7,20)
	spawn(0)
		var/atom/movable/overlay/animation = new(target)
		animation.icon = 'icons/obj/projectiles.dmi'
		animation.layer = 3
		animation.icon_state = "green_laser"
		animation.master = target
		flick("gauss beam", animation)
		sleep(10)
		qdel(animation)

/obj/item/device/nightmareshroud
	name = "nightmare shroud"
	icon = 'icons/mob/necron.dmi'
	icon_state = "shroud"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "syndicate=4;magnets=12"

/obj/item/device/nightmareshroud/attack_self()
	var/list/victims = list()
	for(var/mob/living/carbon/C in orange(11))
		victims += C
	var/mob/living/carbon/T = input(src, "Who should you send a nightmare to?") as null|anything in victims
	if(T)
		var/choice = pick("warpstorm","plasmavolley","gaussvolley","wraith","daemon","corpses")
		switch(choice)
			if("plasmavolley")
				spawn(0)
					fake_projectile(T)
				spawn(10)
					fake_projectile(T)
				spawn(20)
					fake_projectile(T)
			if("gaussvolley")
				spawn(0)
					fake_gauss(T)
				spawn(10)
					fake_gauss(T)
				spawn(20)
					fake_gauss(T)
			if("warpstorm")
				var/list/turfs = list()
				for(var/turf/simulated/S in oview(7,T))
					turfs += S
				var/turf/source = pick(turfs)
				for(var/mob/living/M in view(7,source))
					M << "<font size='15' color='red'><b>A WARP STORM HAS APPEARED</b></font>"
				var/atom/movable/overlay/animation = new(source)
				animation.icon = 'icons/obj/narsie.dmi' //Please change this to the warp storm icon, and add the sound, too. I don't have those things.
				animation.layer = 4
				animation.master = source
				flick("warp storm", animation)
				sleep(50)
				qdel(animation)
			if("wraith")
				var/list/turfs = list()
				for(var/turf/simulated/wall/W in oview(7,T))
					turfs += W
				var/turf/source = pick(turfs)
				var/atom/movable/overlay/animation = new(source) //Selects a wall, so it looks like the wraith is phasing in through the wall to get you.
				animation.icon = 'icons/mob/necron.dmi'
				animation.icon_state = "wraith"
				animation.layer = 4
				animation.master = source
				flick("Necron Wraith", animation)
				sleep(50)
				qdel(animation)
			if("daemon")
				var/list/turfs = list()
				for(var/turf/simulated/floor/F in oview(7,T))
					turfs += F
				var/turf/source = pick(turfs)
				var/atom/movable/overlay/animation = new(source)
				animation.icon = 'icons/mob/necron.dmi'
				animation.icon_state = "daemon_vision"
				animation.layer = 4
				animation.master = source
				flick("Daemon", animation)
				sleep(50)
				qdel(animation)
			if("corpses")
				var/list/turfs = list()
				for(var/turf/simulated/floor/F in oview(7,T))
					turfs += F
				var/turf/source
				for(var/stage = 1, stage<=5, stage++)
					spawn()
						source = pick(turfs)
						var/atom/movable/overlay/animation = new(source)
						animation.icon = 'icons/mob/necron.dmi'
						animation.icon_state = "corpse_vision"
						animation.layer = 4
						animation.master = source
						flick("Unkown", animation)
						sleep(50)
						qdel(animation)

/obj/item/clothing/suit/armor/necrodermis
	name = "necrodermis"
	desc = "Living metal, it appears to be bonded to flesh."
	icon_state = "necron"
	item_state = "necron"
	w_class = 4
	gas_transfer_coefficient = 0.90
	flags = NODROP|THICKMATERIAL|STOPSPRESSUREDMAGE
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 1
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(melee = 80, bullet = 60, laser = 70, energy = 65, bomb = 55, bio = 50, rad = 60)

/obj/item/clothing/suit/armor/necrodermis/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/suit/armor/necrodermis/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		H.heal_overall_damage(1, 1)
		H.AdjustStunned(-1)
		H.AdjustWeakened(-1)
		H.AdjustParalysis(-1)
		if(H.stat == DEAD)
			H.visible_message("\red [H] is torn apart as the necrodermis carapace on \him implodes!")
			H.gib()

/obj/item/clothing/head/helmet/necrodermis
	name = "necrodermis"
	desc = "Living metal, it appears to be bonded to flesh."
	icon_state = "necron"
	item_state = "necron"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|NODROP|THICKMATERIAL|STOPSPRESSUREDMAGE
	armor = list(melee = 75, bullet = 50, laser = 50,energy = 50, bomb = 50, bio = 50, rad = 60)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flash_protect = 1

/obj/item/device/necrodermis
	name = "strange device"
	desc = "This contraption is made of a strange metal and seems to hum with life."
	icon = 'icons/mob/necron.dmi'
	icon_state = "necrodermis"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "syndicate=4;magnets=12"

/obj/item/device/necrodermis/attack_self()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.visible_message("\red The necrodermis uncoils in your hands, wrapping itself around you and binding to your skin!", "\red The necrodermis uncoils in [H]'s hands, wrapping itself around \him and binding to \his skin!")
		if(H.wear_suit)
			qdel(H.wear_suit)
		if(H.head)
			qdel(H.head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/necrodermis(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/necrodermis(H), slot_head)
		H.Weaken(10)
		qdel(src)
	else
		return