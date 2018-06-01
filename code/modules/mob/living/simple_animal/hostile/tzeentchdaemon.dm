/mob/living/simple_animal/hostile/lordofchange
	name = "Lord Of Change"
	desc = "It's your ass now!"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "lordofchange"
	icon_living = "lordofchange"
	icon_dead = ""
	icon_gib = ""
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 1
	meat_type = list(/obj/item/weapon/reagent_containers/food/snacks/xenomeat)
	maxHealth = 10000
	health = 10000
	harm_intent_damage = 0
	melee_damage_lower = 25
	melee_damage_upper = 100
	attacktext = "slashes"
	a_intent = "harm"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 0
	factions = list("alien")
	status_flags = CANPUSH
	minbodytemp = 0
	heat_damage_per_tick = 0

	Die()
		playsound(src.loc,'sound/voice/gooselaugh.ogg',75,1)
		qdel(src)