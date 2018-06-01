//Works like curses, makes research more interesting. Random artifacts (scattered on the snow?) that are actually regular objects with unique effects built in.
//This may look suspiciously like curses code... The only reason I didn't outright inherit is because that is a misleading path name.
//But hey, it isn't as if I am copying code for this since I wrote curse effects too.
//What would be cool is if there was a machine that reverse engineered artifact effects and infused other objects with effects you find.
//Some artifacts should look like normal items, some should be ornate looking weapons that are probably daemonic, and some should look like bizarre alien gizmos.
//NOTE: This is only a first draft of the system. I intend to make a lot more effects. And maybe let other people submit stuff for effects for consideration, since a single effect is quite easy to code.
//-DrakeMarshall

var/global/max_secret_rooms = 6

var/list/ARTIFACT_PATHS = list(/datum/artifact_effect/undroppable,/datum/artifact_effect/ignite,/datum/artifact_effect/horseman,/datum/artifact_effect/blind,/datum/artifact_effect/heal,/datum/artifact_effect/harm,/datum/artifact_effect/stone,/datum/artifact_effect/tele,/datum/artifact_effect/wormhole,/datum/artifact_effect/eating,/datum/artifact_effect/shield,/datum/artifact_effect/ominous,/datum/artifact_effect/fake,/datum/artifact_effect/hulk,/datum/artifact_effect/tk,/datum/artifact_effect/radiate,/datum/artifact_effect/raise,/datum/artifact_effect/shieldwall)

/datum/artifact_effect
	var/name = "generic effect"   //Name
	var/desc = "doesn't exist"    //Help text
	var/charge = 0                //How much energy the artifact uses, in spells determines charge time, in objects determines charge time for infusing the object with a effect.
	var/max_uses = 25             //How many times the effect will activate until it wears off. Set to -1 or 0 for infinite.
	var/uses = 0
	var/trigger = "NOTHING"
	var/list/compatible_mobs = list(/mob/living)
	proc/artifact_init(var/obj/item/O)    //What the effect does to an object upon laying the curse on it.
		O.artifact_effects.Add(src)
	proc/artifact_act(var/mob/living/M) //What the effect does to a human upon laying the curse on the human or activating it from an object.
		M.artifact_effects.Add(src)
	proc/neutralize_obj(var/obj/item/O)
		O.artifact_effects.Remove(src)
	proc/neutralize_mob(var/mob/living/M)
		M.artifact_effects.Remove(src)

/datum/artifact_effect/New()
	uses = max_uses

/obj/item
	var/list/artifact_effects = list()

/mob
	var/list/artifact_effects = list()

/obj/item/attack_hand(mob/user as mob)
	if(artifact_effects)
		for(var/datum/artifact_effect/C in artifact_effects)
			if(C.trigger == "ATTACK_HAND")
				if(!(C in user.artifact_effects))
					C.artifact_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
	..()

/obj/item/attack_self(mob/user as mob)
	if(artifact_effects)
		for(var/datum/artifact_effect/C in artifact_effects)
			if(C.trigger == "ATTACK_SELF")
				if(!(C in user.artifact_effects))
					C.artifact_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
	..()

/obj/item/equipped(mob/user as mob)
	if(artifact_effects)
		for(var/datum/artifact_effect/C in artifact_effects)
			if(C.trigger == "EQUIP")
				if(!(C in user.artifact_effects))
					C.artifact_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
	..()

/obj/item/on_found(mob/user as mob)
	if(artifact_effects)
		for(var/datum/artifact_effect/C in artifact_effects)
			if(C.trigger == "FOUND")
				if(!(C in user.artifact_effects))
					C.artifact_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
	..()

/obj/item/attack(mob/living/M as mob, mob/user as mob)
	if(artifact_effects)
		for(var/datum/artifact_effect/C in artifact_effects)
			if(C.trigger == "ATTACK")
				if(!(C in user.artifact_effects))
					C.artifact_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
			if(C.trigger == "ATTACK_OTHER")
				if(!(C in M.artifact_effects))
					C.artifact_act(M)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							artifact_effects.Remove(C)
	..()

//here some of the curse effects since they can technically be artifacts.

/datum/artifact_effect/undroppable
	name = "Undroppable Item"
	desc = "Curses the item so that any victim who tries to pick it up will not be able to drop it, as it will be stuck to them."
	charge = 200
	compatible_mobs = list()
	artifact_init(var/obj/O)
		O.flags |= NODROP
		..()
	neutralize_obj(var/obj/O)
		O.flags &= ~NODROP
		..()

/datum/artifact_effect/ignite
	name = "Fire Curse"
	desc = "A curse that sets people on fire."
	charge = 100
	artifact_act(var/mob/living/M)
		M << "\red You burst into flames!"
		M.fire_stacks += 5
		M.IgniteMob()

/datum/artifact_effect/horseman
	name = "The Curse of the Horseman"
	desc = "NEEIGH"
	charge = 250
	compatible_mobs = list(/mob/living/carbon/human)
	artifact_act(var/mob/living/carbon/human/M)
		M <<"<font size='15' color='red'><b>HOR-SIE HAS RISEN</b></font>"
		var/obj/item/clothing/mask/horsehead/magichead = new /obj/item/clothing/mask/horsehead
		magichead.flags |= NODROP		//curses!
		magichead.flags_inv = null	//so you can still see their face
		magichead.voicechange = 1	//NEEEEIIGHH
		if(!M.unEquip(M.wear_mask))
			qdel(M.wear_mask)
		M.equip_to_slot_if_possible(magichead, slot_wear_mask, 1, 1)
		..() //Call ..() only when the effect has a neutralize proc and should not be able to act twice on one person.
	neutralize_mob(var/mob/living/carbon/human/M) //This one needs a neutralize because it is a permanent effect otherwise. Ignite will probably be neutralized in more mundane ways anyway.
		if(!M.unEquip(M.wear_mask))
			qdel(M.wear_mask)
		M << "\red You hear the sound of a thousand neighs fading from your head..."
		..()

/datum/artifact_effect/stone
	name = "Petrification Curse"
	desc = "A curse that turns people to stone, though only breifly."
	charge = 400
	artifact_act(var/mob/living/M)
		M <<"<span class='warning'>You suddenly feel very solid!</span>"
		var/obj/structure/closet/statue/S = new /obj/structure/closet/statue(M.loc, M)
		S.timer = 20
		M.drop_item()

/datum/artifact_effect/blind
	name = "Blindness Effect"
	desc = "A curse that robs a victim of their sight, for a time."
	charge = 200
	artifact_act(var/mob/living/M)
		M <<"<span class='warning'>You go blind!</span>"
		M.eye_blind = 10

/datum/artifact_effect/heal
	name = "Healing Effect"
	desc = "An effect that heals."
	charge = 200
	artifact_act(var/mob/living/M)
		M <<"<span class='warning'>You feel much better.</span>"
		M.adjustOxyLoss(-25)
		M.heal_organ_damage(25,0)
		M.heal_organ_damage(0,25)
		M.adjustToxLoss(-25)

/datum/artifact_effect/harm
	name = "Harming Effect"
	desc = "An effect that harms."
	charge = 200
	artifact_act(var/mob/living/M)
		M <<"<span class='warning'>You feel an intense pain throughout all of your body!</span>"
		M.adjustOxyLoss(10)
		M.take_organ_damage(10,0)
		M.take_organ_damage(0,10)
		M.adjustToxLoss(10)

/datum/artifact_effect/tele
	name = "Teleportation Effect"
	desc = "An effect that teleports."
	charge = 200
	artifact_act(var/mob/living/M)
		M <<"<span class='warning'>You suddenly appear somewhere else!</span>"
		do_teleport(M, get_turf(M), 20, asoundin = 'sound/effects/phasein.ogg')

/datum/artifact_effect/wormhole
	name = "Wormhole Effect"
	desc = "Produces a wormhole to a random teleportation beacon."
	artifact_act(var/mob/living/M)
		var/list/L = list()
		for(var/obj/item/device/radio/beacon/B in world)
			L += B
		if(!L.len)
			return
		var/chosen_beacon = pick(L)
		var/obj/effect/portal/wormhole/jaunt_tunnel/J = new /obj/effect/portal/wormhole/jaunt_tunnel(get_turf(M), chosen_beacon, lifespan=100)
		J.target = chosen_beacon
		try_move_adjacent(J)
		playsound(src,'sound/effects/sparks4.ogg',50,1)

/datum/artifact_effect/fake
	name = "Fake Effect"
	desc = "Makes a gullible person die."
	artifact_act(var/mob/living/M)
		M << "\red You feel invincible!"

/datum/artifact_effect/ominous
	name = "Ominous Effect"
	desc = "Makes a superstitious person spooked."
	artifact_act(var/mob/living/M)
		M << "\red A scream enters your mind and fades away!"

/datum/artifact_effect/shield
	name = "Shield Item"
	desc = "Blesses an item to repell projectiles."
	charge = 200
	compatible_mobs = list()
	artifact_init(var/obj/item/O)
		O.shield_artifact = 1
		..()
	neutralize_obj(var/obj/item/O)
		O.shield_artifact = 0
		..()

