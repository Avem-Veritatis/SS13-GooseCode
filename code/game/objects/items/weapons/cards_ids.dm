/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the teleporter
 */
/obj/item/weapon/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/card.dmi'
	w_class = 1.0

	var/list/files = list(  )

/obj/item/weapon/card/data
	name = "data disk"
	desc = "A disk of data."
	icon_state = "data"
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"

/obj/item/weapon/card/data/verb/label(t as text)
	set name = "Label Disk"
	set category = "Object"
	set src in usr

	if (t)
		src.name = text("data disk- '[]'", t)
	else
		src.name = "data disk"
	src.add_fingerprint(usr)
	return

/obj/item/weapon/card/data/clown
	name = "\proper the coordinates to clown planet"
	icon_state = "data"
	item_state = "card-id"
	layer = 3
	level = 2
	desc = "This card contains coordinates to the fabled Clown Planet. Handle with care."
	function = "teleporter"
	data = "Clown Land"

/*
 * ID CARDS
 */
/obj/item/weapon/card/emag
	name = "cryptographic sequencer"
	desc = "It's a card with a magnetic strip attached to some circuitry."
	icon_state = "emag"
	item_state = "card-id"
	origin_tech = "magnets=2;syndicate=2"

/obj/item/weapon/card/id
	name = "identification card"
	desc = "A card used to provide ID and determine access across the station."
	icon_state = "id"
	item_state = "card-id"
	slot_flags = SLOT_ID
	var/mining_points = 0		//For redeeming at mining equipment lockers
	var/list/access = list()
	var/registered_name = null	//The name registered_name on the card
	var/assignment = null

/obj/item/weapon/card/id/attack_self(mob/user)
	user.visible_message("[user] shows \his [src]: \icon[src] [name]: assignment: [assignment]")

/obj/item/weapon/card/id/examine()
	..()
	usr << "The current assignment on the card is [assignment]."
	if(mining_points)
		usr << "There's [mining_points] mining equipment redemption points loaded onto this card."

/obj/item/weapon/card/id/GetAccess()
	return access

/obj/item/weapon/card/id/GetID()
	return src

/*
Usage:
update_label()
	Sets the id name to whatever registered_name and assignment is

update_label("John Doe", "Clowny")
	Properly formats the name and occupation and sets the id name to the arguments
*/
/obj/item/weapon/card/id/proc/update_label(var/newname, var/newjob)
	if(newname || newjob)
		name = text("[][]",
			(!newname)	? "identification card"	: "[newname]'s ID Card",
			(!newjob)		? ""										: " ([newjob])"
		)
		return

	name = text("[][]",
		(!registered_name)	? "identification card"	: "[registered_name]'s ID Card",
		(!assignment)				? ""										: " ([assignment])"
	)

/obj/item/weapon/card/id/verb/read()
	set name = "Read ID Card"
	set category = "Object"
	set src in usr

/obj/item/weapon/card/id/silver
	desc = "A silver card which shows honour and dedication."
	icon_state = "silver"
	item_state = "silver_id"

/obj/item/weapon/card/id/silver/emergency
	name = "Emergency Access Pass"
	desc = "In the case of a crisis, this can be activated to grant full access for two minutes. Activates when somebody touches it."
	icon_state = "silver"
	item_state = "silver_id"
	registered_name = "Imperial Citizen"
	assignment = "Emergency Access Grant"
	New()
		var/datum/job/captain/J = new/datum/job/captain
		access = J.get_access()
		..()

/obj/item/weapon/card/id/silver/emergency/equipped(mob/user as mob)
	src.loc.visible_message("\red [src] activates it's temporary access grant as [user] touches it!")
	src.registered_name = user.real_name
	spawn(1200)
		if(src && src.loc)
			src.loc.visible_message("\red [src]'s temporary access is used up! [src] disintegrates!")
			qdel(src)
	..()

/obj/item/weapon/card/id/inquisitor
	name = "Inquisitorial Seal"
	desc = "An inquisitorial seal. Grants virtually unlimitted authority to a full inquisitor of the Imperium."
	icon_state = "inquisitor"
	item_state = "silver_id"

/obj/item/weapon/card/id/inquisitor/New()
	..()
	icon_state = pick("inquisitor", "inquisitor", "inquisitor2", "inquisitor3")

/obj/item/weapon/card/id/gold
	desc = "A golden card which shows power and might."
	icon_state = "gold"
	item_state = "gold_id"

/obj/item/weapon/card/id/syndicate
	name = "agent card"
	access = list(access_maint_tunnels, access_syndicate)
	origin_tech = "syndicate=3"

