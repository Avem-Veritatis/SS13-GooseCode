/*
Hopefully just a quickly put together achievement system.
Lets see how this goes. -Drake
*/

#define ACHIEVEMENTS "data/player_achievements.sav"

/datum/player_stats
	var/list/achievements = list()

/proc/get_achievements(ckey)
	var/savefile/archive = new(ACHIEVEMENTS)
	if(!archive)	return 0
	if(ckey)
		var/list/contents = list()
		archive[lowertext(ckey)] >> contents
		if(!contents)
			return 0
		return contents
	return 0

/proc/has_achievement(ckey, achievement)
	var/savefile/archive = new(ACHIEVEMENTS)
	if(!archive)	return 0
	if(ckey)
		var/list/contents = list()
		archive[lowertext(ckey)] >> contents
		if(!contents)
			return 0
		if(achievement in contents) return 1
	return 0

/proc/add_achievement(ckey, achievement)
	var/savefile/archive = new(ACHIEVEMENTS)
	if(!archive)	return 0
	if(ckey)
		var/list/contents = list()
		archive[lowertext(ckey)] >> contents
		if(!contents)
			contents = list()
		if(!(achievement in contents))
			contents.Add(achievement)
			archive[lowertext(ckey)] << contents
			return 1
	return 0

/proc/award(var/mob/M, var/achievement)
	if(M.ckey)
		if(add_achievement(M.ckey, achievement))
			M << "\blue <b>New Achievement:</b> [achievement]"