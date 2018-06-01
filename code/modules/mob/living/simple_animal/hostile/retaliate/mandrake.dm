/*
The beginnings of a dark eldar mandrake.
This will take some time but I have an idea or two for how these can work.
We may need a good sprite for this though. I will try and make one.
*/

/mob/living/simple_animal/hostile/retaliate/mandrake
	name = "Mandrake"
	real_name = "Mandrake"
	desc = "Even THEY fear these things..."
	icon = 'icons/mob/mob.dmi'
	icon_state = "mandrake"
	icon_living = "mandrake"
	icon_dead = "mandrake_dead"
	maxHealth = 500 //High health, this will be a long confrontation.
	health = 500
	speak_emote = list("hisses")
	emote_hear = list("hisses")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	harm_intent_damage = 2
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "stabs"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speed = 0
	stop_automated_movement = 1
	status_flags = 0
	environment_smash = 0
	wander = 0
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 450 //A good fire would hurt one, but not something small.
	heat_damage_per_tick = 15	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 10	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	unsuitable_atoms_damage = 10

	factions = list("dark eldar")

/mob/living/simple_animal/hostile/retaliate/mandrake/New()
	..()
	src.say("I DONT WANT WHAT YOU HAVE! I WANT TO BE YOU!")