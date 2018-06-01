/mob/dead/observer
	name = "spirit"
	desc = "The soul of a dead sentient being, still lingering in the warp near its place of death in the material world."
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost"
	layer = 4
	stat = DEAD
	density = 0
	canmove = 0
	blinded = 0
	anchored = 1	//  don't get pushed around
	invisibility = INVISIBILITY_OBSERVER
	var/can_reenter_corpse
	var/datum/hud/living/carbon/hud = null // hud
	var/started_as_observer //This variable is set to 1 when you enter the game as an observer.
							//If you died in the game and are a ghsot - this will remain as null.
							//Note that this is not a reliable way to determine if admins started as observers, since they change mobs a lot.
	var/atom/movable/following = null
	var/factionnumber = 0
	var/inmenu = 0
	var/can_rtd = 1
	var/master = ""

/mob/dead/observer/New(mob/body)
	sight |= SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_SELF
	see_invisible = SEE_INVISIBLE_OBSERVER
	see_in_dark = 100
	verbs += /mob/dead/observer/proc/dead_tele
	stat = DEAD

	var/turf/T
	if(ismob(body))
		T = get_turf(body)				//Where is the body located?
		attack_log = body.attack_log	//preserve our attack logs by copying them to our ghost

		gender = body.gender
		if(body.mind && body.mind.name)
			name = body.mind.name
		else
			if(body.real_name)
				name = body.real_name
			else
				name = random_name(gender)

		mind = body.mind	//we don't transfer the mind but we keep a reference to it.

	if(!T)	T = pick(latejoin)			//Safety in case we cannot find the body's position
	loc = T

	if(!name)							//To prevent nameless ghosts
		name = random_name(gender)
	real_name = name
	..()

/mob/dead/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	return 1
/*
Transfer_mind is there to check if mob is being deleted/not going to have a body.
Works together with spawning an observer, noted above.
*/

/mob/proc/ghostize(var/can_reenter_corpse = 1)
	if(key)
		if(!cmptext(copytext(key,1,2),"@")) //aghost
			var/mob/dead/observer/ghost
			if(fealty)
				ghost = new /mob/dead/observer/cursed(src)
				ghost.key = key
				ghost.master = fealty
				if(!istype(src, /mob/living/simple_animal/hostile/dark_ghost)) //No need to show this to them again.
					ghost << "\red <b>[ghost.master] holds you to your oath of fealty.</b>"
					ghost << "\red <b>Having failed [ghost.master] by being dispelled from the material realm, you are now very weak.</b>"
					ghost << "\red <b>I am sure you will be able to find some capacity to which you may be of service, however.</b>"
			else
				ghost = new /mob/dead/observer(src)	//Transfer safety to observer spawning proc.
				ghost.can_reenter_corpse = can_reenter_corpse
				ghost.key = key
			return ghost

/*
This is the proc mobs get to turn into a ghost. Forked from ghostize due to compatibility issues.
*/
/mob/living/verb/ghost()
	set category = "OOC"
	set name = "Ghost"
	set desc = "Relinquish your life and enter the land of the dead."

	if(stat != DEAD)
		succumb()
	if(stat == DEAD)
		ghostize(1)
	else
		var/response = alert(src, "Are you -sure- you want to ghost?\n(You are alive. If you ghost whilst still alive you may not play again this round! You can't change your mind so choose wisely!!)","Are you sure you want to ghost?","Ghost","Stay in body")
		if(response != "Ghost")	return	//didn't want to ghost after-all
		resting = 1
		ghostize(0)						//0 parameter is so we can never re-enter our body, "Charlie, you can never come baaaack~" :3
	return


