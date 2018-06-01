/obj/item/clothing/under/surgerycybernetic
	desc = "A fine upgrade to the human form. It opens up the biotics tab for you. Look in the upper right hand corner."
	name = "Surgical Mechadendrite"
	icon = 'icons/obj/pipes/regular.dmi'
	icon_state = "surgical"
	item_state = "surgical"
	item_color = "surgical"
	has_sensor = 1
	can_roll = 0
	armor = list(melee = 15, bullet = 0, laser = 5,energy = 0, bomb = 5, bio = 25, rad = 25)
	flags = NODROP | STOPSPRESSUREDMAGE
	flags_inv = HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	var/usetime = 0
	var/surgery = 0

	verb/useinjector()
		set name = "Anaesthetic Injector"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 50)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/surgery(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/surgery(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/reagent_containers/hypospray/medicus/surgery(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/heal(var/mob/living/carbon/human/T in view(usr, 1))
		set name = "Render Surgical Aid"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "The mechadendrite is charging!"
			return
		if(!T.getBruteLoss() && !T.getFireLoss())
			usr << "\red [T] is uninjured."
			return
		if(surgery)
			usr << "\red You are already performing a surgery."
			return
		if(!ishuman(T))
			usr << "\red What... What is this?! This isn't even a human!"
			return
		usetime = world.time
		surgery = 1
		usr << "You begin to perform emergency surgery on [T]..."
		usr.visible_message("\red <B>[usr]'s surgical mechadendrite whirs to action in a flurry of moving parts over [T]!</B>")
		playsound(loc, 'sound/weapons/circsawhit.ogg', 75, 0)
		new /obj/effect/gibspawner/blood(T.loc)
		if(T.suppress_pain > 10 || T.unknown_pain > 10)
			T << "You notice scalpels and needles cutting into your flesh and sewing you back together, but feel no pain."
		else
			T << "\red <b>You feel a massive and unbearable pain as scalpels and needles tear into your flesh and sew you back together.</b>"
			T.emote("scream")
			T.damageoverlaytemp = 60
		for(var/stage = 1, stage<=8, stage++)
			sleep(30)
			if(get_dist(get_turf(usr),get_turf(T)) > 1 || usr.stat || usr.restrained())
				usr.visible_message("\red <B>[usr]'s surgical equipment is torn out of [T]!</B>")
				usr << "\red Surgery has been interrupted."
				if(T.suppress_pain > 10 || T.unknown_pain > 10)
					T << "Surgical equipment is ripped out of you mid-operation. You barely feel it."
				else
					T << "\red <b>Surgical equipment is ripped out of your body mid-operation in a shower of blood! IT HURTS LIKE HELL!</b>"
					T.emote("scream")
					T.Weaken(5)
					T.damageoverlaytemp = 60
				T.take_organ_damage(40, 0)
				new /obj/effect/gibspawner/blood(T.loc)
				surgery = 0
				return
			if(T.suppress_pain > 10 || T.unknown_pain > 10)
				T << "You notice surgical implements shifting around in your body."
			else
				T << pick("\red <b>Scalpels and saws tear through your flesh!</b>", "\red <b>OH EMPEROR! THE PAIN!</b>", "\red <b>Your feel like a thousand small knives are being driven into your body! Which coincidentally is the case.</b>", "\red <b>The mechanical blades and saws work with painful efficiency, piecing you back together.</b>")
				T.emote("scream")
				T.Weaken(5)
				T.damageoverlaytemp = 60
			T.heal_organ_damage(10, 10)
		usr.visible_message("\red <B>[usr] finishes their surgery on [T]!</B>")
		usr << "\red Surgery has been completed."
		surgery = 0

	verb/augment(var/mob/living/carbon/human/T in view(usr, 1))
		set name = "Surgical Augmentation"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "The mechadendrite is charging!"
			return
		if(surgery)
			usr << "\red You are already performing a surgery."
			return
		if(!ishuman(T))
			usr << "\red What... What is this?! This isn't even a human!"
			return
		usetime = world.time
		surgery = 1
		usr << "You begin to perform augmentation surgery on [T]..."
		usr.visible_message("\red <B>[usr]'s surgical mechadendrite whirs to action in a flurry of moving parts over [T]!</B>")
		playsound(loc, 'sound/weapons/circsawhit.ogg', 75, 0)
		new /obj/effect/gibspawner/blood(T.loc)
		if(T.suppress_pain > 10 || T.unknown_pain > 10)
			T << "You notice scalpels and needles cutting into your flesh and sewing you back together, but feel no pain."
		else
			T << "\red <b>You feel a massive and unbearable pain as scalpels and needles tear into your flesh and sew you back together.</b>"
			T.emote("scream")
			T.damageoverlaytemp = 60
		for(var/stage = 1, stage<=8, stage++)
			sleep(30)
			if(get_dist(get_turf(usr),get_turf(T)) > 1 || usr.stat || usr.restrained())
				usr.visible_message("\red <B>[usr]'s surgical equipment is torn out of [T]!</B>")
				usr << "\red Surgery has been interrupted."
				if(T.suppress_pain > 10 || T.unknown_pain > 10)
					T << "Surgical equipment is ripped out of you mid-operation. You barely feel it."
				else
					T << "\red <b>Surgical equipment is ripped out of your body mid-operation in a shower of blood! IT HURTS LIKE HELL!</b>"
					T.emote("scream")
					T.damageoverlaytemp = 60
					T.Weaken(5)
				T.take_organ_damage(40, 0)
				new /obj/effect/gibspawner/blood(T.loc)
				surgery = 0
				return
			if(T.suppress_pain > 10 || T.unknown_pain > 10)
				T << "You notice surgical implements shifting around in your body."
			else
				T << pick("\red <b>Scalpels and saws tear through your flesh!</b>", "\red <b>OH EMPEROR! THE PAIN!</b>", "\red <b>Your feel like a thousand small knives are being driven into your body! Which coincidentally is the case.</b>", "\red <b>The mechanical blades and saws work with painful efficiency, piecing you back together.</b>")
				T.emote("scream")
				T.Weaken(5)
				T.damageoverlaytemp = 60
		usr.visible_message("<span class='notice'>[usr] successfully augments [T]'s [parse_zone(usr.zone_sel.selecting)]!</span>")
		var/obj/item/organ/limb/L
		switch(usr.zone_sel.selecting)
			if("r_arm")
				L = T.getlimb(/obj/item/organ/limb/r_arm)
			if("l_arm")
				L = T.getlimb(/obj/item/organ/limb/l_arm)
			if("r_leg")
				L = T.getlimb(/obj/item/organ/limb/r_leg)
			if("l_leg")
				L = T.getlimb(/obj/item/organ/limb/l_leg)
			if("chest")
				L = T.getlimb(/obj/item/organ/limb/chest)
			if("groin")
				L = T.getlimb(/obj/item/organ/limb/chest)
			if("head")
				L = T.getlimb(/obj/item/organ/limb/head)
			if("eyes")
				L = T.getlimb(/obj/item/organ/limb/head)
			if("mouth")
				L = T.getlimb(/obj/item/organ/limb/head)
		if(L)
			L.loc = get_turf(T)
			T.organs -= L
		switch(usr.zone_sel.selecting)  //for the surgery to progress this MUST still be the original "location" so it's safe to do this.
			if("r_leg")
				T.organs += new /obj/item/organ/limb/robot/r_leg()
			if("l_leg")
				T.organs += new /obj/item/organ/limb/robot/l_leg()
			if("r_arm")
				T.organs += new /obj/item/organ/limb/robot/r_arm()
			if("l_arm")
				T.organs += new /obj/item/organ/limb/robot/l_arm()
			if("head")
				T.organs += new /obj/item/organ/limb/robot/head()
			if("eyes")
				T.organs += new /obj/item/organ/limb/robot/head()
			if("mouth")
				T.organs += new /obj/item/organ/limb/robot/head()
			if("chest")
				var/datum/surgery_step/xenomorph_removal/xeno_removal = new
				xeno_removal.remove_xeno(usr, T) // remove an alien if there is one
				T.organs += new /obj/item/organ/limb/robot/chest()
				for(var/datum/disease/appendicitis/A in T.viruses) //If they already have Appendicitis, Remove it
					A.cure(1)
				T.bleedout = 0 //The only way to save someone from an exitus bullet is to outright replace their entire torsoe...
			if("groin")
				var/datum/surgery_step/xenomorph_removal/xeno_removal = new
				xeno_removal.remove_xeno(usr, T) // remove an alien if there is one
				T.organs += new /obj/item/organ/limb/robot/chest()
				for(var/datum/disease/appendicitis/A in T.viruses) //If they already have Appendicitis, Remove it
					A.cure(1)
		T.update_damage_overlays(0)
		T.update_augments() //Gives them the Cyber limb overlay
		add_logs(usr, T, "augmented", addition="by giving him new [parse_zone(usr.zone_sel.selecting)] INTENT: [uppertext(usr.a_intent)]")
		surgery = 0

	verb/debrain(var/mob/living/carbon/human/T in view(usr, 1))
		set name = "Brain Extraction"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "The mechadendrite is charging!"
			return
		if(surgery)
			usr << "\red You are already performing a surgery."
			return
		if(!ishuman(T))
			usr << "\red What... What is this?! This isn't even a human!"
			return
		usetime = world.time
		surgery = 1
		usr << "You begin to perform brain extraction surgery on [T]..."
		usr.visible_message("\red <B>[usr]'s surgical mechadendrite whirs to action in a flurry of moving parts and starts drilling into [T]'s head!</B>")
		playsound(loc, 'sound/weapons/circsawhit.ogg', 75, 0)
		new /obj/effect/gibspawner/blood(T.loc)
		if(T.suppress_pain > 10 || T.unknown_pain > 10)
			T << "You notice scalpels and saws cutting into your head, but feel no pain."
		else
			T << "\red <b>You feel a massive and unbearable pain as scalpels and saws tear into your skull, probing for your brain.</b>"
			T.emote("scream")
			T.damageoverlaytemp = 60
		for(var/stage = 1, stage<=25, stage++)
			sleep(30)
			if(get_dist(get_turf(usr),get_turf(T)) > 1 || usr.stat || usr.restrained())
				usr.visible_message("\red <B>[usr]'s surgical equipment is torn out of [T]!</B>")
				usr << "\red Surgery has been interrupted."
				if(T.suppress_pain > 10 || T.unknown_pain > 10)
					T << "Surgical equipment is ripped out of you mid-operation. You barely feel it."
				else
					T << "\red <b>Surgical equipment is ripped out of your head mid-operation in a shower of blood! IT HURTS LIKE HELL!</b>"
					T.emote("scream")
					T.damageoverlaytemp = 60
					T.Weaken(5)
				T.take_organ_damage(40, 0)
				new /obj/effect/gibspawner/blood(T.loc)
				surgery = 0
				return
			if(T.suppress_pain > 10 || T.unknown_pain > 10)
				T << "You notice surgical implements shifting around in your head."
			else
				T << pick("\red <b>Scalpels and saws tear through your head!</b>", "\red <b>OH EMPEROR! THE PAIN!</b>", "\red <b>Your feel like a thousand small knives are being driven into your head! Which coincidentally is the case.</b>", "\red <b>The mechanical blades and saws work with painful efficiency, quickly piercing your skull.</b>", "\red <b>YOUR HEAD.</b>", "\red <b>You feel horribly faint.</b>", "\red <b>You feel a worrying numbness as a drill slices through one of your nerves.</b>", "\red <b>Your head is on fire!</b>", "\red <b>You feel a sickening crack reverberate inside your head.</b>", "\red <b>A mechanical hand fumbles around inside your head.</b>")
				T.emote("scream")
				T.Weaken(5)
				T.damageoverlaytemp = 60
		var/obj/item/organ/brain/B = T.getorgan(/obj/item/organ/brain)
		if(!B)
			usr << "\red After all that work, it looks like their brain is already gone."
			surgery = 0
			return
		usr.visible_message("<span class='notice'>[usr] successfully extracts [T]'s brain!</span>")
		B.loc = get_turf(T)
		if(T.key)
			B.transfer_identity(T)
		T.internal_organs -= B
		T.update_hair(0)
		T.apply_damage(25,"brute","head")
		add_logs(usr, T, "debrained", addition="with a surgical mechadendrite. INTENT: [uppertext(usr.a_intent)]")
		surgery = 0

	verb/cavityimplant(var/mob/living/carbon/human/T in view(usr, 1))
		set name = "Cavity Implant"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 100)
			usr << "The mechadendrite is charging!"
			return
		if(surgery)
			usr << "\red You are already performing a surgery."
			return
		if(!ishuman(T))
			usr << "\red What... What is this?! This isn't even a human!"
			return
		usetime = world.time
		surgery = 1
		usr << "You begin to perform brain extraction surgery on [T]..."
		usr.visible_message("\red <B>[usr]'s surgical mechadendrite whirs to action in a flurry of moving parts and starts drilling into [T]'s chest!</B>")
		playsound(loc, 'sound/weapons/circsawhit.ogg', 75, 0)
		new /obj/effect/gibspawner/blood(T.loc)
		if(T.suppress_pain > 10 || T.unknown_pain > 10)
			T << "You notice scalpels and saws cutting into your chest, but feel no pain."
		else
			T << "\red <b>You feel a massive and unbearable pain as scalpels and saws tear into your rib cage.</b>"
			T.emote("scream")
			T.damageoverlaytemp = 60
		for(var/stage = 1, stage<=18, stage++)
			sleep(30)
			if(get_dist(get_turf(usr),get_turf(T)) > 1 || usr.stat || usr.restrained())
				usr.visible_message("\red <B>[usr]'s surgical equipment is torn out of [T]!</B>")
				usr << "\red Surgery has been interrupted."
				if(T.suppress_pain > 10 || T.unknown_pain > 10)
					T << "Surgical equipment is ripped out of you mid-operation. You barely feel it."
				else
					T << "\red <b>Surgical equipment is ripped out of your body mid-operation in a shower of blood! IT HURTS LIKE HELL!</b>"
					T.emote("scream")
					T.damageoverlaytemp = 60
					T.Weaken(5)
				T.take_organ_damage(40, 0)
				new /obj/effect/gibspawner/blood(T.loc)
				surgery = 0
				return
			if(T.suppress_pain > 10 || T.unknown_pain > 10)
				T << "You notice surgical implements shifting around in your body."
			else
				T << pick("\red <b>Scalpels and saws tear through your body!</b>", "\red <b>OH EMPEROR! THE PAIN!</b>", "\red <b>Your feel like a thousand small knives are being driven into your body! Which coincidentally is the case.</b>", "\red <b>The mechanical blades and saws work with painful efficiency, quickly digging into your chest.</b>")
				T.emote("scream")
				T.Weaken(5)
				T.damageoverlaytemp = 60
		var/obj/item/IC = null
		for(var/obj/item/I in T.internal_organs)
			if(!istype(I, /obj/item/organ))
				IC = I
				break
		var/obj/item/tool = T.get_active_hand()
		if(tool)
			if(IC || tool.w_class > 3 || tool.CheckForNukeDisk() || istype(tool, /obj/item/organ))
				usr.visible_message("<span class='notice'>[usr] can't seem to fit [tool] in [T]'s chest cavity.</span>")
				surgery = 0
				return
			usr.visible_message("<span class='notice'>[usr] puts something into [T]'s chest cavity!</span>")
			usr.drop_item()
			T.internal_organs += tool
			tool.loc = T
			add_logs(usr, T, "implanted", addition="with a [tool] using a surgical mechadendrite. INTENT: [uppertext(usr.a_intent)]")
		else
			if(IC)
				usr.visible_message("<span class='notice'>[usr] pulls [IC] out of [T]'s chest cavity!</span>")
				usr.put_in_hands(IC)
				T.internal_organs -= IC
				add_logs(usr, T, "removed the implanted [tool] from", addition="using a surgical mechadendrite. INTENT: [uppertext(usr.a_intent)]")
			else
				usr.visible_message("<span class='notice'>[usr] doesn't find anything in [T]'s chest cavity.</span>")
		surgery = 0

	verb/surgicaldrapes()
		set name = "Surgical Drapes"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/surgical_drapes/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/surgical_drapes/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/surgical_drapes/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/retractor()
		set name = "Retractor"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/retractor/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/retractor/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/retractor/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/hemostat()
		set name = "Hemostat"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/hemostat/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/hemostat/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/hemostat/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/cautery()
		set name = "Cautery"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/cautery/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/cautery/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/cautery/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/drill()
		set name = "Surgical Drill"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/surgicaldrill/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/surgicaldrill/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/surgicaldrill/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/scalpel()
		set name = "Scalpel"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/scalpel/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/scalpel/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/scalpel/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time

	verb/saw()
		set name = "Bone Saw"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(world.time < usetime + 10)
			usr << "The mechadendrite is charging!"
			return
		else
			if(istype(usr.l_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.l_hand)
				usr.put_in_hands(new /obj/item/weapon/circular_saw/cyber(usr))
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/)) //If you are holding something... drop it!
				usr.drop_item(usr.r_hand)
				usr.put_in_hands(new /obj/item/weapon/circular_saw/cyber(usr))
				usr.update_inv_hands()
			else
				usr.put_in_hands(new /obj/item/weapon/circular_saw/cyber(usr))
				usr.update_inv_hands()
			usetime = world.time