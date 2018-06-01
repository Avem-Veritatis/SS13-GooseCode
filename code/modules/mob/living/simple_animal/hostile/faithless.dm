/mob/living/simple_animal/hostile/faithless
	name = "The Faithless"
	desc = "The Wish Granter's faith in humanity, incarnate"
	icon_state = "faithless"
	icon_living = "faithless"
	icon_dead = "faithless_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "passes through"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 1
	maxHealth = 80
	health = 80

	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "grips"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	factions = list("faithless")

/mob/living/simple_animal/hostile/faithless/Process_Spacemove(var/check_drift = 0)
	return 1

/mob/living/simple_animal/hostile/faithless/FindTarget()
	. = ..()
	if(.)
		emote("wails at [.]")

/mob/living/simple_animal/hostile/faithless/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(12))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/faithless/harlequin //A spooky shade that takes your appearance after it attacks you the first time.
	name = "shade"
	desc = "Some kind of creature from the warp..."
	maxHealth = 130
	health = 130
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "bites"
	var/transformed = 0

/mob/living/simple_animal/hostile/faithless/harlequin/AttackingTarget()
	..()
	if(!transformed && ishuman(target))
		var/mob/living/carbon/human/H = target
		src.visible_message("\red The [src]'s form flickers!")
		transformed = 1
		src.icon = H.icon
		src.icon_state = H.icon_state
		src.overlays = H.overlays
		src.name = H.name
		attacktext = "stabs"
	else if(transformed && prob(25))
		src.visible_message("\red [src] darts away!")
		var/list/posturfs = circlerangeturfs(get_turf(src),3)
		var/turf/destturf = safepick(posturfs)
		src.loc = destturf
		var/area/destarea = get_area(destturf)
		destarea.Entered(src)

/mob/living/simple_animal/hostile/faithless/harlequin/Life()
	..()
	if(stat == 2)
		src.visible_message("\red [src] disintegrates in a plume of smoke!")
		new /obj/item/weapon/ectoplasm (src.loc)
		qdel(src)
		return
	else
		if(transformed && prob(5))
			src.visible_message("\red [src] darts away!")
			var/list/posturfs = circlerangeturfs(get_turf(src),3)
			var/turf/destturf = safepick(posturfs)
			src.loc = destturf
			var/area/destarea = get_area(destturf)
			destarea.Entered(src)