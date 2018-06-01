/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet

/obj/item/ammo_casing/a50
	desc = "A .50AE bullet casing."
	caliber = ".50"
	projectile_type = /obj/item/projectile/bullet

/obj/item/ammo_casing/a418
	desc = "A .418 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/suffocationbullet

/obj/item/ammo_casing/a666
	desc = "A .666 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/cyanideround


/obj/item/ammo_casing/c38
	desc = "A .38 bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/weakbullet2


/obj/item/ammo_casing/c10mm
	desc = "A 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/midbullet3

/obj/item/ammo_casing/c12mm
	desc = "A 12mm bullet casing."
	caliber = "12mm"
	projectile_type = /obj/item/projectile/bullet/midbullet3/heavy

/obj/item/ammo_casing/c11mm
	desc = "A strange bullet casing."
	caliber = "11mm"
	projectile_type = /obj/item/projectile/bullet/shootabullet


/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/weakbullet3


/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/midbullet

/obj/item/ammo_casing/c100
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/midbullet2

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "blshell"
	caliber = "shotgun"
	projectile_type = /obj/item/projectile/bullet
	m_amt = 6500

/obj/item/ammo_casing/voxlegis
	name = "heavy slug"
	desc = "A 12 gauge slug."
	icon_state = "blshell"
	caliber = "shotgun"
	projectile_type = /obj/item/projectile/bullet/voxlegis
	m_amt = 6500

/obj/item/ammo_casing/shotgun/buckshot
	name = "shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet
	pellets = 8
	variance = 0.8

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A weak beanbag shell."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	m_amt = 250

/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A stunning shell."
	icon_state = "stunshell"
	projectile_type = /obj/item/projectile/bullet/stunshot
	m_amt = 200

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary shell"
	desc = "An incendiary shell"
	icon_state = "ishell"
	projectile_type = /obj/item/projectile/bullet/incendiary/mech

/obj/item/ammo_casing/shotgun/dart
	name = "shotgun dart"
	desc = "A dart for use in shotguns. Can be injected with up to 30 units of any chemical."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/dart

/obj/item/ammo_casing/shotgun/dart/New()
	..()
	flags |= NOREACT
	flags |= OPENCONTAINER
	create_reagents(30)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/makeshift
	name = "makeshift shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "homebrewshell"
	projectile_type = /obj/item/projectile/bullet/pellet
	pellets = 10
	variance = 0.6

/obj/item/ammo_casing/shotgun/makeshift/slug
	name = "makeshift shotgun slug"
	desc = "A 12 gauge slug."
	projectile_type = /obj/item/projectile/bullet
	variance = 0.1

/obj/item/ammo_casing/shotgun/makeshift/promethium
	name = "promethium slug"
	desc = "A 12 gauge promethium slug."
	projectile_type = /obj/item/projectile/bullet/promethium
	variance = 0.1

/obj/item/ammo_casing/shotgun/makeshift/promethium2
	name = "promethium shot"
	desc = "A wide bore promethium shot."
	projectile_type = /obj/item/projectile/bullet/fire
	pellets = 12
	variance = 0.75

/obj/item/ammo_casing/shotgun/makeshift/overcharge
	name = "fragmentation shell"
	desc = "A 12 gauge frag shell."
	projectile_type = /obj/item/projectile/bullet/shrapnel
	pellets = 20
	variance = 1.3 //Not very accurate at all, but a ton of shrapnel.

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet

/obj/item/ammo_casing/stubber
	desc = "A stubber bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/midbullet3

/obj/item/ammo_casing/stubber/heavy
	desc = "A heavy stubber bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/midbullet3
	projectiles_per_shot = 3
	variance = 0.1

/obj/item/ammo_casing/caseless
	desc = "A caseless bullet casing."


/obj/item/ammo_casing/caseless/fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, params, var/distro, var/quiet)
	if (..())
		loc = null
		return 1
	else
		return 0


/obj/item/ammo_casing/caseless/a75
	desc = "A .75 bullet casing."
	caliber = "75"
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/caseless/a74
	desc = "A .75 bullet casing."
	caliber = "75"
	projectile_type = /obj/item/projectile/bullet/slug

/obj/item/ammo_casing/lasgun
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	caliber = "laser"
	projectile_type = /obj/item/projectile/bullet/lasgun

/obj/item/ammo_casing/stutterlas
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	caliber = "laser"
	projectile_type = /obj/item/projectile/beam
	projectiles_per_shot = 6
	variance = 0.8
	fire_delay = 2

/obj/item/ammo_casing/lascannon
	desc = "ERMAHGAWD IF YOU SEES THIS REPORT TO ADMOON!"
	caliber = "laser"
	projectile_type = /obj/item/projectile/beam/lascannon

/obj/item/ammo_casing/needler
	desc = "A spent needler shell."
	caliber = "needler"
	name = "needle casing"
	icon_state = "needle"
	projectile_type = /obj/item/projectile/bullet/needler

/obj/item/ammo_casing/autogun
	desc = "A spent autogun shell."
	caliber = "autogun"
	name = "autogun casing"
	icon_state = "s-casing"
	projectile_type = /obj/item/projectile/bullet/autogun
	fire_delay = 2

/obj/item/ammo_casing/exitus
	desc = "An exitus bullet casing."
	caliber = "exitus"
	icon_state = "heavyshell"
	projectile_type = /obj/item/projectile/bullet/exitus

/obj/item/ammo_casing/exitus/enforcement
	projectile_type = /obj/item/projectile/bullet/exitus/enforcement
	caliber = "enforcement"
	var/ckey = ""
	var/reason = ""
	var/time = 0

/obj/item/ammo_casing/exitus/enforcement/ready_proj(atom/target as mob|obj|turf, mob/living/user, var/quiet)
	..()
	var/obj/item/projectile/bullet/exitus/enforcement/exitusbullet = BB
	if(exitusbullet)
		exitusbullet.ckey = src.ckey
		exitusbullet.reason = src.reason
		exitusbullet.minutes = src.time

/obj/item/ammo_casing/ruslaser
	name = "laser casing"
	desc = "A laser casing for a russian laser revolver."
	caliber = "laser"
	projectile_type = /obj/item/projectile/bullet/lasgun

/obj/item/ammo_casing/caseless/flare
	desc = "It's a flare shell."
	caliber = "flare"
	icon_state = "ishell"
	projectile_type = /obj/item/projectile/bullet/flare

/obj/item/ammo_casing/caseless/inferno
	desc = "A .75 bullet casing."
	caliber = "75"
	projectile_type = /obj/item/projectile/bullet/inferno
