//I did my best to make these sufficiently difficult to make. Enjoy the new chems. -Drake

/datum/chemical_reaction/hacid
	name = "Hydrochloric Acid"
	id = "hacid"
	result = "hacid"
	required_reagents = list("hydrogen" = 1, "chlorine" = 1, "water" = 1)
	result_amount = 2

/datum/chemical_reaction/eacid
	name = "Fluoroantimonic Acid"
	id = "eacid"
	result = "eacid"
	required_reagents = list("fluorine" = 1, "hydrogen" = 1, "hacid" = 1, "pacid" = 1, "sacid" = 1, "plasma" = 1, "kelotane" = 1, "arithrazine" = 1, "SbF" = 1)
	result_amount = 1

/datum/chemical_reaction/burn
	name = "Promethium"
	id = "burn"
	result = "burn"
	required_reagents = list("fuel" = 2, "plasma" = 2, "ethanol" = 1, "phosphorus" = 1, "dexalin" = 1, "arcjuice" = 1)
	result_amount = 20

/datum/chemical_reaction/burn2
	name = "Promethium"
	id = "burn2"
	result = "burn"
	required_reagents = list("fuel" = 1, "plasma" = 1, "lithium" = 1, "arcjuice" = 1)
	result_amount = 3

/datum/chemical_reaction/knockout
	name = "Chloroform"
	id = "knockout"
	result = "knockout"
	required_reagents = list("ethanol" = 2, "diethylamine" = 2, "neurotoxin" = 2, "chloromethane" = 2)
	result_amount = 2

/datum/chemical_reaction/steroids
	name = "Steroids"
	id = "steroids"
	result = "steroids"
	required_reagents = list("sugar" = 1, "nitrogen" = 1, "sodium" = 1, "dexalin" = 1)
	result_amount = 2

/datum/chemical_reaction/supersteroids
	name = "Kinezine"
	id = "supersteroids"
	result = "supersteroids"
	required_reagents = list("steroids" = 1, "stimulant" = 1, "uranium" = 1)
	result_amount = 1

/datum/chemical_reaction/robust
	name = "Liquid Stone"
	id = "robust"
	result = "robust"
	required_reagents = list("kelotane" = 2, "steroids" = 1, "silver" = 1, "neurotoxin" = 1) //Changed silicon and carbon to kelotane, since that is what silicon and carbon will form.
	result_amount = 2

/datum/chemical_reaction/stonevenom
	name = "Stone Venom"
	id = "stonevenom"
	result = "stonevenom"
	required_reagents = list("robust" = 1, "knockout" = 1, "iron" = 2)
	result_amount = 1

/datum/chemical_reaction/atium
	name = "Hyperadrenal Stimulant"
	id = "atium"
	result = "atium"
	required_reagents = list("speed" = 1, "stimulant" = 1, "epinephrine" = 1, "synaptizine" = 1, "glycerol" = 1)
	result_amount = 5 //Rare ingredients, but at least it should produce a useful amount.

/datum/chemical_reaction/stimulant
	name = "Laserbrain Dust"
	id = "stimulant"
	result = "stimulant"
	required_reagents = list("synaptizine" = 1, "sugar" = 1, "lithium" = 1, "mindbreaker" = 1, "aluminium" = 1)
	result_amount = 4

/datum/chemical_reaction/otherdrug
	name = "Imperial Narcotic"
	id = "otherdrug"
	result = "otherdrug"
	required_reagents = list("mercury" = 1, "whiskey" = 1)
	result_amount = 3

/datum/chemical_reaction/occustim
	name = "Occuline"
	id = "occustim"
	result = "occustim"
	required_catalysts = list("plasma" = 1)
	required_reagents = list("bicaridine" = 1, "hyperzine" = 1, "copper" = 1)
	result_amount = 3

