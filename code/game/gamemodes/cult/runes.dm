var/list/sacrificed = list()

/obj/effect/rune
/////////////////////////////////////////FIRST RUNE
	proc
		teleport(var/key)
			var/mob/living/user = usr
			var/allrunesloc[]
			allrunesloc = new/list()
			var/index = 0
			for(var/obj/effect/rune/R in world)
				if(R == src)
					continue
				if(R.word1 == wordtravel && R.word2 == wordself && R.word3 == key && R.z != 2)
					index++
					allrunesloc.len = index
					allrunesloc[index] = R.loc
			if(index >= 5)
				user << "\red You feel pain, as rune disappears in reality shift caused by too much wear of space-time fabric"
				if (istype(user, /mob/living))
					user.take_overall_damage(5, 0)
				qdel(src)
			if(allrunesloc && index != 0)
				if(istype(src,/obj/effect/rune))
					user.say("Break on through[pick("'","`")]to the other side!")//Only you can stop auto-muting
				else
					user.whisper("I[pick("'","`")]move through the warp!")
				user.visible_message("\red [user] disappears in a flash of red light!", \
				"\red You feel as your body gets dragged through the warp!", \
				"\red You hear a sickening crunch and sloshing of viscera.")
				user.loc = allrunesloc[rand(1,index)]
				return
			if(istype(src,/obj/effect/rune))
				return	fizzle() //Use friggin manuals, Dorf, your list was of zero length.
			else
				call(/obj/effect/rune/proc/fizzle)()
				return


		itemport(var/key)
			var/culcount = 0
			var/runecount = 0
			var/obj/effect/rune/IP = null
			var/mob/living/user = usr
			for(var/obj/effect/rune/R in world)
				if(R == src)
					continue
				if(R.word1 == wordtravel && R.word2 == wordother && R.word3 == key)
					IP = R
					runecount++
			if(runecount >= 2)
				user << "\red You feel pain, as rune disappears in the warp caused by too much wear of space-time fabric"
				if (istype(user, /mob/living))
					user.take_overall_damage(5, 0)
				qdel(src)
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					culcount++
			if(user.loc==src.loc)
				return fizzle()
			if(culcount>=1)
				user.say("Grant us[pick("'","`")]the love of nurgle!")
				user.visible_message("\red You feel the warp moving from the rune - like as it was swapped with somewhere else.", \
				"\red You feel the warp moving from the rune - like as it was swapped with somewhere else.", \
				"\red You smell ozone.")
				for(var/obj/O in src.loc)
					if(!O.anchored)
						O.loc = IP.loc
				for(var/mob/M in src.loc)
					M.loc = IP.loc
				return

			return fizzle()

/////////////////////////////////////////SECOND RUNE

		tomesummon()
			if(istype(src,/obj/effect/rune))
				usr.say("Nurgle[pick("'","`")]grant us the power of the DARK-GODS!!")
			else
				usr.whisper("Nurgle[pick("'","`")]grant us the power of the DARK-GODS!!")
			usr.visible_message("\red Rune disappears with a flash of red light, and in its place now a book lies.", \
			"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there's a book.", \
			"\red You hear a pop and smell ozone.")
			if(istype(src,/obj/effect/rune))
				new /obj/item/weapon/tome(src.loc)
			else
				new /obj/item/weapon/tome(usr.loc)
			qdel(src)
			return



/////////////////////////////////////////THIRD RUNE

		convert()
			var/list/mob/living/carbon/human/cultsinrange = list()
			for(var/mob/living/carbon/M in src.loc)
				if(iscultist(M))
					continue
				if(M.stat==2)
					continue
				for(var/mob/living/carbon/C in orange(1,src))
					if(iscultist(C) && !C.stat)		//converting requires one cultist
						cultsinrange += C
						C.say("FOOL[pick("'","`")]JOIN CHAOS!")
				if(cultsinrange.len >= 1)
					M.visible_message("\red [M] writhes in pain as the markings below him glow a bloody red.", \
					"\red AAAAAAHHHH!.", \
					"\red You hear an anguished scream.")
					if(M.mind && M.mind.special_role == "Genestealer Cult Member")
						M << "<font color=\"purple\"><b><i>You are dimly aware of an immaterial force trying to seize control of your mind. Your mind however is thouroughly closed to the warp.</b></i></font>"
						return 0
					if(is_convertable_to_cult(M.mind))
						ticker.mode.add_cultist(M.mind)
						M.mind.special_role = "Cultist"
						M << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
						M << "<font color=\"purple\"><b><i>Assist your new brothers in their service of chaos. Their goal is yours, and yours is theirs. You serve Nurgle above all else. Spread disease and festering rot.</b></i></font>"
					else
						M << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
						M << "<font color=\"red\"><b>And not a single fuck was given, exterminate the cult at all costs.</b></font>"
						if(game_is_cult_mode(ticker.mode))
							if(M.mind == ticker.mode.sacrifice_target)
								for(var/mob/living/carbon/human/cultist in cultsinrange)
									cultist << "<span class='h2.userdanger'>The Chosen One!! <BR>KILL THE CHOSEN ONE!!! </span>"
						return 0
				else
					for(var/mob/living/carbon/human/cultist in cultsinrange)
						cultist << "<span class='warning'>You need more brothers to overcome their lies and make them see Truth. </span>"
			return fizzle()



/////////////////////////////////////////FOURTH RUNE

		tearreality()
			var/list/mob/living/carbon/human/cultist_count = list()
			for(var/mob/M in range(1,src))
				if(iscultist(M) && !M.stat)
					M.say("GRANDFATHER NURGLE![pick("'","`")]JOIN US!")
					cultist_count += M
			if(cultist_count.len >= 9)
				if(game_is_cult_mode(ticker.mode))
					var/datum/game_mode/cult/Cult = ticker.mode
					if("eldergod" in Cult.cult_objectives)
						Cult.eldergod = 0
					else
						message_admins("[usr.real_name]([usr.ckey]) tried to summon the warp too soon.")	// Admin alert because you *KNOW* dickbutts are going to abuse this.
						for(var/mob/M in cultist_count)
							M.reagents.add_reagent("hell_water", 10)
							M << "<span class='h2.userdanger'>YOUR SOUL BURNS WITH YOUR ARROGANCE!!!</span>"
						return
				var/narsie_type = /obj/machinery/singularity/warpstorm/large
				// Moves narsie if she was already summoned.
				var/obj/her = locate(narsie_type, machines)
				if(her)
					her.loc = get_turf(src)
					return
				// Otherwise...
				new narsie_type(src.loc) // Summon her!
				qdel(src) 	// Stops cultists from spamming the rune to summon narsie more than once.
							// Might actually be wise to straight up del() this
				return
			else
				return fizzle()

/////////////////////////////////////////FIFTH RUNE

		emp(var/U,var/range_red) //range_red - var which determines by which number to reduce the default emp range, U is the source loc, needed because of talisman emps which are held in hand at the moment of using and that apparently messes things up -- Urist
			if(istype(src,/obj/effect/rune))
				usr.say("For[pick("'","`")]NURGLE!")
			else
				usr.whisper("For[pick("'","`")]NURGLE!")
			playsound(U, 'sound/items/Welder2.ogg', 25, 1)
			var/turf/T = get_turf(U)
			if(T)
				T.hotspot_expose(700,125)
			var/rune = src // detaching the proc - in theory
			empulse(U, (range_red - 2), range_red)
			qdel(rune)

/////////////////////////////////////////SIXTH RUNE

		drain()
			var/drain = 0
			for(var/obj/effect/rune/R in world)
				if(R.word1==wordtravel && R.word2==wordblood && R.word3==wordself)
					for(var/mob/living/carbon/D in R.loc)
						if(D.stat!=2)
							var/bdrain = rand(1,25)
							D << "\red You feel weakened."
							D.take_overall_damage(bdrain, 0)
							drain += bdrain
			if(!drain)
				return fizzle()
			usr.say ("Blood![pick("'","`")]Blood! BLOOD! BLOOD! BLOOD! BLOOD!")
			usr.visible_message("\red Blood flows from the rune into [usr]!", \
			"\red The blood starts flowing from the rune and into your frail mortal body. You feel... empowered.", \
			"\red You hear a liquid flowing.")
			var/mob/living/user = usr
			if(user.bhunger)
				user.bhunger = max(user.bhunger-2*drain,0)
			if(drain>=50)
				user.visible_message("\red [user]'s eyes give off eerie red glow!", \
				"\red ...but it wasn't nearly enough. You crave, crave for more. The hunger consumes you from within.", \
				"\red You hear a heartbeat.")
				user.bhunger += drain
				src = user
				spawn()
					for (,user.bhunger>0,user.bhunger--)
						sleep(50)
						user.take_overall_damage(3, 0)
				return
			user.heal_organ_damage(drain%5, 0)
			drain-=drain%5
			for (,drain>0,drain-=5)
				sleep(2)
				user.heal_organ_damage(5, 0)
			return






/////////////////////////////////////////SEVENTH RUNE
//conversion
		seer()
			if(usr.loc==src.loc)
				usr.say("Tzeentch grant sight to the followers of Nurgle!")
				var/mob/living/carbon/human/user = usr
				if(user.see_invisible!=25  || (istype(user) && user.glasses))	//check for non humans
					user << "\red The world beyond flashes your eyes but disappears quickly, as if something is disrupting your vision."
				else
					user << "\red The world beyond opens to your eyes."
				var/see_temp = user.see_invisible
				user.see_invisible = SEE_INVISIBLE_OBSERVER
				user.seer = 1
				while(user.loc==src.loc)
					user.see_invisible = see_temp
					usr.client.view = 12
					usr.sight |= SEE_MOBS|SEE_OBJS|SEE_TURFS
					usr.see_in_dark = 8
					sleep(30)
				return
			return fizzle()

/////////////////////////////////////////EIGHTH RUNE

		raise()
			var/mob/living/carbon/human/corpse_to_raise
			var/mob/living/carbon/human/body_to_sacrifice

			var/is_sacrifice_target = 0
			for(var/mob/living/carbon/human/M in src.loc)
				if(M.stat == DEAD)
					if(game_is_cult_mode(ticker.mode))
						var/datum/game_mode/cult/Cult = ticker.mode
						if(M.mind == Cult.sacrifice_target)
							is_sacrifice_target = 1
					else
						corpse_to_raise = M
						if(M.key)
							M.ghostize(1)	//kick them out of their body
						break
			if(!corpse_to_raise)
				if(is_sacrifice_target)
					usr << "\red This mortal returns from the warp."
				return fizzle()


			is_sacrifice_target = 0
			find_sacrifice:
				for(var/obj/effect/rune/R in world)
					if(R.word1==wordblood && R.word2==wordjoin && R.word3==wordhell)
						for(var/mob/living/carbon/human/N in R.loc)
							if(game_is_cult_mode(ticker.mode))
								var/datum/game_mode/cult/Cult = ticker.mode
								if(N.mind && N.mind == Cult.sacrifice_target)
									is_sacrifice_target = 1
							else
								if(N.stat!= DEAD)
									body_to_sacrifice = N
									break find_sacrifice

			if(!body_to_sacrifice)
				if (is_sacrifice_target)
					usr << "\red The risen one wants that corpse for himself."
				else
					usr << "\red The sacrifical corpse is not dead. You must free it from this world of illusions before it may be used."
				return fizzle()

			var/mob/dead/observer/ghost
			for(var/mob/dead/observer/O in loc)
				if(!O.client)	continue
				if(O.mind && O.mind.current && O.mind.current.stat != DEAD)	continue
				ghost = O
				break

			if(!ghost)
				usr << "\red You require a warp spirit which clings to this world. Beckon their prescence with the sacred chants of Nurgle."
				return fizzle()

			for(var/obj/item/organ/limb/affecting in corpse_to_raise.organs)
				affecting.heal_damage(1000, 1000, 0)
			corpse_to_raise.setToxLoss(0)
			corpse_to_raise.setOxyLoss(0)
			corpse_to_raise.SetParalysis(0)
			corpse_to_raise.SetStunned(0)
			corpse_to_raise.SetWeakened(0)
			corpse_to_raise.radiation = 0
			corpse_to_raise.stat = CONSCIOUS
			corpse_to_raise.updatehealth()
			corpse_to_raise.update_damage_overlays(0)

			corpse_to_raise.key = ghost.key	//the corpse will keep its old mind! but a new player takes ownership of it (they are essentially possessed)
											//This means, should that player leave the body, the original may re-enter
			usr.say("NURGLE LOVES YOU!")
			corpse_to_raise.visible_message("\red [corpse_to_raise]'s eyes glow with a faint red as he stands up, slowly starting to breathe again.", \
			"\red I return... May my flesh fester... and rot... for Nurgle...", \
			"\red You hear a faint, slightly familiar whisper.")
			body_to_sacrifice.visible_message("\red [body_to_sacrifice] is torn apart, a black smoke swiftly dissipating from his remains!", \
			"\red You feel as your blood boils, tearing you apart.", \
			"\red You hear a thousand voices, all crying in pain.")
			body_to_sacrifice.gib()

			corpse_to_raise << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
			corpse_to_raise << "<font color=\"purple\"><b><i>Assist your new compatriots in their worship of nurgle. Their goal is yours, and yours is theirs. You serve Nurgle above all else. Spread his gift.</b></i></font>"
			return





/////////////////////////////////////////NINETH RUNE

		obscure(var/rad)
			var/S=0
			for(var/obj/effect/rune/R in orange(rad,src))
				if(R!=src)
					R.invisibility=INVISIBILITY_OBSERVER
				S=1
			if(S)
				if(istype(src,/obj/effect/rune))
					usr.say("Grandfather Nurgle[pick("'","`")]Hide us.")
					for (var/mob/V in viewers(src))
						V.show_message("\red The rune turns into gray dust, veiling the surrounding runes.", 3)
					qdel(src)
				else
					usr.whisper("Hmm[pick("'","`")]No need to see this.")
					usr << "\red Your talisman turns into gray dust, veiling the surrounding runes."
					for (var/mob/V in orange(1,src))
						if(V!=usr)
							V.show_message("\red Dust emanates from [usr]'s hands for a moment.", 3)

				return
			if(istype(src,/obj/effect/rune))
				return	fizzle()
			else
				call(/obj/effect/rune/proc/fizzle)()
				return

/////////////////////////////////////////TENTH RUNE

		ajourney() //some bits copypastaed from admin tools - Urist
			if(usr.loc==src.loc)
				var/mob/living/carbon/human/L = usr
				usr.say("Nurgle[pick("'","`")]Grant me freedom from this flesh!")
				usr.visible_message("\red [usr]'s eyes glow blue as \he freezes in place, absolutely motionless.", \
				"\red The shadow that is your spirit separates itself from your body. You are now in the warp. While this is a great sight, being here strains your mind and body. Hurry...", \
				"\red You hear only complete silence for a moment.")
				usr.ghostize(1)
				L.ajourn = 1
				while(L)
					if(L.key)
						L.ajourn=0
						return
					else
						L.take_organ_damage(10, 0)
					sleep(100)
			return fizzle()




/////////////////////////////////////////ELEVENTH RUNE

		manifest()
			var/obj/effect/rune/this_rune = src
			src = null
			if(usr.loc!=this_rune.loc)
				return this_rune.fizzle()
			var/mob/dead/observer/ghost
			for(var/mob/dead/observer/O in this_rune.loc)
				if(!O.client)	continue
				if(O.mind && O.mind.current && O.mind.current.stat != DEAD)	continue
				ghost = O
				break
			if(!ghost)
				return this_rune.fizzle()

			usr.say("Grandfather Nurgle[pick("'","`")]assist your chosen few!")
			var/mob/living/carbon/human/dummy/D = new(this_rune.loc)
			usr.visible_message("\red A shape forms in the center of the rune. A shape of... a man.", \
			"\red A shape forms in the center of the rune. A shape of... a man.", \
			"\red You hear liquid flowing.")
			D.real_name = "[pick(first_names_male)] [pick(last_names)]"
			D.universal_speak = 1
			D.status_flags = CANSTUN|CANWEAKEN|CANPARALYSE|CANPUSH

			D.key = ghost.key

			if(game_is_cult_mode(ticker.mode))
				var/datum/game_mode/cult/Cult = ticker.mode
				Cult.add_cultist(D.mind)
			else
				ticker.mode.cult+=D.mind

			D.mind.special_role = "Cultist"
			D << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
			D << "<font color=\"purple\"><b><i>Assist your new compatriots in their dark dealings. Their goal is yours, and yours is theirs. You serve Nurgle above all else. Bring It back.</b></i></font>"

			var/mob/living/user = usr
			while(this_rune && user && user.stat==CONSCIOUS && user.client && user.loc==this_rune.loc)
				user.take_organ_damage(1, 0)
				sleep(30)
			if(D)
				D.visible_message("\red [D] slowly dissipates into dust and bones.", \
				"\red You feel pain, as bonds formed between your soul and this homunculus break.", \
				"\red You hear faint rustle.")
				D.dust()
			return





/////////////////////////////////////////TWELFTH RUNE

		talisman()//only hide, emp, teleport, deafen, blind and tome runes can be imbued atm
			var/obj/item/weapon/paper/newtalisman
			var/unsuitable_newtalisman = 0
			for(var/obj/item/weapon/paper/P in src.loc)
				if(!P.info)
					newtalisman = P
					break
				else
					unsuitable_newtalisman = 1
			if (!newtalisman)
				if (unsuitable_newtalisman)
					usr << "\red The blank is tainted. It is unsuitable."
				return fizzle()

			var/obj/effect/rune/imbued_from
			var/obj/item/weapon/paper/talisman/T
			for(var/obj/effect/rune/R in orange(1,src))
				if(R==src)
					continue
				if(R.word1==wordtravel && R.word2==wordself)  //teleport
					T = new(src.loc)
					T.imbue = "[R.word3]"
					T.info = "[R.word3]"
					imbued_from = R
					break
				if(R.word1==wordsee && R.word2==wordblood && R.word3==wordhell) //tome
					T = new(src.loc)
					T.imbue = "newtome"
					imbued_from = R
					break
				if(R.word1==worddestr && R.word2==wordsee && R.word3==wordtech) //emp
					T = new(src.loc)
					T.imbue = "emp"
					imbued_from = R
					break
				if(R.word1==wordblood && R.word2==wordsee && R.word3==worddestr) //conceal
					T = new(src.loc)
					T.imbue = "conceal"
					imbued_from = R
					break
				if(R.word1==wordhell && R.word2==worddestr && R.word3==wordother) //armor
					T = new(src.loc)
					T.imbue = "armor"
					imbued_from = R
					break
				if(R.word1==wordblood && R.word2==wordsee && R.word3==wordhide) //reveal
					T = new(src.loc)
					T.imbue = "revealrunes"
					imbued_from = R
					break
				if(R.word1==wordhide && R.word2==wordother && R.word3==wordsee) //deafen
					T = new(src.loc)
					T.imbue = "deafen"
					imbued_from = R
					break
				if(R.word1==worddestr && R.word2==wordsee && R.word3==wordother) //blind
					T = new(src.loc)
					T.imbue = "blind"
					imbued_from = R
					break
				if(R.word1==wordself && R.word2==wordother && R.word3==wordtech) //communicat
					T = new(src.loc)
					T.imbue = "communicate"
					imbued_from = R
					break
				if(R.word1==wordjoin && R.word2==wordhide && R.word3==wordtech) //communicat
					T = new(src.loc)
					T.imbue = "runestun"
					imbued_from = R
					break
			if (imbued_from)
				for (var/mob/V in viewers(src))
					V.show_message("\red The runes turn into dust, which then forms into an arcane image on the paper.", 3)
				usr.say("Grandfather Nurgle[pick("'","`")]Show me your love!")
				qdel(imbued_from)
				qdel(newtalisman)
			else
				return fizzle()

/////////////////////////////////////////THIRTEENTH RUNE

		mend()
			var/mob/living/user = usr
			src = null
			user.say("RITA[pick("'","`")]Can't you spare me a dime, I've got to give myself one more chance!")
			user.take_overall_damage(200, 0)
			runedec+=10
			user.visible_message("\red [user] keels over dead, his blood glowing blue as it escapes his body and dissipates into thin air.", \
			"\red ...to be the man that I know I am ...to be the man that I know I am.", \
			"\red You hear faint rustle.")
			for(,user.stat==2)
				sleep(600)
				if (!user)
					return
			runedec-=10
			return


/////////////////////////////////////////FOURTEETH RUNE

		// returns 0 if the rune is not used. returns 1 if the rune is used.
		communicate()
			. = 1 // Default output is 1. If the rune is deleted it will return 1
			var/input = stripped_input(usr, "Please choose a message to tell to the other followers of nurgle.", "Voice from the warp", "")
			if(!input)
				if (istype(src))
					fizzle()
					return 0
				else
					return 0
			if(istype(src,/obj/effect/rune))
				usr.say("Let this virus spread[pick("'","`")]...for Nurgle!")
			else
				usr.whisper("Let this virus spread[pick("'","`")]...for Nurgle!")

			if(istype(src,/obj/effect/rune))
				usr.say("[input]")
			else
				usr.whisper("[input]")
			for(var/datum/mind/H in ticker.mode.cult)
				if (H.current)
					H.current << "\red \b [input]"
			return 1

/////////////////////////////////////////FIFTEENTH RUNE

		sacrifice()
			var/list/mob/living/carbon/human/cultsinrange = list()
			var/list/mob/living/carbon/human/victims = list()
			for(var/mob/living/carbon/human/V in src.loc)//Checks for non-cultist humans to sacrifice
				if(ishuman(V))
					victims += V//Checks for cult status and mob type
			for(var/obj/item/I in src.loc)//Checks for MMIs/brains/Intellicards
				if(istype(I,/obj/item/organ/brain))
					var/obj/item/organ/brain/B = I
					victims += B.brainmob
				else if(istype(I,/obj/item/device/mmi))
					var/obj/item/device/mmi/B = I
					victims += B.brainmob
				else if(istype(I,/obj/item/device/aicard))
					for(var/mob/living/silicon/ai/A in I)
						victims += A
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					cultsinrange += C
					C.say("Let his flesh fester and rot[pick("'","`")]FOR NURGLE!")
					if(cultsinrange.len >= 3) break		//we only need to check for three alive cultists, loop breaks so their aren't extra cultists getting word rewards
			for(var/mob/H in victims)
				if (game_is_cult_mode(ticker.mode))
					var/datum/game_mode/cult/Cult = ticker.mode
					if(H.mind == Cult.sacrifice_target)
						if(cultsinrange.len >= 3)
							sacrificed += H.mind
							stone_or_gib(H)
							for(var/mob/living/carbon/C in cultsinrange)
								C << "\red Nurgle accepts this sacrifice, your objective is now complete."
								C << "\red He is pleased!"
								sac_grant_word(C)
								sac_grant_word(C)
								sac_grant_word(C)	//Little reward for completing the objective
						else
							usr << "\red Your target's earthly bonds are too strong. You need more cultists to succeed in this ritual."
					else
						if(cultsinrange.len >= 3)
							if(H.stat !=2)
								for(var/mob/living/carbon/C in cultsinrange)
									C << "\red Nurgle accepts this sacrifice."
									sac_grant_word(C)
									stone_or_gib(H)
							else
								if(prob(60))
									usr << "\red Nurgle accepts this sacrifice."
									sac_grant_word(usr)
								else
									usr << "\red Nurgle accepts this sacrifice."
									usr << "\red However, a mere dead body is not enough to satisfy Him."
								stone_or_gib(H)
						else
							if(H.stat !=2)
								usr << "\red The victim is still alive, you will need more cultists chanting for the sacrifice to succeed."
							else
								if(prob(60))
									usr << "\red Nurgle accepts this sacrifice."
									sac_grant_word(usr)
								else
									usr << "\red Nurgle accepts this sacrifice."
									usr << "\red However, a mere dead body is not enough to satisfy Him."
								stone_or_gib(H)
				else
					if(cultsinrange.len >= 3)
						if(H.stat !=2)
							for(var/mob/living/carbon/C in cultsinrange)
								C << "\red Nurgle accepts this sacrifice."
								sac_grant_word(C)
								stone_or_gib(H)
						else
							if(prob(60))
								usr << "\red Nurgle accepts this sacrifice."
								sac_grant_word(usr)
							else
								usr << "\red Nurgle accepts this sacrifice."
								usr << "\red However, a mere dead body is not enough to satisfy Him."
							stone_or_gib(H)
					else
						if(H.stat !=2)
							usr << "\red The victim is still alive, you will need more cultists chanting for the sacrifice to succeed."
						else
							if(prob(60))
								usr << "\red Nurgle accepts this sacrifice."
								sac_grant_word(usr)
							else
								usr << "\red Nurgle accepts this sacrifice."
								usr << "\red However, a mere dead body is not enough to satisfy Him."
							stone_or_gib(H)
			for(var/mob/living/carbon/monkey/M in src.loc)
				if (game_is_cult_mode(ticker.mode))
					var/datum/game_mode/cult/Cult = ticker.mode
					if(M.mind == Cult.sacrifice_target)
						if(cultsinrange.len >= 3)
							sacrificed += M.mind
							for(var/mob/living/carbon/C in cultsinrange)
								C << "\red Nurgle accepts this sacrifice, your objective is now complete."
								C << "\red He is pleased!"
								sac_grant_word(C)
								sac_grant_word(C)
								sac_grant_word(C)	//Little reward for completing the objective
						else
							usr << "\red Your target's earthly bonds are too strong. You need more cultists to succeed in this ritual."
							continue
					else
						if(prob(30))
							usr << "\red Nurgle accepts your meager sacrifice."
							sac_grant_word(usr)
						else
							usr << "\red Nurgle accepts this sacrifice."
							usr << "\red However, a mere monkey is not enough to satisfy Him."
				else
					usr << "\red Nurgle accepts your meager sacrifice."
					if(prob(30))
						ticker.mode.grant_runeword(usr)
				stone_or_gib(M)
			for(var/mob/victim in src.loc)			//TO-DO: Move the shite above into the mob's own sac_act - see /mob/living/simple_animal/corgi/sac_act for an example
				victim.sac_act(src, victim)			//Sacrifice procs are now seperate per mob, this allows us to allow sacrifice on as many mob types as we want without making an already clunky system worse

		sac_grant_word(var/mob/living/C)	//The proc that which chooses a word rewarded for a successful sacrifice, sacrifices always give a currently unknown word if the normal checks pass
			if(C.mind.cult_words.len != ticker.mode.allwords.len) // No point running if they already know everything
				var/convert_word
				var/pick_list = ticker.mode.allwords - C.mind.cult_words
				convert_word = pick(pick_list)
				ticker.mode.grant_runeword(C, convert_word)

		stone_or_gib(var/mob/T)
			var/obj/item/device/soulstone/stone = new /obj/item/device/soulstone(get_turf(src))
			if(!stone.transfer_soul("FORCE", T, usr))	//if it fails to add soul
				qdel(stone)
			if(T)
				if(isrobot(T))
					T.dust()//To prevent the MMI from remaining
				else
					T.gib()


/////////////////////////////////////////SIXTEENTH RUNE

		revealrunes(var/obj/W as obj)
			var/go=0
			var/rad
			var/S=0
			if(istype(W,/obj/effect/rune))
				rad = 6
				go = 1
			if (istype(W,/obj/item/weapon/paper/talisman))
				rad = 4
				go = 1
			if (istype(W,/obj/item/weapon/nullrod))
				rad = 1
				go = 1
			if(go)
				for(var/obj/effect/rune/R in orange(rad,src))
					if(R!=src)
						R.invisibility=0
					S=1
			if(S)
				if(istype(W,/obj/item/weapon/nullrod))
					usr << "\red Arcane markings suddenly glow from underneath a thin layer of dust!"
					return
				if(istype(W,/obj/effect/rune))
					usr.say("Tzeentch[pick("'","`")]grant knowledge to this follower of Nurgle!")
					for (var/mob/V in viewers(src))
						V.show_message("\red The rune turns into red dust, reveaing the surrounding runes.", 3)
					qdel(src)
					return
				if(istype(W,/obj/item/weapon/paper/talisman))
					usr.whisper("Tzeentch[pick("'","`")]grant knowledge to this follower of Nurgle!")
					usr << "\red Your talisman turns into red dust, revealing the surrounding runes."
					for (var/mob/V in orange(1,usr.loc))
						if(V!=usr)
							V.show_message("\red Red dust emanates from [usr]'s hands for a moment.", 3)
					return
				return
			if(istype(W,/obj/effect/rune))
				return	fizzle()
			if(istype(W,/obj/item/weapon/paper/talisman))
				call(/obj/effect/rune/proc/fizzle)()
				return

/////////////////////////////////////////SEVENTEENTH RUNE

		wall()
			usr.say("Nurgle[pick("'","`")]Nurgle loves us.")
			src.density = !src.density
			var/mob/living/user = usr
			user.take_organ_damage(2, 0)
			if(src.density)
				usr << "\red Your blood flows into the rune, and you feel that the very space over the rune thickens."
			else
				usr << "\red Your blood flows into the rune, and you feel as the rune releases its grasp on space."
			return

/////////////////////////////////////////EIGHTTEENTH RUNE

		freedom()
			var/mob/living/user = usr
			var/list/mob/living/carbon/cultists = new
			for(var/datum/mind/H in ticker.mode.cult)
				if (istype(H.current,/mob/living/carbon))
					cultists+=H.current
			var/list/mob/living/carbon/users = new
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					users+=C
			if(users.len>=1)
				var/mob/living/carbon/cultist = input("Choose the one who you want to free", "Followers of Nurgle") as null|anything in (cultists - users)
				if(!cultist)
					return fizzle()
				if (cultist == user) //just to be sure.
					return

				var/is_free = 0

				if(!cultist.buckled)
					is_free++
				if(!cultist.handcuffed)
					is_free++
				if(!istype(cultist.wear_mask, /obj/item/clothing/mask/muzzle))
					is_free++
				if(istype(cultist.loc, /obj/structure/closet))
					var/obj/structure/closet/cultist_loc = cultist.loc
					if(!cultist_loc.welded)
						is_free++
				if(istype(cultist.loc, /obj/structure/closet/secure_closet))
					var/obj/structure/closet/secure_closet/cultist_loc = cultist.loc
					if(!cultist_loc.locked)
						is_free++
				if(istype(cultist.loc, /obj/machinery/dna_scannernew))
					var/obj/machinery/dna_scannernew/cultist_loc = cultist.loc
					if(!cultist_loc.locked)
						is_free++

				if(is_free)
					user << "<span class='warning'>The [cultist] is already free.</span>"
					return

				cultist.buckled = null
				if (cultist.handcuffed)
					cultist.handcuffed.loc = cultist.loc
					cultist.handcuffed = null
					cultist.update_inv_handcuffed(0)
				if (cultist.legcuffed)
					cultist.legcuffed.loc = cultist.loc
					cultist.legcuffed = null
					cultist.update_inv_legcuffed(0)
				if (istype(cultist.wear_mask, /obj/item/clothing/mask/muzzle))
					cultist.unEquip(cultist.wear_mask)
				if(istype(cultist.loc, /obj/structure/closet))
					var/obj/structure/closet/cultist_loc = cultist.loc
					if(cultist_loc.welded)
						cultist_loc.welded = 0
				if(istype(cultist.loc, /obj/structure/closet/secure_closet))
					var/obj/structure/closet/secure_closet/cultist_loc = cultist.loc
					if(cultist_loc.locked)
						cultist_loc.locked = 0
				if(istype(cultist.loc, /obj/machinery/dna_scannernew))
					var/obj/machinery/dna_scannernew/cultist_loc = cultist.loc
					if(cultist_loc.locked)
						cultist_loc.locked = 0
				for(var/mob/living/carbon/C in users)
					user.take_overall_damage(15, 0)
					C.say("LOLOLOLOL[pick("'","`")]TC STUBBS!")
				qdel(src)
			return fizzle()

/////////////////////////////////////////NINETEENTH RUNE

		cultsummon()
			var/mob/living/user = usr
			var/list/mob/living/carbon/cultists = new
			for(var/datum/mind/H in ticker.mode.cult)
				if (istype(H.current,/mob/living/carbon))
					cultists+=H.current
			var/list/mob/living/carbon/users = new
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					users+=C
			if(users.len>=3)
				var/mob/living/carbon/cultist = input("Choose the one who you want to summon", "Followers of Nurgle") as null|anything in (cultists - user)
				if(!cultist)
					return fizzle()
				if (cultist == user) //just to be sure.
					return
				if(cultist.buckled || cultist.handcuffed || (!isturf(cultist.loc) && !istype(cultist.loc, /obj/structure/closet)))
					user << "\red You cannot summon the [cultist], for his shackles of blood are strong"
					return fizzle()
				cultist.loc = src.loc
				cultist.Weaken(5)
				cultist.regenerate_icons()
				for(var/mob/living/carbon/human/C in orange(1,src))
					if(iscultist(C) && !C.stat)
						C.say("Grandfather Nurgle[pick("'","`")]Deliver us!")
						C.take_overall_damage(25, 0)
				user.visible_message("\red Rune disappears with a flash of red light, and in its place now a body lies.", \
				"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there's a body.", \
				"\red You hear a pop and smell ozone.")
				qdel(src)
			return fizzle()

/////////////////////////////////////////TWENTIETH RUNES

		deafen()
			if(istype(src,/obj/effect/rune))
				var/affected = 0
				for(var/mob/living/carbon/C in range(7,src))
					if (iscultist(C))
						continue
					var/obj/item/weapon/nullrod/N = locate() in C
					if(N)
						continue
					C.ear_deaf += 50
					C.show_message("\red The world around you suddenly becomes quiet.", 3)
					affected++
					if(prob(1))
						C.sdisabilities |= DEAF
				if(affected)
					usr.say("ITS A SOUND SWORD!!!!![pick("'","`")]!")
					usr << "\red The world becomes quiet as the deafening rune dissipates into fine dust."
					qdel(src)
				else
					return fizzle()
			else
				var/affected = 0
				for(var/mob/living/carbon/C in range(7,usr))
					if (iscultist(C))
						continue
					var/obj/item/weapon/nullrod/N = locate() in C
					if(N)
						continue
					C.ear_deaf += 30
					//talismans is weaker.
					C.show_message("\red The world around you suddenly becomes quiet.", 3)
					affected++
				if(affected)
					usr.whisper("Sound sword?[pick("'","`")] Yeah, sound sword.")
					usr << "\red Your talisman turns into gray dust, deafening everyone around."
					for (var/mob/V in orange(1,src))
						if(!(iscultist(V)))
							V.show_message("\red Dust flows from [usr]'s hands for a moment, and the world suddenly becomes quiet..", 3)
			return

		blind()
			if(istype(src,/obj/effect/rune))
				var/affected = 0
				for(var/mob/living/carbon/C in viewers(src))
					if (iscultist(C))
						continue
					var/obj/item/weapon/nullrod/N = locate() in C
					if(N)
						continue
					C.eye_blurry += 50
					C.eye_blind += 20
					if(prob(5))
						C.disabilities |= NEARSIGHTED
						if(prob(10))
							C.sdisabilities |= BLIND
					C.show_message("\red Suddenly you see red flash that blinds you.", 3)
					affected++
				if(affected)
					usr.say("You can see more with your eyes closed![pick("'","`")]!")
					usr << "\red The rune flashes, blinding those who not follow the Nar-Sie, and dissipates into fine dust."
					qdel(src)
				else
					return fizzle()
			else
				var/affected = 0
				for(var/mob/living/carbon/C in view(2,usr))
					if (iscultist(C))
						continue
					var/obj/item/weapon/nullrod/N = locate() in C
					if(N)
						continue
					C.eye_blurry += 30
					C.eye_blind += 10
					//talismans is weaker.
					affected++
					C.show_message("\red You feel a sharp pain in your eyes, and the world disappears into darkness..", 3)
				if(affected)
					usr.whisper("Sti[pick("'","`")] kaliesin!")
					usr << "\red Your talisman turns into gray dust, blinding those who not follow the Nar-Sie."
			return


		bloodboil() //cultists need at least one DANGEROUS rune. Even if they're all stealthy.
/*
			var/list/mob/living/carbon/cultists = new
			for(var/datum/mind/H in ticker.mode.cult)
				if (istype(H.current,/mob/living/carbon))
					cultists+=H.current
*/
			var/culcount = 0 //also, wording for it is old wording for obscure rune, which is now hide-see-blood.
//			var/list/cultboil = list(cultists-usr) //and for this words are destroy-see-blood.
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					culcount++
			if(culcount>=3)
				for(var/mob/living/carbon/M in viewers(usr))
					if(iscultist(M))
						continue
					var/obj/item/weapon/nullrod/N = locate() in M
					if(N)
						continue
					M.take_overall_damage(51,51)
					M << "\red Your blood boils!"
					if(prob(5))
						spawn(5)
							M.gib()
				for(var/obj/effect/rune/R in view(src))
					if(prob(10))
						explosion(R.loc, -1, 0, 1, 5)
				for(var/mob/living/carbon/human/C in orange(1,src))
					if(iscultist(C) && !C.stat)
						C.say("BLOOD FOR THE BLOOD GOD![pick("'","`")]!")
						C.take_overall_damage(15, 0)
				qdel(src)
			else
				return fizzle()
			return

// WIP rune, I'll wait for Rastaf0 to add limited blood.

		burningblood()
			var/culcount = 0
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C) && !C.stat)
					culcount++
			if(culcount >= 5)
				for(var/obj/effect/rune/R in world)
					if(R.blood_DNA == src.blood_DNA)
						for(var/mob/living/M in orange(2,R))
							M.take_overall_damage(0,15)
							if (R.invisibility>M.see_invisible)
								M << "\red Aargh it burns!"
							else
								M << "\red Rune suddenly ignites, burning you!"
							var/turf/T = get_turf(R)
							T.hotspot_expose(700,125)
				for(var/obj/effect/decal/cleanable/blood/B in world)
					if(B.blood_DNA == src.blood_DNA)
						for(var/mob/living/M in orange(1,B))
							M.take_overall_damage(0,5)
							M << "\red Blood suddenly ignites, burning you!"
							var/turf/T = get_turf(B)
							T.hotspot_expose(700,125)
							qdel(B)
				qdel(src)

//////////             Rune 24 (counting burningblood, which kinda doesnt work yet.)

		runestun(var/mob/living/T as mob)
			if(istype(src,/obj/effect/rune))   ///When invoked as rune, flash and stun everyone around.
				usr.say("Flesh obeys nurgle[pick("'","`")]!")
				for(var/mob/living/L in viewers(src))

					if(iscarbon(L))
						var/mob/living/carbon/C = L
						flick("e_flash", C.flash)
						if(C.stuttering < 1 && (!(HULK in C.mutations)))
							C.stuttering = 1
						C.Weaken(1)
						C.Stun(1)
						C.show_message("\red The rune explodes in a bright flash.", 3)

					else if(issilicon(L))
						var/mob/living/silicon/S = L
						S.Weaken(5)
						S.show_message("\red BZZZT... The rune has exploded in a bright flash.", 3)
				qdel(src)
			else                        ///When invoked as talisman, stun and mute the target mob.
				usr.say("Dream sign ''Evil sealing talisman'[pick("'","`")]!")
				var/obj/item/weapon/nullrod/N = locate() in T
				if(N)
					for(var/mob/O in viewers(T, null))
						O.show_message(text("\red <B>[] invokes a talisman at [], but they are unaffected!</B>", usr, T), 1)
				else
					for(var/mob/O in viewers(T, null))
						O.show_message(text("\red <B>[] invokes a talisman at []</B>", usr, T), 1)

					if(issilicon(T))
						T.Weaken(15)

					else if(iscarbon(T))
						var/mob/living/carbon/C = T
						flick("e_flash", C.flash)
						if (!(HULK in C.mutations))
							C.silent += 15
						C.Weaken(25)
						C.Stun(25)
				return

/////////////////////////////////////////TWENTY-FIFTH RUNE

		armor()
			var/mob/living/carbon/human/user = usr
			if(istype(src,/obj/effect/rune))
				usr.say("Grandfather nurgle![pick("'","`")]Grant us the power of the dark gods!")
			else
				usr.whisper("Grandfather nurgle![pick("'","`")]Grant us the power of the dark gods!")
			usr.visible_message("\red The rune disappears with a flash of red light, and a set of armor appears on [usr]...", \
			"\red You are blinded by the flash of red light! After you're able to see again, you see that you are now wearing a set of armor.")

			user.equip_to_slot_or_del(new /obj/item/clothing/head/culthood/alt(user), slot_head)
			user.equip_to_slot_or_del(new /obj/item/clothing/suit/cultrobes/alt(user), slot_wear_suit)
			user.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult(user), slot_shoes)
			user.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/cultpack(user), slot_back)
			//the above update their overlay icons cache but do not call update_icons()
			//the below calls update_icons() at the end, which will update overlay icons by using the (now updated) cache
			user.put_in_hands(new /obj/item/weapon/complexsword/cultblade(user))	//put in hands or on floor

			qdel(src)

		summon_nspawn()
			if(istype(src,/obj/effect/rune))
				usr.say("Nurgle[pick("'","`")]grant us the aid of your children!")
			else
				usr.whisper("Nurgle[pick("'","`")]grant us the aid of your children!")
			usr.visible_message("\red Rune disappears with a flash of red light, and a Nurgle Spawn appears. It may not yet have a soul in it, but it soon shall.", \
			"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there is a Nurgle Spawn. It may not yet have a soul in it but it soon shall.", \
			"\red You hear a pop and smell ozone.")
			if(istype(src,/obj/effect/rune))
				new /mob/living/simple_animal/chaosspawn/nspawn(src.loc)
			else
				new /mob/living/simple_animal/chaosspawn/nspawn(usr.loc)
			qdel(src)
			return

		summon_borer()
			if(istype(src,/obj/effect/rune))
				usr.say("Nurgle[pick("'","`")]grant us the tools of your love")
			else
				usr.whisper("Nurgle[pick("'","`")]grant us the tools of your love")
			usr.visible_message("\red Rune disappears with a flash of red light, and a Cortical Borer appears. It may not yet have a soul in it, but it soon shall.", \
			"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there is a Cortical Borer. It may not yet have a soul in it but it soon shall.", \
			"\red You hear a pop and smell ozone.")
			if(istype(src,/obj/effect/rune))
				new /mob/living/simple_animal/borer(src.loc)
			else
				new /mob/living/simple_animal/borer(usr.loc)
			qdel(src)
			return