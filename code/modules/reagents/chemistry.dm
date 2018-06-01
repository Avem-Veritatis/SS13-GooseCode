//TODO: Consider chemical transport through blood. Do not include manufacturing enzyme in this. But somebody with that could technically hook themselves up to somebody else to heal them.
//Thing that lets you distribute chemicals. Like, secrete a chemical reserve through skin to effect other mobs or splash on walls, et cetera.
//Medical surgery mechadendrite. Would be interesting.

/*
NEW CHEMISTRY

Contains changes to acids, some original drugs (like space drugs, synaptizine, hyperzine), addictions, and the following new chems (this list may be incomplete):
	hydrochloric acid- Pretty similar to sulfuric, mostly fluff.
	fluorantimonic acid- Super strong acid that turns corpses to dust.
	flame venom- Toxin that gibs corpses. Not actually placed anywhere or chemically producable right now.
	legecillin- The ultimate "rich people chem" that heals a ton of various ailments, but very slowly. Not practical for any kind of fast recovery or combat, but a decent way to slowly regenerate from exotic defects like genetic mutations or eventually even clone damage.
	polymorphine- Makes you uncontrollably assume the identity of those around you while active. Useful for a quick identity change, or to change someone else'e identity if you inject them.
	cameleoline- A stealth chem. In bloodstream, acts like a chameleon projector. When splashed on items, makes them invisible for a good time. When splashed on people, cloaks them, though living people have a short cloak time.
	alteration serum- A conditioning agent. Modifies the memory of the subject to believe whatever they hear with this in their blood. This will require some rp on the players part and invokes whatever rule we have nowadays about mind control.
	butcher's serum- A berserk chem. Forces a human to uncontrollably (and pretty effectively) attack those nearby, wielding guns and such, targeting the head, and generally with the intent of actual fatality. Very good way to frame someone if you know what you are doing.
	ricin- A slow acting, very potent poison, true to what it is in real life. Derived from plants. 2-3 units should be enough to kill you, but it will take a really long time before you actually experience any adverse effects at all.
	thujone- A seizure inducing chemical. Extracted from hyssop. Functionally the same as neurotoxin, but much more stylish, and the screen shaking is horrible.
	morphine- A painkiller and narcotic. OD is lethal. Found in nanomed plus when hacked.
	chloroform- Knocks you out breifly when just splashed on you, pretty good soporific in the bloodstream.
	laserbrain dust- Space coke. Powerful stimulant that can be cut with ID cards, playing cards, and data cards, and inhaled.
	neurocardiac restart- A chemical that will actually revive you from the dead. It leaves you far in crit still, however. And if your non-oxyloss damage is over 200 you will instantly die again, because you are beyond having your heart just restart.
	marshellium- Pretty much what was discussed. Forces you to speak in DM. (lol) I don't know where to put this in-game though.
	norcacillin- See above. Feel free to change this or add to the list you gave me.
	phenol- A plant derived substance normally in very, very small and nondangerous amounts. A pain to extract but a fast killer.
	lho- Lho leaf. Addictive inhalent. Also I replaced ambrosia with Lho.
	pneudelozine- Lexorin's evil twin. High oxygen loss, makes it impossible to speak, and in OD gets way worse.
	stealth toxin- A compound that looks like bicaridine, doesn't metabolize, and eventually converts to an equal dose of pneudelozine. Pretty traceless kill.
	endocryalin- Cools you down, a bit better than frost oil.
	endocryalin concentrate- A more concentrated version that actually puts you to sleep. This could theoretically be used to make a cryogenics system outside of the tube.
	nanites- Addictive drug that gives borg verbs but eventually makes you contract borg transformation disease.
	xenomicrobes- Pretty instantly infects you with xenomorph transformation disease. Doesn't really have much of a place in lore but could be interesting. Also it isn't placed anywhere in-game right now.
	hyperadrenal stimulant- Pretty tricky to make, but extremely powerful. While in your bloodstream, dodging variable is enabled. Plus you move pretty quickly.
	liquid stone- A pretty robust chemical that gives brute damage armoring and increases punch damage. Also slows you down though. Effects scale with volume, so OD could make you utterly immobile but have instantly lethal punches, if you had like 400u.
	stone venom- Derived from liquid stone. Turns you to stone breifly like the flesh to stone spell. Volume scales the duration of the transformation, 50u is a significant duration.
	manufacturing enzyme- Increases all chems in your blood to the same volume of manufacturing enzyme present. Does not metabolize.
	selective manufacturing enzyme- Like the above, only it only manufactures healing chems.
	promethium- Burns stuff. Splash it all over to burn everything. Also handy because it lights thermite.
	warp binding- Chaos chem. Highly incapacitating and a cool graphic.
	soul shatterer- Slaanesh drugs. A dose of this will literally irreparably screw you up. Nothing will be able to save you from how strong these drugs are.
	plague bearer- Nurgle drugs. Makes you a carrier of plague and pretty immune to pain. Maybe throw in your nurgle's rot virus if you really want.
	speed- Like the terran speed drug, it basically speeds you up in the same mechanism the warp chains slow you down.
	occuline- Enhances vision. Pretty soon though the drug overstresses your eyes, damages them, and removes your enhanced vision. So use with caution.

-Drake
*/

#define SOLID 1
#define LIQUID 2
#define GAS 3


//---------------Some Ingredients-----------------
datum/reagent/SbF
	name = "Antimony Pentafluoride"
	id = "SbF"
	description = "A chemical compound made from Fluorine and Antimony."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128

datum/reagent/SbO
	name = "Antimony Trioxide"
	id = "SbO"
	description = "A chemical compound made from Oxygen and Antimony. Has flame retardant properties."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128
	process_dead = 1

datum/reagent/SbO/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method == TOUCH)
		M.adjust_fire_stacks(-(volume / 3)) //About three times as potent as water, being a flame retardant.
		if(M.fire_stacks <= 0)
			M.ExtinguishMob()
	..()

datum/reagent/SbO/on_mob_life(var/mob/living/carbon/human/M as mob) //Actually fireproofs you in your system, though a bit toxic.
	if(!M) M = holder.my_atom
	if(prob(50)) M.adjustToxLoss(1)
	M.adjust_fire_stacks(-1)
	if(M.fire_stacks <= 0)
		M.ExtinguishMob()
	..()
	return

datum/reagent/toxin/chloromethane
	name = "Chloromethane"
	id = "chloromethane"
	description = "A toxic gas once used in refrigeration."
	reagent_state = GAS
	color = "#604030" // rgb: 96, 64, 48
	toxpwr = 2

datum/reagent/epinephrine //Super inaprovaline basically. They /do/ use epinephrine on people undergoing severe respiratory or cardiac problems.
	name = "Epinephrine"    //Not a bad combat stimulant either.
	id = "epinephrine"
	description = "Human adrenaline."
	reagent_state = LIQUID
	color = "#604030" // rgb: 96, 64, 48

datum/reagent/epinephrine/on_mob_life(var/mob/living/carbon/human/M as mob)
	if(!M) M = holder.my_atom
	M.dizziness = max(M.dizziness-3, 0)
	M.drowsyness = max(M.drowsyness-3, 0)
	M.stuttering = max(M.stuttering-3, 0)
	M.confused = max(M.confused-3, 0)
	M.stunned = max(M.stunned-3, 0)
	M.weakened = max(M.weakened-3, 0)
	M.adjustOxyLoss(-3)
	M.ignore_pain += 2
	if(prob(1) && ishuman(M)) //Chance to heal heart problems.
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/heart/heart in H.internal_organs)
			if(heart.status || !heart.beating)
				heart.beating = 1
				heart.status = 0
				heart.update_icon()
	..()
	return

datum/reagent/RNA
	name = "Ribonucleic Acid"
	id = "RNA"
	description = "A substance used in animal cells to selectively manufacture protein based on genetic data."
	reagent_state = LIQUID
	color = "#202040" // rgb: 20, 20, 40

datum/reagent/synaptizine
	name = "Synaptizine"
	id = "synaptizine"
	description = "Synaptizine is used to treat various diseases."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/synaptizine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.drowsyness = max(M.drowsyness-5, 0)
	M.AdjustParalysis(-1)
	M.AdjustStunned(-1)
	M.AdjustWeakened(-1)
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.ignore_pain += 5
	if(holder.has_reagent("mindbreaker"))
		holder.remove_reagent("mindbreaker", 5)
	M.hallucination = max(0, M.hallucination - 10)
	M.adjustToxLoss(pick(1,2,2,3)) //Non addictive, keeps your head completely clear. The disadvantage, then, is toxification, which I have increased to the point that synaptizine is more toxic than basic toxin. Easy enough to balance with antitoxin.
	..()
	return

datum/reagent/space_drugs
	name = "Red Diamond"
	id = "space_drugs"
	description = "An illegal chemical compound and drug."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	addictive = 1
	addictiontype = /datum/addiction

datum/reagent/space_drugs/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.druggy = max(M.druggy, 15)
	if(isturf(M.loc) && !istype(M.loc, /turf/space))
		if(M.canmove)
			if(prob(10)) step(M, pick(cardinal))
	if(prob(7)) M.emote(pick("twitch","drool","moan","giggle"))
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	return

datum/reagent/toxin/acid
	name = "Sulphuric acid"
	id = "sacid"
	description = "A strong mineral acid with the molecular formula H2SO4."
	reagent_state = LIQUID
	color = "#DB5008" // rgb: 219, 80, 8
	toxpwr = 1
	process_dead = 1