/datum/chemical_reaction/speed
	name = "Speed"
	id = "speed"
	result = "speed"
	required_reagents = list("oxygen" = 1, "hyperzine" = 1, "cola" = 1, "space_drugs" = 1)
	result_amount = 2

/datum/chemical_reaction/polymorphine
	name = "Polymorphine"
	id = "polymorphine"
	result = "polymorphine"
	required_catalysts = list("plasma" = 5)
	required_reagents = list("mutagen" = 5, "blood" = 3, "uranium" = 1, "rezadone" = 2)
	result_amount = 1

/datum/chemical_reaction/cameleoline
	name = "Cameleoline"
	id = "cameleoline"
	result = "cameleoline"
	required_catalysts = list("nanites" = 1)
	required_reagents = list("silver" = 1, "weedkiller" = 1, "hooch" = 1)
	result_amount = 1

/datum/chemical_reaction/cameleoline/on_reaction(var/datum/reagents/holder, var/created_volume)
	..()
	holder.add_reagent("crazy", created_volume/2)

/datum/chemical_reaction/fatigue
	name = "Anti-ATP"
	id = "fatigue"
	result = "fatigue"
	required_reagents = list("stoxin" = 1, "lithium" = 1, "ethanol" = 1)
	result_amount = 2

/datum/chemical_reaction/flying
	name = "Levalin"
	id = "flying"
	result = "flying"
	required_reagents = list("hydrogen" = 1, "singulo" = 1, "carbonwater" = 1)
	result_amount = 3

/datum/chemical_reaction/hallucinations
	name = "Blue Supernova"
	id = "hallucinations"
	result = "hallucinations"
	required_reagents = list("mercury" = 1, "nitrogen" = 1, "space_drugs" = 1)
	result_amount = 2

/datum/chemical_reaction/meth
	name = "Snake"
	id = "meth"
	result = "meth"
	required_reagents = list("hallucinations" = 1, "hyperzine" = 1, "steroids" = 1)
	result_amount = 2

/datum/chemical_reaction/conditioning
	name = "Alteration Serum"
	id = "conditioning"
	result = "conditioning"
	required_reagents = list("hallucinations" = 1, "chloromethane" = 1, "neurotoxin" = 1)
	result_amount = 2

/datum/chemical_reaction/berserk
	name = "Butcher's Serum"
	id = "berserk"
	result = "berserk"
	required_reagents = list("conditioning" = 1, "cleaner" = 1, "stimulant" = 1)
	result_amount = 2

/datum/chemical_reaction/legecillin
	name = "Legecillin"
	id = "legecillin"
	result = "legecillin"
	required_reagents = list("spaceacillin" = 1, "anti_toxin" = 1, "oxygen" = 1, "sodiumchloride" = 1)
	result_amount = 4

/datum/chemical_reaction/revival
	name = "Neurocardiac Restart"
	id = "revival"
	result = "revival"
	required_reagents = list("legecillin" = 1, "inaprovaline" = 1, "synaptizine" = 1, "plasma" = 1)
	result_amount = 4

/datum/chemical_reaction/patch
	name = "Olitimine"
	id = "patch"
	result = "patch"
	required_reagents = list("ethanol" = 1, "tricordrazine" = 1, "hydrogen" = 1)
	result_amount = 2

/datum/chemical_reaction/warpbond
	name = "Warp Binding"
	id = "warpbond"
	result = "warpbond"
	required_reagents = list("unholywater" = 1, "fatigue" = 1)
	result_amount = 1

/datum/chemical_reaction/nurgle
	name = "Plague Bearer"
	id = "nurgle"
	result = "nurgle"
	required_reagents = list("unholywater" = 1, "blood" = 1)
	result_amount = 1

/datum/chemical_reaction/slaanesh
	name = "Soul Shatterer"
	id = "slaanesh"
	result = "slaanesh"
	required_reagents = list("unholywater" = 1, "space_drugs" = 1)
	result_amount = 1

