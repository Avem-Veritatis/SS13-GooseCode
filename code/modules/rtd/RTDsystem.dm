/*
RTD system- Goosecode.
*/

var/list/availfaction = list("KRIEGER")
var/list/umlist = list()
var/list/pmlist = list()
var/list/salamanders = list()
var/list/kriegofficers = list()
var/list/tau = list()
var/list/eldar = list()
var/list/ravenguard = list()
var/list/tyranid = list()
var/list/stormtrooper = list()
var/list/ordohereticus = list()
var/list/sob = list()
var/list/ork = list()
var/list/ksons = list()
//leaders
var/list/smleader = list()
var/list/umleader = list()
var/list/pmleader = list()
var/list/krleader = list()
var/list/tauleader = list()
var/list/eldarleader = list()
var/list/ravenleader = list()
var/list/tyranidleader = list()
var/list/ohleader = list()
var/list/sobleader = list()
var/list/orkleader = list()
var/list/ksonsleader = list()
var/list/ohsleader = list()

/proc/load_rtd()							//This is load_rtd. It gets called from world.dm whenever a world/new happens.
	log_admin("Loading RTD lists")
	loadsmsave()
	loadumsave()
	loadpmsave()
	loadkrsave()
	loadtausave()
	loadeldarsave()
	loadrgsave()
	loadtyranidsave()
	loadohsave()
	loadsobsave()
	loadorksave()
	loadksonssave()
//leaders
	loadsmleader()
	loadumleader()
	loadpmleader()
	loadtauleader()
	loadeldarleader()
	loadrgleader()
	loadtyranidleader()
	loadohleader()
	loadohsleader()			//not implemented
	loadsobleader()
	loadorkleader()
	loadksonsleader()
	return 1


/*
It kicks these off.
*/


/proc/loadumsave()
	if(!fexists("data/rtd/umMember.sav"))
		log_admin("OMG Can't find umMember.sav!")
	var/savefile/umMember = new("data/rtd/umMember.sav")
	umMember>>umlist									//file to object, object to list
	return

/proc/loadksonssave()
	if(!fexists("data/rtd/ksonsMember.sav"))
		log_admin("OMG Can't find ksonsMember.sav!")
	var/savefile/ksonsMember = new("data/rtd/ksonsMember.sav")
	ksonsMember>>ksons
	return

/proc/loadpmsave()
	if(!fexists("data/rtd/pmMember.sav"))
		log_admin("OMG Can't find pmMember.sav!")
	var/savefile/pmMember = new("data/rtd/pmMember.sav")
	pmMember>>pmlist
	return

proc/loadsmsave()
	if(!fexists("data/rtd/smMember.sav"))
		log_admin("OMG Can't find smMember.sav!")
	var/savefile/smMember = new("data/rtd/smMember.sav")
	smMember>>salamanders
	return

proc/loadkrsave()
	if(!fexists("data/rtd/krMember.sav"))
		log_admin("OMG Can't find krMember.sav!")
	var/savefile/krMember = new("data/rtd/krMember.sav")
	krMember>>kriegofficers
	return

proc/loadtausave()
	if(!fexists("data/rtd/tauMember.sav"))
		log_admin("OMG Can't find tauMember.sav!")
	var/savefile/tauMember = new("data/rtd/tauMember.sav")
	tauMember>>tau
	return

proc/loadeldarsave()
	if(!fexists("data/rtd/eldarMember.sav"))
		log_admin("OMG Can't find eldarMember.sav!")
	var/savefile/eldarMember = new("data/rtd/eldarMember.sav")
	eldarMember>>eldar
	return

proc/loadrgsave()
	if(!fexists("data/rtd/rgMember.sav"))
		log_admin("OMG Can't find rgMember.sav!")
	var/savefile/rgMember = new("data/rtd/rgMember.sav")
	rgMember>>ravenguard
	return

proc/loadtyranidsave()
	if(!fexists("data/rtd/tyranidMember.sav"))
		log_admin("OMG Can't find tyranidMember.sav!")
	var/savefile/tyranidMember = new("data/rtd/tyranidMember.sav")
	tyranidMember>>tyranid
	return

