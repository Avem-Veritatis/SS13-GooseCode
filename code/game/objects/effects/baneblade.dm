/*
A very small start to this.
Will need sprites and such.
*/

/obj/effect/fake_floor/baneblade
	name = "baneblade"
	desc = "A reinforced floor."
	icon_state = "engine"
	var/health = 15

/obj/effect/fake_floor/baneblade/ex_act(force)
	if(health >= 0)
		health -= force
	else
		..(1)

/obj/effect/fake_floor/fake_wall/r_wall/baneblade //TODO: Make necron NPCs fire on these walls.
	name = "baneblade"
	desc = "Looks sturdy."
	icon_state = "armor0"
	base_icon_state = "armor"
	explosion_recursions = 60 //Explosions don't get past this until it is actually blown up.
	var/health = 30

/obj/effect/fake_floor/fake_wall/r_wall/baneblade/ex_act(exforce)
	var/force = 6-exforce
	if(health > 0)
		health -= force
		if(health <= 15)
			src.overlays += image('icons/turf/walls.dmi', "armordamage")
	else
		for(var/obj/structure/banebladecannon/BC in range(0, src))
			qdel(BC)
		for(var/obj/structure/banebolter/BB in range(0, src))
			qdel(BB)
		..(1)

/obj/effect/fake_floor/fake_wall/r_wall/baneblade/thermitemelt(mob/user as mob)
	health -= 5
	if(health <= 15)
		src.overlays += image('icons/turf/walls.dmi', "armordamage")
	return

/obj/effect/fake_floor/fake_wall/r_wall/baneblade/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/weldingtool/))
		if(src.health < 20)
			var/obj/item/weapon/weldingtool/WT = W
			if(WT.remove_fuel(0,user))
				user << "\red You attempt to repair some of the damage to the armor."
				if(prob(20))
					health += 1
					if(health > 15)
						src.overlays.Cut()
		else
			user << "\red The armor is undamaged."
	else
		return attack_hand(user)

/obj/effect/fake_floor/fake_wall/r_wall/baneblade/slit
	name = "Shooting Slot"
	opacity = 0
	icon_state = "sarmor0"
	base_icon_state = "sarmor"

/obj/effect/fake_floor/fake_wall/r_wall/baneblade/slit/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/item/projectile))
		if(get_dir(loc, get_turf(mover)) == dir)
			return 1
	return 0

/obj/item/device/baneblade_jaunter
	name = "Baneblade Warp Teleporter"
	desc = "A single use device to send people to a baneblade that was deployed."
	icon = 'icons/obj/items.dmi'
	icon_state = "Jaunter"
	item_state = "electronic"
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 5
	origin_tech = "bluespace=2"

/obj/item/device/baneblade_jaunter/attack_self(mob/user as mob)
	if(prob(2))
		user << "<span class='notice'>You're having difficulties getting the [src.name] to work.</span>"
		return
	else
		user.visible_message("<span class='notice'>[user.name] activates the [src.name]!</span>")
		var/list/L = list()
		for(var/obj/mecha/combat/baneblade/B in world)
			L += B
		if(!L.len)
			user << "<span class='notice'>The [src.name] failed to create a tunnel. Maybe the baneblade was destroyed?</span>"
			return
		var/chosen_beacon = pick(L)
		var/obj/effect/portal/wormhole/jaunt_tunnel/J = new /obj/effect/portal/wormhole/jaunt_tunnel(get_turf(src))
		J.target = chosen_beacon
		try_move_adjacent(J)
		playsound(src,'sound/effects/sparks4.ogg',50,1)
		qdel(src)