/datum/chemical_reaction/combattraining
	name = "Combat Training Hallucinogen"
	id = "combattraining"
	result = "combattraining"
	required_reagents = list("mindbreaker" = 5, "hyperzine" = 5, "water" = 20)
	result_amount = 30

/datum/chemical_reaction/strangle
	name = "Pneudelozine"
	id = "strangle"
	result = "strangle"
	required_reagents = list("lexorin" = 1, "toxin" = 1, "neurotoxin" = 1, "carpotoxin" = 1)
	result_amount = 1

/datum/chemical_reaction/freeze
	name = "Endocryalin"
	id = "freeze"
	result = "freeze"
	required_reagents = list("frostoil" = 1, "water" = 1, "enzyme" = 1, "carbon" = 1)
	result_amount = 1

/datum/chemical_reaction/sfreeze
	name = "Endocryalin Concentrate"
	id = "sfreeze"
	result = "sfreeze"
	required_reagents = list("freeze" = 10, "ice" = 5, "plasma" = 5)
	result_amount = 5

/datum/chemical_reaction/stealth
	name = "Engineered Stealth Toxin"
	id = "stealth"
	result = "stealth"
	required_reagents = list("strangle" = 10, "bicaridine" = 10, "devilskiss" = 10, "plasma" = 70)
	result_amount = 15

/datum/chemical_reaction/boost
	name = "Selective Manufacturing Enzyme"
	id = "boost"
	result = "boost"
	required_reagents = list("increase" = 10, "anti_toxin" = 30, "blood" = 60)
	result_amount = 15

/datum/chemical_reaction/increase
	name = "Manufacturing Enzyme"
	id = "increase"
	result = "increase"
	required_reagents = list("enzyme" = 1, "blood" = 1, "nutriment" = 1, "mutagen" = 1, "soymilk" = 1, "carbon" = 1, "RNA" = 1)
	required_catalysts = list("plasma" = 1)
	result_amount = 4

/datum/chemical_reaction/SbF
	name = "Antimony Pentafluoride"
	id = "SbF"
	result = "SbF"
	required_reagents = list("SbO" = 1, "fluorine" = 5)
	result_amount = 2

/datum/chemical_reaction/destroyer
	name = "Flame Venom"
	id = "destroyer"
	result = "destroyer"
	required_reagents = list("capsaicin" = 1, "condensedcapsaicin" = 1, "mutagen" = 1, "potassium" = 1)
	result_amount = 2

/datum/chemical_reaction/fakedeath
	name = "Stasis Mix"
	id = "fakedeath"
	result = "fakedeath"
	required_reagents = list("freeze" = 1, "stoxin" = 1)
	result_amount = 1

/datum/chemical_reaction/toxbrute
	name = "Venonine"
	id = "toxbrute"
	result = "toxbrute"
	required_catalysts = list("plasma" = 1)
	required_reagents = list("inaprovaline" = 10, "mutagen" = 10, "plasma" = 1)
	result_amount = 10

/datum/chemical_reaction/brainburn
	name = "Thenozine"
	id = "brainburn"
	result = "brainburn"
	required_reagents = list("kelotane" = 1, "mercury" = 1, "hydrogen" = 1)
	result_amount = 1

/datum/chemical_reaction/triumvirate
	name = "Triumvirate"
	id = "triumvirate"
	result = "triumvirate"
	required_reagents = list("stimulant" = 1, "speed" = 1, "meth" = 1)
	result_amount = 2

/datum/chemical_reaction/overdrive
	name = "Overdrive"
	id = "overdrive"
	result = "overdrive"
	required_reagents = list("triumvirate" = 1, "polymorphine" = 1, "supersteroids" = 1, "ethanol" = 1)
	result_amount = 2

/datum/chemical_reaction/rotgut
	name = "Rotgut"
	id = "rotgut"
	result = "rotgut"
	required_reagents = list("hooch" = 1, "moonshine" = 1)
	result_amount = 2