proc/loadohsave()
	if(!fexists("data/rtd/ohMember.sav"))
		log_admin("OMG Can't find ohMember.sav!")
	var/savefile/ohMember = new("data/rtd/ohMember.sav")
	ohMember>>ordohereticus
	return

proc/loadohssave()
	if(!fexists("data/rtd/ohsMember.sav"))
		log_admin("OMG Can't find ohsMember.sav!")
	var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
	ohsMember>>stormtrooper
	return

proc/loadsobsave()
	if(!fexists("data/rtd/sobMember.sav"))
		log_admin("OMG Can't find sobMember.sav!")
	var/savefile/sobMember = new("data/rtd/sobMember.sav")
	sobMember>>sob
	return

proc/loadorksave()
	if(!fexists("data/rtd/orkMember.sav"))
		log_admin("OMG Can't find orkMember.sav!")
	var/savefile/orkMember = new("data/rtd/orkMember.sav")
	orkMember>>ork
	return

//leaders

/proc/loadumleader()
	if(!fexists("data/rtd/umleader.sav"))
		log_admin("OMG Can't find umleader.sav!")
	var/savefile/umOVERSEER = new("data/rtd/umleader.sav")
	umOVERSEER>>umleader									//file to object, object to list
	return

/proc/loadksonsleader()
	if(!fexists("data/rtd/ksonsleader.sav"))
		log_admin("OMG Can't find ksonsleader.sav!")
	var/savefile/ksonsOVERSEER = new("data/rtd/ksonsleader.sav")
	ksonsOVERSEER>>ksonsleader
	return

/proc/loadpmleader()
	if(!fexists("data/rtd/pmleader.sav"))
		log_admin("OMG Can't find pmMember.sav!")
	var/savefile/pmOVERSEER = new("data/rtd/pmleader.sav")
	pmOVERSEER>>pmleader
	return

proc/loadsmleader()
	if(!fexists("data/rtd/smleader.sav"))
		log_admin("OMG Can't find smleader.sav!")
	var/savefile/smOVERSEER = new("data/rtd/smleader.sav")
	smOVERSEER>>smleader
	return

proc/loadtauleader()
	if(!fexists("data/rtd/tauleader.sav"))
		log_admin("OMG Can't find tauleader.sav!")
	var/savefile/tauOVERSEER = new("data/rtd/tauleader.sav")
	tauOVERSEER>>tauleader
	return

proc/loadeldarleader()
	if(!fexists("data/rtd/eldarleader.sav"))
		log_admin("OMG Can't find eldarleader.sav!")
	var/savefile/eldarOVERSEER = new("data/rtd/eldarleader.sav")
	eldarOVERSEER>>eldarleader
	return

proc/loadrgleader()
	if(!fexists("data/rtd/rgleader.sav"))
		log_admin("OMG Can't find rgleader.sav!")
	var/savefile/rgOVERSEER = new("data/rtd/rgleader.sav")
	rgOVERSEER>>ravenleader
	return

proc/loadtyranidleader()
	if(!fexists("data/rtd/tyranidleader.sav"))
		log_admin("OMG Can't find tyranidleader.sav!")
	var/savefile/tyranidOVERSEER = new("data/rtd/tyranidleader.sav")
	tyranidOVERSEER>>tyranidleader
	return

proc/loadohleader()
	if(!fexists("data/rtd/ohleader.sav"))
		log_admin("OMG Can't find ohleader.sav!")
	var/savefile/ohOVERSEER = new("data/rtd/ohleader.sav")
	ohOVERSEER>>ohleader
	return

proc/loadohsleader()
	if(!fexists("data/rtd/ohsleader.sav"))
		log_admin("OMG Can't find ohsleader.sav!")
	var/savefile/ohOVERSEER = new("data/rtd/ohsleader.sav")
	ohOVERSEER>>ohsleader
	return

proc/loadsobleader()
	if(!fexists("data/rtd/sobleader.sav"))
		log_admin("OMG Can't find sobleader.sav!")
	var/savefile/sobOVERSEER = new("data/rtd/sobleader.sav")
	sobOVERSEER>>sobleader
	return

proc/loadorkleader()
	if(!fexists("data/rtd/orkleader.sav"))
		log_admin("OMG Can't find orkleader.sav!")
	var/savefile/orkOVERSEER = new("data/rtd/orkleader.sav")
	orkOVERSEER>>orkleader
	return

