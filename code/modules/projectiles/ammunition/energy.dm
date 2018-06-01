/obj/item/ammo_casing/energy
	name = "energy weapon lens"
	desc = "The part of the gun that makes the laser go pew"
	caliber = "energy"
	projectile_type = /obj/item/projectile/energy
	trace_residue = null	//energy weapons leave no trace! :o
	var/e_cost = 100 //The amount of energy a cell needs to expend to create this shot.
	var/select_name = "energy"
	var/mod_name = null
	var/fire_sound = 'sound/weapons/Laser.ogg'

/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/item/projectile/beam
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/item/projectile/beam
	e_cost = 83
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/practice
	projectile_type = /obj/item/projectile/practice
	select_name = "practice"

/obj/item/ammo_casing/energy/laser/scatter
	projectile_type = /obj/item/projectile/beam/scatter
	pellets = 5
	variance = 0.8
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/heavy
	projectile_type = /obj/item/projectile/beam/heavylaser
	select_name = "anti-vehicle"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/ammo_casing/energy/laser/pulse
	projectile_type = /obj/item/projectile/beam/pulse
	e_cost = 1
	select_name = "DESTROY"
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/ammo_casing/energy/laser/pulse2
	projectile_type = /obj/item/projectile/beam/pulse2
	e_cost = 1
	select_name = "DESTROY"
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/ammo_casing/energy/laser/bluetag
	projectile_type = /obj/item/projectile/lasertag/bluetag
	select_name = "bluetag"

/obj/item/ammo_casing/energy/laser/redtag
	projectile_type = /obj/item/projectile/lasertag/redtag
	select_name = "redtag"

/obj/item/ammo_casing/energy/bolt
	projectile_type = /obj/item/projectile/energy/bolt
	select_name = "bolt"
	fire_sound = 'sound/weapons/Genhit.ogg'

/obj/item/ammo_casing/energy/bolt/large
	projectile_type = /obj/item/projectile/energy/bolt/large
	select_name = "heavy bolt"

/obj/item/ammo_casing/energy/xray
	projectile_type = /obj/item/projectile/beam/xray
	e_cost = 50
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/electrode
	projectile_type = /obj/item/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'sound/weapons/taser.ogg'

/obj/item/ammo_casing/energy/electrode/gun
	fire_sound = 'sound/weapons/gunshot.ogg'

/obj/item/ammo_casing/energy/ion
	projectile_type = /obj/item/projectile/ion
	select_name = "ion"
	fire_sound = 'sound/weapons/Laser.ogg'

/obj/item/ammo_casing/energy/declone
	projectile_type = /obj/item/projectile/energy/declone
	select_name = "declone"
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/mindflayer
	projectile_type = /obj/item/projectile/beam/mindflayer
	select_name = "MINDFUCK"
	fire_sound = 'sound/weapons/Genhit.ogg'

/obj/item/ammo_casing/energy/flora
	fire_sound = 'sound/effects/stealthoff.ogg'

/obj/item/ammo_casing/energy/flora/yield
	projectile_type = /obj/item/projectile/energy/florayield
	select_name = "increase yield"
	mod_name = "yield"

/obj/item/ammo_casing/energy/flora/mut
	projectile_type = /obj/item/projectile/energy/floramut
	select_name = "induce mutations"
	mod_name = "mut"

/obj/item/ammo_casing/energy/temp
	projectile_type = /obj/item/projectile/temp
	select_name = "freeze"
	e_cost = 250
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/temp/hot
	projectile_type = /obj/item/projectile/temp/hot
	select_name = "bake"

/obj/item/ammo_casing/energy/meteor
	projectile_type = /obj/item/projectile/meteor
	select_name = "goddamn meteor"

/obj/item/ammo_casing/energy/kinetic
	projectile_type = /obj/item/projectile/kinetic
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/Gunshot4.ogg'

/obj/item/ammo_casing/energy/disabler
	projectile_type = /obj/item/projectile/energy/disabler
	select_name  = "disable"
	e_cost = 50
	fire_sound = "sound/weapons/taser.ogg"

/obj/item/ammo_casing/lasgun
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	caliber = "laser"
	projectile_type = /obj/item/projectile/beam

/obj/item/ammo_casing/hellgun
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	caliber = "laser"
	projectile_type = /obj/item/projectile/beam/hellbeam

/obj/item/ammo_casing/energy/plasma
	projectile_type = /obj/item/projectile/energy/plasma
	select_name = "plasma round"
	fire_sound = 'sound/weapons/plasma.ogg'

/obj/item/ammo_casing/energy/plasmarifle
	projectile_type = /obj/item/projectile/energy/heavyplasma
	variance = 0.88
	select_name = "heavy plasma round"
	fire_sound = 'sound/weapons/plasma.ogg'

/obj/item/ammo_casing/energy/plasmaburst
	projectile_type = /obj/item/projectile/energy/heavyplasma
	variance = 0.7
	pellets = 4
	select_name = "plasma burst"
	fire_sound = 'sound/weapons/plasma.ogg'

/obj/item/ammo_casing/energy/bolter //Exclusively for the cyborg bolter.
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	projectile_type = /obj/item/projectile/bullet/gyro
	select_name = "bolter"
	fire_sound = 'sound/weapons/Gunshot_bolter.ogg'

/obj/item/ammo_casing/energy/tester
	projectile_type = /obj/item/projectile/energy/test
	select_name = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	fire_sound = 'sound/weapons/Laser.ogg'
	e_cost = 1

/obj/item/ammo_casing/energy/laser/scattertest
	projectile_type = /obj/item/projectile/energy/test
	pellets = 5
	variance = 0.8
	select_name = "scatter"
	e_cost = 1