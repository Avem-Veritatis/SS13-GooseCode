/*
The General idea I am going for is to create two abilities. One is the 'Render aid' which prompts a decision tree that allows activity.
The other (the clone) is for medics. It has the same name and wording but does a lot more. It effectively replaces 'render aid' and is more robust.
Everyone gets render aid but only medics get render aid clone.
*/

/*
Basic First Aid
*/
/mob/living/carbon/human/proc/renderaid(var/mob/living/carbon/human/M in mob_list)
	set category = null
	set name = "Render Aid"
	set desc = "Lets you do your best to save some one's ass."
	if(!ishuman(M))
		usr << text("<span class='notice'>Thats not a person.</span>")
		return
	var/mob/living/carbon/human/U = src
	if(U.treating)
		usr << text("<span class='notice'>You are already treating some one!</span>")
		return
	var/list/options = list(
		"Basic First Aid",
		"Cancel",
		)

	var/theoptions = input("Select how you wish to aid [M]", "Treatment Menu") as null|anything in options
	if (isnull(theoptions))																	//You chose poorly
		return
	if(!Adjacent(M))																			//How close are we?
		usr << text("<span class='notice'>Get a little closer.</span>")
		return

	switch(theoptions)
		if ("Cancel")
			//do nothing

		if ("Basic First Aid")
																											//HERE COMES THE LOGIC TREE!!!!
			if(!istype(M))
				U <<"That is not a person."														//Target not a person
				return
			if(U.stat == DEAD)
				U <<"Don't see how you can do that when you are dead."							//Healer is dead
				return
			if(M.stat == DEAD)
				U <<"He's dead Jim!"															//Target is dead
				return
			if(!U.canmove || U.stat || U.restrained())
				U << "<span class='notice'>Just... can't.... seem.... to reach....!!</span>"	//Healer is tied up
				return
			if(U.brainloss >= 60)
				U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//Healer is stupid
				U.visible_message(text("<span class='alert'>[U] stares blankly at [M]</span>"))
				U << text("<span class='notice'>I don't know. That person seems alright. Your head feels funny.")
				U << text("<span class='notice'>Oh crap. You need to call an adult!")
				U.say("Walk it off!")
				return
			if(M.health >= 90)																				//Target is scratched
				U << text("<span class='notice'>You can not seem to find anything seriously wrong with [M]. Maybe you should get a second opinion.")
				return
			if(M.health >= 20)																				//Target is able to walk to medbay
				U << text("<span class='notice'>[M] looks pretty beat up but these wounds do not appear life threatening. Better get them to a medicus.")
				return
			if(M.health >= 1)																				//Target may need to be dragged to medbay
				U << text("<span class='notice'>This looks bad. [M] is stable for the moment, but you'll need to find help.")
				return
			if(M.health >= -99)																				//Time for CPR
				var/t_him = "it"																			//First we figure out the target's gender
				if (M.gender == MALE)
					t_him = "him"
				if (M.gender == FEMALE)
					t_him = "her"
				U << text("<span class='notice'>[M] is not going to last much longer. You need to try to bind these wounds and keep [t_him] alive!")
				U << text("<span class='notice'>Do not move and do not let anyone distract you.")
				U.treating = 1																							//Lets start on the healing part
				while(U.treating)																						//Activate the while loop!
					if(M.health	>= 1)
						usr << text("<span class='notice'>Looks like [M] is stable for the moment.</span>")
						U.treating = 0
						return
					if(do_after(U, 20))
						if(!Adjacent(M))																			//How close are we?
							usr << text("<span class='notice'>Get a little closer.</span>")
							U.treating = 0
							return

						if(M.oxyloss >= 50)
							M.adjustOxyLoss(-7)
							M.updatehealth()
							M.visible_message("[U] performs CPR on [M].")
							U << "<span class='notice'>[M] is not breathing! You perform CPR on [t_him].</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 40
						if(M.getBruteLoss() >= 50)
							M.adjustBruteLoss(-5)
							M.updatehealth()
							M.visible_message("[U] begins to staunch the bleeding.")
							U << "<span class='notice'>[M] bleeding all over the place! You apply pressure to the wounds.</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 60
						if(M.getFireLoss() >= 50)
							M.adjustFireLoss(-5)
							M.updatehealth()
							M.visible_message("[U] begins to pressure wrap [U]'s burns.")
							U << "<span class='notice'>[M] is very badly burned. You begin pressure wrapping the wounds. You hope it will be enough.</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 60
						if((M.oxyloss >= 30) && (M.oxyloss <= 49))
							M.adjustOxyLoss(-7)
							M.updatehealth()
							M.visible_message("[U] performs CPR on [M].")
							U << "<span class='notice'>[M] is still not breathing! You should continue CPR on [t_him].</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 40
						if((M.getFireLoss() >= 30) && (M.fireloss <= 49))
							M.adjustFireLoss(-5)
							M.updatehealth()
							M.visible_message("[U] begins to pressure wrap [U]'s burns.")
							U << "<span class='notice'>[M] is burned. You begin pressure wrapping the wounds. This is so gross.</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 60
						if((M.getBruteLoss() >= 30) && (M.bruteloss <= 49))
							M.adjustBruteLoss(-5)
							M.updatehealth()
							M.visible_message("[U] staunchs the bleeding.")
							U << "<span class='notice'>[M] is bleeding a bit! You apply pressure to the wounds.</span>"
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
						if((M.getFireLoss() >= 1) && (M.fireloss <= 29))
							M.adjustFireLoss(-5)
							M.updatehealth()
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 60
						if((M.getBruteLoss() >= 1) && (M.bruteloss <= 29))
							M.adjustBruteLoss(-5)
							M.updatehealth()
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
						if((M.oxyloss >= 1) && (M.oxyloss <= 49))
							M.adjustOxyLoss(-7)
							M.updatehealth()
							M << "<span class='unconscious'>[U] is trying to keep you alive.</span>"
							sleep 40
					else 																					//If either of you moves- it's over!
						U << text("<span class='notice'>You stop binding [t_him]'s wounds.")
						U.treating = 0
						return


		else
			U << "<span class='notice'>Something Broke! Write down everything you were doing and stick it on teh forums!</span>"
			U.treating = 0

