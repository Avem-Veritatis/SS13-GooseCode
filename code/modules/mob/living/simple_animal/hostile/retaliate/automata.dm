/*
Vorax Class Battle Automata
For the mechanicus

Other automata to make:
	Crusader
	Baharat

Ranged Weapons Systems
Taser
Lasgun
Energy Gun
Ion Rifle
Autocannon
Inferno Pistol
Plasma Pistol
Bolter
Gauss Rifle
Pulse Rifle

Melee Weapons Systems
Stun Baton
Power Knife
Chain Sword

cogitator- Has information about the actual device and its code. A high CPU lets the interpreter run a lot of stuff, and in theory, with high CPU, lets it actually wait a half-instant then re-assess the situation, for a very fast reaction time.
motor core- Installed before armor. Speeds up automated movement when mounted (also changes its power consumption), also makes the scripting move() proc work faster and use more or less power.
power core- Generates power. Generally assembled with frame built in the fabricator, a beaker of liquid fuel, and some metal. Does not ever run out of fuel. Fills the cell at a fixed rate per tick.
power cell- Stores the automata's power. When the cell is empty, the automata may not do anything. A better cell means better storage, naturally.
armor- Gives a chance to deflect attacks, reduces movement speed in a similar way as the motor core increases it.

cogitator-
motor core- DONE
power core- DONE
power cell- DONE
armor- DONE

Other upgrades
Shield System (very high energy cost)
Self-detonation Charge (on death, including if a suicide function is called in NTSL, possibly based on inserting a grenade)
handcuffs

SOME PROCS TO GIVE AUTOMATA
---------------------------
Reaction to Speech
Threat assessment
Door control
Target
Melee Target
Ranged Target
Call help (difficult to do if code is not default since a random key must be brute-forced)

Tech in general
All tech gets a certain amount of CPU. If you remove the (overly restrictive) CPU limits, you may overclock the CPU. However, at some point this risks destroying the technology.
...I am not so sure if I actually want to do that.

*/

/obj/item/weapon/cogitator
	icon = 'icons/mob/automata.dmi'
	icon_state = "cogitator"
	name = "Cogitator Stack"
	desc = "A jumble of arcane electronics that houses a machine spirit."
	var/CPU = 60
	var/rawcode = ""
	var/authenticated = 1
	var/can_modify = 1
	var/overclocked = 0 //If it is overclocked, you get access to more CPU, but at a risk of damaging the cogitator.

/obj/item/weapon/cogitator/slave
	name = "Slave Cogitator Stack"
	desc = "A jumble of arcane electronics that houses a machine spirit. This one does not have the processing capability to run independantly."
	CPU = 5

/obj/item/weapon/cogitator/master
	name = "Advanced Cogitator Stack"
	desc = "A jumble of arcane electronics that houses a machine spirit. This one has enhanced processing capabilities and can be linked to other cogitators to give them orders."
	CPU = 120

/obj/item/weapon/cogitator/goleph //golephs
	name = "goleph core"
	desc = "A jumble of arcane electronics designed upon a heretical pattern."
	CPU = 300 //Honestly, a goleph is more intelligent than some lesser daemon a heretek plucked from the warp and shoved in a machine.
	can_modify = 0
	authenticated = 0 //Yeah no. Silica Animus are a red flag on the mainframe.
	rawcode = "$targets = list_targets(); $enemy = pick($targets); target_name($enemy\[\"name\"\]);" //Temporary code to just kill things, I will naturally make this more sophisticated.

/obj/item/weapon/cogitator/daemon //malifects, seriously corrupted machines
	name = "machine daemon"
	desc = "A malicious daemon fused into a machine. Highly intelligent and probably unruly."
	icon_state = "warp_core"
	CPU = 250
	can_modify = 0
	authenticated = 0
	rawcode = "$targets = list_targets(); $enemy = pick($targets); target_name($enemy\[\"name\"\]);" //Temporary code to just kill things, I will naturally make this more sophisticated.

