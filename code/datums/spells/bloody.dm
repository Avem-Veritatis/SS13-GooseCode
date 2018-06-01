/*
This spell is effectively identical to disintegrate.
The difference is, this version is vastly more theatric.
Using this for some obscure ability or other but sometime when psykers are completely redone, this might be a real spell.
*/

/obj/effect/proc_holder/spell/targeted/devestate
	name = "Devestate"
	desc = "Smite an unlucky adversary with a deadly wave of energy."
	school = "telekinesis"
	charge_max = 600
	clothes_req = 0
	invocation_type = "emote"
	range = 1
	cooldown_min = 300

/obj/effect/proc_holder/spell/targeted/devestate/Click()
	if(usr)
		invocation = "Blood red tendrils materialize around [usr.real_name] and lash out!"
	else
		invocation_type ="none"
	..()

/obj/effect/proc_holder/spell/targeted/devestate/cast(list/targets,mob/user = usr)
	if(!targets.len)
		user << "No target found."
		return

	if(targets.len > 1)
		user << "Multiple targets...? What the hell...?"
		return

	var/mob/living/target = targets[1]

	if(!(target in oview(range)))
		user << "They are too far away!"
		return

	var/mob/living/victim = target

	spawn(0)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc) //This is going to be absurdly gory...
		new /obj/effect/gibspawner/generic(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		if(ishuman(victim))
			new /obj/effect/gibspawner/human(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		if(ishuman(victim))
			new /obj/effect/gibspawner/human(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		if(ishuman(victim))
			new /obj/effect/gibspawner/human(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		victim.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(victim.loc)
		new /obj/effect/gibspawner/generic(victim.loc)
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		if(ishuman(victim))
			new /obj/effect/gibspawner/human(victim.loc)
		step_away(victim,user,10)
		sleep(1)
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		new /obj/effect/gibspawner/generic(get_step(get_turf(victim), pick(cardinal)))
		if(ishuman(victim))
			new /obj/item/organ/heart(victim.loc)
			new /obj/item/organ/limb/chest(victim.loc)
			new /obj/item/organ/limb/head(victim.loc)
		for(var/obj/item/I in victim.contents)
			if(prob(25)) I.loc = get_step(get_turf(victim), pick(cardinal))
		victim.gib()
		sleep(1)
		if(victim)
			qdel(victim)