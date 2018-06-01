/obj/item/projectile/energy
	name = "energy"
	icon_state = "spark"
	damage = 0
	damage_type = BURN
	flag = "energy"
	trace_residue = "Minor electrical discolouration."


/obj/item/projectile/energy/electrode
	name = "electrode"
	icon_state = "spark"
	stun = 2
	weaken = 2
	stutter = 10
	hitsound = "sparks"

	on_hit(var/atom/target, var/blocked = 0)
		if(!ismob(target) || blocked >= 2) //Fully blocked by mob or collided with dense object - burst into sparks!
			var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread
			sparks.set_up(1, 1, src)
			sparks.start()
		..()

/obj/item/projectile/energy/declone
	name = "biological deconstructor ray"
	icon_state = "declone"
	damage = 20
	damage_type = CLONE
	irradiate = 40
	trace_residue = "Some sort of nanomachines."

/obj/item/projectile/energy/dart
	name = "dart"
	icon_state = "toxin"
	damage = 5
	damage_type = TOX
	weaken = 5
	trace_residue = null


/obj/item/projectile/energy/bolt
	name = "bolt"
	icon_state = "shuriken"
	damage = 10
	damage_type = TOX
	nodamage = 0
	weaken = 10
	stutter = 10
	trace_residue = null

/obj/item/projectile/energy/shuriken
	name = "shuriken"
	icon_state = "shuriken"
	damage = 10
	damage_type = TOX
	nodamage = 0
	weaken = 10
	stutter = 10
	trace_residue = null

/obj/item/projectile/energy/bolt/large
	name = "largebolt"
	damage = 10

/obj/item/projectile/energy/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	damage = 34
	damage_type = STAMINA
	var/range = 7

/obj/item/projectile/energy/disabler/Range()
	range--
	if(range <= 0)
		delete()

/obj/item/projectile/energy/heavyplasma //A sort of hybrid between a meltagun shot and a plasma gun shot.
	name = "heavy plasma"
	icon = 'icons/obj/largeprojectiles.dmi'
	icon_state = "plasma"
	damage = 30
	trace_residue = "Unfocused charring patterns."
	piercing = 100
	woundtype = /datum/wound/melt
	var/meltprob = 30
	var/toxpwr = 5

/obj/item/projectile/energy/heavyplasma/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target,/turf/)||istype(target,/obj/structure/)||istype(target,/obj/machinery/door/)||istype(target, /obj/effect/fake_floor))
		target.ex_act(3)
	if(istype(target, /mob/living))
		var/volume = 10
		var/mob/living/M = target
		if(!istype(M, /mob/living/simple_animal/hostile/retaliate/goose))
			if(ishuman(M))
				var/mob/living/carbon/human/H = M

				if(H.head)
					if(prob(meltprob) && !H.head.unacidable)
						H << "<span class='danger'>Your headgear melts away but protects you from the plasma!</span>"
						qdel(H.head)
						H.update_inv_head(0)
						H.update_hair(0)
					else
						H << "<span class='warning'>Your headgear protects you from the plasma.</span>"
					return

				if(H.wear_mask)
					if(prob(meltprob) && !H.wear_mask.unacidable)
						H << "<span class='danger'>Your mask melts away but protects you from the plasma!</span>"
						qdel(H.wear_mask)
						H.update_inv_wear_mask(0)
						H.update_hair(0)
					else
						H << "<span class='warning'>Your mask protects you from the plasma.</span>"
					return

				if(H.glasses) //Doesn't protect you from the acid but can melt anyways!
					if(prob(meltprob) && !H.glasses.unacidable)
						H << "<span class='danger'>Your glasses melts away!</span>"
						qdel(H.glasses)
						H.update_inv_glasses(0)

			else if(ismonkey(M))
				var/mob/living/carbon/monkey/MK = M
				if(MK.wear_mask)
					if(!MK.wear_mask.unacidable)
						MK << "<span class='danger'>Your mask melts away but protects you from the plasma!</span>"
						qdel(MK.wear_mask)
						MK.update_inv_wear_mask(0)
					else
						MK << "<span class='warning'>Your mask protects you from the plasma.</span>"
					return

			if(!M.unacidable)
				if(istype(M, /mob/living/carbon/human) && volume >= 3)
					var/mob/living/carbon/human/H = M
					var/obj/item/organ/limb/affecting = H.get_organ("head")
					if(affecting)
						if(affecting.take_damage(4*toxpwr, 2*toxpwr))
							H.update_damage_overlays(0)
						if(prob(meltprob)) //Applies disfigurement
							H.emote("scream")
							H.facial_hair_style = "Shaved"
							H.hair_style = "Bald"
							H.update_hair(0)
							H.status_flags |= DISFIGURED
				else
					M.take_organ_damage(min(6*toxpwr, volume * toxpwr)) // uses min() and volume to make sure they aren't being sprayed in trace amounts (1 unit != insta rape) -- Doohl
	..()

