/obj/machinery/rack
	name = "broken rack"
	desc = "OH SHIT THIS RACK IS TECH HERESY REPORT TO ADMUNS NOW!!! Although to be honest if you see this it is probably an admin's fault..."
	icon = 'icons/obj/machines/gunrack.dmi'
	icon_state = "heresy"
	anchored = 1
	var/base_icon = null
	var/list/contained = list()
	var/capacity = 4
	var/holds_type = null
	var/holds_name = ""
	var/full = 0

/obj/machinery/rack/New()
	..()
	if(full)
		for(var/iteration = 1, iteration<=capacity, iteration++)
			var/obj/item/I = new holds_type(src)
			I.loc = src
			contained.Add(I)
		updateicon()

/obj/machinery/rack/proc/updateicon()
	icon_state = "[base_icon]_[contained.len]"

/obj/machinery/rack/examine()
	set src in oview(5)
	..()
	usr << "There's [contained.len ? "a" : "no"] [holds_name]s on the rack."

/obj/machinery/rack/attackby(obj/item/weapon/W, mob/user)

	if(istype(W, holds_type) && anchored)
		if(contained.len >= capacity)
			user << "<span class='danger'>This rack seems full.</span>"
			return
		else
			var/area/a = loc.loc // Gets our locations location, like a dream within a dream
			if(!isarea(a))
				return
			user.drop_item()
			contained.Add(W)
			W.loc = src
			user.visible_message("<span class='notice'>[user] puts the [holds_name] on the rack.</span>", "<span class='notice'>You place the [holds_name] on the rack.</span>")
			updateicon()
	else if(istype(W, /obj/item/weapon/wrench))
		anchored = !anchored
		user << "<span class='notice'>You [anchored ? "attach" : "detach"] [src.name] [anchored ? "to" : "from"] the ground</span>"
		playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)

/obj/machinery/rack/proc/getitem()
	for(var/obj/item/I in contained)
		I.loc = get_turf(src)
		contained.Remove(I)
		break
	updateicon()

/obj/machinery/rack/attack_hand(mob/user)
	if(contained.len <= 0)
		user << "<span class='notice'>Nope- it is empty.</span>"
		return
	user.visible_message("<span class='notice'>[user] removes the [holds_name] from the rack.</span>", "<span class='notice'>You remove the [holds_name] from the rack.</span>")
	getitem()

/obj/machinery/rack/attack_tk(mob/user)
	if(contained.len <= 0)
		return
	user << "<span class='notice'>You telekinetically remove the [holds_name] from the rack.</span>"
	getitem()

/obj/machinery/rack/expinovite
	name = "Expinovite Injector rack"
	desc = "It can hold four injectors."
	icon_state = "sr_0"
	holds_type = /obj/item/weapon/reagent_containers/hypospray/revival
	holds_name = "injector"
	base_icon = "sr"

/obj/machinery/rack/expinovite/full
	icon_state = "sr_4"
	full = 1

/obj/machinery/rack/lasgun
	name = "Lasrifle rack"
	desc = "It can hold four Lasrifles."
	icon_state = "gr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/lasgun
	holds_name = "lasgun"
	base_icon = "gr"

/obj/machinery/rack/lasgun/full
	icon_state = "gr_4"
	full = 1

/obj/machinery/rack/lasgunkreig
	name = "Lucious Pattern Lasrifle rack"
	icon_state = "lgr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/lasgunkreig
	base_icon = "lgr"

/obj/machinery/rack/lasgunkreig/full
	icon_state = "lgr_4"
	full = 1

/obj/machinery/rack/pistol
	name = "Laspistol rack"
	desc = "It can hold four Laspistol."
	icon_state = "pr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/laspistol
	holds_name = "laspistol"
	base_icon = "pr"

/obj/machinery/rack/pistol/full
	icon_state = "pr_4"
	full = 1

/obj/machinery/rack/longlas
	name = "Longlas rack"
	desc = "It can hold four longlas."
	icon_state = "llr_0"
	holds_type = /obj/item/weapon/gun/energy/longlas
	holds_name = "longlas"
	base_icon = "llr"
	capacity = 3

/obj/machinery/rack/longlas/full
	icon_state = "llr_3"
	full = 1

/obj/machinery/rack/hellgun
	name = "Hellgun rack"
	desc = "It can hold four Hellguns."
	icon_state = "hgr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/hellgun
	holds_name = "hellgun"
	base_icon = "hgr"

/obj/machinery/rack/hellgun/full
	icon_state = "hgr_4"
	full = 1

/obj/machinery/rack/hellpistol
	name = "Hellpistol rack"
	desc = "It can hold three hellpistols."
	icon_state = "hpr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/hellpistol
	holds_name = "hellpistol"
	base_icon = "hpr"
	capacity = 3

/obj/machinery/rack/hellpistol/full
	icon_state = "hpr_3"
	full = 1

