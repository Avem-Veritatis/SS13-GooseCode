/obj/effect/proc_holder/spell/targeted/mime/concentrate
	name = "Concentrate"
	desc = "Stretch out with your senses."
	school = "mime"
	panel = "Mime"
	invocation = "none"
	invocation_type = "none"
	clothes_req = 0
	human_req = 1
	charge_max = 200
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/concentrate/cast(list/targets)
	for(var/mob/living/carbon/human/U in targets)
		if(!ishuman(U))
			U << text("<span class='notice'>Wait.. what are you?.</span>")
			return
		if(U.stat == DEAD)
			U <<"Looks like we went to that big theater in the sky!"							//user is dead
			return
		if(!U.canmove || U.stat || U.restrained())
			U <<"Kinda hard to do that at the moment."
			return
		if(U.brainloss >= 60)
			U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//user is stupid
			U << text("<span class='notice'>Your head feels funny.</span>")
			U << text("<span class='notice'>Oh crap. You need to call an adult!</span>")
			return
		switch(U.purity)
			if(1 to INFINITY)
				U << text("<span class='notice'>There was something you needed to remember. What was it?</span>")
				U.purity = 0
			if(0)
				U << text("<span class='notice'>How did I even get here? Did I arrive with these humans? Humans... why do I call them that?</span>")
				U.purity--
			if(-1)
				U << text("<span class='notice'>Humans. Always so many humans. They breed like rabbits. Or maybe it just seems that way. It wasn't always like this.</span>")
				U.purity--
			if(-2)
				U << text("<span class='notice'>They tortured you. Not the humans. Your own kind. Terrible monsters that they were. They tortured others as well. Humans mostly. How long did you spend in that cage?</span>")
				U.purity--
			if(-3)
				U << text("<span class='notice'>With these clothes they think you are some kind of performer. They think you are from ArchAngel II. But you have always been here. Ever since you escaped from Camorrah. These humans started building and you just walked inside.</span>")
				U.purity--
			if(-4)
				U << text("<span class='notice'>They gave you food and spoke low gothic. You don't look human, but you might as well be. The warp altered you. There was something... something else to remember. You need to focus.</span>")
				U.purity--
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/focus(null)
			if(-5)
				U << text("<span class='notice'>It's gnawing at the back of your mind. Focus.</span>")
			if(-7)
				U << text("<span class='notice'>You remember now. You escaped here through the warp. Lept from the walls of Camorrah and fled through the red swirling madness. Slaanesh pulled at you, tried to take you. You were broken and wounded. A human saved you and he did so at a terrible cost to himself. You are free now. Free at last.</span>")
				U.purity--
			if(-8)
				U << text("<span class='notice'>Hiding. You are good at hiding. You've been hiding for a long long time. Not from humans. You've been hiding from THEM. They looked for you. They must have looked all over. Maybe thats why you are here now. Maybe you are tired of hiding. Perhaps you want to be found. Thats a dark thought. They'd kill you if they found you. You've become too much of a problem for them.</span>")
				U.purity--
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/stealth(null)
			if(-9)
				U << text("<span class='notice'>A dreamstone. That is what you need. If you want to cheat Slaanesh you must join the ranks of Ynnead. But where can we get a Spirit Stone on this frozen rock? There is one way... but it is dangerous. You'll need to find a laserpointer.</span>")
				U.purity--
			if(-10)
				if(istype(U.l_hand, /obj/item/device/laser_pointer))
					usr.visible_message("<span class='notice'>[usr] pulls the device apart and begins to reconfigure it.</span>", "<span class='notice'>Not sure if this will work but it is worth a shot.</span>", "<span class='warning>You can't see shit.</span>")
					qdel(usr.l_hand)
					new /obj/item/device/hacktool(U.loc)
					U.purity--
				else if(istype(U.r_hand, /obj/item/device/laser_pointer))
					usr.visible_message("<span class='notice'>[usr] pulls the device apart and begins to reconfigure it.</span>", "<span class='notice'>Not sure if this will work but it is worth a shot.</span>", "<span class='warning>You can't see shit.</span>")
					qdel(usr.r_hand)
					new /obj/item/device/hacktool(U.loc)
					U.purity--
				else
					U << text("<span class='notice'>You just need a laserpointer. Where can you find something like that?.</span>")
			if(-11)
				U << text("<span class='notice'>We will need to use this device on a webway gate. If memory serves you, you can find a Dream Stone at Crone21775. But be careful. That is in the eye of terror. Right in the center of it.</span>")
				U.purity--
			if(-12)
				if(istype(U.l_hand, /obj/item/device/soulstone))
					usr.visible_message("<span class='notice'>[usr] stares at a small red crystal.</span>", "<span class='notice'>Yes. This is it. This is what we need to survive.</span>", "<span class='warning>You can't see shit.</span>")
					U.purity--
				else if(istype(U.r_hand, /obj/item/device/soulstone))
					usr.visible_message("<span class='notice'>[usr] stares at a small red crystal.</span>", "<span class='notice'>Yes. This is it. This is what we need to survive.</span>", "<span class='warning>You can't see shit.</span>")
					U.purity--
				else
					U << text("<span class='notice'>Hold that soulstone in your hand. You must hold it. You must bind with it!</span>")
			if(-13)
				U << text("<span class='notice'>It makes sense doesn't it? You kind forgot the old gods and in turn, they have all turned their backs on you. Standing still and waiting to be devoured by 'she who thirsts'. Every one of them destroyed. All except Cegorach.</span>")
				U.purity--
			if(-14)
				U << text("<span class='notice'>Why make another god to fight for you, when you still have one left. Cegorach helped you escape that place. Maybe you didn't see him. Maybe you did not hear his voice. But you should have died when you lept into the warp. Something must have guided you. Something- some one.</span>")
				U.purity--
				new /mob/living/eventmob/darkeldarone(U.loc)
			if(-15)
				U << text("<span class='notice'>It's time to stop fighting the humans. Time to stop fighting your own kind. Time to end this worthless war. There is only one enemy here and it is Slaanesh. Cegorach did not abandon you. It is time for you to join him.</span>")
				U.status_flags = 0
				U.health = 200
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/hop(null)
				U.purity--
			if(-16)
				U << text("<span class='notice'>This mask was a nice touch. It was just laying there on the floor and you put it on. It helped you to escape that place. But who are you in this grand dance of humans and necrons? Time to make another choice.</span>")
				U.purity--
			if(-17)
				for(var/obj/item/clothing/mask/gas/mime/X in U.contents)
					if (X.harl)
						if (istype(X, /obj/item/clothing/mask/gas/mime/solitare))
							U.purity--
							U << text("<span class='notice'>The Dark Prince. Excellent choice. You must play the role of your greatest enemy. Only then can you understand her and one day defeat her at her own game.</span>")
							return
						if (istype(X, /obj/item/clothing/mask/gas/mime/cegorach))
							U.purity--
							U << text("<span class='notice'>They say that the Laughing God wears this mask and walks among his followers, playing the role of himself. Truly, he is the only one qualified.</span>")
							return
						if (istype(X, /obj/item/clothing/mask/gas/mime/death))
							U.purity--
							U << text("<span class='notice'>Death. The role that must be played. Shameful as it is, this mask appears very often on the grand stage. Joyful will be the day when no one plays it.</span>")
							return
						if (istype(X, /obj/item/clothing/mask/gas/mime/blind))
							U.purity--
							U << text("<span class='notice'>Serephinia, how you tried to prevent all of this. Where are your children now?</span>")
							return
					else
						U << text("<span class='notice'>Use a crayon on the mask.</span>")
						return
				U << text("<span class='notice'>Use a crayon on the mask.</span>")
			if(-18)
				U << text("<span class='notice'>So you have chosen a face to bear. The right costume is necessary if you are to perform in the great dance that is battle. By the light of your performance, perhaps the humans and some day your own kind will remember the one true enemy.</span>")
				U.purity--
				new /mob/living/eventmob/darkeldartwo(U.loc)
			if(-19)
				U << text("<span class='notice'>If you are to follow the dance of the laughing god, you must complete your costume. Your uniform. Let us begin with that.</span>")
				U.purity--
			if(-20)
				for(var/obj/item/clothing/under/C in U.contents)
					if(istype(C, /obj/item/clothing/under/harlequin))
						U << text("<span class='notice'>Excellent. This looks somewhat better. There is still several things you will need to become a true performer for Cegorach. Let us move on to your shoes. They could use some reinforcing.</span>")
						U.purity--
						return
				U << text("<span class='notice'>Dye your mime's outfit in the washing machine by washing it with a pen.</span>")
			if(-21)
				if( (istype(U.get_active_hand(), /obj/item/clothing/shoes) && istype(U.get_inactive_hand(), /obj/item/stack/sheet/metal)) || (istype(U.get_inactive_hand(), /obj/item/clothing/shoes) && istype(U.get_active_hand(), /obj/item/stack/sheet/metal)) )
					U.visible_message("[U] reinforces the shoes with metal.")
					qdel(U.get_active_hand())
					qdel(U.get_inactive_hand())
					var/obj/item/clothing/shoes/swat/harlequin/HB = new /obj/item/clothing/shoes/swat/harlequin(U)
					U.put_in_hands(HB)
					spawn(30)
						U << text("<span class='notice'>Yes... Good... You are getting good at creating this costume, even with quite limited materials. Now for the gloves. They need some color.</span>")
						U.purity--
				else
					U << text("<span class='notice'>You will need to hold a pair of shoes and some metal to do this.</span>")
			if(-22)
				for(var/obj/item/clothing/gloves/combat/harlequin/HG in U.contents)
					U << text("<span class='notice'>Good. This is coming together well. Now that you have proven yourself on the crone world and taken the mask of the harlequin, it is only fitting that you look the part.</span>")
					U.purity--
					return
				U << text("<span class='notice'>Use a crayon on those white gloves of yours.</span>")
			if(-23)
				U << text("<span class='notice'>Now that hat. I know just the thing. Get out your beret.</span>")
				U.purity--
				new /mob/living/eventmob/darkeldarthree(U.loc)
			if(-24)
				if(istype(U.get_active_hand(), /obj/item/clothing/head/beret))
					U.visible_message("[U] sticks some kind of plume in the beret!")
					qdel(U.get_active_hand())
					U.put_in_hands(new /obj/item/clothing/head/helmet/harlequin(U))
					U.purity--
				else
					U << text("<span class='notice'>Hold your beret in your hand. You need to modify it.</span>")
			if(-25)
				U << text("<span class='notice'>Hm... Your costume is nearly complete. Once it is, you will be nearer to finalizing your oath to Cegorach. But now you need something to cap off your apparel... Something to protect you in battle and deliver the right performance at once. The coat of a true harlequin.\n\nNow, apparently the human's have a celebrity stationed at this place. I am sure they can help you with a matter of fashion like this. The autodrobe on that ship probably has something good for your needs. The celebrity though... You have an unexplainable sense of unease. Best be careful.</span>")
				U.purity--
			if(-26)
				U << text("<span class='notice'>You don't remember how this got in your pocket... It might be the work of the laughing god. You have a feeling it will help you get the armor you need.</span>")
				U.visible_message("[U] fishes a strange coin out of \his pocket!")
				new /obj/item/weapon/coin/harlequin(U.loc)
				U.purity--
			if(-27)
				for(var/obj/item/clothing/suit/armor/harlequin/HS in U.contents)
					U << text("<span class='notice'>Very good. Now you really look like a harlequin, and your new costume will be effective on the battle field, with the laughing god's guidance ever behind you.</span>")
					U.purity--
					return
				for(var/mob/living/carbon/human/H in range(1, src))
					if(H != src && H.stat == DEAD && (/mob/living/carbon/human/proc/celebshuttle in H.verbs)) //If they are dead and they have the celeb implant.
						U.visible_message(text("<span class='alert'>[U] activates a tiny wrist mounted control panel on [H]'s corpse. Implants are so useful!</span>"))
						var/datum/shuttle_manager/s = shuttles["celeb"]
						if(istype(s)) s.move_shuttle(0,1)
						return
				U << text("<span class='notice'>You need to gain access to the celebrity's wardrobes... Use that coin somehow... Somehow you need to get the celebrity to call his ship down for you. If the celebrity dies... Well I guess you can always use the controller on the body.</span>")
			if(-28)
				U << text("<span class='notice'>You need a proper weapon now... Perhaps... There is still something you must remember.</span>")
				U.purity--
			if(-29)
				U << text("<span class='notice'>Where... There was something before this outpost... Before you came here even.</span>")
				U.purity--
			if(-30)
				U << text("<span class='notice'>Some kind of room... It must be hidden now.</span>")
				U.purity--
			if(-31)
				U << text("<span class='notice'>The mining station. There is something at the mining station. Go to the eastern building down the pathway.</span>")
				U.purity--
				new /mob/living/eventmob/darkeldarfour(U.loc)
			if(-32)
				for(var/obj/effect/landmark/mimefalsewall/MF in range(2, U))
					U << text("<span class='notice'>Yes... This is the right place.</span>")
					var/turf/T = get_turf(MF)
					T.ChangeTurf(/turf/simulated/floor/plating)
					var/obj/structure/falsewall/reinforced/R = new /obj/structure/falsewall/reinforced(T)
					R.opening = 1
					R.do_the_flick()
					spawn(4)
						R.density = 0
						R.SetOpacity(0)
						R.update_icon(0)
					for(var/obj/effect/landmark/mimeequipmentdrop/ME in landmarks_list)
						new /obj/item/weapon/powersword/harlequin(get_turf(ME))
					for(var/obj/effect/landmark/mimeopponentdrop/MO in landmarks_list)
						new /mob/living/simple_animal/hostile/faithless/harlequin(get_turf(MO))
					U.purity--
					return
				U << text("<span class='notice'>The power room. That little mining building the humans built up has a power room. Something... Something there. Something was there before the humans were.</span>")
			if(-33)
				for(var/obj/item/weapon/powersword/harlequin/HB in U.contents)
					U << text("<span class='notice'>Now <i>this</i> is a suitable weapon. It must have remained in here for centuries... And that creature was attracted to it's power. It is yours now. You do not know the blade's story; it may have served one of the darker souls of your kind, or it may have served a performer for the laughing god. But you will forge a new story for it. A good one.</span>")
					U.purity--
					return
				U << text("<span class='notice'>There is a weapon in there. You <b>need</b> that weapon.</span>")
				return
			if(-34)
				U.purity--
				var/mob/living/simple_animal/hostile/retaliate/mandrake/M = new(U.loc)
				while(U.health > -99)
					if(!M)
						return
					else if(!U)
						qdel(M)
						return
					else if(U.paralysis > 1)
						M.loc = U.loc
						sleep(20)
						qdel(M)
						U.gib()
						return
					else if(M.health > 0)
						M.loc = U.loc
						U.apply_damage(15, BRUTE, "head")
						playsound(M.loc, 'sound/effects/eldar2.ogg', 75, 0)
						usr.visible_message("<span class='notice'>[usr] is stabbed in the throat by some kind of creature!</span>", "<span class='notice'>You've been stabbed in the throat!</span>", "<span class='warning>You can't see shit. But there is some crazy stuff going down!</span>")
						sleep(120)
					else
						qdel(M)
						return
			if(-35)
				U << text("<span class='notice'>The Exhiles survived because they ran... but one can only run so far before they have to turn and fight. Time to hone these new skills.</span>")
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/shrieker(null)
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/swap(null)
				U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/trick(null)
				for(var/obj/effect/proc_holder/spell/targeted/mime/concentrate/D in U.mind.spell_list)
					U.mind.spell_list.Remove(D)