//And that is it for the pre-round list load. Now lets take a look at the panels

/*
Ultramarines
*/

/mob/living/carbon/human/whitelisted/um/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/whitelisted/um/leader/proc/edit_faction_membership()			//my editor template
	var/editchoice																		//start the var
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")	//surprise! var is input
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				umlist.Add(lowertext(newname))										//umlist is a constant so lets toss that name in there
				var/savefile/umMember = new("data/rtd/umMember.sav")				//lets drag this variable back from the dead
				umMember<<umlist										//overwrite the save file with the list
				return
			else
				alert("Something went wrong. Tell the coders umleader/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				umlist.Remove(lowertext(removal))
				var/savefile/umMember = new("data/rtd/umMember.sav")
				umMember<<umlist
				return
		if("List members")
			umlistDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/um/leader/proc/umlistDisplay()
	var/name = "Current Ultramarines"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in umlist)
		msg += "\t[C]"

		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Thousand Sons
*/

/mob/living/carbon/human/whitelisted/ksons/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/whitelisted/ksons/leader/proc/edit_faction_membership()			//my editor template
	var/editchoice																		//start the var
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")	//surprise! var is input
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				ksons.Add(lowertext(newname))										//umlist is a constant so lets toss that name in there
				var/savefile/ksonsMember = new("data/rtd/ksonsMember.sav")				//lets drag this variable back from the dead
				ksonsMember<<ksons										//overwrite the save file with the list
				return
			else
				alert("Something went wrong. Tell the coders umleader/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				ksons.Remove(lowertext(removal))
				var/savefile/ksonsMember = new("data/rtd/ksonsMember.sav")
				ksonsMember<<ksons
				return
		if("List members")
			ksonsDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/ksons/leader/proc/ksonsDisplay()
	var/name = "Current Membership"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in ksons)
		msg += "\t[C]"

		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")


/*
Salamander Marines
*/


/mob/living/carbon/human/whitelisted/sm/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()


/mob/living/carbon/human/whitelisted/sm/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				salamanders.Add(lowertext(newname))
				var/savefile/smMember = new("data/rtd/smMember.sav")
				smMember<<salamanders
				return
			else
				alert("Something went wrong. Tell the coders smleader/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				salamanders.Remove(lowertext(removal))
				var/savefile/smMember = new("data/rtd/smMember.sav")
				smMember<<salamanders
				return
		if("List members")
			salamandersDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/sm/leader/proc/salamandersDisplay()
	var/name = "Current Salamanders"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in salamanders)
		msg += "\t[C]"

		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Imperial Guard


/mob/living/carbon/human/kriegofficer/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()


/mob/living/carbon/human/kriegofficer/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				kriegofficers.Add(lowertext(newname))
				var/savefile/krMember = new("data/rtd/krMember.sav")
				krMember<<kriegofficers
				return
			else
				alert("Something went wrong. Tell the coders kriegofficer/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				kriegofficers.Remove(lowertext(removal))
				var/savefile/krMember = new("data/rtd/krMember.sav")
				krMember<<kriegofficers
				return
		if("List members")
			kriegofficersDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/kriegofficer/proc/kriegofficersDisplay()
	var/name = "Current Krieg Officers"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in kriegofficers)
		msg += "\t[C]"

		msg += "<BR>"
		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
*/

/*
Tau
*/

/mob/living/carbon/human/tau/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/tau/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				tau.Add(lowertext(newname))
				var/savefile/tauMember = new("data/rtd/tauMember.sav")
				tauMember<<tau
				return
			else
				alert("Something went wrong. Tell the coders tau/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				tau.Remove(lowertext(removal))
				var/savefile/tauMember = new("data/rtd/tauMember.sav")
				tauMember<<tau
				return
		if("List members")
			tauDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/tau/leader/proc/tauDisplay()
	var/name = "Current Tau"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in tau)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Eldar
*/

