/mob/living/simple_animal/hostile/retaliate/goose
	name = "Goose"
	real_name = "Goose"
	desc = "It's a goose!"
	icon = 'icons/mob/mob.dmi'
	icon_state = "goose"
	icon_living = "goose"
	icon_dead = "goose"
	maxHealth = 500
	health = 500
	speak_emote = list("clearly says")
	emote_hear = list("wails","screeches")
	response_help  = "pets"
	response_disarm = "gets bitten by"
	response_harm   = "has angered"
	melee_damage_lower = 1
	melee_damage_upper = 2
	attacktext = "bites"
	speed = 1
	stop_automated_movement = 1
	status_flags = 0
	factions = list("cult")
	status_flags = CANPUSH
	attack_sound = 'sound/voice/dreet2.ogg'
	environment_smash = 0
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 270
	maxbodytemp = 370
	heat_damage_per_tick = 0	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 0	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	unsuitable_atoms_damage = 0
	isgoose = 1					//this is called in simple_animal upon die() - it lets the death portion understand that this is no ordinary 'simple_animal'

/mob/living/simple_animal/hostile/retaliate/goose/FindTarget()
	. = ..()
	if(.)

		emote("is enraged by [.]")
		icon_state = "agoose"
		stance = HOSTILE_STANCE_ATTACK
		speed = -1

/mob/living/simple_animal/hostile/retaliate/goose/t2s
	name = "Goose"
	real_name = "Goose"
	desc = "It's a goose!"
	icon = 'icons/mob/mob.dmi'
	icon_state = "gooset2s"
	icon_living = "gooset2s"
	icon_dead = "gooset2s"
	var/speaking = 0

/mob/living/simple_animal/hostile/retaliate/goose/t2s/FindTarget()
	. = ..()
	if(.)

		emote("is enraged by [.]")
		icon_state = "agooset2s"
		stance = HOSTILE_STANCE_ATTACK
		speed = -1

/mob/living/simple_animal/hostile/retaliate/goose/t2s/verb/speak()
	set name = "Speak"
	set desc = "Use your text to speach device."
	set category = "Goose"
	var/rdmspeach = pick('sound/voice/goose1.ogg','sound/voice/goose2.ogg', 'sound/voice/goose3.ogg', 'sound/voice/goose4.ogg', 'sound/voice/goose5.ogg', 'sound/voice/goose6.ogg', 'sound/voice/goose7.ogg', 'sound/voice/goose8.ogg', 'sound/voice/goose9.ogg')

	if(speaking)
		return
	else
		speaking = 1
		playsound(loc, rdmspeach, 75, 0)
		sleep(20)
		speaking = 0
	..()


/mob/living/simple_animal/hostile/retaliate/goose/t2s/New()
	verbs.Add(/mob/living/simple_animal/hostile/retaliate/goose/t2s/verb/speak)
	..()

/mob/living/simple_animal/hostile/retaliate/goose/Life()

	if(locate(/obj/item/weapon/reagent_containers/food/) in loc)
		var/obj/item/weapon/reagent_containers/food/SV = locate(/obj/item/weapon/reagent_containers/food/) in loc
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The Goose</B> scarfs down the [SV]!", 1)
		qdel(SV)
		return

	if(health > maxHealth)
		health = maxHealth

	if(stunned)
		AdjustStunned(-1)
	if(weakened)
		AdjustWeakened(-1)
	if(paralysis)
		AdjustParalysis(-1)

	..()

/mob/living/simple_animal/hostile/retaliate/goose/attack_animal(mob/living/simple_animal/M as mob, P as obj)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	if (istype(P, /obj/item/weapon/reagent_containers/food/))
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> scarfs down the [P]!", 1)
		qdel(P)
		return
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		adjustBruteLoss(damage)


/*
Undercover Goose
*/

/mob/living/simple_animal/ugoose
	name = "Assistant"
	real_name = "Assistant"
	desc = "Seems Legit!"
	icon = 'icons/mob/mob.dmi'
	icon_state = "cutout"
	maxHealth = 1
	health = 1
	speak_emote = list("clearly says")
	emote_hear = list("wails","screeches")
	response_help  = "touches"
	response_disarm = "gets pushed "
	response_harm   = "has exposed"
	melee_damage_lower = 0
	melee_damage_upper = 0
	attacktext = "pushes"
	speed = 1
	isugoose = 1
	var/disguisenumber = 1

