/obj/item/ammo_casing/energy/beamshot/inferno
	name = "inferno generator"
	beam_icon = "inferno"
	cap_icon = "red_laser"
	beam_name = "inferno beam"
	damage = 40
	meltwalls = 1
	damage_type = BURN
	flag = "laser"
	select_name = "inferno shot"
	fire_sound = 'sound/weapons/flamer.ogg'
	flamable = 1
	antivehicle = 1


/obj/item/weapon/gun/energy/inferno
	name = "Inferno Pistol"
	desc = "An inferno pistol. Utilizes melta technology in a portable form."
	icon_state = "inferno"
	item_state = "inferno"
	w_class = 3.0
	m_amt = 2000
	origin_tech = "combat=6;magnets=10"
	ammo_type = list(/obj/item/ammo_casing/energy/beamshot/inferno)
	var/cooldown = 1

/obj/item/weapon/gun/energy/inferno/afterattack()
	if(cooldown)
		..()
		cooldown = 0
		sleep 10
		cooldown = 1
	else
		return


/obj/item/weapon/gun/energy/inferno/update_icon()
	return