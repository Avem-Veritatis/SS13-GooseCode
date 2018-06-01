/mob/living/carbon/human/attack_hand(mob/living/carbon/human/M)
	if(..())	//to allow surgery to return properly.
		return

	if((M != src) && check_shields(0, M.name))
		add_logs(M, src, "attempted to touch")
		visible_message("<span class='warning'>[M] attempted to touch [src]!</span>")
		return 0

	if(M.a_intent != "help" && M.inertial_speed <= 4)
		var/obj/item/D = src.get_active_hand()
		if(D && D.complex_block && src.dir != M.dir) //A parrying weapon can easily counter a head on hand-to-hand attack.
			visible_message("<span class='warning'>[src] deflected an attack from [M] with the [D]!</span>")
			M.take_organ_damage(rand(5, 10), 0)
			step_away(M,src,10)
			return

	switch(M.a_intent)
		if("help")
			if(health >= 0)
				help_shake_act(M)
				if(src != M)
					add_logs(M, src, "shaked")
				return 1

			//CPR
			if((M.head && (M.head.flags & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags & MASKCOVERSMOUTH)))
				M << "<span class='notice'>Remove your mask!</span>"
				return 0
			if((head && (head.flags & HEADCOVERSMOUTH)) || (wear_mask && (wear_mask.flags & MASKCOVERSMOUTH)))
				M << "<span class='notice'>Remove their mask!</span>"
				return 0

			if(cpr_time < world.time + 30)
				add_logs(src, M, "CPRed")
				visible_message("<span class='notice'>[M] is trying to perform CPR on [src]!</span>")
				if(!do_mob(M, src))
					return 0
				if((health >= -99 && health <= 0))
					cpr_time = world.time
					var/suff = min(getOxyLoss(), 7)
					adjustOxyLoss(-suff)
					updatehealth()
					M.visible_message("[M] performs CPR on [src]!")
					src << "<span class='unconscious'>You feel a breath of fresh air enter your lungs. It feels good.</span>"

		if("grab")
			if(M == src || anchored)
				return 0

			if(M.inertial_speed != null)
				if(M.inertial_speed >= 2)
					add_logs(M, src, "tackled", addition="with inertial speed [M.inertial_speed]")
					if(M.dir == src.dir && !src.lying)
						M << "\red You use your momentum to tackle [src] from behind."
					else
						M << "\red You use your momentum to tackle [src]."
					playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
					visible_message("<span class='danger'>[M] has tackled [src]!</span>",
								"<span class='userdanger'>[M] has tackled [src]!</span>")
					M.Weaken(3)
					if(M.dir == src.dir && !src.lying)
						src.Weaken(3+M.inertial_speed)
					else
						src.Weaken(2+M.inertial_speed)
					src.drop_item()
					return

			add_logs(M, src, "grabbed", addition="passively")

			if(w_uniform)
				w_uniform.add_fingerprint(M)

			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M, src)
			if(buckled)
				M << "<span class='notice'>You cannot grab [src], \he is buckled in!</span>"
			if(!G)	//the grab will delete itself in New if affecting is anchored
				return
			M.put_in_active_hand(G)
			G.synch()
			LAssailant = M

			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			if(M.dir == src.dir && !src.lying)
				visible_message("<span class='warning'>[M] has grabbed [src] passively from behind!</span>")
				Weaken(1)
			else
				visible_message("<span class='warning'>[M] has grabbed [src] passively!</span>")
			return 1

		if("harm")
			add_logs(M, src, "punched")

			var/attack_verb = "punch"
			if(lying)
				attack_verb = "kick"
			else if(M.dna)
				switch(M.dna.mutantrace)
					if("lizard")
						attack_verb = "scratch"
					if("plant")
						attack_verb = "slash"

			var/damage = rand(0, 9)
			if(!damage)
				switch(attack_verb)
					if("slash")
						playsound(loc, 'sound/weapons/slashmiss.ogg', 25, 1, -1)
					else
						playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)

				visible_message("<span class='warning'>[M] has attempted to [attack_verb] [src]!</span>")
				return 0


			var/obj/item/organ/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")

			if(HULK in M.mutations)
				damage += 5

			if(M.reagents_punchmod)
				damage += M.reagents_punchmod

			if(M.inertial_speed != null && M.inertial_speed >= 5 && !src.lying) //The advantages of high speed.
				var/obj/item/W = M.get_inactive_hand()
				if(istype(W, /obj/item/weapon/complexknife/))
					visible_message("<span class='danger'>[M] slashes at [src] with the [W]!</span>")
					src.Weaken(1)
					src.density = 0 //Lets them hit and run if they are skilled enough.
					spawn(3) src.density = 1
					new /obj/effect/gibspawner/blood(src.loc)
					apply_damage(W.force, BRUTE, affecting, armor_block/2)
				if(istype(W, /obj/item/weapon/twohanded/chainswordig/))
					visible_message("<span class='danger'>[M] brings the [W] down over [src]'s head!</span>")
					playsound(get_turf(src), 'sound/weapons/chainsword.ogg', 75, 0)
					src.Weaken(1)
					src.density = 0 //Lets them hit and run if they are skilled enough.
					spawn(3) src.density = 1
					new /obj/effect/gibspawner/blood(src.loc)
					apply_damage(W.force, BRUTE, affecting, armor_block/2)
				if(istype(W, /obj/item/weapon/chainsword/))
					visible_message("<span class='danger'>[M] stabs the [W] at [src]'s chest!</span>")
					playsound(get_turf(src), 'sound/weapons/chainsword.ogg', 75, 0)
					src.Weaken(1)
					new /obj/effect/gibspawner/blood(src.loc)
					apply_damage(W.force, BRUTE, affecting, armor_block/2)
				if(istype(W, /obj/item/weapon/powersword/))
					visible_message("<span class='danger'>[M] slams their power blade into [src] mid-charge!</span>")
					if(istype(W, /obj/item/weapon/powersword/burning))
						src.fire_stacks += 5
						src.IgniteMob()
					src.drop_item()
					src.Weaken(6)
					apply_damage(W.force, BRUTE, affecting, armor_block)
					step_away(src,M,10) //A for loop would be better but copypasta is faster...
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					step_away(src,M,10)
					return
				damage += 10
				add_logs(M, src, "drop kicked")
				visible_message("<span class='danger'>[M] has drop kicked [src]!</span>", \
						"<span class='userdanger'>[M] has drop kicked [src]!</span>")
				apply_damage(damage, BRUTE, affecting, armor_block)
				src.drop_item()
				src.Weaken(6)
				M.Weaken(1)
				return

			else if(M.inertial_speed != null)
				if(M.inertial_speed >= 2)
					M << "\red You use your momentum to land a more forceful blow."
					damage += inertial_speed

			else if(M.dir == src.dir && !src.lying)
				M << "\red You attack [src] from behind."
				damage += 2

			switch(attack_verb)
				if("slash")
					playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
				else
					playsound(loc, "punch", 25, 1, -1)

			visible_message("<span class='danger'>[M] has [attack_verb]ed [src]!</span>", \
						"<span class='userdanger'>[M] has [attack_verb]ed [src]!</span>")

			apply_damage(damage, BRUTE, affecting, armor_block)
			if((stat != DEAD) && damage >= 9)
				visible_message("<span class='danger'>[M] has weakened [src]!</span>", \
								"<span class='userdanger'>[M] has weakened [src]!</span>")
				apply_effect(4, WEAKEN, armor_block)
				forcesay(hit_appends)
			else if(lying)
				forcesay(hit_appends)

		if("disarm")
			add_logs(M, src, "disarmed")

			if(M.inertial_speed != null)
				if(M.inertial_speed >= 2)
					M << "\red You use your momentum to push [src]."
					playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
					visible_message("<span class='danger'>[M] has slammed into [src]!</span>",
								"<span class='userdanger'>[M] has slammed into [src]!</span>")
					if(prob(50))
						src.drop_item()
					if(prob(50))
						M.Weaken(1+inertial_speed)
					if(prob(75))
						src.Weaken(2+inertial_speed)
					if(CANPUSH & src.status_flags)
						step_away(src,M,inertial_speed)
						step_away(src,M,inertial_speed)
					else
						step_away(src,M,inertial_speed)
					return

			if(w_uniform)
				w_uniform.add_fingerprint(M)
			var/obj/item/organ/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/randn = rand(1, 100)
			if(randn <= 25)
				apply_effect(2, WEAKEN, run_armor_check(affecting, "melee"))
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				visible_message("<span class='danger'>[M] has pushed [src]!</span>",
								"<span class='userdanger'>[M] has pushed [src]!</span>")
				forcesay(hit_appends)
				return

			var/talked = 0	// BubbleWrap

			if(randn <= 60)
				//BubbleWrap: Disarming breaks a pull
				if(pulling)
					visible_message("<span class='warning'>[M] has broken [src]'s grip on [pulling]!</span>")
					talked = 1
					stop_pulling()

				//BubbleWrap: Disarming also breaks a grab - this will also stop someone being choked, won't it?
				if(istype(l_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/lgrab = l_hand
					if(lgrab.affecting)
						visible_message("<span class='warning'>[M] has broken [src]'s grip on [lgrab.affecting]!</span>")
						talked = 1
					spawn(1)
						qdel(lgrab)
				if(istype(r_hand, /obj/item/weapon/grab))
					var/obj/item/weapon/grab/rgrab = r_hand
					if(rgrab.affecting)
						visible_message("<span class='warning'>[M] has broken [src]'s grip on [rgrab.affecting]!</span>")
						talked = 1
					spawn(1)
						qdel(rgrab)
				//End BubbleWrap

				if(!talked)	//BubbleWrap
					if(drop_item())
						visible_message("<span class='danger'>[M] has disarmed [src]!</span>", \
										"<span class='userdanger'>[M] has disarmed [src]!</span>")
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return


			playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] attempted to disarm [src]!</span>", \
							"<span class='userdanger'>[M] attemped to disarm [src]!</span>")
	return

/mob/living/carbon/human/proc/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, inrange, params)
	return