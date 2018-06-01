/*
H.verbs += /mob/living/carbon/human/proc/celebfall		 //This is how we get the verb! Insert into the job equip. civilian.dm
All of this plays off the variable purity.
var/purity = 0			//move to /mob/living/carbon/human
The files themselves will be located in the corruption folder on the job folder.
This particular proc will function as a master controller for all procs used in the Celebrity's downfall.
Not all roles will have the oppertunity to join chaos. Not all roles will be able to effect a negative purity rating.
In the future there will be oppertunities for POSITIVE purity ratings. But for now this proc will master control
for the negative portions. -Norc
*/

/mob/living/carbon/human/proc/celebfall()
	set category = "Celebrity"
	set name = "Fuck Sobriety!"
	set desc = "I didn't make it this far by following THIER rules."
	//set src in usr
	var/mob/living/carbon/human/U = src
	if(!ishuman(src))
		usr << text("<span class='notice'>Wait.. what are you?.</span>")
		return
	if(U.stat == DEAD)
		U <<"Looks like we went to that big disco in the sky!"							//user is dead
		return
	if(!U.canmove || U.stat || U.restrained())
		U.say("Bartender! A little help here!")	//user is tied up
		return
	if(U.brainloss >= 60)
		U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//user is stupid
		U.visible_message(text("<span class='alert'>[U] stares blankly.</span>"))
		U << text("<span class='notice'>Your head feels funny.</span>")
		U << text("<span class='notice'>Oh crap. You need to call an adult!</span>")
		U.say("Sing us a song you're the piano man! Sing us a song tonight!!</span>")
		return
	switch(U.purity)
		if(1 to INFINITY)
			U << text("<span class='notice'>You renounce the Emperor and all that nonsense.</span>")
			U.purity = 0
		if(0)
			U << text("<span class='notice'>Yeah! We don't need their stupid rules. We can at least have a beer. Just one beer. What is the worst that could happen? Lets go find a bottle of beer.</span>")
			U.purity--
		if(-1)
			if(istype(U.l_hand, /obj/item/weapon/reagent_containers/food/drinks/beer))
				qdel(usr.l_hand)
				usr.visible_message("<span class='notice'>[usr] downs the entire beer like some one that hasn't had one in a while.</span>", "<span class='notice'>You drink the shit out of that beer.</span>", "<span class='warning>You smell beer.</span>")
				playsound(src.loc, 'sound/items/drink.ogg', 50, 1)
				usr.update_inv_hands()
				U.purity--
			else if(istype(U.r_hand, /obj/item/weapon/reagent_containers/food/drinks/beer))
				qdel(usr.r_hand)
				usr.visible_message("<span class='notice'>[usr] downs the entire beer like some one that hasn't had one in a while.</span>", "<span class='notice'>You drink the shit out of that beer.</span>", "<span class='warning>You smell beer.</span>")
				usr.update_inv_hands()
				playsound(src.loc, 'sound/items/drink.ogg', 50, 1)
				U.purity--
			else
				U << text("<span class='notice'>What the crap? This isn't beer. It has to be a beer- just like old times. A beer in a beer bottle with a label on it that says 'space beer'. AND you have to be holding it in your hand!")
				return
		if(-2)
			U << text("<span class='notice'>Oh man that was nice! That really hit the spot. You know what would wash this down? Some blow. We need to get our hands on some laserbrain dust. I'm pretty sure there is some inside your ship some where.</span>")
			U.maxHealth = 150
			U.health = 150
			U.purity--
		if(-3)
			if(U.reagents.has_reagent("stimulant"))
				U << text("<span class='notice'>Oh holy crap man! That was awesome! Are you feeling better? I'm feeling better. This is nice. REAL nice.</span>")
				U.purity--
			else
				U << text("<span class='notice'>Man I am a disembodied voice in your head! Did you really think you can trick me? Go get that Laserbrain dust! FUCKING STEAL IT if you have to! Just get it into your body!</span>")
		if(-4)
			U << text("<span class='notice'>That was sweet but it's kind of lonely misbehaving by ourselves. Lets find some one else to get high with. And I know just the thing. WOOPS! Dropped it on the ground. Hope no one saw.</span>")
			new /obj/item/clothing/mask/cigarette/celeb(U.loc)
			new /obj/item/weapon/lighter/zippo(U.loc)

			U.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette/celeb(U), slot_l_hand)
			U.visible_message(text("<span class='alert'>[U] pulls out a cigarette and smiles at it.</span>"))
			U << text("<span class='notice'>I forgot we had this. This will do nicely. Lets find some one to share it BEFORE we light it up.</span>")
			U.maxHealth = 200
			U.health = 200
			U.factions += "SLAANESH"
			U.purity--
			var/obj/item/device/celebhacktool/C = new /obj/item/device/celebhacktool(U.loc)
			U << "\red Hm? What's this? This [C] was also in our pocket."
		if(-5)
			U << text("<span class='notice'>Puff puff give, you know how this works.</span>")	//had to put this in because everyone kept spawning multiple ciggarettes and wondering why it wasn't working.
		if(-6)
			U << text("<span class='notice'>It has been a while since we jammed. I'm pretty sure we have an instrument in the closet on the south side of the ship. Lets grab it and see what we can manage.</span>")
			U.purity--
		if(-7)
			if(istype(U.l_hand, /obj/item/weapon/guitar))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the guitar.</span>", "<span class='notice'>This old thing. You have spent half your life with instruments like this. Lets tune it up a bit. We'll need a screwdriver.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else if(istype(U.r_hand, /obj/item/weapon/guitar))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the guitar.</span>", "<span class='notice'>This old thing. You have spent half your life with instruments like this. Lets tune it up a bit. We'll need a screwdriver.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else
				U << text("<span class='notice'>Lets hear some tunes! Go find out old instrument in the ship. It's in there some where. Trust me! I'm a disembodied voice!</span>")
		if(-8)
			if(istype(U.l_hand, /obj/item/weapon/guitar/five))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the guitar.</span>", "<span class='notice'>It's looking nice. It's looking real nice. Lets go show off our new style. It'll be a scream.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else if(istype(U.r_hand, /obj/item/weapon/guitar/five))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the guitar.</span>", "<span class='notice'>It's looking nice. It's looking real nice. Lets go show off our new style. It'll be a scream.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else
				U << text("<span class='notice'>No, this does not look like an upgraded guitar to me. Lets examine it again. Maybe figure out what we are doing wrong.</span>")
		if(-9)
			usr.visible_message("<span class='notice'>[usr] appears lost in thought.</span>", "<span class='notice'>Drugs, music, sex... it's all the same thing you know? It is all passion! What good is all the money in the universe if you don't feel alive? Lets go make ourselves a stun baton. Get some wire and rods and build one from scratch. One that is COMPLETELY ours. We can get a techpriest to help if it turns out to be complicated.</span>", "<span class='warning>You can't see shit.</span>")
			U.purity--
		if(-10)
			if(istype(U.l_hand, /obj/item/weapon/melee/baton/cattleprod) || istype(U.l_hand, /obj/item/weapon/melee/baton))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the baton.</span>", "<span class='notice'>Every second of pain, like every note of music... is power. I think it is coming together now.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else if(istype(U.r_hand, /obj/item/weapon/melee/baton/cattleprod) || istype(U.r_hand, /obj/item/weapon/melee/baton))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the baton.</span>", "<span class='notice'>Every second of pain, like every note of music... is power. I think it is coming together now.</span>", "<span class='warning>You can't see shit.</span>")
				U.purity--
			else
				U << text("<span class='notice'>You need to feel alive again. You need to harm others and BE harmed yourself. What is life even worth if you can not feel anything? Build a stun baton and lets get going.</span>")
		if(-11)
			usr.visible_message("<span class='notice'>[usr] appears lost in thought.</span>", "<span class='notice'>This is where things get tricky. We have learned the secret to TRUE power. The secret to true strength. Instead of running from vice, we have embraced it, faced it, stolen it, eaten it. The music critics can't hold you back anymore and soon... even physics won't be able to hold you back. You have a chance to transcend...but you just need one thing. A human heart. Now I know what you are thinking, you are thinking that is pretty messed up. But don't get shy on me now. This is ArchAngel IV!! There has got to be a few dead bodies laying around here some where. Get a human heart... and then we can find out just how powerful you really are. You will probably need a circular saw for this. Something small and sharp at least. Just aim for the chest and dig it out of there.</span>", "<span class='warning>You can't see shit.</span>")
			U.purity--
		if(-12)
			if(istype(U.l_hand, /obj/item/organ/heart))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the human heart when suddenly it morphs into something else.</span>", "<span class='notice'>I have been guiding you since you first stepped off that ship. You are my chosen and your power shall be limitless. But there is danger. Those that sent you here want you to perish. Your music, your words, your style frees the people that they have enslaved. You liberate all those around you! The imperials fear you for that. We must act quickly. Search the secret tavern for a clue.</span>", "<span class='warning>You can't see shit.</span>")
				qdel(usr.l_hand)
				var/obj/R = locate("landmark*crashclue")
				new /obj/item/weapon/paper/crashclue(R.loc)
				U.equip_to_slot_or_del(new /obj/item/weapon/sblade_stageone(U), slot_l_hand)
				U.purity--
			else if(istype(U.r_hand, /obj/item/organ/heart))
				usr.visible_message("<span class='notice'>[usr] stares intenly at the human heart when suddenly it morphs into something else.</span>", "<span class='notice'>I have been guiding you since you first stepped off that ship. You are my chosen and your power shall be limitless. But there is danger. Those that sent you here want you to perish. Your music, your words, your style frees the people that they have enslaved. You liberate all those around you! The imperials fear you for that. We must act quickly. Search the secret tavern for a clue.</span>", "<span class='warning>You can't see shit.</span>")
				qdel(usr.r_hand)
				var/obj/R = locate("landmark*crashclue")
				new /obj/item/weapon/paper/crashclue(R.loc)
				U.equip_to_slot_or_del(new /obj/item/weapon/sblade_stageone(U), slot_r_hand)
				U.purity--
			else
				U << text("<span class='notice'>You need a human heart. You need to hold it in your hand and assimilate it's power.</span>")
		if(-13)
			U << text("<span class='notice'>The blade needs your strength. Only then will the path be revealed. Hold it in your hand.</span>")
			var/t_his = "it's"
			if (U.gender == MALE)
				t_his = "his"
			if (U.gender == FEMALE)
				t_his = "her"
			if(istype(U.l_hand, /obj/item/weapon/sblade_stageone))
				qdel(usr.l_hand)
				U.equip_to_slot_or_del(new /obj/item/weapon/slaanesh_blade(U), slot_l_hand)
				usr.visible_message("<span class='notice'>[usr] cuts a small symbol into [t_his] forehead.</span>", "<span class='notice'>Holding the blade up to your face, you close your eyes and slowly carve the symbol of Slaanesh into your forehead. Although you have never seen it before, it feels as if it has always been there. The pain is intense but it is the most natural thing you have ever known.</span>", "<span class='warning>Your hair stands on end.</span>")
				src.mutate("mark of slaanesh")
				U.purity--
			else if(istype(U.r_hand, /obj/item/weapon/sblade_stageone))
				qdel(usr.r_hand)
				U.equip_to_slot_or_del(new /obj/item/weapon/slaanesh_blade(U), slot_r_hand)
				usr.visible_message("<span class='notice'>[usr] cuts a small symbol into [t_his] forehead.</span>", "<span class='notice'>Holding the blade up to your face, you close your eyes and slowly carve the symbol of Slaanesh into your forehead. Although you have never seen it before, it feels as if it has always been there. The pain is intense but it is the most natural thing you have ever known.</span>", "<span class='warning>Your hair stands on end.</span>")
				src.mutate("mark of slaanesh")
				U.purity--
			else
				U << text("<span class='notice'>Get out your blade and hold it in your hand. It's time to declare allegiance. True power awaits.</span>")
		if(-14) //Should this maybe check that they are in the right loc? I don't /really/ know quite how this is working...
			U.say("I have travelled north. I have found the ship. Slaanesh, show me the way inside.")
			var/datum/shuttle_manager/s = shuttles["ladder"]
			if(istype(s)) s.move_shuttle(0,1)
			U.purity--
		if(-15)
			U.loud = 1
			U.say("Things will get loud now!")
			src.mutate("tentacles")
			U.purity--
			U.maxHealth = 250
			U.health = 250
			U.status_flags = CANPARALYSE|CANPUSH
			src << "\red You feel stronger."
			award(usr, "Slaanesh's Chosen")
		if(-16)
			U << "<span class='slaanesh'>So... Disciple... I have heard certain whispers of an escaped eldar in your location. This one managed to escape the care of the darker variant of its kind... I would be so pleased if you could capture this one. Crush their spirit stone and keep them in exquisite agony...</span>"
			U.purity--
			U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/celeb/push(null)
		if(-17)
			U << "<span class='slaanesh'>You have done well thus far. Now is the time for you to assume your final form. I grant you the greatest blessing you will ever know. Find a private place and join the eternal party as an ascended champion!</span>"
			U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/celeb/ascention(null)




