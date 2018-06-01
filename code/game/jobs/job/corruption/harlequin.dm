/obj/item/clothing/under/harlequin
	name = "mime's outfit"
	desc = "Now it's more colorful."
	icon_state = "harlequin"
	item_state = "mime"
	item_color = "harlequin"
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 5, bomb = 5, bio = 10, rad = 10)

/obj/item/clothing/suit/armor/harlequin
	name = "Harlequin Coat"
	desc = "The ornamented battle dress of a harlequin."
	icon_state = "harlequin"
	item_state = "harlequin"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 65, bullet = 60, laser = 60, energy = 100, bomb = 65, bio = 100, rad = 100)
	slowdown = -10
	allowed = list(/obj/item/weapon/gun, /obj/item/weapon/chainsword, /obj/item/weapon/powersword, /obj/item/weapon/complexknife, /obj/item/weapon/complexsword, /obj/item/weapon/fastknife)

/obj/item/clothing/head/helmet/harlequin
	name = "beret"
	desc = "A beret with a large plume stuck in the top."
	icon_state = "harlequin"
	item_state = "harlequin"
	flags = HEADCOVERSEYES|HEADCOVERSMOUTH|THICKMATERIAL
	armor = list(melee = 30, bullet = 25, laser = 25, energy = 100, bomb = 50, bio = 100, rad = 100)
	flags_inv = HIDEEARS

/obj/item/clothing/gloves/combat/harlequin
	name = "harlequin gloves"
	desc = "It's just crayon drawings on a pair of white gloves, but somehow it still looks ornamented and even combat ready."
	icon_state = "harlequin"
	item_state = "harlequin"

/obj/item/clothing/shoes/swat/harlequin
	name = "harlequin boots"
	desc = "A pair of shoes that have been artfully reinforced with metal. Not bad, considering the simplicity of their construction."
	icon_state = "harlequin"
	item_state = "harlequin"

//harlequin

/obj/item/clothing/mask/gas/mime/solitare
	name = "Solitaire Mask"
	desc = "It may be crayon markings... but whoever designed this mask means business. This is some grade A heresy right here."
	alloweat = 1
	icon_state = "solitaire"
	item_state = "solitaire"
	can_flip = null
	harl = 1

/obj/item/clothing/mask/gas/mime/cegorach
	name = "Cegorach Mask"
	desc = "It may be crayon markings... but whoever designed this mask means business. This is some grade A heresy right here."
	alloweat = 1
	icon_state = "laughing"
	item_state = "laughing"
	can_flip = null
	harl = 1

/obj/item/clothing/mask/gas/mime/death
	name = "Death Mask"
	desc = "It may be crayon markings... but whoever designed this mask means business. This is some grade A heresy right here."
	alloweat = 1
	icon_state = "death"
	item_state = "death"
	can_flip = null
	harl = 1

/obj/item/clothing/mask/gas/mime/blind
	name = "Blinded Princess Mask"
	desc = "It may be crayon markings... but whoever designed this mask means business. This is some grade A heresy right here."
	alloweat = 1
	icon_state = "blind"
	item_state = "blind"
	can_flip = null
	harl = 1

//end harlequin

/obj/item/weapon/powersword/harlequin
	name = "Harlequin's Blade"
	desc = "A harlequin's power sword."
	icon_state = "harlequin_off"
	icon_on = "harlequin_on"
	icon_off = "harlequin_off"
	item_on = "mercychainswordig0"
	item_off = "mercychainswordig0"
	switchsound = 'sound/effects/phasein.ogg'
	force = 40.0
	throwforce = 30
	origin_tech = "combat=8"
	stunforce = 10
	parryprob = 250
	parrycooldown = 1
	parryduration = 10
	var/slicecooldown = 0

/obj/item/weapon/powersword/harlequin/verb/slice()
	set category = "Mime"
	set name = "Slice"
	set desc = "Sprint forward in a blur and slice things in your path."

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(!locate(/obj/item/clothing/suit/armor/harlequin) in H)
			H << "\red You need your costume to use this ability!"
			return
		if(!locate(/obj/item/clothing/mask/gas/mime) in H)
			H << "\red You need your costume to use this ability!"
			return
		if(H.loc != get_turf(H))
			return
		if(H.get_active_hand() != src)
			H << "\red You can only do this while actually wielding the blade, silly."
			return
		if(slicecooldown)
			H << "\red Ability charging."
			return
		slicecooldown = 1
		spawn(20) slicecooldown = 0
		H.visible_message("\red [H] sprints forward in a blur!")
		var/obj/effect/harl/B = new /obj/effect/harl(get_turf(H))
		B.master = src
		B.user = H
		H.loc = B
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		H.loc = get_turf(B)
		qdel(B)
	else
		usr << "\red What... What the hell are you?"
		return

/obj/effect/harl
	name = "blade slice"
	desc = "The slicing path of a harlequin blade."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "slice"
	density = 1
	anchored = 1
	unacidable = 1
	var/mob/living/carbon/human/user
	var/obj/item/weapon/powersword/harlequin/master

/obj/effect/effect/bad_smoke/harlequin
	var/mob/living/carbon/human/user
	var/can_move = 1

/obj/effect/effect/bad_smoke/harlequin/Destroy()
	user.loc = get_turf(src)
	..()

/obj/effect/effect/bad_smoke/harlequin/relaymove(var/mob/user, direction)
	step(src, direction)
	return