datum/reagent/toxin/acid/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)//magic numbers everywhere
	if(!istype(M, /mob/living))
		return
	if(M.stat == 2)
		if(toxpwr > 6)
			M.dust()
			M << "\red Your corpse dissolves in the strong acid!"
	if(method == TOUCH)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M

			if(H.head)
				if(prob(meltprob) && !H.head.unacidable)
					H << "<span class='danger'>Your headgear melts away but protects you from the acid!</span>"
					qdel(H.head)
					H.update_inv_head(0)
					H.update_hair(0)
				else
					H << "<span class='warning'>Your headgear protects you from the acid.</span>"
				return

			if(H.wear_mask)
				if(prob(meltprob) && !H.wear_mask.unacidable)
					H << "<span class='danger'>Your mask melts away but protects you from the acid!</span>"
					qdel(H.wear_mask)
					H.update_inv_wear_mask(0)
					H.update_hair(0)
				else
					H << "<span class='warning'>Your mask protects you from the acid.</span>"
				return

			if(H.glasses) //Doesn't protect you from the acid but can melt anyways!
				if(prob(meltprob) && !H.glasses.unacidable)
					H << "<span class='danger'>Your glasses melts away!</span>"
					qdel(H.glasses)
					H.update_inv_glasses(0)

		else if(ismonkey(M))
			var/mob/living/carbon/monkey/MK = M
			if(MK.wear_mask)
				if(!MK.wear_mask.unacidable)
					MK << "<span class='danger'>Your mask melts away but protects you from the acid!</span>"
					qdel(MK.wear_mask)
					MK.update_inv_wear_mask(0)
				else
					MK << "<span class='warning'>Your mask protects you from the acid.</span>"
				return

		if(!M.unacidable)
			if(istype(M, /mob/living/carbon/human) && volume >= 3)
				var/mob/living/carbon/human/H = M
				var/obj/item/organ/limb/affecting = H.get_organ("head")
				if(affecting)
					if(prob(meltprob)) //Applies disfigurement
						H.emote("scream")
						H.facial_hair_style = "Shaved"
						H.hair_style = "Bald"
						H.update_hair(0)
						H.status_flags |= DISFIGURED
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, /datum/wound/chem))  //Now acid will do a bit more damage, but over time.
						H.update_damage_overlays(0)
						H << "\red The acid burns!"
					sleep(60)
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, 0))
						H.update_damage_overlays(0)
						H.emote("scream")
					sleep(60)
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, 0))
						H.update_damage_overlays(0)
						H << "\red The acid burns!"
					sleep(60)
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, 0))
						H.update_damage_overlays(0)
						H.emote("scream")
					sleep(60)
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, 0))
						H.update_damage_overlays(0)
					sleep(60)
					if(affecting.take_damage((volume*toxpwr)/25, (volume*toxpwr)/25, 0))
						H.update_damage_overlays(0)
						H.emote("scream")
			else
				M.take_organ_damage(min(6*toxpwr, volume * toxpwr)) // uses min() and volume to make sure they aren't being sprayed in trace amounts (1 unit != insta rape) -- Doohl
	else
		if(!M.unacidable)
			M.take_organ_damage(min(4*toxpwr, 4*toxpwr))
			M.emote("scream")

datum/reagent/toxin/acid/on_mob_life(var/mob/living/M as mob)
	if(M.stat == 2)
		if(toxpwr > 4)
			M.dust()
			M << "\red Your corpse dissolves in the strong acid!"
	if(!M) M = holder.my_atom
	M.take_organ_damage((volume*toxpwr)/15, (volume*toxpwr)/15) //If you have acid in your bloodstream, you are well and truly screwed up.
	M.emote("scream")
	M.reagents.remove_all_type(/datum/reagent/toxin/acid, 4, 0, 1)
	..()

datum/reagent/toxin/acid/reaction_obj(var/obj/O, var/volume)
	if((istype(O,/obj/item) || istype(O,/obj/effect/glowshroom)) && prob(meltprob * 3))
		if(!O.unacidable)
			var/obj/effect/decal/cleanable/molten_item/I = new/obj/effect/decal/cleanable/molten_item(get_turf(O))
			I.desc = "Looks like this was \an [O] some time ago."
			for(var/mob/M in viewers(5, O))
				M << "<span class='danger'> \the [O] melts.</span>"
			qdel(O)

datum/reagent/toxin/acid/polyacid
	name = "Polytrinic acid"
	id = "pacid"
	description = "Polytrinic acid is a an extremely corrosive chemical substance."
	reagent_state = LIQUID
	color = "#8E18A9" // rgb: 142, 24, 169
	toxpwr = 2
	meltprob = 30

datum/reagent/toxin/acid/hydrochloric
	name = "hydrochloric acid"
	id = "hacid"
	description = "Hydrochloric acid is a strong acid."
	reagent_state = LIQUID
	color = "#808000" //Should be about olive...
	toxpwr = 2
	meltprob = 15

datum/reagent/toxin/acid/eacid //One of the super-poisons you will be able to make now.
	name = "fluoroantimonic acid"
	id = "eacid"
	description = "This is a very rare superacid. It melts just about anything and will seriously injure unprotected life forms."
	reagent_state = LIQUID
	color = "#FFFF00" // rgb: bright yellow
	toxpwr = 10 //In a smoke grenade, this would turn you to dust basically instantly, no matter what. Just dumping it on someone would be lethal, but it wouldn't turn you to ash.
	meltprob = 100

datum/reagent/water/carbonwater
	name = "Carbonated Water"
	id = "carbonwater"
	description = "Water with bubbles of carbon dioxide dissolved in it. Causes uncontrollable burping."
	reagent_state = LIQUID
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha) (the same as water)

datum/reagent/water/carbonwater/on_mob_life(var/mob/living/M as mob)
	if(M.stat == 2.0)
		return
	if(!M) M = holder.my_atom
	if(prob(15))
		M.emote("burp")
	..()
	return

datum/reagent/burn //TODO: Make this actually create vaporious burning promethium.
	name = "Promethium"
	id = "burn"
	description = "A highly volatile substance used by the imperium as both fuel and incendiary. Readily ignites on contact with anything, even air."
	reagent_state = LIQUID
	color = "#000000" // rgb: Completely black. That way making chemsmoke with it will look realistic.

datum/reagent/burn/reaction_turf(var/turf/T, var/volume)
	src = null
	T.hotspot_expose(700, 50, 1)
	if(istype(T,/turf/simulated/floor))
		var/turf/simulated/toburn = T
		if(!locate(/obj/effect/hotspot) in toburn)
			new /obj/effect/hotspot(toburn)
			toburn.temperature = volume*2
		//toburn.atmos_spawn_air(SPAWN_HEAT, 2)
	if(istype(T,/turf/simulated/wall))
		var/turf/simulated/wall/tomelt = T
		if(tomelt.thermite)
			tomelt.thermitemelt(null) //Triggers thermite melting in contact with walls.

datum/reagent/burn/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	M.fire_stacks = min(5,M.fire_stacks + 5)
	M.IgniteMob()
	if(M.stat == DEAD)
		if(M.fire_stacks > 100) //It needs to be something pretty huge to do this, because it is kind of unfair, but it really ought to burn you up eventually.
			M << "\red The heat of the fire burns you to ashes!"
			M.dust()

datum/reagent/burn/reaction_obj(var/obj/O, var/volume)
	var/turf/T = get_turf(O)
	T.hotspot_expose(700, 50, 1)
	if(istype(T,/turf/simulated/floor))
		var/turf/simulated/toburn = T
		new /obj/effect/hotspot(toburn)
		//toburn.atmos_spawn_air(SPAWN_HEAT, 2)

datum/reagent/burn/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.fire_stacks += 1 //In bloodstream the burns are naturally worse. A hell of a lot worse apparently.
	M.adjustFireLoss(2)
	..()
	return

datum/reagent/toxin/knockout   //The best way to put someone to sleep short of neurotoxin, thujone, or some other horrible chem.
	name = "Chloroform"
	id = "knockout"
	description = "A powerful but highly illegal chemical compound that will rapidly knock people out. Even the fumes can put you to sleep."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103
	toxpwr = 1  //Mildly toxic. This is nasty stuff. A bit shouldn't hurt much, but it is basically a neurotoxin... Easy kill in a smoke.

datum/reagent/toxin/knockout/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(!data) data = 1
	data++
	switch(data)
		if(1 to 10)
			M.confused += 4
			M.drowsyness += 1
			M.Dizzy(4)
			M.druggy += 1
		if(10 to 50)
			M.druggy += 1
			M.Dizzy(4)
			M.confused += 4
			M.drowsyness += 2
		if(51 to INFINITY)
			M.druggy += 2
			M.Dizzy(4)
			M.confused += 6
			M.drowsyness += 6
			M.sleeping += 1
			M.adjustToxLoss((data - 50)*REM)
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.unknown_pain += 2
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	..()
	return

datum/reagent/toxin/knockout/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)//magic numbers everywhere
	if(method==TOUCH)
		M << "\red The fumes make you lightheaded..."
		M.Dizzy(10)
		M.confused += 10
		M.drowsyness += 10
		spawn(20)
			M.sleeping += 20 //Even if you just splash it on them, the fumes knock them out in just two seconds.
			M.confused += 10
			M.drowsyness += 10
	else
		M << "\red You feel vaguely aware of the fact that you can no longer move."
		M.sleeping += 1
		M.weakened += 10 //In their bloodstream it will still paralyze them but not knock them out for very long at all. It will eventually put them to sleep much longer though.

datum/reagent/robust //This should be rare...
	name = "Cyanomorphide"
	id = "robust"
	description = "A strange, rare, and highly potent chemical that makes your flesh harden like stone. This will make prolonged movement difficult, but it will also make you very, very, very robust. Slightly toxic, due to the dramatic effect it has on physiology, however in a fight the gains far outway the cost."
	reagent_state = LIQUID
	color = "#808080" //RGB: Iron colored

datum/reagent/robust/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(prob(30)) M.adjustToxLoss(1) //Again, slightly toxic.
	if(prob(50))
		M.suppress_pain += 1 //A lot of it will make you start to feel less pain
		M.ignore_pain += 1 //Which does come with some advantages I suppose
	if(M.reagents_speedmod < volume/3) //This one is volume dependant. Too much of it will basically paralyze you
		M.reagents_speedmod += 1
		if(prob(30))
			M << "\red You feel your skin hardening like rock!"
	if(M.reagents_punchmod < volume/3) //Again, a lot of it can go a long way. 30u will make you stupidly slow. But it will also make you knock people out with a single blow.
		M.reagents_punchmod += 1
	if(volume>20)
		M.reagents_armormod = 0.6 //Significant protection
		if(volume>50)
			M.reagents_armormod = 0.3 //Insane protection.
	else
		M.reagents_armormod = 0.9 //Even a bit gives you an edge.
	..()
	return

datum/reagent/stonevenom
	name = "Stone Venom"
	id = "stonevenom"
	description = "A strange, highly potent substance derived from liquid stone. Stone venom is so concentrated that it will outright petrify the flesh of anyone it touches for a span of time. This will eventually wear off, and is nonlethal (unless you destroy their statue), however it is a very effective way to incapacitate someone for a long stretch of time. Volume dependant effects."
	reagent_state = LIQUID
	color = "#000000" //RGB: Black

datum/reagent/stonevenom/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	src = null
	var/obj/structure/closet/statue/S = new /obj/structure/closet/statue(get_turf(M),M)
	S.timer = volume*5 //50 units will paralyze you about as long as it would as a cast spell. 50 units is a lot, though.

