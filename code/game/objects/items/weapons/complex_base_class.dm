/*
Complex knife class.
*/

/obj/item/weapon/complexknife
	name = "Knife"
	desc = "Report this heresy to an admin please."
	icon_state = "cknife"
	item_state = "knife"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 20
	throwforce = 25
	w_class = 3
	attack_speedmod = -1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "cut")
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)

/obj/item/weapon/complexknife/attack(mob/target as mob, mob/living/user as mob)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(H.inertial_speed != null)
			if(H.inertial_speed >= 5 && H.dir == T.dir && !T.lying)
				add_logs(user, target, "backstabbed")
				user.visible_message("<span class='danger'>[H] slams the [src.name] into [T]'s back at high speed!</span>")
				T.Weaken(3)
				var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
				var/hit_area = parse_zone(affecting.name)
				var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
				armor /= 2 //Armor piercing!
				T.apply_damage(rand(35, 65), src.damtype, affecting, armor , src, deliveredwound=/datum/wound/puncture)
				new /obj/effect/gibspawner/blood(T.loc)
				spawn(2) qdel(src)
				return
		if(istype(H.get_inactive_hand(), /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = H.get_inactive_hand()
			if(G.state >= GRAB_NECK)
				if(G.affecting == T)
					spawn(0)
						add_logs(user, target, "tried to slit the throat of")
						H.visible_message("<span class='danger'><b>[H] begins to slit [T]'s throat!</b></span>")
						T.silent += 3 //Shhhh...
						var/check = 40
						while(check && src && H && T && H.get_inactive_hand() == G && G.state >= GRAB_NECK && G.affecting == T && H.get_active_hand() == src)
							check--
							sleep(10)
						if(!check)
							add_logs(user, target, "sucessfully slit the throat of")
							playsound(loc, 'sound/weapons/bladeslice.ogg', 75, 0)
							new /obj/effect/gibspawner/blood(T.loc)
							H.visible_message("<span class='danger'><b>[H] has slit [T]'s throat!</b></span>")
							T.apply_damage(25,"brute","head", deliveredwound=/datum/wound/slash)
							T.adjustOxyLoss(1000)
							return
						else
							H << "\red You fail to slit [target]'s throat."
							return
	return ..()

/obj/item/weapon/complexknife/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is slitting \his own throat with the [name]! It looks like \he's trying to commit suicide.</span>", "<span class='suicide'>[user] is slitting \his wrists with the [name]! It looks like \he's trying to commit suicide.</span>"))
	new /obj/effect/gibspawner/blood(user.loc)
	return (OXYLOSS)

/*
Complex sword class.
*/

/obj/item/weapon/complexsword
	name = "Sword"
	desc = "A really damn generic sword."
	icon_state = "katana"
	item_state = "katana"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 25
	throwforce = 10
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	piercingpower = 5
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)
	var/stance = "defensive"
	var/piercing = 0
	var/last_attacks = ""
	var/counter = 0

/obj/item/weapon/complexsword/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [name]! It looks like \he's trying to commit suicide.</span>")
	new /obj/effect/gibspawner/blood(user.loc)
	return (BRUTELOSS)

/obj/item/weapon/complexsword/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/complexsword/process()
	if(last_attacks != "")
		if(counter >= 6)
			counter = 0
			last_attacks = ""
		counter += 1

/obj/item/weapon/complexsword/verb/switchpiercing()
	set name = "Piercing Blow"
	set desc = "Make the next blow armor piercing. Delivering an armor piercing blow takes more time than a regular one."
	set category = "Sword"

	piercing = !piercing
	if(piercing)
		usr << "\red You prepare to deliver a piercing blow."
	else
		usr << "\red You are no longer prepared to deliver a piercing blow."

/obj/item/weapon/complexsword/verb/switchstance()
	set name = "Toggle Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Sword"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("\red [usr] falls into [stance] stance.")

/obj/item/weapon/complexsword/attack(mob/living/target as mob, mob/user as mob)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(src.piercing)
			H.changeNext_move(CLICK_CD_MELEE*4)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -15))
					return
			src.piercing = 0
			last_attacks += "pierce"
			counter = 0
			if("hamstringpiercepiercepierce" == last_attacks && stance == "agressive")
				add_logs(user, target, "stabbed the heart of")
				target.visible_message("<span class ='danger'>[user] slams the [src] into [target]'s heart!</span>")
				target.take_organ_damage(200, 0)
				last_attacks = ""
				return
			add_logs(user, target, "dealt a piercing blow to")
			user.visible_message("<span class='danger'>[H] deals a heavy blow to [T] with the [src.name]!</span>")
			var/attackforce = src.force
			if(H.inertial_speed != null)
				attackforce += H.inertial_speed*2
			var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
			var/hit_area = parse_zone(affecting.name)
			var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
			armor /= 2 //Armor piercing!
			T.apply_damage(attackforce, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/slash)
			new /obj/effect/gibspawner/blood(T.loc)
			return
		if (user.a_intent == "disarm")
			add_logs(user, target, "attempted to disarm")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target))
					return
			last_attacks += "disarm"
			counter = 0
			target.visible_message("<span class ='danger'>[target] has been disarmed with \the [src] by [user]!</span>")
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			var/obj/item/thing = target.get_active_hand()
			target.drop_items()
			if(src.parrying == target && thing)
				target.visible_message("<span class ='danger'>[user] grabs for the [thing]!</span>")
				user.put_in_hands(thing)
			src.add_fingerprint(user)
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
		if (user.a_intent == "grab")
			add_logs(user, target, "attempted to hamstring")
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -40))
					return
			last_attacks += "hamstring"
			counter = 0
			if("knockbackhamstring" == last_attacks)
				target.visible_message("<span class ='danger'>[user] executes a tripping move!</span>")
				target.Weaken(6)
				last_attacks = ""
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			if(T.reagents_speedmod <= 10)
				T.reagents_speedmod += 5
			src.add_fingerprint(user)
			target.visible_message("<span class ='danger'>[user] sweeps at [target]'s legs with \the [src]!</span>")
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
		if (user.a_intent == "help")
			add_logs(user, target, "knocked back")
			last_attacks += "knockback"
			counter = 0
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			step_away(target,user,10)
			if(H.inertial_speed != null)
				var/todamage = 1
				if(CANPUSH & target.status_flags)
					step_away(target,user,10)
				var/obj/item/D = target.get_active_hand()
				if(D && D.complex_block)
					if(!D.handle_block(src, user, target, -40))
						todamage = 0
				if(todamage)
					var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
					var/hit_area = parse_zone(affecting.name)
					var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
					T.apply_damage(src.force/2, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/slash)
				return
			src.add_fingerprint(user)
			target.visible_message("<span class ='danger'>[user] knocks [target] back with \the [src]!</span>")
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
	..()
	if(prob(20) && ishuman(target)) new /obj/effect/gibspawner/blood(target.loc)

