//Tau Armor

/obj/item/clothing/head/tausuit/XV25
	 name = "XV25 stealth suit Helmet"
	 desc = "Designed for stealth. . . not that you'll be stealthy."
	 icon_state = "XV25"
	 flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	 item_state = "XV25"
	 armor = list(melee = 60, bullet = 45, laser = 55,energy = 65, bomb = 25, bio = 0, rad = 15)
	 flags_inv = HIDEEARS|HIDEEYES
	 cold_protection = HEAD
	 min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	 heat_protection = HEAD
	 max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT


/obj/item/clothing/suit/armor/tausuit/XV25
	name = "XV25 Stealthsuit"
	desc = "The XV25 Stealthsuit is one of the smallest of all the various Tau Battlesuits, and is designed for use in operations requiring a high degree of stealth."
	icon_state = "XV25"
	item_state = "XV25"
	blood_overlay_type = "armor"
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	body_parts_covered = CHEST|ARMS|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	var/stealth = 0
	var/stealthing = 0
	var/injector = 0

/obj/item/clothing/suit/armor/tausuit/XV25/verb/Stimulant_Injector()
	set name = "Stimulant Injector"
	set desc = "Inject a secret chemical that will counteract all movement-impairing effect."
	set category = "XV25 Stealth Suit"
	set popup_menu = 0
	set src in usr													//It's all about the usr. You looking for src? It's right here in usr.
	if(!usr.canmove || usr.stat || usr.restrained())				//This is a train with three stops. First stop is if usr can't move, is dead or restrained. That train stop ends in a return (Meaning we just forget about it)
		return
	if(!injector)													//if injector = 0, this is where we go.
		injector = 1												//While we are here we'll just change injector to yes.
		usr << "<span class='notice'>Adrenaline rushes through you.</span>"	//fluff text
		var/mob/living/carbon/C = usr								//New abstract concept! A person named C! And it is usr.
		C.SetParalysis(0)
		C.SetStunned(0)
		C.SetWeakened(0)
		C.lying = 0
		C.update_canmove()
		C.reagents.add_reagent("tricordrazine", 20)					//We do a bunch of stuff to em
		C.adjustToxLoss(-3)
		C.adjustOxyLoss(-5)
		C.adjustCloneLoss(-3)
		C.radiation -= 5
		spawn(600)													//spawn makes a new sepperate process, this one will activate after 600 (which is 60 seconds)
			usr << "<span class='notice'>Stimulant Injector Ready.</span>"	//fluff text
			injector = 0											//change injector to no.
	if(injector)													//if injector = yes, this is our third and final train stop.
		usr << "<span class='notice'>Stimulant injector is not ready.</span>"
		return

/obj/item/clothing/suit/armor/tausuit/XV25/verb/stealth()
	set category = "XV25 Stealth Suit"
	set desc = "Stealth suit makes you invisible... for the greater good!"
	set popup_menu = 0
	set src in usr
	name = "Stealth"
	desc = "Utilize the stealth suit's capability."
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(stealthing) return
	if(!stealth) //Didn't want to give them full stealth already strong enough as it is I'd say
		stealthing = 1
		animate(usr, alpha = 15, time = 30) //Smoothly fades out alpha. This will look pretty cool if I am correct. Also since this ability can be used indefinitely the alpha levels should be visible if you are out in the open and the spotter is observant. Still many situations in which this is a decided advantage.
		stealthing = 0
		stealth = 1
		usr << "\blue You are now harder to spot."
		return
	if(stealth)
		stealth = 0
		stealthing = 1
		animate(usr, alpha = 255, time = 30)
		stealthing = 0
		usr << "\blue You are now visible."
		return

/obj/item/clothing/suit/armor/tausuit/XV15
	name = "XV15 Stealthsuit"
	desc = "The XV15 Stealthsuit is one of the smallest of all the various Tau Battlesuits, and is designed for use in operations requiring a high degree of stealth."
	icon_state = "XV15"
	item_state = "XV15"
	blood_overlay_type = "armor"
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	body_parts_covered = CHEST|ARMS|GROIN|ARMS|LEGS|HANDS|FEET
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	armor = list(melee = 50, bullet = 30, laser = 50, energy = 15, bomb = 20, bio = 0, rad = 0)
	var/stealth = 0
	var/stealthing = 0
	var/injector = 0

/obj/item/clothing/suit/armor/tausuit/XV15/verb/stealth()
	set category = "XV15 Stealth Suit"
	set desc = "Stealth suit makes you invisible... for the greater good!"
	set popup_menu = 0
	set src in usr
	name = "Stealth"
	desc = "Utilize the stealth suit's capability."
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(stealthing)
		return
	if(!stealth) //Didn't want to give them full stealth already strong enough as it is I'd say
		stealthing = 1
		animate(usr, alpha = 15, time = 30)
		stealthing = 0
		stealth = 1
		usr << "\blue You are now harder to spot."
		return
	if(stealth)
		stealth = 0
		stealthing = 1
		animate(usr, alpha = 255, time = 30)
		stealthing = 0
		usr << "\blue You are now visible."
		return

/obj/item/clothing/head/tausuit/XV15
	 name = "XV15 stealth suit Helmet"
	 desc = "Designed for stealth. . . not that you'll be stealthy."
	 icon_state = "XV15"
	 flags = HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR|!CANSTUN|!CANWEAKEN
	 item_state = "XV15"
	 armor = list(melee = 50, bullet = 35, laser = 45,energy = 55, bomb = 25, bio = 0, rad = 15)
	 flags_inv = HIDEEARS|HIDEEYES
	 cold_protection = HEAD
	 min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	 heat_protection = HEAD
	 max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT