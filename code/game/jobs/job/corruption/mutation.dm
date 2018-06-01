/*
A chaos mutation system.
Mutations will have datums to sort and handle them (I like datums lol)
This will also sort what type of mutation it is (ex general chaos mutation, slaanesh mutation, et cetera)
Most mutations will work either by applying an overlay (a feature built into the mutation datum, I will need to implement this in human code), creating an item (for example, the tentacles item or an arm blade), and/or editing existing variables in the mob.
*/

/datum/mutation
	var/name = "chaos mutation"
	var/desc = "This should probably not exist."
	var/overlay_icon_state = "error"
	var/mob/living/carbon/human/holder
	var/layer = 20

/datum/mutation/proc/init_mob(var/mob/living/carbon/human/H)
	holder = H
	H.mutations_warp.Add(src)
	return

/datum/mutation/slaanesh
	name = "slaanesh mutation"

/datum/mutation/khorne
	name = "khorne mutation"

/datum/mutation/nurgle
	name = "nurgle mutation"

/datum/mutation/tzeench
	name = "tzeench mutation"

/datum/mutation/malal
	name = "malal mutation"

/datum/mutation/undivided
	name = "chaos undivided mutation"

/datum/mutation/xeno
	name = "xeno mutation"

/datum/mutation/generic
	name = "generic mutation"

/mob/living/carbon/human/proc/mutate(var/mutation_type = null)
	if(!mutation_type)
		var/path = pick(typesof(/datum/mutation/))
		var/datum/mutation/M = new path()
		M.init_mob(src)
		update_mutations()
		return
	switch(mutation_type)
		if("slaanesh")
			var/path = pick(typesof(/datum/mutation/slaanesh) - /datum/mutation/slaanesh)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("khorne")
			var/path = pick(typesof(/datum/mutation/khorne) - /datum/mutation/khorne)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("nurgle")
			var/path = pick(typesof(/datum/mutation/nurgle) - /datum/mutation/nurgle)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("tzeench")
			var/path = pick(typesof(/datum/mutation/tzeench) - /datum/mutation/tzeench)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("undivided")
			var/path = pick(typesof(/datum/mutation/undivided) - /datum/mutation/undivided)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("malal")
			var/path = pick(typesof(/datum/mutation/malal) - /datum/mutation/malal)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("xeno")
			var/path = pick(typesof(/datum/mutation/xeno) - /datum/mutation/xeno)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("mark of slaanesh")
			var/datum/mutation/slaanesh/mark/M = new()
			M.init_mob(src)
		if("tentacle mutation")
			var/datum/mutation/slaanesh/tentacles/M = new()
			M.init_mob(src)
		if("red eyes")
			var/datum/mutation/undivided/redeyes/M = new()
			M.init_mob(src)
		if("arcane glow")
			var/datum/mutation/tzeench/glow/M = new()
			M.init_mob(src)
		if("rot")
			var/datum/mutation/nurgle/rot/M = new()
			M.init_mob(src)
		if("flies")
			var/datum/mutation/nurgle/flies/M = new()
			M.init_mob(src)
		if("bloody")
			var/datum/mutation/khorne/bloody/M = new()
			M.init_mob(src)
		if("kflames")
			var/datum/mutation/khorne/flame/M = new()
			M.init_mob(src)
		if("tflames")
			var/datum/mutation/tzeench/flame/M = new()
			M.init_mob(src)
		if("chains")
			var/datum/mutation/undivided/chains/M = new()
			M.init_mob(src)
		if("addiction")
			var/datum/mutation/slaanesh/addiction/M = new()
			M.init_mob(src)
		if("goldenglow")
			var/datum/mutation/generic/glow/M = new()
			M.init_mob(src)
	update_mutations()

/mob/living/carbon/human/proc/make_chaos_spawn(var/chaosgod = null)
	if(!chaosgod)
		chaosgod = pick("slaanesh, nurgle, tzeench", "khorne")
	var/list/mutations = list()
	switch(chaosgod)
		if("slaanesh")
			mutations = list(/datum/mutation/slaanesh/mark, /datum/mutation/slaanesh/tentacles, /datum/mutation/undivided/redeyes)
		if("nurgle")
			mutations = list(/datum/mutation/nurgle/rot, /datum/mutation/nurgle/flies, /datum/mutation/undivided/redeyes)
		if("tzeench")
			mutations = list(/datum/mutation/tzeench/flame, /datum/mutation/undivided/redeyes, /datum/mutation/undivided/chains)
		if("khorne")
			mutations = list(/datum/mutation/khorne/bloody, /datum/mutation/khorne/flame, /datum/mutation/undivided/redeyes)
	for(var/path in mutations)
		var/datum/mutation/M = locate(path) in src
		if(!M)
			M = new path()
			M.init_mob(src)
	update_mutations()
	src.visible_message("\red <b>[src] is entirely consumed by the powers of chaos!</b>")
	src.ghostize(0)
	src.berserk = 1
	src.berserkmaster = chaosgod


