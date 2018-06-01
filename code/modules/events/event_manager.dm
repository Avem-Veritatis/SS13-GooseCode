var/datum/controller/event/events

/datum/controller/event
	var/list/control = list()	//list of all datum/round_event_control. Used for selecting events based on weight and occurrences.
	var/list/running = list()	//list of all existing /datum/round_event

	var/scheduled = 0			//The next world.time that a naturally occuring random event can be selected.
	var/frequency_lower = 3000	//5 minutes lower bound.
	var/frequency_upper = 9000	//15 minutes upper bound. Basically an event will happen every 15 to 30 minutes.

	var/holiday					//This will be a string of the name of any realworld holiday which occurs today (GMT time)

//Initial controller setup.
/datum/controller/event/New()
	//There can be only one events manager. Out with the old and in with the new.
	if(events != src)
		if(istype(events))
			del(events)
		events = src

	for(var/type in typesof(/datum/round_event_control))
		var/datum/round_event_control/E = new type()
		if(!E.typepath)
			continue				//don't want this one! leave it for the garbage collector
		control += E				//add it to the list of all events (controls)
	reschedule()


//This is called by the MC every MC-tick (*neatfreak*).
/datum/controller/event/proc/process()
	checkEvent()
	var/i = 1
	while(i<=running.len)
		var/datum/round_event/Event = running[i]
		if(Event)
			Event.process()
			i++
			continue
		running.Cut(i,i+1)

//checks if we should select a random event yet, and reschedules if necessary
/datum/controller/event/proc/checkEvent()
	if(scheduled <= world.time)
		spawnEvent()
		reschedule()

//decides which world.time we should select another random event at.
/datum/controller/event/proc/reschedule()
	scheduled = world.time + rand(frequency_lower, max(frequency_lower,frequency_upper))

//selects a random event based on whether it can occur and it's 'weight'(probability)
/datum/controller/event/proc/spawnEvent()
	if(!config.allow_random_events)
		return

	var/sum_of_weights = 0
	for(var/datum/round_event_control/E in control)
		if(E.occurrences >= E.max_occurrences)	continue
		if(E.earliest_start >= world.time)		continue
		if(E.holidayID)
			if(E.holidayID != holiday)			continue
		if(E.weight < 0)						//for round-start events etc.
			if(E.runEvent() == PROCESS_KILL)
				E.max_occurrences = 0
				continue
			return
		sum_of_weights += E.weight

	sum_of_weights = rand(0,sum_of_weights)	//reusing this variable. It now represents the 'weight' we want to select

	for(var/datum/round_event_control/E in control)
		if(E.occurrences >= E.max_occurrences)	continue
		if(E.earliest_start >= world.time)		continue
		if(E.holidayID)
			if(E.holidayID != holiday)			continue
		sum_of_weights -= E.weight

		if(sum_of_weights <= 0)				//we've hit our goal
			if(E.runEvent() == PROCESS_KILL)//we couldn't run this event for some reason, set its max_occurrences to 0
				E.max_occurrences = 0
				continue
			return


/datum/round_event/proc/findEventArea() //Here's a nice proc to use to find an area for your event to land in!
	var/list/safe_areas = list(
	/area/turret_protected/ai,
	/area/turret_protected/ai_upload,
	/area/engine,
	/area/solar,
	/area/holodeck,
	/area/shuttle/arrival,
	/area/shuttle/escape/station,
	/area/shuttle/escape_pod1/station,
	/area/shuttle/escape_pod2/station,
	/area/shuttle/escape_pod3/station,
	/area/shuttle/escape_pod4/station,
	/area/shuttle/mining/station,
	/area/shuttle/transport1/station,
	/area/shuttle/specops/station)

	//These are needed because /area/engine has to be removed from the list, but we still want these areas to get fucked up.
	var/list/danger_areas = list(
	/area/engine/break_room,
	/area/engine/chiefs_office)

	//Need to locate() as it's just a list of paths.
	return locate(pick((the_station_areas - safe_areas) + danger_areas))



//allows a client to trigger an event (For Debugging Purposes)
/client/proc/forceEvent(var/datum/round_event_control/E in events.control)
	set name = "Trigger Event (Debug Only)"
	set category = "Debug"

	if(!holder)
		return

	if(istype(E))
		E.runEvent()
		message_admins("[key_name_admin(usr)] has triggered an event. ([E.name])", 1)

