/mob/living/carbon/human
	//Hair colour and style
	var/hair_color = "000"
	var/hair_style = "Bald"

	//Facial hair colour and style
	var/facial_hair_color = "000"
	var/facial_hair_style = "Shaved"

	//Eye colour
	var/eye_color = "000"

	var/skin_tone = "caucasian1"	//Skin tone

	var/lip_style = null	//no lipstick by default- arguably misleading, as it could be used for general makeup

	var/age = 30		//Player's age (pure fluff)
	var/blood_type = "A+"	//Player's bloodtype (Not currently used, just character fluff)

	var/underwear = "Nude"	//Which underwear the player wants
	var/undershirt = "Nude" //Which undershirt the player wants
	var/socks = "None" 		//Which socks the player wants
	var/backbag = 2			//Which backpack type the player has chosen. Nothing, Satchel or Backpack.

	//Equipment slots
	var/obj/item/clothing/suit/wear_suit = null
	var/obj/item/w_uniform = null
	var/obj/item/shoes = null
	var/obj/item/belt = null
	var/obj/item/gloves = null
	var/obj/item/clothing/glasses/glasses = null
	var/obj/item/head = null
	var/obj/item/ears = null
	var/obj/item/wear_id = null
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/obj/item/s_store = null

	var/base_icon_state = "caucasian1_m"

	var/list/organs = list() //Gets filled up in the constructor (human.dm, New() proc, line 24. I'm sick and tired of missing comments. -Agouri

	var/special_voice = "" // For changing our voice. Used by a symptom.

	var/failed_last_breath = 0 //This is used to determine if the mob failed a breath. If they did fail a brath, they will attempt to breathe each tick, otherwise just once per 4 ticks.

	var/xylophone = 0 //For the spoooooooky xylophone cooldown

	var/gender_ambiguous = 0 //if something goes wrong during gender reassignment this generates a line in examine

	var/reagents_speedmod = 0 //Making this so reagents can actually speed you up or slow you down. -Drake
	var/reagents_punchmod = 0 //Same thing. Reagents can modify punch damage.
	var/reagents_armormod = 1 //Again, this lets you reduce brute damage you take. It is multiplied with brute damage.
	var/suppress_pain = 0 //This allows reagents and other things (cold?) to suppress damage overlays, screen alerts, and makes your health status icon closer to 100.
	var/unknown_pain = 0  //This allows reagents to make your status icon an unknown icon as opposed to constantly 100 health, taking priority over both suppress_pain and alter_pain
	var/ignore_pain = 0 //This lets you stay awake longer past critical threshhold, and lets pain from injuries much less likely to incapacitate you.
	var/aura_sight = 0 //If they can see auras. Probably I will use this for lings. -Drake //Actually I will hold off on migrating that.
	var/list/addictions = list()
	var/DMSpeak = 0 //The probability that what you say gets converted to DM... (lol)
	var/norc = 0 //See above.

	var/berserk = 0
	var/berserktarget = null
	var/berserkmaster = null
	var/brainwashed = 0

	var/speedboost = 0

	var/innacuracy = 0

	var/stealth = 0

	var/list/mutations_warp = list()

	var/list/contracts = list()
	var/list/pending_contracts = list()

	var/inertial_speed = null //This is a variable to track how fast a human has been moving recently.

	var/obj/item/offhand_cooldown = 0

	var/necron_killcount = 0

	var/wings = 0

	var/bumpattack_cooldown = 0

	var/loud = 0

