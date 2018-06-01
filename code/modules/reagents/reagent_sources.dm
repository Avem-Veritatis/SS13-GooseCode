/*
Contains contraband bottles of illicit chems, items containing rare ingredients, et cetera. Note that lho cigs and some basic cig code modification is seperate.
This is so that some of the chems in game can be a bit more difficult to acquire.
*/

/obj/item/weapon/reagent_containers/glass/bottle/nanites
	name = "Nanalent Bottle"
	desc = "A small bottle. Contains drugs."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle7"
	New()
		..()
		reagents.add_reagent("nanites", 30)

/obj/item/weapon/reagent_containers/glass/bottle/stimulant
	name = "Laserbrain Dust"
	desc = "A small packet. Contains drugs."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "coke"
	New()
		..()
		reagents.add_reagent("stimulant", 30)

/obj/item/weapon/reagent_containers/glass/bottle/morphine
	name = "Kalma Bottle"
	desc = "A small bottle. Contains kalma, a rather useful painkiller."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "kalma"
	New()
		..()
		reagents.add_reagent("morphine", 30)

/obj/item/weapon/reagent_containers/hypospray/stabilize
	name = "Salilane Injector"
	desc = "A modified air-needle autoinjector. This one has a simple interface used to stabilize a patient. Just point the tip at the target's neck and press the big grey button on the other end."
	amount_per_transfer_from_this = 5
	icon_state = "stabilize"
	volume = 10
	ignore_flags = 1
	flags = 0

/obj/item/weapon/reagent_containers/hypospray/stabilize/New()
	..()
	reagents.add_reagent("epinephrine", 2)
	reagents.add_reagent("tricordrazine", 4)
	reagents.add_reagent("inaprovaline", 4)

/obj/item/weapon/reagent_containers/hypospray/cure
	name = "Isilonimine Injector"
	desc = "An injector containing the miracle drug legecillin. This will reduce the effects of aging, alleviate disease symptoms, make withdrawal easier to bear, cleanse impurities from the subject's system, and renew the mind."
	amount_per_transfer_from_this = 30
	icon_state = "stabilize"
	volume = 120
	ignore_flags = 1
	flags = 0

/obj/item/weapon/reagent_containers/hypospray/cure/New()
	..()
	reagents.add_reagent("legecillin", 120)

/obj/item/weapon/reagent_containers/hypospray/stimpack
	name = "Stimulant Injector"
	desc = "An injector filled with very potent stimulants."
	amount_per_transfer_from_this = 60
	icon_state = "stimpack"
	volume = 60
	ignore_flags = 1
	flags = 0

/obj/item/weapon/reagent_containers/hypospray/stimpack/New() //Satrophine+Psychon, makes you absurdly robust while active.
	..()
	reagents.add_reagent("triumvirate", 30)
	reagents.add_reagent("supersteroids", 30)

/obj/structure/closet/secure_closet/freezer/is_open_container() //This is where we can get chloromethane. Draw it out of fridges and freezers with a syringe.
	return 1

/obj/structure/closet/secure_closet/freezer/New()
	..()
	create_reagents(40)
	reagents.add_reagent("chloromethane", 40)

/obj/item/weapon/storage/toolbox/emergency/New() //I *think* you can do a double New() define like this... Even if it seems like a questionable coding practice, it makes one less component of this system to integrate into the absolution build.
	..()
	if(prob(50))
		new /obj/item/weapon/reagent_containers/food/snacks/ration(src)
	else
		if(prob(6))
			new /obj/item/weapon/reagent_containers/food/snacks/ration/rare(src)
	if(prob(30))
		new /obj/item/weapon/reagent_containers/hypospray/stabilize(src)

/obj/item/weapon/reagent_containers/glass/bottle/unholywater
	name = "Unholy Water Flask"
	desc = "A small bottle. Contains water that has been infused with the powers of chaos undivided."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("unholywater", 30)

