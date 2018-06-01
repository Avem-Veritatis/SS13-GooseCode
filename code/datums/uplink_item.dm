var/list/uplink_items = list()

/proc/get_uplink_items()
	// If not already initialized..
	if(!uplink_items.len)

		// Fill in the list	and order it like this:
		// A keyed list, acting as categories, which are lists to the datum.

		var/list/last = list()
		for(var/item in typesof(/datum/uplink_item))

			var/datum/uplink_item/I = new item()
			if(!I.item)
				continue
			if(I.gamemodes.len && ticker && !(ticker.mode.type in I.gamemodes))
				continue
			if(I.excludefrom.len && ticker && (ticker.mode.type in I.excludefrom))
				continue
			if(I.last)
				last += I
				continue

			if(!uplink_items[I.category])
				uplink_items[I.category] = list()

			uplink_items[I.category] += I

		for(var/datum/uplink_item/I in last)

			if(!uplink_items[I.category])
				uplink_items[I.category] = list()

			uplink_items[I.category] += I

	return uplink_items

// You can change the order of the list by putting datums before/after one another OR
// you can use the last variable to make sure it appears last, well have the category appear last.

/datum/uplink_item
	var/name = "item name"
	var/category = "item category"
	var/desc = "item description"
	var/item = null
	var/cost = 0
	var/last = 0 // Appear last
	var/list/gamemodes = list() // Empty list means it is in all the gamemodes. Otherwise place the gamemode name here.
	var/list/excludefrom = list()//Empty list does nothing. Place the name of gamemode you don't want this item to be available in here. This is so you dont have to list EVERY mode to exclude something.

/datum/uplink_item/proc/spawn_item(var/turf/loc, var/obj/item/device/uplink/U)
	if(item)
		U.uses -= max(cost, 0)
		U.used_TC += cost
		feedback_add_details("traitor_uplink_items_bought", "[item]")
		return new item(loc)

/datum/uplink_item/proc/buy(var/obj/item/device/uplink/U, var/mob/user)

	..()
	if(!istype(U))
		return 0

	if (!user || user.stat || user.restrained())
		return 0

	if (!( istype(user, /mob/living/carbon/human)))
		return 0

	// If the uplink's holder is in the user's contents
	if ((U.loc in user.contents || (in_range(U.loc, user) && istype(U.loc.loc, /turf))))
		user.set_machine(U)
		if(cost > U.uses)
			return 0

		var/obj/I = spawn_item(get_turf(user), U)

		if(istype(I, /obj/item) && ishuman(user))
			var/mob/living/carbon/human/A = user
			A.put_in_any_hand_if_possible(I)

			if(istype(I,/obj/item/weapon/storage/box/) && I.contents.len>0)
				for(var/atom/o in I)
					U.purchase_log += "<BIG>\icon[o]</BIG>"
			else
				U.purchase_log += "<BIG>\icon[I]</BIG>"

		U.interact(user)
		return 1
	return 0

/*
//
//	UPLINK ITEMS
//
*/
// KHORNE

/datum/uplink_item/khorne
	category = "Faithful of Khorne"

/datum/uplink_item/khorne/sword2
	name = "Sword of Khorne"
	desc = "The energy sword is an edged weapon with a.... BLOOD FOR THE BLOOD GOD!!!"
	item = /obj/item/weapon/melee/energy/sword/kb
	cost = 3

/*datum/uplink_item/khorne/sword3
	name = "Sacrificial sword"
	desc = "Allows you to summon a minion of Khorne. (must be ghosts to accept the call)"
	item = /obj/item/weapon/melee/kbsword
	cost = 4*/

/datum/uplink_item/khorne/syndicate_minibomb
	name = "Blood Pact Grenade"
	desc = "The blood pact greande is a powerful handheld bomb. It can be thrown with a five second fuse, or loaded into a missile launcher."
	item = /obj/item/weapon/grenade/syndieminibomb
	cost = 3

/datum/uplink_item/khorne/butcher
	name = "Butcher's Nails Implant"
	desc = "An implant that makes the subject enter a berserk fury, turning them into a deadly combatant and forcing them to attack nearby people. Be careful, because if you use this on another person, they will consider you a target."
	item = /obj/item/weapon/implanter/butcher
	cost = 10

