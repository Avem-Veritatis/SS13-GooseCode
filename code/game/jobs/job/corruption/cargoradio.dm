/*
Here is the idea. The QM's headset is a stronger variant of a normal cargo headset. It is no drop and equipping it will add the user to the mastervox list.
The object has a verb, the verb instantly forces itself on the owner of the object- as verbs do. The verb is csay. Csay is modelled after msay (for moderators)
and effectively takes a message and delivers it to EVERYONE else in the mastervox list. These indeviduals will all have
thier own devices which put them in mastervox list and allow them to do something similiar.
*/

var/list/mastervox = list() 								//and here we have the list.. sitting out in the open by itself, hopefully not instanced at all.

/obj/item/device/radio/headset/headset_cargo/qm				//Normal cargo headset with perks added on top.
	name = "Departmento Munitorum Headset"
	desc = "A headset used by the Administratum, specifically the Departmento Munitorum. This one appears to be a lot more advanced then the others. To access the supply channel, use :u. To access the relay use 'csay'"
	flags = NODROP											//Here is our nodrop. I thought a lot about this one and thought YOLO.
	var/breed = "Unknown"									//Lets set this up for later use.

	verb/cargoradio_say(msg as text)						//Here is the verb itself, walking in with msg as text, much like msay.
		set category = "Master-Vox"
		set name = "csay"
		set hidden = 1										//No idea what hidden does. If it causes issues I'll kill it.
		set src in usr

		msg = sanitize(copytext(msg, 1, MAX_MESSAGE_LEN))	//No idea what sanitize does to the msg, if it causes issues...
		log_admin("CSAY: [key_name(src)] : [msg]")			//And sure, lets log it why not.

		if (!msg)											//No dramatic silence in chat please.
			return

		var/spanclass = "mod_channel"						//Very little experience with spanclass. I want to test this one.
		if(ishuman(usr))
			breed = "Human voice"							//Since all aliens are human variants this won't catch much.
		if(!ishuman(usr))
			breed = "Alien voice"							//I just wanted to do that.

		for(var/client/C in mastervox)
			C << "<span class='[spanclass]'>Imperial Relay Nine: <span class='name'>[breed]</span>: <span class='message'>\\[msg]</span></span>"

/obj/item/device/radio/headset/headset_cargo/qm/equipped(usr)	//Not sure if this is the proper way to equip an item.. but you see what I am going for.
	mastervox.Add(usr)
	..()

/obj/item/device/radio/headset/headset_cargo/qm/dropped(usr)	//And if he some how manages to remove it...
	mastervox.Remove(usr)
	qdel(src)