/obj/item/weapon/complexsword/handle_ctrlclick(var/mob/living/user, var/mob/living/target)
	if(stance == "defensive")
		..()
	else
		if(user.next_click <= world.time)
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message("\red [user] charges at [target]!")
			step_towards(user,target)
			spawn(1) step_towards(user,target)
			spawn(2) step_towards(user,target)
			spawn(3) step_towards(user,target)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.inertial_speed += 6

/*
Complex chainsword class.
*/

/obj/item/weapon/chainsword
	name = "chainsword"
	desc = "The Emporer's wrath made manifest."
	icon_state = "chainsword"
	item_state = "chainsword"
	hitsound = 'sound/weapons/chainsword.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("mauled" , "mutilated" , "lacerated" , "ripped" , "torn")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	piercingpower = 15
	woundtypes = list(/datum/wound/chainsword)
	var/stance = "defensive"
	var/last_attacks = ""
	var/counter = 0

/obj/item/weapon/chainsword/suicide_act(mob/user)
	playsound(loc, 'sound/weapons/chainsword.ogg', 75, 0)
	user.visible_message("<span class='suicide'>[user] is sawing into \his own head with the [name]! It looks like \he's trying to commit suicide.</span>")
	new /obj/effect/gibspawner/blood(user.loc)
	return (BRUTELOSS)

/obj/item/weapon/chainsword/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/chainsword/process()
	if(stance == "agressive")
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.get_active_hand() == src)
				if(H.reagents_speedmod > -0.5)
					H.reagents_speedmod -= 1
	if(last_attacks != "")
		if(counter >= 6)
			counter = 0
			last_attacks = ""
		counter += 1

/obj/item/weapon/chainsword/verb/switchstance()
	set name = "Toggle Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Sword"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("\red [usr] falls into [stance] stance.")

