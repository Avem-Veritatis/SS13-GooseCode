/obj/effect/landmark
	name = "landmark"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	anchored = 1.0
	unacidable = 1

/obj/effect/landmark/New()

	..()
	tag = text("landmark*[]", name)
	invisibility = 101
	landmarks_list += src

	switch(name)			//some of these are probably obsolete
		if("shuttle")
			shuttle_z = z
			qdel(src)
			return
		if("monkey")
			monkeystart += loc
			qdel(src)
			return
		if("start")
			newplayer_start += loc
			qdel(src)
			return
		if("wizard")
			wizardstart += loc
			qdel(src)
			return
		if("celebrity")
			celebritystart += loc
			qdel(src)
			return
		if("JoinLate")
			latejoin += loc
			qdel(src)
			return
		if("prisonwarp")
			prisonwarp += loc
			qdel(src)
			return
		if("Holding Facility")
			holdingfacility += loc
		if("tdome1")
			tdome1	+= loc
		if("tdome2")
			tdome2 += loc
		if("tdomeadmin")
			tdomeadmin	+= loc
		if("tdomeobserve")
			tdomeobserve += loc
		if("prisonsecuritywarp")
			prisonsecuritywarp += loc
			qdel(src)
			return
		if("blobstart")
			blobstart += loc
			qdel(src)
			return

		if("xeno_spawn")
			xeno_spawn += loc
			qdel(src)
			return

	return 1

/obj/effect/landmark/Destroy()
	landmarks_list -= src
	..()

/obj/effect/landmark/start
	name = "start"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/start/New()
	..()
	tag = "start*[name]"
	invisibility = 101

	return 1

//Costume spawner landmarks

/obj/effect/landmark/costume/New() //costume spawner, selects a random subclass and disappears

	var/list/options = typesof(/obj/effect/landmark/costume)
	var/PICK= options[rand(1,options.len)]
	new PICK(src.loc)
	qdel(src)

//SUBCLASSES.  Spawn a bunch of items and disappear likewise
/obj/effect/landmark/costume/chicken/New()
	new /obj/item/clothing/suit/chickensuit(src.loc)
	new /obj/item/clothing/head/chicken(src.loc)
	new /obj/item/weapon/reagent_containers/food/snacks/egg(src.loc)
	qdel(src)

/obj/effect/landmark/costume/gladiator/New()
	new /obj/item/clothing/under/gladiator(src.loc)
	new /obj/item/clothing/head/helmet/gladiator(src.loc)
	qdel(src)

/obj/effect/landmark/costume/madscientist/New()
	new /obj/item/clothing/under/gimmick/rank/captain/suit(src.loc)
	new /obj/item/clothing/head/flatcap(src.loc)
	new /obj/item/clothing/suit/labcoat/mad(src.loc)
	new /obj/item/clothing/glasses/greenglasses(src.loc)
	qdel(src)

/obj/effect/landmark/costume/elpresidente/New()
	new /obj/item/clothing/under/gimmick/rank/captain/suit(src.loc)
	new /obj/item/clothing/head/flatcap(src.loc)
	new /obj/item/clothing/mask/cigarette/cigar/havana(src.loc)
	new /obj/item/clothing/shoes/jackboots(src.loc)
	qdel(src)

/obj/effect/landmark/costume/nyangirl/New()
	var/CHOICE = pick( /obj/item/clothing/under/schoolgirl , /obj/item/clothing/under/blackskirt )
	new CHOICE(src.loc)
	new /obj/item/clothing/head/kitty(src.loc)
	if (prob(50))
		new /obj/item/clothing/glasses/sunglasses/blindfold(src.loc)
	else
		new /obj/item/clothing/mask/muzzle/gag(src.loc)
	qdel(src)

/obj/effect/landmark/costume/maid/New()
	var/CHOICEUNI = pick( /obj/item/clothing/under/maid , /obj/item/clothing/under/janimaid )
	new CHOICEUNI(src.loc)
	var/CHOICEHEAD = pick( /obj/item/clothing/head/maidbow , /obj/item/clothing/head/rabbitears )
	new CHOICEHEAD(src.loc)
	if (prob(50))
		new /obj/item/clothing/glasses/sunglasses/blindfold(src.loc)
	else
		new /obj/item/clothing/mask/muzzle/gag(src.loc)
	qdel(src)

