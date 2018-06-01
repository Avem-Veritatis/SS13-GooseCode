/obj/item/projectile/ion
	name = "ion bolt"
	icon_state = "ion"
	damage = 0
	damage_type = BURN
	nodamage = 1
	flag = "energy"
	trace_residue = "Minor electrical discolouration."


	on_hit(var/atom/target, var/blocked = 0)
		empulse(target, 1, 1)
		return 1


/obj/item/projectile/bullet/gyro
	name = "Bolt"
	icon_state = "bolter"
	damage = 45
	flag = "bullet"
	trace_residue = "Airburst explosive patterning."
	bloody = 1 //This should make bolter shots appear more powerful.
	piercing = 25 //Pierces armor pretty well.
	woundtype = /datum/wound/bolter

/obj/item/projectile/bullet/gyro/heavy
	name = "Heavy Bolt"
	damage = 60
	piercing = 35

/obj/item/projectile/bullet/gyro/npc
	damage = 25
	pass_flags = PASSULTRA

/obj/item/projectile/bullet/vanquisher
	name = "vanquisher shell"
	icon_state = "baneblade"
	damage = 60
	damage_type = BRUTE
	flag = "bullet"
	woundtype = /datum/wound/shrapnel

/obj/item/projectile/bullet/vanquisher/on_hit(var/target)
	..()
	var/turf/T = get_turf(target)
	explosion(T, 2, 2, 3, 0, 2, flame_range = 0)
	return

/obj/item/projectile/bullet/slug
	name ="slug"
	icon_state = "bigbullet"
	damage = 20
	flag = "bullet"
	trace_residue = "Lead residue."
	piercing = 5

/obj/item/projectile/temp
	name = "freeze beam"
	icon_state = "ice_2"
	damage = 0
	damage_type = BURN
	nodamage = 1
	flag = "energy"
	trace_residue = null
	var/temperature = 100


	on_hit(var/atom/target, var/blocked = 0)//These two could likely check temp protection on the mob
		if(istype(target, /mob/living))
			var/mob/M = target
			M.bodytemperature = temperature
		return 1

/obj/item/projectile/temp/hot
	name = "heat beam"
	temperature = 400
	trace_residue = "Unfocused charring patterns."

/obj/item/projectile/temp/melta
	name = "liquad death"
	icon = 'icons/obj/largeprojectiles.dmi'
	icon_state = "melta"
	nodamage = 0
	damage = 50
	temperature = 30000
	trace_residue = "Unfocused charring patterns."
	piercing = 10
	woundtype = /datum/wound/melt

/obj/item/projectile/temp/melta/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	if(istype(target,/turf/)||istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
		target.ex_act(2)
	if(istype(target, /obj/effect/fake_floor))
		target.ex_act(2)
	if(istype(target,/obj/mecha/))
		var/turf/T = get_turf(target)
		explosion(T, 2, 2, 3, 0, 2, flame_range = 0)
	..()

/obj/item/projectile/beam/lascannon
	name = "lascannon shot"
	icon_state = "heavylaser"
	damage = 75
	piercing = 30
	//speed = 1
	delay = 0.65 //Lets see if /that/ works better.
	woundtype = /datum/wound/melt

/obj/item/projectile/beam/lascannon/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target,/turf/)||istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
		target.ex_act(3)
	if(istype(target, /obj/effect/fake_floor))
		target.ex_act(3)
	if(istype(target,/obj/mecha/))
		var/obj/mecha/mech = target
		mech.take_damage(750)
	..()

/obj/item/projectile/meteor
	name = "meteor"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "smallf"
	damage = 0
	damage_type = BRUTE
	nodamage = 1
	flag = "bullet"
	trace_residue = null

	Bump(atom/A as mob|obj|turf|area)
		if(A == firer)
			loc = A.loc
			return

		sleep(-1) //Might not be important enough for a sleep(-1) but the sleep/spawn itself is necessary thanks to explosions and metoerhits

		if(src)//Do not add to this if() statement, otherwise the meteor won't delete them
			if(A)

				A.ex_act(2)
				playsound(src.loc, 'sound/effects/meteorimpact.ogg', 40, 1)

				for(var/mob/M in range(10, src))
					if(!M.stat && !istype(M, /mob/living/silicon/ai))\
						shake_camera(M, 3, 1)
				delete()
				return 1
		else
			return 0

