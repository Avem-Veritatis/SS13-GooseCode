/*
Undercover Goose
The death sequence is coded into simple_animal under die()
*/

/*

/datum/job/ugoose
	title = "Undercover Goose"
	flag = UGOOSE
	department_head = list("Norc")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Goose King"
	selection_color = "#ddffdd"
	minimal_player_age = 7

/datum/job/ugoose/equip(var/mob/living/carbon/human/H)
	H << "\blue Shhhhhhh they suspect nothing."
	if(!H)	return 0
	return H.Goosify()

*/
/mob/living/carbon/human/proc/Goosify(var/delete_items = 0)
	if (notransform)
		return
	for(var/obj/item/W in src)
		unEquip(W)
	regenerate_icons()
	notransform = 1
	canmove = 0
	icon = null
	invisibility = 101
	for(var/t in organs)
		qdel(t)

	var/mob/living/simple_animal/ugoose/newgoose

	newgoose = new /mob/living/simple_animal/ugoose(loc)
	newgoose.key = key

	newgoose << "<B>Go forth and conquer!</B>"
	. = newgoose
	newgoose.loc = get_turf(locate("landmark*goose")) //Hardcoding this because I have no idea why it's not working.
	newgoose.verbs += /mob/living/simple_animal/ugoose/proc/changedisguise
	qdel(src)

/mob/living/simple_animal/ugoose/proc/changedisguise()
	set category = "Undercover Goose"
	set name = "Change your disguise"
	set desc = "CHA CHA CHANGES! Turn and face the strange changes!"
	//set src in usr
	var/mob/living/simple_animal/ugoose/U = src
	switch(U.disguisenumber)
		if (1)											//SpaceMarine
			U.icon_state = "cutout2"
			U.disguisenumber = 2
			U.name = "UltraMarine!"
			U.desc = "What the? An Ultramarine?!?!?!?"
		if (2)											//Adepetus Custodes!
			U.icon_state = "cutout3"
			U.disguisenumber = 3
			U.name = "Adepetus Custodes!"
			U.desc = "What the?! A Custodes? Here? On ArchAngel?!"
		if (3)											//Tyranid
			U.icon_state = "cutout4"
			U.disguisenumber = 4
			U.name = "A Tyranid!"
			U.desc = "He doesn't smell like a Tyranid. He kinda smells like cardboard."
		if (4)											//warpspawn
			U.icon_state = "cutout5"
			U.disguisenumber = 5
			U.name = "A Warpspawn!"
			U.desc = "Not sure what this thing is but it is DEFINITELY from the warp. Probably a goose or something."
		if (5)											//Ork
			U.icon_state = "cutout6"
			U.disguisenumber = 6
			U.name = "Warboss Gooseface"
			U.desc = "RIGHT! YOU GITS LISTEN TO ME YOU TELLS ME WHO TAUGHT YOU TO READ!"
		if (6)
			U.icon_state = "cutout"					//return to assistant
			U.disguisenumber = 1
			U.name = "Assistant"
			U.desc = "Seems Legit!"

