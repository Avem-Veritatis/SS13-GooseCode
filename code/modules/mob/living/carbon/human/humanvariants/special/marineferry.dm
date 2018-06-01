
//ultramarines
/mob/living/carbon/human/whitelisted/um/verb/spacemarineshuttle()
	set name = "Call Shuttle"
	set desc = "Summon and dismiss the space marine shuttle."
	set category = "Object"
	MARINEshuttle(usr)
	return

/mob/living/carbon/human/whitelisted/um/proc/MARINEshuttle()
	var/dat = {"<B>Imperial Shuttle</B><br>
		<a href='?src=\ref[src];shuttle=1'>Move Shuttle</a><br>
		"}
	var/sound = 'sound/voice/mshuttle1.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle4.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle5.ogg'
	usr << sound(sound)
	var/mob/living/carbon/P = usr
	P.soundevent = 1
	spawn (80)
		P.soundevent = 0
	usr << browse(dat, "window=shuttle;size=400x400")
	return

/mob/living/carbon/human/whitelisted/um/Topic(href, href_list)
	var/mob/living/carbon/P = usr
	if(P.soundevent)
		usr << "<span class='warning'>Shuttle is busy. Please wait.</span>"
		return
	if(href_list["shuttle"])															//These all call the MARINEshuttle, hopefully
		switch(href_list["shuttle"])
			if("1")
				var/sound = 'sound/voice/mshuttle2.ogg'
				P.soundevent = 1
				usr << sound(sound)
				spawn (80)
					var/datum/shuttle_manager/s = shuttles["ferry"]
					if(istype(s)) s.move_shuttle(0,1)
					sound = 'sound/voice/mshuttle3.ogg'
					P.soundevent = 1
					usr << sound(sound)
				return


//salamanders

/mob/living/carbon/human/whitelisted/sm/verb/spacemarineshuttle()
	set name = "Call Shuttle"
	set desc = "Summon and dismiss the space marine shuttle."
	set category = "Object"
	MARINEshuttle(usr)
	return

/mob/living/carbon/human/whitelisted/sm/proc/MARINEshuttle()
	var/dat = {"<B>Imperial Shuttle</B><br>
		<a href='?src=\ref[src];shuttle=1'>Move Shuttle</a><br>
		"}
	var/sound = 'sound/voice/mshuttle1.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle4.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle5.ogg'
	usr << sound(sound)
	var/mob/living/carbon/P = usr
	P.soundevent = 1
	spawn (80)
		P.soundevent = 0
	usr << browse(dat, "window=shuttle;size=400x400")
	return

/mob/living/carbon/human/whitelisted/sm/Topic(href, href_list)
	var/mob/living/carbon/P = usr
	if(P.soundevent)
		usr << "<span class='warning'>Shuttle is busy. Please wait.</span>"
		return
	if(href_list["shuttle"])															//These all call the MARINEshuttle, hopefully
		switch(href_list["shuttle"])
			if("1")
				var/sound = 'sound/voice/mshuttle2.ogg'
				P.soundevent = 1
				usr << sound(sound)
				spawn (80)
					var/datum/shuttle_manager/s = shuttles["ferry"]
					if(istype(s)) s.move_shuttle(0,1)
					sound = 'sound/voice/mshuttle3.ogg'
					P.soundevent = 1
					usr << sound(sound)
				return



//ravenguard

//leader
/mob/living/carbon/human/whitelisted/ravenguardhead/verb/spacemarineshuttle()
	set name = "Call Shuttle"
	set desc = "Summon and dismiss the space marine shuttle."
	set category = "Object"
	MARINEshuttle(usr)
	return

/mob/living/carbon/human/whitelisted/ravenguardhead/proc/MARINEshuttle()
	var/dat = {"<B>Imperial Shuttle</B><br>
		<a href='?src=\ref[src];shuttle=1'>Move Shuttle</a><br>
		"}
	var/sound = 'sound/voice/mshuttle1.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle4.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle5.ogg'
	usr << sound(sound)
	var/mob/living/carbon/P = usr
	P.soundevent = 1
	spawn (80)
		P.soundevent = 0
	usr << browse(dat, "window=shuttle;size=400x400")
	return

/mob/living/carbon/human/whitelisted/ravenguardhead/Topic(href, href_list)
	var/mob/living/carbon/P = usr
	if(P.soundevent)
		usr << "<span class='warning'>Shuttle is busy. Please wait.</span>"
		return
	if(href_list["shuttle"])															//These all call the MARINEshuttle, hopefully
		switch(href_list["shuttle"])
			if("1")
				var/sound = 'sound/voice/mshuttle2.ogg'
				P.soundevent = 1
				usr << sound(sound)
				spawn (80)
					var/datum/shuttle_manager/s = shuttles["ferry"]
					if(istype(s)) s.move_shuttle(0,1)
					sound = 'sound/voice/mshuttle3.ogg'
					P.soundevent = 1
					usr << sound(sound)
				return

//rtd

/mob/living/carbon/human/whitelisted/rg/verb/spacemarineshuttle()
	set name = "Call Shuttle"
	set desc = "Summon and dismiss the space marine shuttle."
	set category = "Object"
	MARINEshuttle(usr)
	return

/mob/living/carbon/human/whitelisted/rg/proc/MARINEshuttle()
	var/dat = {"<B>Imperial Shuttle</B><br>
		<a href='?src=\ref[src];shuttle=1'>Move Shuttle</a><br>
		"}
	var/sound = 'sound/voice/mshuttle1.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle4.ogg'
	if(prob(10))
		sound = 'sound/voice/mshuttle5.ogg'
	usr << sound(sound)
	var/mob/living/carbon/P = usr
	P.soundevent = 1
	spawn (80)
		P.soundevent = 0
	usr << browse(dat, "window=shuttle;size=400x400")
	return

/mob/living/carbon/human/whitelisted/rg/Topic(href, href_list)
	var/mob/living/carbon/P = usr
	if(P.soundevent)
		usr << "<span class='warning'>Shuttle is busy. Please wait.</span>"
		return
	if(href_list["shuttle"])															//These all call the MARINEshuttle, hopefully
		switch(href_list["shuttle"])
			if("1")
				var/sound = 'sound/voice/mshuttle2.ogg'
				P.soundevent = 1
				usr << sound(sound)
				spawn (80)
					var/datum/shuttle_manager/s = shuttles["ferry"]
					if(istype(s)) s.move_shuttle(0,1)
					sound = 'sound/voice/mshuttle3.ogg'
					P.soundevent = 1
					usr << sound(sound)
				return