/mob/living/carbon/human/proc/mutation_expose() //Right now this is just polymorphine side effects, but I want to keep things flexible.
	var/selection = rand(1,10)
	switch(selection)
		if(1)
			randmutb(src)
		if(2)
			randmutg(src)
		if(3)
			src.disabilities = 0
			src.sdisabilities = 0
		if(4)
			src.silent += 10
		if(5)
			src.dizziness += 10
			src.radiation += 10
			src.stuttering += 10
		if(6)
			src.reagents_speedmod -= 15
		if(7)
			src.reagents_speedmod += 15
		if(8)
			/*
			if(istype(src.l_hand, /obj/item/weapon/melee/arm_blade))
				qdel(src.l_hand)
				src.visible_message("<span class='warning'>With a sickening crunch, [src] reforms his blade into an arm!</span>", "<span class='notice'>We assimilate the blade back into our body.</span>", "<span class='warning>You hear organic matter ripping and tearing!</span>")
				src.update_inv_hands()
				return
			else if(istype(src.r_hand, /obj/item/weapon/melee/arm_blade))
				qdel(src.r_hand)
				src.visible_message("<span class='warning'>With a sickening crunch, [src] reforms his blade into an arm!</span>", "<span class='notice'>We assimilate the blade back into our body.</span>", "<span class='warning>You hear organic matter ripping and tearing!</span>")
				src.update_inv_hands()
				return
			else
				if(!src.drop_item())
					return
				var/obj/item/W = new /obj/item/weapon/melee/arm_blade(src)
				src.put_in_hands(W)
			*/
			//that won't work now that we have callidus c'tan phase blade
			return
		if(9)
			wabbajack(src)
		if(10)
			src.apply_effect(20,IRRADIATE,0)

/mob/living/carbon/human/proc/auto_move(var/target)
	if(src.stat != CONSCIOUS) return
	if(!src.lying)
		if(istype(src.get_active_hand(), /obj/item/weapon/gun))
			walk_to(src, target, 2, 3)
		else
			walk_to(src, target, 1, 3)

/obj/screen/zone_sel/fake
	selecting = "head"

/mob/living/carbon/human/proc/auto_equip(var/mob/living/target)
	if(src.stat != CONSCIOUS) return
	if(prob(75))
		src.a_intent = "harm"
	else
		src.a_intent = "disarm"
	if(!src.zone_sel)
		src.zone_sel = new /obj/screen/zone_sel/fake
	if(src.zone_sel.selecting != "head")
		src.zone_sel.selecting = "head" //This is an actually dangerous location to attack.
	update_hud()
	var/obj/item/W = src.get_active_hand()
	var/obj/item/OH = src.get_inactive_hand()
	if(istype(W, /obj/item/weapon/night))
		return
	if(istype(OH, /obj/item/weapon/night))
		hand = !hand
		return
	if(W)
		if(OH)
			if(NODROP in W.flags && !(NODROP in OH.flags))
				hand = !hand
				update_hud()
			if(NODROP in W.flags && NODROP in OH.flags)
				if(W.force < OH.force)
					hand = !hand
					update_hud()
		else
			if(NODROP in W.flags)
				hand = !hand
	if(W && W.force < 5) //If the 'weapon' they wield isn't much of a weapon at all.
		src.drop_item()
		W = null
	//Pulls the best weapon from their inventory so the beserk AI is actually dangerous.
	var/obj/item/best_force = W
	var/list/guns = list()
	var/list/available = list()
	for(var/obj/item/G in view(1, src)) //We can grab things off the ground, too. But we won't go out of our way to pick them up.
		available.Add(G)
	for(var/obj/item/P in src.contents)
		available.Add(P)
		for(var/obj/item/P2 in P.contents)
			available.Add(P2) //Should get stuff inside backpacks.
	for(var/obj/item/O in available)
		if(istype(O, /obj/item/weapon/implant)) continue
		if(istype(O, /obj/item/organ)) continue
		if(NODROP in O.flags) continue
		if(O == W) continue
		if(O.force < 5) continue
		if(!best_force || O.force > best_force.force)
			best_force = O
		if(istype(O, /obj/item/weapon/gun))
			guns.Add(O)
	if(guns.len && !(target in view(2, src))) //If the target is far away, guns are probably better.
		if(src.get_active_hand())
			if(src.back.contents.len < 7)
				src.equip_to_slot_or_del(src.get_active_hand(), slot_in_backpack)
			else
				src.drop_item()
		src.put_in_hands(pick(guns))
	else
		if(best_force && best_force != W)
			if(src.get_active_hand())
				if(src.back.contents.len < 7)
					src.equip_to_slot_or_del(src.get_active_hand(), slot_in_backpack)
				else
					src.drop_item()
			src.put_in_hands(best_force)

