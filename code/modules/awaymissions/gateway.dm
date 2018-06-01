var/list/obj/machinery/gateway/ELDARGATES = list()

/obj/machinery/gateway
	name = "gateway"
	desc = "A mysterious gateway built by unknown hands, it allows for faster than light travel to far-flung locations."
	icon = 'icons/obj/machines/gateway.dmi'
	icon_state = "off"
	var/id = null			//id of this bump_teleporter.
	var/id_target = null	//id of bump_teleporter which this moves you to.
	density = 1
	anchored = 1
	var/active = 0
	use_power = 0
	var/reconfigurable = 0
	var/oldID


/*
Do the port

/obj/machinery/gateway/centerstation/Bumped(atom/movable/M as mob|obj)
	if(!ready)		return
	if(!active)		return
	if(!awaygate)	return

	if(M.CheckForNukeDisk())
		if(ismob(M))
			var/mob/MOB = M
			MOB << "<span class='warning'>You are forbidden from taking the nuclear authentication disk off station.</span>"
		return

	if(awaygate.calibrated)
		M.loc = get_step(awaygate.loc, SOUTH)
		M.dir = SOUTH
		return
	else
		var/obj/effect/landmark/dest = pick(awaydestinations)
		if(dest)
			M.loc = dest.loc
			M.dir = SOUTH
			use_power(5000)
		return
*/


/obj/machinery/gateway/attackby(var/obj/item/I, var/mob/user)
	oldID = id_target												//backing up the ID target in case a hacktool is used.
	if(active)
		active = 0
	else if(istype(I, /obj/item/device/soulstone))
		active = 1
	else if(istype(I, /obj/item/device/hacktool))
		if(reconfigurable)
			var/obj/item/device/hacktool/P = I
			id_target = P.injectid
			user.visible_message("<span class='notice'>[user] uses the tool to reconfigure it's destination and activate it.</span>", "<span class='notice'>Destination overridden. You have a limited time to enter it..</span>", "<span class='warning>You can't see shit.</span>")
			active = 1
			qdel(I)
		else
			user.visible_message("<span class='notice'>[user] uses the tool but seems perplexed at it's inner workings.</span>", "<span class='notice'>This one is not reconfigurable.</span>", "<span class='warning>You can't see shit.</span>")

	else if(istype(I, /obj/item/device/webwaysummons))
		new /obj/mecha/combat/wraithlord/loaded (loc)
		qdel(I)
	else
		active = 0
	update_icon()
	sleep(200)
	active = 0
	id_target = oldID												//was a hack tool used? We'll never know.
	update_icon()

/obj/machinery/gateway/update_icon()
	if(active)
		icon_state = "on"
		return
	else
		icon_state = "off"

/obj/machinery/gateway/Bumped(atom/user)
	if(active)
		if(!ismob(user))
			//user.loc = src.loc	//Stop at teleporter location
			return

		if(!id_target)
			//user.loc = src.loc	//Stop at teleporter location, there is nowhere to teleport to.
			return

		for(var/obj/machinery/gateway/EG in ELDARGATES)
			if(EG.id == src.id_target)
				usr.loc = EG.loc	//Teleport to location with correct id.
				radarintercept("<font color='silver'> ....a brief buzz of static...</font>")
				return

/obj/machinery/gateway/New()
	..()
	ELDARGATES += src

/obj/machinery/gateway/Destroy()
	ELDARGATES -= src
	..()

/obj/machinery/gateway/ex_act()
	return