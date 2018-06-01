/*
A slaanesh artifact. Much like a daemon weapon, but this one takes the souls of those it kills inside of itself, not a daemon.
*/

/datum/artifact_effect/captured_soul
	name = "Captured Soul"
	desc = "The soul of some poor person trapped inside of an object, their psychic energy fueling whatever contraption they are forced into."
	charge = 0
	max_uses = -1
	uses = 1
	trigger = "EQUIP"
	compatible_mobs = list(/mob/living/carbon)
	var/datum/artifact_power/artifact_power //Gives a new verb to the user and/or captured soul.
	var/datum/passive_effect/passive_effect //Gives a passive effect that improves the blade or the bearer.
	var/mob/living/carbon/target
	var/mob/living/carbon/victim
	var/mob/living/simple_animal/shade/spirit
	var/obj/item/myitem
	artifact_act(var/mob/living/M)
		if(!M) return
		if(target != M)
			artifact_power.init_mob(M)
			src.target = M
			spirit << "\red <b>The new bearer of your spirit is [M]!</b>"
	artifact_init(var/obj/item/O)
		..()
		myitem = O
		var/active_path = pick(/datum/artifact_power/phase,/datum/artifact_power/dodge,/datum/artifact_power/tele,/datum/artifact_power/shield)
		artifact_power = new active_path
		var/passive_path = pick(/datum/passive_effect/unstunnable,/datum/passive_effect/regen,/datum/passive_effect/immunity,/datum/passive_effect/speed)
		passive_effect = new passive_path
		artifact_power.init(O)
		spirit = new /mob/living/simple_animal/shade(O.loc)
		spirit.loc = O //put shade in object
		spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
		spirit.canmove = 0//Can't move out of the object
		spirit.artifact = O
		spirit.name = victim.real_name
		spirit.real_name = victim.real_name
		spirit.key = victim.key
		victim.drop_item()
		if(myitem.loc == victim) //Don't want to delete oneself because the victim is holding the blade (in the event of suicide when they have over 100 health and don't immediately fall down dead)
			myitem.loc = get_turf(victim)
		victim.dust()
		spirit.verbs.Add(/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer,/mob/living/simple_animal/shade/proc/telepathic_shout,/mob/living/simple_animal/shade/proc/throw_artifact,/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer,/mob/living/simple_animal/shade/proc/energize_weapon)
		spawn()
			src.passive()
	proc/passive()
		set background = BACKGROUND_ENABLED
		while(1)
			sleep(20)
			if(target)
				passive_effect.runmob(src.target)

/obj/item/weapon/slaanesh_blade
	name = "bliss razor" //Temporary name. They will get to rename it.
	desc = "A wickedly curved, jet black blade stained a deep royal purple. This blade hums and pulses with unearthly energies and bears a cetain inexplicable beauty and allure."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "slaanesh"
	item_state = "pk_on"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 25 //A decent melee weapon, but not exactly spectacular. Gets better when it hosts more souls, et cetera.
	throwforce = 40 //I don't know why all the weapons in this game have such low throwing force. You are literally throwing a supernaturally enhanced dagger at someone. That should actually injure them.
	w_class = 2 //Dagger. One of the advantages of the slaaneshi weapon.
	attack_verb = list("slashed", "mutilated", "eviscerated", "torn", "ripped", "diced", "mauled", "impaled", "tortured")
	var/energy = 250 //How much force the blade has to bind the captured souls to the bearer's will. This can be renewed, but rebellious souls will constantly eat away at it. Eventually they will have full power to kill their bearer.

/obj/item/weapon/slaanesh_blade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src.name]! It looks like \he's trying to commit suicide.</span>")
	user << "\red You hear the sound of laughter in your mind as darkness overtakes your consciousness."
	user.sleeping += 25 //Just making sure they pass out. By the time the slaaneshi gets the blade, they will probably not die from falling on their sword.
	spawn(100)
		user.visible_message("<span class='suicide'>You hear a hissing sound as a wave of exquisite pain washes over you.</span>") //Spooky slaaneshi shit.
		user << "\red Your essence is consumed by [src]!" //If someone willingly sacrifices themselves with the blade, it becomes even more powerful than if you forcibly captured their soul.
		src.force += 20
		src.throwforce += 20
		src.energy = 0 //Not much sorcery demanding a master's allegiance after the master kills themself. Then the blade is just free.
		src.absorb_soul(null, user)
	return(BRUTELOSS)

/obj/item/weapon/slaanesh_blade/attack(target as mob, mob/living/user as mob)
	if(istype(target,/mob/living/carbon))
		var/mob/living/carbon/C = target
		if(C == user)
			user.visible_message("\red [user] slits their wrist with [src]!", \
	"\red You draw your own blood to strengthen the sorcery in [src], bringing the inhabitant spirits under greater control.", \
	"\red You hear a hissing sound.")
			energy += 60
			force += 1.0
			throwforce += 1.0
			user.take_organ_damage(25,0)
			return
		if(C.stat == 2)
			if(C.client)
				user << "\red [src] greedily absorbs [C]'s essence!"
				user << "\red [src] seems to hum with energy as [C]'s torment is soaked up by the blade!"
			src.absorb_soul(user, C)
			playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
		else
			if(prob(src.artifact_effects.len*30))
				user << "\red [src] overloads [C]'s senses and casts them into a breif coma."
				C.sleeping += 10
	else if(istype(target,/mob/living/simple_animal)) //Still gibs animals, but gets less power from them.
		var/mob/living/simple_animal/A = target
		if(A.stat == 2)
			user << "\red [src] accepts your sacrifice."
			user << "\red [src] seems slightly energized."
			src.force += 3.0
			src.throwforce += 5.0
			A.gib()
			playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/slaanesh_blade/throw_impact(atom/hit_atom)
	..()
	if(isliving(hit_atom))
		var/mob/living/vict = hit_atom
		vict.visible_message("\red [src] swings in midair as if it had a mind of its own, pointing like a compass needle to [hit_atom]'s heart as its point slashes them!", \
	"\red You feel a stabbing pain in your chest as [src] drives itself towards your heart!", \
	"\red You hear the sound of steel slicing through flesh.")
		if(iscarbon(vict) && vict.stat == 2)
			src.absorb_soul(null, vict)

/obj/item/weapon/slaanesh_blade/proc/absorb_soul(var/mob/living/carbon/user, var/mob/living/carbon/C)
	if(!C.client)
		if(user)
			user << "\red This one's soul is not present. Sacrifice failed."
		return //No absorbing AFK people.
	var/datum/artifact_effect/captured_soul/soul = new()
	soul.victim = C
	soul.artifact_init(src)
	soul.artifact_act(user)
	src.force += 10.0
	src.throwforce += 10.0