/mob/living/simple_animal/hostile/retaliate/vision //If this works I am migrating the feature into daemons.
	name = "Spectre"
	desc = "A strange vision."
	icon = null
	icon_state = null
	density = 0
	opacity = 0
	response_help = "flails wildly at"
	response_disarm = "flails wildly at"
	response_harm = "flails wildly at"
	speed = 0
	stop_automated_movement_when_pulled = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 5
	melee_damage_upper = 15
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	status_flags = CANPUSH
	minbodytemp = 0
	heat_damage_per_tick = 0
	wander = 0
	environment_smash = 0 //No, one guys hallucinations can not be allowed to visibly smash windows.

	var/mob/living/carbon/human/my_target = null
	var/image/currentimage = null
	var/image/left
	var/image/right
	var/image/up
	var/image/down

	var/is_aggressive = 0

/mob/living/simple_animal/hostile/retaliate/vision/attackby(var/obj/item/weapon/P as obj, mob/user as mob)
	for(var/mob/M in oviewers(world.view,my_target))
		M << "\red <B>[my_target] flails around wildly.</B>"
	my_target.show_message("\red <B>[src] has been attacked by [my_target]!</B>", 1) //Lazy.
	src.adjustBruteLoss(P.force)
	return

/mob/living/simple_animal/hostile/retaliate/vision/bullet_act(var/obj/item/projectile/P)
	my_target.show_message("\red <B>[src] has been hit by the [P]!</B>", 1)
	src.adjustBruteLoss(P.damage)
	return

/mob/living/simple_animal/hostile/retaliate/vision/Crossed(var/mob/M, somenumber)
	if(M == my_target)
		step_away(my_target,src,2) //These projections are less impactable by victim's actions. Mob projections can't be killed or pushed around like regular hallucinations.

/mob/living/simple_animal/hostile/retaliate/vision/proc/updateimage()
//	del src.currentimage
	if(src.dir == NORTH)
		del src.currentimage
		src.currentimage = new /image(up,src)
	else if(src.dir == SOUTH)
		del src.currentimage
		src.currentimage = new /image(down,src)
	else if(src.dir == EAST)
		del src.currentimage
		src.currentimage = new /image(right,src)
	else if(src.dir == WEST)
		del src.currentimage
		src.currentimage = new /image(left,src)
	my_target << currentimage

/mob/living/simple_animal/hostile/retaliate/vision/Life()
	..()
	if(src.stat == DEAD) return
	if(src.is_aggressive)
		for(var/mob/living/carbon/human/H in range(1, get_turf(src)))
			if(H == my_target)
				H.adjustStaminaLoss(rand(melee_damage_lower, melee_damage_upper))
				H.take_organ_damage(0, rand(melee_damage_lower, melee_damage_upper)/4)
				H << "\red <b>The [src] attacks!</b>"
	if(prob(70))
		if(get_dist(src,my_target) > 1)
			src.dir = get_dir(src,my_target)
			step_towards(src,my_target)
			updateimage()
		else if(prob(50))
			step_away(src,my_target,2)
			updateimage()

/mob/living/simple_animal/hostile/retaliate/vision/AttackingTarget()
	return

/mob/living/simple_animal/hostile/retaliate/vision/Die()
	my_target << "\red [src] is dispelled!"
	qdel(src)

proc/mob_vision_agressive(var/mob/living/carbon/human/T, var/mob/living/clone) //This would be a good psyker power.
	var/mob/living/simple_animal/hostile/retaliate/vision/V = new /mob/living/simple_animal/hostile/retaliate/vision
	V.my_target = T
	V.loc = get_turf(V.my_target)
	V.left = image(clone,dir = WEST)
	V.right = image(clone,dir = EAST)
	V.up = image(clone,dir = NORTH)
	V.down = image(clone,dir = SOUTH)
	V.name = clone.name
	V.is_aggressive = 1

/mob/living/simple_animal/hostile/retaliate/vision/plague
	name = "disease induced hallucination"
	desc = "A strange vision."
	icon = 'icons/mob/mob.dmi'
	icon_state = "nurgling"
	alpha = 200
	var/offered = 0

/mob/living/simple_animal/hostile/retaliate/vision/plague/New()
	..()
	src.left = image(src,dir = WEST)
	src.right = image(src,dir = EAST)
	src.up = image(src,dir = NORTH)
	src.down = image(src,dir = SOUTH)
	icon = null
	icon_state = null

/mob/living/simple_animal/hostile/retaliate/vision/plague/Life()
	..()
	if(src.stat == DEAD) return
	if(!my_target)
		qdel(src)
	if(!offered && prob(20))
		offered = 1
		my_target << pick("<b>[src]</b> says, \"I can stop the plague from hurting you, if you want.\"", "<b>[src]</b> says, \"The plague is unpleasant, is it not? I can stop its progress.\"", "<b>[src]</b> says, \"You need not suffer from this. Let me help you.\"")
		spawn(40)
			my_target << pick("<b>[src]</b> says, \"It would be easy for me, child. If you are willing to cooperate.\"", "<b>[src]</b> says, \"It is possible through the power of papa nurgle, if you are willing.\"", "<b>[src]</b> says, \"The plague lord would be most glad to help you... For a price.\"")
		spawn(80)
			my_target << pick("<b>[src]</b> says, \"Your infection doesn't have to be a curse... It can be a blessing.\"", "<b>[src]</b> says, \"Disease should not be a curse. Let me make it a blessing.\"", "<b>[src]</b> says, \"Nurgle can bless you with this glorious sickness.\"")
		spawn(120)
			my_target << "<b>[src]</b> says, \"Just speak the oaths. Say \"I swear fealty to the plague lord nurgle in exchange for respite from my disease.\" and I will make it better.\""
			var/datum/daemon_contract/plague/C = new /datum/daemon_contract/plague
			C.offer(my_target)
			offered = 2
	if(offered == 2)
		if("NURGLE" in my_target.factions)
			my_target << "<b>[src]</b> says, \"Papa is glad you have made the right choice. You are blessed, child. Nobody need know of our little deal...\""
			qdel(src)
		else
			if(prob(5))
				my_target << pick("<b>[src]</b> says, \"I trust you will make the right choice.\"", "<b>[src]</b> says, \"I will wait. The unclean one is patient.\"", "<b>[src]</b> says, \"In a moment, I can make it better for you.\"", "<b>[src]</b> says, \"Choose wisely.\"", "<b>[src]</b> says, \"Loyalty to nurgle will be rewarded.\"", "<b>[src]</b> says, \"Helping you would be so easy...\"")
			if(prob(1))
				src.Die()

/mob/living/simple_animal/hostile/retaliate/vision/plague/Die()
	for(var/datum/daemon_contract/plague/C in my_target.pending_contracts) //If they kill the vision without accepting the contract, it is retracted.
		award(usr, "Uncorruptable")
		my_target << "<b>[src]</b> says, \"Very well. You have made your decision.\""
		qdel(C)
	..()