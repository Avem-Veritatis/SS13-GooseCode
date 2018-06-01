/mob/living/carbon/human/attack_alien(mob/living/carbon/alien/humanoid/M as mob)
	if(check_shields(0, M.name))
		visible_message("<span class='danger'>[M] attempted to touch [src]!</span>")
		return 0

	switch(M.a_intent)
		if ("help")
			visible_message("<span class='warning'> [M] caresses [src] with its scythe like arm.</span>")
		if ("grab")
			if(M == src || anchored)
				return
			if (w_uniform)
				w_uniform.add_fingerprint(M)

			if(istype(M, /mob/living/carbon/alien/humanoid/tyranid/genestealer))
				var/mob/living/carbon/alien/humanoid/tyranid/genestealer/G = M
				if(G.evol_stage >= 4)
					if(prob(85))
						src.Weaken(4)
						src.drop_items()
						G.start_pulling(src)
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						visible_message("<span class='danger'>[M] has grabbed [src]!</span>")
						return
					else
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						visible_message("<span class='danger'>[M] attempted to grab [src]!</span>")
						return

			if(istype(M, /mob/living/carbon/alien/humanoid/tyranid/lictor))
				var/mob/living/carbon/alien/humanoid/tyranid/lictor/L = M
				if(L.evol_stage >= 4)
					if(prob(85))
						src.Weaken(4)
						src.drop_items()
						L.start_pulling(src)
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						visible_message("<span class='danger'>[M] has grabbed [src]!</span>")
						return
					else
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						visible_message("<span class='danger'>[M] attempted to grab [src]!</span>")
						return

			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M, src)

			M.put_in_active_hand(G)

			G.synch()
			LAssailant = M

			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			visible_message("<span class='danger'>[M] has grabbed [src] passively!</span>")

		if("harm")
			if (w_uniform)
				w_uniform.add_fingerprint(M)
			var/damage = rand(0, 20)
			if(locate(/obj/structure/alien/weeds) in loc) //If the tyranid is defending an area they are much stronger.
				damage += 15
			if(istype(M, /mob/living/carbon/alien/humanoid/tyranid/ravener))
				damage += 10
				var/mob/living/carbon/alien/humanoid/tyranid/ravener/R = M
				if(R.rending_claws)
					playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
					visible_message("<span class='danger'>[M] has slashed at [src] with rending claws!</span>", "<span class='userdanger'>[M] has slashed at [src] with rending claws!</span>")
					src.take_organ_damage(damage, 0) //Goes through armor.
					Weaken(1)
					step_away(src,M,2)
					sleep(3)
					step_away(src,M,2)
					new /obj/effect/gibspawner/blood(src.loc)
					return
			if(istype(M, /mob/living/carbon/alien/humanoid/tyranid/lictor))
				var/mob/living/carbon/alien/humanoid/tyranid/lictor/L = M
				if(L.piercing)
					playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
					visible_message("<span class='danger'>[M] has slashed at [src] with piercing claws!</span>", "<span class='userdanger'>[M] has slashed at [src] with piercing claws!</span>")
					src.take_organ_damage(pick(45, 65), 0) //For an exorbitant price, a lictor can take a stronger opponent quite handily.
					new /obj/effect/gibspawner/blood(src.loc)
					return
			if(!damage)
				playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
				visible_message("<span class='danger'>[M] has lunged at [src]!</span>", \
					"<span class='userdanger'>[M] has lunged at [src]!</span>")
				return 0
			var/obj/item/organ/limb/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")

			playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] has slashed at [src]!</span>", \
				"<span class='userdanger'>[M] has slashed at [src]!</span>")

			apply_damage(damage, BRUTE, affecting, armor_block)
			if (damage >= 25)
				visible_message("<span class='danger'>[M] has wounded [src]!</span>", \
					"<span class='userdanger'>[M] has wounded [src]!</span>")
				apply_effect(4, WEAKEN, armor_block)
			updatehealth()

		if("disarm")
			if(prob(50))
				step_away(src, M, 1)
			var/randn = rand(1, 100)
			if (randn <= 50) //Tackling is slightly less likely to work, but now has a chance to work on less stunnable mobs.
				playsound(loc, 'sound/weapons/pierce.ogg', 25, 1, -1)
				drop_items()
				Weaken(5)
				if(!(CANWEAKEN && src.status_flags)) //Smaller chance to temporarily knock down a more powerful opponent.
					if(prob(20))
						src.Paralyse(3)
				visible_message("<span class='danger'>[M] has tackled down [src]!</span>", \
					"<span class='userdanger'>[M] has tackled down [src]!</span>")
			else
				if (randn <= 99)
					playsound(loc, 'sound/weapons/slash.ogg', 25, 1, -1)
					drop_items()
					visible_message("<span class='danger'>[M] disarmed [src]!</span>", \
						"<span class='userdanger'>[M] disarmed [src]!</span>")
				else
					playsound(loc, 'sound/weapons/slashmiss.ogg', 50, 1, -1)
					visible_message("<span class='danger'>[M] has tried to disarm [src]!</span>", \
						"<span class='userdanger'>[M] has tried to disarm [src]!</span>")
	return