/obj/item/weapon/reagent_containers/food/drinks/soda_cans/heresy
	name = "Diet Harry Tick's"
	desc = "Praise Khor-The Emperor!"
	icon_state = "changelingsting"

/obj/item/weapon/reagent_containers/food/drinks/soda_cans/heresy/New()
	..()
	reagents.add_reagent("unholywater", 20)
	reagents.add_reagent("cola", 5)
	reagents.add_reagent("carbonwater", 5)
	src.pixel_x = rand(-10.0, 10)
	src.pixel_y = rand(-10.0, 10)

/obj/item/weapon/reagent_containers/glass/bottle/marshellium //...I can't even imagine where to put this... Maybe place it somewhere on the map?
	name = "Marshellium Flask"
	desc = "A small bottle. Contains the stuff of absolution."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("marshellium", 30)

/obj/item/weapon/reagent_containers/glass/bottle/norcacillin
	name = "Norcacillin Flask"
	desc = "A small bottle. Contains the stuff of absolution."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("norcacillin", 30)

/obj/item/weapon/reagent_containers/food/snacks/ration //This should go in the armory, kitchen, emergency storage, something.
	name = "Imperial Ration"
	desc = "A ration of the Imperium. It is unsure if this is really edible."
	icon_state = "ration"

/obj/item/weapon/reagent_containers/food/snacks/ration/New()
	..()
	reagents.add_reagent("nutriment", 9)
	var/flavors = pick("soysauce","ketchup","capsaicin","condensedcapsaicin","sodiumchloride","blackpepper","cornoil","enzyme","tomatojuice", "potato")
	reagents.add_reagent(pick(flavors), 3)
	bitesize = 6

/obj/item/weapon/reagent_containers/food/snacks/ration/rare //Some bizarre ancient imperial ration laced with stims and protein suplements. Probably unwise to consume when it was new, but it is currently the only place you can get RNA. Ultimately I want this to be a space hulk find but for now it will need to go in some desolate maint closet.
	name = "Enriched Imperial Ration"
	desc = "A ration of the Imperium. This ancient packaging contains a failed performance-enhancing variant of what the Imperium feeds its guards. It might be unwise to consume."

/obj/item/weapon/implant/butcher
	name = "butcher's nails"
	desc = "Makes the subject go into a bloodthirsty state in which they attack every living thing they encounter."
	var/mob/living/carbon/human/H

/obj/item/weapon/implant/butcher/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Butcher's Nails Implant<BR>
				<b>Life:</b> Indefinite.<BR>
				<b>Important Notes:</b> <font color='red'>MECHANICUS DESIGNATED CLASS V HERETICAL TECHNOLOGY</font><BR>
				<HR>
				<b>Implant Details:</b> Subjects with butcher's nails installed will be unstable, agressive, and unnaturally deadly in combat situations.<BR>
				<b>Function:</b> Bestows involuntary and highly potent combat abilities on an implanted individual.<BR>
				<b>Other Notes:</b> The Butcher's Nails implant, a device from the dark age of technology, has been adapted and used by the infamous world eaters traitor legion. Device is suspected of affiliation with the dark god known as Khorne."}
	return dat

/obj/item/weapon/implant/butcher/implanted(mob/source)
	source << "<span class='warning'>You have a splitting headache!</span>"
	if(ishuman(source))
		H = source
		H.Weaken(3)
		H.berserk = 1
		processing_objects.Add(src)
	return 1

/obj/item/weapon/implant/butcher/process()
	if(H && src.loc == H)
		if(H.reagents.get_reagent_amount("berserk") < 20)
			H.reagents.add_reagent("berserk", 2)
		if(H.reagents.get_reagent_amount("meth") < 20) //Definitely makes sense to replace hyperadrenal stimulant with snake.
			H.reagents.add_reagent("meth", 2)
		if(H.reagents.get_reagent_amount("tricordrazine") < 20)
			H.reagents.add_reagent("tricordrazine", 2)
		if(H.reagents.get_reagent_amount("supersteroids") < 20)
			H.reagents.add_reagent("supersteroids", 2)
	else
		processing_objects.Remove(src)