/////////////////////////////////////////////////////
//--------------SLAANESH MUTATIONS-----------------//
/////////////////////////////////////////////////////

/datum/mutation/slaanesh/mark
	name = "mark of slaanesh"
	desc = "A mark on the forehead that shows fealty to the prince of pleasure, Slaanesh."
	overlay_icon_state = "slaanesh_mark"
	layer = 1 //Mark can't be easily concealed!

/datum/mutation/slaanesh/tentacles
	name = "tentacle mutation"
	desc = "A gift from lord Slaanesh, a mass of writhing tentacles."
	overlay_icon_state = "blank"

/datum/mutation/slaanesh/tentacles/init_mob(var/mob/living/carbon/human/H)
	..()
	if(!H.unEquip(H.w_uniform))
		qdel(H.w_uniform)
	H.equip_to_slot_if_possible(new /obj/item/clothing/under/tentacles, slot_w_uniform, 1, 1)

/datum/mutation/slaanesh/addiction
	name = "unnatural addiction"
	desc = "An addiction to an unnatural substance."
	overlay_icon_state = "blank"

/datum/mutation/slaanesh/addiction/init_mob(var/mob/living/carbon/human/H)
	..()
	var/datum/addiction/severe/A = new /datum/addiction/severe
	A.recovery = 20000 //Basically impossible to recover from even with legecillin. Makes you literally dependant on one of these chemicals.
	A.addictionid = pick("blood", "mercury", "lipozine", "poisonberryjuice", "neurotoxin", "chloromethane")
	A.addictionname = A.addictionid
	if(A.addictionname == "poisonberryjuice") //This is horrible coding practice, but for a simple and functional mutation proc it will have to do.
		A.addictionname = "poison berry juice"
	A.name = "Unnatural Addiction"
	H.addictions.Add(A)

/////////////////////////////////////////////////////
//----------------CHAOS UNDIVIDED------------------//
/////////////////////////////////////////////////////

/datum/mutation/undivided/redeyes
	name = "red eyes"
	desc = "Glowing red eyes."
	overlay_icon_state = "red_eyes"

/datum/mutation/undivided/chains
	name = "warp chains"
	desc = "A physical manifestation of someone's bonds to the immaterium."
	overlay_icon_state = "chains"
	layer = 1

/////////////////////////////////////////////////////
//--------------------TZEENCH----------------------//
/////////////////////////////////////////////////////

/datum/mutation/tzeench/glow
	name = "Arcane Glow"
	desc = "Pulsing arcane lights emanate from the subject."
	overlay_icon_state = "glow"

/datum/mutation/tzeench/flame
	name = "Arcane Fire"
	desc = "Ethereal blue flames surrounding the subject."
	overlay_icon_state = "tflames"
	layer = 1

/////////////////////////////////////////////////////
//----------------NURGLE MUTATIONS-----------------//
/////////////////////////////////////////////////////

/datum/mutation/nurgle/rot
	name = "Rotted Tissue"
	desc = "A region of half-rotted flesh."
	overlay_icon_state = "rot"
	layer = 1

/datum/mutation/nurgle/flies
	name = "Fly Swarm"
	desc = "Flies are attracted to the subject."
	overlay_icon_state = "flies"
	layer = 1

/////////////////////////////////////////////////////
//----------------KHORNE MUTATIONS-----------------//
/////////////////////////////////////////////////////

/datum/mutation/khorne/bloody
	name = "Bloody"
	desc = "Subject is always bloodstained."
	overlay_icon_state = "bloody"
	layer = 1

/datum/mutation/khorne/flame
	name = "Sanguine Flames"
	desc = "Otherwordly crimson flames surround the subject."
	overlay_icon_state = "kflames"
	layer = 1

//Generic mutations. IE golden glow.

/datum/mutation/generic/glow
	name = "Holy Light"
	desc = "Affected individual is literally radiant with the Emperor's holy light."
	overlay_icon_state = "goldenglow"