/obj/item/weapon/chainsword/attack(mob/living/target as mob, mob/user as mob)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if (H.inertial_speed != null && H.a_intent == "harm")
			if(H.inertial_speed >= 5 && H.dir == T.dir && !T.lying)
				add_logs(user, target, "backstabbed")
				user.visible_message("<span class='danger'>[H] stabs [T] in the back with the [src.name]!</span>")
				H.inertial_speed = null
				T.Paralyse(5)
				step_away(T,H,10)
				step_away(T,H,10)
				var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
				var/hit_area = parse_zone(affecting.name)
				var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
				armor /= 2 //Armor piercing!
				T.apply_damage(src.force + 20, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/chainsword)
				new /obj/effect/gibspawner/blood(T.loc)
				return
		if (H.inertial_speed != null && H.a_intent == "grab")
			H.changeNext_move(CLICK_CD_MELEE*4)
			if(H.inertial_speed >= 5 && H.dir == T.dir && !T.lying)
				add_logs(user, target, "backstabbed")
				user.visible_message("<span class='danger'>[H] stabs [T] in the back with the [src.name]!</span>")
				H.inertial_speed = null
				T.Paralyse(5)
				step_away(T,H,10)
				step_away(T,H,10)
				var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
				T.apply_damage(src.force + 20, src.damtype, affecting, 0 , src, deliveredwound=/datum/wound/chainsword)
				new /obj/effect/gibspawner/blood(T.loc)
				return
		if (H.a_intent == "grab")
			add_logs(user, target, "dealt a piercing blow to")
			H.changeNext_move(CLICK_CD_MELEE*4)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -15))
					return
			last_attacks += "pierce"
			counter = 0
			if("hamstringpiercepiercepierce" == last_attacks && stance == "agressive")
				target.visible_message("<span class ='danger'>[user] slams the [src] into [target]'s heart!</span>")
				target.take_organ_damage(200, 0)
				last_attacks = ""
				return
			user.visible_message("<span class='danger'>[H] deals a heavy blow to [T] with the [src.name]!</span>")
			var/attackforce = src.force
			if(H.inertial_speed != null)
				attackforce += H.inertial_speed*2
			var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
			var/hit_area = parse_zone(affecting.name)
			var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
			armor /= 2 //Armor piercing!
			T.apply_damage(attackforce, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/chainsword)
			new /obj/effect/gibspawner/blood(T.loc)
			return
		if (user.a_intent == "disarm")
			add_logs(user, target, "attempted to disarm")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target))
					return
			last_attacks += "disarm"
			counter = 0
			target.visible_message("<span class ='danger'>[target] has been disarmed with \the [src] by [user]!</span>")
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			var/obj/item/thing = target.get_active_hand()
			target.drop_items()
			if(src.parrying == target && thing)
				target.visible_message("<span class ='danger'>[user] grabs for the [thing]!</span>")
				user.put_in_hands(thing)
			src.add_fingerprint(user)
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
		if (user.a_intent == "help")
			add_logs(user, target, "attempted to hamstring")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -40))
					return
			last_attacks += "hamstring"
			counter = 0
			if("knockbackhamstring" == last_attacks)
				target.visible_message("<span class ='danger'>[user] executes a tripping move!</span>")
				target.Weaken(6)
				last_attacks = ""
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			if(T.reagents_speedmod <= 30)
				T.reagents_speedmod += 10
			src.add_fingerprint(user)
			target.visible_message("<span class ='danger'>[user] sweeps at [target]'s legs with \the [src], hamstringing them!</span>")
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
	..()
	if(prob(50) && ishuman(target)) new /obj/effect/gibspawner/blood(target.loc)

	var/obj/item/weapon/grab/G = user.get_inactive_hand()
	if(!istype(G))
		return
	var/mob/living/M = G.affecting
	if(target == M)																		//running down to the riptide
		if(istype(user.get_inactive_hand(), /obj/item/weapon/grab))
			user.visible_message("<span class='danger'><b>[user] begins to cut [target] in two!</b></span>")

			var/check = 7//X seconds before Gibbed, Totally not stolen from the Ninja Net
			while(!isnull(M)&&!isnull(src)&&check>0)//While M and net exist, X seconds have not passed.
				check--
				sleep(10)

		if(istype(user.get_inactive_hand(), /obj/item/weapon/grab))						//I want to be your left hand man
			if(isnull(M)||M.loc!=loc)//If mob is gone or not at the location.
				add_logs(user, target, "used a chainsword to gib")
				playsound(loc, 'sound/weapons/chainsword.ogg', 75, 0)
				new /obj/effect/gibspawner/blood(target.loc)
				new /obj/effect/gibspawner/generic(target.loc)
				user.visible_message("<span class='danger'><b>[user] has slashed [target] in half!</b></span>")
				target.gib()															//this cowboys running from himself
				if(istype(src, /obj/item/weapon/chainsword/chainaxe2) || istype(src, /obj/item/weapon/chainsword/chainaxe))
					award(user, "Blood for the blood god!")
				return

/obj/item/weapon/chainsword/handle_ctrlclick(var/mob/living/user, var/mob/living/target)
	if(stance == "defensive")
		..()
	else
		if(user.next_click <= world.time)
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message("\red [user] charges at [target]!")
			step_towards(user,target)
			spawn(1) step_towards(user,target)
			spawn(2) step_towards(user,target)
			spawn(3) step_towards(user,target)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.inertial_speed += 6

/*
Power Sword Base Class
*/

/obj/item/weapon/powersword
	name = "Power Sword"
	desc = "A really damn generic power sword."
	icon_state = "pk_off"
	item_state = "pk_off"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 30
	throwforce = 10
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	parryprob = 150
	piercingpower = 15
	woundtypes = list(/datum/wound/puncture, /datum/wound/slash)
	var/stance = "defensive"
	var/piercing = 0
	var/last_attacks = ""
	var/counter = 0
	var/stunforce = 7
	var/status = 0
	var/icon_on = "pk_on"
	var/icon_off = "pk_off"
	var/item_on = "pk_on"
	var/item_off = "pk_off"
	var/switchsound = 'sound/effects/inq.ogg'

/obj/item/weapon/powersword/New()
	..()
	update_icon()
	return

/obj/item/weapon/powersword/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is putting the live [name] in \his mouth! It looks like \he's trying to commit suicide.</span>")
	return (FIRELOSS)

/obj/item/weapon/powersword/update_icon()
	if(status)
		icon_state = icon_on
		item_state = item_on
		playsound(loc, switchsound, 75, 0)
	else
		icon_state = icon_off
		item_state = item_off

/obj/item/weapon/powersword/attack_self(mob/user)
	status = !status
	user << "<span class='notice'>[src] is now [status ? "on" : "off"].</span>"
	update_icon()

/obj/item/weapon/powersword/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/powersword/process()
	if(last_attacks != "")
		if(counter >= 6)
			counter = 0
			last_attacks = ""
		counter += 1

/obj/item/weapon/powersword/verb/switchpiercing()
	set name = "Piercing Blow"
	set desc = "Make the next blow armor piercing. Delivering an armor piercing blow takes more time than a regular one."
	set category = "Sword"

	piercing = !piercing
	if(piercing)
		usr << "\red You prepare to deliver a piercing blow."
	else
		usr << "\red You are no longer prepared to deliver a piercing blow."

/obj/item/weapon/powersword/verb/switchstance()
	set name = "Toggle Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Sword"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("\red [usr] falls into [stance] stance.")