/obj/effect/landmark/costume/butler/New()
	new /obj/item/clothing/tie/waistcoat(src.loc)
	new /obj/item/clothing/under/suit_jacket(src.loc)
	new /obj/item/clothing/head/that(src.loc)
	qdel(src)

/obj/effect/landmark/costume/scratch/New()
	new /obj/item/clothing/gloves/white(src.loc)
	new /obj/item/clothing/shoes/sneakers/white(src.loc)
	new /obj/item/clothing/under/scratch(src.loc)
	if (prob(30))
		new /obj/item/clothing/head/cueball(src.loc)
	qdel(src)

/obj/effect/landmark/costume/highlander/New()
	new /obj/item/clothing/under/kilt(src.loc)
	new /obj/item/clothing/head/beret(src.loc)
	qdel(src)

/obj/effect/landmark/costume/prig/New()
	new /obj/item/clothing/tie/waistcoat(src.loc)
	new /obj/item/clothing/glasses/monocle(src.loc)
	var/CHOICE= pick( /obj/item/clothing/head/bowler, /obj/item/clothing/head/that)
	new CHOICE(src.loc)
	new /obj/item/clothing/shoes/sneakers/black(src.loc)
	new /obj/item/weapon/cane(src.loc)
	new /obj/item/clothing/under/sl_suit(src.loc)
	new /obj/item/clothing/mask/fakemoustache(src.loc)
	qdel(src)

/obj/effect/landmark/costume/plaguedoctor/New()
	new /obj/item/clothing/suit/bio_suit/plaguedoctorsuit(src.loc)
	new /obj/item/clothing/head/plaguedoctorhat(src.loc)
	new /obj/item/clothing/mask/gas/plaguedoctor(src.loc)
	qdel(src)

/obj/effect/landmark/costume/nightowl/New()
	new /obj/item/clothing/under/owl(src.loc)
	new /obj/item/clothing/mask/gas/owl_mask(src.loc)
	qdel(src)

/obj/effect/landmark/costume/waiter/New()
	new /obj/item/clothing/under/waiter(src.loc)
	var/CHOICE= pick( /obj/item/clothing/head/kitty, /obj/item/clothing/head/rabbitears)
	new CHOICE(src.loc)
	new /obj/item/clothing/suit/apron(src.loc)
	qdel(src)

/obj/effect/landmark/costume/pirate/New()
	new /obj/item/clothing/under/pirate(src.loc)
	new /obj/item/clothing/suit/pirate(src.loc)
	var/CHOICE = pick( /obj/item/clothing/head/pirate , /obj/item/clothing/head/bandana )
	new CHOICE(src.loc)
	new /obj/item/clothing/glasses/eyepatch(src.loc)
	qdel(src)

/obj/effect/landmark/costume/commie/New()
	new /obj/item/clothing/under/soviet(src.loc)
	new /obj/item/clothing/head/ushanka(src.loc)
	qdel(src)

/obj/effect/landmark/costume/imperium_monk/New()
	new /obj/item/clothing/suit/imperium_monk(src.loc)
	if (prob(25))
		new /obj/item/clothing/mask/gas/cyborg(src.loc)
	qdel(src)

/obj/effect/landmark/costume/holiday_priest/New()
	new /obj/item/clothing/suit/holidaypriest(src.loc)
	qdel(src)

/obj/effect/landmark/costume/marisawizard/fake/New()
	new /obj/item/clothing/shoes/sandal/marisa(src.loc)
	new /obj/item/clothing/head/wizard/marisa/fake(src.loc)
	new/obj/item/clothing/suit/wizrobe/marisa/fake(src.loc)
	qdel(src)

/obj/effect/landmark/costume/cutewitch/New()
	new /obj/item/clothing/under/sundress(src.loc)
	new /obj/item/clothing/head/witchwig(src.loc)
	new /obj/item/weapon/staff/broom(src.loc)
	qdel(src)