/mob/dead/observer/Move(NewLoc, direct)

	dir = direct //Now ghost graphics have directions, so lets put this in. -Drake

	var/turf/destination = get_step(get_turf(src),direct)
	if(destination)
		for(var/obj/effect/warp/W in range(destination, 0)) //Ghost walls. For no particular reason. -Drake
			if(W.ghost_density)
				return
		var/area/AR = get_area(destination)
		if(istype(AR, /area/maintenance/undermaint) || istype(AR, /area/maintenance/safe)) //None of that!
			return

	if (istype(destination, /turf/simulated/floor/plating/wasteland))
		src << "\red As you occupy the fully immaterial world, you gain solid form."
		new /mob/living/simple_animal/hostile/manifest_ghost(get_turf(src), src)
		spawn(1)
			qdel(src)
		return

	if(NewLoc)
		loc = NewLoc
		for(var/obj/effect/step_trigger/S in NewLoc)
			S.Crossed(src)

		return
	loc = get_turf(src) //Get out of closets and such as a ghost //Why in the emprah's name would a ghost get put in a closet?!
	if((direct & NORTH) && y < world.maxy)
		y++
	else if((direct & SOUTH) && y > 1)
		y--
	if((direct & EAST) && x < world.maxx)
		x++
	else if((direct & WEST) && x > 1)
		x--

	for(var/obj/effect/step_trigger/S in locate(x, y, z))	//<-- this is dumb
		S.Crossed(src)

/mob/dead/observer/examine()
	if(usr)
		usr << desc

/mob/dead/observer/can_use_hands()	return 0
/mob/dead/observer/is_active()		return 0

/mob/dead/observer/Stat()
	..()
	statpanel("Status")
	if (client.statpanel == "Status")
		stat(null, "Station Time: [worldtime2text()]")
		if(ticker)
			if(ticker.mode)
				//world << "DEBUG: ticker not null"
				if(ticker.mode.name == "AI malfunction")
					//world << "DEBUG: malf mode ticker test"
					if(ticker.mode:malf_mode_declared)
						stat(null, "Time left: [max(ticker.mode:AI_win_timeleft/(ticker.mode:apcs/3), 0)]")
		if(emergency_shuttle)
			if(emergency_shuttle.online && emergency_shuttle.location < 2)
				var/timeleft = emergency_shuttle.timeleft()
				if (timeleft)
					stat(null, "ETA-[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")

/mob/dead/observer/verb/reenter_corpse()
	set category = "Ghost"
	set name = "Re-enter Corpse"
	if(!client)	return
	if(!(mind && mind.current))
		src << "<span class='warning'>You have no body.</span>"
		return
	if(!can_reenter_corpse)
		src << "<span class='warning'>You cannot re-enter your body.</span>"
		return
	if(mind.current.key && copytext(mind.current.key,1,2)!="@")	//makes sure we don't accidentally kick any clients
		usr << "<span class='warning'>Another consciousness is in your body...It is resisting you.</span>"
		return
	if(mind.current.ajourn && mind.current.stat != DEAD) 	//check if the corpse is astral-journeying (it's client ghosted using a cultist rune).
		var/obj/effect/rune/R = locate() in mind.current.loc	//whilst corpse is alive, we can only reenter the body if it's on the rune
		if(!(R && R.word1 == wordhell && R.word2 == wordtravel && R.word3 == wordself))	//astral journeying rune
			usr << "<span class='warning'>The astral cord that ties your body and your spirit has been severed. You are likely to wander the realm beyond until your body is finally dead and thus reunited with you.</span>"
			return
	mind.current.ajourn=0
	mind.current.key = key
	return 1

/mob/dead/observer/proc/dead_tele()
	set category = "Ghost"
	set name = "Teleport"
	set desc= "Teleport to a location"
	if(!istype(usr, /mob/dead/observer))
		usr << "Not when you're not dead!"
		return
	usr.verbs -= /mob/dead/observer/proc/dead_tele
	spawn(30)
		usr.verbs += /mob/dead/observer/proc/dead_tele
	var/A
	A = input("Area to jump to", "BOOYEA", A) as null|anything in ghostteleportlocs
	var/area/thearea = ghostteleportlocs[A]
	if(!thearea)	return

	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		L+=T

	if(!L || !L.len)
		usr << "No area available."

	usr.loc = pick(L)

/mob/dead/observer/verb/enter_the_warp()
	set category = "Ghost"
	set name = "Enter the Warp"
	set desc= "Enter the deep warp (warning, you won't be able to leave once you enter!)"
	enter_warp(src)