/datum/uplink_item/khorne/bolter
	name = "Chaos Bolter"
	desc = "A full sized chaos bolter."
	item = /obj/item/weapon/gun/projectile/automatic/bolter/chaos
	cost = 6

/datum/uplink_item/khorne/pistol
	name = "Stubber Pistol"
	desc = "A small, easily concealable handgun that uses 8-round 10mm magazines and is compatible with silencers."
	item = /obj/item/weapon/gun/projectile/automatic/pistol
	cost = 4

/datum/uplink_item/khorne/plasmagrenade
	name = "Plasma Grenade"
	desc = "An exceedingly powerful grenade. Throw it and run like hell. Leaves a small core of plasma in the epicenter of the blast."
	item = /obj/item/weapon/grenade/plasma
	cost = 7

/datum/uplink_item/khorne/plasmamissile
	name = "Plasma Missile"
	desc = "An exceedingly powerful missile. Launch it and run like hell. Leaves a small core of plasma in the epicenter of the blast."
	item = /obj/item/weapon/plasmisslea
	cost = 7

/datum/uplink_item/khorne/smg
	name = "Submachine Gun"
	desc = "A fully-loaded Scarborough Arms-developed submachine gun that uses 20-round .45 ACP magazines and is compatible with silencers."
	item = /obj/item/weapon/gun/projectile/automatic/c20r
	cost = 5
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/khorne/machinegun
	name = "Heavy Stubber"
	desc = "A traditionally constructed machine gun made by AA-2531. This deadly weapon has a massive 50-round magazine of 7.62x51mm ammunition."
	item = /obj/item/weapon/gun/projectile/automatic/l6_saw
	cost = 7
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/khorne/syndicate_bomb
	name = "Explosive Charge"
	desc = "This bomb has an adjustable timer with a minimum setting of 60 seconds. Ordering the bomb sends you a small beacon, which will teleport the explosive to your location when you activate it. \
	You can wrench the bomb down to prevent removal. The crew may attempt to defuse the bomb."
	item = /obj/item/device/sbeacondrop/bomb
	cost = 5
	excludefrom = list(/datum/game_mode/traitor/double_agents)

/datum/uplink_item/khorne/syndicate_detonator
	name = "Explosive Charge Detonator"
	desc = "The Syndicate Detonator is a companion device to the Explosive Charge. Simply press the included button and an encrypted radio frequency will instruct all live syndicate bombs to detonate. \
	Useful for when speed matters or you wish to synchronize multiple bomb blasts. Be sure to stand clear of the blast radius before using the detonator."
	item = /obj/item/device/syndicatedetonator
	cost = 1
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/khorne/promethium
	name = "Promethium Charge"
	desc = "A small charge that can be primed and placed next to walls to melt through them."
	item = /obj/item/weapon/grenade/chem_grenade/mini/promethium
	cost = 1

// Slaanesh

/datum/uplink_item/slaanesh
	category = "Faithful of Slaanesh"

/datum/uplink_item/slaanesh/sword3
	name = "Sword of Slaanesh"
	desc = "The energy sword is sexy... very sexy..."
	item = /obj/item/weapon/melee/energy/sword/sb
	cost = 3

/datum/uplink_item/slaanesh/eldarpistol
	name = "An Eldar Shuriken Pistol"
	desc = "A small pistol used by both Eldar and Dark Eldar alike. Small enough to fit into a pocket or slip into a bag unnoticed. It fires bolts tipped with toxins collected from a rare organism. \
	Its bolts also stun enemies for short periods, and replenish automatically."
	item = /obj/item/weapon/gun/energy/eldarpistol
	cost = 5
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/slaanesh/needlepistol
	name = "Needler Pistol"
	desc = "A small silenced pistol that fires poisoned darts encased in lasers. Has an eighteen round magazine."
	item = /obj/item/weapon/gun/projectile/automatic/needler
	cost = 5
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/slaanesh/drugbag
	name = "Dice Bag"
	desc = "A small dice bag full of mystery pills. Some are powerful stimulants, others healing pills, and others still powerful poisons."
	item = /obj/item/weapon/storage/pill_bottle/drug
	cost = 3
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/slaanesh/soap
	name = "Slaaneshi Soap"
	desc = "A sinister-looking surfactant used to clean blood stains to hide murders and prevent DNA analysis. You can also drop it underfoot to slip people."
	item = /obj/item/weapon/soap/syndie
	cost = 1

