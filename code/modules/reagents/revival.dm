/obj/item/weapon/reagent_containers/hypospray/revival
	name = "Expinovite Injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to bring back the dead."
	amount_per_transfer_from_this = 100
	icon_state = "lazarus_hypo"
	volume = 100
	//ignore_flags = 1 //That would actually make these a little to strong as a medicine and as a weapon.
	flags = 0
	w_class = 3

/obj/item/weapon/reagent_containers/hypospray/revival/attackby(var/obj/item/A as obj, mob/user as mob)
	if (istype(A, /obj/item/device/revrefull))
		qdel(A)
		..()
		reagents.add_reagent("revival", 20)
		reagents.add_reagent("dexalinp", 10)
		reagents.add_reagent("dexalin", 10)
		reagents.add_reagent("tricordrazine", 10)
		reagents.add_reagent("legecillin", 10)
		reagents.add_reagent("morphine", 5)
		reagents.add_reagent("hallucinations", 5)
		reagents.add_reagent("thujone", 30)

/obj/item/weapon/reagent_containers/glass/bottle/revrefill
	name =	"Empty Expinovite Tube"
	desc =	"Fill this up and put it in an Expinovite Injector"
	icon =	'icons/obj/chemical.dmi'
	icon_state = "refill"
	w_class = 1
	amount_per_transfer_from_this = 0
	possible_transfer_amounts = list(0)
	volume = 100
	flags = OPENCONTAINER

/obj/item/device/revrefull
	name =	"Unspent Expinovite Tube"
	desc =	"Put this in a Used Expinovite Injector"
	icon =	'icons/obj/chemical.dmi'
	icon_state = "refillf"
	w_class = 1


/obj/item/weapon/reagent_containers/hypospray/revival/New()
	name = "Expinovite Injector"
	..()
	reagents.add_reagent("revival", 20)
	reagents.add_reagent("dexalinp", 10)
	reagents.add_reagent("dexalin", 10)
	reagents.add_reagent("tricordrazine", 10)
	reagents.add_reagent("legecillin", 10)
	reagents.add_reagent("morphine", 5)
	reagents.add_reagent("hallucinations", 5)
	reagents.add_reagent("thujone", 30)

/*
/obj/machinery/rack/revival
	name = "Expinovite Injector rack"
	desc = "It can hold four injectors."
	icon = 'icons/obj/machines/gunrack.dmi'
	icon_state = "sr_0"
	anchored = 1
	var/list/contained = list()
	var/capacity = 4
	var/ = /obj/item/weapon/reagent_containers/hypospray/revival

/obj/machinery/injectrack/proc/updateicon()
	icon_state = "sr_[injnumber]"

/obj/machinery/injectrack/examine()
	set src in oview(5)
	..()
	usr << "There's [injnumber ? "a" : "no"] expinovite injectors on the rack."

/obj/machinery/injectrack/attackby(obj/item/weapon/W, mob/user)

	if(istype(W, injtype) && anchored)
		if(injnumber > 3)
			user << "<span class='danger'>This rack seems full.</span>"
			return
		else
			var/area/a = loc.loc // Gets our locations location, like a dream within a dream
			if(!isarea(a))
				return

			user.drop_item()
			qdel(W)
			injnumber += 1
			user.visible_message("<span class='notice'>[user] puts a injector on the rack.</span>", "<span class='notice'>You place the injector on the rack.</span>")
			updateicon()
	else if(istype(W, /obj/item/weapon/wrench))
		anchored = !anchored
		user << "<span class='notice'>You [anchored ? "attach" : "detach"] Expinovite Injector rack [anchored ? "to" : "from"] the ground</span>"
		playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)

/obj/machinery/injectrack/proc/getinjector()
	injnumber -= 1
	updateicon()

/obj/machinery/injectrack/attack_hand(mob/user)
	if(injnumber == 0)
		user << "<span class='notice'>Nope- it is empty.</span>"
		return

	new injtype(user.loc)

	user.visible_message("<span class='notice'>[user] removes an injector from the rack.</span>", "<span class='notice'>You remove an injector from the rack.</span>")

	getinjector()

/obj/machinery/injectrack/attack_tk(mob/user)
	if(injnumber == 0)
		return

	new injtype(get_turf(src))

	user << "<span class='notice'>You telekinetically remove the injector from the rack.</span>"

	getinjector()

/obj/machinery/injectrack/loaded
	injnumber = 4
	icon_state = "sr_4"
*/