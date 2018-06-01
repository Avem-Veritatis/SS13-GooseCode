/*
Some warp effects in the ghost layer and just generally things pertaining to the empyrean.
Hm, what if there was a tyranid shadow in the warp effect? Just a shadow graphic with ghost density.
Eventually I want to bring psykers into this and complexify it a bit.
For now, I suppose there will be naturally occuring portals into the deep warp, and naturally occruing poltergeist daemons.
-Drake
*/

/obj/effect/warp
	layer = 4.0
	invisibility = INVISIBILITY_OBSERVER
	density = 0
	anchored = 1
	var/ghost_density = 0

/obj/effect/warp/overlay //If the animation lags it I will take this out. //Cool it doesn't seem to have ever made lag. I guess a static animation is a lot more client side anyway so it never could have made lag.
	name = "warp currents"
	desc = "Swirling warp energies."
	icon = 'icons/obj/narsie.dmi'
	icon_state = "ws2"

/obj/effect/warp/falsewall //Use this to cover up a few things from ghosts...
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	icon = 'icons/turf/walls.dmi'
	icon_state = "polar0"
	layer = 15

/obj/effect/warp/overlay/transit //Could be interesting if I made some transit systems use warp travel. I would sort of like to put that in for the movable turf ships.
	layer = 4.0
	invisibility = 0
	pixel_x = -89
	pixel_y = -85

/obj/effect/warp/wall
	name = "psychic barrier"
	desc = "An immaterial barrier that blocks fully immaterial entities."
	icon = 'icons/obj/magic.dmi'
	icon_state = "1"
	ghost_density = 1
	alpha = 40

/obj/effect/warp/shadow //Eventually I can put this as something for tyranids.
	name = "warp shadow"
	desc = "A dark spot in the warp."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "warpshadow"
	ghost_density = 1
	pixel_x = -32
	pixel_y = -32
	layer = 15 //Above EVERYTHING

//Sadly, area Entered() and Exited() procs aren't working for this.

/area/warp
	name = "Deep Warp"
	requires_power = 1
	always_unpowered = 1
	lighting_use_dynamic = 0
	power_light = 0
	power_equip = 0
	power_environ = 0

/turf/simulated/floor/plating/wasteland
	name = "floor"
	icon = 'icons/turf/floorsmigrated.dmi'
	icon_state = "wasteland1"

/turf/simulated/floor/plating/wasteland/ex_act(severity)
	return

/turf/simulated/floor/plating/wasteland/New()
	..()
	icon_state = "wasteland[rand(1, 31)]"

/mob/living/simple_animal/hostile/manifest_ghost
	name = "spirit"
	real_name = "spirit"
	desc = "The soul of one of the fallen manifested in the warp."
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost"
	icon_living = "ghost"
	icon_dead = "shade_dead"
	speak_emote = list("murmers","wails")
	emote_hear = list("wails","screeches")
	response_help  = "passes through"
	response_disarm = "passes through"
	response_harm   = "passes through"
	attacktext = "sucks life from"
	maxHealth = 80
	health = 80
	harm_intent_damage = 0
	melee_damage_lower = 20
	melee_damage_upper = 50
	speed = -1
	stop_automated_movement = 1
	friendly = "passes through"

/mob/living/simple_animal/hostile/manifest_ghost/Life() //They need to be able to still see warp things.
	..()
	see_invisible = SEE_INVISIBLE_OBSERVER
	verbs.Remove(/mob/living/verb/ghost) //How can a ghost ghost?

/mob/living/simple_animal/hostile/manifest_ghost/Move(NewLoc, direct) //Warp walls block manifest ghosts, even if they are material.
	var/turf/destination = get_step(get_turf(src),direct)
	for(var/obj/effect/warp/W in range(destination, 0))
		if(W.ghost_density)
			dir = direct //Need to do that if we are just returning right here.
			return
	..(NewLoc, direct)

/mob/living/simple_animal/hostile/manifest_ghost/New(loc, ghost)
	..(loc)
	var/mob/dead/observer/O = ghost
	src.fealty = O.master
	src.icon = O.icon
	src.icon_state = O.icon_state
	src.icon_living = O.icon_state
	src.name = O.name
	src.real_name = O.name
	src.key = O.key
	if(istype(O, /mob/dead/observer/cursed))
		src.health += 80 //Increases the strength of the spirit. They may be trapped in that form, but in the least they share a connection to the warp.
		src.maxHealth += 80

/mob/living/simple_animal/hostile/manifest_ghost/Die()
	src << "\red Your manifest spirit in the warp is dispelled from this location."
	enter_warp(src.ghostize(0))
	del(src)

/mob/living/simple_animal/hostile/manifest_ghost/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/retaliate/daemon)) //Even lesser daemonic beings are well suited to preying on the spirits of dead. The soul of a fallen should not be able to defeat an ebon geist.
			damage *= 5
		adjustBruteLoss(damage)

proc/enter_warp(var/atom/movable/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/oldalpha = H.alpha
		H.alpha = 0
		H.canmove = 0
		anim(get_turf(H),H,'icons/mob/mob.dmi',,"liquify",,H.dir)
		sleep(14)
		H.alpha = oldalpha
		H.canmove = 1
	var/list/destinations = list()
	for(var/turf/simulated/floor/plating/wasteland/T in world)
		destinations.Add(T)
	if(M && M.loc)
		M.loc = pick(destinations)
	else
		if(usr)
			usr << "\red Stop breaking shit!"

proc/warp_blast(var/atom/target)
	var/turf/T = get_turf(target)
	spawn(0)
		anim(T , T, 'icons/obj/narsie.dmi', "ws1", sleeptime = 40, direction = null, offset_x = -89, offset_y = -85)
	spawn(0)
		for(var/stage = 1, stage<=8, stage++) //About four daemons will come through.
			sleep(5)
			if(prob(10))
				new /mob/living/simple_animal/hostile/retaliate/daemon/poltergeist(T)
			if(prob(2))
				new /mob/living/simple_animal/hostile/retaliate/daemon/lesser/predator(T)
			if(prob(2))
				new /mob/living/simple_animal/hostile/retaliate/daemon/lesser(T)
			for(var/mob/living/M in range(5, T))
				if(!istype(M, /mob/living/simple_animal/hostile/retaliate/daemon) && M.alpha != 0)
					if(ishuman(M))
						var/mob/living/carbon/human/H = M
						if(H.berserk)
							continue //Doesn't send chaos spawns into the warp, that would be no fun.
					if(prob(80))
						M.visible_message("\red [M] is dragged into the warp!")
						enter_warp(M)
					else if(prob(50))
						if(ishuman(M))
							var/mob/living/carbon/human/H = M
							H.make_chaos_spawn()
					else if(prob(15))
						M.Weaken(10)
						step_away(M,T,15)
						step_away(M,T,15)
						step_away(M,T,15)
					else if(prob(15))
						M.adjustCloneLoss(15)
						M.adjustBrainLoss(35)
					else if(prob(15))
						M.take_organ_damage(20, 20)
					else if(prob(15))
						M.dust()
					else if(prob(15))
						M.gib()
			for(var/obj/O in range(5, T)) //Drags nearby objects into the warp as well.
				if(prob(20))
					enter_warp(O)

//TODO: warp mind map