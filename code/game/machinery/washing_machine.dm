/obj/machinery/washing_machine
	name = "washing machine"
	icon = 'icons/obj/machines/washing_machine.dmi'
	icon_state = "wm_10"
	density = 1
	anchored = 1.0
	var/state = 1
	//1 = empty, open door
	//2 = empty, closed door
	//3 = full, open door
	//4 = full, closed door
	//5 = running
	//6 = blood, open door
	//7 = blood, closed door
	//8 = blood, running
	var/panel = 0
	//0 = closed
	//1 = open
	var/hacked = 1 //Bleh, screw hacking, let's have it hacked by default.
	//0 = not hacked
	//1 = hacked
	var/gibs_ready = 0
	var/obj/crayon

/obj/machinery/washing_machine/verb/start()
	set name = "Start Washing"
	set category = "Object"
	set src in oview(1)

	if(state != 4)
		usr << "<span class='notice'>[src] cannot run in this state.</span>"
		return

	if(locate(/mob, contents))
		state = 8
	else
		state = 5
	update_icon()
	sleep(200)
	for(var/atom/A in contents)
		A.clean_blood()

	//Tanning!
	for(var/obj/item/stack/sheet/hairlesshide/HH in contents)
		var/obj/item/stack/sheet/wetleather/WL = new(src)
		WL.amount = HH.amount
		qdel(HH)


	if(crayon)
		var/wash_color
		if(istype(crayon, /obj/item/toy/crayon))
			var/obj/item/toy/crayon/CR = crayon
			wash_color = CR.colourName
		else if(istype(crayon, /obj/item/weapon/stamp))
			var/obj/item/weapon/stamp/ST = crayon
			wash_color = ST.item_color

		if(wash_color)
			var/new_jumpsuit_icon_state = ""
			var/new_jumpsuit_item_state = ""
			var/new_jumpsuit_name = ""
			var/new_glove_icon_state = ""
			var/new_glove_item_state = ""
			var/new_glove_name = ""
			var/new_shoe_icon_state = ""
			var/new_shoe_name = ""
			var/new_sheet_icon_state = ""
			var/new_sheet_name = ""
			var/new_softcap_icon_state = ""
			var/new_softcap_name = ""
			var/new_desc = "The colors are a bit dodgy."
			for(var/T in typesof(/obj/item/clothing/under/color))
				var/obj/item/clothing/under/color/J = new T
				if(wash_color == J.item_color)
					new_jumpsuit_icon_state = J.icon_state
					new_jumpsuit_item_state = J.item_state
					new_jumpsuit_name = J.name
					qdel(J)
					break
				qdel(J)
			for(var/T in typesof(/obj/item/clothing/gloves))
				var/obj/item/clothing/gloves/G = new T
				if(wash_color == G.item_color)
					new_glove_icon_state = G.icon_state
					new_glove_item_state = G.item_state
					new_glove_name = G.name
					qdel(G)
					break
				qdel(G)
			for(var/T in typesof(/obj/item/clothing/shoes/sneakers))
				var/obj/item/clothing/shoes/sneakers/S = new T
				if(wash_color == S.item_color)
					new_shoe_icon_state = S.icon_state
					new_shoe_name = S.name
					qdel(S)
					break
				qdel(S)
			for(var/T in typesof(/obj/item/weapon/bedsheet))
				var/obj/item/weapon/bedsheet/B = new T
				if(wash_color == B.item_color)
					new_sheet_icon_state = B.icon_state
					new_sheet_name = B.name
					qdel(B)
					break
				qdel(B)
			for(var/T in typesof(/obj/item/clothing/head/soft))
				var/obj/item/clothing/head/soft/H = new T
				if(wash_color == H.item_color)
					new_softcap_icon_state = H.icon_state
					new_softcap_name = H.name
					qdel(H)
					break
				qdel(H)
			if(new_jumpsuit_icon_state && new_jumpsuit_item_state && new_jumpsuit_name)
				for(var/obj/item/clothing/under/color/J in contents)
					if(!J.item_color)
						continue
					J.item_state = new_jumpsuit_item_state
					J.icon_state = new_jumpsuit_icon_state
					J.item_color = wash_color
					J.name = new_jumpsuit_name
					J.desc = new_desc
					J.suit_color = wash_color
			if(new_glove_icon_state && new_glove_item_state && new_glove_name)
				for(var/obj/item/clothing/gloves/G in contents)
					if(!G.item_color)
						continue
					G.item_state = new_glove_item_state
					G.icon_state = new_glove_icon_state
					G.item_color = wash_color
					G.name = new_glove_name
					G.desc = new_desc
			if(new_shoe_icon_state && new_shoe_name)
				for(var/obj/item/clothing/shoes/sneakers/S in contents)
					if(!S.item_color)
						continue
					if(S.chained == 1)
						S.chained = 0
						S.slowdown = SHOES_SLOWDOWN
						new /obj/item/weapon/handcuffs(src)
					S.icon_state = new_shoe_icon_state
					S.item_color = wash_color
					S.name = new_shoe_name
					S.desc = new_desc
			if(new_sheet_icon_state && new_sheet_name)
				for(var/obj/item/weapon/bedsheet/B in contents)
					if(!B.item_color)
						continue
					B.icon_state = new_sheet_icon_state
					B.item_color = wash_color
					B.name = new_sheet_name
					B.desc = new_desc
			if(new_softcap_icon_state && new_softcap_name)
				for(var/obj/item/clothing/head/soft/H in contents)
					if(!H.item_color)
						continue
					H.icon_state = new_softcap_icon_state
					H.item_color = wash_color
					H.name = new_softcap_name
					H.desc = new_desc
		qdel(crayon)
		crayon = null


	if(locate(/mob, contents))
		state = 7
		gibs_ready = 1
	else
		state = 4
	if(usr && ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(H.mind && H.mind.assigned_role == "Mime" && H.purity <= -20)
			for(var/obj/item/clothing/under/mime/harlequin in contents)
				for(var/obj/item/weapon/pen/P in contents)
					if(harlequin)
						qdel(harlequin)
						new /obj/item/clothing/under/harlequin(src)
	update_icon()


/obj/machinery/washing_machine/verb/climb_out()
	set name = "Climb out"
	set category = "Object"
	set src in usr.loc

	sleep(20)
	if(state in list(1, 3, 6))
		usr.loc = loc


/obj/machinery/washing_machine/update_icon()
	icon_state = "wm_[state][panel]"


/obj/machinery/washing_machine/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/toy/crayon) ||istype(I, /obj/item/weapon/stamp))
		if(state in list(1, 3, 6))
			if(!crayon)
				user.drop_item()
				crayon = I
				crayon.loc = src
			else
				..()
		else
			..()
	else if(istype(I, /obj/item/weapon/grab))
		if(state == 1 && hacked)
			var/obj/item/weapon/grab/G = I
			if(ishuman(G.assailant) && iscorgi(G.affecting))
				G.affecting.loc = src
				del(G)
				state = 3
		else
			..()
	else if(istype(I, /obj/item/stack/sheet/hairlesshide)	|| \
		istype(I, /obj/item/clothing/under)		|| \
		istype(I, /obj/item/clothing/mask)		|| \
		istype(I, /obj/item/clothing/head)		|| \
		istype(I, /obj/item/weapon/pen)       || \
		istype(I, /obj/item/clothing/gloves)	|| \
		istype(I, /obj/item/clothing/shoes)		|| \
		istype(I, /obj/item/clothing/suit)		|| \
		istype(I, /obj/item/weapon/bedsheet))

		//YES, it's hardcoded... saves a var/can_be_washed for every single clothing item. //But clothing is an entire type! It inherits variables! Why in the emperor's name did a tg coder think this was the best solution to a problem... -Drake
		if(istype(I, /obj/item/clothing/suit/space))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/suit/syndicatefake))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/suit/cyborg_suit))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/suit/bomb_suit))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/suit/armor))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/mask/gas))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/mask/cigarette))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/head/syndicatefake))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(istype(I, /obj/item/clothing/head/helmet))
			user << "<span class='notice'>[I] does not fit.</span>"
			return
		if(I && I.flags & NODROP) //if "can't drop" item
			user << "<span class='notice'>\The [I] is stuck to your hand, you cannot put it in the washing machine!</span>"
			return

		if(contents.len < 5)
			if(state in list(1, 3))
				user.drop_item()
				I.loc = src
				state = 3
			else
				user << "<span class='notice'>You can't put the item in right now.</span>"
		else
			user << "<span class='notice'>[src] is full.</span>"
	else
		..()
	update_icon()


/obj/machinery/washing_machine/attack_hand(mob/user)
	switch(state)
		if(1)
			state = 2
		if(2)
			state = 1
			for(var/atom/movable/O in contents)
				O.loc = loc
		if(3)
			state = 4
		if(4)
			state = 3
			for(var/atom/movable/O in contents)
				O.loc = loc
			crayon = null
			state = 1
		if(5)
			user << "<span class='notice'>[src] is busy.</span>"
		if(6)
			state = 7
		if(7)
			if(gibs_ready)
				gibs_ready = 0
				if(locate(/mob, contents))
					var/mob/M = locate(/mob, contents)
					M.gib()
					new /obj/item/clothing/head/ianpelt(loc)
			for(var/atom/movable/O in contents)
				O.loc = loc
			crayon = null
			state = 1

	update_icon()