/obj/effect/proc_holder/spell/targeted/mime/focus
	name = "Focus"
	desc = "Stretch out with your senses."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 750
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/focus/cast(list/targets)
	for(var/mob/living/carbon/human/U in targets)
		if( U.purity == -5 )
			U << text("<span class='notice'>You need to stand still and focus for a moment. This is important.</span>")
			U.purity--
			return
		if( U.purity == -6 )
			U << text("<span class='notice'>It's..... almost....</span>")
			U.purity--
			return
		if( U.purity < -6 )
			U << text("<span class='notice'>You stretch out with your senses.</span>")
			for(var/i=0, i<8, i++)
				sleep (60)
				if(U) U.client.view++
			sleep(120)
			if(U) U.client.view = 7
	..()

/*
stealth
*/

/obj/effect/proc_holder/spell/targeted/mime/stealth
	name = "Stealth"
	desc = "Hiding is like second nature to you."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/stealth/cast(list/targets)
	for(var/mob/living/carbon/human/U in targets)
		U.invisibility = INVISIBILITY_LEVEL_TWO
		spawn(0)
			anim(U.loc,U,'icons/mob/mob.dmi',,"cloak",,U.dir)
		U.alpha = 0
		U << "\blue You are now invisible to normal detection."
		for(var/mob/O in oviewers(U))
			O.show_message("[U.name] vanishes into thin air!",1)
		sleep(120)
		if(U)
			spawn(0)
				anim(U.loc,U,'icons/mob/mob.dmi',,"uncloak",,U.dir)
			U.alpha = 255
			U << "\blue You are now visible."
			for(var/mob/O in oviewers(U))
				O.show_message("[U.name] appears from thin air!",1)
		U.invisibility = 0
	..()

