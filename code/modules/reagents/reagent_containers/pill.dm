////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/pill
	name = "pill"
	desc = "A tablet or capsule."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	possible_transfer_amounts = null
	volume = 50

	New()
		..()
		if(!icon_state)
			icon_state = "pill[rand(1,20)]"

	attack_self(mob/user)
		return

	attack(mob/M, mob/user, def_zone)
		if(!canconsume(M, user))
			return 0

		if(M == user)
			M << "<span class='notice'>You swallow [src].</span>"
			M.unEquip(src) //icon update
			if(reagents.total_volume)
				reagents.reaction(M, INGEST)
				spawn(5)
					reagents.trans_to(M, reagents.total_volume)
					qdel(src)
			else
				qdel(src)
			return 1

		else if(istype(M, /mob/living/carbon/human) )
			M.visible_message("<span class='danger'>[user] attempts to force [M] to swallow [src].</span>", \
								"<span class='userdanger'>[user] attempts to force [M] to swallow [src].</span>")

			if(!do_mob(user, M)) return

			user.unEquip(src) //icon update
			M.visible_message("<span class='danger'>[user] forces [M] to swallow [src].</span>", \
								"<span class='userdanger'>[user] forces [M] to swallow [src].</span>")

			add_logs(user, M, "fed", object="[reagentlist(src)]")

			if(reagents.total_volume)
				reagents.reaction(M, INGEST)
				spawn(5)
					reagents.trans_to(M, reagents.total_volume)
					qdel(src)
			else
				qdel(src)

			return 1

		return 0

	afterattack(obj/target, mob/user , proximity)
		if(!proximity) return
		if(target.is_open_container() != 0 && target.reagents)
			if(!target.reagents.total_volume)
				user << "<span class='notice'>[target] is empty. There's nothing to dissolve [src] in.</span>"
				return
			user << "<span class='notice'>You dissolve [src] in [target].</span>"
			for(var/mob/O in viewers(2, user))	//viewers is necessary here because of the small radius
				O << "<span class='warning'>[user] slips something into [target].</span>"
			reagents.trans_to(target, reagents.total_volume)
			spawn(5)
				qdel(src)


////////////////////////////////////////////////////////////////////////////////
/// Pills. END
////////////////////////////////////////////////////////////////////////////////

//Pills
/obj/item/weapon/reagent_containers/pill/antitox
	name = "anti-toxins pill"
	desc = "Neutralizes many common toxins."
	icon_state = "pill17"
	New()
		..()
		reagents.add_reagent("anti_toxin", 50)

/obj/item/weapon/reagent_containers/pill/tox
	name = "toxins pill"
	desc = "Highly toxic."
	icon_state = "pill5"
	New()
		..()
		reagents.add_reagent("toxin", 50)

/obj/item/weapon/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = "Don't swallow this."
	icon_state = "pill5"
	New()
		..()
		reagents.add_reagent("cyanide", 50)

/obj/item/weapon/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill16"
	New()
		..()
		reagents.add_reagent("adminordrazine", 50)

/obj/item/weapon/reagent_containers/pill/stox
	name = "sleeping pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("stoxin", 30)

/obj/item/weapon/reagent_containers/pill/kelotane
	name = "kelotane pill"
	desc = "Used to treat burns."
	icon_state = "pill11"
	New()
		..()
		reagents.add_reagent("kelotane", 30)

/obj/item/weapon/reagent_containers/pill/dermaline
	name = "dermaline pill"
	desc = "Used to treat severe burns."
	icon_state = "pill12"
	New()
		..()
		reagents.add_reagent("dermaline", 30)

/obj/item/weapon/reagent_containers/pill/inaprovaline
	name = "inaprovaline pill"
	desc = "Used to stabilize patients."
	icon_state = "pill20"
	New()
		..()
		reagents.add_reagent("inaprovaline", 30)

/obj/item/weapon/reagent_containers/pill/dexalin
	name = "dexalin pill"
	desc = "Used to treat oxygen deprivation."
	icon_state = "pill16"
	New()
		..()
		reagents.add_reagent("dexalin", 30)

/obj/item/weapon/reagent_containers/pill/bicaridine
	name = "bicaridine pill"
	desc = "Used to treat physical injuries."
	icon_state = "stims"
	New()
		..()
		reagents.add_reagent("bicaridine", 30)

/obj/item/weapon/reagent_containers/pill/stimulant
	name = "stimulant pill"
	desc = "Often taken by overworked employees, athletes, and the inebriated. You'll snap to attention immediately!"
	icon_state = "stims"

/obj/item/weapon/reagent_containers/pill/stimulant/New()
	..()
	reagents.add_reagent("hyperzine", 10)
	reagents.add_reagent("ethylredoxrazine", 10)
	reagents.add_reagent("coffee", 30)


//space marine pill

/obj/item/weapon/reagent_containers/pill/smheal
	name = "stimulant pill"
	desc = "The Apothecaries finest. For the Emperor's finest."
	icon_state = "stims"

/obj/item/weapon/reagent_containers/pill/smheal/New()
	..()
	reagents.add_reagent("tricordrazine", 15)
	reagents.add_reagent("legecillin", 15)


/obj/item/weapon/reagent_containers/pill/eversor //If we eventually actually put eversors in, I figure it will be nice to have this on hand.
	name = "eversor pill"
	desc = "A pill with the eversor cocktail in it."
	icon_state = "stims"
	volume = 100

/obj/item/weapon/reagent_containers/pill/eversor/New()
	..()
	reagents.add_reagent("increase", 10)
	reagents.add_reagent("overdrive", 5)
	reagents.add_reagent("triumvirate", 5)
	reagents.add_reagent("atium", 5)
	reagents.add_reagent("strongtox", 5)
	reagents.add_reagent("coffee", 5)
	reagents.add_reagent("anti_toxin", 5)
	reagents.add_reagent("tricordrazine", 5)
	reagents.add_reagent("legecillin", 5)
	reagents.add_reagent("doctorsdelight", 5)
	reagents.add_reagent("kelotane", 5)
	reagents.add_reagent("dermaline", 5)
	reagents.add_reagent("bicaridine", 5)
	reagents.add_reagent("ethylredoxrazine", 5)
	reagents.add_reagent("polymorphine", 5)
	reagents.add_reagent("SbO", 5)
	reagents.add_reagent("dexalinp", 5)
	reagents.add_reagent("revival", 5)
	reagents.add_reagent("supersteroids", 5)