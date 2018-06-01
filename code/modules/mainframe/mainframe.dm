/*
This is going to be a second scripting implementation, some simple networking protocols for stuff to interact.
Shouldn't be too hard to make, given that wireless signals are already completely fleshed out in the code.
And this system will create a lot of possibilities.

This network system will let various machines interact. The things that can send/recieve info are:
		The telecomms traffic console
    Automata
    Cameras
    Airlocks
    Security Records Console
    Medical Records Console
    Crew Monitoring Console
    Maybe alarm consoles, too
    Data probe mechadendrite- lets a person interface with machines in close range as they might over the network. Might also give random flavor text about "machine spirits"

    Apart from these, it might actually be fairly easy to give some generic network access to computers/machines, where it allows someone to open up a session at a distance as if they had done so with telekinesis.
    No NTSL script would be required for that. Or really for any of the above. The only three things that will have NTSL scripting in them is the telecomms engine, automata, and the mainframe core itself.

This may seem a bit complicated, but if it is done right it will work fairly simply and be an excellent addition to both the outpost in general and the options for hereteks.

Network System
All radio signals are sent to mainframe, which relays it to destination. Mainframe can provide an index of linked devices, but otherwise just relays stuff.
Network protocol is a radio signal which can have various commands. This could include
	pings
	requests for data
	sending of data
	opening/closing/locking an airlock
	uploading code to the device

Basically just radio-based proc calling. Only difficult bit is authentication. Which I can probably just make a set of randomized keys sent in the radio transmission to identify permission levels.

-Drake
*/

/obj/machinery/computer/mainframe
	name = "Network Core"
	desc = "A networking mainframe."
	icon_state = "ob1"
	icon = 'icons/obj/machines/Orbitalcomand.dmi'
	density = 1
	anchored = 1
	var/list/linked_machines = list()

/obj/structure/mainframe_sides
	name = "Network Core"
	icon = 'icons/obj/machines/artillery.dmi'
	anchored = 1
	density = 0