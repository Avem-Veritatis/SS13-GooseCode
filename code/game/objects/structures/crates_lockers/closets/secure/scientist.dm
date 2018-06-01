/obj/structure/closet/secure_closet/scientist
	name = "scientist's locker"
	req_access = list(access_tox_storage)
	icon_state = "secureres1"
	icon_closed = "secureres"
	icon_locked = "secureres1"
	icon_opened = "secureresopen"
	icon_broken = "secureresbroken"
	icon_off = "secureresoff"

	New()
		..()
		sleep(2)
		new /obj/item/clothing/suit/labcoat/coat/science(src)
		new /obj/item/clothing/under/rank/scientist(src)
		new /obj/item/clothing/suit/labcoat/science(src)
		new /obj/item/clothing/shoes/sneakers/white(src)
//		new /obj/item/weapon/cartridge/signal/toxins(src)
		new /obj/item/device/radio/headset/headset_sci(src)
		new /obj/item/weapon/tank/air(src)
		new /obj/item/clothing/mask/gas(src)
		return



/obj/structure/closet/secure_closet/RD
	name = "\proper research director's locker"
	req_access = list(access_rd)
	icon_state = "inqlocked"
	icon_closed = "inqclosed"
	icon_opened = "inqopen"
	icon_locked = "inqlocked"
	icon_broken = "inqbroken"
	icon_off = "inqclosed"

	New()
		..()
		sleep(2)
		new /obj/item/clothing/suit/labcoat/coat/science(src)
		new /obj/item/clothing/suit/bio_suit/scientist(src)
		new /obj/item/clothing/head/bio_hood/scientist(src)
		new /obj/item/clothing/under/rank/research_director(src)
		new /obj/item/clothing/suit/labcoat(src)
		new /obj/item/weapon/cartridge/rd(src)
		new /obj/item/clothing/shoes/sneakers/white(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/device/radio/headset/heads/rd(src)
		new /obj/item/weapon/tank/air(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/clothing/suit/armor/reactive(src)
		new /obj/item/device/flash(src)
		new /obj/item/device/laser_pointer(src)
		new /obj/item/clothing/under/rank/research_director/alt(src)
		new /obj/item/clothing/under/rank/research_director/ema(src)
		return