/obj/effect/landmark/costume/fakewizard/New()
	new /obj/item/clothing/shoes/sandal(src.loc)
	new /obj/item/clothing/suit/wizrobe/fake(src.loc)
	new /obj/item/clothing/head/wizard/fake(src.loc)
	new /obj/item/weapon/staff/(src.loc)
	qdel(src)

/obj/effect/landmark/costume/sexyclown/New()
	new /obj/item/clothing/mask/gas/sexyclown(src.loc)
	new /obj/item/clothing/under/sexyclown(src.loc)
	qdel(src)

/obj/effect/landmark/costume/sexymime/New()
	new /obj/item/clothing/mask/gas/sexymime(src.loc)
	new /obj/item/clothing/under/sexymime(src.loc)
	qdel(src)

/obj/effect/landmark/costume/anon/New()
	new /obj/item/clothing/under/suit_jacket/charcoal(src.loc)
	new /obj/item/clothing/suit/lawyer/blackjacket(src.loc)
	new /obj/item/clothing/mask/fawkes(src.loc)
	qdel(src)

/obj/effect/landmark/simulator
	name = "simulation spawn"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1.0

/*
Croneworlds Landmarks
*/
/obj/effect/landmark/cronespawner
	name = "cronespawner"

/obj/effect/landmark/costume/crone

/obj/effect/landmark/costume/crone/New()
	var/landmarkrandom = rand(1, 19)
	switch(landmarkrandom)
		if(1)
			new /mob/living/simple_animal/hostile/void_dweller(src.loc)
			new /obj/item/device/soulstone(src.loc)
		if(2)
			new /mob/living/simple_animal/hostile/shadow(src.loc)
			new /obj/item/weapon/book/manual/norcbook_two(src.loc)
		if(3)
			new /mob/living/simple_animal/hostile/zombie(src.loc)
			new /obj/item/weapon/book/manual/norcbook_four(src.loc)
		if(4)
			new /obj/item/clothing/head/ushanka(src.loc)
			new /obj/item/weapon/book/manual/norcbook_one(src.loc)
		if(5)
			new /obj/item/clothing/under/gladiator(src.loc)
		if(6)
			new /obj/item/clothing/head/helmet/gladiator(src.loc)
			new /obj/item/aluminumtube(src.loc)
		if(7)
			new /mob/living/simple_animal/hostile/retaliate/daemon/lesser/predator(src.loc) //Putting that instead of nightblood. Nightblood currently steals ghosts, and this is more dangerous.
			new /obj/item/weapon/book/manual/norcbook_three(src.loc)
		if(8)
			new /obj/item/weapon/chainsword/chaos_chainsword(src.loc)
		if(9)
			new /obj/item/weapon/choppa(src.loc)
			if(prob(40)) new /obj/item/device/soulstone(src.loc)
		if(10)
			new /obj/item/weapon/circular_saw(src.loc)
			new /obj/item/weapon/storage/toolbox/emergency/cursed(src.loc)
		if(11)
			new /obj/item/weapon/powersword/burning(src.loc)
		if(12)
			new /obj/item/weapon/torture(src.loc)
			new /obj/item/device/mass_spectrometer(src.loc)
		if(13)
			new /obj/machinery/doppler_array(src.loc)
		if(14)
			new /obj/machinery/telepad(src.loc)
			new /obj/item/weapon/bikehorn(src.loc)
		if(15)
			new /obj/structure/closet/decrepit(src.loc)
		if(16)
			new /mob/living/simple_animal/hostile/retaliate/daemon/hulk(src.loc)
		if(17)
			new /mob/living/simple_animal/hostile/russian/ranged(src.loc)
		if(18)
			new /mob/living/simple_animal/hostile/dark_ghost(src.loc)
		if(19)
			new /mob/living/simple_animal/hostile/giant_spider/hunter(src.loc)
			new /obj/item/weapon/powersword/eldar(src.loc)
	qdel(src)

//placeholder ALPHA This is for roundstart juggling
/obj/effect/landmark/placeholderalpha
	name = "alpha"

/obj/effect/landmark/placeholderbeta
	name = "beta"