/obj/item/weapon/motor_core
	name = "basic motor core"
	desc = "An imperial motor core suitable for carrying weak loads."
	icon = 'icons/mob/automata.dmi'
	icon_state = "motor_core"
	var/efficiency_multiplier = 1 //Cheap motor with decent stats.
	var/maximum_output = 10
	var/current_output = 0

/obj/item/weapon/motor_core/standard
	name = "standard motor core"
	desc = "A standard imperial motor core used in a wide spectrum of automata."
	efficiency_multiplier = 0.7 //Most efficient motor, best in most situations
	maximum_output = 20

/obj/item/weapon/motor_core/high_performance
	name = "high performance motor core"
	desc = "A high power imperial motor core used for ultrafast or heavy automata."
	efficiency_multiplier = 1.5 //Way less efficient, but very high output.
	maximum_output = 40

/obj/item/weapon/motor_core/warp
	name = "immaterium kinetics core"
	desc = "A warp based locomotive apparatus that fuses psychic power and technology into an unholy combination."
	icon_state = "warp_motor"
	efficiency_multiplier = 0.5 //More efficient.
	maximum_output = 20

/obj/item/weapon/power_core
	name = "fuel generator"
	desc = "An imperial power generator for an automata."
	icon = 'icons/mob/automata.dmi'
	icon_state = "power_core"
	var/output = 10

/obj/item/weapon/power_core/plasma
	name = "plasma generator"
	output = 20

/obj/item/weapon/power_core/fission
	name = "fission generator"
	output = 40

/obj/item/weapon/power_core/warp
	name = "empyrean drive"
	desc = "A power generator fusing the immaterium and materium, harnessing malefic energies to power an automata."
	icon_state = "warp_power"
	output = 30

/obj/item/weapon/automata_armor
	name = "light armor frame"
	desc = "A light armor pattern designed for an Imperial automata."
	icon = 'icons/mob/automata.dmi'
	icon_state = "armor"
	var/armor_power = 20
	var/weight = 2

/obj/item/weapon/automata_armor/medium
	name = "standard armor frame"
	desc = "A standard armor pattern designed for an Imperial automata."
	armor_power = 40
	weight = 3

/obj/item/weapon/automata_armor/heavy
	name = "plate armor frame"
	desc = "Heavy Imperial armor plating to protect the most powerful automata."
	icon_state = "armor_heavy"
	armor_power = 80
	weight = 5

/obj/item/weapon/automata_armor/warp
	name = "chaos armor frame"
	desc = "Blood red armor forged with technologies best left untouched."
	icon_state = "chaos_armor"
	armor_power = 65
	weight = 3

/obj/item/weapon/automata_module //Ideally I want this to export a new proc to the interpreter.
	icon = 'icons/mob/automata.dmi'
	icon_state = "module"

/mob/living/simple_animal/hostile/retaliate/automata
	name = "Vorax Class Battle Automata"
	desc = "An Imperial combat machine used to hunt and destroy."
	icon = 'icons/mob/automata.dmi'
	icon_state = "vorex_automata"
	icon_living = "vorex_automata"
	icon_dead = "vorex_automata_dead"
	icon_gib = "vorex_automata_dead"
	turns_per_move = 1
	response_help = "pats"
	response_disarm = "shoves"
	response_harm = "punches"
	speak_chance = 0
	a_intent = "harm"
	stop_automated_movement_when_pulled = 0
	maxHealth = 70
	health = 70
	see_in_dark = 10
	harm_intent_damage = 1 //Punching a metal combat robot probably won't do much.
	melee_damage_lower = 5
	melee_damage_upper = 15
	attacktext = "attacks"
	pass_flags = PASSTABLE
	faction = list("automata")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	environment_smash = 0
	ventcrawler = 2
	wander = 0 //doesn't really randomly wander, althoug patrol objectives are legitimate

	min_oxy = 0 //Robots don't need to breathe.
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0 //And they don't really feel adverse effects in the cold.

	var/obj/item/weapon/cogitator/core
	var/obj/item/weapon/motor_core/motor
	var/obj/item/weapon/automata_armor/armor
	var/obj/item/weapon/power_core/generator
	var/obj/item/weapon/stock_parts/cell/C

	var/obj/item/weapon/melee_weapon
	var/obj/item/weapon/gun/ranged_weapon
	var/obj/item/weapon/card/id/botcard			// the ID card that the bot "holds"
	var/list/modules = list()

	var/network = "NULL"		// the network the automata are connected to, where code may be uploaded
	var/activated = 0
	var/list/stderr = list() //A list that holds the automata's error output.

	var/list/memory_data = list()	// stored memory (can't be named just "memory" since that is an existing mob variable)
	var/datum/Robo_Compiler/Compiler	// the compiler that compiles and runs the code

	var/last_signal = 0 	// Last time it sent a signal
	var/moving = 0 //If it has manually called move() that tick.

