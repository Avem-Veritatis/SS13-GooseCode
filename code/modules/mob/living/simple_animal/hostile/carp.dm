
/mob/living/simple_animal/hostile/carp
	name = "space carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"
	icon_gib = "carp_gib"
	speak_chance = 0
	turns_per_move = 5
	meat_type = list(/obj/item/weapon/reagent_containers/food/snacks/carpmeat)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	speed = 1
	maxHealth = 25
	health = 25

	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'

	//Space carp aren't affected by atmos.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	factions = list("carp")

/mob/living/simple_animal/hostile/carp/Process_Spacemove(var/check_drift = 0)
	return 1	//No drifting in space for space carp!	//original comments do not steal

/mob/living/simple_animal/hostile/carp/FindTarget()
	. = ..()
	if(.)
		emote("nashes at [.]")

/mob/living/simple_animal/hostile/carp/AttackingTarget()
	. =..()
	var/mob/living/carbon/L = .
	if(istype(L))
		if(prob(15))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/carp/holocarp
	icon_state = "holocarp"
	icon_living = "holocarp"

/mob/living/simple_animal/hostile/carp/holocarp/Die()
	qdel(src)
	return

/mob/living/simple_animal/hostile/carp/lasercarp
	icon_state = "lasercarp"
	icon_living = "lasercarp"
	name = "Space Laser Beam Carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish.This one seems angry. Perhaps this is due to the laser gun welded to it's head?"
	response_disarm = "gently pushes aside the threatening laser barrel"
	response_help = "carefully pets"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/item/projectile/beam

/mob/living/simple_animal/hostile/carp/megacarp
	icon = 'icons/migrated/alienqueen.dmi'
	name = "Mega Space Carp"
	desc = "A ferocious, fang bearing creature that resembles a fish. This one seems especially ticked off."
	icon_state = "megacarp"
	icon_living = "megacarp"
	icon_dead = "megacarp_dead"
	icon_gib = "megacarp_gib"
	maxHealth = 65
	health = 65

	melee_damage_lower = 20
	melee_damage_upper = 20