/obj/item/weapon/implanter/butcher
	name = "Butcher's Nails"

/obj/item/weapon/implanter/butcher/New()
	imp = new /obj/item/weapon/implant/butcher(src)
	..()
	update_icon()

/obj/item/weapon/reagent_containers/food/snacks/ration/rare/New()
	..()
	reagents.add_reagent("nutriment", 6)
	reagents.add_reagent("steroids", 8)
	reagents.add_reagent("stimulant", 8)
	reagents.add_reagent("soymilk", 4)
	reagents.add_reagent("RNA", 4)
	reagents.add_reagent("mutagen", 2)
	bitesize = 20

/obj/item/weapon/book/manual/chemicals
	name = "Chemical Index"
	icon_state ="chemistry"
	author = "The Imperium"
	title = "Chemical Index"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				</style>
				</head>
				<body>

				<h1>Chemical Ingredients:</h1>

				<BR><b>Venonine</b>: A medical compound used in extreme situations to alleviate blunt trauma, at the cost of toxification: Inaprovalene, Unstable Mutagen, Plasma
				<BR><b>Thenozine</b>: An extremely effective treatment on burns, though with unpleasant side effects: Kelotane, Mercury, Hydrogen
				<BR><b>Legecillin</b>: An expensive compound that slowly heals all kinds of ailments and even is known to reduce the effects of aging: Spaceacillin, Dylovene, Oxygen, Salt
				<BR><b>Combat Training Hallucinogen</b>: An excellent way to test your reflexes: Mindbreaker Toxin, Hyperzine, Water
				<BR><b>Endocryalin</b>: A compound to keep things cold, or produce makeshift cryogenics: Frost Oil, Water, Enzyme, Carbon
				<BR><b>Endocryalin Concentrate</b>: A concentrated version of endocryalin: Endocryalin, Ice, Plasma
				<BR><b>Stasis Mix</b>: A curious chemical that makes the subject momentarily appear to die: Endocryalin, Sleep Toxin
				<BR><b>Anti-ATP</b>: A toxin that fatigues the subject, eventually causing them to collapse from exhaustion: Sleep Toxin, Lithium, Ethanol
				<BR><b>Neurocardiac Restart</b>: The active ingredient of the expinovite cocktail: Legecillin, Inaprovalene, Synaptizine, Plasma
				<BR><b>Olitimine</b>: A substance that is moderately effective at treating physical injuries on both the living, and purportedly the dead: Ethanol, Hydrogen, Tricordrazine
				<BR><b>Imperial Narcotic</b>: An imperially approved light narcotic: Whiskey, Mercury
				<BR><b>Blue Supernova</b>: This is not sanctioned...: Mercury, Nitrogen, Red Diamond
				<BR><b>Spur</b>: A drug that has been around since the days of ancient terra, though it was called speed back then: Oxygen, Hyperzine, Space Cola, Red Diamond
				<BR><b>Alteration Serum</b>: Inquisitors find this one useful in dealing with unruly individuals: Blue Supernova, Chloromethane, Neurotoxin
				<BR><b>Occuline</b>: A compound that can improve vision: Bicaridine, Hyperzine, Copper, Plasma
				<BR><b>Laserbrain Dust</b>: This is really not sanctioned...: Sugar, Aluminium, Mindbreaker Toxin, Lithium, s**a******e
				<BR><b>Steroids</b>: A bit useful in a fistfight, although you would be disqualified from any self respecting athletics event: Sugar, Nitrogen, Sodium, Dexalin
				<BR><b>Chloroform</b>: The best pacification compound for the last forty thousand years: Ethanol, Diethylamine, Neurotoxin, Chloromethane
				<BR><b>Antimony Pentafluoride</b>: A covalent substance formed from antimony and five fluorine atoms: Antimony Trioxide, Fluorine
				<BR><b>Levalin</b>: An anomalous fluid that may be worth investigating: Hydrogen, Singularity, Carbonated Water
				<BR><b>Promethium</b>: A potent fuel that burns very hot: Fuel, Plasma, Lithium, Arc Juice

				</body>
				</html>"}