/*
Medic
*/

/mob/living/carbon/human/proc/renderaidclone(var/mob/living/carbon/human/M in mob_list)
	set category = null
	set name = "Begin Treatment"
	set desc = "Lets you do your best to save some one's ass."
	if(!ishuman(M))
		usr << text("<span class='notice'>Thats not a person.</span>")
		return
	var/mob/living/carbon/human/U = src
	if(U.treating)
		usr << text("<span class='notice'>You are already treating some one!</span>")
		return
	var/list/options = list(
		"Assess Patient",
		"Stabilize Patient",
		"Cancel",
		)

	var/theoptions = input("Select how you wish to aid [M]", "Treatment Menu") as null|anything in options
	if (isnull(theoptions))																	//You chose poorly
		return
	if(!Adjacent(M))																			//How close are we?
		usr << text("<span class='notice'>Get a little closer.</span>")
		return

	switch(theoptions)
		if ("Cancel")
			//do nothing

		if ("Assess Patient")
																											//HERE COMES THE LOGIC TREE!!!!
			if(!istype(M))
				U <<"That is not a person."														//Target not a person
				return
			if(U.stat == DEAD)
				U <<"Don't see how you can do that when you are dead."							//Healer is dead
				return
			if(M.stat == DEAD)
				U <<"He's dead Jim!"															//Target is dead
				return
			if(!U.canmove || U.stat || U.restrained())
				U << "<span class='notice'>Just... can't.... seem.... to reach....!!</span>"	//Healer is tied up
				return
			if(U.brainloss >= 60)
				U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//Healer is stupid
				U.visible_message(text("<span class='alert'>[U] stares blankly at [M]</span>"))
				U << text("<span class='notice'>I don't know. That person seems alright. Your head feels funny.")
				U << text("<span class='notice'>Oh crap. You need to call an adult!")
				U.say("You look funny.")
				return
			if(M.health >= 99)
				U << text("<span class='notice'>Patient looks fine for the moment.")
				return

			if(M.health >= 75)																				//Target is scratched
				U << text("<span class='notice'>Minor damage. Cuts and bruises.")
				return
			if(M.health >= -99)
				var/brutebrute = 0
				var/oxyoxy = 0
				var/firefire = 0
				var/brainbrain = 0
				var/toxtox = 0
				var/conscious = 0
				var/t_him = "it"																			//First we figure out the target's gender
				if (M.gender == MALE)
					t_him = "his"
				if (M.gender == FEMALE)
					t_him = "her"
				U.<< text("<span class='notice'>[M] Is in bad shape. You quickly size up [t_him] injuries.")
				if(M.getBruteLoss() >= 20)
					brutebrute = 1
				if(M.oxyloss >= 5)
					oxyoxy = 1
				if(M.getFireLoss() >= 20)
					firefire = 1
				if(M.brainloss >= 20)
					brainbrain = 1
				if(M.getToxLoss() >= 20)
					toxtox = 1
				if(M.health >= 1)
					conscious = 1

				U << ("Subject is [M.gender].")
				var/t_heshe
				if (M.gender == MALE)
					t_heshe = "He"
				if (M.gender == FEMALE)
					t_heshe = "She"
				if(conscious)
					U.show_message("<span class='notice'>[t_heshe] is conscious.</span>", 1)
				if(!conscious)
					U.show_message("<span class='notice'>[t_heshe] is <font color='red'>unconscious.</font></span>", 1)
				if(brutebrute)
					U.show_message("<span class='notice'>[t_heshe] has <font color='red'>lacerations and is bleeding.</font></span>", 1)
				if(oxyoxy)
					U.show_message("<span class='notice'>[t_heshe] is <font color='red'>not breathing.</font></span>", 1)
				if(firefire)
					U.show_message("<span class='notice'>[t_heshe] is <font color='red'>badly burned.</font></span>", 1)
				if(brainbrain)
					U.show_message("<span class='notice'>[t_heshe] is having <font color='red'>neurological difficulty.</font></span>", 1)
				if(toxtox)
					U.show_message("<span class='notice'>[t_heshe] is in shock.<font color='red'> Possibly poisoned.</font></span>", 1)
				return

		if ("Stabilize Patient")

			if(!Adjacent(M))																	//How close are we?
				usr << text("<span class='notice'>Get a little closer.</span>")
				return
			if(!istype(M))
				U <<"That is not a person."														//Target not a person
				return
			if(U.stat == DEAD)
				U <<"Don't see how you can do that when you are dead."							//Healer is dead
				return
			if(M.stat == DEAD)
				U <<"He's dead Jim!"															//Target is dead
				return
			if(!U.canmove || U.stat || U.restrained())
				U << "<span class='notice'>Just... can't.... seem.... to reach....!!</span>"	//Healer is tied up
				return
			if(U.brainloss >= 60)
				U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//Healer is stupid
				U.visible_message(text("<span class='alert'>[U] stares blankly at [M]</span>"))
				U << text("<span class='notice'>I don't know. That person seems alright. Your head feels funny.")
				U << text("<span class='notice'>Oh crap. You need to call an adult!")
				U.say("I just peed my pants and no one can do anything about it!")
				return
			if(do_after(U, 20))
				U.visible_message(text("<span class='alert'>[U] pulls a thin metalic device from a wrist mounted device and fixes it to a thin rubber tube. [U] inserts the needle into [M]'s neck.</span>"))
				U << text("<span class='notice'>.Primer transfered: 1 Units.")
				M.reagents.add_reagent("inaprovaline", 30)		//junk it up with inaprovaline
				M.adjustOxyLoss(-99)
				sleep 20
				if(do_after(U, 20))
					U << text("<span class='notice'>.Inaprovaline transfered: 30 Units.")
					U.visible_message(text("<span class='alert'>The tube between [U] and [M] pulses.</span>"))
					sleep 20
					if(do_after(U, 20))
						U << text("<span class='notice'>.Tricordrazine transfered: 30 Units.")
						M.reagents.add_reagent("tricordrazine", 30)		//junk it up with tricordrazine
						U.visible_message(text("<span class='alert'>The tube between [U] and [M] pulses.</span>"))
						U << text("<span class='notice'>.Patient is stable and ready for transport.")
					else
						U.visible_message(text("<span class='alert'>[U]'s concentration is broken!</span>"))
						U << text("<span class='notice'>.Something is distracting you. Stand still!")
				else
					U.visible_message(text("<span class='alert'>[U]'s concentration is broken!</span>"))
					U << text("<span class='notice'>.Something is distracting you. Stand still!")
			else
				U.visible_message(text("<span class='alert'>[U]'s concentration is broken!</span>"))
				U << text("<span class='notice'>.Something is distracting you. Stand still!")