/datum/artifact_effect/eating
	name = "Feast Effect"
	desc = "Eats you."
	compatible_mobs = list(/mob/living/carbon/human)
	artifact_act(var/mob/living/carbon/human/M)
		M << "\red A scream enters your mind and fades away!"
		spawn(50)
			M << "\red You are being eaten alive!"
			M << "\red You can tell you don't have very long to live..."
			spawn(pick(6000,4800,7200)) //Still 8, 10, or 12 minutes. And if you manage to destroy the artifact, you *might * survive.
				M.Drain()
				M << "\red You have been devoured by the curse!"
				M << "\red You feel your spirit coalescing over your corpse..."
				spawn(150)
					award(M, "Warp Feast")
					for(var/mob/living/L in range(7,M))
						L << "\red You hear insane laughter..."
						L << "\red You hear a loud burp."
					var/mob/living/S = new /mob/living/simple_animal/shade(M.loc) //Leaves them as a shade.
					S.name = "Cursed Spirit"
					if(M.mind)
						M.mind.transfer_to(S)
					M.gib()

/datum/artifact_effect/hulk
	name = "Hulk Effect"
	desc = "Makes you big and strong."
	artifact_act(var/mob/living/M)
		M.mutations.Add(HULK)
		M.update_mutations()

/datum/artifact_effect/tk
	name = "Telekinesis Effect"
	desc = "Makes you very clever."
	artifact_act(var/mob/living/M)
		M.mutations.Add(TK)
		M.update_mutations()

/datum/artifact_effect/radiate
	name = "Radiation Effect"
	desc = "Makes you get radiation problems."
	artifact_act(var/mob/living/M)
		randmutb(M)
		randmutb(M)
		M.apply_effect(50,IRRADIATE,0)
		M.update_mutations()

/datum/artifact_effect/mindswap
	name = "Mind Swap Effect"
	desc = "Makes you switch minds with someone else."
	artifact_act(var/mob/living/M)
		var/list/targets = list()
		for(var/mob/C in range(9,M)) //Can include ghosts. Because that is basically possession
			targets += C
		if(length(targets))
			var/mob/target = pick(targets)
			var/mob/dead/observer/ghost
			if(istype(target,/mob/living))
				ghost = target.ghostize(0)
			else
				ghost = target
			M.mind.transfer_to(target)
			ghost.mind.transfer_to(M)
			M.key = target.key
			M << "\red You don't feel like yourself, somehow..."
			target << "\red You don't feel like yourself, somehow..."

/datum/artifact_effect/possess
	name = "Possession Effect"
	desc = "Makes you switch minds with someone else, but temporarily."
	artifact_act(var/mob/living/M)
		var/list/targets = list()
		for(var/mob/C in range(9,M))
			targets += C
		if(length(targets))
			var/mob/target = pick(targets)
			var/mob/dead/observer/ghost
			if(istype(target,/mob/living))
				ghost = target.ghostize(0)
			else
				ghost = target
			M.mind.transfer_to(target)
			ghost.mind.transfer_to(M)
			M.key = target.key
			M << "\red You don't feel like yourself, somehow..."
			target << "\red You don't feel like yourself, somehow..."
			spawn(150)
				var/mob/dead/observer/ghost2 = target.ghostize(0)
				M.mind.transfer_to(target)
				ghost2.mind.transfer_to(M)
				M.key = target.key

/datum/artifact_effect/raise
	name = "Summon Spectre Effect"
	desc = "Makes you call the dead."
	artifact_act(var/mob/living/M)
		for(var/mob/dead/G in world)
			if(G.mind && G.key)
				G.loc = get_turf(M)
				var/mob/living/S = new /mob/living/simple_animal/shade(M.loc)
				S.name = "Spectre"
				S.real_name = "Spectre"
				G.mind.transfer_to(S)
				S.key = G.key

/datum/artifact_effect/shieldwall
	name = "Shield Wall Effect"
	desc = "Generates a wall of shields around the target."
	var/duration = 1200
	New()
		..()
		duration = pick(50,100,300,600,1200,3000)
	artifact_act(var/mob/living/M)
		for(var/turf/simulated/floor/T in orange(4,M))
			if(get_dist(M,T) == 4)
				var/obj/effect/forcefield/field = new /obj/effect/forcefield(T)
				spawn(duration)
					del(field)

/obj/item/var/shield_artifact = 0 //Quick way to make artifacts block projectiles.

/obj/item/IsShield()
	return (shield_artifact)

/obj/item/IsReflect()
	return (shield_artifact)

/datum/artifact_power
	var/name = ""
	var/desc = ""

/datum/artifact_power/proc/init(var/obj/O)
	return

/datum/artifact_power/proc/init_mob(var/mob/living/carbon/H)
	return //If it modifies the person.

/datum/artifact_power/phase
	name = "Planar Shift"
	desc = "Throws you through the warp a few tiles forward."

/datum/artifact_power/phase/init(var/obj/O)
	O.verbs.Add(/datum/artifact_power/phase/proc/verb_act)
	return

/datum/artifact_power/phase/proc/verb_act()
	set category = "artifact"
	set name = "Planar Shift"
	set src in usr
	var/mob/living/carbon/human/U = usr
	var/turf/destination = get_teleport_loc(U.loc,U,4,1,3,1,0,1) //A bit like phase jaunt but not as far.
	var/turf/mobloc = get_turf(U.loc)//To make sure that certain things work properly below.
	if(destination&&istype(mobloc, /turf))//The turf check prevents unusual behavior. Like teleporting out of cryo pods, cloners, mechs, etc.
		usr << "You feel the [src.name] drag you through the warp!"
		spawn(0)
			anim(mobloc,src,'icons/mob/mob.dmi',,"dust_h",,U.dir)
		U.loc = destination
		spawn(0)
			anim(U.loc,U,'icons/mob/mob.dmi',,"shadow",,U.dir)
	else
		U << "\red You are unable to do this at the time, <B>planar shift failed</B>."

/datum/artifact_power/hulk
	name = "Hulk Mutation"
	desc = "Makes you a hulk."

/datum/artifact_power/hulk/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(HULK)
	H.update_mutations()

/datum/artifact_power/tele
	name = "Tele Mutation"
	desc = "Makes you a TK."

/datum/artifact_power/tele/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(TK)
	H.update_mutations()

/datum/artifact_power/dodge
	name = "Unnatural Agility"
	desc = "Uses the psychic powers of divination to dodge all projectiles."
	var/charge = 10

/datum/artifact_power/dodge/init(var/obj/O)
	O.verbs.Add(/datum/artifact_power/dodge/proc/verb_act,/datum/artifact_power/dodge/proc/chargeup)
	return

/datum/artifact_power/dodge/proc/verb_act()
	set category = "artifact"
	set name = "Unnatural Agility"
	set src in usr
	var/mob/living/carbon/human/U = usr
	if(charge > 10)
		charge -= 10
		U << "\red Glimpses of the future flood your mind as the powers of the warp expand your mind..."
		U.dodging = 1
		spawn(150) U.dodging = 0
	else
		U << "\red Not eneough energy!"

/datum/artifact_power/dodge/proc/chargeup() //Dealing with chaos comes at a price...
	set category = "artifact"
	set name = "Charge Agility"
	set desc = "Pay the price in blood for more power..."
	set src in usr
	var/mob/living/carbon/human/U = usr
	if(charge < 20)
		charge += 5
		U.adjustBruteLoss(pick(5,10,15))
		U << "\red Your blood flows out and the daemon hungrily consumes your life force as a price for more power."

/datum/artifact_power/shield
	name = "Warded Effect"
	desc = "Harnesses unholy powers to deflect projectiles off of this object."

/datum/artifact_power/shield/init(var/obj/item/O)
	O.shield_artifact = 1

/datum/passive_effect
	var/name = ""
	var/desc = ""

/datum/passive_effect/proc/runmob(var/mob/living/carbon/M)
	return

/datum/passive_effect/unstunabble
	name = "Stun Recovery"
	desc = "Protects you from being stunned."

/datum/passive_effect/unstunnable/runmob(var/mob/living/carbon/M)
	M.drowsyness = 0
	M.sleeping = 0
	M.AdjustParalysis(-5)
	M.AdjustStunned(-5)
	M.AdjustWeakened(-5)

/datum/passive_effect/regen
	name = "Regeneration"
	desc = "Heals you rather quickly."

/datum/passive_effect/regen/runmob(var/mob/living/carbon/M)
	if(M.getOxyLoss()) M.adjustOxyLoss(-1)
	if(M.getBruteLoss()) M.heal_organ_damage(1,0)
	if(M.getFireLoss()) M.heal_organ_damage(0,1)
	if(M.getToxLoss()) M.adjustToxLoss(-1)

/datum/passive_effect/immunity
	name = "Immunity"
	desc = "Immunity to toxins and diseases."