/datum/uplink_item/slaanesh/para_pen
	name = "Paralysis Pen"
	desc = "A syringe disguised as a functional pen, filled with a neuromuscular-blocking drug that renders a target immobile on injection and makes them seem dead to observers. \
	Side effects of the drug include noticeable drooling. The pen holds one dose of paralyzing agent, and cannot be refilled."
	item = /obj/item/weapon/pen/paralysis
	cost = 4
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/slaanesh/plastic_explosives
	name = "Composition C-4"
	desc = "C-4 is plastic explosive of the common variety Composition C. You can use it to breach walls, attach it to organisms to destroy them, or connect a signaler to its wiring to make it remotely detonable. \
	It has a modifiable timer with a minimum setting of 10 seconds."
	item = /obj/item/weapon/plastique
	cost = 1

/datum/uplink_item/slaanesh/freedom
	name = "Freedom Implant"
	desc = "An implant injected into the body and later activated using a bodily gesture to attempt to slip restraints."
	item = /obj/item/weapon/storage/box/syndie_kit/imp_freedom
	cost = 3

/datum/uplink_item/slaanesh/uplink
	name = "Uplink Implant"
	desc = "An implant injected into the body, and later activated using a bodily gesture to open an uplink with 5 telecrystals. \
	The ability for an agent to open an uplink after their posessions have been stripped from them makes this implant excellent for escaping confinement."
	item = /obj/item/weapon/storage/box/syndie_kit/imp_uplink
	cost = 7

/datum/uplink_item/slaanesh/adrenal
	name = "Adrenal Implant"
	desc = "An implant injected into the body, and later activated using a bodily gesture to inject a chemical cocktail, which has a mild healing effect along with removing all stuns and increasing his speed."
	item = /obj/item/weapon/storage/box/syndie_kit/imp_adrenal
	cost = 4

/datum/uplink_item/slaanesh/stimpack
	name = "Stimulant Injector"
	desc = "An injector that delivers a cocktail of satrophine and psychon into the subject's system, making them very robust while it is active on them."
	item = /obj/item/weapon/reagent_containers/hypospray/stimpack
	cost = 4

//Nurgle

/datum/uplink_item/nurgle
	category = "Faithful of Nurgle"

/datum/uplink_item/nurgle/sword5
	name = "Sword of Nurgle"
	desc = "The energy sword is here to show Nurgle's love for the emperor's slaves."
	item = /obj/item/weapon/melee/energy/sword/nb
	cost = 3

/datum/uplink_item/nurgle/blight
	name = "Blight Grenade"
	desc = "A grenade that spreads the blessings of nurgle."
	item = /obj/item/weapon/grenade/chem_grenade/plague
	cost = 5

/datum/uplink_item/nurgle/bioterror2
	name = "Plague Rifle"
	desc = "A rifle that shoots extremely biohazardous chemicals and knocks enemies down. Pump action."
	item = /obj/item/weapon/gun/projectile/shotgun/combat/plague
	cost = 10
	gamemodes = list(/datum/game_mode/nuclear)

// Tzeentch

/datum/uplink_item/tzeentch
	category = "Faithful of Tzeentch"

/datum/uplink_item/tzeentch/reportgen
	name = "Single Use Command Signal Duplicator"
	desc = "For creating fake transmissions for the outpost command staff. They will appear to come from Imperial Command. One use only"
	item = /obj/item/device/reportgen
	cost = 1

/datum/uplink_item/tzeentch/sword4
	name = "Sword of Tzeentch"
	desc = "The energy sword is an edged weapon with a blade of pure energy. The sword is small enough to be pocketed when inactive. Activating it produces a loud, distinctive noise."
	item = /obj/item/weapon/melee/energy/sword/tb
	cost = 3

/datum/uplink_item/tzeentch/digital
	name = "Digital Weapon Implant"
	desc = "A rare digital weapon. This one takes the form of an implant and can be concealed very easily. One use only, but when activated it will fire a powerful laser that will seriously injure and knock down an opponent."
	item = /obj/item/weapon/implanter/digital
	cost = 2

/datum/uplink_item/tzeentch/teleport
	name = "Warp Skimmer"
	desc = "Allows a faithful to teleport to fixed locations by skimming the warp."
	item = /obj/item/weapon/warp_skimmer
	cost = 7