//Here ends the end of the active path. We can do more with this but from this point on the danger going mad should be EXETREME.

/*
abilities
*/

/obj/effect/proc_holder/spell/targeted/celeb/push
	name = "Expose the Warp"
	desc = "Slaanesh pushes against the very fabric of reality- threatening to break through."
	invocation = "Get Turned up to Death!"
	invocation_type = "none"
	school = "warp"
	panel = "Warp Magic"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1


/obj/effect/proc_holder/spell/targeted/celeb/push/cast()				//we hijack the click!! Take this click to cuba!!!

	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/U = usr
	var/soundfile = 'sound/voice/celeb.ogg'								//droppin beats!
	playsound(U.loc, soundfile, 75, 0)
	var/obj/item/device/soulstone/X
	for(var/mob/living/carbon/human/H in range(9, U.loc))				//who is in range?

		if(H != U)
			H.Jitter(250)												//make them jitter
			spawn(0)
				if(X in H.contents)
					var/eyeofslaanesh = H.name
					if(H.gender == "male")
						U << "Kill [eyeofslaanesh] and bring his soulstone to me!"
						H.Weaken(4)
					if(H.gender == "female")
						U << "Kill [eyeofslaanesh] and bring her soulstone to me!"
						H.Weaken(4)
				else
					H.mutate("slaanesh")
					warppush(H)


	if(iscarbon(U))													//regen but only if people are in range to see it
		U.handcuffed = initial(U.handcuffed)
		if(!U.stat)
			U.heal_organ_damage(2,2)
		if(U.reagents)
			U.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			U.adjustToxLoss(-2)

		for(var/datum/reagent/R in U.reagents.reagent_list)
			U.reagents.clear_reagents()

	U.visible_message("<span class='notice'>Space and time bend before your eyes!!</span>", "<span class='notice'>LETS GET THIS PARTY STARTED!!</span>")


	..()

/obj/effect/proc_holder/spell/targeted/celeb/push/proc/warppush(var/mob/H)
	H.loc = get_turf(locate("landmark*warppush"))
	sleep(240)
	H.loc = get_turf(locate("landmark*warppush2"))



/obj/effect/proc_holder/spell/targeted/celeb/ascention
	name = "Ascention"
	desc = "Become a Champion of Chaos."
	invocation = "MY SOUL FOR YOU!!"
	invocation_type = "none"
	school = "warp"
	panel = "Warp Magic"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/celeb/ascention/cast()				//we hijack the click!! Take this click to cuba!!!
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/U = usr
	new /mob/living/simple_animal/hostile/faithless/slaaneshchampion(U.loc)
	U.visible_message("<span class='notice'>[U] bends and twists into some kind of abomination!</span>", "<span class='notice'>Only your body is needed. Your soul serves me better in the warp.</span>")
	qdel(U)
	..()


/mob/living/simple_animal/hostile/faithless/slaaneshchampion
	name = "Daemonette"
	desc = "A creature of the warp!"
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemonette_dead"