/*
Battle Dance
*/

//The idea is to laugh, drop smoke and hop from target to target stunning everyone.
//This could get wonky with the mime bouncing through glass. People might also scream OP. But I have to see this happen. It's going to be incredible. I'll give it a long charge rate.

/obj/effect/proc_holder/spell/targeted/mime/hop
	name = "Battle Dance"
	desc = "Jump from person to person."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/hop/cast()				//we hijack the click!! Take this click to cuba!!!

	if(!usr) return
	if(!ishuman(usr)) return

	var/mob/living/carbon/human/H = usr
	if(H.gender == MALE)
		var/mimelaugh = pick('sound/voice/mimelaugh1.ogg','sound/voice/mimelaugh2.ogg')
		playsound(H.loc, mimelaugh, 75, 0)
	else
		var/mimelaugh = pick('sound/voice/mimelaughf1.ogg','sound/voice/mimelaughf2.ogg')
		playsound(H.loc, mimelaugh, 75, 0)
	var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
	smoke.set_up(10, 0, H.loc)
	smoke.start()
	H.dodging = 2
	for(var/mob/living/O in viewers(world.view, H.loc))
		H.loc = O.loc
		if(ishuman (O))
			O << "<font color='red'>[H] Lunges at you!</font>"
			var/mob/living/carbon/human/M = O
			M.Weaken(4)
		sleep(10)
	sleep(300)
	H.dodging = 0

	..()