/mob/living/carbon/human/whitelisted/eldar/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/whitelisted/eldar/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				eldar.Add(lowertext(newname))
				var/savefile/eldarMember = new("data/rtd/eldarMember.sav")
				eldarMember<<eldar
				return
			else
				alert("Something went wrong. Tell the coders eldar/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				eldar.Remove(lowertext(removal))
				var/savefile/eldarMember = new("data/rtd/eldarMember.sav")
				eldarMember<<eldar
				return
		if("List members")
			eldarDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/eldar/leader/proc/eldarDisplay()
	var/name = "Current Eldar"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in eldar)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Raven Guard
*/

/mob/living/carbon/human/whitelisted/ravenguardhead/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/whitelisted/ravenguardhead/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				ravenguard.Add(lowertext(newname))
				var/savefile/rgMember = new("data/rtd/rgMember.sav")
				rgMember<<ravenguard
				return
			else
				alert("Something went wrong. Tell the coders ravenguard/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				ravenguard.Remove(lowertext(removal))
				var/savefile/rgMember = new("data/rtd/rgMember.sav")
				rgMember<<ravenguard
				return
		if("List members")
			ravenguardDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/ravenguardhead/proc/ravenguardDisplay()
	var/name = "Current RavenGuard"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in ravenguard)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Tyranid
*/

/mob/living/carbon/alien/humanoid/tyranid/lictor/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/alien/humanoid/tyranid/lictor/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				tyranid.Add(lowertext(newname))
				var/savefile/tyranidMember = new("data/rtd/tyranidMember.sav")
				tyranidMember<<tyranid
				return
			else
				alert("Something went wrong. Tell the coders tyranid/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				tyranid.Remove(lowertext(removal))
				var/savefile/tyranidMember = new("data/rtd/tyranidMember.sav")
				tyranidMember<<tyranid
				return
		if("List members")
			tyranidDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/alien/humanoid/tyranid/lictor/leader/proc/tyranidDisplay()
	var/name = "Current Tyranids"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in tyranid)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")


/*
Ordo Hereticus
*/
/mob/living/carbon/human/OHstormtrooper/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/OHinq/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/OHstormtrooper/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Stormtrooper", "Remove a Stormtrooper", "List Stormtroopers", "Cancel")
	switch(editchoice)
		if("Add a Stormtrooper")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				stormtrooper.Add(lowertext(newname))
				var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
				ohsMember<<stormtrooper
				return
			else
				alert("Something went wrong. Tell the coders ohing/proc/edit_faction_membership")
				return
		if("Remove a Stormtrooper")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				stormtrooper.Remove(lowertext(removal))
				var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
				ohsMember<<stormtrooper
				return
		if("List Stormtroopers")
			ohsDisplay()
		else
			alert("Something went wrong. Tell the coders ohing/proc/edit_faction_membership")
			return

/mob/living/carbon/human/OHstormtrooper/leader/proc/ohsDisplay()
	var/name = "Current Stormtroopers"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in stormtrooper)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")



/mob/living/carbon/human/OHinq/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Add a Stormtrooper", "Remove a Stormtrooper", "List Stormtroopers", "Add a Stormtrooper Leader", "Remove a Stormtrooper Leader", "List Stormtroopers Leader(s)", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				ordohereticus.Add(lowertext(newname))
				var/savefile/ohMember = new("data/rtd/ohMember.sav")
				ohMember<<ordohereticus
				return
			else
				alert("Something went wrong. Tell the coders ohing/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				ordohereticus.Remove(lowertext(removal))
				var/savefile/ohMember = new("data/rtd/ohMember.sav")
				ohMember<<ordohereticus
				return
		if("List members")
			ordohereticusDisplay()

		if("Add a Stormtrooper")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				stormtrooper.Add(lowertext(newname))
				var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
				ohsMember<<stormtrooper
				return
			else
				alert("Something went wrong. Tell the coders ohing/proc/edit_faction_membership")
				return
		if("Remove a Stormtrooper")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				stormtrooper.Remove(lowertext(removal))
				var/savefile/ohsMember = new("data/rtd/ohsMember.sav")
				ohsMember<<stormtrooper
				return
		if("List Stormtroopers")
			ohsDisplay()

		if("Add a Stormtrooper Leader")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				stormtrooper.Add(lowertext(newname))
				var/savefile/ohsleader = new("data/rtd/ohsleader.sav")
				ohsleader<<stormtrooper
				return
			else
				alert("Something went wrong. Tell the coders ohing/proc/edit_faction_membership")
				return
		if("Remove a Stormtrooper Leader")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				stormtrooper.Remove(lowertext(removal))
				var/savefile/ohsleader = new("data/rtd/ohsleader.sav")
				ohsleader<<stormtrooper
				return
		if("List Stormtroopers Leader(s)")
			ohslDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/OHinq/leader/proc/ordohereticusDisplay()
	var/name = "Current Inquisitors"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in ordohereticus)
		msg += "\t[C]"

		msg += "<BR>"
		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/mob/living/carbon/human/OHinq/leader/proc/ohsDisplay()
	var/name = "Current Stormtroopers"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in stormtrooper)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/mob/living/carbon/human/OHinq/leader/proc/ohslDisplay()
	var/name = "Current Stormtrooper Leader(s)"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in ohsleader)
		msg += "\t[C]"
		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
