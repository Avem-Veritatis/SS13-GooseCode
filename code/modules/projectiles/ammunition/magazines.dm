////////////////INTERNAL MAGAZINES//////////////////////
/obj/item/ammo_box/magazine/internal/cylinder
	name = "revolver cylinder"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/cylinder/ammo_count(var/countempties = 1)
	if (!countempties)
		var/boolets = 0
		for (var/i = 1, i <= stored_ammo.len, i++)
			var/obj/item/ammo_casing/bullet = stored_ammo[i]
			if (bullet.BB)
				boolets++
		return boolets
	else
		return ..()

/obj/item/ammo_box/magazine/internal/cylinder/rus357
	name = "russian revolver cylinder"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 6
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/rus357/New()
	stored_ammo += new ammo_type(src)

/obj/item/ammo_box/magazine/internal/cylinder/ruslaser
	name = "russian laser cylinder"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/ruslaser
	caliber = "laser"
	max_ammo = 6
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/ruslaser/New()
	stored_ammo += new ammo_type(src)

/obj/item/ammo_box/magazine/internal/cylinder/rev38
	name = "d-tiv revolver cylinder"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = "38"
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot
	name = "shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	caliber = "shotgun"
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/makeshift
	name = "shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = null
	caliber = "shotgun"
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/shotcom
	name = "combat shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 8
	multiload = 0

/obj/item/ammo_box/magazine/internal/voxlegi
	name = "vox legi pattern shotgun internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/voxlegis
	caliber = "shotgun"
	max_ammo = 12
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/dualshot
	name = "double-barrel shotgun internal magazine"
	desc = "This doesn't even exist"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	caliber = "shotgun"
	max_ammo = 2
	multiload = 0

///////////EXTERNAL MAGAZINES////////////////
/obj/item/ammo_box/magazine/m9mm
	name = "magazine (9mm)"
	icon_state = "9x19p"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 10
	multiple_sprites = 2
	m_amt = 18750 //5 sheets of metal per magazine in the autolathe

/obj/item/ammo_box/magazine/msmg9mm
	name = "SMG magazine (9mm)"
	icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 20

/obj/item/ammo_box/magazine/msmg9mm/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/m10mm
	name = "magazine (10mm)"
	icon_state = "9x19p"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m12mm
	name = "magazine (12mm)"
	icon_state = "heavypistol"
	origin_tech = "combat=3"
	ammo_type = /obj/item/ammo_casing/c12mm
	caliber = "12mm"
	max_ammo = 12
	multiple_sprites = 2

/obj/item/ammo_box/magazine/sm45
	name = "magazine (.45)"
	icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/sm45/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/uzim45
	name = "Uzi magazine (.45)"
	icon_state = "uzi45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 30

/obj/item/ammo_box/magazine/uzim100
	name = "AutoPistol magazine (.45)"
	icon_state = "uzi45"
	ammo_type = /obj/item/ammo_casing/c100
	caliber = ".45"
	max_ammo = 100

/obj/item/ammo_box/magazine/autogun
	name = "AutoGun magazine"
	icon_state = "autogunmag"
	ammo_type = /obj/item/ammo_casing/autogun
	caliber = "autogun"
	max_ammo = 60

/obj/item/ammo_box/magazine/autogun/drum
	name = "AutoGun Drum"
	icon_state = "a762-0"
	max_ammo = 150

/obj/item/ammo_box/magazine/c20rm
	name = "C-20r magazine (.45)"
	icon_state = "c20rm"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 20

/obj/item/ammo_box/magazine/c20rm/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/tommygunm45
	name = "tommy gun drum (.45)"
	icon_state = "drum45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 50

/obj/item/ammo_box/magazine/m50
	name = "magazine (.50ae)"
	icon_state = "50ae"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/a50
	caliber = ".50"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_box/magazine/m75
	name = "magazine (.75)"
	icon_state = "75"
	ammo_type = /obj/item/ammo_casing/caseless/a75
	caliber = "75"
	multiple_sprites = 2
	max_ammo = 8