/mob/living/carbon/human/proc/auto_attack(var/mob/living/target) //Should robustly use guns and melee when it is best to do so.
	if(src.stat != CONSCIOUS) return
	if(src.lying) return
	if(ishuman(target))
		var/mob/living/carbon/human/htarget = target
		if(src.berserkmaster == htarget || (src.berserkmaster && src.berserkmaster == htarget.berserkmaster))
			walk(src, 0)
			berserktarget = null
			return
	src.auto_equip(target)
	var/obj/item/W = src.get_active_hand()
	if(target in view(1, src))
		if(!W) //Hits them if we are not holding anything.
			changeNext_move(CLICK_CD_MELEE)
			//target.attack_hand(src) //...why isn't this working?
			src.UnarmedAttack(target, 1)
		else
			W.attack(target, src, src.zone_sel.selecting) //If it is a weapon but not a gun, wacks them with it.
	else
		if(istype(W, /obj/item/weapon/gun)) //Shoots a gun if it is in hand and you are at a distance.
			var/obj/item/weapon/gun/G = W
			if(istype(G, /obj/item/weapon/gun/energy)) //energy guns need this to run first for them to successfully fire
				var/obj/item/weapon/gun/energy/E = G
				E.newshot()
			if(G.chambered) //For some reason afterattack was throwing errors about complex tools, so this eliminates those checks.
				if(!G.chambered.fire(target, src, null, 0, 0))
					G.shoot_with_empty_chamber(src)
					src.drop_item()
				else
					if(get_dist(src, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
						G.shoot_live_shot(src, 1, target)
					else
						G.shoot_live_shot(src)
			else
				G.shoot_with_empty_chamber(src)
				src.drop_item()
			G.process_chamber()
			G.update_icon()
	if(!target || target.stat == DEAD) //then we need to find a new living target
		walk(src, 0)
		berserktarget = null

/mob/living/carbon/human/proc/handle_berserk()
	if(src.lying) walk(src, 0)
	if(src.stat != CONSCIOUS) return
	if(!berserktarget)
		for(var/mob/living/M in oview(7, src))
			if(M && M.stat != DEAD)
				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					if(src.berserkmaster == H || (src.berserkmaster && src.berserkmaster == H.berserkmaster))
						continue
				berserktarget = M
				break
	else
		if(!(berserktarget in view(1, src)))
			auto_move(berserktarget)
			spawn(10)
				if(!(berserktarget in view(1, src)))
					auto_move(berserktarget)
		auto_attack(berserktarget)
		spawn(10)
			auto_attack(berserktarget)

/mob/living/carbon/human/ClickOn(var/atom/A, params) //Some combat interface things.
	var/list/modifiers = params2list(params)           //Shift+Click to attack with the off-hand.
	if(modifiers["shift"])
		if(isliving(A))
			var/mob/living/M = A
			var/obj/item/W = src.get_inactive_hand()
			if(W && !istype(W, /obj/item/weapon/gun))
				if(M in view(1, src))
					if(!offhand_cooldown)
						offhand_cooldown = 1
						spawn(5) offhand_cooldown = 0
						W.attack(M, src, src.zone_sel.selecting)
						return
	if(modifiers["ctrl"])
		if(isliving(A))
			var/mob/living/M = A
			var/obj/item/W = src.get_active_hand()
			if(W && W.complex_click)
				W.handle_ctrlclick(src, M)
				return
	..()