SOB
*/


/mob/living/carbon/human/sob/cannoness/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/sob/cannoness/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				sob.Add(lowertext(newname))
				var/savefile/sobMember = new("data/rtd/sobMember.sav")
				sobMember<<sob
				return
			else
				alert("Something went wrong. Tell the coders cannoness/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				sob.Remove(lowertext(removal))
				var/savefile/sobMember = new("data/rtd/sobMember.sav")
				sobMember<<sob
				return
		if("List members")
			sobDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/sob/cannoness/proc/sobDisplay()
	var/name = "Current Sisters of Battle"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in sob)
		msg += "\t[C]"

		msg += "<BR>"
		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Orks
*/

/mob/living/carbon/human/ork/warboss/leader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/ork/warboss/leader/proc/edit_faction_membership()
	var/editchoice
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				ork.Add(lowertext(newname))
				var/savefile/orkMember = new("data/rtd/orkMember.sav")
				orkMember<<ork
				return
			else
				alert("Something went wrong. Tell the coders ork/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				ork.Remove(lowertext(removal))
				var/savefile/orkMember = new("data/rtd/orkMember.sav")
				orkMember<<ork
				return
		if("List members")
			orkDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/ork/warboss/leader/proc/orkDisplay()
	var/name = "Current Orks"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in ork)
		msg += "\t[C]"

		msg += "<BR>"
		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")

/*
Plague Marines
*/

/mob/living/carbon/human/whitelisted/pmleader/verb/edit_faction()
	set category = "OOC"
	set name = "Faction Panel"
	set desc = "Edit Faction Membership"
	edit_faction_membership()

/mob/living/carbon/human/whitelisted/pmleader/proc/edit_faction_membership()			//my editor template
	var/editchoice																		//start the var
	editchoice = input("Select an action:","Faction Management") as null|anything in list("Add a Member","Remove a Member", "List members", "Cancel")	//surprise! var is input
	switch(editchoice)
		if("Add a Member")
			var/newname = strip_html_simple(input("Enter the ckey of the new member:","Add a Member","") as text, 30) //No ckeys will be >30 chars... Right?
			if(newname && trim(newname))
				pmlist.Add(lowertext(newname))										//umlist is a constant so lets toss that name in there
				var/savefile/pmMember = new("data/rtd/pmMember.sav")				//lets drag this variable back from the dead
				pmMember<<pmlist										//overwrite the save file with the list
				return
			else
				alert("Something went wrong. Tell the coders umleader/proc/edit_faction_membership")
				return
		if("Remove a Member")
			var/removal = strip_html_simple(input("Enter the ckey of the member to remove:","Remove a Member","") as text, 30)
			if(removal && trim(removal))
				pmlist.Remove(lowertext(removal))
				var/savefile/pmMember = new("data/rtd/pmMember.sav")
				pmMember<<pmlist
				return
		if("List members")
			pmlistDisplay()

		if("Cancel") return

		else
			return

/mob/living/carbon/human/whitelisted/pmleader/proc/pmlistDisplay()
	var/name = "Current Plague Marines"

	var/msg = "<b>Current Members: (MAKE SURE THESE CKEYS ARE EXACT!):</b>\n"

	for(var/C in pmlist)
		msg += "\t[C]"

		msg += "<BR>"

		msg += "\n"

	usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[msg]</BODY></HTML>", "window=[name]")