/obj/item/weapon/powersword/attack(mob/living/target as mob, mob/user as mob)
	if(!status)
		..()
		return
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(src.piercing)
			H.changeNext_move(CLICK_CD_MELEE*4)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -15))
					return
			src.piercing = 0
			last_attacks += "pierce"
			counter = 0
			if("knockbackpiercepierce" == last_attacks && stance == "agressive" && H.zone_sel && H.zone_sel.selecting == "head")
				add_logs(user, target, "beheaded")
				T.visible_message("<span class ='danger'>[H] slashes [T]'s head clean off with the [src.name]!</span>")
				T.death(0)
				var/obj/item/organ/limb/head/head = new /obj/item/organ/limb/head(get_turf(T))
				var/obj/item/organ/brain/B = T.getorgan(/obj/item/organ/brain)
				if(B)
					if(T.key)
						B.transfer_identity(T)
					T.internal_organs -= B
					B.loc = head
				last_attacks = ""
				return
			if("hamstringpiercepiercepierce" == last_attacks && stance == "agressive")
				add_logs(user, target, "stabbed the heart of")
				target.visible_message("<span class ='danger'>[user] slams the [src] into [target]'s heart!</span>")
				target.take_organ_damage(200, 0)
				last_attacks = ""
				return
			add_logs(user, target, "dealt a piercing blow to")
			user.visible_message("<span class='danger'>[H] deals a heavy blow to [T] with the [src.name]!</span>")
			var/attackforce = src.force
			if(H.inertial_speed != null)
				attackforce += H.inertial_speed*2
			var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
			var/hit_area = parse_zone(affecting.name)
			var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
			armor /= 2 //Armor piercing!
			T.apply_damage(attackforce, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/slash)
			new /obj/effect/gibspawner/blood(T.loc)
			return
		if (user.a_intent == "disarm")
			add_logs(user, target, "attempted to disarm")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target))
					return
			last_attacks += "disarm"
			counter = 0
			add_logs(user, target, "stunned")
			target.visible_message("<span class ='danger'>[target] has been stunned with \the [src] by [user]!</span>")
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			var/obj/item/thing = target.get_active_hand()
			target.drop_items()
			target.Weaken(stunforce)
			target.Stun(stunforce)
			target.apply_effect(STUTTER, stunforce)
			if(src.parrying == target && thing)
				target.visible_message("<span class ='danger'>[user] grabs for the [thing]!</span>")
				user.put_in_hands(thing)
			src.add_fingerprint(user)
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
		if (user.a_intent == "grab")
			add_logs(user, target, "attempted to hamstring")
			var/obj/item/D = target.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, user, target, -40))
					return
			last_attacks += "hamstring"
			counter = 0
			if("knockbackhamstring" == last_attacks)
				target.visible_message("<span class ='danger'>[user] executes a tripping move!</span>")
				target.Weaken(6)
				last_attacks = ""
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			if(T.reagents_speedmod <= 10)
				T.reagents_speedmod += 5
			src.add_fingerprint(user)
			target.visible_message("<span class ='danger'>[user] sweeps at [target]'s legs with \the [src]!</span>")
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
		if (user.a_intent == "help")
			add_logs(user, target, "knocked back")
			last_attacks += "knockback"
			counter = 0
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			step_away(target,user,10)
			if(H.inertial_speed != null)
				var/todamage = 1
				if(CANPUSH & target.status_flags)
					step_away(target,user,10)
				var/obj/item/D = target.get_active_hand()
				if(D && D.complex_block)
					if(!D.handle_block(src, user, target, -40))
						todamage = 0
				if(todamage)
					var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
					var/hit_area = parse_zone(affecting.name)
					var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
					T.apply_damage(src.force/2, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/slash)
				return
			src.add_fingerprint(user)
			target.visible_message("<span class ='danger'>[user] knocks [target] back with \the [src]!</span>")
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			return
	..()
	if(prob(20) && ishuman(target)) new /obj/effect/gibspawner/blood(target.loc)

/obj/item/weapon/powersword/handle_ctrlclick(var/mob/living/user, var/mob/living/target)
	if(stance == "defensive")
		..()
	else
		if(user.next_click <= world.time)
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message("\red [user] charges at [target]!")
			step_towards(user,target)
			spawn(1) step_towards(user,target)
			spawn(2) step_towards(user,target)
			spawn(3) step_towards(user,target)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.inertial_speed += 6

/*
Two handed "mercy" chainsword class. One of the most devestating melee weapons, but also relatively difficult to use.
*/

/obj/item/weapon/twohanded/chainswordig
	icon_state = "mercychainswordig0"
	name = "mercy chainsword"
	desc = "A blade of the \"mercy chainsword\" pattern. Fitted with a longer handle, it can be wielded effectively in one hand or in two hands for additional force. Lacking a regular hand guard, it is very dangerous to wield."
	force = 35
	throwforce = 15
	w_class = 4
	slot_flags = SLOT_BACK
	force_unwielded = 35
	force_wielded = 50
	attack_verb = list("rended", "cleaved", "torn", "cut", "ripped", "mauled", "lacerated", "mutilated")
	hitsound = 'sound/weapons/chainsword.ogg'
	complex_block = 1
	complex_click = 1
	attack_speedmod = 0
	can_parry = 1
	parryprob = 150
	piercingpower = 5
	woundtypes = list(/datum/wound/chainsword)