/*
Kiss of Death
*/

/obj/item/kod
	name = "A sword"
	desc = "Used for reconfiguring Eldar Gateways."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "blade_s"

/obj/effect/proc_holder/spell/targeted/mime/kod
	name = "Kiss Of Death"
	desc = "Some people just deserve to die."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	max_targets = 1
	charge_max = 1000
	clothes_req = 0
	human_req = 1
	var/thrown = 0
	var/cycle = 0

/obj/effect/proc_holder/spell/targeted/mime/kod/cast(list/targets) //Hexed out for now just to compile...
	return                                                           //Also I suspect that mime targeted spells only effect the caster...
	/*
	if(!usr) return
	if(!ishuman(usr)) return
	thrown = 1
	var/obj/item/kod/S = new(usr.loc)
	S.pixel_y = 30
	spawn (0)
		while (thrown)
			S.pixel_y++
			cycle++
			if (cycle > 30)
				thrown = 0
				for(var/mob/living/target in targets)
					if(!usr)
						usr << "What the? Who are you?"
						return

					if(!isliving(usr) || usr.stat || usr.restrained() || usr.lying)
						user << "You can not do that while restrained."
						return
					if(istype(target, /mob/living/carbon))
						var/mob/M =	target
						M.Weaken(1)
						step_away(M,src,15)
						step_away(M,src,15)
						step_away(M,src,15)
						user.visible_message("<span class='notice'>[usr] stabs [M] with some kind of blade!</span>", "<span class='notice'>You stab [M] with your sword!</span>")

					target.mutations.Add(mutations)
		target.disabilities |= disabilities
		target.update_mutations()	//update target's mutation overlays
		spawn(duration)
			target.mutations.Remove(mutations)
			target.disabilities &= ~disabilities
			target.update_mutations()

			sleep(1)


	return
*/

