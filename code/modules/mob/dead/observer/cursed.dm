/*
The ghost of someone who swore fealty in the afterlife to chaos in exchange for power. This inhibits their RTD, since their ghost is taken by chaos.
This variant of cursed ghost will get a few better verbs for interacting with the material world.
Fealty is still a very, very large price to pay for power in one life, however. As it should be.
*/

/mob/dead/observer/cursed
	name = "tainted spirit"
	icon_state = "ghost_dark"
	can_reenter_corpse = 0
	can_rtd = 0
	var/speaktime = 0
	var/bootime = 0
	var/manifestenergy = 0

/mob/dead/observer/cursed/verb/flicker()
	set category = "Ghost"
	set name = "Flicker Light"
	set desc = "Use your disruptive presence in the empyrean to make a light you touch flicker."

	if(bootime > world.time) return
	var/obj/machinery/light/L = locate(/obj/machinery/light) in view(1, src)
	if(L)
		L.flicker()
		bootime = world.time + 400
		return
	return

/mob/dead/observer/cursed/verb/makesound()
	set category = "Ghost"
	set name = "Speak From Beyond"
	set desc = "Whisper in the ear of one of the living you stand over."

	if(speaktime > world.time)
		src << "\red You do not have the energy to do this yet."
		return
	var/mob/living/M = locate(/mob/living) in view(1, src)
	if(M)
		playsound(get_turf(M), pick('sound/hallucinations/behind_you1.ogg',\
			'sound/hallucinations/behind_you2.ogg',\
			'sound/hallucinations/i_see_you1.ogg',\
			'sound/hallucinations/i_see_you2.ogg',\
			'sound/hallucinations/im_here1.ogg',\
			'sound/hallucinations/im_here2.ogg',\
			'sound/hallucinations/look_up1.ogg',\
			'sound/hallucinations/look_up2.ogg',\
			'sound/hallucinations/over_here1.ogg',\
			'sound/hallucinations/over_here2.ogg',\
			'sound/hallucinations/over_here3.ogg',\
			'sound/hallucinations/turn_around1.ogg',\
			'sound/hallucinations/turn_around2.ogg',\
			), 50, 1, -3)
		speaktime = world.time + 2000
		return
	return

/mob/dead/observer/cursed/verb/absorb()
	set category = "Ghost"
	set name = "Absorb Blood"
	set desc = "Suck the blood off the floor to fuel a manifestation."

	var/obj/effect/decal/cleanable/blood/B = locate(/obj/effect/decal/cleanable/blood) in view(1, src)
	if(B)
		if(istype(B, /obj/effect/decal/cleanable/blood/gibs/old))
			B << "\red That doesn't look very appetizing, even for you. Something fresher would be better."
			return
		B.visible_message("\red Something devours the [B]!", "\red You devour the [B].", "\red You hear a slurping sound.")
		qdel(B)
		manifestenergy += 1

/mob/dead/observer/cursed/verb/manifest()
	set category = "Ghost"
	set name = "Manifest"
	set desc = "Use gathered energy to surface in the materium to serve your dark master."
	if(manifestenergy < 10)
		src << "\red <b>You are too weak to form a physical manifestation!</b>"
	else
		var/mob/living/simple_animal/hostile/dark_ghost/M = new (get_turf(src))
		M.fealty = master
		M.visible_message("\red <b>A twisted countenance unfolds out of thin air!</b>")
		M.key = src.key
		spawn(3000) //If it hasn't been killed a bit later, it will run out of energy unless it happened to drain a corpse.
			if(M)
				M << "\red Your borrowed life force from absorbed blood runs out."
				M.health -= 15
				if(M.health <= 0)
					M << "\red You have no remaining energy to sustain your corporeal form!"
					M.Die()

/mob/living/simple_animal/hostile/dark_ghost
	name = "tainted spirit"
	real_name = "tainted spirit"
	desc = "A malevolent presence."
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost_dark"
	icon_living = "ghost_dark"
	icon_dead = "shade_dead"
	speak_emote = list("hisses")
	emote_hear = list("wails","screeches")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	attacktext = "sucks life from"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	maxHealth = 15
	health = 15
	harm_intent_damage = 10
	melee_damage_lower = 5
	melee_damage_upper = 5
	speed = 1
	stop_automated_movement = 1
	friendly = "passes through"
	var/energy = 0
	var/phased = 0

/mob/living/simple_animal/hostile/dark_ghost/verb/devour()
	set category = "Ghost"
	set name = "Sacrifice Dead"
	set desc = "Feast upon a fresh corpse to enhance your life force binding you to the material world."

	var/mob/living/carbon/M = locate(/mob/living/carbon) in view(1, src)
	if(M && M.stat == DEAD)
		if(!(HUSK in M.mutations))
			M.mutations.Add(HUSK)
			M.update_mutations()
			M.visible_message("\red The [src] desecrates [M]'s corpse!", "\red You drain energy from [M]'s corpse.", "\red You hear a slurping sound.")
			src << "\red You feel energized!"
			if(speed > -1)
				speed -= 1
			maxHealth += 20 //Not terribly potent. A spirit in theory could become not utterly useless with some skilled manipulation, but pretty much anyone with a lasgun will not be threatened.
			health += 20
			if(health < maxHealth) //Some recovery from any damage, too.
				health += min((maxHealth-health), 5)
			melee_damage_lower += 3
			melee_damage_upper += 6
			energy += 1
		else
			src << "\red This corpse is a husk."

/mob/living/simple_animal/hostile/dark_ghost/verb/spectre() //Lets them expend some energy to make use of their part-ghost nature. This will let one of these spirits do well with allying themselves to one of the living or some such.
	set category = "Ghost"
	set name = "Spectral Motion"
	set desc = "Warp your semi-corporeal body to defy the laws of physics and pass through all other objects."

	if(phased) return

	if(!energy)
		src << "\red You do not have the strength to exert such control over your material form!"
	else
		src << "\red You move around other objects as if fully a spirit."
		energy -= 1
		src.incorporeal_move = 1
		phased = 1
		var/old_melee_damage_lower = melee_damage_lower
		var/old_melee_damage_upper = melee_damage_upper
		melee_damage_lower = 0
		melee_damage_upper = 0
		spawn(40)
			melee_damage_lower = old_melee_damage_lower //Restores attack damage.
			melee_damage_upper = old_melee_damage_upper
			src.incorporeal_move = 0
			phased = 0
			src << "\red You are no longer incorporeal."

/mob/living/simple_animal/hostile/dark_ghost/bullet_act(var/obj/item/projectile/Proj)
	if(phased)
		return
	..(Proj)

/mob/living/simple_animal/hostile/dark_ghost/adjustBruteLoss(damage)
	if(phased)
		return
	..(damage)

/mob/living/simple_animal/hostile/dark_ghost/Die()
	src.visible_message("\red [src] dissolves into nothingness with a growl.","\red Your physical form is undone.","\red You hear an anguished growl!")
	src.ghostize(0)
	qdel(src)