/obj/item/weapon/twohanded/chainswordig/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/twohanded/chainswordig/verb/saw(var/mob/living/carbon/human/T in view(1))
	set name = "Sawing Attack"
	set desc = "Saw into a downed opponent to deal significant damage over time and possibly finish them off."
	set category = "Sword"

	if(!src.wielded)
		usr << "\red You have to hold the blade in both hands for this."
		return

	if(T.lying)
		if(ishuman(usr))
			var/mob/living/carbon/human/U = usr
			U.visible_message("\red [U] lowers the [src.name] over [T] and prepares to saw them!")
			sleep(10)
			for(var/stage = 1, stage<=20, stage++)
				sleep(10)
				if(get_dist(get_turf(usr),get_turf(T)) > 1 || usr.get_active_hand() != src)
					return
				var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(U.zone_sel.selecting))
				var/hit_area = parse_zone(affecting.name)
				var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
				armor /= 2
				T.apply_damage(src.force/2, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/chainsword)
				T.Weaken(3)
				new /obj/effect/gibspawner/blood(T.loc)
			T.gib()

/obj/item/weapon/twohanded/chainswordig/update_icon()
	attack_speedmod = wielded //Convenient, because it should attack with speedmod 1 if it is wielded and 0 if it is not...
	if(wielded)
		piercingpower = 20
	else
		piercingpower = 5
	icon_state = "mercychainswordig[wielded]"
	return

/obj/item/weapon/twohanded/chainswordig/attack(mob/living/M as mob, mob/user as mob)
	if(ishuman(user) && ishuman(M))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = M
		if(CLUMSY in H.mutations)
			H.visible_message("<span class='danger'>[H] accidentally slices themselves with the [src]!</span>")
			new /obj/effect/gibspawner/blood(H.loc)
			H.take_organ_damage(40, 0)
			H.Weaken(1)
			return
		if(H.inertial_speed == null)
			H.visible_message("<span class='danger'>[H] accidentally slices themselves with the [src]!</span>")
			new /obj/effect/gibspawner/blood(H.loc)
			H.take_organ_damage(40, 0)
			H.Weaken(1)
			return
		if (H.a_intent == "disarm")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/D = M.get_active_hand()
			if(D && D.complex_block)
				if(!D.handle_block(src, H, M))
					return
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			M.Weaken(3)
			M.drop_items()
			src.add_fingerprint(H)
			M.visible_message("<span class ='danger'>[H] sweeps \the [src] beneath [M]'s feet, knocking them down!</span>")
			return
		if (H.inertial_speed != null && H.a_intent == "harm" && H.next_click <= world.time && wielded)
			H.changeNext_move(CLICK_CD_MELEE)
			if(H.inertial_speed >= 5 && H.dir == T.dir && !T.lying)
				user.visible_message("<span class='danger'>[H] slams the [src.name] into [T]'s back!</span>")
				H.inertial_speed = null
				T.Paralyse(5)
				step_away(T,H,10)
				step_away(T,H,10)
				var/obj/item/organ/limb/affecting = T.get_organ(ran_zone(H.zone_sel.selecting))
				var/hit_area = parse_zone(affecting.name)
				var/armor = T.run_armor_check(affecting, "melee", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>", "<span class='warning'>Your armour has softened a hit to your [hit_area].</span>")
				armor /= 2 //Armor piercing!
				T.apply_damage(src.force + 20, src.damtype, affecting, armor , src, deliveredwound=/datum/wound/chainsword)
				new /obj/effect/gibspawner/blood(T.loc)
				return
		..()
		if(ishuman(M) && prob(50)) new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/twohanded/chainswordig/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	if(A && wielded && (istype(A,/obj/structure/window) || istype(A,/obj/structure/grille))) //destroys windows and grilles in one hit
		if(istype(A,/obj/structure/window)) //should just make a window.Break() proc but couldn't bother with it
			var/obj/structure/window/W = A

			new /obj/item/weapon/shard( W.loc )
			if(W.reinf) new /obj/item/stack/rods( W.loc)

			if (W.dir == SOUTHWEST)
				new /obj/item/weapon/shard( W.loc )
				if(W.reinf) new /obj/item/stack/rods( W.loc)
		qdel(A)

/*OPSPEED/obj/item/weapon/twohanded/chainswordig/process()
	if(wielded)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.get_active_hand() == src)
				if(H.reagents_speedmod >= -3)
					H.reagents_speedmod -= 1*/