/obj/item/weapon/paper/crumpled/illegalchems //Contains the other recipes. I don't expect them to be found through experimentation, merely through finding one of these. I mean, what imperial guidebook would detail how to make polymorphine?
	name = "paper"

/obj/item/weapon/paper/crumpled/illegalchems/New()
	..()
	if(prob(80))
		info = pick("<b>Fluoroantimonic Acid</b> Fluorine, Hydrogen, Hydrochloric Acid, Polytrinic Acid, Sulfuric Acid, Plasma, Kelotane, Arithrazine, Antimony Pentafluoride", "<b>Flame Venom</b> Capsaicin, Condensed Capsaicin, Unstable Mutagen, Potassium", "<b>Manufacturing Enzyme</b> Enzyme, Blood, Nutriment, Unstable Mutagen, Soy Milk, Carbon, Ribonucleic Acid, Plasma", "<b>Selective Manufacturing Enzyme</b> Manufacturing Enzyme, Dylovene, Blood","<b>Engineered Stealth Toxin</b> Pneudelozine, Bicaridine, Devil's Kiss, Plasma","<b>Pneudelozine</b> Lexorin, Toxin, Neurotoxin, Carpotoxin","<b>Soul Shatterer</b> Unholy Water, Red Diamond","<b>Plague Bearer</b> Unholy Water, Blood","<b>Warp Binding</b> Unholy Water, Anti-ATP","<b>Butcher's Serum</b> Alteration Serum, Space Cleaner, Laserbrain Dust","<b>Cameleoline</b> Nanites, Silver, Weedkiller, Hooch","<b>Polymorphine</b> Plasma, Mutagen, Blood, Uranium, Rezadone","<b>Hyperadrenal Stimulant</b> Speed, Laserbrain Dust, Epinephrine, Synaptizine, Glycerol","<b>Stone Venom</b> Liquid Stone, Chloroform, Iron","<b>Liquid Stone</b> Silicon, Carbon, Steroids, Silver, Neurotoxin","<b>Kinezine</b> Steroids, Laserbrain Dust, Uranium","<b>Promethium (A lot of it)</b> Fuel, Plasma, Ethanol, Phosphorous, Dexalin, Arc Juice","<b>Snake</b> Blue Supernova, Hyperzine, Steroids", "Warning: The drink \"Diet Harry Tick's\" has been confirmed to contain unholy water. This drink is hereby banned from the imperium. Report all sightings of contraband.", "Note to the department: The firesuits on this outpost need replacing. They use an ancient terran flame retardant known as antimony trioxide, but the imperium has several more effective methods of protecting from fire. Unless the suits on this outpost are brough up to codes, there will be an inquiry.", "Departmental note: Warning: All enriched imperial rations have been recalled. Very few were made, but in the event that one is found with the others, do NOT ingest.", "Departmental note: Please outfit the kitchens with new refrigeration units. The current ones are using archaic chemical cooling systems that are not up to codes.", "Mixing too many drugs is dangerous!")
	else
		info = pick("<b>Konomi code.</b> Up, Up, Down, Down, A, B, Start", "<b>Goosezine</b> Bread, Whiskey, Unholy Water","<b>Unholy Water</b> Water, Chlorine, Nitrogen, Carbon, Potassium, Hydrogen, Oxygen, Radium","<b>Vault Combination</b> 31, 7, 92, 63","<b>Tombs Route</b> South, East, South, West","Honk.","<b>Adminoradrazine</b> Unstable Mutagen, Tricordrazine", "<b>ANSWER</b> 42","<b>BuildExplicitAccessWithName(byref(denyAccess), 'CURRENT_USER', dwAccessPermissions, DENY_ACCESS, NO_INHERITANCE)</b>")