datum/reagent/atium //This should also be rare... Really rare. Makes your reflexes so good you can dodge bullets. -Drake
	name = "Reflex"
	id = "atium"
	description = "A potent compound derived from epinephrine and certain other stimulants. Increases your reflexes so that you are very, very difficult to hurt."
	reagent_state = LIQUID
	color = "#C0C0C0" //RGB: Silver.

datum/reagent/atium/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(M.reagents_speedmod > -10)
		M.reagents_speedmod -= 1
	//M.status_flags |= GOTTAGOFAST //Makes you move pretty fast. Note that the dodge code that makes this work is actually located in projectile.
	if(M.reagents_punchmod < 4)
		M.reagents_punchmod += 1
	if(prob(30)) //Increases attack speed slightly this way.
		M.next_click = world.time
	M.AdjustParalysis(-3)
	M.AdjustStunned(-3)
	M.AdjustWeakened(-3)
	M.adjustStaminaLoss(-3)
	M.ignore_pain += 5
	M.dodging = 1
	if(prob(50))
		M.dodging = 2
	..()
	return

/mob/living/carbon/proc/borgmachine(var/obj/machinery/computer/T in oview(7))
	set category = "Robot Commands"
	set name = "Interface Computer"
	if(!T)
		var/list/targets = list()
		for(var/obj/machinery/computer/C in oview(7))
			targets += C
		T = input(src, "Select a device to interface.") as null|anything in targets
	if(T && istype(T))
		src.UnarmedAttack(T,0) //*should* let user interface computers normally

/mob/living/carbon/proc/borgemp(var/atom/movable/T in oview(7))
	set category = "Robot Commands"
	set name = "Overload Technology"
	if(!T)
		var/list/targets = list()
		for(var/atom/movable/C in oview(7))
			targets += C
		T = input(src, "Select a target.") as null|anything in targets
	if(T)
		T.emp_act(1) //User can selectively hit things with a light EMP. Pretty strong ability, really, given it can open doors, break headsets, and decharge some kinds of gun. Mind you, they will probably turn borg soon so it is okay to dangle this in front of them.

/mob/living/carbon/proc/borgairlock(var/obj/machinery/door/airlock/T in oview(7))
	set category = "Robot Commands"
	set name = "Interface Airlock"
	if(!T)
		var/list/targets = list()
		for(var/obj/machinery/door/airlock/C in oview(7))
			targets += C
		T = input(src, "Select an airlock to interface.") as null|anything in targets
	if(T && istype(T))
		var/list/operations = list("Toggle Open","Toggle Bolt","Toggle Safety","Toggle Electricity")
		var/operation = input(src, "Select an operation.") as null|anything in operations
		switch(operation)
			if("Toggle Open")
				if(T.welded)
					usr << "The airlock has been welded shut!"
				else if(T.locked)
					usr << "The door bolts are down!"
				else if(!T.density)
					T.close()
				else
					T.open()
			if("Toggle Bolt")
				T.locked = !T.locked
				T.update_icon()
			if("Toggle Safety")
				T.safe = !T.safe
			if("Toggle Electricity")
				if(T.secondsElectrified)
					T.secondsElectrified = 0
					usr << "[T] is no longer electrified."
				else
					T.secondsElectrified = 30
					usr << "[T] is temporarily electrified."

datum/reagent/nanites
	name = "Nanite Drug"
	id = "nanites"
	description = "Microscopic robots in a highly addictive reagent that slowly converts an individual into a cyborg. A peculiar agent from the dark age of technology."
	reagent_state = LIQUID
	color = "#535E66" // rgb: 83, 94, 102
	addictive = 3 //Pretty high chance to get addicted.
	addictiontype = /datum/addiction/severe
	var/cycles = 0

datum/reagent/nanites/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.druggy += 1
	M.heal_organ_damage(1, 1) //Nanites can heal you.
	cycles += 2
	if(volume > 30)
		cycles += 2
	if(cycles > 100)
		M.verbs.Add(/mob/living/carbon/proc/borgmachine)
	if(cycles > 200)
		M.verbs.Add(/mob/living/carbon/proc/borgemp)
	if(cycles > 300)
		M.verbs.Add(/mob/living/carbon/proc/borgairlock)
	if(cycles > 500)
		M.contract_disease(new /datum/disease/transformation/robot(0),1)
	..()
	return

datum/reagent/xenomicrobes
	name = "Xenomicrobes"
	id = "xenomicrobes"
	description = "Microbes with an entirely alien cellular structure."
	reagent_state = LIQUID
	color = "#535E66" // rgb: 83, 94, 102

datum/reagent/xenomicrobes/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	src = null
	if( (prob(10) && method==TOUCH) || method==INGEST)
		M.contract_disease(new /datum/disease/transformation/xeno(0),1)

datum/reagent/stimulant
	name = "Laserbrain Dust"
	id = "stimulant"
	description = "An illegal but nevertheless highly effective drug that grants enhanced speed and stun reduction using a mix of high energy compounds and stimulants. Side effects include confusion, shaking, twitching, et cetera. Also known as hulk dust in some sectors of the imperium."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	addictive = 1
	addictiontype = /datum/addiction
	var/awarded = 0

datum/reagent/stimulant/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(prob(10)) M.emote(pick("twitch","blink_r","shiver"))
	if(prob(30)) M.adjustToxLoss(1) //Slightly toxic, although it would take a ton to hurt you really at all.
	if(M.reagents_speedmod > -2)
		M.reagents_speedmod -= 1 //Makes you move really quickly, even if that does come at a price.
	if(prob(10)) //Increases attack speed slightly this way. Not actually particularly noticable.
		M.next_click = world.time
	M.AdjustStunned(-2) //Makes you difficult to stun and faster.
	M.AdjustWeakened(-2)
	M.adjustStaminaLoss(-2)
	M.druggy = max(M.druggy, 5) //Gets you just a little but high.
//  Tony Montana was never dizzy!
//	M.Dizzy(1)
	M.jitteriness += 2
	M.ignore_pain += 5 //Makes you immune to critical passing out...
	M.suppress_pain += 5 //And also oblivious to your injuries.
	//if(!M.confused) M.confused = 1
	//M.confused = max(M.confused, 5)
	if(volume >= 200)
		M.adjustToxLoss(1)
		M.heal_organ_damage(1, 1)
		M.inertial_speed = 6
		if(!awarded)
			awarded = 1
			award(usr, "<span class='slaanesh'>Snowflame</span>") //Yes, the DC comic supervillain who legitly got his powers from cocaine
	..()
	return

datum/reagent/hyperzine
	name = "Hypex"
	id = "hyperzine"
	description = "Hyperzine is a highly effective, long lasting, muscle stimulant. The side effects include blood de-oxygenation, so it is wise to use sparingly."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	//addictive = 1
	//addictiontype = /datum/addiction

datum/reagent/hyperzine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(5)) M.emote(pick("twitch","blink_r","shiver"))
	if(prob(5))
		M.adjustOxyLoss(5)
		M << "\red You limbs ache!"
	M.status_flags |= GOTTAGOFAST
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	//..()		//this was causing hyperzine to be consumed twice... //That was probably intentional, but they should have used custom metabolism.
	return

datum/reagent/otherdrug
	name = "Imperial Narcotic"
	id = "otherdrug"
	description = "A non-addictive depressant proliferated by the Imperium."
	reagent_state = LIQUID
	color = "#800080" //RGB: Purple
	overdose = REAGENTS_OVERDOSE

datum/reagent/otherdrug/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(20)) M.hallucination += 1
	if(prob(20)) M.adjustBrainLoss(1)
	//M.druggy = max(M.druggy, 2)
	M.Dizzy(1)
	M.confused += 1
	M.stuttering += 1
	M.eye_blurry = min(M.eye_blurry+1, 3)
	if(isturf(M.loc) && !istype(M.loc, /turf/space))
		if(M.canmove && !M.restrained())
			step(M, pick(cardinal))
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	return

datum/reagent/steroids
	name = "Frenzon"
	id = "steroids"
	description = "Imperially sanctioned performance enhancing drugs. Side effects are numerous."
	reagent_state = LIQUID
	color = "#808080"

datum/reagent/supersteroids/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(prob(40)) M.adjustToxLoss(1)
	if(M.reagents_punchmod < volume/10)
		M.reagents_punchmod += 1
	M.reagents_armormod = min(M.reagents_armormod, 0.95)
	..()
	return

datum/reagent/supersteroids
	name = "Psychon"
	id = "supersteroids"
	description = "A particularly potent and highly illegal muscular stimulant. While somewhat toxic, this allows the subject to over-extend their natural capacities significantly."
	reagent_state = LIQUID
	color = "#808080"
	var/grown = 0

datum/reagent/supersteroids/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	M.adjustToxLoss(1)
	if(!grown)
		grown = 1
		animate(M, transform = (M.transform*TransformUsingVariable(75, 125, 0.5)), time = 300)
		M.maxHealth += 80
		M.health += 80
	if(M.reagents_punchmod < volume/2)
		M.reagents_punchmod += 1
	M.reagents_armormod = min(M.reagents_armormod, 0.90)
	if(prob(50)) M.heal_organ_damage(1, 1)
	if(M.handcuffed)
		M.visible_message("<span class='warning'>[M] is trying to break free!</span>", \
				"<span class='warning'>You attempt to break free.</span>")
		del(M.handcuffed)
		M.regenerate_icons()
	..()
	return

datum/reagent/supersteroids/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/living/M = holder.my_atom
		M.transform = initial(M.transform)
		M.maxHealth -= 80
		M.health -= 80
	..()

datum/reagent/toxbrute
	name = "Venonine"
	id = "toxbrute"
	description = "Heals trauma injuries almost magically, converting the physical stress on the subject's system to toxification."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/toxbrute/on_mob_life(var/mob/living/M as mob)
	if(M.stat == 2.0)
		return
	if(!M) M = holder.my_atom
	if(M.getBruteLoss())
		M.adjustToxLoss(4)
		M.heal_organ_damage(4,0)
	..()
	return

datum/reagent/brainburn
	name = "Thenozine"
	id = "brainburn"
	description = "A compound that stimulates unnatural regeneration in the dermal layer, giving an effective way to treat serious burns. It wreaks serious havoc on the nervous system, possibly resulting in cases of brain damage."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/brainburn/on_mob_life(var/mob/living/M as mob)
	if(M.stat == 2.0)
		return
	if(!M) M = holder.my_atom
	M.adjustBrainLoss(2)
	M.heal_organ_damage(0,4)
	..()
	return

datum/reagent/strongtox
	name = "Equivine"
	id = "strongtox"
	description = "A compound that dramatically counteracts toxic damage. Side effects include bleeding and drowsyness."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/strongtox/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-5)
	M.adjustBruteLoss(1)
	M.drowsyness += 1
	..()
	return