/mob/dead/observer/verb/lookforgretchin()
	set category = "Ghost"
	set name = "Try to be an Ork"
	set desc= "Look for a gretchin to become. (warning, this could overwrite all other RTD for the round.)"
	var/response = alert(src, "Would like to search for an empty gretchin to possess?", "Ork Gretchin request", "Yes", "No")

	if(response == "Yes")
		for(var/mob/living/carbon/human/ork/gretchin/M in world)
			if(M.isempty == 1)
				if(M.health > 0)
					src << "\blue Found one!"
					M.key = usr.key
					M.isempty = 0
					break
				src << "\blue [M] is dead."
			else
				src << "\blue [M] is occupied."
		src << "\blue They are all occupied!!"
	else if (response == "No")
		src << "\blue Then stop bothering me."

/mob/dead/observer/verb/lookfortyranid()
	set category = "Ghost"
	set name = "Try to be a Tyranid"
	set desc= "Look for a tyranid larva to become. (warning, this could overwrite all other RTD for the round.)"
	var/response = alert(src, "Would like to search for an empty tyranid larva to possess?", "Tyranid Larva request", "Yes", "No")

	if(response == "Yes")
		for(var/mob/living/carbon/alien/larva/tyranid/M in world)
			if(M.isempty == 1)
				if(M.health > 0)
					src << "\blue Found one!"
					M.key = usr.key
					M.isempty = 0
					break
				src << "\blue [M] is dead."
			else
				src << "\blue [M] is occupied."
		src << "\blue They are all occupied!!"
	else if (response == "No")
		src << "\blue Then stop bothering me."

/mob/dead/observer/verb/follow()
	set category = "Ghost"
	set name = "Follow" // "Haunt"
	set desc = "Follow and haunt a mob."

	var/list/mobs = getmobs()
	for(var/mob/M in mobs) //Removes some of these mobs. There are three good reasons for this: 1: Having all the necron and daemon NPCs show up makes a lot of annoying scrolling. 2: By lore, it makes sense that a dead spirit can't just find a necron, since no psychic signature. And they probably couldn't find a daemon very easily for other reasons. 3: I don't want ghosts jumping to daemons in the deep warp.
		if(istype(M, /mob/living/simple_animal/hostile/retaliate/daemon))
			mobs.Remove(M)
		if(istype(M, /mob/dead/observer))
			mobs.Remove(M)
		if(istype(M, /mob/living/simple_animal/hostile/necron))
			mobs.Remove(M)
		if(istype(M, /mob/living/silicon/robot/necron))
			mobs.Remove(M)
//		if(istype(M, /mob/living/simple_animal/hostile/asteroid))    //This is not a thing
//			dest.Remove(M)
	 //All these removals should make ghost following less flooded by random critters.
	var/input = input("Please, select a mob!", "Haunt", null, null) as null|anything in mobs
	var/mob/target = mobs[input]
	ManualFollow(target)

// This is the ghost's follow verb with an argument
/mob/dead/observer/proc/ManualFollow(var/atom/movable/target)
	if(target && target != src)
		if(following && following == target)
			return
		following = target
		src << "\blue Now following [target]"
		spawn(0)
			var/turf/pos = get_turf(src)
			while(loc == pos && target && following == target && client)
				var/turf/T = get_turf(target)
				var/area/AR = get_area(T)
				if(istype(AR, /area/maintenance/undermaint) || istype(AR, /area/maintenance/safe)) //None of that!
					following = null
					return
				if(!T)
					break
				// To stop the ghost flickering.
				if(loc != T)
					loc = T
				pos = loc
				sleep(15)
			if (target == following) following = null