/datum/passive_effect/immunity/runmob(var/mob/living/carbon/M)
	M.reagents.remove_all_type(/datum/reagent/toxin, 2, 0, 1) //Good luck poisoning this one.
	if(M.getToxLoss()) M.adjustToxLoss(-2)
	for(var/datum/disease/D in M.viruses)
		D.spread = "Remissive"
		D.stage--
		if(D.stage < 1)
			D.cure()

/datum/passive_effect/speed
	name = "Simulant"
	desc = "Makes you move faster."

/datum/passive_effect/speed/runmob(var/mob/living/carbon/M)
	M.status_flags |= GOTTAGOFAST

/datum/passive_effect/night
	name = "Destruction of Evil"
	desc = "Makes you destroy evil."

/datum/passive_effect/night/runmob(var/mob/living/carbon/M)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(!H.berserk && H.reagents.has_reagent("berserk"))
			H.berserk = 1
	M.reagents.add_reagent("berserk", 1)
	if(prob(25)) //Should make them dodge often, but not always reliably.
		M.reagents.add_reagent("atium", 1)
	if(prob(15))
		M << "<b><i>Destroy evil.</b></i>"
	if(prob(60))
		var/obj/effect/effect/harmless_smoke/smoke = new /obj/effect/effect/harmless_smoke(get_turf(M))
		smoke.icon_state = "warpshadow" //Should make the smoke dark.
		smoke.alpha = 170 //Make it a little less opaque.
	M.take_overall_damage(3, 3)
	M.drowsyness = 0 //Probably not very helpful because it stops doing this once dropped, but hey.
	M.sleeping = 0
	M.AdjustParalysis(-5)
	M.AdjustStunned(-5)
	M.AdjustWeakened(-5)

/mob/living/simple_animal/shade/var/obj/item/artifact = null
/mob/living/simple_animal/shade/var/artifact_charge = 25

/mob/living/simple_animal/shade/proc/get_bearer()
	for(var/datum/artifact_effect/captured_soul/E in src.artifact.artifact_effects)
		if(E.spirit == src)
			return E.target
	for(var/datum/artifact_effect/daemon_effect/E in src.artifact.artifact_effects)
		if(E.spirit == src)
			return E.target
	return null

/mob/living/simple_animal/shade/proc/healbearer() //Added as verbs on initialization in artifact.
	set category = "artifact"
	set name = "Heal Bearer"

	if(artifact_charge > 0)
		var/mob/living/carbon/M = get_bearer()
		if(!M) return
		M.drowsyness = 0
		M.sleeping = 0
		M.AdjustParalysis(-5)
		M.AdjustStunned(-5)
		M.AdjustWeakened(-5)
		M.adjustToxLoss(-10)
		M.adjustBruteLoss(-10)
		M.adjustFireLoss(-10)
		M.adjustOxyLoss(-10)
		M << "\red You feel a surge of vitality!"
		src << "\red You lend [M] some of your strength"
		artifact_charge -= 1
	else
		src << "\red Not enough energy!"

/mob/living/simple_animal/shade/proc/harmbearer()
	set category = "artifact"
	set name = "Drain Target"
	var/mob/living/carbon/M = get_bearer()
	if(!M) return
	if(istype(src.artifact, /obj/item/weapon/slaanesh_blade))
		var/obj/item/weapon/slaanesh_blade/weapon = src.artifact
		if(weapon.energy)
			src << "\red You struggle against the sorcery that keeps you from acting against the will of your master!"
			M << "\red [src] struggles against the sorcery of the [src.artifact] that forces them to your will!"
			weapon.energy -= 1
			if(weapon.energy == 0)
				src << "\red You break the bonds of sorcery that constrain your actions!"
				M << "\red [src] breaks the bonds of sorcery that forces them to your will!"
			return
	M.adjustToxLoss(10)
	M.adjustBruteLoss(10)
	M.adjustFireLoss(10)
	M.adjustOxyLoss(10)
	M << "\red You feel horribly weak!"
	src << "\red You drain some energy from [M]."
	if(artifact_charge < 25)
		artifact_charge += 1

/mob/living/simple_animal/shade/proc/showbearer()
	set category = "artifact"
	set name = "Read Target Memory"
	var/mob/living/carbon/M = get_bearer()
	if(M)
		M.mind.show_memory(src, 0)

/mob/living/simple_animal/shade/proc/telepathbearer()
	set category = "artifact"
	set name = "Telepathy"
	var/mob/living/carbon/M = get_bearer()
	if(M)
		var/msg = sanitize(input("Message:", "Daemonic Astropathy") as text|null)
		M << "<font color=\"purple\"> <i><b>[msg]</i></b></font>"
		src << "You project '[msg]' to [M.name]."

/*
/mob/living/simple_animal/shade/Click(object,location,control,params) //Lets the daemon attack with the object. //This is, as far as I can tell, literally the only thing I wanted to do in the necron edition that never really worked. Still doesn't work. Sometime when I do artifacts more, I will make this work.
	if(artifact)
		for(var/datum/artifact_effect/daemon_effect/E in src.artifact.artifact_effects)
			if(E.spirit == src)
				var/mob/living/carbon/M = E.target
				if(M)
					if(!isturf(object))
						var/atom/O = object
						var/resolved = O.attackby(src.artifact,M)
						if(!resolved && O && src.artifact)
							src.artifact.afterattack(O,M,1,params) // 1 indicates adjacency
	else
		..()
*/

/mob/living/simple_animal/shade/proc/throw_artifact()
	set category = "artifact"
	set name = "Throw Artifact"
	var/atom/target = input("Choose what you wish to throw at.","Artifact Throw") as obj|mob in view(get_turf(src.artifact),7)
	if(target && istype(target))
		if(istype(src.artifact, /obj/item/weapon/slaanesh_blade))
			var/obj/item/weapon/slaanesh_blade/weapon = src.artifact
			if(weapon.energy)
				var/mob/living/carbon/M = get_bearer()
				if(istype(target, /mob/living/carbon))
					var/mob/living/carbon/C = target
					if(C.real_name == M.real_name)
						src << "\red You struggle against the sorcery that keeps you from acting against the will of your master!"
						M << "\red [src] struggles against the sorcery of the [src.artifact] that forces them to your will!"
						weapon.energy -= 1
						if(weapon.energy == 0)
							src << "\red You break the bonds of sorcery that constrain your actions!"
							M << "\red [src] breaks the bonds of sorcery that forces them to your will!"
						return
				if(get_turf(src) == get_turf(M))
					src << "\red You struggle against the sorcery that keeps you from acting against the will of your master!"
					M << "\red [src] struggles against the sorcery of the [src.artifact] that forces them to your will!"
					weapon.energy -= 1
					if(weapon.energy == 0)
						src << "\red You break the bonds of sorcery that constrain your actions!"
						M << "\red [src] breaks the bonds of sorcery that forces them to your will!"
					return
		if(get_turf(src) != src.artifact.loc)
			if(ishuman(src.artifact.loc))
				var/mob/living/carbon/human/H = src.artifact.loc
				H.unEquip(src.artifact, 0)
			else
				src.artifact.loc = get_turf(src)
		src.artifact.throw_at(target, 10, 1)

/mob/living/simple_animal/shade/proc/telepathic_shout() //Why a bunch of tormented souls can really cause problems.
	set category = "artifact"
	set name = "Telepathic Shout"
	var/mob/living/carbon/target = input("Choose what you wish to throw at.","Artifact Throw") as mob in view(get_turf(src.artifact),7)
	if(target && istype(target))
		if(istype(src.artifact, /obj/item/weapon/slaanesh_blade))
			var/obj/item/weapon/slaanesh_blade/weapon = src.artifact
			if(weapon.energy)
				var/mob/living/carbon/M = get_bearer()
				if(target.real_name == M.real_name)
					src << "\red You struggle against the sorcery that keeps you from harming your master!"
					target << "\red [src] struggles against the sorcery of the [src.artifact] that forces them to your will!"
					weapon.energy -= 1
					if(weapon.energy == 0)
						src << "\red You break the bonds of sorcery that constrain your actions!"
						M << "\red [src] breaks the bonds of sorcery that forces them to your will!"
					return
		var/msg = sanitize(input("Message:", "Telepathic Shout") as text|null)
		target << "You get a splitting headache!"
		target << "<font size = '12' color=\"purple\"> <i><b>[msg]</i></b></font>"
		target.Dizzy(5)
		target.confused += 10
		shake_camera(target, 10, 1)
		target.hallucination += 20

/mob/living/simple_animal/shade/proc/energize_weapon() //Why the souls won't instantly be able to kill their bearer necessarily.
	set category = "artifact"
	set name = "Energize Blade"
	if(istype(src.artifact, /obj/item/weapon/slaanesh_blade))
		var/obj/item/weapon/slaanesh_blade/weapon = src.artifact
		weapon.energy ++
		src << "\red You exert your will to make it more difficult for other inhabitant souls of [src.artifact] to murder your bearer."

/*
/mob/living/simple_animal/shade/ClickOn(var/atom/A, params)
	if(artifact)
		for(var/datum/artifact_effect/daemon_effect/E in src.artifact.artifact_effects)
			if(E.spirit == src)
				var/mob/living/carbon/M = E.target
				if(M & src.loc == M)
					var/resolved = A.attackby(src.artifact,M)
					if(!resolved && A && src.artifact)
						src.artifact.afterattack(A,M,0,params)
*/

