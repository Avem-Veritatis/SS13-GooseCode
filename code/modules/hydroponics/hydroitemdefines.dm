// Plant analyzer
/obj/item/device/analyzer/plant_analyzer
	name = "plant analyzer"
	desc = "A scanner used to evaluate a plant's various areas of growth."
	icon = 'icons/obj/device.dmi'
	icon_state = "hydro"
	item_state = "analyzer"
	origin_tech = "magnets=1;biotech=1"

/obj/item/device/analyzer/plant_analyzer/attack_self(mob/user as mob)
	return 0

// *************************************
// Hydroponics Tools
// *************************************

/obj/item/weapon/reagent_containers/spray/weedspray // -- Skie
	desc = "It's a toxic mixture, in spray form, to kill small weeds."
	icon = 'icons/obj/hydroponics.dmi'
	name = "weed-spray"
	icon_state = "weedspray"
	item_state = "spray"
	volume = 100
	flags = OPENCONTAINER
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 10

/obj/item/weapon/reagent_containers/spray/weedspray/New()
	..()
	reagents.add_reagent("weedkiller", 100)

/obj/item/weapon/reagent_containers/spray/weedspray/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is huffing the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return (TOXLOSS)

/obj/item/weapon/reagent_containers/spray/pestspray // -- Skie
	desc = "It's some pest eliminator spray! <I>Do not inhale!</I>"
	icon = 'icons/obj/hydroponics.dmi'
	name = "pest-spray"
	icon_state = "pestspray"
	item_state = "spray"
	volume = 100
	flags = OPENCONTAINER
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 10

/obj/item/weapon/reagent_containers/spray/pestspray/New()
	..()
	reagents.add_reagent("pestkiller", 100)

/obj/item/weapon/reagent_containers/spray/pestspray/suicide_act(mob/user)
	viewers(user) << "<span class='suicide'>[user] is huffing the [src.name]! It looks like \he's trying to commit suicide.</span>"
	return (TOXLOSS)

/obj/item/weapon/minihoe // -- Numbers
	name = "mini hoe"
	desc = "It's used for removing weeds or scratching your back."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "hoe"
	item_state = "hoe"
	flags = CONDUCT
	force = 5.0
	throwforce = 7.0
	w_class = 2.0
	m_amt = 50
	attack_verb = list("slashed", "sliced", "cut", "clawed")
	hitsound = 'sound/weapons/bladeslice.ogg'

// *************************************
// Nutrient defines for hydroponics
// *************************************


/obj/item/weapon/reagent_containers/glass/bottle/nutrient
	name = "bottle of nutrient"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"
	volume = 50
	w_class = 1.0
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/New()
	..()
	src.pixel_x = rand(-5.0, 5)
	src.pixel_y = rand(-5.0, 5)


/obj/item/weapon/reagent_containers/glass/bottle/nutrient/ez
	name = "bottle of E-Z-Nutrient"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/ez/New()
	..()
	reagents.add_reagent("eznutriment", 50)

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/l4z
	name = "bottle of Left 4 Zed"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle18"

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/l4z/New()
	..()
	reagents.add_reagent("left4zednutriment", 50)

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/rh
	name = "bottle of Robust Harvest"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle15"

/obj/item/weapon/reagent_containers/glass/bottle/nutrient/rh/New()
	..()
	reagents.add_reagent("robustharvestnutriment", 50)