datum/reagent/occustim
	name = "Occuline"
	id = "occustim"
	description = "A compound that puts extreme strain on the eyes, allowing enhanced vision, but eventually damaging the eyes."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103

datum/reagent/occustim/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(!data) data = 1
	data++
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		switch(data)
			if(0 to 30)
				H.client.view = 9
			if(31 to 80)
				H.client.view = 10
				H.eye_blurry = min(H.eye_blurry+1, 3)
				if(prob(50)) H.eye_stat += 1
			if(81 to 90)
				H.disabilities |= NEARSIGHTED
				H.eye_blurry += 1
				H.eye_stat += 1
				H.client.view = world.view
			if(91 to INFINITY) //And then excess of the chemical dissapates.
				holder.remove_reagent(src.id, 100)
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	..()
	return

datum/reagent/occustim/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.client.view = world.view
	..()

datum/reagent/toxin/morphine
	name = "Kalma"
	id = "morphine"
	description = "A powerful painkiller and incapacitating narcotic."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103
	toxpwr = 0
	addictive = 1
	addictiontype = /datum/addiction

datum/reagent/toxin/morphine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(!data) data = 1
	data++
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.suppress_pain += 5 //Powerful painkiller.
	M.heal_organ_damage(1, 1) //Useful for medicine, despite incapacitating and addictive effects.
	switch(data)
		if(0 to 10)
			M.confused += 4
			M.drowsyness += 1
		if(11 to 40)
			M.druggy += 1
			M.Dizzy(1)
			M.confused += 4
			M.drowsyness += 2
		if(41 to INFINITY)
			M.druggy += 2
			M.Dizzy(2)
			M.confused += 6
			M.drowsyness += 6
			if(data > 150)
				M.adjustToxLoss((data - 150)*REM)
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	..()
	return

datum/reagent/toxin/lho
	name = "Lho Leaf"
	id = "lho"
	description = "A narcotic inhalent rampant in the Imperium. Highly addictive. Also a decent painkiller."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103
	toxpwr = 0
	addictive = 1
	addictiontype = /datum/addiction/severe

datum/reagent/toxin/lho/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(!data) data = 1
	data++
	if(istype(M,/mob/living/carbon/human)) //Decent painkiller.
		var/mob/living/carbon/human/H = M
		H.suppress_pain += 3
		H.ignore_pain += 2 //This is why someone might actually use lho. Mind you, they probably have to keep using it after that.
	switch(data)
		if(0 to 10)
			M.druggy += 1
			M.confused += 1
		if(11 to 40)
			M.jitteriness = max(M.jitteriness-5,0)
			if(prob(50))
				M.hallucination += 1
			M.druggy += 2
			M.Dizzy(1)
			M.confused += 2
		if(41 to INFINITY)
			M.hallucination += 1
			if(prob(50))
				M.hallucination += 1
			M.druggy += 3
			M.Dizzy(2)
			M.confused += 4
			M.jitteriness = max(M.jitteriness-5,0)
			if(prob(60)) M.drowsyness = max(M.drowsyness, 3)
			if(data > 150)
				if(prob(5)) M.adjustBrainLoss(1) //Slight brain damage with prolonged use.
	..()
	return

datum/reagent/speed
	name = "Spur"
	id = "speed"
	description = "A stimulant drug developed in ancient terra. Laws on the control of the substance vary throughout the Imperium. Increases movement speed dramatically, at the cost of losing certain other capacities like aiming carefully."
	reagent_state = LIQUID
	color = "#888888" //RGB: Grey
	addictive = 1
	addictiontype = /datum/addiction

datum/reagent/speed/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.reagents_speedmod = min(H.reagents_speedmod, -1.5) //Stuff should make you pretty fast.
		H.innacuracy = 25
		H.next_click = world.time                          //At everything.
	..()
	return

datum/reagent/speed/Del()
	if(holder && ishuman(holder.my_atom))
		var/mob/living/carbon/human/H = holder.my_atom
		H.innacuracy = 0
	..()

datum/reagent/polymorphine
	name = "Polymorphine"
	id = "polymorphine"
	description = "A strange substance that warps the physique of the subject. Used by the secretive Callidus assassins. Most untrained individuals find polymorphine difficult to control."
	reagent_state = SOLID
	color = "#676057" //RGB- reddish grey
	process_dead = 1

datum/reagent/polymorphine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/P = M
		for(var/mob/living/carbon/human/H in orange(P, 3))
			if(P.dna.uni_identity != H.dna.uni_identity && prob(60))
				P.dna.uni_identity = H.dna.uni_identity
				updateappearance(P)
				P.real_name = H.real_name
				P.visible_message("<span class='warning'>[P]'s form distorts before your vision!</span>")
		//if(prob(1))
		//	P.mutation_expose() //TODO: Put this back in when it is more functional.
		P.heal_organ_damage(3, 3)
	..()
	return

/obj/effect/dummy/cameleoline
	name = ""
	desc = ""
	density = 0
	anchored = 1
	var/can_move = 1

/obj/effect/dummy/cameleoline/proc/activate(var/obj/O, var/atom/movable/MA, new_icon, new_iconstate, new_overlays, life)
	name = O.name
	desc = O.desc
	icon = new_icon
	icon_state = new_iconstate
	overlays = new_overlays
	dir = O.dir
	layer = O.layer //A floor dummy should actually go on the floor layer. It shouldn't cover up the table over it.
	MA.loc = src
	spawn(life)
		src.disrupt()

/obj/effect/dummy/cameleoline/attackby()
	for(var/mob/M in src)
		M << "\red Your chameleon field deactivates."
	src.disrupt()

/obj/effect/dummy/cameleoline/attack_hand()
	for(var/mob/M in src)
		M << "\red Your chameleon field deactivates."
	src.disrupt()

/obj/effect/dummy/cameleoline/ex_act()
	for(var/mob/M in src)
		M << "\red Your chameleon field deactivates."
	src.disrupt()

/obj/effect/dummy/cameleoline/bullet_act()
	for(var/mob/M in src)
		M << "\red Your chameleon field deactivates."
	..()
	src.disrupt()

/obj/effect/dummy/cameleoline/relaymove(var/mob/user, direction)
	if(istype(loc, /turf/space)) return //No magical space movement!

	if(can_move)
		can_move = 0
		switch(user.bodytemperature)
			if(300 to INFINITY)
				spawn(10) can_move = 1
			if(295 to 300)
				spawn(13) can_move = 1
			if(280 to 295)
				spawn(16) can_move = 1
			if(260 to 280)
				spawn(20) can_move = 1
			else
				spawn(25) can_move = 1
		step(src, direction)
	return

/obj/effect/dummy/cameleoline/Destroy()
	src.disrupt()
	del(src)

/obj/effect/dummy/cameleoline/proc/disrupt()
	var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	spark_system.start()
	for(var/atom/movable/A in src)
		A.loc = src.loc
		if(ismob(A))
			var/mob/M = A
			M.reset_view(null)
	del(src)

datum/reagent/cameleoline
	name = "Cameleoline"
	id = "cameleoline"
	description = "An unusual compound from the dark age of technology. Refracts light to make objects difficult to see."
	reagent_state = SOLID
	color = "#676057" //RGB- reddish grey

datum/reagent/cameleoline/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(volume > 300) //OD effect. Pretty helpful, but only if you are prepared for the stun and damages.
		M << "\red Every single cell in your body screams as the overdose of cameleoline violently reacts with your body!"
		M.Weaken(5)
		flick("flash", M.flash)
		M.adjustToxLoss(30)
		M.adjustOxyLoss(20)
		M.take_organ_damage(5,5)
		M.alpha = 100
		M.layer = TURF_LAYER+0.2
		M.reagents.remove_reagent("cameleoline",1000) //Gets rid of all the cameleoline in them.
		return
	if(prob(50))
		M.adjustToxLoss(1) //Not really meant to be ingested.
	if(istype(M.loc, /obj/effect/dummy/cameleoline))
		return
	var/saved_item
	var/saved_icon
	var/saved_icon_state
	var/saved_overlays
	for(var/obj/item/target in range(5, get_turf(M)))
		saved_item = target
		saved_icon = target.icon
		saved_icon_state = target.icon_state
		saved_overlays = target.overlays
	if(saved_item)
		var/obj/effect/dummy/cameleoline/C = new/obj/effect/dummy/cameleoline(M.loc)
		C.activate(saved_item, M, saved_icon, saved_icon_state, saved_overlays, 200) //20 second life cloaking fields
	..()
	return

datum/reagent/cameleoline/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method == TOUCH)
		if(istype(M.loc, /obj/effect/dummy/cameleoline))
			return
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			var/cloak_time = volume*10
			var/saved_item = H
			var/saved_icon = H.icon
			var/saved_icon_state = "body_cloaked"
			var/saved_overlays = list()
			if(H.stat == DEAD)
				cloak_time *= 20 //Dead bodies are really easy to hide, because they don't move or give off heat signatures.
			if(H.lying)
				saved_icon_state = "body_cloaked_lying"
			var/obj/effect/dummy/cameleoline/C = new/obj/effect/dummy/cameleoline(H.loc)
			C.activate(saved_item, H, saved_icon, saved_icon_state, saved_overlays, cloak_time)
			src = null
		else
			var/saved_item
			var/saved_icon
			var/saved_icon_state
			var/saved_overlays
			for(var/obj/item/target in range(5, get_turf(M)))
				saved_item = target
				saved_icon = target.icon
				saved_icon_state = target.icon_state
				saved_overlays = target.overlays
			if(saved_item)
				var/obj/effect/dummy/cameleoline/C = new/obj/effect/dummy/cameleoline(M.loc)
				if(M.stat == DEAD)
					C.activate(saved_item, M, saved_icon, saved_icon_state, saved_overlays, volume*200) //Easier to hide corpses.
				else
					C.activate(saved_item, M, saved_icon, saved_icon_state, saved_overlays, volume*10)
			src = null
	else
		..()

datum/reagent/cameleoline/reaction_obj(var/obj/O, var/volume)
	if(!istype(O, /obj/item))
		return
	if(!isturf(O.loc)) //Object needs to be an item, and it needs to be on turf, for it to be cloaked.
		return
	var/saved_item
	var/saved_icon
	var/saved_icon_state
	var/saved_overlays
	var/turf/target = get_turf(O)
	saved_item = target
	saved_icon = target.icon
	saved_icon_state = target.icon_state
	saved_overlays = target.overlays
	if(saved_item)
		var/obj/effect/dummy/cameleoline/C = new/obj/effect/dummy/cameleoline(O.loc)
		C.activate(saved_item, O, saved_icon, saved_icon_state, saved_overlays, volume*200) //Items are easier to cloak than live people (see info on corpses)
	src = null