/*
fakegoose
*/

/obj/item/fakegoose
	name = "Goose"
	desc = "This goose is made of cardboard. Wait... THIS ISNT A GOOSE AT ALL!"
	gender = PLURAL
	icon = 'icons/mob/mob.dmi'
	icon_state = "fgoose"
	throwforce = 0
	w_class = 1.0
	throw_range = 1
	throw_speed = 1
	layer = 4

/*
RTD controller
*/

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose
	name = "Bruce"

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/verb/full_RTD_edit()
	set category = "RTD"
	set name = "Enter Password"
	set desc = "Stick that password in me."
	enterpassword(src)

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/enterpassword()
	spawn(0)
		var/actualpassword = "ADC"


		var/time_passed = world.time

		for(var/i=1,i<=3,i++)	//we get 3 attempts to enterpassword
			var/givenpassword = input(src,"Enter Password", "Enterpassword",null) as text
			if((world.time-time_passed)>300)
				return	//took too long omg

			if(givenpassword == actualpassword)
				grantaccess(src)
				return
			else
				panic(src)
				return

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/panic()
	spawn (0)
		log_admin("[src.key] attempted to access Bruce")
		log_admin("[key_name(src)] attempted to access Bruce.")
		message_admins("\blue [key_name_admin(usr)] has attempted to access Bruce. Report to Norc and Drake immeadately!", 1)
		usr << text("<span class='notice'>Wrong Answer! Goodbye!</span>")
		del(src.client)
		qdel(src)

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/grantaccess()
	src.verbs += /mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/factioncontroller
	usr << text("<span class='notice'>Access Granted</span>")

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/factioncontroller()
	set category = "RTD"
	set name = "Faction Controller"
	set desc = "Lets get this started."
	var/thechooser = 0
	var/editchoice															//start the var
	editchoice = input("Select an action:","Faction Management") as null|anything in list(
		"Edit UltraMarine Leader",
		"Edit UltraMarines",

		"Edit SalamanderMarine Leader",
		"Edit Salamander Marines",

		"Edit KriegOfficers",

		"Edit Tauleader",
		"Edit Tau",

		"Edit Eldar Leader",
		"Edit Eldar",

		"Edit RavenGuard Leader",
		"Edit RavenGuard",

		"Edit Tyranid Leader",
		"Edit Tyranids",

		"Edit Ordo HereticusLeader",
		"Edit Ordo Hereticus",

		"Edit Ordo Hereticus Stormtroopers",

		"Edit SOB Leader",
		"Edit SOB",

		"Edit Ork Leader",
		"Edit Orks",

		"Edit Plague Marine Leader",
		"Edit Plague Marines",

		"Edit Thousand Sons Leader",
		"Edit Thousand Sons",

		"Display all lists",


		"Cancel")
	switch(editchoice)						//I have no idea what I'm doing.
		if("Edit UltraMarine Leader")
			thechooser = 1
			edit_faction_membership(thechooser)
		if("Edit UltraMarines")
			thechooser = 2
			edit_faction_membership(thechooser)
		if("Edit SalamanderMarine Leader")
			thechooser = 3
			edit_faction_membership(thechooser)
		if("Edit Salamander Marines")
			thechooser = 4
			edit_faction_membership(thechooser)
		if("Edit KriegOfficers")
			thechooser = 5
			edit_faction_membership(thechooser)
		if("Edit Tauleader")
			thechooser = 6
			edit_faction_membership(thechooser)
		if("Edit Tau")
			thechooser = 7
			edit_faction_membership(thechooser)
		if("Edit Eldar Leader")
			thechooser = 8
			edit_faction_membership(thechooser)
		if("Edit Eldar")
			thechooser = 9
			edit_faction_membership(thechooser)
		if("Edit RavenGuard Leader")
			thechooser = 10
			edit_faction_membership(thechooser)
		if("Edit RavenGuard")
			thechooser = 11
			edit_faction_membership(thechooser)
		if("Edit Tyranid Leader")
			thechooser = 12
			edit_faction_membership(thechooser)
		if("Edit Tyranids")
			thechooser = 13
			edit_faction_membership(thechooser)
		if("Edit Ordo HereticusLeader")												//not implemented
			thechooser = 14
			edit_faction_membership(thechooser)
		if("Edit Ordo Hereticus")
			thechooser = 15
			edit_faction_membership(thechooser)
		if("Edit Ordo Hereticus Stormtroopers")
			thechooser = 16
			edit_faction_membership(thechooser)
		if("Edit SOB Leader")
			thechooser = 17
			edit_faction_membership(thechooser)
		if("Edit SOB")
			thechooser = 18
			edit_faction_membership(thechooser)
		if("Edit Ork Leader")
			thechooser = 19
			edit_faction_membership(thechooser)
		if("Edit Orks")
			thechooser = 20
			edit_faction_membership(thechooser)
		if("Edit Plague Marine Leader")
			thechooser = 21
			edit_faction_membership(thechooser)
		if("Edit Plague Marines")
			thechooser = 22
			edit_faction_membership(thechooser)
		if("Edit Thousand Sons Leader")
			thechooser = 23
			edit_faction_membership(thechooser)
		if("Edit Thousand Sons")
			thechooser = 24
			edit_faction_membership(thechooser)
		if("Display all lists")
			display_faction_membership()

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/edit_faction_membership(thechooser)
	var/editchoice																		//start the var
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")	//surprise! var is input
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				switch (thechooser)
					if(1)
						umleader.Add(newname)
						var/savefile/umOVERSEER = new("data/rtd/umleader.sav")
						umOVERSEER<<umleader
						return
					if(2)
						umlist.Add(newname)										//umlist is a constant so lets toss that name in there
						var/savefile/umMember = new("data/rtd/umMember.sav")				//lets drag this variable back from the dead
						umMember<<umlist										//overwrite the save file with the list
						return
					if(3)
						smleader.Add(newname)
						var/savefile/smOVERSEER = new("data/rtd/smleader.sav")
						smOVERSEER<<smleader
						return
					if(4)
						salamanders.Add(newname)
						var/savefile/smMember = new("data/rtd/smMember.sav")
						smMember<<salamanders
						return
					if(5)
						kriegofficers.Add(newname)
						var/savefile/krMember = new("data/rtd/krMember.sav")
						krMember<<kriegofficers
						return
					if(6)
						tauleader.Add(newname)
						var/savefile/tauOVERSEER = new("data/rtd/tauleader.sav")
						tauOVERSEER<<tauleader
						return
					if(7)
						tau.Add(newname)
						var/savefile/tauMember = new("data/rtd/tauMember.sav")
						tauMember<<tau
						return
					if(8)
						eldarleader.Add(newname)
						var/savefile/eldarOVERSEER = new("data/rtd/eldarleader.sav")
						eldarOVERSEER<<eldarleader
						return
					if(9)
						eldar.Add(newname)
						var/savefile/eldarMember = new("data/rtd/eldarMember.sav")
						eldarMember<<eldar
						return
					if(10)
						ravenleader.Add(newname)
						var/savefile/rgOVERSEER = new("data/rtd/rgleader.sav")
						rgOVERSEER<<ravenleader
						return
					if(11)
						ravenguard.Add(newname)
						var/savefile/rgMember = new("data/rtd/rgMember.sav")
						rgMember<<ravenguard
						return
					if(12)
						tyranidleader.Add(newname)
						var/savefile/tyranidOVERSEER = new("data/rtd/tyranidleader.sav")
						tyranidOVERSEER<<tyranidleader
						return
					if(13)
						tyranid.Add(newname)
						var/savefile/tyranidMember = new("data/rtd/tyranidMember.sav")
						tyranidMember<<tyranid
						return
					if(14)
						ohleader.Add(newname)														//not implemented
						var/savefile/ohOVERSEER = new("data/rtd/ohleader.sav")
						ohOVERSEER<<ohleader
						return
					if(15)
						ordohereticus.Add(newname)
						var/savefile/ohMember = new("data/rtd/ohMember.sav")
						ohMember<<ordohereticus
						return
					if(16)
						stormtrooper.Add(newname)
						var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
						ohsMember<<stormtrooper
						return
					if(17)
						sobleader.Add(newname)
						var/savefile/sobOVERSEER = new("data/rtd/sobleader.sav")
						sobOVERSEER<<sobleader
						return
					if(18)
						sob.Add(newname)
						var/savefile/sobMember = new("data/rtd/sobMember.sav")
						sobMember<<sob
						return
					if(19)
						orkleader.Add(newname)
						var/savefile/orkOVERSEER = new("data/rtd/orkleader.sav")
						orkOVERSEER<<orkleader
						return
					if(20)
						ork.Add(newname)
						var/savefile/orkMember = new("data/rtd/orkMember.sav")
						orkMember<<ork
						return
					if(21)
						pmleader.Add(newname)
						var/savefile/pmOVERSEER = new("data/rtd/pmleader.sav")
						pmOVERSEER<<pmleader
						return
					if(22)
						pmlist.Add(newname)
						var/savefile/pmMember = new("data/rtd/pmMember.sav")
						pmMember<<pmlist
						return
					if(23)
						ksonsleader.Add(newname)
						var/savefile/ksonsOVERSEER = new("data/rtd/ksonsleader.sav")
						ksonsOVERSEER<<ksonsleader
						return
					if(24)
						ksons.Add(newname)
						var/savefile/ksonsMember = new("data/rtd/ksons.sav")
						ksonsMember<<ksons
						return

		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				switch (thechooser)
					if(1)
						umleader.Remove(removal)
						var/savefile/umOVERSEER = new("data/rtd/umleader.sav")
						umOVERSEER<<umleader
						return
					if(2)
						umlist.Remove(removal)
						var/savefile/umMember = new("data/rtd/umMember.sav")
						umMember<<umlist
						return
					if(3)
						smleader.Remove(removal)
						var/savefile/smOVERSEER = new("data/rtd/smleader.sav")
						smOVERSEER<<smleader
						return
					if(4)
						salamanders.Remove(removal)
						var/savefile/smMember = new("data/rtd/smMember.sav")
						smMember<<salamanders
						return
					if(5)
						kriegofficers.Remove(removal)
						var/savefile/krMember = new("data/rtd/krMember.sav")
						krMember<<kriegofficers
						return
					if(6)
						tauleader.Remove(removal)
						var/savefile/tauOVERSEER = new("data/rtd/tauleader.sav")
						tauOVERSEER<<tauleader
						return
					if(7)
						tau.Remove(removal)
						var/savefile/tauMember = new("data/rtd/tauMember.sav")
						tauMember<<tau
						return
					if(8)
						eldarleader.Remove(removal)
						var/savefile/eldarOVERSEER = new("data/rtd/eldarleader.sav")
						eldarOVERSEER<<eldarleader
						return
					if(9)
						eldar.Remove(removal)
						var/savefile/eldarMember = new("data/rtd/eldarMember.sav")
						eldarMember<<eldar
						return
					if(10)
						ravenleader.Remove(removal)
						var/savefile/rgOVERSEER = new("data/rtd/rgleader.sav")
						rgOVERSEER<<ravenleader
						return
					if(11)
						ravenguard.Remove(removal)
						var/savefile/rgMember = new("data/rtd/rgMember.sav")
						rgMember<<ravenguard
						return
					if(12)
						tyranidleader.Remove(removal)
						var/savefile/tyranidOVERSEER = new("data/rtd/tyranidleader.sav")
						tyranidOVERSEER<<tyranidleader
						return
					if(13)
						tyranid.Remove(removal)
						var/savefile/tyranidMember = new("data/rtd/tyranidMember.sav")
						tyranidMember<<tyranid
						return
					if(14)
						ohleader.Remove(removal)														//not implemented
						var/savefile/ohOVERSEER = new("data/rtd/ohleader.sav")
						ohOVERSEER<<ohleader
						return
					if(15)
						ordohereticus.Remove(removal)
						var/savefile/ohMember = new("data/rtd/ohMember.sav")
						ohMember<<ordohereticus
						return
					if(16)
						stormtrooper.Remove(removal)
						var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
						ohsMember<<stormtrooper
						return
					if(17)
						sobleader.Remove(removal)
						var/savefile/sobOVERSEER = new("data/rtd/sobleader.sav")
						sobOVERSEER<<sobleader
						return
					if(18)
						sob.Remove(removal)
						var/savefile/sobMember = new("data/rtd/sobMember.sav")
						sobMember<<sob
						return
					if(19)
						orkleader.Remove(removal)
						var/savefile/orkOVERSEER = new("data/rtd/orkleader.sav")
						orkOVERSEER<<orkleader
						return
					if(20)
						ork.Remove(removal)
						var/savefile/orkMember = new("data/rtd/orkMember.sav")
						orkMember<<ork
						return
					if(21)
						pmleader.Remove(removal)
						var/savefile/pmOVERSEER = new("data/rtd/pmleader.sav")
						pmOVERSEER<<pmleader
						return
					if(22)
						pmlist.Remove(removal)
						var/savefile/pmMember = new("data/rtd/pmMember.sav")
						pmMember<<pmlist
						return
					if(23)
						ksonsleader.Remove(removal)
						var/savefile/ksonsOVERSEER = new("data/rtd/ksonsleader.sav")
						ksonsOVERSEER<<ksonsleader
						return
					if(24)
						ksons.Remove(removal)
						var/savefile/ksonsMember = new("data/rtd/ksons.sav")
						ksonsMember<<ksons
						return

		if("List members")
			switch (thechooser)
				if(1)
					var/name = "Current Ultramarine Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in umleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(2)
					var/name = "Current Ultramarines"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in umlist)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(3)
					var/name = "Current Salamander Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in smleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(4)
					var/name = "Current Salamanders"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in salamanders)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(5)
					var/name = "Current Krieg Officers"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in kriegofficers)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(6)
					var/name = "Current Tau Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in tauleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

				if(7)
					var/name = "Current Tau"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in tau)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(8)
					var/name = "Current Eldar Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in eldarleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(9)
					var/name = "Current Eldar"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in eldar)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(10)
					var/name = "Current RavenGuard Leader"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in ravenleader)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(11)
					var/name = "Current Raven Guard"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in ravenguard)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(12)
					var/name = "Current Tyranid Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in tyranidleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(13)
					var/name = "Current Tyranids"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in tyranid)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(14)
					var/name = "Ordo Hereticus Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in ohleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

				if(15)
					var/name = "Current Ordo Hereticus"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in ordohereticus)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(16)
					var/name = "Current OH Stormtroopers"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in stormtrooper)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(17)
					var/name = "Current SOB Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in sobleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(18)
					var/name = "Current SOB"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in sob)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(19)
					var/name = "Current Ork Leader"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in orkleader)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(20)
					var/name = "Current Orks"

					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

					for(var/C in ork)
						msg += "\t[C]"

						msg += "<BR>"

						msg += "\n"

					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(21)
					var/name = "Current Plague Marine Leader"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in pmleader)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(22)
					var/name = "Current Plague Marines"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in pmlist)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(23)
					var/name = "Current Thousand Sons Leader"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in ksonsleader)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
				if(24)
					var/name = "Current Thousand Sons"
					var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"
					for(var/C in ksons)
						msg += "\t[C]"
						msg += "<BR>"
						msg += "\n"
					usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

		if("Cancel") return

/mob/living/simple_animal/hostile/retaliate/goose/sprucegoose/proc/display_faction_membership()
	var/name = "All Lists:"
	var/msg = "<b>Factions:<BR></b>\n"
	msg += "PlagueMarines:"
	msg += "[pmlist]"
	msg += "<BR>"
	msg += "PlagueMarine leader:"
	msg += "[pmleader]"
	msg += "<BR>"
	msg += "Orks:"
	msg += "[ork]"
	msg += "<BR>"
	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")