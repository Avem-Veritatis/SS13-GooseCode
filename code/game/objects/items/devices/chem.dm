/obj/item/device/cheminhaler
	name = "Chem Inhaler"
	desc = "An inhaler used by the imperial guard to easily ingest combat stimulants."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "cheminhaler"
	throwforce = 1
	w_class = 1.0
	throw_speed = 3
	throw_range = 7
	flags = CONDUCT
	item_state = "electronic"
	origin_tech = "combat=2"
	var/uses = 25
	var/cooldown = 0

/obj/item/device/cheminhaler/attack_self(mob/living/carbon/user as mob, flag = 0, emp = 0)
	if(!user) 	return
	if(uses <= 0)
		user << "\red The [src] is empty!"
		return
	if(cooldown)
		return
	user << "\red You use the chem inhaler."
	uses -= 1
	cooldown = 1
	spawn(200) cooldown = 0
	user.reagents.add_reagent("epinephrine", 10)
	user.reagents.add_reagent("hyperzine", 10)
	user.reagents.add_reagent("steroids", 10)
	user.reagents.add_reagent("synaptizine", 3)
	user.reagents.add_reagent("anti_toxin", 3)