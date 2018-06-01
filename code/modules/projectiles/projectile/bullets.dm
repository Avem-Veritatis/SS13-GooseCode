/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	woundtype = /datum/wound/bullet

/obj/item/projectile/bullet/voxlegis
	name = "heavy slug"
	icon_state= "bullet"
	damage = 55
	flag = "bullet"
	icon_state = "bigbullet"
	trace_residue = "Lead residue."
	stun = 1
	weaken = 2
	bloody = 1
	piercing = 15

/obj/item/projectile/bullet/needler
	name = "needle"
	icon_state = "needler"
	damage_type = TOX
	damage = 35
	trace_residue = "Cauterized Pinpricking"
	hitsound = 'sound/weapons/sear.ogg'
	piercing = 3
	woundtype = /datum/wound/laser

/obj/item/projectile/bullet/weakbullet
	damage = 5
	stun = 5
	weaken = 5

/obj/item/projectile/bullet/weakbullet2
	damage = 15
	stun = 5
	weaken = 5

/obj/item/projectile/bullet/weakbullet3
	damage = 20

/obj/item/projectile/bullet/pellet
	name = "pellet"
	damage = 15

/obj/item/projectile/bullet/pellet/New()
	src.pixel_x = rand(-10, 10)
	src.pixel_y = rand(-10, 10)
	..()

/obj/item/projectile/bullet/midbullet
	damage = 20
	weaken = 1

/obj/item/projectile/bullet/shootabullet			//ork shoota special ammo
	icon_state = "bflash"
	damage = 11

/obj/item/projectile/bullet/shurikan			//eldar special ammo
	name = "shuriken"
	icon_state = "shuriken"
	damage = 15
	piercing = 5 //monomolecular and such
	woundtype = null

/obj/item/projectile/bullet/midbullet2
	damage = 25

/obj/item/projectile/bullet/midbullet3 //Only used with the Stechkin Pistol - RobRichards
	name = "stubber bullet"
	damage = 30

/obj/item/projectile/bullet/midbullet3/heavy
	damage = 40


/obj/item/projectile/bullet/suffocationbullet//How does this even work?
	name = "co bullet"
	damage = 20
	damage_type = OXY


/obj/item/projectile/bullet/cyanideround
	name = "poison bullet"
	damage = 40
	damage_type = TOX


/obj/item/projectile/bullet/burstbullet//I think this one needs something for the on hit
	name = "exploding bullet"
	damage = 20


/obj/item/projectile/bullet/stunshot
	name = "stunshot"
	damage = 5
	stun = 10
	weaken = 10
	stutter = 10
	woundtype = null


/obj/item/projectile/bullet/a762
	damage = 25

/obj/item/projectile/bullet/auto
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 10
	on_hit(var/atom/target, var/blocked = 0)
		if(istype(target,/turf/)||istype(target,/obj/structure/))
			target.ex_act(2)
		..()

/obj/item/projectile/bullet/flare
	name = "flare"
	icon_state = "flare"
	damage = 1
	woundtype = null

/obj/item/projectile/bullet/flare/on_hit(var/atom/target, var/blocked = 0)
	new /obj/item/device/flashlight/flare2 (src.loc)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()


/obj/item/projectile/bullet/fire
	name = "fire"
	icon_state = "flame"
	damage = 3
	damage_type = BURN
	woundtype = null

/obj/item/projectile/bullet/fire/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()

/obj/item/projectile/bullet/fire/New()
	spawn(5)
		qdel(src)

/obj/item/projectile/bullet/incendiary

/obj/item/projectile/bullet/incendiary/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()

/obj/item/projectile/bullet/incendiary/shell
	damage = 20

/obj/item/projectile/bullet/incendiary/mech
	damage = 7

/obj/item/projectile/bullet/promethium
	name = "promethium shell"
	damage = 20

/obj/item/projectile/bullet/promethium/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()
	..()

/obj/item/projectile/bullet/exitus
	name = "exitus bullet"
	icon_state = "exitus"
	damage = 50
	weaken = 2
	stun = 2
	bloody = 1
	homing = 1
	piercing = 100
	layer_pierce = 19
	pixel_shot = 0 //Homing bullets have to use the legacy system for understandable reasons... Although an angle changing homing bullet would admittedly look awesome. I would make that but it's not worth it for a single gun.
	var/life = 20

/obj/item/projectile/bullet/exitus/on_hit(var/atom/target, var/blocked = 0)
	if(ismob(target))
		var/mob/M = target
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/C = target
			C.bleedout = 1
		else
			M.death(0)
	else
		target.ex_act(2)
	..()

/obj/item/projectile/bullet/exitus/enforcement
	damage = 100
	weaken = 10
	stun = 10
	paralyze = 10
	var/reason = ""
	var/minutes = 0
	var/ckey = ""

/obj/item/projectile/bullet/exitus/enforcement/on_hit(var/atom/target, var/blocked = 0)
	if(ismob(target) && usr)
		var/mob/M = target
		if(M.ckey == ckey)
			if(reason != "" && minutes != 0)
				AddBan(ckey, M.computer_id, reason, usr.ckey, 1, minutes)
	..()

