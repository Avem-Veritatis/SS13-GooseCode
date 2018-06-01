/mob/living/carbon/human/dummy/goosemarine
	name = "GooseMarine"
	real_name = "GooseMarine"
	universal_speak = 1
	gender = "male"
	icon = 'icons/mob/mob.dmi'
	icon_state = "goosemarine"

/mob/living/carbon/human/dummy/goosemarine/New()
	..()
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/BPMP, slot_l_hand)

/mob/living/carbon/human/dummy/goosemarine/ex_act(severity)
	return

/mob/living/carbon/human/dummy/goosemarine/Life()
	..()
	if(prob(1))
		var/chat = pick('sound/voice/dreet2.ogg','sound/voice/gooselaugh.ogg')
		playsound(loc, chat, 75, 0)