/obj/item/projectile/energy/plasma
	name = "plasma"
	icon_state = "plasmagun"
	damage = 30
	damage_type = BURN
	flag = "energy"
	trace_residue = "Serious Burns"
	woundtype = /datum/wound/melt
	var/meltprob = 30
	var/toxpwr = 5

	on_hit(var/mob/living/M, var/volume)//magic numbers everywhere
		volume = 10
		if(!istype(M, /mob/living))
			return
		if(!istype(M, /mob/living/simple_animal/hostile/retaliate/goose))
			if(ishuman(M))
				var/mob/living/carbon/human/H = M

				if(H.head)
					if(prob(meltprob) && !H.head.unacidable)
						H << "<span class='danger'>Your headgear melts away but protects you from the plasma!</span>"
						qdel(H.head)
						H.update_inv_head(0)
						H.update_hair(0)
					else
						H << "<span class='warning'>Your headgear protects you from the plasma.</span>"
					return

				if(H.wear_mask)
					if(prob(meltprob) && !H.wear_mask.unacidable)
						H << "<span class='danger'>Your mask melts away but protects you from the plasma!</span>"
						qdel(H.wear_mask)
						H.update_inv_wear_mask(0)
						H.update_hair(0)
					else
						H << "<span class='warning'>Your mask protects you from the plasma.</span>"
					return

				if(H.glasses) //Doesn't protect you from the acid but can melt anyways!
					if(prob(meltprob) && !H.glasses.unacidable)
						H << "<span class='danger'>Your glasses melts away!</span>"
						qdel(H.glasses)
						H.update_inv_glasses(0)

			else if(ismonkey(M))
				var/mob/living/carbon/monkey/MK = M
				if(MK.wear_mask)
					if(!MK.wear_mask.unacidable)
						MK << "<span class='danger'>Your mask melts away but protects you from the plasma!</span>"
						qdel(MK.wear_mask)
						MK.update_inv_wear_mask(0)
					else
						MK << "<span class='warning'>Your mask protects you from the plasma.</span>"
					return

			if(!M.unacidable)
				if(istype(M, /mob/living/carbon/human) && volume >= 3)
					var/mob/living/carbon/human/H = M
					var/obj/item/organ/limb/affecting = H.get_organ("head")
					if(affecting)
						if(affecting.take_damage(4*toxpwr, 2*toxpwr))
							H.update_damage_overlays(0)
						if(prob(meltprob)) //Applies disfigurement
							H.emote("scream")
							H.facial_hair_style = "Shaved"
							H.hair_style = "Bald"
							H.update_hair(0)
							H.status_flags |= DISFIGURED
				else
					M.take_organ_damage(min(6*toxpwr, volume * toxpwr)) // uses min() and volume to make sure they aren't being sprayed in trace amounts (1 unit != insta rape) -- Doohl
		else
			if(!M.unacidable)
				M.take_organ_damage(min(6*toxpwr, volume * toxpwr))

/*
pulseb
*/

/obj/item/projectile/energy/pulseb
	name = "pulse blast"
	icon_state = "ice_1" //needs icon?
	damage = 140
	damage_type = BURN
	flag = "bullet"
	trace_residue = "Serious Burns"
	woundtype = /datum/wound/melt
	var/meltprob = 10
	var/toxpwr = 5

	on_hit(var/mob/living/M, var/volume, var/atom/target)//magic numbers everywhere
		volume = 10

		if(!istype(M, /mob/living/simple_animal/hostile/retaliate/goose))
			if(ishuman(M))
				var/mob/living/carbon/human/H = M

				if(H.head)
					if(prob(meltprob) && !H.head.unacidable)
						H << "<span class='danger'>Your headgear melts away but protects you from the blast!</span>"
						qdel(H.head)
						H.update_inv_head(0)
						H.update_hair(0)

				if(H.wear_mask)
					if(prob(meltprob) && !H.wear_mask.unacidable)
						H << "<span class='danger'>Your mask melts away but protects you from the blast!</span>"
						qdel(H.wear_mask)
						H.update_inv_wear_mask(0)
						H.update_hair(0)

				if(H.glasses) //Doesn't protect you from the acid but can melt anyways!
					if(prob(meltprob) && !H.glasses.unacidable)
						qdel(H.glasses)
						H.update_inv_glasses(0)

			if(ismonkey(M))
				var/mob/living/carbon/monkey/MK = M
				if(MK.wear_mask)
					if(!MK.wear_mask.unacidable)
						MK << "<span class='danger'>Your mask melts away but protects you from the plasma!</span>"
						qdel(MK.wear_mask)
						MK.update_inv_wear_mask(0)
					else
						MK << "<span class='warning'>Your mask protects you from the plasma.</span>"
						return
			if(istype(target,/turf/)||istype(target,/obj/structure/)||istype(target,/obj/machinery/door/))
				target.ex_act(2)


/obj/item/projectile/energy/pulseb/New()
	spawn(4)
		qdel(src)

/obj/item/projectile/energy/test
	name = "tester beam"
	icon_state = "testbeam"
	damage = 75
	damage_type = BURN
	flag = "bullet"
	pixel_shot = 1
	diagnostic = 1
	delay = 50