/obj/item/projectile/bullet/mime
	damage = 20
	trace_residue = null

/obj/item/projectile/bullet/mime/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)


/obj/item/projectile/bullet/dart
	name = "dart"
	icon_state = "cbbolt"
	damage = 6
	trace_residue = "Deep pinpricking."
	woundtype = null
	var/force_inject = 0

	New()
		..()
		flags |= NOREACT
		create_reagents(50)

	on_hit(var/atom/target, var/blocked = 0, var/hit_zone)
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/M = target
			if(M.can_inject(null,0,hit_zone) || force_inject) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				reagents.trans_to(M, reagents.total_volume)
				return 1
			else
				target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against the [name]!</span>")
		flags &= ~NOREACT
		reagents.handle_reactions()
		return 1

/obj/item/projectile/bullet/dart/metalfoam
	New()
		..()
		reagents.add_reagent("aluminium", 15)
		reagents.add_reagent("foaming_agent", 5)
		reagents.add_reagent("pacid", 5)

/obj/item/projectile/bullet/dart/venom
	name = "venom crystal"

	New()
		..()
		reagents.add_reagent("potassium", 10)
		reagents.add_reagent("phosphorus", 10)
		reagents.add_reagent("sugar", 10)
		reagents.add_reagent("venomthropes", 10)
		reagents.add_reagent("phenol", 10)
		reagents.add_reagent("curare", 10)

/obj/item/projectile/bullet/dart/acid
	name = "maggot"
	force_inject = 1

	New()
		..()
		reagents.add_reagent("hacid", 50)

/obj/item/projectile/bullet/dart/shrieker
	name = "shrieker shuriken"
	icon_state = "shuriken"
	color = "#000000"
	damage = 50
	piercing = 15
	force_inject = 1
	bloody = 1

	New()
		..()
		reagents.add_reagent("destroyer", 10) //This is the perfect poison for this weapon.

//This one is for future syringe guns update
/obj/item/projectile/bullet/dart/syringe
	name = "syringe"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeproj"

/obj/item/projectile/bullet/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	weaken = 5
	trace_residue = "Sludge residue."

/obj/item/projectile/bullet/neurotoxin/on_hit(var/atom/target, var/blocked = 0)
	if(isalien(target))
		return 0
	..() // Execute the rest of the code.

/obj/item/projectile/bullet/devourer
	name = "devourer"
	icon_state = "tplasma"
	damage = 10
	damage_type = TOX
	trace_residue = "Sludge residue."

/obj/item/projectile/bullet/devourer/on_hit(var/atom/target, var/blocked = 0)
	var/mob/living/simple_animal/hostile/alien/ripper/R = new /mob/living/simple_animal/hostile/alien/ripper(get_turf(target))
	R.size = 15
	R.health = 5
	R.melee_damage_lower = 3
	R.melee_damage_upper = 5
	R.update_size()
	if(isalien(target))
		return 0
	..() // Execute the rest of the code.

/obj/item/projectile/bullet/chaingun
	name = "bullet"
	icon_state = "bullet"
	damage = 5
	damage_type = BRUTE
	flag = "bullet"

/obj/item/projectile/bullet/shrapnel
	name = "\proper shrapnel"
	icon_state = "shrapnel1"
	damage = 20
	damage_type = BRUTE
	flag = "bullet"
	trace_residue = "Embedded shrapnel."
	bloody = 1
	piercing = 5 //Pierces armor slightly since it is shrapnel.
	//speed = 1    //One does not simply outrun shrapnel. Unless they are the mime.
	delay = 0.6 //Lets see if /that/ works better.
	woundtype = /datum/wound/shrapnel
	pixel_shot = 0

/obj/item/projectile/bullet/shrapnel/New()
	..()
	icon_state = "shrapnel[rand(1, 10)]"
	src.pixel_x = rand(-15, 15)
	src.pixel_y = rand(-15, 15)
	spawn(6)
		qdel(src)//new

/obj/item/projectile/bullet/autogun
	name = "autogun bullet"
	icon_state = "bullet"
	damage = 11
	damage_type = BRUTE
	flag = "bullet"
	//speed = 1
	//delay = 0.5 //Lets see if /that/ works better.

/obj/item/projectile/bullet/lasgun
	name ="Laser"
	icon_state = "ibeam"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 15
	damage_type = BURN
	flag = "laser"
	trace_residue = "Focused charring patterns."
	//speed = 1
	delay = 0.65 //Lets see if /that/ works better.
	woundtype = /datum/wound/laser

/obj/item/projectile/bullet/lasgun2
	name ="Laser"
	icon_state = "red_laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 3
	damage_type = BURN
	flag = "laser"
	trace_residue = "Focused charring patterns."
	woundtype = /datum/wound/laser

/obj/item/projectile/bullet/lasgun3
	name ="Laser"
	icon_state = "green_laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 10
	damage_type = BURN
	flag = "laser"
	trace_residue = "Focused charring patterns."
	woundtype = /datum/wound/laser