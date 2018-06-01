//Contains the target item datums for Steal objectives.

//TODO: Change these to things that are actually valuable. -Drake
//Done. Target stealing items make sense on this server now hopefully.

datum/objective_item
	var/name = "A silly bike horn! Honk!"
	var/targetitem = /obj/item/weapon/bikehorn		//typepath of the objective item
	var/difficulty = 9001							//vaguely how hard it is to do this objective
	var/list/excludefromjob = list()				//If you don't want a job to get a certain objective (no captain stealing his own medal, etcetc)
	var/list/altitems = list()				//Items which can serve as an alternative to the objective (darn you blueprints)

datum/proc/check_special_completion() //for objectives with special checks (is that slime extract unused? does that intellicard have an ai in it? etcetc)
	return 1

datum/objective_item/steal/missile
	name = "a missile launcher"
	targetitem = /obj/item/weapon/gun/magic/staff/misslelauncher
	difficulty = 5
	excludefromjob = list("Captain", "Head of Security", "Warden", "Lord General", "Comissar", "Sergeant")

datum/objective_item/steal/handtele
	name = "a teleportation device"
	targetitem = /obj/item/weapon/hand_tele
	difficulty = 5
	excludefromjob = list("Captain", "Lord General")

datum/objective_item/steal/artifact
	name = "a device from the tombs (not a gun or staff, a more generic xenos device)"
	targetitem = /obj/item/xenoartifact
	difficulty = 10

datum/objective_item/steal/heart
	name = "a human heart"
	targetitem = /obj/item/organ/heart
	difficulty = 5

datum/objective_item/steal/soulstone
	name = "an eldar spirit stone (empty or filled)"
	targetitem =  /obj/item/device/soulstone
	difficulty = 15
	excludefromjob = list("Eldar Spy")

datum/objective_item/steal/soulstonefilled
	name = "a filled eldar spirit stone"
	targetitem =  /obj/item/device/soulstone
	difficulty = 20
	excludefromjob = list("Eldar Spy")

datum/objective_item/steal/soulstonefilled/check_special_completion(var/obj/item/device/soulstone/S)
	if(S.imprinted != "empty")
		return 1
	else
		return 0

datum/objective_item/steal/laserbrain
	name = "a full bag of laserbrain dust"
	targetitem = /obj/item/weapon/reagent_containers/glass/bottle/stimulant
	difficulty = 2

datum/objective_item/steal/laserbrain/check_special_completion(var/obj/item/weapon/reagent_containers/glass/bottle/stimulant/L)
	if(L.reagents.total_volume >= 30 && L.reagents.has_reagent("stimulant")) //Technically you can dilute it so long as there is enough powder in there and there is some laserbrain...
		return 1
	else
		return 0

datum/objective_item/steal/capmedal
	name = "the General's Medal"
	targetitem = /obj/item/clothing/tie/medal/gold/captain
	difficulty = 5
	excludefromjob = list("Captain", "Lord General")

datum/objective_item/steal/inferno
	name = "an inferno pistol"
	targetitem = /obj/item/weapon/gun/energy/inferno
	difficulty = 5
	excludefromjob = list("Chief Medical Officer", "Sister Hospitalier")

datum/objective_item/steal/nukedisc
	name = "the meltabomb authentication disk"
	targetitem = /obj/item/weapon/disk/nuclear
	difficulty = 5
	excludefromjob = list("Captain", "Lord General")

datum/objective_item/steal/carapace
	name = "a suit of carapace armor"
	targetitem = /obj/item/clothing/suit/armor/carapace
	difficulty = 5
	excludefromjob = list("Head of Security", "Warden", "Comissar", "Sergeant")

datum/objective_item/steal/reactive
	name = "the reactive teleport armor"
	targetitem = /obj/item/clothing/suit/armor/reactive
	difficulty = 5
	excludefromjob = list("Research Director")

datum/objective_item/steal/reactive
	name = "an inquisitor's suit"
	targetitem = /obj/item/clothing/suit/armor/inq
	difficulty = 3
	excludefromjob = list("Inquisitor")