/datum/uplink_item/tzeentch/scroll
	name = "Lesser Scroll of Teleportation"
	desc = "A runed scroll that allows a follower of Tzeench to travel to another area through the immaterium. One use ranged teleport."
	item = /obj/item/weapon/teleportation_scroll/apprentice
	cost = 1

/datum/uplink_item/tzeentch/voice_changer
	name = "Mask of Tzeentch"
	item = /obj/item/clothing/mask/gas/voice
	desc = "A conspicuous gas mask that mimics the voice named on your identification card. When no identification is worn, the mask will render your voice unrecognizable."
	cost = 2

/datum/uplink_item/tzeentch/vortex
	name = "Vortex Grenade"
	item = /obj/item/weapon/grenade/vortex
	desc = "A grenade that can rip a hole into the immaterium, sending nearby things into the warp and attracting daemons to the materium."
	cost = 9

/datum/uplink_item/tzeentch/chameleon_jumpsuit
	name = "Chameleon Jumpsuit"
	desc = "A jumpsuit used to imitate the uniforms of outpost staff."
	item = /obj/item/clothing/under/chameleon
	cost = 1

/datum/uplink_item/tzeentch/chameleon_stamp
	name = "Chameleon Stamp"
	desc = "A stamp that can be activated to imitate an official imperial stamp. The disguised stamp will work exactly like the real stamp and will allow you to forge false documents to gain access or equipment; \
	it can also be used in a washing machine to forge clothing."
	item = /obj/item/weapon/stamp/chameleon
	cost = 1

/datum/uplink_item/heretek
	category = "Tech Heresy"

/datum/uplink_item/heretek/detomatix
	name = "Detomatix PDA Cartridge"
	desc = "When inserted into a personal digital assistant, this cartridge gives you five opportunities to detonate PDAs of crewmembers who have their message feature enabled. \
	The concussive effect from the explosion will knock the recipient out for a short period, and deafen them for longer. It has a chance to detonate your PDA."
	item = /obj/item/weapon/cartridge/syndicate
	cost = 2

/datum/uplink_item/heretek/gygax
	name = "Gygax Exosuit"
	desc = "A lightweight exosuit, painted in a dark scheme. Its speed and equipment selection make it excellent for hit-and-run style attacks. \
	This model lacks a method of space propulsion, and therefore it is advised to repair the mothership's teleporter if you wish to make use of it."
	item = /obj/mecha/combat/gygax/dark/loaded
	cost = 15
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/heretek/mauler
	name = "Mauler Exosuit"
	desc = "A massive and incredibly deadly Khornate exosuit. Features long-range targetting, space thrusters, and mounted smoke-screen launchers."
	item = /obj/mecha/combat/marauder/mauler/loaded
	cost = 30
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/heretek/syndieborg
	name = "Heretek's Servitor"
	desc = "A servitor designed for extermination and slaved to chaos. Delivered through a single-use warp teleporter. One would not envy the fate of whoever this servitor used to be before an arch-heretek got hold of them."
	item = /obj/item/weapon/antag_spawner/borg_tele
	cost = 10 //considering the presence of khorne berserks at such low prices, this is now affordable at all times. Also it has equipment that isn't shit.
	//gamemodes = list(/datum/game_mode/nuclear)
//for refunding the syndieborg teleporter
/datum/uplink_item/dangerous/syndieborg/spawn_item()
	var/obj/item/weapon/antag_spawner/borg_tele/T = ..()
	if(istype(T))
		T.TC_cost = cost

/datum/uplink_item/heretek/viscerators
	name = "Viscerator Delivery Grenade"
	desc = "A unique grenade that deploys a swarm of razor-viscerators upon activation, which will chase down and shred any non-operatives in the area."
	item = /obj/item/weapon/grenade/spawnergrenade/manhacks
	cost = 4
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/heretek/emp
	name = "EMP Kit"
	desc = "A box that contains two haywire grenades, an EMP implant and a short ranged recharging device disguised as a flashlight. Useful to disrupt communication and silicon lifeforms."
	item = /obj/item/weapon/storage/box/syndie_kit/emp
	cost = 3