/*
hack tool
*/
/obj/item/device/hacktool
	name = "An Eldar Device"
	desc = "Used for reconfiguring Eldar Gateways."
	icon = 'icons/obj/device.dmi'
	icon_state = "gatewrench"
	item_state = "pen"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = 2 //Increased to 2, because diodes are w_class 2. Conservation of matter.
	origin_tech = "combat=1;magnets=2"
	var/injectid = "Crone21775"
	var/oldname = "Crone21775"

/obj/item/device/hacktool/attack_self(mob/user as mob)
	interact(user)

/obj/item/device/hacktool/interact(mob/user as mob)

	if(!user)
		user << "What the? Who are you?"
		return

	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		user << "Just.... can't.... reach...."
		return

	else
		injectid = input(user,"Enter Gate ID", "Name change",injectid) as text
		user.visible_message("<span class='notice'>[user] reconfigures the Eldar device.</span>", "<span class='notice'>Resetting interface device.</span>", "<span class='warning'>You can't see shit.</span>")
	add_fingerprint(user)

//I have a loose idea that there will be a unique power granted depending on the mask you choose, which you will gain access to while you fight the mandrake.
//With that in mind, I have made a bunch of random harlequin spells.

/obj/effect/proc_holder/spell/targeted/mime/shrieker //Just writing a bunch of random harlequin powers... As seen in the lictor, I love making verbs like this.
	name = "Shrieker Cannon"
	desc = "Fire a shrieker cannon and then appear somewhere else."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/shrieker/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/H = usr
	if(H.gender == MALE)
		var/mimelaugh = pick('sound/voice/mimelaugh1.ogg','sound/voice/mimelaugh2.ogg')
		playsound(H.loc, mimelaugh, 75, 0)
	else
		var/mimelaugh = pick('sound/voice/mimelaughf1.ogg','sound/voice/mimelaughf2.ogg')
		playsound(H.loc, mimelaugh, 75, 0)
	H.visible_message("\red [H] fires the Shrieker Cannon!", "\red You fire the Shrieker Cannon.")
	var/turf/T = H.loc
	var/turf/U = get_step(H, H.dir)
	if(!isturf(U) || !isturf(T))
		return
	var/obj/item/projectile/bullet/dart/shrieker/A = new /obj/item/projectile/bullet/dart/shrieker(H.loc)
	A.current = U
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	A.process()
	spawn(10)
		H.alpha = 0
		var/list/posturfs = circlerangeturfs(get_turf(H),4)
		var/turf/destturf = safepick(posturfs)
		H.loc = destturf
		var/area/destarea = get_area(destturf)
		destarea.Entered(H)
		var/datum/effect/effect/system/harmless_smoke_spread/smoke = new /datum/effect/effect/system/harmless_smoke_spread()
		smoke.set_up(10, 0, H.loc)
		smoke.start()
		animate(H, alpha = 255, time = 5)
	..()