datum/objective_item/steal/documents
	name = "a set of secret documents"
	targetitem = /obj/item/documents //Any set of secret documents. Doesn't have to be NT's
	difficulty = 20

//Items with special checks!
datum/objective_item/steal/plasma
	name = "150 units of promethium (full tank)"
	targetitem = /obj/item/weapon/tank
	difficulty = 3
	excludefromjob = list("Chief Engineer","Research Director","Station Engineer","Scientist","Atmospheric Technician", "Lord Inquisitor", "Tech Priest", "Adeptus Magos")

datum/objective_item/plasma/check_special_completion(var/obj/item/weapon/tank/T)
	var/target_amount = text2num(name)
	var/found_amount = 0
	found_amount += T.air_contents.promethium
	return found_amount>=target_amount

datum/objective_item/steal/functionalai
	name = "a functional master servitor"
	targetitem = /obj/item/device/aicard
	difficulty = 20 //beyond the impossible

datum/objective_item/functionalai/check_special_completion(var/obj/item/device/aicard/C)
	for(var/mob/living/silicon/ai/A in C)
		if(istype(A, /mob/living/silicon/ai) && A.stat != 2) //See if any AI's are alive inside that card.
			return 1
	return 0

datum/objective_item/steal/blueprints
	name = "the outpost blueprints or a photo of them"
	targetitem = /obj/item/blueprints
	difficulty = 5
	excludefromjob = list("Chief Engineer", "Adeptus Magos")
	altitems = list(/obj/item/weapon/photo)

datum/objective_item/blueprints/check_special_completion(var/obj/item/I)
	if(istype(I, /obj/item/blueprints))
		return 1
	if(istype(I, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/P = I
		if(P.blueprints)	//if the blueprints are in frame
			return 1
	return 0

datum/objective_item/steal/psword
	name = "a power sword or other power weapon"
	targetitem = /obj/item/weapon/powersword
	difficulty = 5
	excludefromjob = list("Inquisitor","Comissar", "Quartermaster")

//Unique Objectives
datum/objective_item/unique/docs_red
	name = "the \"Red\" secret documents"
	targetitem = /obj/item/documents/syndicate/red
	difficulty = 10

datum/objective_item/unique/docs_blue
	name = "the \"Blue\" secret documents"
	targetitem = /obj/item/documents/syndicate/blue
	difficulty = 10

//Old ninja objectives.
datum/objective_item/special/pinpointer
	name = "the captain's pinpointer"
	targetitem = /obj/item/weapon/pinpointer
	difficulty = 10

datum/objective_item/special/aegun
	name = "an advanced energy gun"
	targetitem = /obj/item/weapon/gun/energy/gun/nuclear
	difficulty = 10

datum/objective_item/special/ddrill
	name = "a diamond drill"
	targetitem = /obj/item/weapon/pickaxe/diamonddrill
	difficulty = 10

datum/objective_item/special/boh
	name = "a bag of holding"
	targetitem = /obj/item/weapon/storage/backpack/holding
	difficulty = 10

datum/objective_item/special/hypercell
	name = "a hyper-capacity cell"
	targetitem = /obj/item/weapon/stock_parts/cell/hyper
	difficulty = 5

datum/objective_item/special/laserpointer
	name = "a laser pointer"
	targetitem = /obj/item/device/laser_pointer
	difficulty = 5

//Stack objectives get their own subtype
datum/objective_item/stack
	name = "5 cardboards"
	targetitem = /obj/item/stack/sheet/cardboard
	difficulty = 9001

datum/objective_item/stack/check_special_completion(var/obj/item/stack/S)
	var/target_amount = text2num(name)
	var/found_amount = 0

	if(istype(S, targetitem))
		found_amount = S.amount
	return found_amount>=target_amount

datum/objective_item/stack/diamond
	name = "10 diamonds"
	targetitem = /obj/item/stack/sheet/mineral/diamond
	difficulty = 10

datum/objective_item/stack/gold
	name = "50 gold bars"
	targetitem = /obj/item/stack/sheet/mineral/gold
	difficulty = 15

datum/objective_item/stack/uranium
	name = "25 refined uranium bars"
	targetitem = /obj/item/stack/sheet/mineral/uranium
	difficulty = 10