/datum/uplink_item/heretek/agent_card
	name = "Agent Identification card"
	desc = "Agent cards prevent master servitors from tracking the wearer, and can copy access from other identification cards. The access is cumulative, so scanning one card does not erase the access gained from another."
	item = /obj/item/weapon/card/id/syndicate
	cost = 1

/datum/uplink_item/heretek/chameleon_proj
	name = "Chameleon-Projector"
	desc = "Projects an image across a user, disguising them as an object scanned with it, as long as they don't move the projector from their hand. The disguised user cannot run and rojectiles pass over them."
	item = /obj/item/device/chameleon
	cost = 3

/datum/uplink_item/heretek/camera_bug
	name = "Camera Bug"
	desc = "Enables you to bug cameras to view them remotely. Adding particular items to it alters its functions."
	item = /obj/item/device/camera_bug
	cost = 1

/datum/uplink_item/heretek/emag
	name = "Cryptographic Sequencer"
	desc = "The emag is a small card that unlocks hidden functions in electronic devices, subverts intended functions and characteristically breaks security mechanisms."
	item = /obj/item/weapon/card/emag
	cost = 3

/datum/uplink_item/heretek/toolbox
	name = "Full Heretek's Toolbox"
	desc = "The heretek's toolbox is a suspicious black and red. Aside from tools, it comes with cable and a multitool. Insulated gloves are not included."
	item = /obj/item/weapon/storage/toolbox/syndicate
	cost = 1

/datum/uplink_item/heretek/thermal
	name = "Thermal Imaging Glasses"
	desc = "These glasses are thermals disguised as mechanicus optical meson scanners. \
	They allow you to see organisms through walls by capturing the upper portion of the infrared light spectrum, emitted as heat and light by objects. \
	Hotter objects, such as warm bodies and servitors emit more of this light than cooler objects like walls and airlocks."
	item = /obj/item/clothing/glasses/thermal/syndi
	cost = 3

/datum/uplink_item/heretek/binary
	name = "Binary Translator Key"
	desc = "A key, that when inserted into a radio headset, allows you to listen to and talk with servitors in binary. "
	item = /obj/item/device/encryptionkey/binary
	cost = 2

/datum/uplink_item/heretek/ai_detector
	name = "Master Servitor Detector"
	desc = "A functional multitool that turns red when it detects a master servitor watching it or its holder. Knowing when a master servitor is watching you is useful for knowing when to maintain cover. Mind you, the outpost isn't fitted with a master servitor..."
	item = /obj/item/device/multitool/ai_detect
	cost = 1

/datum/uplink_item/heretek/powersink
	name = "Power sink"
	desc = "When screwed to wiring attached to an electric grid, then activated, this large device places excessive load on the grid, causing a stationwide blackout. The sink cannot be carried because of its excessive size. \
	Ordering this sends you a small beacon that will teleport the power sink to your location on activation."
	item = /obj/item/device/powersink
	cost = 5

/datum/uplink_item/heretek/singularity_beacon
	name = "Singularity Beacon"
	desc = "When screwed to wiring attached to an electric grid, then activated, this large device pulls the singularity towards it. \
	Does not work when the singularity is still in containment. A singularity beacon can cause catastrophic damage to a space station, \
	leading to an emergency evacuation. Because of its size, it cannot be carried. Ordering this sends you a small beacon that will teleport the larger beacon to your location on activation."
	item = /obj/item/device/sbeacondrop
	cost = 5 //Slightly cheaper, because singularities are never naturally created.

/datum/uplink_item/heretek/wire_kit_doors
	name = "Airlock Wiring Implant"
	desc = "An implant granting you the knowledge of Non-secure Airlock and Door wire systems"
	item = /obj/item/weapon/storage/box/syndie_kit/imp_wire_door
	cost = 1

// AMMUNITION

/datum/uplink_item/ammo
	category = "Ammunition and Attachments"

/datum/uplink_item/ammo/needler
	name = "Needler Ammunition"
	desc = "A magazine of needler ammunition."
	item = /obj/item/ammo_box/magazine/needlermag
	cost = 1

/datum/uplink_item/ammo/smg
	name = "Ammo-45"
	desc = "A 20-round .45 ACP magazine for use in the C-20r submachine gun."
	item = /obj/item/ammo_box/magazine/c20rm
	cost = 1
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/ammo/pistol
	name = "Stubber Pistol Ammunition"
	desc = "An additional 8-round 10mm magazine for use in the stubber pistol."
	item = /obj/item/ammo_box/magazine/m10mm
	cost = 1