/obj/effect/proc_holder/spell/targeted/mime/swap
	name = "Shadows"
	desc = "Move with dizzying speed and leave an image of yourself in your place."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 100
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/swap/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/H = usr
	H.dodging = 1
	spawn(50) H.dodging = 0
	var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H)) //Leaves a shadow in their place.
	S.icon = H.icon
	S.icon_state = H.icon_state
	S.overlays = H.overlays
	S.alpha = H.alpha
	spawn(23)
		animate(S, alpha = 0, time = 10)
	H.alpha = 0
	spawn(23) animate(H, alpha = 255, time = 10)
	var/list/posturfs = circlerangeturfs(get_turf(H),4)
	var/turf/destturf = safepick(posturfs)
	H.loc = destturf
	var/area/destarea = get_area(destturf)
	destarea.Entered(H)
	..()

/obj/effect/proc_holder/spell/targeted/mime/trick //This might turn out to just be irritating, but while I am writing miscillaneous harlequin verbs I might as well...
	name = "Trick (You have to stand right next to some one)"
	desc = "Do the god of pranks proud."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 300
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/trick/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	for(var/mob/living/carbon/human/H in range(1, usr))
		if(H != usr)
			var/obj/item/weapon/grenade/G
			if(istype(H.l_store, /obj/item/weapon/grenade))
				G = H.l_store
			if(istype(H.r_store, /obj/item/weapon/grenade))
				G = H.r_store
			if(G)
				usr.visible_message("\red [usr] pulls the pin on the [G] in [H]'s pocket!", "You pull the pin on the [G] in [H]'s pocket! What a prank!", "You hear a clicking sound.")
				G.attack_self(usr)
				..()
				return
			var/randprank = rand(1, 2)
			switch(randprank)
				if(1)
					var/obj/item/weapon/legcuffs/beartrap/BT = new /obj/item/weapon/legcuffs/beartrap(get_turf(usr))
					BT.armed = 1
					BT.update_icon()
					usr << "\red You drop the [BT]."
					usr.start_pulling(H)
					step(usr, get_dir(usr, get_step_away(usr, H)))
				if(2)
					usr.visible_message("\red [usr] stabs [H] with a small needle!")
					H.reagents.add_reagent(pick("curare", "chloralhydrate", "hallucinations", "fatigue"), 5)
	..()