/mob/dead/observer/verb/jumptomob() //Moves the ghost instead of just changing the ghosts's eye -Nodrak
	set category = "Ghost"
	set name = "Jump to Mob"
	set desc = "Teleport to a mob"

	if(istype(usr, /mob/dead/observer)) //Make sure they're an observer!


		var/list/dest = list() //List of possible destinations (mobs)
		var/target = null	   //Chosen target.

		dest += getmobs() //Fill list, prompt user with list

		for(var/mob/M in dest)
			if(istype(M, /mob/living/simple_animal/hostile/retaliate/daemon))
				dest.Remove(M)
			if(istype(M, /mob/living/simple_animal/hostile/necron))
				dest.Remove(M)
			if(istype(M, /mob/living/silicon/robot/necron))
				dest.Remove(M)
			if(istype(M, /mob/living/simple_animal/hostile/asteroid))
				dest.Remove(M)

		target = input("Please, select a player!", "Jump to Mob", null, null) as null|anything in dest

		if (!target)//Make sure we actually have a target
			return
		else
			var/mob/M = dest[target] //Destination mob
			var/mob/A = src			 //Source mob
			var/turf/T = get_turf(M) //Turf of the destination mob

			var/area/AR = get_area(T)
			if(istype(AR, /area/maintenance/undermaint) || istype(AR, /area/maintenance/safe)) //None of that!
				following = null
				return

			if(T && isturf(T))	//Make sure the turf exists, then move the source to that destination.
				A.loc = T
			else
				A << "This mob is not located in the game world."
/*
/mob/dead/observer/verb/boo()
	set category = "Ghost"
	set name = "Boo!"
	set desc= "Scare your crew members because of boredom!"

	if(bootime > world.time) return
	var/obj/machinery/light/L = locate(/obj/machinery/light) in view(1, src)
	if(L)
		L.flicker()
		bootime = world.time + 600
		return
	//Maybe in the future we can add more <i>spooky</i> code here!
	return
*/

/mob/dead/observer/memory()
	set hidden = 1
	src << "\red You are dead! You have no mind to store memory!"

/mob/dead/observer/add_memory()
	set hidden = 1
	src << "\red You are dead! You have no mind to store memory!"

/mob/dead/observer/verb/toggle_darkness()
	set name = "Toggle Darkness"
	set category = "Ghost"

	if (see_invisible == SEE_INVISIBLE_OBSERVER_NOLIGHTING)
		see_invisible = SEE_INVISIBLE_OBSERVER
	else
		see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING

/mob/dead/observer/verb/view_manfiest()
	set name = "View Crew Manifest"
	set category = "Ghost"

	var/dat
	dat += "<h4>Crew Manifest</h4>"
	dat += data_core.get_manifest()

	src << browse(dat, "window=manifest;size=370x420;can_close=1")

/*
New Whitelist. Because the old one sucks
Update: What have we created?
*/

/mob/dead/observer/verb/RTD()
	set category = "Ghost"
	set name = "RTD" // "Haunt"
	set desc = "Allows a player who has been authorized to use a whitelisted role to respawn as that role."
	if(!ticker || !ticker.mode)
		usr << "\blue The game hasn't started yet!"
		return
	if(!can_rtd)
		usr << "\red <b>The fealty of your soul is commanded by [master]. You are not free to go.</b>"
		return
	if(ticker.mode.name == "necron")
		usr << "\blue Reinforcements are cut off! OH MY GOD!!!"
		return
	if(world.time - round_start_time < config.shuttle_refuel_delay)
		usr << "\blue The round has just begun! Please wait another [abs(round(((world.time - round_start_time) - config.shuttle_refuel_delay)/600))] minutes before trying again."
		return
	if(inmenu)
		usr << "\blue I didn't learn to code yesterday. First- close the menu you already have open."
		return
	if (mind && mind.current)
		if (mind.current.stat != DEAD)
			usr << "\blue Yeah like I didn't think of that. Your body is still alive dumbass."
			return
		else
			usr <<	"\blue You have a body but it is dead. Proceeding."
			inmenu = 1
			researchavailable()
			award(usr, "One of us!")
			return
	else
		award(usr, "<span class='silver'>One of us!</span>")
		inmenu = 1
		researchavailable()
		return