/datum/uplink_item/ammo/machinegun
	name = "Heavy Stubber Ammunition"
	desc = "A 50-round magazine of 7.62�51mm ammunition for use in the heavy stubber. By the time you need to use this, you'll already be on a pile of corpses."
	item = /obj/item/ammo_box/magazine/m762
	cost = 3
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/ammo/silencer
	name = "Silencer"
	desc = "A universal small-arms silencer favored by stealth operatives, this will make shots quieter when equipped onto any low-caliber weapon."
	item = /obj/item/weapon/silencer
	cost = 1

/datum/uplink_item/device_tools
	category = "Support Items"

/datum/uplink_item/device_tools/medkit
	name = "Tactical Medical Supply Kit"
	desc = "The syndicate medkit is a suspicious black and red. Included is a combat stimulant injector for rapid healing, a medical hud for quick identification of injured comrades, \
	and other medical supplies helpful for a medical field operative.."
	item = /obj/item/weapon/storage/firstaid/tactical
	cost = 3
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/device_tools/syndigolashes
	name = "No-Slip Brown Shoes"
	desc = "These allow you to run on wet floors. They do not work on lubricated surfaces."
	item = /obj/item/clothing/shoes/syndigaloshes
	cost = 1

/datum/uplink_item/device_tools/teleporter
	name = "Teleporter Circuit Board"
	desc = "A printed circuit board that completes the teleporter onboard the shuttle. It is advised that you test fire the teleporter before entering it, as malfunctions can occur."
	item = /obj/item/weapon/circuitboard/teleporter
	cost = 20
	gamemodes = list(/datum/game_mode/nuclear)

/datum/uplink_item/device_tools/shield
	name = "Energy Shield"
	desc = "An incredibly useful personal shield projector, capable of reflecting energy projectiles and defending against other attacks."
	item = /obj/item/weapon/shield/energy
	cost = 8
	gamemodes = list(/datum/game_mode/nuclear)

// POINTLESS BADASSERY

/datum/uplink_item/badass
	category = "(Pointless) Badassery"

/datum/uplink_item/badass/bundle
	name = "Heresy Bundle"
	desc = "Heresy Bundles are specialised groups of items that arrive in a plain box. These items are collectively worth more than 10 telecrystals, but you do not know which specialisation you will receive."
	item = /obj/item/weapon/storage/box/syndicate
	cost = 10
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/badass/syndiecards
	name = "Heretical Playing Cards"
	desc = "A special deck of space-grade playing cards with a mono-molecular edge and metal reinforcement, making them slightly more robust than a normal deck of cards. \
	You can also play card games with them."
	item = /obj/item/toy/cards/deck/syndicate
	cost = 1
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/badass/energydrink
	name = "Thunder Cola"
	desc = "A fortifying energy drink produced by Kyner Industries."
	item = /obj/item/weapon/reagent_containers/food/drinks/soda_cans/energydrink
	cost = 1
	excludefrom = list(/datum/game_mode/nuclear)

/datum/uplink_item/badass/balloon
	name = "For showing that you are The HERETIC"
	desc = "A useless red balloon with a chaos rune on it, which can blow the deepest of covers."
	item = /obj/item/toy/syndicateballoon
	cost = 10

/datum/uplink_item/badass/random
	name = "Random Item"
	desc = "Picking this choice will send you a random item from the list. Useful for when you cannot think of a strategy to finish your objectives with."
	item = /obj/item/weapon/storage/box/syndicate
	cost = 0

/datum/uplink_item/badass/random/spawn_item(var/turf/loc, var/obj/item/device/uplink/U)

	var/list/buyable_items = get_uplink_items()
	var/list/possible_items = list()

	for(var/category in buyable_items)
		for(var/datum/uplink_item/I in buyable_items[category])
			if(I == src)
				continue
			if(I.cost > U.uses)
				continue
			possible_items += I

	if(possible_items.len)
		var/datum/uplink_item/I = pick(possible_items)
		U.uses -= max(0, I.cost)
		feedback_add_details("traitor_uplink_items_bought","RN")
		return new I.item(loc)