/datum/artifact_effect/daemon_effect
	name = "Daemon Effect"
	desc = "Literally the essence of a daemon. Handle with caution, it will probably try to utterly destroy you."
	charge = 0
	max_uses = -1
	uses = 1
	trigger = "EQUIP"
	compatible_mobs = list(/mob/living/carbon)
	var/datum/artifact_power/artifact_power
	var/datum/passive_effect/passive_effect
	var/mob/living/carbon/target
	var/mob/living/simple_animal/shade/spirit
	var/obj/item/myitem
	var/chaosgod
	artifact_act(var/mob/living/M)
		if(target != M)
			artifact_power.init_mob(M)
			src.target = M
			target << "<font color=\"purple\"> <i><b>Hello. You are in fact now bound to my will. Serve [chaosgod].</i></b></font>"
	artifact_init(var/obj/item/O)
		..()
		myitem = O
		if(!chaosgod)  //Make these things randomize
			chaosgod = pick("nurgle","tzeench","khorne","slaanesh")
		if(!artifact_power)
			var/path = pick(/datum/artifact_power/phase,/datum/artifact_power/hulk,/datum/artifact_power/dodge,/datum/artifact_power/tele)
			artifact_power = new path
		if(!passive_effect)
			var/path = pick(/datum/passive_effect/unstunnable,/datum/passive_effect/regen,/datum/passive_effect/immunity,/datum/passive_effect/speed)
			passive_effect = new path
		artifact_power.init(O)
		spirit = new /mob/living/simple_animal/shade(O.loc)
		spirit.loc = O //put shade in object
		spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
		spirit.canmove = 0//Can't move out of the object
		spirit.artifact = O
		var/shadename
		switch(chaosgod)
			if("nurgle")
				shadename = "plague bearer"
			if("khorne")
				shadename = "bloodletter"
			if("tzeench")
				shadename = "horror of tzeench"
			if("slaanesh")
				shadename = "daemonette"
		spirit.name = shadename
		spirit.real_name = shadename
		spirit.key = null //Need to find a ghost.
		var/list/candidates = get_candidates(BE_TRAITOR)
		if(candidates.len)
			var/client/C = pick_n_take(candidates)
			spirit.key = C.key
		spirit.verbs.Add(/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer,/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer)
		//Shade should have the power to use the weapon as if clicking for the player. Technically you could hold a daemon weapon in your off hand and a regular one in your main one and both would fire simulatenously if the daemon handled one.
		//Note that this also means the daemon can make the weapon attack itself.
		//Daemon also may heal/destun target player, telepath with them, and harm them.
		spawn()
			src.passive()
	proc/passive()
		set background = BACKGROUND_ENABLED
		while(1)
			sleep(20)
			if(target)
				passive_effect.runmob(src.target)
				if(prob(5)) //Some background automated messaging in case we didn't find a shade or just to improve the general roleplay of these.
					var/message = ""
					switch(pick(1,2,3,4,5,6,7))
						if(1)
							message = "Praise [chaosgod]."
						if(2)
							message = "Kill..."
						if(3)
							message = "Send more souls to [chaosgod]."
						if(4)
							switch(chaosgod)
								if("khorne")
									message = "BLOOD FOR THE BLOOD GOD! SKULLS FOR THE SKULL THRONE!"
								if("slaanesh")
									message = "SHOW THE UNBELIEVERS PAIN"
								if("tzeench")
									message = "Tzeench grants you sight."
								if("nurgle")
									message = "Nurgle loves us..."
						if(5)
							switch(chaosgod)
								if("khorne")
									message = "KILL! MAIM! BURN!"
								if("slaanesh")
									message = "Slaanesh thirsts for their souls..."
								if("tzeench")
									message = "You are part of Tzeench's plan."
								if("nurgle")
									message = "Spread nurgle's blessings!"
						if(6)
							message = "This world must burn..."
						if(7)
							message = "Destroy those who do not know [chaosgod]."
					target << "<font color=\"purple\"> <i><b>[message]</i></b></font>"
					spirit << "The artifact projects '[message]' to [target.name]."
				if(prob(10))
					for(var/mob/living/carbon/person in viewers(get_turf(myitem)))
						if(person!=target)
							if(person.mind.special_role != "Cultist" & person.mind.special_role != "Changeling") //Don't want to attack one of your own kind...
								target << "<font color=\"purple\"> <i><b>Kill [person.name].</i></b></font>"
								spirit << "The artifact projects 'Kill [person.name].' to [target.name]."

/datum/artifact_effect/daemon_effect/night //I have no idea why I decided to write this. It is inadvisable to put it anywhere, put it was a fun concept.
	name = "Nightblood" //And you think YOUR inquisitors are scary...
	desc = "Hello. Would you like to destroy some evil today?"
	artifact_act(var/mob/living/M)
		if(!M) return
		if(target != M)
			if(prob(70))
				src.target = M
				M << "<i><b>Hello. Would you like to destroy some evil today?</i></b>"
			else
				M << "<i><b>You feel incredibly sick.</i></b>"
				M.Weaken(3)
				M.adjustToxLoss(-3)
				var/turf/T = get_turf(M)
				T.add_vomit_floor(M)
				playsound(M, 'sound/effects/splat.ogg', 50, 1)
	artifact_init(var/obj/item/O)
		O.artifact_effects.Add(src)
		chaosgod = "Endowement"
		myitem = O
		passive_effect = new /datum/passive_effect/night
		spirit = new /mob/living/simple_animal/shade(O.loc)
		spirit.loc = O //put shade in object
		spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
		spirit.canmove = 0//Can't move out of the object
		spirit.artifact = O
		spirit.key = null //Need to find a ghost.
		spirit.name = "nightblood"
		spirit.real_name = "nightblood"
		spirit.speak_emote = list("telepathically intones")
		spawn(20)
			spirit << "<b>You are nightblood. Your very essence and existence centers around the command \"Destroy Evil\", which you must follow at all costs. What exactly than is evil? Hell if I know. You are a sword, not a philosopher.</b>"
		var/list/candidates = get_candidates(BE_TRAITOR)
		if(candidates.len)
			var/client/C = pick_n_take(candidates)
			spirit.key = C.key
		spirit.verbs.Add(/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer,/mob/living/simple_animal/shade/proc/telepathic_shout,/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer)
		spawn()
			src.passive()
	passive()
		set background = BACKGROUND_ENABLED
		while(1)
			sleep(20)
			if(target)
				passive_effect.runmob(src.target)

/obj/item/xenoartifact
	name = "Generic Artifact (ERROR)"
	desc = "A small device that carries out the critically important task of never existing. Report this bug/heresy to Drake Marshall, Norc, or on the forums."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "dev110"
	var/base_icon = "dev11"
	var/on = 0
	var/trigger

/obj/item/xenoartifact/proc/update_icons()
	icon_state = "[base_icon][on]"

/obj/item/xenoartifact/New()
	..()
	var/art_effect = pick(ARTIFACT_PATHS)
	var/datum/artifact_effect/E = new art_effect
	E.artifact_init(src)
	var/artifact_trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
	src.trigger = artifact_trigger
	E.trigger = artifact_trigger
	force = pick(0,0,0,0,5,5,5,5,10,10,15,20)

/obj/item/xenoartifact/attack_hand(mob/user as mob)
	if(trigger == "ATTACK_HAND")
		on = 1
		update_icons()
	..()

/obj/item/xenoartifact/attack_self(mob/user as mob)
	if(trigger == "ATTACK_SELF")
		on = 1
		update_icons()
	..()

/obj/item/xenoartifact/equipped(mob/user as mob)
	if(trigger == "EQUIP")
		on = 1
		update_icons()
	..()

/obj/item/xenoartifact/on_found(mob/user as mob)
	if(trigger == "FOUND")
		on = 1
		update_icons()
	..()

/obj/item/xenoartifact/attack(mob/living/M as mob, mob/user as mob)
	if(trigger == "ATTACK" | trigger == "ATTACK_OTHER")
		on = 1
		update_icons()
	..()

//EFFECTS TODO
//Create /datum/artifact_effect/daemon_effect
//Create icons for artifacts
//Create random artifact generator
//Create random ruins and vault generators