/obj/effect/proc_holder/spell/targeted/mime/smoke
	name = "Smoke"
	desc = "Disappear in a plume of smoke and reform later."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 100
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/smoke/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/H = usr
	var/datum/effect/effect/system/bad_smoke_spread/smoke = new /datum/effect/effect/system/bad_smoke_spread()
	smoke.set_up(10, 0, H.loc)
	smoke.start()
	var/obj/effect/effect/bad_smoke/harlequin/harl = new /obj/effect/effect/bad_smoke/harlequin(get_turf(H))
	harl.user = H
	H.loc = harl
	..()

/obj/item/weapon/coin/harlequin
	sideslist = list("the laughing god","she who thirsts")
	luckyside = "the laughing god"
	unluckyside = "she who thirsts"
	cmineral = "harlequin"

/obj/item/weapon/coin/harlequin/New()
	..()
	icon_state = "coin_harlequin_the laughing god"

/obj/effect/landmark/mimefalsewall //This will create the stash from which the mime gets a special blade.
	name = "Mime False Wall"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/mimefalsewall/New()
	..()
	invisibility = 100

/obj/effect/landmark/mimeequipmentdrop //Spawns the blade.
	name = "Mime Equipment Drop"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/mimeopponentdrop //Drops an opponent in the stash so they don't get it for nothing. Not nearly as difficult as the mandrake, but still something. Some kind shade I think. Purple, of coarse.
	name = "Mime Opponent Drop"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0