datum/reagent/crazy
	name = "Decayed Cameleoline"
	id = "crazy"
	description = "Formerly cameleoline, this sample appears to have decayed and lost its potency. It is probably still refractive to some capacity, but not helpful for stealth operations."
	reagent_state = SOLID
	color = "#676057" //RGB- reddish grey

datum/reagent/crazy/reaction_turf(var/turf/T, var/volume)
	T.color = "#" + pick("C73232","5998FF","2A9C3B","CFB52B","AE4CCD","FFFFFF","333333")
	spawn(50)
		T.color = initial(T.color)
		src = null

datum/reagent/crazy/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	spawn()
		M.GlichAnimation(loops = 5)
	..()
	return

datum/reagent/crazy/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	spawn()
		M.GlichAnimation(loops = 5)
	..()

datum/reagent/crazy/reaction_obj(var/obj/O, var/volume)
	if(istype(O, /obj/item))
		spawn()
			O.GlichAnimation(loops = 5)
			src = null

datum/reagent/warpbond
	name = "Warp Binding"
	id = "warpbond"
	description = "A distillation replete with warp energies, this potion binds any who ingest it with chains from the immaterium."
	reagent_state = SOLID
	color = "#000000" //RGB- black

datum/reagent/warpbond/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(holder.has_reagent("speed")) //Drugs can't counteract the curses of the warp.
		holder.remove_reagent("speed", 2)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.reagents_speedmod = 20
		H.next_click = (world.time + rand(0,80))
		if(prob(10))
			H.visible_message("\red <b>The warp chains choke [H]!</b>")
			H.emote("gasp")
			H.adjustOxyLoss(10)
			H.silent += 5
		if(prob(5))
			H.visible_message("\red <b>[H] struggles against the warp chains!</b>")
	else
		M.Stun(5)
	var/turf/mobloc = get_turf(M)
	anim(mobloc,M,'icons/mob/mob.dmi',,"warp_chains",,M.dir)
	..()
	return

datum/reagent/flying //Would be interesting to manipulate density var with this sometime... Not all the time but sometimes while active.
	name = "Levalin"
	id = "flying"
	description = "A strange substance of the warp that reduces the effects of gravity."
	reagent_state = LIQUID
	color = "#000000" //RGB- black

datum/reagent/flying/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method != TOUCH)
		M.pixel_y = 20
		M.layer = FLY_LAYER

datum/reagent/flying/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.pass_flags |= PASSTABLE
	M.status_flags |= GOTTAGOFAST //You don't get slowed down by armor or hunger if you aren't actually running.
	M.pixel_y += pick(-1,0,1)
	if(M.pixel_y < 16)
		M.pixel_y += 1
	if(M.pixel_y > 24)
		M.pixel_y -= 1
	M.density = 1
	if(prob(20))
		M.density = 0
	..()
	return

datum/reagent/flying/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.pass_flags &= ~PASSTABLE
		M.pixel_y = 0
		M.layer = MOB_LAYER
		M.density = 1
	..()

datum/reagent/marshellium //lol...
	name = "Marshellium"
	id = "marshellium"
	description = "description = 'description = 0x0058120'"
	reagent_state = LIQUID
	color = "#000000" //RGB- black

datum/reagent/marshellium/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.DMSpeak += 1
		if(prob(5))
			H << "\red You crave eucalyptus..."
		if(prob(50)) H.say("Next Patch")
		if(prob(4))
			for(var/obj/machinery/door/airlock/A in view(H, 7))
				H.say("var/obj/machinery/door/airlock/A = pick(view(src, 7)); A.open()")
				A.open()
				break
		if(prob(4))
			H.say("src.Weaken(3)")
			H.Weaken(3)
		if(prob(4))
			for(var/mob/living/carbon/human/T in oview(H, 7))
				H.say("('[T]').Weaken(3)")
				T.Weaken(3)
				break
		if(prob(4))
			H.say("src.adjustToxLoss(5)")
			H.adjustToxLoss(5)
		if(prob(4))
			for(var/mob/living/carbon/human/T in oview(H, 7))
				H.say("('[T]').adjustToxLoss(5)")
				T.adjustToxLoss(5)
				break
		if(H.DMSpeak > 150)
			if(prob(3))
				for(var/atom/A in view(H, 7))
					H.say("('[A]').ex_act(pick(0,1,1,2,2,2))")
					A.ex_act(pick(0,1,1,2,2,2))
					break
			if(prob(8))
				for(var/atom/movable/MA in view(H, 7))
					H.say("('[MA]').emp_act(pick(0,1,1))")
					MA.emp_act(pick(0,1,1))
					break
			if(prob(4))
				H.say("src.take_organ_damage(20, 20)")
				H.take_organ_damage(20, 20)
			if(prob(4))
				H.say("src.heal_organ_damage(20, 20)")
				H.heal_organ_damage(20, 20)
	..()
	return

datum/reagent/marshellium/Del()
	if(holder && ishuman(holder.my_atom))
		var/mob/living/carbon/human/M = holder.my_atom
		if(istype(M))
			M.DMSpeak = 0
	..()

datum/reagent/norcacillin //Naturally, if there is anything from the idea that I am missing feel free to put it in. This /is/ your chem, after all.
	name = "Norcacillin"
	id = "norcacillin"
	description = "A substance of unknown origin that appears to be a reasonable effective healing compound. Side effects may include the uncontrollable desire to consume bread."
	reagent_state = LIQUID
	color = "#000000" //RGB- black

datum/reagent/norcacillin/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.heal_organ_damage(2,2) //Because geese are sturdy.
		H.norc += 1
		if(prob(15))
			H.contract_disease(new /datum/disease/transformation/goose(0),1)
	..()
	return

datum/reagent/norcacillin/Del()
	if(holder && ishuman(holder.my_atom))
		var/mob/living/carbon/human/M = holder.my_atom
		if(istype(M))
			M.norc = 0
	..()

datum/reagent/toxin/chlorinegas
	name = "Chlorine"
	id = "chlorinegas"
	description = "Inhaled chlorine gas makes hydrochloric acid in the subject's lungs, causing them to drown in their own blood."
	reagent_state = GAS
	color = "#C8A5DC" // rgb: 200, 165, 220
	toxpwr = 0

	on_mob_life(var/mob/living/M as mob)
		if(M.stat == 2.0)
			return
		if(!M) M = holder.my_atom
		if(prob(50))
			M.take_organ_damage(1, 0)
		M.adjustOxyLoss(3.5)
		if(prob(20)) M.emote("gasp")
		if(prob(20)) M.emote("cough")
		if(prob(10)) M << pick("\red You feel a searing pain in your lungs!", "\red You are drowning in your own blood!", "\red You can't breath!", "\red <b>Your lungs!</b>")
		..()
		return

datum/reagent/toxin/hallucinations
	name = "Blue Supernova"
	id = "hallucinations"
	description = "A substance outlawed in most sectors of the imperium. Makes you see things. Addictive."
	reagent_state = LIQUID
	color = "#5070F3" //RGB: Blue.
	toxpwr = 0
	addictive = 1
	addictiontype = /datum/addiction

datum/reagent/toxin/hallucinations/on_mob_life(var/mob/living/M)
	if(!M) M = holder.my_atom
	if(prob(50)) M.adjustBrainLoss(1)
	M.druggy += 5
	M.confused += 5
	M.hallucination += 10
	M.Dizzy(2)
	..()
	return

datum/reagent/toxin/conditioning
	name = "Psytropene"
	id = "conditioning"
	description = "A serum which causes any individual under its influence to immutably believe everything they are told. Their memories and ideals can be freely modified, and will remain modified even after the effects of the drug wear off."
	reagent_state = LIQUID
	color = "#000000" //RGB- black
	toxpwr = 0

datum/reagent/toxin/conditioning/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method != TOUCH)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.reagents.get_reagent_amount("conditioning")) return
			H.brainwashed = 1
			H << "\red <b>A strange dizziness washes over you...</b>"
			if(isloyal(H.mind.current) && volume < 45)
				H << "\red <b>And vanishes, courtesy of your loyalty implant.</b>"
				src.volume = 0
				return
			H << "\red <b>You have fallen under the influence of brainwashing! </b>"
			H << "\red <b>While you are being brainwashed, you will believe everything you are told unquestioningly. You will only be obligated to believe what you are told while under the effects of brainwashing, but even after the effects wear off your memories remain modified.</b>"
			H.visible_message("<b>[H]'s</b> eyes blur for a moment and then refocus.")
	..()

datum/reagent/toxin/conditioning/Del()
	if(holder && ishuman(holder.my_atom))
		var/mob/living/carbon/human/H = holder.my_atom
		if(H.brainwashed)
			H.brainwashed = 0
			H << "\red <b>You feel more aware of your surroundings.</b>"
			H << "\red <b>You are no longer being brainwashed!</b>"
			H << "\red <b>You retain any changes your brainwashing inflicted upon your memories and consciousness, but you are no longer vulnerable to future modifications.</b>"
	..()

datum/reagent/toxin/berserk
	name = "Fury"
	id = "berserk"
	description = "An illegal combat drug, this substance is used in the infamous butcher's nails implant, which, considering its affiliation with the world eaters, is likely to channel the powers of Khorne."
	reagent_state = LIQUID
	color = "#000000" //RGB- black
	toxpwr = 0

datum/reagent/toxin/berserk/on_mob_life(var/mob/living/carbon/M as mob)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.berserk)
			H.berserk = 1
			H << "\red <b>You feel an unnatural energy and rage wash over you...</b>"
			H.visible_message("\red <b>[H]'s eyes burn a blood red!</b>")
			for(var/datum/reagent/B in src.holder.reagent_list)
				if(B.id == "blood")
					H.berserkmaster = B.data["donor"] //Mind you, this won't force them to do as you say IC.
	..()

datum/reagent/toxin/berserk/Del()
	if(holder && ishuman(holder.my_atom))
		var/mob/living/carbon/human/H = holder.my_atom
		H.berserk = 0
		H << "\red <b>You feel more like yourself. You are once again in control.</b>"
		..()