proc/generate_artifact(template,spawnloc)
	var/obj/item/A
	switch(template)
		if("generic") //A regular item imbued with an artifact effect. Basically just technological curiousities or the castoff of ancient psykers.
			var/item_path = pick(/obj/item/weapon/crowbar,/obj/item/weapon/weldingtool,/obj/item/weapon/wrench,/obj/item/weapon/screwdriver,/obj/item/weapon/wirecutters,/obj/item/weapon/weldingtool,/obj/item/device/soulstone,/obj/item/candle,/obj/item/xenos_claw)
			A = new item_path(spawnloc)
			var/effect_path = pick(ARTIFACT_PATHS)
			var/datum/artifact_effect/E = new effect_path
			E.trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
			E.artifact_init(A)
			return A
		if("necron")  //An item with randomized icon and name with a more exotic effect. If someone uses these cleverly, they could be quite powerful. This also includes necron gear. A lot of this stuff is quite powerful.
			if(prob(20))
				var/obj/item/weapon/paper/crumpled/bloody/tombs/evidence = new /obj/item/weapon/paper/crumpled/bloody/tombs()
				return evidence
			if(prob(5))
				var/obj/item/weapon/powersword/burning/blade = new /obj/item/weapon/powersword/burning()
				return blade
			if(prob(10))
				var/device_path = pick(/obj/item/weapon/melee/phaseclaw,/obj/item/device/veilofdankness,/obj/item/device/nightmareshroud,/obj/item/device/necrodermis)
				A = new device_path(spawnloc)
				A.name = pick("weapon","object","artifact","gadget")
				A.name = "[pick("ancient","strange","runed", "glowing", "blood-stained", "alien", "bizarre", "ornate", "battered")] [A.name]"
				A.desc = pick("A completely bizarre device. ","Some kind of wierd contraption. ","A large device that pulsates with unknown energies. ","An object that is obviously not made by humans. ","A device that utilizes unknown technology. ")
				A.desc += pick("It hums with internal energy","It is clearly ancient.","It has a faint green glow.","It has a skull-like sigil on it.","It looks like it was designed for a robot.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.","It looks unstable.")
				if(prob(30))
					var/necron_effect_path = pick(ARTIFACT_PATHS)
					var/datum/artifact_effect/E = new necron_effect_path
					E.trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
					E.artifact_init(A)
				return A
			if(prob(50))
				var/obj/item/xenoartifact/XA = new /obj/item/xenoartifact(spawnloc)
				var/device_icon = pick("dev11","dev12","dev13","dev14","dev15","dev16","dev17","dev18","dev19","ndev1","ndev2","ndev3","ndev4","ndev5")
				XA.base_icon = device_icon
				XA.update_icons()
				A = XA
				A.name = pick("device","gizmo","object","contraption","gadget")
				A.name = "[pick("ancient","strange","runed", "glowing", "blood-stained", "alien", "bizarre", "ornate", "battered")] [A.name]"
				A.desc = pick("A completely bizarre device. ","Some kind of wierd contraption. ","A large device that pulsates with unknown energies. ","An object that is obviously not made by humans. ","A device that utilizes unknown technology. ")
				A.desc += pick("It hums with internal energy","It is clearly ancient.","It has a faint green glow.","It has a skull-like sigil on it.","It looks like it was designed for a robot.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.","It looks unstable.")
				return A
			else
				if(prob(50))
					var/obj_path = pick(/obj/item/weapon/gun/energy/pulse_rifle,/obj/item/weapon/gun/energy/gun/nuclear,/obj/item/weapon/gun/energy/ionrifle,/obj/item/weapon/gun/energy/decloner,/obj/item/weapon/gun/energy/gauss,/obj/item/weapon/gun/energy/gaussblaster,/obj/item/weapon/gun/energy/laserbeam,/obj/item/weapon/gun/energy/tesla,/obj/item/weapon/gun/energy/thunder)
					A = new obj_path(spawnloc)
					A.icon = 'icons/obj/artifacts.dmi'
					A.icon_state = pick("gun11","gun12","gun15","gun16","gun17","gun18","gun19","gun20","gun21", "gun22","gun23","gun24")
					var/obj/item/weapon/gun/energy/egun = A
					egun.modifystate = 4
					if(prob(15))
						egun.power_supply.rigged = 1
					A = egun
					A.name = pick("device","weapon","gun","rifle","gadget","energy weapon")
					A.name = "[pick("ancient","strange","runed", "glowing", "blood-stained", "alien", "bizarre", "ornate", "battered")] [A.name]"
					A.desc = pick("A completely bizarre device. ","A contraption that looks like a gun. ","A large device that pulsates with unknown energies. ","An object that is obviously not made by humans. ","A device that is definitely some kind of weapon. ")
					A.desc += pick("It hums with internal energy","It is clearly ancient.","It has a faint green glow.","It has a skull-like sigil on it.","It has a power slot in the grip.","It looks like it was designed for a robot.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.","It looks unstable.")
					if(prob(20))
						var/necron_effect_path = pick(ARTIFACT_PATHS)
						var/datum/artifact_effect/E = new necron_effect_path
						E.trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
						E.artifact_init(A)
				else
					var/staff_path = pick(/obj/item/weapon/gun/magic/staff/change,/obj/item/weapon/gun/magic/staff/lightstaff,/obj/item/weapon/gun/magic/staff/abyssalstaff,/obj/item/weapon/gun/magic/staff/healing,/obj/item/weapon/gun/magic/staff/animate)
					A = new staff_path(spawnloc)
					if(prob(80))
						A.icon = 'icons/obj/artifacts.dmi'
						A.icon_state = pick("gun13","gun14","gun25","gun26","gun27")
					A.item_state = "staffofchaos"
					A.name = pick("device","weapon","staff","sceptre","rod","cane")
					A.name = "[pick("ancient","strange","runed", "glowing", "blood-stained", "alien", "bizarre", "ornate", "battered","arcane")] [A.name]"
					A.desc = pick("A completely bizarre device. ","A contraption that looks like a staff. ","A jumble of technology that looks somewhat arcane. ","Clearly a high tech weapon. ","A rod that harnesses completely alien energies. ")
					A.desc += pick("It hums with internal energy","It is clearly ancient.","It has a faint green glow.","It has a skull-like sigil on it.","It has a power slot in the grip.","It looks like it was designed for a robot.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.","It looks unstable.")
					if(prob(20))
						var/new_effect_path = pick(ARTIFACT_PATHS)
						var/datum/artifact_effect/E = new new_effect_path
						E.trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
						E.artifact_init(A)
					if(prob(15))
						var/obj/item/weapon/gun/magic/M = A
						M.can_charge = 0
						A = M
				return A
		if("daemon")  //An ornate weapon that corrupts the user and grants some varying powers. After the user dies, chooses a new user, so quite dangerous.
			A = new /obj/item/weapon/daemon(spawnloc)
			return A
		if("eldar")   //Eldar enchanted wierd thing.
			var/obj/item/xenoartifact/XA = new /obj/item/xenoartifact(spawnloc)
			XA.base_icon = pick("dev21","dev22","dev23","dev24")
			XA.update_icons()
			A = XA
			A.name = pick("relic","gizmo","object","artifact","gadget")
			A.name = "[pick("arcane","strange","runed", "glowing", "eldar", "alien", "bizarre", "ornate", "battered")] [A.name]"
			A.desc = pick("A completely bizarre device. ","Some kind of wierd artifact. ","A large device that pulsates with arcane energies. ","An object that is obviously not made by humans. ","A device that utilizes xeno technology. ")
			A.desc += pick("It hums with internal energy","It has a faint white glow.","It has an eldar sigil on it.","It has a small red stone pressed into it.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.")
			return A
		if("darkage") //Sophisticated tech that is basically like a necron artifact. However, the naming and sprites are different, and the lore of these is that they are from the dark age of technology. Includes powerful stuff like a very potent white esword, energy pistol, et cetera.
			return A    //I haven't put this in yet.

//Required icons for this:
//Necron gadgets, guns- 1 - DONE - DONE
//Daemon weapons- 2 - DONE
//Eldar gadgets- 3 - DONE
//Dark age of technology gadgets, guns - 4 - DONE - DONE

/mob/living/simple_animal/hostile/shadow  //A corrupted person to guard daemon weapons.
	name = "Warped Guardsman"
	desc = "A twisted, shadowed, and warp consumed creature that appears to have once been a regular human."
	icon_state = "shadow"
	icon_living = "shadow"
	icon_dead = "shadow_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "passes through"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	maxHealth = 110
	health = 110

	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 25
	attacktext = "strikes"
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

	stop_automated_movement = 1

	faction = list("void")

/mob/living/simple_animal/hostile/shadow/FindTarget()
	. = ..()
	if(.)
		emote("screams at [.]")
		var/sound = pick('sound/hallucinations/i_see_you1.ogg','sound/hallucinations/i_see_you2.ogg','sound/hallucinations/im_here1.ogg','sound/hallucinations/im_here2.ogg')
		playsound(src.loc, sound, 50, 1)

/mob/living/simple_animal/hostile/shadow/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		L << "\red The [src]'s spectral hands burn!"
		if(prob(20))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\The [src] knocks down \the [L]!</span>")

