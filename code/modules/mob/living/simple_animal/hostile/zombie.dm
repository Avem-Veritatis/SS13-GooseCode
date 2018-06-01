/mob/living/simple_animal/hostile/zombie
	name = "corpse"
	desc = "Looks like it might be a zombie."
	icon_state = "zombie_dead"
	icon_living = "zombie_dead"
	icon_dead = "zombie_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "touches"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	speed = 1
	maxHealth = 100
	health = 100

	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'

	//Space zombie aren't affected by atmos.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	factions = list("zombie")
	idle_vision_range = 4
	var/icon_aggro = "zombie"
	var/corpse = null

/mob/living/simple_animal/hostile/zombie/Process_Spacemove(var/check_drift = 0)
	return 1	//No drifting in space for space zombie!	//original comments do not steal

/mob/living/simple_animal/hostile/zombie/Aggro()
	..()
	if(src.icon_state != src.icon_aggro)
		src.visible_message("\red [src] stands up and begins shambling purposefully towards you!")
	icon_state = icon_aggro

/mob/living/simple_animal/hostile/zombie/LoseAggro()
	..()
	icon_state = icon_living

/mob/living/simple_animal/hostile/zombie/bullet_act(var/obj/item/projectile/P)//Reduces damage from most projectiles to curb off-screen kills
	if(!stat)
		Aggro()
	..()

/mob/living/simple_animal/hostile/zombie/hitby(atom/movable/AM)//No floor tiling them to death, wiseguy
	if(istype(AM, /obj/item))
		if(!stat)
			Aggro()
	..()

/mob/living/simple_animal/hostile/zombie/AttackingTarget()
	. =..()
	var/mob/living/carbon/L = target
	if(istype(L))
		if(prob(15))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/zombie/Die()
	..()
	if(corpse)
		if(ismob(corpse))
			var/mob/C = corpse
			C.loc = src.loc
			qdel(src)
		else
			new corpse(src.loc)
			qdel(src)

/mob/living/simple_animal/hostile/zombie/explorator
	icon_state = "zexplorator_dead"
	icon_living = "zexplorator_dead"
	icon_dead = "zexplorator_dead"
	icon_aggro = "zexplorator"
	name = "explorator"
	desc = "This exploration trip went horribly wrong."
	corpse = /obj/effect/landmark/corpse/explorator2

/mob/living/simple_animal/hostile/zombie/viro
	icon_state = "zviro_dead"
	icon_living = "zviro_dead"
	icon_dead = "zviro_dead"
	icon_aggro = "zviro"
	name = "virologist"
	desc = "This guy is clearly an expert in his field."
	corpse = /obj/effect/landmark/corpse/viro

/mob/living/simple_animal/hostile/zombie/preacher
	icon_state = "zpreacher_dead"
	icon_living = "zpreacher_dead"
	icon_dead = "zpreacher_dead"
	icon_aggro = "zpreacher"
	name = "ecclesiarch"
	desc = "This one is a really persistent evangelist..."
	corpse = /obj/effect/landmark/corpse/preacher

/mob/living/simple_animal/hostile/zombie/guard
	icon_state = "zguard_dead"
	icon_living = "zguard_dead"
	icon_dead = "zguard_dead"
	icon_aggro = "zguard"
	name = "imperial guard"
	desc = "This guard is so dedicated that he keeps guarding things despite being dead."
	corpse = /obj/effect/landmark/corpse/guard

/mob/living/simple_animal/hostile/zombie/inq
	icon_state = "zinq_dead"
	icon_living = "zinq_dead"
	icon_dead = "zinq_dead"
	icon_aggro = "zinq"
	name = "inquisitor"
	desc = "Unexpected inquisition."

/mob/living/simple_animal/hostile/zombie/medicus
	icon_state = "zmedicus_dead"
	icon_living = "zmedicus_dead"
	icon_dead = "zmedicus_dead"
	icon_aggro = "zmedicus"
	name = "medicus"
	desc = "This one adds a whole new meaning to the diagnosis 'dead man walking'."

//And now to make this sufficiently confusing... Non-zombie corpses to mix in.

/obj/effect/landmark/corpse/explorator2
	name = "explorator"
	corpseradio = /obj/item/device/radio/headset/headset_eng
	corpseuniform = /obj/item/clothing/under/color/lightbrown
	corpseshoes = /obj/item/clothing/shoes/boots
	corpsegloves = /obj/item/clothing/gloves/yellow
	corpsehelmet = /obj/item/clothing/head/helmet/space/rig
	corpsesuit = /obj/item/clothing/suit/labcoat/science/explore
	corpsemask = /obj/item/clothing/mask/gas/TRAP
	corpsebrute = 300
	corpseoxy = 300
	corpseid = 1
	corpseidjob = "Explorator"
	corpseidaccess = "Tech Priest"
	bloody = 1

/obj/effect/landmark/corpse/viro
	name = "virologist"
	corpseradio = /obj/item/device/radio/headset/headset_med
	corpseuniform = /obj/item/clothing/under/rank/virologist
	corpseshoes = /obj/item/clothing/shoes/sneakers/white
	corpsegloves = /obj/item/clothing/gloves/latex
	corpsesuit = /obj/item/clothing/suit/labcoat/virologist
	corpsemask = /obj/item/clothing/mask/gas/old
	corpseback = /obj/item/weapon/storage/backpack/medic
	corpsebrute = 300
	corpseoxy = 300
	corpseid = 1
	corpseidjob = "Virologist"
	corpseidaccess = "Virologist"
	bloody = 1
	bloodyfeet = 1

/obj/effect/landmark/corpse/preacher
	name = "ecclesiarch"
	corpseradio = /obj/item/device/radio/headset
	corpseuniform = /obj/item/clothing/under/rank/chaplain
	corpseshoes = /obj/item/clothing/shoes/sneakers/black
	corpsebrute = 300
	corpseoxy = 300
	corpseid = 1
	corpseidjob = "Preacher"
	corpseidaccess = "Preacher"
	bloody = 1

/obj/effect/landmark/corpse/guard
	name = "imperial guard"
	corpseradio = /obj/item/device/radio/headset/headset_sec
	corpseuniform = /obj/item/clothing/under/rank/security
	corpseshoes = /obj/item/clothing/shoes/imperialboots/reinforced
	corpsesuit = /obj/item/clothing/suit/armor/imperialarmor/reinforced
	corpsehelmet = /obj/item/clothing/head/imperialhelmet/reinforced
	corpsegloves = /obj/item/clothing/gloves/black
	corpsebrute = 300
	corpseoxy = 300
	corpseid = 1
	corpseidjob = "Imperial Guard"
	corpseidaccess = "Imperial Guard"
	bloody = 1