/*
Space Hulk Generation Concept
-----------------------------
A basically static turf map with moving turf debree generated around the outskirts.
First floor: Scattered with landmarks that generate large threats in the area, like an insane AI and scattered robots, scattered genestealers and tyranid things, et cetera.
Second floor: Scattered with similar landmarks, but everything including the hardcoded map and the dangers it chooses from has a more obvious association with chaos. Daemons may occur here.
Third floor: Completely hardcoded map scattered with loot drops and randomly spawned daemons. Absurdly dangerous, but full of sealed away artifacts and ritual sites.

Space Hulk Traps / Dangers
--------------------------
Generic:
	Disturbed tubing can rupture and vent plasma at someone.
	Exposed power centers may shock passerby.
	Debree may shift when walked upon.
	Unstable flooring may send someone down to the floor below.
	Damaged teleportation technology may send someone unprotected through the warp and then to somewhere else on the hulk.
	Depressurization of certain locations may violently throw you out into space.
Tyranids:
	Random resin structures and traps convert the epicenter of tyranid presence into an acutal hive, maintained by an NPC hormagaunt.
	Genestealers appear from vents, tackling and dragging victims closer to the hive before disappearing again.
	Ymgarl genestealers awaken from corners of the map when people move near them, starting out quite weak but evolving new powers as they feed on more blood from an explorer.
Robots:
	Defense robots of various sprites scattered around.
	Defense turrets of various sprites and projectiles scattered around.
	Central AI sometimes spawned in a vessel.
	When active cameras are present in the area, airlocks attempt to crush people, lock them in rooms with dangerous things, et cetera.
	Also small chance that if airlocks seal them in a room, will put in toxic smoke, or attempt to violently depressurize the room.
	If there is an AI, it will taunt user over a short range intercomm in the area as it arranges these deaths.
	Such areas are more likely to have archeotech (as opposed to various xenos tech).
Eldar:
	Crazed wraithbone constructs.
	Eldar rune traps. (runes apppear and take effect after they are stepped on)
	Such areas are more likely to have magical eldar artifacts (instead of archeotech and generic xenos tech).
Biohazard:
	Biological experimentation equipment.
	Quite possibly zombies or mutants. Zombies might actually come to life when passed near, unlike most of the corpses that will be found on the hulk.
	Quite possibly contagious disease samples.
Daemons:
	Poltergeist mobs and similar.
	Tormenting mobs that kill slowly but make a big show of it.
	Full daemons that will sometimes extend daemon pacts to people in the area, but will not hesitate to kill people quickly in designated areas.
	An immortal daemon that roams the area. You need to just run when you see it. It will not pursue you very much at all if you try to flee, but you better get running if you see it. Probably a lord of change but I need an acceptable sprite for it.
	Random curses in place. Each chaos area has certain arbitrary "rules" in place by means of these curses. In some areas, spilling another's blood will put a deadly curse on you. In others, failing to routinely perform a ritual will give you bad luck.
	Periodic blackouts where all lights are extinguished and terrifying attackers converge on you without a very bright light and/or other safeguards.
	Reality defying traps like an endless hallway, floors that fade out underneath you leaving you floating in space, pathways that suddenly have you stepping through the warp with only a transparent image of the passage superimposed over it (this often means you can actually step into the warp if you are so reckless, but once you do so the ethereal passage that is the material world will disappear).
	A very high density of cursed objects.
	Such areas are more likely to have chaos artifacts.

Space Hulk Loot / Advantages
----------------------------
Archeotech
	Archeotech devices are possible finds here.
	These include STC designs that are compatible with the RnD machine (as well as something the mechanicus should eventually get).
	These also include rare wh40k guns like grav weapons et cetera.
	This also includes rare chemicals.
	This also includes the combat razor.
	This also includes artifacts similar to necron artifacts but without a full overlap of effects.
	This also includes some miscillaneous melee energy weapons.
	This also includes equipment that with some work can be used by mechanicus members to get better augmentations and such.
Xenos artifacts
	These include generic necron-ish artifacts with differing sprites.
	These also include generic artifact guns with random sprites.
Eldar artifacts
	These include necron style artifacts with more overtly magical effects.
	These also include various staffs.
	These also include eldar power weapons and eldar armor.
	These also include shuriken weapons, soulstones, and wraithbone.
	This also includes the crimson mask, though it will reside in a special part of the map with its own defenses.
Chaos artifacts
	These include daemon weapons.
	These also include various instances of cursed armor, blasphemous texts that can grant small powers if kept, and pages that describe the surrounding area.
	These also include trinkets and talismans that will either bless or curse anyone with the guts to equip. The blessings/curses are minor, but these things will stack.
	This also includes the shadow cloak, though it will reside in a special part of the map with its own defenses.
Rituals
	At certain sites, rituals may be completed. The details of what must be done to complete the rituals are scattered in blasphemous texts.
	The most obvious one is the site for summoning daemons. There are four different rituals to summon daemons of each chaos god. A successful summoning will be difficult, but it can give you an opportunity to strike a daemon pact.
	There is also a site to raise a corpse. This only requires a rare book to complete, but the revival will only last ten minutes before needing to be renewed. This one can also be used to imbue oneself with daemonic power. This gives you severe chaos side effects, and requires daemon essence among other things, but grants huge buffs. This also has an easy ritual to turn somebody into a bruul parasite.
	There is also a site to imbue a weapon with a daemon's essence you have trapped in a spirit stone. This will create a new daemon weapon. This site can also forge extremely powerful weapons/armor and imbue objects with other lesser enchantments. It can even create weapons that harness daemon essence and other rare things for devestating effects. Finally it can create a device that may be used to imbue automata with daemons.
	There is also a room in which ghosts may manifest enough to converse with a visitor.
Tradable salvage
	All the artifacts above, as well as a lot of scraps of ship parts, may be traded as salvage.
	Things you may get for trading include...
		Space gear
		Bright lights
		Imperial weapons
		Mechanical familiars
		Augments
		Warp crystals
		Explosive charges
Ships
	A broken down salvage ship exists out front if you can find parts to repair it. This one can't leave the space hulk with its engines, but is a useful way to get around the place.
	A larger ship that can fly down to the outpost located on the outskirts of the second floor. Minimal repairs are required.
	On the third floor there is a valkyrie you can actually fly down to the outpost. It is fully functional, though hard to get to.
*/

/area/spacehulk
	name = "Space Hulk"
	icon_state = "away"
	ambientsounds = list('sound/hallucinations/behind_you1.ogg','sound/hallucinations/behind_you2.ogg','sound/hallucinations/i_see_you1.ogg','sound/hallucinations/i_see_you2.ogg','sound/hallucinations/im_here1.ogg','sound/hallucinations/im_here2.ogg','sound/hallucinations/look_up1.ogg','sound/hallucinations/look_up2.ogg','sound/hallucinations/over_here1.ogg','sound/hallucinations/over_here2.ogg','sound/hallucinations/over_here3.ogg','sound/hallucinations/turn_around1.ogg','sound/hallucinations/turn_around2.ogg','sound/hallucinations/veryfar_noise.ogg','sound/hallucinations/far_noise.ogg')

/obj/effect/fake_floor/fake_wall/spacehulk
	icon_state = "2iron0"
	base_icon_state = "2iron"

/obj/effect/fake_floor/fake_wall/r_wall/spacehulk
	icon_state = "2r_iron0"
	base_icon_state = "2r_iron"