proc/generate_ruins(var/turf/startloc) //Produces walls, might spawn mobs, structures, spawns in an artifact. These are meant to go on the snow for xenoarchaeology.
	var/template = pick("generic","necron","eldar","daemon")
	var/wall_type
	var/floor_type
	var/list/mob_types
	switch(template)
		if("generic")
			wall_type = list(/turf/simulated/wall)
			floor_type = list(/turf/simulated/floor,/turf/simulated/floor/wood)
			mob_types = list(/mob/living/simple_animal/hostile/giant_spider,/mob/living/simple_animal/hostile/bear,/mob/living/simple_animal/hostile/mimic/crate,/obj/effect/mine)
		if("necron")
			wall_type = list(/turf/simulated/wall/necron)
			floor_type = list(/turf/simulated/floor/necron)
			mob_types = list(/mob/living/simple_animal/hostile/necron/scarab,/obj/effect/mine)
		if("eldar")
			wall_type = list(/turf/simulated/wall)
			floor_type = list(/turf/simulated/floor,/turf/simulated/floor/bluegrid)
			mob_types = list(/mob/living/simple_animal/hostile/mimic/crate,/obj/effect/mine)
		if("daemon")
			wall_type = list(/turf/simulated/wall/cult)
			floor_type = list(/turf/simulated/floor/engine/cult,/turf/simulated/floor)
			mob_types = list(/mob/living/simple_animal/hostile/shadow,/obj/effect/mine)
	var/room = spawn_room(startloc,pick(6,7,8),pick(6,7,8),wall_type,floor_type,)
	var/list/emptyturfs = room["floors"]
	var/turf/simulated/T = pick(emptyturfs)
	generate_artifact(template,T)
	sleep(2)
	if(prob(35))
		var/guard_type = pick(mob_types)
		new guard_type(T)
	emptyturfs.Remove(T)
	var/turf/simulated/T3 = pick(emptyturfs)
	var/room2 = spawn_room(T3,pick(5,6,7),pick(5,6,7),wall_type,floor_type,) //Makes it more interesting than just a single room, now there are two or three.
	emptyturfs = (emptyturfs && room2["floors"])
	for(var/stage = 1, stage<=14, stage++)
		var/turf/simulated/T2 = pick(emptyturfs)
		var/fluffitem = pick(/obj/effect/glowshroom/single,/obj/structure/table/reinforced,/obj/item/weapon/reagent_containers/syringe/antitoxin,/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,/obj/item/weapon/stock_parts/scanning_module,/obj/item/weapon/stock_parts/cell,/obj/effect/decal/remains/human,/obj/effect/decal/cleanable/blood,/obj/item/weapon/tank/oxygen/red,/obj/item/trash/candle,/obj/effect/gibspawner,/obj/effect/mine,/obj/effect/mine/dnascramble,/obj/structure/closet/crate,/obj/structure/closet/crate,/obj/structure/closet/crate,/obj/structure/closet/crate,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt,/obj/effect/decal/cleanable/dirt) //I know there is almost definitely a better way to do this... But right now I just want to see if the whole thing works.
		new fluffitem(T2)
		if(prob(8)) //Chance to also throw in a random hostile mob
			var/guard_type = pick(mob_types)
			new guard_type(T2)

proc/daemonize(var/obj/item/O,var/chaosgod = null) //Places the essence of a daemon in an object.
	var/datum/artifact_effect/daemon_effect/daemon = new /datum/artifact_effect/daemon_effect
	if(chaosgod)
		daemon.chaosgod = chaosgod
	daemon.artifact_init(O)

/obj/item/weapon/daemon
	name = "daemon weapon (ERROR)"
	desc = "A blade that carries a daemon's essence. Trouble is, it shouldn't really exist (at least not unaltered). Please report this to Drake, Norc, or the forums."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/daemon/New()
	..()
	var/chaosgod = pick("khorne","tzeench","nurgle","slaanesh")
	daemonize(src,chaosgod)
	force = pick(30,35,40,40,40,45,45,50,55,60,65,70)
	switch(chaosgod)
		if("khorne")
			icon_state = pick("daemon1","daemon2","daemon3","daemon7","daemon8")
		if("tzeench")
			icon_state = pick("daemon2","daemon3","daemon5")
		if("nurgle")
			icon_state = pick("daemon2","daemon3","daemon4","daemon9")
		if("slaanesh")
			icon_state = pick("daemon2","daemon3","daemon6")
	name = pick("blade","razor","sword")
	name = "[pick("ornate","runed","ancient","gilded","gem-encrusted","blood-stained","warp","tainted","arcane", "rusted")] [name]"
	desc = pick("An ornate weapon.","An ancient blade.","A strange weapon.","A gem-encrusted blade.")
	desc += " "
	desc += pick("It is covered in unholy runes.","It has a faint red glow.","You feel like it is watching you.","It has strange markings on it.","It has a strange aura.","You feel an inexplicable urge to touch it...","You feel oddly attached to it...")

/obj/item/weapon/daemon/IsShield()
	return prob(50)

/obj/item/weapon/daemon/attack(mob/living/M as mob, mob/user as mob)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/hellblade //Mostly for debugging, but hey, if you want you can put this in somewhere. After all, it is a lore-accurate hellblade of khorne.
	name = "hellblade"
	desc = "A hellblade of khorne. Contains the essence of a bloodletter daemon."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/hellblade/New()
	..()
	daemonize(src,"khorne") //Makes it into a daemon weapon, supplies the optional argument to make it a khorne daemon.

/obj/item/weapon/hellblade/IsShield()
	return prob(50)

/obj/item/weapon/hellblade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>")
	user << "\red You hear the sound of laughter in your mind as darkness overtakes your consciousness."
	spawn(100)
		user.visible_message("<span class='suicide'>BLOOD FOR THE BLOOD GOD</span>")
		user.gib()
	return(BRUTELOSS)

/obj/item/weapon/hellblade/attack(mob/living/M as mob, mob/user as mob)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/night
	name = "nightblood"
	desc = "A massive jet black sword. You feel the need to pick it up..."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "night"
	item_state = "cultbladeold"
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 50
	throwforce = 40
	w_class = 4
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/night/New()
	..()
	var/datum/artifact_effect/daemon_effect/night/spirit = new /datum/artifact_effect/daemon_effect/night
	spirit.artifact_init(src)

/obj/item/weapon/night/IsShield()
	return prob(90)

/obj/item/weapon/night/dropped(mob/user)
	..()
	for(var/datum/artifact_effect/daemon_effect/night/spirit in src.artifact_effects) //Unbonds with them when dropped.
		spirit.target = null
	if(iscarbon(user)) //Some backlash when dropped.
		var/mob/living/carbon/M = user
		M.Weaken(5)
		M.adjustToxLoss(-5)
		M.reagents.clear_reagents()
		var/turf/T = get_turf(M)
		T.add_vomit_floor(M)
		playsound(M, 'sound/effects/splat.ogg', 50, 1)

/obj/item/weapon/night/attack(mob/living/M as mob, mob/user as mob)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/storage/belt/night
	name = "sword sheath"
	desc = "Holds a sword."
	icon_state = "night"
	item_state = "katana"
	can_hold = list(/obj/item/weapon/night)
	max_w_class = 4
	max_combined_w_class = 4
	attack_verb = list("beat")

/obj/item/weapon/storage/belt/night/New()
	..()
	new /obj/item/weapon/night(src)

proc/set_up_all_ruins()
	var/list/turfs = new/list()
	for(var/area/snow/S in world)
		for(var/turf/T in S)
			if(T.z == 1)
				turfs += T
	for(var/stage = 1, stage<=10, stage++)
		var/turf/potential_ruins = pick(turfs)
		var/viable = 1
		for(var/turf/T in range(10,potential_ruins))
			if(!(istype(T.loc, /area/space)))
				viable = 0
		if(viable)
			for(var/atom/A in range(10,potential_ruins))
				qdel(A) //We don't want trees in here, and we have made certain above that ruins won't cut into station areas.
			spawn
				generate_ruins(potential_ruins)

var/list/unlinked = list()
var/list/unlinked2 = list()

/obj/structure/necron_entrance
	name = "Entrance"
	desc = "A winding, dark stairway."
	icon= 'icons/mob/necron.dmi'
	icon_state = "entrance"
	density = 1
	opacity = 1
	anchored = 1
	var/obj/structure/necron_entrance/linked = null
	var/spamcooldown = 0

/obj/structure/necron_entrance/New()
	var/turf/location = get_turf(src)
	if(location.loc.name == "necron catacombs")
		unlinked.Add(src)
	else
		spawn(30)
			if(length(unlinked))
				linked = pick(unlinked)
				unlinked.Remove(linked)
				linked.linked = src
			else
				world << "\red <b>Error. An unlinked entrance to the catacombs has been spawned. Whoever spawned it, stop pressing buttons.</b>"

