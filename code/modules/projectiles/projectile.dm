/*
#define BRUTE "brute"
#define BURN "burn"
#define TOX "tox"
#define OXY "oxy"
#define CLONE "clone"

#define ADD "add"
#define SET "set"
*/

/obj/item/projectile
	name = "projectile"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bullet"
	density = 1
	unacidable = 1
	anchored = 1 //There's a reason this is here, Mport. God fucking damn it -Agouri. Find&Fix by Pete. The reason this is here is to stop the curving of emitter shots.
	pass_flags = PASSTABLE
	mouse_opacity = 0
	hitsound = 'sound/weapons/pierce.ogg'
	var/bumped = 0		//Prevents it from hitting more than one guy at once
	var/def_zone = ""	//Aiming at
	var/mob/firer = null//Who shot it
	var/silenced = 0	//Attack message
	var/yo = null
	var/xo = null
	var/current = null
	var/atom/original = null // the original target clicked
	var/turf/starting = null // the projectile's starting turf
	var/list/permutated = list() // we've passed through these atoms, don't try to hit them again

	var/p_x = 16
	var/p_y = 16 // the pixel location of the tile that the player clicked. Default is the center

	var/damage = 10
	var/damage_type = BRUTE //BRUTE, BURN, TOX, OXY, CLONE are the only things that should be in here
	var/nodamage = 0 //Determines if the projectile will skip any damage inflictions
	var/flag = "bullet" //Defines what armor to use when it hits things.  Must be set to bullet, laser, energy,or bomb
	var/projectile_type = "/obj/item/projectile"
	var/kill_count = 50 //This will de-increment every process(). When 0, it will delete the projectile.
		//Effects
	var/stun = 0
	var/weaken = 0
	var/paralyze = 0
	var/irradiate = 0
	var/stutter = 0
	var/eyeblur = 0
	var/drowsy = 0
	var/forcedodge = 0
	var/trace_residue = "Projectile markings."

	var/bloody = 0 //makes the bullet spray blood when it hits a person. -Drake
	var/homing = 0 //Used exclusively for the exitus rifle.
	var/atom/target = null
	var/piercing = 0
	var/layer_pierce = 0
	var/speed = 0 //At zero moves at normal projectile speed. At 1, moves twice as fast as normal. At 2, moves three times as fast as normal. Et cetera.
	var/speed_iter = 0
	var/delay = 1
	var/woundtype = null
	var/pixel_shot = 1 //A variable switch to try and let them use a fancier system.
	var/rotateme = 1
	var/Angle
	var/diagnostic = 0

	//New() //Just an attempt at nicer looking projectiles. //I will save this for later, especially when I can put animate in things like this and moving turf.
	//	..()
	//	spawn(1)
	//		var/matrix/angled = matrix(transform) //Alright, time to try this.
	//		angled.Turn(Atan2(xo, yo))
	//		src.transform = angled //huh.

	ex_act() //I don't think a blast should be deleting this...
		return

	proc/delete()
		// Garbage collect the projectiles
		loc = null

	proc/on_hit(var/atom/target, var/blocked = 0, var/hit_zone)
		if(isliving(target))
			var/mob/living/L = target
			L.add_suit_fibers(trace_residue)

			if(isanimal(target) || isrobot(target))
				return 0

			if(ishuman(L))
				if(src.bloody) //Lets a projectile spray blood... For now only for humans. Can be extended to aliens and even robots later.
					new /obj/effect/gibspawner/blood(L.loc)

			return L.apply_effects(stun, weaken, paralyze, irradiate, stutter, eyeblur, drowsy, blocked)
		else
			target.add_custom_fiber(trace_residue)

	proc/vol_by_damage()
		if(src.damage)
			return Clamp((src.damage) * 0.67, 30, 100)// Multiply projectile damage by 0.67, then clamp the value between 30 and 100
		else
			return 50 //if the projectile doesn't do damage, play its hitsound at 50% volume

	Bump(atom/A as mob|obj|turf|area)

		if(firer)
			if(A == firer || (A == firer.loc && istype(A, /obj/mecha)))
				loc = A.loc
				return 0 //cannot shoot yourself

		if(bumped)//Stops multihit projectiles
			return 1

		bumped = 1
		if(ismob(A))
			if(!src.homing && istype(A, /mob/living/carbon)) //More dodge code! This makes sure you can't get shot at. The others just make it look nicer.
				var/mob/living/carbon/M = A
				if(M.dodging || (M.confused && M.luck > 0 && prob(M.luck*2)) || (M.luck > 0 && prob(M.luck/3)))
					if(M.stat != 2) //We don't want dodging if we are dead. Though how you kill someone in this state I have no clue.
						var/dodgeloc = locate(min(max(-(y + yo), 1), world.maxx), min(max(x + xo, 1), world.maxy), z) //Kind of hackish, but (-y,x) is an easy way to get perpendicular motion.
						if(!step_towards(M, dodgeloc)) //This literally makes you automatically dodge projectiles... Very nice reflexes.
							bumped = 0
							return 0 //Note that if this fails you still get hit. If you stand in a corner you can't dodge.
			var/mob/M = A
			if(!istype(A, /mob/living))
				loc = A.loc
				return 0// nope.avi

			var/reagent_note
			if(reagents && reagents.reagent_list)
				reagent_note = " REAGENTS:"
				for(var/datum/reagent/R in reagents.reagent_list)
					reagent_note += R.id + " ("
					reagent_note += num2text(R.volume) + ") "
			var/distance = get_dist(get_turf(A), starting) // Get the distance between the turf shot from and the mob we hit and use that for the calculations.
			def_zone = ran_zone(def_zone, max(100-(7*distance), 5)) //Lower accurancy/longer range tradeoff. 7 is a balanced number to use.
			add_logs(firer, M, "shot", object="[src]", addition=reagent_note)


		spawn(0)
			if(A)
				// We get the location before running A.bullet_act, incase the proc deletes A and makes it null
				var/turf/new_loc = null
				if(istype(A, /turf))
					new_loc = A
				else
					new_loc = A.loc

				var/permutation = A.bullet_act(src, def_zone) // searches for return value, could be deleted after run so check A isn't null

				if(permutation == -1 || (forcedodge && !istype(A, /turf)))// the bullet passes through a dense object!
					bumped = 0 // reset bumped variable!
					loc = new_loc
					permutated.Add(A)
					return 0

				if(homing && (A == target || src.loc == target))
					density = 0
					invisibility = 101
					delete()
					return 0

				if(layer_pierce) //Lets a bullet actually go through x number of objects. Unless it is a homing bullet that just hit its target.
					layer_pierce -= 1
					bumped = 0
					return 1

				density = 0
				invisibility = 101
				delete()
				return 0
		return 1


	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(air_group || (height==0)) return 1

		if(istype(mover, /obj/item/projectile))
			return prob(95)
		else
			return 1


	process()
		if(pixel_shot)
			if(diagnostic)
				world << "\n\n--------------------------\nshot vector is ([xo], [yo]) fired at ([x], [y])\n-----------------------------\n\n"
			if(rotateme)
				if(!Angle)
					Angle = Atan2(yo, xo)
					xo = sin(Angle)*32 //Make sure the distance per tick is constant.
					yo = cos(Angle)*32
					if(Angle < 0)
						Angle += 360
				var/matrix/M = new
				M.Turn(Angle)
				transform = M
		if(kill_count < 1)
			delete()
			return
		kill_count--
		spawn while(src && src.loc)
			if(pixel_shot)
				if(rotateme)
					var/matrix/M = new
					M.Turn(Angle)
					transform = M
				/*
				while(step_y >= 16)
					pixel_y -= 32
					step(src, NORTH, 32)
					//src.y += 1
				while(pixel_x >= 16)
					pixel_x -= 32
					step(src, EAST, 32)
					//src.x += 1
				while(pixel_y < -16)
					pixel_y += 32
					step(src, SOUTH, 32)
					//src.y -= 1
				while(pixel_x < -16)
					pixel_x += 32
					step(src, WEST, 32)
				*/
					//src.x -= 1
				var/Pixel_x=round(sin(Angle)+16*sin(Angle)*2) //THIS should do it. Maybe?
				var/Pixel_y=round(cos(Angle)+16*cos(Angle)*2)
				spawn(0)
					animate(src, pixel_x = (pixel_x + Pixel_x), time=delay)
				spawn(0)
					animate(src, pixel_y = (pixel_y + Pixel_y), time=delay)
				/*
				spawn(delay) //Some calculations to set things the right way.
					x += round((pixel_x-16)/32)+1
					pixel_x = ((pixel_x-16)%32)-16
					y += round((pixel_y-16)/32)+1
					pixel_y = ((pixel_y-16)%32)-16
				*/
				var/x_change = round((src.pixel_x-16)/32) + 1
				var/y_change = round((src.pixel_y-16)/32) + 1
				src.pixel_x -= x_change*32
				src.pixel_y -= y_change*32
				var/new_x = src.x + x_change
				var/new_y = src.y + y_change
				step_towards(src, locate(new_x, new_y, z))
				if(diagnostic)
					world << "\n[src] data\nx:[src.x] y:[src.y] pixel_x:[pixel_x] pixel_y:[pixel_y]"
			else
				if(homing && target) //Recalibrate where the bullet is flying to.
					current = get_turf(target)
					if(get_turf(src) == get_turf(current))
						spawn(10) //Just making sure the bullet gets dealt with in this case...
							qdel(src)
				else if((!( current ) || loc == current))
					current = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z)
			if((x == 1 || x == world.maxx || y == 1 || y == world.maxy))
				delete()
				return
			if(!pixel_shot)
				step_towards(src, current)
			if(speed_iter == speed)
				speed_iter = 0
				sleep(delay)
			else
				speed_iter += 1
			if(!bumped && ((original && original.layer>=2.75) || ismob(original)))
				if(loc == get_turf(original))
					if(!(original in permutated))
						Bump(original)
						sleep(1)
			Range()
		return

/obj/item/projectile/proc/Range()
	return