datum/reagent/legecillin //Heals all sorts of problems, but quite slowly.
	name = "Legecillin"
	id = "legecillin"
	description = "A compound that boosts the body's natural healing, cleanses impurities, heals diseases, and reduces the effects of aging."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/legecillin/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	M.reagents.remove_all_type(/datum/reagent/toxin, 1, 0, 1)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		for(var/datum/addiction/A in H.addictions)
			A.recovery -= 1
	if(prob(10)) M.adjustCloneLoss(-1)
	if(prob(45)) M.adjustOxyLoss(-1)
	if(prob(50) && M.radiation) M.radiation -= 1
	if(prob(25)) M.heal_organ_damage(1,1)
	if(prob(50)) M.adjustToxLoss(-1)
	if(prob(10) && M.hallucination) M.hallucination -= 1
	if(prob(10)) M.adjustBrainLoss(-1)
	if(prob(2)) M.disabilities = 0
	if(prob(2)) M.sdisabilities = 0
	if(M.eye_blurry) M.eye_blurry -= 1
	if(prob(50) && M.eye_blind) M.eye_blind -= 1
	if(M.silent) M.silent -= 1
	if(M.dizziness) M.dizziness -= 1
	if(M.stuttering) M.stuttering -= 1
	if(M.confused) M.confused -= 0
	for(var/datum/disease/D in M.viruses)
		if(prob(2))
			D.stage--
			if(D.stage < 1)
				D.cure()
	..()
	return

datum/reagent/revival
	name = "Neurocardiac Restart"
	id = "revival"
	description = "A drug that restarts the heart of a dead patient. Provided that their soul has not departed and that their body is not too seriously injured, this may result in the eventual revival of the subject, provided their wounds are treated. Note that the drug is slightly toxic to the living."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	process_dead = 1

datum/reagent/revival/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	if(M.stat == DEAD)
		if(M.health >= config.health_threshold_dead)
			M << "\red You heart starts beating again!"
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				H.suiciding = 0
				for(var/obj/item/organ/heart/heart in H.internal_organs)
					heart.beating = 1
					heart.status = 0
					heart.update_icon()
			M.adjustOxyLoss(-15) //This will revive you... But not for long if you are mostly brute damaged.
			M.heal_organ_damage(5,5) //Should counteract excess brute and burn damages, which will be frequent.
			dead_mob_list -= M
			living_mob_list += M
			if(!isanimal(M))	M.stat = UNCONSCIOUS
		else
			M.adjustOxyLoss(-5)
			M.heal_organ_damage(2,2)
		holder.remove_reagent(src.id, 0.2 * REAGENTS_METABOLISM)
	if(M.stat != DEAD)
		M.adjustToxLoss(1) //Yet another factor to balance if you wish for a successful revival.
		holder.remove_reagent(src.id, REAGENTS_METABOLISM)
	return

datum/reagent/patch
	name = "Olitimine"
	id = "patch"
	description = "A substance that can patch up injuries in both the living and purportedly the dead. Totally not a good idea to use in conjunction with neurocardiac restart to outperform a standard expinovite injection."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	process_dead = 1

datum/reagent/patch/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	M.heal_organ_damage(1, 1)
	if(M.stat == DEAD)
		M.heal_organ_damage(1, 1)
	..()
	return

datum/reagent/toxin/fakedeath //This is basically zombie powder in most ways, but designed for a different purpose. That is, it is easier to make but only practical for short-term stuns, mostly useful for actually faking death, especially with the added deathgasp emote.
	name = "Stasis Mix"
	id = "fakedeath"
	description = "A strong toxin that momentarily causes their life signs to stop, then wears off almost instantly after this."
	reagent_state = SOLID
	color = "#669900" // rgb: 102, 153, 0
	toxpwr = 0

datum/reagent/toxin/fakedeath/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	M.status_flags |= FAKEDEATH
	M.Weaken(5)
	M.silent = max(M.silent, 5)
	M.tod = worldtime2text()
	..()
	return

datum/reagent/toxin/fakedeath/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.status_flags &= ~FAKEDEATH
	..()

datum/reagent/toxin/fakedeath/reaction_mob(var/mob/living/carbon/human/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living/carbon/human))
		return
	if(method == TOUCH)
		return
	else
		M.emote("deathgasp") //Otherwise it isn't that convincing.
		spawn(volume*5)
			M.reagents.remove_reagent("fakedeath",1000) //Purges your system pretty soon.
	return

/datum/disease/advance/nurgle/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Rot Virus"
		symptoms = list(new/datum/symptom/flesh_eating, /datum/symptom/genetic_mutation)
		SetSpread(CONTACT_GENERAL)
	..(process, D, copy)

datum/reagent/toxin/nurgle
	name = "Plague Bearer"
	id = "nurgle"
	description = "The blessings of papa nurgle. Possibly extracted from an actual plaguebearer daemon."
	reagent_state = LIQUID
	color = "#535E66" // rgb: 83, 94, 102
	toxpwr = 0

datum/reagent/toxin/nurgle/on_mob_life(var/mob/living/carbon/M as mob) //Pain immune, healing, carrying horrible diseases.
	if(!M) M = holder.my_atom
	M.druggy += 1
	M.adjustToxLoss(pick(-2,-1,0,1,2))
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.ignore_pain += 2
		H.suppress_pain += 2
	M.heal_organ_damage(1, 1)
	diseases = list(/datum/disease/advance/nurgle, /datum/disease/brainrot, /datum/disease/fluspanish) //I recall you had a nurgle virus, maybe put it in. You will have to replace one of them, however, because at the moment humans can only be infected with three viruses at one time.
	for(var/path in diseases)
		M.contract_disease(new path(0),1)
	for(var/datum/disease/v in M.viruses)
		v.carrier = 1
	..()
	return

datum/reagent/slaanesh
	name = "Soul Shatterer"
	id = "slaanesh"
	description = "The drug to rule all drugs, created from the essence of Lord Slaanesh."
	reagent_state = LIQUID
	color = "#800080" //RGB: Purple
	overdose = REAGENTS_OVERDOSE
	addictive = 5
	addictiontype = /datum/addiction/severe