/obj/item/projectile/energy/floramut
	name = "alpha somatoray"
	icon_state = "energy"
	damage = 0
	damage_type = TOX
	nodamage = 1
	flag = "energy"
	trace_residue = null

	on_hit(var/atom/target, var/blocked = 0)
		if(iscarbon(target))
			var/mob/living/carbon/M = target
			if(check_dna_integrity(M) && M.dna.mutantrace == "plant") //Plantmen possibly get mutated and damaged by the rays.
				if(prob(15))
					M.apply_effect((rand(30,80)),IRRADIATE)
					M.Weaken(5)
					for (var/mob/V in viewers(src))
						V.show_message("\red [M] writhes in pain as \his vacuoles boil.", 3, "\red You hear the crunching of leaves.", 2)
				if(prob(35))
				//	for (var/mob/V in viewers(src)) //Public messages commented out to prevent possible metaish genetics experimentation and stuff. - Cheridan
				//		V.show_message("\red [M] is mutated by the radiation beam.", 3, "\red You hear the snapping of twigs.", 2)
					if(prob(80))
						randmutb(M)
						domutcheck(M,null)
					else
						randmutg(M)
						domutcheck(M,null)
				else
					M.adjustFireLoss(rand(5,15))
					M.show_message("\red The radiation beam singes you!")
				//	for (var/mob/V in viewers(src))
				//		V.show_message("\red [M] is singed by the radiation beam.", 3, "\red You hear the crackle of burning leaves.", 2)
			else
			//	for (var/mob/V in viewers(src))
			//		V.show_message("The radiation beam dissipates harmlessly through [M]", 3)
				M.show_message("\blue The radiation beam dissipates harmlessly through your body.")

/obj/item/projectile/energy/florayield
	name = "beta somatoray"
	icon_state = "energy2"
	damage = 0
	damage_type = TOX
	nodamage = 1
	flag = "energy"
	trace_residue = null

	on_hit(mob/living/carbon/target, var/blocked = 0)
		if(iscarbon(target))
			if(ishuman(target) && target.dna && target.dna.mutantrace == "plant")	//These rays make plantmen fat.
				target.nutrition = min(target.nutrition+30, 500)
			else
				target.show_message("\blue The radiation beam dissipates harmlessly through your body.")
		else
			return 1


/obj/item/projectile/beam/mindflayer
	name = "flayer ray"
	icon_state = "energy2"
	trace_residue = null
	damage_type = TOX
	woundtype = null
	on_hit(var/atom/target, var/blocked = 0)
		if(ishuman(target))
			var/mob/living/carbon/M = target
			M.adjustBrainLoss(20)
			M.hallucination += 20

/obj/item/projectile/kinetic
	name = "kinetic force"
	icon_state = null
	damage = 15
	damage_type = BRUTE
	flag = "bomb"
	trace_residue = null
	var/range = 2

obj/item/projectile/kinetic/New()
	var/turf/proj_turf = get_turf(src)
	if(!istype(proj_turf, /turf))
		return
	var/datum/gas_mixture2/environment = proj_turf.get_air()
	var/pressure = environment.get_pressure()
	if(pressure < 50)
		name = "full strength kinetic force"
		damage = 30
		bloody = 1
	..()

/obj/item/projectile/kinetic/Range()
	range--
	if(range <= 0)
		new /obj/item/effect/kinetic_blast(src.loc)
		delete()

/obj/item/projectile/kinetic/on_hit(var/atom/target)
	var/turf/target_turf= get_turf(target)
	if(istype(target_turf, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = target_turf
		M.gets_drilled()
	new /obj/item/effect/kinetic_blast(target_turf)
	..()

/obj/item/effect/kinetic_blast
	name = "kinetic explosion"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "kinetic_blast"
	layer = 4.1

/obj/item/effect/kinetic_blast/New()
	spawn(4)
		qdel(src)

/obj/item/projectile/bullet/las
	name ="Laser"
	icon_state= "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 15
	damage_type = BURN
	flag = "laser"
	trace_residue = "Focused charring patterns."
	woundtype = /datum/wound/laser

/obj/item/projectile/bullet/inferno
	name ="Inferno bolt"
	icon_state= "bolter"
	damage = 35
	damage_type = BRUTE
	flag = "bullet"
	trace_residue = "Airburst explosive patterning."
	bloody = 1 //This should make bolter shots appear more powerful.
	piercing = 2
	woundtype = /datum/wound/bolter

/obj/item/projectile/bullet/inferno/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()

/obj/item/projectile/bullet/fusion
	name = "Fusion blast"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "diffuse"
	damage = 80
	damage_type = BURN
	flag = "bullet"
	trace_residue = "Focused charring patterns."
	woundtype = /datum/wound/melt

/obj/item/projectile/bullet/fusion/on_hit(var/atom/target, var/blocked = 0, var/mob/living/M, var/volume)
	if(istype(target,/turf/)||istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
		target.ex_act(2)
	if(istype(target,/obj/mecha/))
		if(prob(12))
			var/turf/T = get_turf(target)
			explosion(T, 2, 2, 3, 0, 2, flame_range = 0)

/obj/item/projectile/bullet/fusion/New()
	spawn(3.5)
		qdel(src)