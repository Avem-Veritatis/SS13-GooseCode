/obj/effect/proc_holder/changeling/carepackage
	name = "Short Range Supply Teleport"
	desc = "We call for a short range teleport to deliver backup supplies"
	helptext = "Well rounded supplies. More than enough to get the job done."
	chemical_cost = 50
	dna_cost = 1



/obj/effect/proc_holder/changeling/carepackage/sting_action(var/mob/user)
	if(!user.drop_item())
		user << "The [user.get_active_hand()] is stuck to your hand, put it away first."
		return
	user.put_in_hands(new /obj/item/weapon/storage/box/callidus(user))
	radarintercept("<font color='red'>S... S.... NINE... FOUR... ONE... package delivered. Moving on.")
	return 1
