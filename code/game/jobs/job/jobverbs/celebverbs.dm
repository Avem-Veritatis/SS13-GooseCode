/mob/living/carbon/human/proc/celebshuttle()
	set category = "Celebrity"
	set name = "Move ship"
	set desc = "Like an obediant dog... your ship comes on command."
	//set src in usr
	var/mob/living/carbon/human/U = src
	if(!ishuman(src))
		usr << text("<span class='notice'>Wait.. what are you?.</span>")
		return
	if(U.stat == DEAD)
		U <<"Pffft! Your dead! Your ship remarried, it didn't wait for you."							//user is dead
		return
	if(!U.canmove || U.stat || U.restrained())
		U.say("Must... reach... implant...")	//user is tied up
		return
	if(U.brainloss >= 60)
		U << text("<span class='notice'>You have no idea where you even are right now.</span>")		//user is stupid
		U.visible_message(text("<span class='alert'>[U] stares blankly.</span>"))
		U << text("<span class='notice'>Your head feels funny.")
		U << text("<span class='notice'>Oh crap. You need to call an adult!")
		U.say("Is it cold up there in space bowie? Does it make your nipples all pointy point?")
		return
	else
		U.visible_message(text("<span class='alert'>[U] activates a tiny wrist mounted control panel. Implants are so useful!</span>"))
		var/datum/shuttle_manager/s = shuttles["celeb"]
		if(istype(s)) s.move_shuttle(0,1)
		return