/mob/living/simple_animal/hostile/retaliate/automata/New()
	..()
	Compiler = new() //Initializes a compiler
	Compiler.Holder = src

/mob/living/simple_animal/hostile/retaliate/automata/vorax/New() //Equips the vorax with its stock equipment and sets the default access and code.
	..()
	core = new(src)
	motor = new /obj/item/weapon/motor_core/standard(src)
	armor = new /obj/item/weapon/automata_armor(src)
	generator = new /obj/item/weapon/power_core(src)
	C = new /obj/item/weapon/stock_parts/cell/vorex(src)
	core.rawcode = "$targets = list_targets(); debug_stuff($targets); $enemy = pick($targets); $enemy_name = at($enemy,\"name\"); target_name($enemy_name);"
	spawn(3)
		src.botcard = new /obj/item/weapon/card/id(src)
		var/datum/job/detective/J = new /datum/job/detective
		src.botcard.access = J.get_access()
	spawn(30)
		src.visible_message("[src] starts up!")
		src.compile()
		src.activated = 1
		motor.current_output = 12

/mob/living/simple_animal/hostile/retaliate/automata/Die()
	visible_message("<b>[src]</b> blows apart!")
	new /obj/effect/gibspawner/robot(src.loc)
	..()
	LoseTarget()

/mob/living/simple_animal/hostile/retaliate/automata/gib()
	src.Die()
	return

/mob/living/simple_animal/hostile/retaliate/automata/Life()
	..()
	if(src.stat == DEAD) return
	if(activated && src.core)
		src.Compiler.Run(src.core.CPU, src.core.overclocked) //CPU limits amount of code that can be executed. This lets a clever person with a high CPU update their bot's status more frequently then they otherwise would, so it could have a better reaction time in combat.
	if(generator && C)
		C.give((generator.output))

/mob/living/simple_animal/hostile/retaliate/automata/Bump(M as mob|obj)
	if((istype(M, /obj/machinery/door)) && (!isnull(src.botcard)))
		var/obj/machinery/door/D = M
		if(!istype(D, /obj/machinery/door/firedoor) && D.check_access(src.botcard))
			D.open()
	else
		..()
	return

/mob/living/simple_animal/hostile/retaliate/automata/attackby(var/obj/item/O as obj, var/mob/user as mob) //Factoring in the stopping power of armor.
	if(O.force)
		if(prob(src.armor.armor_power - (O.force*pick(1,2))))
			visible_message("<span class='danger'>[O] bounces harmlessly off of [src].</span>")
		else
			if(O.damtype == BURN || O.damtype == BRUTE)
				adjustBruteLoss(O.force)
			visible_message("<span class='danger'>[src] has been attacked with [O] by [user]!</span>", \
					"<span class='userdanger'>[src] has been attacked with [O] by [user]!</span>")
	else
		usr << "<span class='danger'> This weapon is ineffective, it does no damage.</span>"
		visible_message("<span class='danger'>[user] gently taps [src] with [O].</span>")