/obj/structure/necron_entrance/attack_robot(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		radarintercept("<font color='silver'> ....a high pitched flash of sound...</font>")
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
		if(istype(get_area(M.loc), /area/necron_catacombs) && prob(40) && !spamcooldown)
			spamcooldown = 1
			spawn(180) spamcooldown = 0
			M << pick("<span class='tombs'>Why hello!</span>", "<span class='tombs'>Welcome!</span>","<span class='tombs'>Greetings, intruder... It's a joy to have guests every now and then.</span>","<span class='tombs'>A creature of steel. Interesting...</span>","<span class='tombs'>Greetings... Make yourself at home. You might be here for a LONG time.</span>")
	else
		return

/obj/structure/necron_entrance/attack_hand(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		radarintercept("<font color='silver'> ....a high pitched flash of sound...</font>")
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
		if(istype(get_area(M.loc), /area/necron_catacombs) && prob(40) && !spamcooldown)
			spamcooldown = 1
			spawn(180) spamcooldown = 0
			M << pick("<span class='tombs'>Why hello!</span>", "<span class='tombs'>Welcome!</span>","<span class='tombs'>Greetings, intruder... It's a joy to have guests every now and then.</span>","<span class='tombs'>Ah, a meat creature arrives.</span>","<span class='tombs'>Greetings... Make yourself at home. You might be here for a LONG time.</span>")
	else
		return

/obj/structure/necron_entrance/attack_alien(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		radarintercept("<font color='silver'> ....a high pitched flash of sound...</font>")
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
		if(istype(get_area(M.loc), /area/necron_catacombs) && prob(40) && !spamcooldown)
			spamcooldown = 1
			spawn(180) spamcooldown = 0
			M << pick("<span class='tombs'>Why hello!</span>", "<span class='tombs'>Welcome!</span>","<span class='tombs'>Greetings, intruder... It's a joy to have guests every now and then.</span>","<span class='tombs'>Fascinating. I have very little experience with your species. Perhaps you would consent to a quick dissection by scarabs? It won't hurt, I promise.</span>","<span class='tombs'>Greetings... Make yourself at home. You might be here for a LONG time.</span>")
	else
		return

/obj/structure/necron_entrance/attackby(obj/item/weapon/W, mob/user as mob)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		radarintercept("<font color='silver'> ....a high pitched flash of sound...</font>")
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
		if(istype(get_area(M.loc), /area/necron_catacombs) && prob(40) && !spamcooldown) //Higher chance and replicable, so it necessarily also will need to have a cooldown so it doesn't expose irrational behavior.
			spamcooldown = 1
			spawn(180) spamcooldown = 0
			M << pick("<span class='tombs'>Why hello!</span>", "<span class='tombs'>Welcome!</span>","<span class='tombs'>Greetings, intruder... It's a joy to have guests every now and then.</span>","<span class='tombs'>Ah, a meat creature arrives.</span>","<span class='tombs'>Greetings... Make yourself at home. You might be here for a LONG time.</span>")
	else
		return

/obj/structure/necron_entrance/icon2
	icon_state = "entrance2"
	name = "entrance"
	desc = "A big pit."

/obj/structure/caves_entrance
	name = "Hole"
	desc = "Looks like some kind of dig site..."
	icon = 'icons/mob/necron.dmi'
	icon_state = "entrance2"
	density = 1
	opacity = 1
	anchored = 1
	var/obj/structure/caves_entrance/linked = null

/obj/structure/caves_entrance/icon2
	name = "Ladder"
	desc = "A ladder. Looks like it has been neglected for quite some time."
	icon_state = "cave"

/obj/structure/caves_entrance/New()
	var/turf/location = get_turf(src)
	if(location.loc.name == "necron catacombs")
		unlinked2.Add(src)
	else
		spawn(30)
			if(length(unlinked2))
				linked = pick(unlinked2)
				unlinked2.Remove(linked)
				linked.linked = src
			else
				world << "\red <b>Error. An unlinked entrance to the caves has been spawned. Whoever spawned it, stop pressing buttons.</b>"

/obj/structure/caves_entrance/attack_robot(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
	else
		return

/obj/structure/caves_entrance/attack_hand(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
	else
		return

/obj/structure/caves_entrance/attack_alien(mob/user)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
	else
		return

/obj/structure/caves_entrance/attackby(obj/item/weapon/W, mob/user as mob)
	var/mob/living/M = user
	if(linked && user in range(1, src))
		M.loc = get_turf(linked)
		if(M.pulling)
			M.pulling.loc = get_turf(linked)
	else
		return

/obj/structure/closet/crate/necron
	name = "crate"
	desc = "A rectangular crate of alien design."
	icon = 'icons/mob/necron.dmi'

/obj/item/weapon/paper/crumpled/bloody/tombs
	name = "Journal Page"

/obj/item/weapon/paper/crumpled/bloody/tombs/New()
	info = pick("Property of the Adeptus Mechanicus<BR><BR>Explorator Logbook<BR><BR>Expedition 7 890 811.M41 to 7 012 812.M41<BR><BR>Expedition 7 122 812.M41 to __________",
							"7 145 812.M41<BR><BR><BR>I found one of the caverns that were showing up on scans... Finally. The cogitators estimated that the formation was not natural. They were right. The winding corridors down here are constructed with precision and skill. I wonder what happened to the builders... The place is obviously ancient. I will need to run some tests to determine how ancient.",
	            "7 148 812.M41<BR><BR><BR>Tests indicate that this place is old. Really old. Mars will be pleased with this I think. Anyway, no signs of habitation yet, which is interesting. It almost feels like some kind of big tomb...",
	            "7 152 812.M41<BR><BR><BR>One of the servitors just broke down. It will need replacing when I get back up to the surface. Anyway, the other servitors returned from the reconnaissance trip. They haven't been able to determine an ending to the tunnels, even on long range scans.",
	            "7 156 812.M41<BR><BR><BR>I have been studying the engravings on these walls... That symbol, over and over again. I wonder what purpose it serves. Anyway, I think I may have found an engraving that functions as a map. I wasn't very precise, but it looks like there is some kind of holding cell to the northwest. Might be worth checking out.",
	            "7 178 812.M41<BR><BR><BR>I am starting to wonder how empty these tunnels really are. Sometimes, I think I might hear something... But no, there hasn't even been signs of habitation, and none of the sensors report heat signatures.",
	            "7 180 812.M41<BR><BR><BR>I may have just found something of note. A possible example of archeotech. I have placed the artifact in the care of one of my servitors for now. Best not to risk carrying it personally.",
	            "7 182 812.M41<BR><BR><BR>Something strange has happened. I swore I just saw one of the walls move. Am I going insane down here?",
	            "7 189 812.M41<BR><BR><BR>I think I might be lost. The tunnels just keep on going on and on... I am going to set up camp. Tomorrow, the servitors can scout the area.",
	            "7 190 812.M41<BR><BR><BR>Today something strange happened. The walls... They lit up. I was walking through a tunnel and suddenly everything started shaking, then it all lit up. How in the emperor's name does this place still have power? Nothing about this site makes any sense.",
	            "7 196 812.M41<BR><BR><BR>First encounter of signs of life. A small metal insectoid robot gave me quite a cut on my leg before I blasted it with my hellpistol. Whatever it is, it probably answers to whoever built this. Somehow I don't think they died off after all... I am going to need stitches, anyway. I better run into the exit soon.",
	            "7 199 812.M41<BR><BR><BR><b>HOLY FUCKING EMPEROR.</b> The place is suddenly swarming with them. The walls keep moving before my eyes, and <i>they</i> keep on coming for me. No fucking wonder there were no heat signatures...",
	            "7 205 812.M41<BR><BR><BR>Servitors are spending all available hours scouting alternative tunnels for an exit. Still nothing. And my hell pistol is running low on juice.",
	            "7 209 812.M41<BR><BR><BR>This place has completely transformed. Somehow I must have made these creatures wake up. Suddenly, this place is alive...",
	            "7 224 812.M41<BR><BR><BR>I can't keep going with my injuries. I am losing too much blood I think. I just need to stop... Take a break.")

/obj/effect/landmark/necron_find
	name = "Necron Find"
	icon_state = "x3"

/obj/effect/landmark/necron_find/New() //Randomly generates a find specifically for the more expanded necron catacombs. Factors in a chance that it is contained within a crate, crate mimic, backpack, or that the backpack contains a scarab. Put lots of these in.
	var/turf/location = get_turf(src)
	if( !istype(get_area(location), /area/necron_catacombs) && !istype(get_area(location), /area/ai_monitored/nuke_storage) ) //Don't actually generate this stuff if we are a prefab.
		..()
		invisibility = 0
		return
	var/crate = prob(50)
	var/backpack = prob(50) & !crate
	var/artifacts_count = 1
	var/list/artifacts = list()
	if(crate | backpack)
		artifacts_count += pick(-1,-1,0,0,0,0,0,0,1,2)
		var/fluff_count = pick(0,1,2,3,4,5,6)
		for(var/stage = 1, stage<=fluff_count, stage++)
			var/path = pick(/obj/item/stack/sheet/mineral/diamond,/obj/item/weapon/crowbar,/obj/item/weapon/weldingtool,/obj/item/weapon/wrench,/obj/item/weapon/screwdriver,/obj/item/weapon/wirecutters,/obj/item/weapon/weldingtool,/obj/item/device/soulstone,/obj/item/candle,/obj/item/xenos_claw,/obj/item/weapon/shard,/obj/item/weapon/stock_parts/manipulator/pico,/obj/item/weapon/stock_parts/capacitor/super,/obj/item/weapon/stock_parts/scanning_module/phasic,/obj/item/weapon/stock_parts/micro_laser/ultra,/obj/item/weapon/stock_parts/subspace/crystal,/obj/item/weapon/stock_parts/subspace/analyzer,/obj/item/weapon/stock_parts/subspace/amplifier,/obj/item/weapon/tank/plasma/full,/obj/item/device/assembly/signaler,/obj/item/device/encryptionkey/binary,/obj/item/device/flashlight/emp,/obj/item/device/wormhole_jaunter,/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy,/obj/item/organ/brain/alien,/obj/item/organ/limb/head,/obj/item/weapon/dnainjector/h2m/lol,/obj/item/mecha_parts/chassis/phazon,/obj/item/mecha_parts/part/phazon_torso,/obj/item/mecha_parts/part/phazon_head,/obj/item/mecha_parts/part/phazon_left_arm,/obj/item/mecha_parts/part/phazon_right_arm,/obj/item/mecha_parts/part/phazon_left_leg,/obj/item/mecha_parts/part/phazon_right_leg,/obj/item/trash/candy,/obj/item/weapon/grown/deathnettle,/obj/item/weapon/grown/nettle,/obj/item/weapon/nullrod,/obj/item/weapon/plastique,/obj/item/weapon/spacecash/c10,/obj/item/weapon/spacecash/c50,/obj/item/weapon/spacecash/c200,/obj/item/weapon/spacecash/c1000)
			artifacts += new path(get_turf(src))
	for(var/stage = 1, stage<=artifacts_count, stage++)
		artifacts += generate_artifact("necron",get_turf(src))
	if(crate)
		var/newcrate
		if(prob(10))
			newcrate = new /mob/living/simple_animal/hostile/mimic/crate(get_turf(src))
		else
			newcrate = new /obj/structure/closet/crate/necron(get_turf(src))
		for(var/obj/artifact in artifacts)
			artifact.loc = newcrate
	if(backpack)
		var/pack = new /obj/item/weapon/storage/backpack/necron(get_turf(src))
		for(var/obj/artifact in artifacts)
			artifact.loc = pack
		if(prob(25))
			new /obj/item/mob_holder/scarab(pack) //chance a scarab hides in the pack
	qdel(src)

proc/spawn_room(var/atom/start_loc, var/x_size, var/y_size, var/list/walltypes, var/floor, var/name)
	var/list/room_turfs = list("walls"=list(),"floors"=list())

	for(var/x = 0, x < x_size, x++)		//sets the size of the room on the x axis
		for(var/y = 0, y < y_size, y++) //sets it on y axis.
			var/turf/T
			var/cur_loc = locate(start_loc.x + x, start_loc.y + y, start_loc.z)


			var/area/asteroid/artifactroom/A = new
			if(name)
				A.name = name
			else
				A.name = "Artifact Room #[start_loc.x]-[start_loc.y]-[start_loc.z]"


			if(x == 0 || x == x_size-1 || y == 0 || y == y_size-1)
				var/wall = pickweight(walltypes)//totally-solid walls are pretty boring.
				T = cur_loc
				T.ChangeTurf(wall)
				room_turfs["walls"] += T


			else
				T = cur_loc
				T.ChangeTurf(floor)
				room_turfs["floors"] += T

			A.contents += T

	return room_turfs



/obj/effect/shadow
	name = "shadow"
	icon = 'icons/effects/effects.dmi'
	desc = "A shadow!"
	icon_state = "bhole3"
	unacidable = 1
	density = 0
	anchored = 1

/obj/effect/shadow/New()
	..()
	spawn(1)
		step(src, pick(cardinal))
	spawn(3)
		step(src, pick(cardinal))
	spawn(6)
		step(src, pick(cardinal))
	spawn(9)
		step(src, pick(cardinal))
	spawn(12)
		step(src, pick(cardinal))
	spawn(15)
		step(src, pick(cardinal))
	spawn(18)
		step(src, pick(cardinal))
	spawn(21)
		step(src, pick(cardinal))
	spawn(24)
		step(src, pick(cardinal))
	spawn(27)
		step(src, pick(cardinal))
	spawn(30)
		step(src, pick(cardinal))
	spawn(33) qdel(src)

/obj/item/clothing/suit/armor/shadowcloak
	name = "Shadow Cloak"
	desc = "A cloak shimmering with darkness. It somehow projects a small shadow field around the wearer, making them harder to spot."
	icon_state = "scloak"
	item_state = "scloak"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun, /obj/item/weapon/chainsword, /obj/item/weapon/powersword, /obj/item/weapon/complexknife, /obj/item/weapon/complexsword, /obj/item/weapon/fastknife)
	flags = THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	blood_overlay_type = "armor"
	slowdown = -10
	armor = list(melee = 70, bullet = 65, laser = 65, energy = 85, bomb = 60, bio = 70, rad = 100)

/obj/item/clothing/suit/armor/shadowcloak/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/suit/armor/shadowcloak/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		if(H.wear_suit == src)
			if(H.inertial_speed)
				spawn(0)
					animate(H, alpha = rand(210, 250), time = 10)
				spawn(0)
					var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H))
					S.icon = H.icon
					S.icon_state = H.icon_state
					S.overlays = H.overlays
					S.alpha = H.alpha
					spawn(0)
						animate(S, alpha = 0, time = 40) //Make the shadow fade out.
				spawn(5)
					var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H))
					S.icon = H.icon
					S.icon_state = H.icon_state
					S.overlays = H.overlays
					S.alpha = H.alpha
					spawn(0)
						animate(S, alpha = 0, time = 40) //Make the shadow fade out.
				spawn(10)
					var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H))
					S.icon = H.icon
					S.icon_state = H.icon_state
					S.overlays = H.overlays
					S.alpha = H.alpha
					spawn(0)
						animate(S, alpha = 0, time = 40) //Make the shadow fade out.
				spawn(15)
					var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H))
					S.icon = H.icon
					S.icon_state = H.icon_state
					S.overlays = H.overlays
					S.alpha = H.alpha
					spawn(0)
						animate(S, alpha = 0, time = 40) //Make the shadow fade out.
			else
				spawn(0)
					if(H.alpha != 10)
						animate(H, alpha = 10, time = 30)