/mob/dead/observer/proc/researchavailable()
	var/RTDoptions = list("")
	RTDoptions += availfaction
	if (lowertext(usr.key) in salamanders)
		RTDoptions += "SALAMANDERS"								//SALAMANDERS
	if (lowertext(usr.key) in umlist)
		RTDoptions += "ULTRAMARINES"							//ULTRAMARINES
	if (lowertext(usr.key) in kriegofficers)
		RTDoptions += "KRIEGOFFICERS"							//KRIEGOFFICERS
	if (lowertext(usr.key) in tau)
		RTDoptions += "TAU"										//TAU
	if (lowertext(usr.key) in eldar)
		RTDoptions += "ELDAR"									//ELDAR
	if (lowertext(usr.key) in ravenguard)
		RTDoptions += "RAVENGUARD"								//RAVENGUARD
	if (lowertext(usr.key) in sob)
		RTDoptions += "SOB"										//SOB
	if (lowertext(usr.key) in ork)
		RTDoptions += "ORK"										//ORK
	if (lowertext(usr.key) in pmlist)
		RTDoptions += "PLAGUEMARINES"							//PLAGUEMARINES
	if (lowertext(usr.key) in ksons)
		RTDoptions += "THOUSANDSONS"							//THOUSANDSONS
	if (lowertext(usr.key) in ordohereticus)
		RTDoptions += "ORDOHERETICUS"							//ORDOHERETICUS
	if (lowertext(usr.key) in stormtrooper)
		RTDoptions += "STORMTROOPERS"							//STORMTROOPERS
	if (lowertext(usr.key) in tyranid)
		RTDoptions += "TYRANIDS"								//TYRANIDS
										//So called 'Leaders'
	if (lowertext(usr.key) in umleader)
		RTDoptions += "UMLEADER"								//UMLEADER
	if (lowertext(usr.key) in smleader)
		RTDoptions += "SMLEADER"								//SMLEADER
	if (lowertext(usr.key) in tauleader)
		RTDoptions += "TAULEADER"								//TAULEADER
	if (lowertext(usr.key) in eldarleader)
		RTDoptions += "ELDARLEADER"								//ELDARLEADER
	if (lowertext(usr.key) in ravenleader)
		RTDoptions += "RAVENLEADER"								//RAVENLEADER
	if (lowertext(usr.key) in tyranidleader)
		RTDoptions += "TYRANIDLEADER"							//TYRANIDLEADER
	if (lowertext(usr.key) in sobleader)
		RTDoptions += "SOBLEADER"								//SOBLEADER
	if (lowertext(usr.key) in orkleader)
		RTDoptions += "ORKLEADER"								//ORKLEADER
	if (lowertext(usr.key) in pmleader)
		RTDoptions += "PMLEADER"								//PMLEADER
	if (lowertext(usr.key) in ksonsleader)
		RTDoptions += "KSONSLEADER"								//KSONSLEADER
	if (lowertext(usr.key) in ohleader)
		RTDoptions += "OHLEADER"
	if (lowertext(usr.key) in ohsleader)
		RTDoptions += "OHSTORMLEADER"
	RTDoptions += "Cancel" 										//Gonna sneak this into the list so it'll pop up as an option in choosefromlist()
	choosefromlist(RTDoptions)
	return

