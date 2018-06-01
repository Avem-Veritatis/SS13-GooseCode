//Due to how large this one is it gets its own file
/*
Chaplain
*/
/datum/job/chaplain
	title = "Preacher"
	flag = CHAPLAIN
	department_head = list("The Ecclesiarchy")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Ecclesiarchy"
	selection_color = "#dddddd"

	default_pda = /obj/item/device/pda/chaplain

	access = list(access_morgue, access_chapel_office, access_crematorium, access_maint_tunnels)
	minimal_access = list(access_morgue, access_chapel_office, access_crematorium)
	assistant_access = list(access_chapel_office)

/datum/job/chaplain/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/bible(H), slot_r_hand)
	H.seer = 1 //Chaplain can see into the warp. Sort of important, because it will allow them to do anything to fight certain types of daemon.
	var/obj/item/weapon/implant/loyalty/E = new/obj/item/weapon/implant/loyalty(H)
	E.imp_in = H
	E.implanted = 1