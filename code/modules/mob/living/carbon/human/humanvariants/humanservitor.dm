/mob/living/carbon/human/whitelisted/servitor
	name = "Unknown"
	real_name = "Unknown"
	suicide_allowed = 0
	universal_speak = 1
	gender = "male"
	status_flags = 0

/mob/living/carbon/human/whitelisted/servitor/New()
	..()
	sleep (5)
	hardset_dna(src, null, null, null, "servitor")
	real_name = text("Servitor ([rand(1, 1000)])")
	equip_to_slot_or_del(new /obj/item/clothing/under/golem(src), slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/suit/golem(src), slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/golem(src), slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/golem(src), slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/golem(src), slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/space/golem(src), slot_head)

	src.organs = list()


	var/obj/item/weapon/card/id/W = new
	W.icon_state = "data"
	W.access = get_all_accesses()
	W.assignment = "Servitor"
	W.registered_name = real_name
	W.update_label()
	W.flags |= NODROP
	equip_to_slot_or_del(W, slot_wear_id)
	sleep(20)
	regenerate_icons()