datum/reagent/slaanesh/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/list/factions = list("SLAANESH")
	if(length(factions & M.factions)) //A follower of slaanesh has ingested slaanesh drug. This is bad news for everyone else, since it is like super-cocaine for them. -Drake
		award(M, "<span class='slaanesh'>Slaanesh's Faithful</span>")
		M.druggy += 1
		M.heal_organ_damage(3,2)
		M.Dizzy(1)
		M.confused = max(M.confused, 3)
		M.AdjustParalysis(-3)
		M.AdjustStunned(-3)
		M.AdjustWeakened(-3)
		M.adjustStaminaLoss(-3) //While this is quite powerful, I eventually want to make this increase the risk of insanity and such.
		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			H.ignore_pain += 3
			H.reagents_speedmod -= 3 //...lol this will be funny
	else
		award(M, "<span class='slaanesh'>Wasted</span>")
		if(prob(30))
			shake_camera(M, 10, 1)
		if(prob(50))
			if(istype(M,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				H.unknown_pain += 1
		M.hallucination += 100
		M.druggy = max(M.druggy, 60)
		M.Dizzy(2)
		if(!M.confused) M.confused = 1
		M.confused = max(M.confused, 30)
		if(isturf(M.loc) && !istype(M.loc, /turf/space))
			if(M.canmove && !M.restrained())
				if(prob(50)) step(M, pick(cardinal))
	holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
	return

datum/reagent/slaanesh_corruption
	name = "Purple Supernova"
	id = "slaanesh_corruption"
	description = "???!"
	reagent_state = SOLID
	color = "#669900"
	var/fakedeath = 0
	var/timer = 0
	var/obj/effect/mob_projection/V

datum/reagent/slaanesh_corruption/on_mob_life(var/mob/living/carbon/human/M as mob)
	if(!M) M = holder.my_atom
	if(!istype(M)) return
	M.druggy += 5
	M.confused += 5
	M.hallucination += 10
	M.Dizzy(2)
	if(volume > 120 && M.purity == -5) //Set the purity numbers to the correct location in the path, not sure where this goes.
		fakedeath = 1
		M << "\red Your heart stops beating!"
		M.status_flags |= FAKEDEATH
		M.tod = worldtime2text()
		M.emote("deathgasp")
	if(fakedeath)
		timer ++
		M.Weaken(5)
		M.silent = max(M.silent, 5)
		M.healths.icon_state = "health7" //Should make you appear completely dead.
		if(timer == 10)
			V = new()
			V.clone = null //Hm... This is a good place to start, need to do a bit of work to make this work correctly though.
			V.my_target = M
			V.loc = get_turf(V.my_target)
			V.left = image(V.clone,dir = WEST)
			V.right = image(V.clone,dir = EAST)
			V.up = image(V.clone,dir = NORTH)
			V.down = image(V.clone,dir = SOUTH)
			V.name = V.clone.name
			V.message = ""
			spawn V.update_loop()
		if(timer == 40)
			qdel(V)
			M << "\red Your heart starts beating again!"
			M.status_flags &= ~FAKEDEATH
			if(M.purity == -5)
				M.purity = -6
	..()
	return

datum/reagent/slaanesh_corruption/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M << "\red Your heart starts beating again!"
		M.status_flags &= ~FAKEDEATH
	..()


datum/reagent/fatigue
	name = "Anti-ATP"
	id = "fatigue"
	description = "An unusual compound that breaks down ATP, effectively sapping energy from an affected individual."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/fatigue/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	M.adjustStaminaLoss(3)
	if(prob(25)) M.reagents_speedmod += 1
	..()
	return

datum/reagent/toxin/curare //A bit like lexorin, a bit different. I would say worse, though it deals damage slightly slower.
	name = "Curare"
	id = "curare"
	description = "A lovely organic plant based compound that you don't want to get in your bloodstream. Causes paralysis of all skeletal muscles in the body... Including the diaphragm, making it impossible to breathe."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	toxpwr = 1

datum/reagent/toxin/curare/on_mob_life(var/mob/living/M as mob)
	if(M.stat == 2.0)
		return
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(2)
	if(prob(70)) M.Weaken(2)
	if(prob(20)) M.emote("gasp")
	..()
	return

datum/reagent/toxin/phenol
	name = "Phenol"
	id = "phenol"
	description = "An organic plant-based compound. Naturally quite harmless, as it appears in only trace amounts. When distilled, however, it can form a powerful topical analgaesic or neurotoxin."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103
	toxpwr = 0
	var/stage = 0

datum/reagent/toxin/phenol/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(!data) data = 1
	stage++
	switch(stage)
		if(5 to 10)
			M.confused += 2
			M.Dizzy(3)
			if(prob(50))
				M.drowsyness += 1
		if(10 to 30)
			if(prob(data*3))
				M.Weaken(1)
			M.confused += 2
			M.drowsyness += 4
			M.druggy += 1
			M.Dizzy(3)
			M.adjustToxLoss(1)
		if(30 to INFINITY)
			if(istype(M,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				H.unknown_pain += 1
			M.Paralyse(1)
			M.adjustToxLoss(stage-30)
			M.druggy += 3

	holder.remove_reagent(src.id, 0.2 * REAGENTS_METABOLISM) //10u is a lethal dose
	return

datum/reagent/toxin/phenol/reaction_mob(var/mob/living/carbon/human/M, var/method=TOUCH, var/volume)//Splashing people with plasma is stronger than fuel!
	if(!istype(M, /mob/living/carbon/human))
		return
	if(method == TOUCH)
		M.suppress_pain += 40 //Topical analgaesic. I know in actuality phenol only has this effect on epithelial tissue, but this is more interesting.
	else
		M.suppress_pain += 15 //Weaker effect if ingested, but still gives a spurt of less pain.
		M.unknown_pain += 20
	return

datum/reagent/toxin/combattraining
	name = "Combat Training Hallucinogen"
	id = "combattraining"
	description = "A powerful hallucinogen. Makes you percieve attackers, and thus used to be used in combat training before it was outdated."
	reagent_state = LIQUID
	color = "#B31008" // rgb: 139, 166, 233
	toxpwr = 0

datum/reagent/toxin/combattraining/on_mob_life(var/mob/living/M)
	if(!M) M = holder.my_atom
	if(prob(volume))
		fake_attack(M)  //Makes sure that the hallucinations will probably fake attackers
	M.hallucination += 5
	..()
	return

/datum/addiction
	var/name = "Generic Chemical Dependancy"
	var/desc = "A reliance a certain compound, resulting in withdrawal when it is lacked."
	var/ticks = 0 //How long the subject has gone without the compound.
	var/severity = 2 //How bad withdrawal is.
	var/recovery = 1000 //How many ticks it takes to lose the addiction.
	var/addictionid = "" //The id of the compound you are addicted to.
	var/addictionname = "" //The name of the compound you are addicted to.

	proc/on_mob_life(var/mob/living/carbon/human/H)
		if(H.reagents.has_reagent(addictionid)) //You don't feel withdrawal if you have the chem in you. Neither can you kick the addiction.
			if(src.ticks > 0)
				src.ticks = 0
			return
		src.ticks ++
		var/list/factions = list("SLAANESH")
		if(length(factions & H.factions))
			H.addictions.Remove(src)
		if(src.ticks >= recovery)
			H.addictions.Remove(src)
		if(ticks*severity >= 1000)
			if(prob(3))
				H << pick("\red You feel sick with withdrawal.","\red You NEED [addictionname].", "\red You don't feel good...")
		switch(ticks*severity)
			if(0 to 1000)
				return
			if(1000 to 1501)
				if(prob(5))
					H.Stun(1)
					H.emote("twitch")
				if(prob(15))
					H.Dizzy(1)
				if(prob(10))
					if(H.health >= 30)
						H.adjustToxLoss(1)
			if(1501 to 2000)
				if(prob(10))
					H.damageoverlaytemp = 60
				if(prob(15))
					H.Dizzy(2)
				if(prob(15))
					if(H.health >= 30)
						H.adjustToxLoss(1)
				if(prob(10))
					H.Stun(1)
					H.emote("twitch")
			if(2001 to 3000)
				if(prob(40))
					H.damageoverlaytemp = 60
					H.Dizzy(1)
					if(H.health >= 30)
						H.adjustToxLoss(1)
			if(3001 to 4000)
				if(prob(60))
					H.damageoverlaytemp = 60
					H.Dizzy(1)
					if(H.health >= 30)
						H.adjustToxLoss(1)
				H.confused += 1
			if(4001 to 5000)
				if(prob(80))
					H.damageoverlaytemp = 60
					H.Dizzy(2)
					if(H.health >= 30)
						H.adjustToxLoss(1)
				H.confused += 1
			if(5001 to 6000)
				if(prob(5))
					H.Paralyse(1)
				if(prob(80))
					if(prob(80))
						H.damageoverlaytemp = 60
					else
						shake_camera(H, 5, 1)
					H.Dizzy(2)
					if(H.health >= 20)
						H.adjustToxLoss(1)
				H.confused += 2
			if(6001 to 7000)
				if(prob(10))
					H.Paralyse(1)
				if(prob(90))
					if(prob(70))
						H.damageoverlaytemp = 60
					else
						shake_camera(H, 5, 1)
					H.Dizzy(2)
					if(H.health >= 10)
						H.adjustToxLoss(1)
				H.confused += 2
				H.Dizzy(1)
				H.hallucination += 2
			if(7001 to 8000)
				if(prob(20))
					H.Paralyse(1)
				if(prob(90))
					if(prob(60))
						H.damageoverlaytemp = 60
					else
						shake_camera(H, 5, 1)
					H.eye_blurry = max(H.eye_blurry, 3)
					if(H.health >= 5)
						H.adjustToxLoss(2)
				H.confused += 4
				H.Dizzy(2)
				H.hallucination += 3
			if(9001 to 10000)
				if(prob(20))
					H.Paralyse(1)
				if(prob(50))
					H.damageoverlaytemp = 60
				else
					shake_camera(H, 5, 1)
				H.eye_blurry = max(H.eye_blurry, 3)
				H.confused += 6
				H.Dizzy(3)
				H.drowsyness += 2
				H.hallucination += 5
				H.adjustToxLoss(2)
			if(10001 to INFINITY)
				H.adjustToxLoss(5)
				H.Paralyse(5)

/datum/addiction/severe //This means at the end of the addiction you will be badly debilitated and half poisoned to death. It is survivable though.
	name = "Severe Chemical Dependancy"
	recovery = 2000
	severity = 3

datum
	reagent

		var/process_dead = 0
		var/addictive = 0
		var/addictiontype = null

		boost
			name = "Selective Manufacturing Enzyme"
			id = "boost"
			description = "An enzyme that increases levels of helpful chemicals. This is one of the secrets to unlocking many of the most powerful applications of chemistry."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE
			var/boosted = list("inaprovalene","tricordrazine","bicardine","anti_toxin","dexalinp","dexalin","imidazoline","dermaline","kelotane","doctorsdelight","synaptizine")

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				for(var/A in holder.reagent_list)
					var/datum/reagent/R = A
					if(R.id in boosted && R.volume < src.volume)
						R.volume ++
				return

		increase
			name = "Manufacturing Enzyme"
			id = "increase"
			description = "An enzyme that increases the levels of any chemicals present in the individual it is exposed to."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE
			process_dead = 1
			var/dontmake = list("increase","boost")

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				if(M.stat == DEAD && prob(80)) return //Works on dead people, but not nearly as quickly.
				for(var/A in holder.reagent_list)
					var/datum/reagent/R = A
					if(R.volume < src.volume && !(R.id in dontmake))
						R.volume ++
				return

		destroyer
			name = "Flame Venom"
			id = "destroyer"
			description = "A rare biocatalyst that causes the victim's blood to boil, generally extracted from a fire scorpion. The reaction is so violent that the victim's body will eventually be torn apart by it."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE
			process_dead = 1

			on_mob_life(var/mob/living/carbon/M as mob)
				if(M.stat == 2.0)
					M << "\red <b>Your blood boils.</b>"
					M.gib()
					return
				if(!M) M = holder.my_atom
				M.adjustToxLoss(1)
				M.take_organ_damage(0, 2)
				if(prob(30))
					M << pick("\red You feel a burning sensation in your veins","\red You feel a pressure building up beneath your skin","\red You don't feel too good...","\red Your chest hurts...")
				if(prob(10))
					M.take_organ_damage(20, 0)
					new /obj/effect/gibspawner/blood(M.loc)
					M.update_damage_overlays(0)
					M.visible_message("\red <b>[M]'s skin bursts in a shower of blood!</b>")
				return

		strangle
			name = "Pneudelozine"
			id = "strangle"
			description = "A toxin that causes the victim's neck muscles to collapse the trachea, effectively strangling them and rendering them incapable of speech in even harmless doses. It is theoretically curable, but not easily. If a significant amount of pneudelozine is present, it acts as an extremely potent general neurotoxin, causing shaking, paralysis, ruptured blood vessels, poisoning, and further asphyxiation due to the fact that your body has effectively shut down."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE

			on_mob_life(var/mob/living/carbon/M as mob)
				if(!M) M = holder.my_atom
				if(volume>20)
					M << pick("<b><font color='red' size='five'><b><i>OH GOD</b></i></font>","<b><font color='red' size='five'><b><i>NO AIR</b></i></font>","<b><font color='red' size='five'><b><i>DYING</b></i></font>","<b><font color='red' size='five'><b><i>CAN'T MOVE</b></i></font>","<b><font color='red' size='five'><b><i>YOUR BLOOD BOILS</b></i></font>")
					M.adjustOxyLoss(7) //And a significant quantity can act as a general neurotoxin, causing shaking, ruptured veins, paralysis, poisoning, and ramped up oxyloss.
					M.adjustToxLoss(5)
					M.take_organ_damage(2, 1)
					M.Jitter(10)
					M.Paralyse(10)
				if(volume>3)
					if(volume<20)
						M << pick("\red You feel like an invisible hand is strangling you.","\red You can't breathe!","\red Your throat is horribly constricted!","\red You feel lightheaded...","\red You feel dizzy...","\red Your heart races!")
					M.adjustOxyLoss(6) //This way, a bit can nonlethally silence you without dealing any damage.
				else
					if(prob(50))
						M << pick("\red Your throat constricts.","\red Your neck muscles twitch","\red You feel lightheaded...")
					M.adjustOxyLoss(1)
				M.silent = max(M.silent, 10)
				..()
				return

		thujone
			name = "Thujone"
			id = "thujone"
			description = "An organic chemical compound found in several plant oils. Causes seizures. Also causes minor hallucinations which are much, much worse in conjugation with any kind of alchohol. Used in absinthe."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE

			on_mob_life(var/mob/living/carbon/M as mob)
				if(!M) M = holder.my_atom
				if(volume > 3) //Trace amounts are still harmless.
					if(prob(10))
						M << "\red You have a seizure!"
					if(prob(50))
						shake_camera(M, 20, 2) //This really screws you up. I intend to make it difficult to get.
					else
						shake_camera(M, 20, 1) //If it is constantly at 2 you will probably have a seizure.
					M.Weaken(5)
					M.Jitter(5)
					M.Dizzy(10) //You are dizzy after the seizures wear off.
					M.hallucination += 1 //Minor hallucinations
					for(var/A in holder.reagent_list)
						var/datum/reagent/R = A
						if(istype(R,/datum/reagent/ethanol))
							M.hallucination += 14  //Which are worse than mindbreaker if you have alchohol in you as well.
					if(prob(5))
						M.adjustOxyLoss(1)
					if(prob(15))
						M.take_organ_damage(1, 0)
					if(prob(20))
						M.adjustToxLoss(1)
				..()
				return

		ricin //Highly toxic, thujone's evil twin
			name = "Ricin"
			id = "ricin"
			description = "An organic chemical compound found in castor beans. Highly toxic."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			var/stage = 0

			on_mob_life(var/mob/living/carbon/M as mob)
				if(!M) M = holder.my_atom
				stage++
				switch(stage)
					if(100 to 200)
						if(prob(1))
							M.emote("sway")
							M << "\red You feel kind of sick..."
					if(201 to 300)
						if(prob(25))
							M.adjustToxLoss(1)
					if(301 to INFINITY)
						if(prob(20))
							M << "\red You have a seizure!"
							if(prob(50))
								shake_camera(M, 20, 2) //This really screws you up. I intend to make it difficult to get.
							else
								shake_camera(M, 20, 1) //If it is constantly at 2 you will probably have a seizure.
							M.Weaken(5)
							M.Jitter(5)
							M.Dizzy(10) //You are dizzy after the seizures wear off.
						M.adjustOxyLoss(2)
						M.take_organ_damage(1, 0)
						M.adjustToxLoss(4)
						if(istype(M,/mob/living/carbon/human))
							var/mob/living/carbon/human/H = M
							H.unknown_pain += 1
				if(prob(65))
					holder.remove_reagent(src.id, 0.01) //Absurdly slow depletion rate.
				//..()
				return

		freeze
			name = "Endocryalin"
			id = "freeze"
			description = "An enzyme with an extremely low activation energy that absorbs heat from a human body down to extreme temperatures. This can be used to improvise cryogenics, or to incapacitate."
			reagent_state = LIQUID
			color = "#000067"
			overdose = 100

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				M.bodytemperature = 60
				if(prob(3))
					M.emote("shiver")
				..()
				return

		sfreeze
			name = "Endocryalin Concentrate"
			id = "sfreeze"
			description = "The concentrated form of endocryalin which can cause body temperature to drop within a few degrees of absolute zero."
			reagent_state = LIQUID
			color = "#000067"
			overdose = 100

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				M.sleeping += 1 //Actually puts you to sleep. Excellent for cryogenics, or as a difficult to make but powerful sedative.
				M.bodytemperature = 10
				if(prob(3))
					M.emote("shiver")
				..()
				return

		stealth //Now this stuff is evil.
			name = "Bicaridine"
			id = "stealth"
			description = "A toxin that only takes effect after some time has passed, silencing and strangling the victim as if an invisible hand clutched their throat. Looks a lot like bicaridine."
			reagent_state = LIQUID
			color = "#13BC5E" // rgb: 19, 188, 94
			overdose = REAGENTS_OVERDOSE
			var/timer = 500

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				if(!timer)
					M.reagents.add_reagent("strangle",volume)
					holder.remove_reagent(id, volume)
				else
					timer -= 1
				//.. ()
				return

		toxpurge
			name = "Rapid Reagent Metabolizer"
			id = "toxpurge"
			description = "A chemical used for negating rare toxins. Purges the affected individual of all reagents."
			reagent_state = LIQUID
			color = "#500080" // rgb: 96, 165, 132
			overdose = REAGENTS_OVERDOSE

			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				for(var/A in holder.reagent_list)
					var/datum/reagent/R = A
					R.volume -= 0.5
				..()
				return

datum/reagent/meth
	name = "Snake"
	id = "meth"
	description = "Ride the snake.... This is also known as barrage in some regions of the imperium."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	addictive = 1
	addictiontype = /datum/addiction
	var/damage = 0

datum/reagent/meth/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(prob(15)) M.emote(pick("twitch","blink_r","shiver"))
	//M.status_flags |= GOTTAGOFAST
	M.AdjustStunned(-10) //Basically unstunnable.
	M.AdjustWeakened(-10)
	M.druggy += 1
	M.Dizzy(1)
	if(!M.confused) M.confused = 1
	M.confused = max(M.confused, 5)
	if(M.getBruteLoss()) //Delays being impacted by damage, but eventually makes it return even worse then it was.
		M.heal_organ_damage(5,0) //Pretty effective.
		damage += 5
		spawn(600) //Still gives you basically a minute before feeling brute damage.
			if(M) M.take_organ_damage(6,0)
			damage -= 5
	..()
	return

datum/reagent/meth/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/living/M = holder.my_atom
		M.take_organ_damage(round((damage*6)/5), 0)
	..()

datum/reagent/toxin/plague
	name = "Biohazardous Plague Infected Shit"
	description = "You should probably rub this stuff all over your face."
	id = "plague"
	reagent_state = LIQUID
	color = "#53AE66"
	toxpwr = 0
	var/effect = null

datum/reagent/toxin/plague/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human/whitelisted/pmleader) || istype(M, /mob/living/carbon/human/whitelisted/pm)) return
	for(var/datum/disease/plague/D in M.viruses) //Don't do anything if they are already infected.
		src.effect = D.effect //But mimic their effect, because maybe this is the infected person emitting the stuff.
		..()
		return
	var/datum/disease/plague/D = new /datum/disease/plague()
	if(src.effect)
		D.effect = src.effect
	else
		D.effect = pick("weaken", "blind", "bleeding", "necrosis", "nurgling", "toxification")
	M.contract_disease(D, 1, 0)
	if(!M.resistances.Find(D.type))
		M << "\red Your body reacts violently to the infection you are exposed to!"
		shake_camera(M, 20, 1)
		M.Weaken(5)
		M.Jitter(5)
		M.Dizzy(10)
	..()
	return

datum/reagent/triumvirate
	name = "Satrophine"
	id = "triumvirate"
	description = "A mix of potent stimulants."
	reagent_state = LIQUID
	color = "#CCCCCC"
	addictive = 1
	addictiontype = /datum/addiction
	var/brutebuffer = 0
	var/firebuffer = 0
	var/toxbuffer = 0
	var/oxybuffer = 0
	var/buffermode = "absorb"
	var/buffer_absorb = 20
	var/buffer_release = 2
	var/max_buffer = 300

datum/reagent/triumvirate/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	//if(prob(15)) M.emote(pick("twitch","blink_r","shiver"))
	M.ignore_pain += 5
	M.suppress_pain += 5
	M.adjustStaminaLoss(-10)
	M.AdjustStunned(-10)
	M.AdjustWeakened(-10)
	M.AdjustParalysis(-10)
	M.drowsyness = 0
	M.eye_blurry = 0
	M.reagents_speedmod = min(M.reagents_speedmod, -12)
	M.next_click -= 1
	M.inertial_speed += 2
	spawn(2) M.next_click -= 1
	spawn(4) M.next_click -= 1
	spawn(6) M.next_click -= 1
	spawn(8) M.next_click -= 1
	spawn(10) M.next_click -= 1
	M.adjustToxLoss(pick(2, 3))
	var/total_buffered = brutebuffer + firebuffer + toxbuffer + oxybuffer
	if(M.health >= M.maxHealth - 30)
		buffermode = "release"
	if(M.health < M.maxHealth - 30)
		buffermode = "absorb"
	if(total_buffered >= max_buffer)
		buffermode = "release"
	if(total_buffered <= 0)
		buffermode = "absorb"
	switch(buffermode)
		if("absorb")
			if(M.getBruteLoss())
				M.heal_organ_damage(min(buffer_absorb, M.getBruteLoss()),0)
				brutebuffer += min(buffer_absorb, M.getBruteLoss())
			if(M.getFireLoss())
				M.heal_organ_damage(0,min(buffer_absorb, M.getFireLoss()))
				firebuffer += min(buffer_absorb, M.getFireLoss())
			if(M.getToxLoss())
				M.adjustToxLoss(max(-buffer_absorb, -M.getToxLoss()))
				toxbuffer += min(buffer_absorb, M.getToxLoss())
			if(M.getOxyLoss())
				M.adjustOxyLoss(max(-buffer_absorb, -M.getOxyLoss()))
				oxybuffer += min(buffer_absorb, M.getOxyLoss())
		if("release")
			if(brutebuffer)
				M.take_organ_damage(buffer_release, 0)
				brutebuffer -= buffer_release
			if(firebuffer)
				M.take_organ_damage(0, buffer_release)
				firebuffer -= buffer_release
			if(toxbuffer)
				M.adjustToxLoss(buffer_release)
				toxbuffer -= buffer_release
			if(oxybuffer)
				M.adjustOxyLoss(buffer_release)
				oxybuffer -= buffer_release
	..()
	return

datum/reagent/triumvirate/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/living/M = holder.my_atom
		M.take_organ_damage(brutebuffer, 0)
		M.take_organ_damage(firebuffer, 0)
		M.adjustToxLoss(toxbuffer)
		M.adjustOxyLoss(oxybuffer)
	..()

datum/reagent/triumvirate/overdrive
	name = "Onslaught"
	description = "One of the main things given to eversors."
	id = "overdrive"
	buffer_absorb = 60
	buffer_release = 8
	max_buffer = 1000
	addictiontype = /datum/addiction/severe

datum/reagent/triumvirate/overdrive/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	M.speedboost = 1
	M.inertial_speed += 10
	..()

datum/reagent/triumvirate/overdrive/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/living/M = holder.my_atom
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			H.speedboost = 0
	..()

datum/reagent/colors
	name = "Magical Color Changing Shit"
	id = "colors"
	description = "It's magic. We don't have to explain this shit."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/colors/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	animate(M, color = "#[pick("C73232","5998FF","2A9C3B","CFB52B","AE4CCD","FFFFFF","333333")]", time = 15)
	..()
	return

datum/reagent/colors/Del()
	if(holder && ismob(holder.my_atom))
		var/mob/living/M = holder.my_atom
		M.color = null
	..()

datum/reagent/growth2
	name = "Super Growth Serum"
	id = "growth2"
	description = "A wierd chemical that makes you grow. A lot. And the effects don't wear off."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	var/grown = 0

datum/reagent/growth2/on_mob_life(var/mob/living/H as mob)
	if(!H) H = holder.my_atom
	if(!istype(H,/mob/living/carbon/human)) return
	var/mob/living/carbon/human/M = H
	if(!grown)
		grown = 1
		animate(M, transform = (M.transform*TransformUsingVariable(100, 100, 0.5)), time = 400)
		M.maxHealth += 100
		M.health += 100
	..()
	return