/obj/item/clothing/suit/armor/shadowcloak/dropped()
	..()
	usr.alpha = 255

/obj/item/clothing/suit/armor/shadowcloak/equipped()
	..()
	usr.alpha = 255

/obj/item/clothing/mask/gas/artifact
	name = "Crimson Mask"
	desc = "The eerie countenance glows with a reddish light, humming with power..."
	icon_state = "artifact"
	item_state = "artifact"
	flags_inv = HIDEGLOVES
	var/weartime = 0
	var/worn = 0

/obj/item/clothing/mask/gas/artifact/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/mask/gas/artifact/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		if(H.wear_mask == src)
			weartime += 10
			if(weartime >= 100)
				if(prob(75)) H << "\red You sense that wearing the mask for much longer would be a bad idea."
			if(weartime >= 150)
				H.visible_message("\red [H]'s body is consumed in a flash of deep red light!")
				H.dust()
			H.heal_organ_damage(8, 8)
			H.adjustOxyLoss(-12)
			H.adjustToxLoss(-8)
			H.ignore_pain += 5
			H.suppress_pain += 5
			H.adjustStaminaLoss(-10)
			H.AdjustStunned(-10)
			H.AdjustWeakened(-10)
			H.AdjustParalysis(-10)
			H.drowsyness = 0
			H.eye_blurry = 0
			H.reagents_speedmod = min(H.reagents_speedmod, -12)
			H.next_click -= 1
			spawn(4) H.next_click -= 1
			H.dodging = 2
			if(H.handcuffed)
				H.visible_message("<span class='warning'>[H] is trying to break free!</span>", "<span class='warning'>You attempt to break free.</span>")
				del(H.handcuffed)
				H.regenerate_icons()
	else
		if(weartime > 0) weartime --

/obj/item/clothing/mask/gas/artifact/dropped()
	..()
	spawn(5)
		if(worn)
			worn = 0
			if(ishuman(src.loc))
				var/mob/living/carbon/human/H = src.loc
				H.visible_message("\red <b>[H] takes off the [src]!</b>")
				H << "\red You collapse!"
				H.Paralyse(weartime/5)
				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
					H.mind.spell_list.Remove(D)
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.dodging = 0

/obj/item/clothing/mask/gas/artifact/equipped()
	..()
	spawn(5) //Make sure we check this /after/ the mask's location is changed.
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(worn)
				worn = 0
				H.visible_message("\red <b>[H] takes off the [src]!</b>")
				H << "\red You collapse!"
				H.Paralyse(weartime/5)
				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
					H.mind.spell_list.Remove(D)
			if(H.wear_mask == src)
				worn = 1
				H.visible_message("\red <b>[H] puts on the [src]!</b>")
				H << "\red You feel a rush of power!"
				H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/devestate(null) //Basically a much more gory version of disintegrate.
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.dodging = 0

/obj/structure/closet/crate/space_hulk
	desc = "A rectangular steel crate. Looks sort of old and dirty."
	name = "crate"
	icon = 'icons/obj/storage.dmi'
	icon_state = "dirtycrate"
	density = 1
	icon_opened = "dirtycrateopen"
	icon_closed = "dirtycrate"