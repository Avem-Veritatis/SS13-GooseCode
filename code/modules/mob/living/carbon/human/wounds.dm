/*
A lightweight wounds datum.
Literally only for flavortext; I don't think we need things like broken bones. Ever.
It's just that the whole "severe bruising" thing is a little silly.
*/

/datum/wound
	var/desc = "has a bruise on it"
	var/scarname = null
	var/damtype = "brute"
	var/heal_thresh = 0

/datum/wound/burn
	desc = "has burns"
	scarname = null
	damtype = "burn"
	heal_thresh = 0

/datum/wound/shrapnel
	desc = "has a piece of shrapnel embedded in it"
	scarname = "has a small star shaped scar"
	damtype = "brute"
	heal_thresh = 10

/datum/wound/bullet
	desc = "has a bullet hole in it"
	scarname = "has a large star shaped scar"
	damtype = "brute"
	heal_thresh = 5

/datum/wound/bolter
	desc = "has a massive bullet hole blasted in it"
	scarname = "has a massive star shaped scar"
	damtype = "brute"
	heal_thresh = 10

/datum/wound/laser
	desc = "has laser searing"
	scarname = "has a large star shaped scar"
	damtype = "burn"
	heal_thresh = 15

/datum/wound/melt
	desc = "is partially burnt away"
	scarname = "has a massive swath of scarring"
	damtype = "burn"
	heal_thresh = 20

/datum/wound/fractures
	desc = "looks broken"
	damtype = "brute"
	heal_thresh = 20

/datum/wound/slash
	desc = "has an ugly gash in it"
	scarname = "has a long scar twisting across it"
	damtype = "brute"
	heal_thresh = 10

/datum/wound/puncture
	desc = "has a deep puncture wound in it"
	scarname = "has a large star shaped scar"
	damtype = "brute"
	heal_thresh = 10

/datum/wound/chainsword
	desc = "has a massive slash raggedly torn through it"
	scarname = "has a long ragged scar twisting across it"
	damtype = "brute"
	heal_thresh = 15

/datum/wound/chem
	desc = "has chemical burns"
	damtype = "burn"
	heal_thresh = 10