/mob/living/simple_animal/hostile/retaliate/automata/bullet_act(var/obj/item/projectile/P)
	if(istype(P, /obj/item/projectile/energy) || istype(P, /obj/item/projectile/beam))
		var/reflectchance = src.armor.armor_power - (P.damage*pick(1,2))
		if(prob(reflectchance))
			if(P.damage_type == BURN || P.damage_type == BRUTE)
				adjustBruteLoss(P.damage)
			visible_message("<span class='danger'>The [P.name] gets reflected by [src]'s shell!</span>", \
							"<span class='userdanger'>The [P.name] gets reflected by [src]'s shell!</span>")

			// Find a turf near or on the original location to bounce to
			if(P.starting)
				var/new_x = P.starting.x + pick(0, 0, -1, 1, -2, 2, -2, 2, -2, 2, -3, 3, -3, 3)
				var/new_y = P.starting.y + pick(0, 0, -1, 1, -2, 2, -2, 2, -2, 2, -3, 3, -3, 3)
				var/turf/curloc = get_turf(src)

				// redirect the projectile
				P.original = locate(new_x, new_y, P.z)
				P.starting = curloc
				P.current = curloc
				P.firer = src
				P.yo = new_y - curloc.y
				P.xo = new_x - curloc.x

			return -1 // complete projectile permutation

	return (..(P))

/mob/living/simple_animal/hostile/retaliate/automata/MoveToTarget()
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return
	if(target in ListTargets())
		if(motor.current_output == 0) return
		var/target_distance = get_dist(src,target)
		var/speed = ((armor.weight*7)-motor.current_output)
		var/power = (motor.current_output*motor.efficiency_multiplier)*target_distance*4
		if(!C.use(power)) return //Tries to move with the cell's power, factoring in
		if(ranged)//We ranged? Shoot at em
			if(target_distance >= 2 && ranged_cooldown <= 0)//But make sure they're a tile away at least, and our range attack is off cooldown
				OpenFire(target)
		if(retreat_distance != null)//If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance)//If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,speed)
			else
				Goto(target,speed,minimum_distance)//Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,speed,minimum_distance)
		if(isturf(loc) && target.Adjacent(src))	//If they're next to us, attack
			AttackingTarget()
		spawn(50) //After five seconds, it re-assesses power usage and speed.
			walk(src, 0)
			MoveToTarget()
		return
	if(environment_smash)
		if(target.loc != null && get_dist(src, target.loc) <= vision_range)//We can't see our target, but he's in our vision range still
			if(environment_smash >= 2)//If we're capable of smashing through walls, forget about vision completely after finding our target
				Goto(target,speed,minimum_distance)
				FindHidden()
				return
			else
				if(FindHidden())
					return
	LostTarget()

/mob/living/simple_animal/hostile/retaliate/automata/AttackingTarget()
	if(!melee_weapon)
		target.attack_animal(src) //If no melee weapon, just hits them. Not super high damage, but it could kill someone if you hit them enough.
	else
		melee_weapon.attack(target, src, "head") //Uses the melee weapon installed if there is one.

/mob/living/simple_animal/hostile/retaliate/automata/proc/check_for_weapons(var/obj/item/slot_item)
	if(istype(slot_item, /obj/item/weapon/gun) || istype(slot_item, /obj/item/weapon/melee))
		if(!(slot_item.type in safe_weapons))
			return 1
	return 0

/mob/living/simple_animal/hostile/retaliate/automata/proc/setcode(var/t)
	if(t)
		if(istext(t))
			if(core)
				if(core.can_modify) //If it is a daemon or goleph or something, you can't just write your new code in.
					core.rawcode = t
					core.authenticated = 0 //The code has been tampered with. Unless a skilled hacker replicated authentication, other machines on the mainframe will purge the unpure machine if it tries to communicate with them, for example if it tries to call other bots to attack someone it sees.

/mob/living/simple_animal/hostile/retaliate/automata/proc/compile()
	if(Compiler && core)
		stderr.Add(Compiler.Compile(core.rawcode))

/mob/living/simple_animal/hostile/retaliate/automata/proc/clear_stderr()
	stderr = list()
	return

/mob/living/simple_animal/hostile/retaliate/automata/proc/output_stderr(var/mob/M)
	for(var/line in stderr)
		M << line
	return