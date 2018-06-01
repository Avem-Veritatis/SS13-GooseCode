/obj/item/weapon/reagent_containers/hypospray
	name = "hypospray"
	desc = "The DeForest Medical Corporation hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients."
	icon = 'icons/obj/syringe.dmi'
	item_state = "hypo"
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = null
	flags = OPENCONTAINER
	slot_flags = SLOT_BELT
	var/ignore_flags = 0

/obj/item/weapon/reagent_containers/hypospray/attack_paw(mob/user)
	return attack_hand(user)


///obj/item/weapon/reagent_containers/hypospray/New()	//comment this to make hypos start off empty
//	..()
//	reagents.add_reagent("doctorsdelight", 30)


/obj/item/weapon/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	if(!reagents.total_volume)
		user << "<span class='notice'>[src] is empty.</span>"
		return
	if(!istype(M))
		return

	if(reagents.total_volume && (ignore_flags || M.can_inject(user, 1))) // Ignore flag should be checked first or there will be an error message.
		M << "<span class='warning'>You feel a tiny prick!</span>"
		user << "<span class='notice'>You inject [M] with [src].</span>"

		reagents.reaction(M, INGEST)
		if(M.reagents)
			var/list/injected = list()
			for(var/datum/reagent/R in reagents.reagent_list)
				injected += R.name

			var/trans = reagents.trans_to(M, amount_per_transfer_from_this)
			user << "<span class='notice'>[trans] unit\s injected.  [reagents.total_volume] unit\s remaining in [src].</span>"

			var/contained = english_list(injected)

			add_logs(user, M, "injected", object="[src.name]", addition="([contained])")

/obj/item/weapon/reagent_containers/hypospray/combat
	name = "combat stimulant injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "combat_hypo"
	volume = 60
	ignore_flags = 1 // So they can heal their comrades.

/obj/item/weapon/reagent_containers/hypospray/combat/New()
	..()
	reagents.add_reagent("synaptizine", 30)

/*
Medicus Hypos
*/

/obj/item/weapon/spenthypo //medicus trash
	name = "A spent hypo tube"
	desc = "The by-product of disposable medical eqiupment."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "migniter-d"
	w_class = 1.0

/obj/item/weapon/reagent_containers/hypospray/medicus
	flags = 0 //Can't refill with other stuff to go through armor...

/obj/item/weapon/reagent_containers/hypospray/medicus/dropped()
	new /obj/item/weapon/spenthypo(src.loc)
	qdel(src)

/obj/item/weapon/reagent_containers/hypospray/medicus/heal	//The slow heal injector.
	name = "Adalent injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "adalent"
	volume = 60
	ignore_flags = 1 // So they can heal their comrades.

/obj/item/weapon/reagent_containers/hypospray/medicus/heal/New()
	..()
	reagents.add_reagent("tricordrazine", 15)
	reagents.add_reagent("legecillin", 15)

/obj/item/weapon/reagent_containers/hypospray/medicus/rescue	//The fast rescue injector.
	name = "Naproxen injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "naproxen"
	volume = 60
	ignore_flags = 1 // So they can heal their comrades.

/obj/item/weapon/reagent_containers/hypospray/medicus/rescue/New()
	..()
	reagents.add_reagent("leporazine", 10)
	reagents.add_reagent("dexalinp", 10)
	reagents.add_reagent("bicaridine", 10)

/obj/item/weapon/reagent_containers/hypospray/medicus/comcom	//Combat Stim.
	name = "Bumetanide injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "stimulant"
	volume = 60
	ignore_flags = 1 // So they can heal their comrades.

/obj/item/weapon/reagent_containers/hypospray/medicus/comcom/New()
	..()
	reagents.add_reagent("tricordrazine", 15)
	reagents.add_reagent("speed", 15)

/obj/item/weapon/reagent_containers/hypospray/medicus/pacification	//Patient pacification.
	name = "Ketoconazole injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "pacify"
	volume = 60
	ignore_flags = 1 // So they can "heal" their comrades.

/obj/item/weapon/reagent_containers/hypospray/medicus/pacification/New()
	..()
	reagents.add_reagent("mindbreaker", 25)
	reagents.add_reagent("chloralhydrate", 5)

/obj/item/weapon/reagent_containers/hypospray/medicus/surgery
	name = "Huge Needle"
	desc = "A modified needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon_state = "surgery"
	volume = 60
	ignore_flags = 1

/obj/item/weapon/reagent_containers/hypospray/medicus/surgery/New()
	..()
	reagents.add_reagent("morphine", 28)
	reagents.add_reagent("phenol", 2)
	reagents.add_reagent("tricordrazine", 10)