//I haven't really made a good implementation for this but it is great for cinematics. If this were an admin verb you could pull some interesting stuff, or make it some kind of random event where someone sees visions of daemons telling them to kill people.
//Like hallucinations but more controlled, projected by watchers, wierd chemicals, and psychic thingies.
//A lot of code taken from fake_attacker, but much more versatile for more interesting application.
//By DrakeMarshall

/obj/effect/mob_projection
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = 0
	anchored = 1
	opacity = 0
	var/mob/living/carbon/human/my_target = null
	var/mob/living/clone = null
	var/image/currentimage = null
	var/image/left
	var/image/right
	var/image/up
	var/image/down
	var/lifetime = 600 //Default 1 minute lifetime. (deciseconds)
	var/message_delay = 200
	var/message = null //Specify a string if the projection is meant to say something to the victim.

proc/project_mob(var/mob/living/M,var/mob/living/carbon/human/T,var/msg)
	var/obj/effect/mob_projection/V = new /obj/effect/mob_projection
	V.clone = M
	V.my_target = T
	V.loc = get_turf(V.my_target)
	V.left = image(V.clone,dir = WEST)
	V.right = image(V.clone,dir = EAST)
	V.up = image(V.clone,dir = NORTH)
	V.down = image(V.clone,dir = SOUTH)
	V.name = V.clone.name
	V.message = msg
	spawn(V.lifetime)
		qdel(V)
	spawn V.update_loop()

/obj/effect/mob_projection/attackby(var/obj/item/weapon/P as obj, mob/user as mob)
	for(var/mob/M in oviewers(world.view,my_target))
		M << "\red <B>[my_target] flails around wildly.</B>"
	my_target.show_message("\red <B>[src] has been attacked by [my_target] </B>", 1) //Lazy.
	return

/obj/effect/mob_projection/Crossed(var/mob/M, somenumber)
	if(M == my_target)
		step_away(my_target,src,2) //These projections are less impactable by victim's actions. Mob projections can't be killed or pushed around like regular hallucinations.

/obj/effect/mob_projection/proc/updateimage()
//	del src.currentimage
	if(src.dir == NORTH)
		del src.currentimage
		src.currentimage = new /image(up,src)
	else if(src.dir == SOUTH)
		del src.currentimage
		src.currentimage = new /image(down,src)
	else if(src.dir == EAST)
		del src.currentimage
		src.currentimage = new /image(right,src)
	else if(src.dir == WEST)
		del src.currentimage
		src.currentimage = new /image(left,src)
	my_target << currentimage

/obj/effect/mob_projection/proc/update_loop()
	if(message)
		spawn(message_delay-10)
			if(!src in oview(7, my_target))
				src.loc = get_turf(my_target)
				step_away(src,my_target,3)
			my_target << "<span class='game say'><span class='name'>[src.name]</span><span class='message'> says, \"[message]\"</span></span>"
	while(1)
		sleep(rand(5,10))
		if(prob(70))
			if(get_dist(src,my_target) > 1)
				src.dir = get_dir(src,my_target)
				step_towards(src,my_target)
				updateimage()
			else if(prob(50))
				step_away(src,my_target,2)
				updateimage()

/obj/effect/mob_projection/agressive
	var/obj/item/W

/obj/effect/item_projection
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = 0
	anchored = 1
	opacity = 0
	var/mob/living/carbon/human/my_target = null
	var/lifetime = 600
	var/image/currentimage

proc/project_item(var/mob/living/carbon/human/T,var/obj/clone,var/location) //Nothing to fancy here, only objects can be placed.
	var/obj/item/message_projection/N = new /obj/effect/mob_projection
	N.my_target = T
	if(location)
		N.loc = location
	else
		N.loc = get_turf(N.my_target)
	N.name = clone.name
	N.desc = clone.desc
	N.currentimage = image(clone)
	spawn(N.lifetime)
		qdel(N)
	spawn
		N.my_target << N.currentimage

/obj/item/message_projection //Mentally constructed paper note.
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "nothing"
	name = "paper"
	desc = ""
	opacity = 0
	throwforce = 0
	w_class = 1.0
	throw_range = 1
	throw_speed = 1
	var/mob/living/carbon/human/my_target = null
	var/lifetime = 600
	var/message = ""
	var/image/currentimage

proc/project_note(var/mob/living/carbon/human/T,var/msg)
	var/obj/item/message_projection/N = new /obj/effect/mob_projection
	N.my_target = T
	N.loc = get_turf(N.my_target)
	N.currentimage = image('icons/obj/bureaucracy.dmi',N,"paper_words",OBJ_LAYER)
	N.message = msg
	spawn(N.lifetime)
		qdel(N)
	spawn
		while(1)
			sleep(5)
			N.my_target << N.currentimage

/obj/item/message_projection/examine()
	set src in oview(1)
	if(is_blind(usr))
		return
	if(in_range(usr, src))
		if( !(ishuman(usr) || isobserver(usr) || issilicon(usr)) )
			usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[message]<HR></BODY></HTML>", "window=[name]")
			onclose(usr, "[name]")
		else
			usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[message]<HR></BODY></HTML>", "window=[name]")
			onclose(usr, "[name]")
	else
		usr << "<span class='notice'>It is too far away.</span>"

/obj/item/message_projection/attack_self(mob/user)
	examine()

/obj/effect/turf_projection
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = 0
	anchored = 1
	opacity = 0
	var/mob/living/my_target
	var/image/currentimage
	var/lifetime = 600

/obj/effect/turf_projection/attackby(var/obj/item/weapon/P as obj, mob/user as mob)
	for(var/mob/M in oviewers(world.view,my_target))
		M << "\red <B>[my_target] flails around wildly.</B>"
	my_target.show_message("You push the wall but nothing happens!", 1) //Lazy.
	return

/obj/effect/turf_projection/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(mover == my_target)
		return 0
	return 1

proc/project_turf(var/mob/living/carbon/human/T,var/location) //Nothing to fancy here, only objects can be placed.
	var/obj/effect/turf_projection/N = new /obj/effect/turf_projection
	N.my_target = T
	N.loc = location
	N.currentimage = image('icons/turf/shuttle.dmi',N,"wall3",MOB_LAYER+1) //Should be above basically everything.
	spawn(N.lifetime)
		qdel(N)
	spawn
		N.my_target << N.currentimage
	return N