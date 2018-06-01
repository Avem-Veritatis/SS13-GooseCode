/obj/structure/cult
	density = 1
	anchored = 1
	icon = 'icons/obj/cult.dmi'

/obj/structure/cult/talisman
	name = "Altar"
	desc = "A bloodstained altar dedicated to Nar-Sie"
	icon_state = "talismanaltar"


/obj/structure/cult/forge
	name = "Daemon forge"
	desc = "A forge used in crafting the unholy weapons used by the armies of Nar-Sie"
	icon_state = "forge"

/obj/structure/cult/pylon
	name = "Pylon"
	desc = "You must construct additional pylons!"
	icon_state = "pylon"
	luminosity = 5

/obj/structure/cult/tome
	name = "Desk"
	desc = "A desk covered in arcane manuscripts and tomes in unknown languages. Looking at the text makes your skin crawl"
	icon_state = "tomealtar"

/obj/effect/gateway
	name = "gateway"
	desc = "You're pretty sure that abyss is staring back"
	icon = 'icons/obj/cult.dmi'
	icon_state = "hole"
	density = 1
	unacidable = 1
	anchored = 1.0
	var/active = 0

/obj/effect/gateway/Bumped(mob/M as mob|obj)
	if(!ismob(M)) return
	if(active)
		var/turf/target
		var/list/L = list()
		for(var/mob/living/carbon/human/H in world)
			if(H == M) continue
			var/turf/T = get_turf(H)
			if(T.z == 1)
				L += T
		if(!L.len) return
		target = pick(L)
		M.visible_message("[M] dissappears into the [src]!")
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.mutate("red eyes")
			H << "\red Exposure to the warp turns your eyes red!"
			H.Paralyse(1)
			H.take_organ_damage(10, 10)
		M.loc = target
		var/obj/effect/effect/harmless_smoke/smoke = new /obj/effect/effect/harmless_smoke(get_turf(M))
		smoke.icon_state = "warpshadow"
		smoke.alpha = 170
		M.visible_message("<b>[M] appears out of thin air!</b>")

/obj/effect/gateway/Crossed(AM as mob|obj)
	src.Bumped(AM)

/obj/effect/gateway/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/kitchenknife/ritual))
		user.visible_message("\red <b>[user] places the [W] into the [src], unlocking it!</b>")
		src.active = 1
		spawn(100)
			src.active = 0