/mob/dead/observer/proc/choosefromlist(RTDoptions)
	var/sound = 'sound/voice/rtdmenu4.ogg'
	if(prob(10))
		sound = 'sound/voice/rtdmenu2.ogg'
	if(prob(10))
		sound = 'sound/voice/rtdmenu5.ogg'
	usr << sound(sound)
	var/editchoice																		//start the var
	editchoice = input("Select an available faction:","Faction Selection") as null|anything in RTDoptions	//surprise! var is input
	switch(editchoice)

		if("KRIEGER")
			message_admins("[usr.key] executed RTD faction: Krieger.", 0)
			usr << "\blue You are an Imperial guardsman from the Death Korps of Krieg. Location: High Orbit, ArchAngel IV. No metagaming!"
			usr.loc = get_turf(locate("landmark*kriegstart"))
			var/mob/living/carbon/human/krieg/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("SALAMANDERS")
			message_admins("[usr.key] executed RTD faction: SalamanderMarine.", 0)
			usr << "\blue You are a Salamander Marine on your way back to Vulcan. There is a distress call from ArchAngel IV."
			usr.loc = get_turf(locate("landmark*smstart"))
			var/mob/living/carbon/human/whitelisted/sm/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ULTRAMARINES")
			message_admins("[usr.key] executed RTD faction: Ultramarine.", 0)
			usr << "\blue You are an UltraMarine on your way back to Ultramar. There is a distress call from ArchAngel IV."
			usr.loc = get_turf(locate("landmark*UMteam"))
			var/mob/living/carbon/human/whitelisted/um/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("KRIEGOFFICERS")
			message_admins("[usr.key] executed RTD faction: Krieger Officer.", 0)
			usr << "\blue You are an officer of the Death Korps of Krieg. The Lord General of ArchAngel IV has activated a distress beacon."
			usr.loc = get_turf(locate("landmark*kriegofficerstart"))
			var/mob/living/carbon/human/kriegofficer/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("TAU")
			message_admins("[usr.key] executed RTD faction: Tau.", 0)
			usr << "\blue You are Tau. You must spread the greater good. Free the people of this sector. Only Tyrants stand against liberty and freedom. Crush those who seek to supress your message."
			usr.loc = get_turf(locate("landmark*taustart"))
			var/mob/living/carbon/human/tau/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ELDAR")
			message_admins("[usr.key] executed RTD faction: Eldar.", 0)
			usr << "\blue You are an Eldar. Fucking humans are on the verge of plunging this sector into darkness. Stop them before it's too late!"
			usr.loc = get_turf(locate("landmark*eldarstart"))
			var/mob/living/carbon/human/whitelisted/eldar/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("RAVENGUARD")
			message_admins("[usr.key] executed RTD faction: RavenGuard.", 0)
			usr << "\blue You are a RavenGuard on your way to a BBQ. There is a distress call from ArchAngel IV."
			usr.loc = get_turf(locate("landmark*rgstart"))
			var/mob/living/carbon/human/whitelisted/rg/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("SOB")
			message_admins("[usr.key] executed RTD faction: SOB.", 0)
			usr << "\blue You are a Sister of Battle. Mechanicus has reported pitched battle on ArchAngel IV. Lets turn up the heat."
			usr.loc = get_turf(locate("landmark*sobteam"))
			var/mob/living/carbon/human/sob/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ORK")
			message_admins("[usr.key] executed RTD faction: Ork.", 0)
			usr << "\blue YOU IS ORK! ERE WE GO!!"
			usr.loc = get_turf(locate("landmark*orkstart"))
			var/mob/living/carbon/human/ork/gretchin/new_character = new(usr.loc)
			new_character.isempty = 0
			new_character.key = usr.key
			qdel(src)

		if("PLAGUEMARINES")
			message_admins("[usr.key] executed RTD faction: PlagueMarines.", 0)
			usr << "\blue You are a Plague Marine of Nurgle. The ArchAngel system is a high traffic transfer point. If you can infect a small group of fleeing humans, you'd end up infecting the entire sector."
			usr.loc = get_turf(locate("landmark*pmteam"))
			var/mob/living/carbon/human/whitelisted/pm/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("THOUSANDSONS")
			message_admins("[usr.key] executed RTD faction: ThousandSons.", 0)
			usr << "\blue You are a Thousand Sons! M'kachen is trapped on ArchAngel IV. Find him. Free him."
			usr.loc = get_turf(locate("landmark*ksonsteam"))
			var/mob/living/carbon/human/whitelisted/ksons/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ORDOHERETICUS")
			message_admins("[usr.key] executed RTD faction: OrdoHereticus Inquisitor.", 0)
			usr << "\blue You are an Ordo Hereticus Inquisitor. The Acolytes on ArchAngel IV have reported all kinds of heresy. It's time to shut this little project down."
			usr.loc = get_turf(locate("landmark*OHstart"))
			var/mob/living/carbon/human/OHinq/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("OHLEADER")
			message_admins("[usr.key] executed RTD faction: OrdoHereticus Inquisitor(Leader).", 0)
			usr << "\blue You are an Ordo Hereticus Inquisitor. The Acolytes on ArchAngel IV have reported all kinds of heresy. It's time to shut this little project down."
			usr.loc = get_turf(locate("landmark*OHstart"))
			var/mob/living/carbon/human/OHinq/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("OHSTORMLEADER")
			message_admins("[usr.key] executed RTD faction: OrdoHereticus StormTrooper Captain.", 0)
			usr << "\blue You are an Ordo Hereticus Inquisitorial Stormtrooper. The Acolytes on ArchAngel IV have reported all kinds of heresy. It's time to shut this little project down."
			usr.loc = get_turf(locate("landmark*OHstart"))
			var/mob/living/carbon/human/OHstormtrooper/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("STORMTROOPERS")
			message_admins("[usr.key] executed RTD faction: OH StormTrooper.", 0)
			usr << "\blue You are an Inquisitorial Stormtrooper, assigned to Ordo Hereticus on board the 'StarGazer'. You are to take your orders from the Ordo Hereticus and protect them with your life!"
			usr.loc = get_turf(locate("landmark*OHstart"))
			var/mob/living/carbon/human/OHstormtrooper/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("TYRANIDS")
			message_admins("[usr.key] executed RTD faction: Tyranid.", 0)
			usr << "\blue You are a Tyranid. ITS TIME FOR SUPPER!"
			usr.loc = get_turf(locate("landmark*wtyranidstart"))
			var/mob/living/carbon/alien/larva/tyranid/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("UMLEADER")
			message_admins("[usr.key] executed RTD faction: UltraMarine Leader.", 0)
			usr << "\blue You are an UltraMarine!"
			usr.loc = get_turf(locate("landmark*UMteam"))
			var/mob/living/carbon/human/whitelisted/um/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("SMLEADER")
			message_admins("[usr.key] executed RTD faction: SalamanderMarine Leader.", 0)
			usr << "\blue You are a Salamander Marine!"
			usr.loc = get_turf(locate("landmark*smstart"))
			var/mob/living/carbon/human/whitelisted/sm/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("TAULEADER")
			message_admins("[usr.key] executed RTD faction: Tau Leader.", 0)
			usr << "\blue You are Tau!"
			usr.loc = get_turf(locate("landmark*taustart"))
			var/mob/living/carbon/human/tau/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ELDARLEADER")
			message_admins("[usr.key] executed RTD faction: Eldar Leader.", 0)
			usr << "\blue You are an Eldar!"
			usr.loc = get_turf(locate("landmark*eldarstart"))
			var/mob/living/carbon/human/whitelisted/eldar/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("RAVENLEADER")
			message_admins("[usr.key] executed RTD faction: RavenGuard Leader.", 0)
			usr << "\blue You are a RavenGuard!"
			usr.loc = get_turf(locate("landmark*rgstart"))
			var/mob/living/carbon/human/whitelisted/ravenguardhead/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("TYRANIDLEADER")
			message_admins("[usr.key] executed RTD faction: Tyranid Leader.", 0)
			usr << "\blue You are a Tyranid!"
			usr.loc = get_turf(locate("landmark*wtyranidstart"))
			var/mob/living/carbon/alien/humanoid/tyranid/lictor/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("SOBLEADER")
			message_admins("[usr.key] executed RTD faction: SOB Leader.", 0)
			usr << "\blue You are a Sister of Battle!"
			usr.loc = get_turf(locate("landmark*sobteam"))
			var/mob/living/carbon/human/sob/cannoness/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("ORKLEADER")
			message_admins("[usr.key] executed RTD faction: Ork Warboss.", 0)
			usr << "\blue YOU IS ORK WARBOSS"
			usr.loc = get_turf(locate("landmark*orkstart"))
			var/mob/living/carbon/human/ork/warboss/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("PMLEADER")
			message_admins("[usr.key] executed RTD faction: Plague Marine Leader.", 0)
			usr << "\blue You are a Plague Marine of Nurgle!"
			usr.loc = get_turf(locate("landmark*pmteam"))
			var/mob/living/carbon/human/whitelisted/pmleader/new_character = new(usr.loc)
			new /obj/warpin(usr.loc)
			new_character.key = usr.key
			qdel(src)

		if("KSONSLEADER")
			message_admins("[usr.key] executed RTD faction: ThousandSons Leader.", 0)
			usr << "\blue You are a Captain in the Thousand Sons!"
			usr.loc = get_turf(locate("landmark*ksonsteam"))
			var/mob/living/carbon/human/whitelisted/ksons/leader/new_character = new(usr.loc)
			new_character.key = usr.key
			qdel(src)


		if("Cancel")
			inmenu = 0
			return

		else
			inmenu = 0
			return