/obj/machinery/rack/combatknife
	name = "combat knife rack"
	desc = "It can hold four combat knives."
	icon_state = "ckr_0"
	holds_type = /obj/item/weapon/complexknife/combatknife
	holds_name = "combat knife"
	base_icon = "ckr"

/obj/machinery/rack/combatknife/full
	icon_state = "ckr_4"
	full = 1

/obj/machinery/rack/guardsword
	name = "sword rack"
	desc = "It can hold six guardsman's swords."
	icon_state = "swr_0"
	holds_type = /obj/item/weapon/complexsword/IGsword
	holds_name = "sword"
	base_icon = "swr"
	capacity = 6

/obj/machinery/rack/guardsword/full
	icon_state = "swr_6"
	full = 1

/obj/machinery/rack/chainsword
	name = "chainsword rack"
	desc = "It can hold two mercy chainswords."
	icon_state = "chsr_0"
	holds_type = /obj/item/weapon/twohanded/chainswordig
	holds_name = "chainsword"
	base_icon = "chsr"
	capacity = 2

/obj/machinery/rack/chainsword/full
	icon_state = "chsr_2"
	full = 1

/obj/machinery/rack/chainsword2
	name = "chainsword rack"
	desc = "It can hold two chainswords."
	icon_state = "chsr2_0"
	holds_type = /obj/item/weapon/chainsword/generic_chainsword
	holds_name = "chainsword"
	base_icon = "chsr2"
	capacity = 2

/obj/machinery/rack/chainsword2/full
	icon_state = "chsr2_2"
	full = 1

/obj/machinery/rack/powersword
	name = "power sword rack"
	desc = "It can hold two munitorium pattern power swords."
	icon_state = "psr_0"
	holds_type = /obj/item/weapon/powersword/munitorium
	holds_name = "power sword"
	base_icon = "psr"
	capacity = 2

/obj/machinery/rack/powersword/full
	icon_state = "psr_2"
	full = 1

/obj/machinery/rack/bolter
	name = "bolter rack"
	desc = "It can hold two bolters."
	icon_state = "bltr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/bolter
	holds_name = "bolter"
	base_icon = "bltr"
	capacity = 2

/obj/machinery/rack/bolter/full
	icon_state = "bltr_2"
	full = 1

/obj/machinery/rack/autogun
	name = "Autogun rack"
	desc = "It can hold four Autoguns."
	icon_state = "agr_0"
	holds_type = /obj/item/weapon/gun/projectile/automatic/autogun2
	holds_name = "autogun"
	base_icon = "agr"

/obj/machinery/rack/autogun/full
	icon_state = "agr_4"
	full = 1

/obj/machinery/rack/shield
	name = "Shield rack"
	desc = "It can hold five shields."
	icon_state = "shr_0"
	holds_type = /obj/item/weapon/shield/riot/imperial
	holds_name = "shield"
	base_icon = "shr"
	capacity = 5

/obj/machinery/rack/shield/full
	icon_state = "shr_5"
	full = 1

/obj/machinery/rack/ration
	name = "Imperial Rations"
	desc = "It can hold twelve rations."
	icon_state = "rr_0"
	holds_type = /obj/item/weapon/reagent_containers/food/snacks/ration
	holds_name = "imperial ration"
	base_icon = "rr"
	capacity = 12

/obj/machinery/rack/ration/full
	icon_state = "rr_12"
	full = 1

/obj/machinery/rack/frags
	name = "Frag Grenades"
	desc = "It can hold three boxes of frag grenades."
	icon_state = "boxr_0"
	holds_type = /obj/item/weapon/storage/box/imperialgrenades
	holds_name = "box"
	base_icon = "boxr"
	capacity = 3

/obj/machinery/rack/frags/full
	icon_state = "boxr_3"
	full = 1

/obj/machinery/rack/kraks
	name = "Krak Grenades"
	desc = "It can hold three boxes of krak grenades."
	icon_state = "boxr_0"
	holds_type = /obj/item/weapon/storage/box/krakgrenades
	holds_name = "box"
	base_icon = "boxr"
	capacity = 3

/obj/machinery/rack/kraks/full
	icon_state = "boxr_3"
	full = 1

/obj/machinery/rack/firstaid
	name = "Medi-Packs"
	desc = "It can hold four medi-packs."
	icon_state = "medr_0"
	holds_type = /obj/item/weapon/storage/firstaid/impguard
	holds_name = "medi-pack"
	base_icon = "medr"
	capacity = 4

/obj/machinery/rack/firstaid/full
	icon_state = "medr_4"
	full = 1

/obj/machinery/rack/firstaid2
	name = "Tactical Medi-Packs"
	desc = "It can hold four medi-packs."
	icon_state = "medr_0"
	holds_type = /obj/item/weapon/storage/firstaid/advanced
	holds_name = "medi-pack"
	base_icon = "medr"
	capacity = 4

/obj/machinery/rack/firstaid2/full
	icon_state = "medr_4"
	full = 1