/obj/item/weapon/card/id/syndicate/afterattack(obj/item/I, mob/user, proximity)
	if(!proximity)	return
	if(istype(I, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/idcard = I
		access |= idcard.access
		if(isliving(user) && user.mind)
			if(user.mind.special_role)
				user << "<span class='notice'>The card's microscanners activate as you pass it over the ID, copying its access.</span>"


/obj/item/weapon/card/id/syndicate/attack_self(mob/user)
	if(!src.registered_name)
		//Stop giving the players unsanitized unputs! You are giving ways for players to intentionally crash clients! -Nodrak
		var t = copytext(sanitize(input(user, "What name would you like to put on this card?", "Agent card name", ishuman(user) ? user.real_name : user.name)),1,26)
		if(!t || t == "Unknown" || t == "floor" || t == "wall" || t == "r-wall") //Same as mob/new_player/prefrences.dm
			alert("Invalid name.")
			return
		registered_name = t

		var u = copytext(sanitize(input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than maintenance.", "Agent card job assignment", "Assistant")),1,MAX_MESSAGE_LEN)
		if(!u)
			alert("Invalid assignment.")
			registered_name = ""
			return
		src.assignment = u
		update_label()
		user << "\blue You successfully forge the ID card."
	else
		..()

/obj/item/weapon/card/id/syndicate_command
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Overlord"
	access = list(access_syndicate)

/obj/item/weapon/card/id/captains_spare
	name = "captain's spare ID"
	desc = "The spare ID of the High Lord himself."
	icon_state = "gold"
	item_state = "gold_id"
	registered_name = "Captain"
	assignment = "Captain"
	New()
		var/datum/job/captain/J = new/datum/job/captain
		access = J.get_access()
		..()

/obj/item/weapon/card/id/generals_spare
	name = "Millitant Militia ID"
	desc = "The spare ID of the High Lord himself."
	icon_state = "spareID"
	item_state = "gold_id"
	registered_name = "General"
	assignment = "Imperial Command"
	New()
		var/datum/job/captain/J = new/datum/job/captain
		access = J.get_access()
		..()

/obj/item/weapon/card/id/ordohereticus
	name = "Inquisitorial Seal"
	desc = "An inquisitorial seal. Grants virtually unlimited authority to a full inquisitor of the Imperium."
	icon_state = "inquisitor"
	item_state = "gold_id"
	registered_name = "Inquisition"
	assignment = "Ordo Hereticus"
	New()
		var/datum/job/captain/J = new/datum/job/captain
		access = J.get_access()
		..()
		icon_state = pick("inquisitor", "inquisitor", "inquisitor2", "inquisitor3")
		name = "Inquisitorial Seal"


/obj/item/weapon/card/id/ultramarine
	name = "UltraMarine ID"
	desc = "An Ultra ID, for UltraMarines."
	icon_state = "umcard"
	registered_name = "UltraMarine"
	assignment = "UltraMarine"
	access = list(access_maint_tunnels, access_syndicate, access_security, access_sec_doors, access_brig, access_armory, access_forensics_lockers, access_court,
	            access_medical, access_genetics, access_morgue, access_rd,
	            access_tox, access_tox_storage, access_chemistry, access_engine, access_engine_equip, access_maint_tunnels,
	            access_external_airlocks, access_change_ids, access_ai_upload,
	            access_teleporter, access_eva, access_heads, access_captain, access_all_personal_lockers,
	            access_tech_storage, access_chapel_office, access_atmospherics, access_kitchen,
	            access_bar, access_janitor, access_crematorium, access_robotics, access_cargo, access_construction,
	            access_hydroponics, access_library, access_lawyer, access_virology, access_cmo, access_qm, access_surgery,
	            access_theatre, access_research, access_mining, access_mailsorting,
	            access_heads_vault, access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce,
	            access_keycard_auth, access_tcomsat, access_gateway, access_mineral_storeroom,access_cent_general, access_cent_specops, access_cent_living, access_cent_storage)

/obj/item/weapon/card/id/salamandermarines
	name = "Salamander Marine ID"
	desc = "A Salamander Marine ID Card."
	icon_state = "smcard"
	registered_name = "Salamander Marine"
	assignment = "Salamander Marine"
	access = list(access_maint_tunnels, access_syndicate, access_security, access_sec_doors, access_brig, access_armory, access_forensics_lockers, access_court,
	            access_medical, access_genetics, access_morgue, access_rd,
	            access_tox, access_tox_storage, access_chemistry, access_engine, access_engine_equip, access_maint_tunnels,
	            access_external_airlocks, access_change_ids, access_ai_upload,
	            access_teleporter, access_eva, access_heads, access_captain, access_all_personal_lockers,
	            access_tech_storage, access_chapel_office, access_atmospherics, access_kitchen,
	            access_bar, access_janitor, access_crematorium, access_robotics, access_cargo, access_construction,
	            access_hydroponics, access_library, access_lawyer, access_virology, access_cmo, access_qm, access_surgery,
	            access_theatre, access_research, access_mining, access_mailsorting,
	            access_heads_vault, access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce,
	            access_keycard_auth, access_tcomsat, access_gateway, access_mineral_storeroom,access_cent_general, access_cent_specops, access_cent_living, access_cent_storage)


/obj/item/weapon/card/id/centcom
	name = "\improper Centcom ID"
	desc = "An ID straight from Cent. Com."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "General"
	New()
		access = get_all_centcom_access()
		..()

/obj/item/weapon/card/id/dogtag
	name = "Imperial Guard Dogtag"
	desc = "A set of dogtags with the Imperial symbol on it."
	icon_state = "dogtag"
	assignment = "Imperial Guard"

/obj/item/weapon/card/id/prisoner
	name = "prisoner ID card"
	desc = "You are a number, you are not a free man."
	icon_state = "orange"
	item_state = "orange-id"
	assignment = "Prisoner"
	registered_name = "Scum"
	var/goal = 0	//How far from freedom?
	var/points = 0

/obj/item/weapon/card/id/prisoner/attack_self(mob/user)
	usr << "You have accumulated [points] out of the [goal] points you need for freedom."

/obj/item/weapon/card/id/prisoner/one
	name = "prisoner card #13-001"
	registered_name = "Prisoner #13-001"

/obj/item/weapon/card/id/prisoner/two
	name = "prisoner card #13-002"
	registered_name = "Prisoner #13-002"

/obj/item/weapon/card/id/prisoner/three
	name = "prisoner card #13-003"
	registered_name = "Prisoner #13-003"

/obj/item/weapon/card/id/prisoner/four
	name = "prisoner card #13-004"
	registered_name = "Prisoner #13-004"

/obj/item/weapon/card/id/prisoner/five
	name = "prisoner card #13-005"
	registered_name = "Prisoner #13-005"

/obj/item/weapon/card/id/prisoner/six
	name = "prisoner card #13-006"
	registered_name = "Prisoner #13-006"

/obj/item/weapon/card/id/prisoner/seven
	name = "prisoner card #13-007"
	registered_name = "Prisoner #13-007"

/obj/item/weapon/card/id/assistant
	name = "assistant employment card"
	desc = "Imprinted with the Assistant Lifelong Enslavement Contract."
	var/registered = FALSE

/obj/item/weapon/card/id/assistant/attackby(obj/item/I, mob/user)
	if(!registered)
		var/obj/item/weapon/card/id/idcard = I.GetID()
		if(idcard)
			desc = "Assistant to [idcard.registered_name]."

			var/datum/job/job = null
			for(var/datum/job/J in job_master.occupations)
				if(J.title == idcard.assignment)
					job = J
					break
			if(job &&!istype(idcard,/obj/item/weapon/card/id/syndicate))
				access |= job.assistant_access
			registered = TRUE
			user << "<span class='notice'>You register the assistant as a part of your department.</span>"

/obj/item/weapon/card/id/assistant/attack_self(mob/user)	//copypasta but not worth proc imo
	user.visible_message("[user] shows \his [src]: \icon[src] [name]: assignment: [registered ? desc : assignment]")

/obj/item/weapon/card/id/assistant/proc/ResetRegistration()
	src.registered = FALSE
	src.desc = "Imprinted with the Assistant Lifelong Enslavement Contract."
	var/datum/job/assdatum = job_master.GetJob("Assistant")
	src.access = assdatum.get_access()

/obj/item/weapon/card/id/tau			//Potential tau station with individual access, I think yes.
	name = "Tau ID"
	desc = "A Tau ID emblem, for tauhz? this one you no see, this error.."
	icon_state = "fingerprint0"
	registered_name = "gr34t0r g00d"
	assignment = "Code breaker"

/obj/item/weapon/card/id/tau/firecaste
	name = "Fire caste ID"
	desc = "A Tau ID emblem, for a Tau Fire caste member"
	icon_state = "shas"
	assignment = "Fire Caste"
	access = list(access_maint_tunnels)

/obj/item/weapon/card/id/tau/watercaste
	name = "Water caste ID"
	desc = "A Tau ID emblem, for a Tau Water caste memeber"
	icon_state = "por"
	assignment = "Water Caste"
	access = list(access_maint_tunnels)