/obj/item/ammo_box/magazine/m762
	name = "magazine (7.62mm)"
	icon_state = "a762"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/stubber/heavy
	caliber = "a762"
	max_ammo = 30
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m762/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),10)]"

/obj/item/ammo_box/magazine/boltermag
	name = "Sickle Magazine"
	icon_state = "sicklemag"
	ammo_type = /obj/item/ammo_casing/caseless/a75
	caliber = "75"
	max_ammo = 25
	multiple_sprites = 2

/obj/item/ammo_box/magazine/bpistolmag
	name = "Bolt Pistol Magazine"
	icon_state = "sicklemag"
	ammo_type = /obj/item/ammo_casing/caseless/a75
	caliber = "75"
	max_ammo = 10
	multiple_sprites = 2

/obj/item/ammo_box/magazine/sluggamag
	name = "Sickle Magazine"
	icon_state = "sicklemag"
	ammo_type = /obj/item/ammo_casing/caseless/a74
	caliber = "74"
	max_ammo = 25

/obj/item/ammo_box/magazine/lasgunmag
	name = "Lasgun Mag"
	icon_state = "lasgunmag"
	ammo_type = /obj/item/ammo_casing/lasgun
	caliber = "laser"
	max_ammo = 150

/obj/item/ammo_box/magazine/stutterlas
	name = "Stutter Lasgun Mag"
	icon_state = "lasgunmag"
	ammo_type = /obj/item/ammo_casing/stutterlas
	caliber = "laser"
	max_ammo = 150
	multiple_sprites = 2

/obj/item/ammo_box/magazine/hellgunmag
	name = "Hellgun Magazine"
	icon_state = "lasgunmag"
	ammo_type = /obj/item/ammo_casing/hellgun
	caliber = "laser"
	max_ammo = 25
	multiple_sprites = 2

/obj/item/ammo_box/magazine/laspistolmag
	name = "Laspistol Mag"
	icon_state = "laspistolmag"
	ammo_type = /obj/item/ammo_casing/lasgun
	caliber = "laser"
	max_ammo = 80
	multiple_sprites = 2

/obj/item/ammo_box/magazine/lascannonmag
	name = "Lascannon Power Pack"
	icon_state = "lasgunmag"
	ammo_type = /obj/item/ammo_casing/lascannon
	caliber = "laser"
	max_ammo = 3

/obj/item/ammo_box/magazine/needlermag
	name = "Needler Mag"
	icon_state = "lasgunmag"
	ammo_type = /obj/item/ammo_casing/needler
	caliber = "needler"
	max_ammo = 18

/obj/item/ammo_box/magazine/exitus
	name = "Exitus Piercing Magazine"
	icon_state = "sicklemag"
	ammo_type = /obj/item/ammo_casing/exitus
	caliber = "exitus"
	max_ammo = 6

/obj/item/ammo_box/magazine/exitus/enforcement
	name = "Exitus Judgement Shell"
	icon_state = "heavyshell"
	ammo_type = /obj/item/ammo_casing/exitus/enforcement
	max_ammo = 1
	caliber = "enforcement"

/obj/item/ammo_box/magazine/exitus/enforcement/attack_self()
	for(var/obj/item/ammo_casing/exitus/enforcement/exitus in stored_ammo)
		exitus.ckey = input(usr,"Select a ckey to target","Exitus Configuration","") as text|null
		exitus.reason = input(usr,"Select a reason","Exitus Configuration","") as text|null
		exitus.time = input(usr,"Select a duration (in minutes)","Exitus Configuration",1440) as num|null

/obj/item/ammo_box/magazine/flaremag
	name = "Flares"
	icon_state = "laspistolmag"
	ammo_type = /obj/item/ammo_casing/caseless/flare
	caliber = "flare"
	max_ammo = 10

/obj/item/ammo_box/magazine/boltermag/inf
	name = "Inferno Sickle Magazine"
	icon_state = "sicklemaginf"
	ammo_type = /obj/item/ammo_casing/caseless/inferno
	caliber = "75"
	max_ammo = 25
	multiple_sprites = 2
