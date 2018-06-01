/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply."
	icon_state = "gas_alt"
	flags = MASKCOVERSMOUTH | MASKCOVERSEYES | BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	w_class = 3.0
	can_flip = 1
	action_button_name = "Toggle Mask"
	item_state = "gas_alt"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01

/obj/item/clothing/mask/gas/r
	icon_state = "gasmask_r"
	item_state = "gasmask_r"

/obj/item/clothing/mask/gas/c
	icon_state = "gasmask_c"
	item_state = "gasmask_c"

/obj/item/clothing/mask/gas/old
	icon_state = "gas_mask"
	item_state = "gas_mask"

/obj/item/clothing/mask/gas/stormtroop
	icon_state = "stormm"
	item_state = "stormm"

// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "welding mask"
	desc = "A gas mask with built in welding goggles and face shield. Looks like a skull, clearly designed by a nerd."
	icon_state = "weldingmask"
	m_amt = 4000
	g_amt = 2000
	flash_protect = 2
	can_flip = null
	tint = 2
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	origin_tech = "materials=2;engineering=2"
	action_button_name = "Toggle Welding Mask"
	visor_flags = MASKCOVERSEYES
	visor_flags_inv = HIDEEYES

/obj/item/clothing/mask/gas/welding/attack_self()
	toggle()


/obj/item/clothing/mask/gas/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding mask"
	set src in usr

	weldingvisortoggle()

// ********************************************************************

// **** Security gas mask ****

/obj/item/clothing/mask/gas/sechailer
	name = "Imperial Respirator"
	desc = "An imperial gas mask with a mark VIII filter and a loudspeaker."
	action_button_name = "HALT!"
	icon_state = "ig"
	can_flip = null
	var/cooldown = 0
	var/aggressiveness = 2

/obj/item/clothing/mask/gas/sechailer/DK
	name = "Krieg gasmask"
	icon_state = "kmask"
	item_state = "kmask"

/obj/item/clothing/mask/gas/sechailer/warden
	icon_state = "wardenmask"

/obj/item/clothing/mask/gas/sechailer/hos
	icon_state = "hosmask"

/obj/item/clothing/mask/gas/sechailer/cyborg
	aggressiveness = 1 //Borgs are nicecurity!

/obj/item/clothing/mask/gas/sechailer/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/screwdriver))
		switch(aggressiveness)
			if(1)
				user << "\blue You set the restrictor to the middle position."
				aggressiveness = 2
			if(2)
				user << "\blue You set the restrictor to the last position."
				aggressiveness = 3
			if(3)
				user << "\blue You set the restrictor to the first position."
				aggressiveness = 1
			if(4)
				user << "\red You adjust the restrictor but nothing happens, probably because its broken."
	else if(istype(W, /obj/item/weapon/wirecutters))
		if(aggressiveness != 4)
			user << "\red You broke it!"
			aggressiveness = 4
	else
		..()

/obj/item/clothing/mask/gas/sechailer/attack_self()
	halt()

/obj/item/clothing/mask/gas/sechailer/verb/halt()
	set category = "Object"
	set name = "HALT"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat) return

	var/phrase = 0	//selects which phrase to use
	var/phrase_text = null
	var/phrase_sound = null


	if(cooldown < world.time - 35) // A cooldown, to stop people being jerks
		switch(aggressiveness)		// checks if the user has unlocked the restricted phrases
			if(1)
				phrase = rand(1,5)	// set the upper limit as the phrase above the first 'bad cop' phrase, the mask will only play 'nice' phrases
			if(2)
				phrase = rand(1,11)	// default setting, set upper limit to last 'bad cop' phrase. Mask will play good cop and bad cop phrases
			if(3)
				phrase = rand(1,18)	// user has unlocked all phrases, set upper limit to last phrase. The mask will play all phrases
			if(4)
				phrase = rand(12,18)	// user has broke the restrictor, it will now only play shitcurity phrases

		switch(phrase)	//sets the properties of the chosen phrase
			if(1)				// good cop
				phrase_text = "HALT! HALT! HALT!"
				phrase_sound = "halt"
			if(2)
				phrase_text = "Stop in the name of the Law."
				phrase_sound = "bobby"
			if(3)
				phrase_text = "Compliance is in your best interest."
				phrase_sound = "compliance"
			if(4)
				phrase_text = "Prepare for justice!"
				phrase_sound = "justice"
			if(5)
				phrase_text = "Running will only increase your sentence."
				phrase_sound = "running"
			if(6)				// bad cop
				phrase_text = "Don't move, Creep!"
				phrase_sound = "dontmove"
			if(7)
				phrase_text = "Down on the floor, Creep!"
				phrase_sound = "floor"
			if(8)
				phrase_text = "Dead or alive you're coming with me."
				phrase_sound = "robocop"
			if(9)
				phrase_text = "God made today for the crooks we could not catch yesterday."
				phrase_sound = "god"
			if(10)
				phrase_text = "Freeze, Scum Bag!"
				phrase_sound = "freeze"
			if(11)
				phrase_text = "Stop right there, criminal scum!"
				phrase_sound = "imperial"
			if(12)				// LA-PD
				phrase_text = "Stop or I'll bash you."
				phrase_sound = "bash"
			if(13)
				phrase_text = "Go ahead, make my day."
				phrase_sound = "harry"
			if(14)
				phrase_text = "Stop breaking the law, ass hole."
				phrase_sound = "asshole"
			if(15)
				phrase_text = "You have the right to shut the fuck up."
				phrase_sound = "stfu"
			if(16)
				phrase_text = "Shut up crime!"
				phrase_sound = "shutup"
			if(17)
				phrase_text = "Face the wrath of the golden bolt."
				phrase_sound = "super"
			if(18)
				phrase_text = "I am, the LAW!"
				phrase_sound = "dredd"

		usr.visible_message("[usr]'s Compli-o-Nator: <font color='red' size='4'><b>[phrase_text]</b></font>")
		playsound(src.loc, "sound/voice/complionator/[phrase_sound].ogg", 100, 0, 4)
		cooldown = world.time



// ********************************************************************


//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "plague doctor mask"
	desc = "A modernised version of the classic design, this mask will not only filter out toxins but it can also be connected to an air supply."
	icon_state = "plaguedoctor"
	item_state = "gas_mask"
	can_flip = null
	armor = list(melee = 0, bullet = 0, laser = 2,energy = 2, bomb = 0, bio = 75, rad = 0)

/obj/item/clothing/mask/gas/swat
	name = "\improper SWAT mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "swat"
	can_flip = null

/obj/item/clothing/mask/gas/syndicate
	name = "syndicate mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "swat"
	can_flip = null

/obj/item/clothing/mask/gas/voice
	name = "gas mask"
	//desc = "A face-covering mask that can be connected to an air supply. It seems to house some odd electronics."
	var/mode = 0// 0==Scouter | 1==Night Vision | 2==Thermal | 3==Meson
	var/voice = "Unknown"
	var/vchange = 0//This didn't do anything before. It now checks if the mask has special functions/N
	origin_tech = "syndicate=4"
	can_flip = null
	icon_state = "plaguedoctor"

/obj/item/clothing/mask/gas/voice/space_ninja
	name = "ninja mask"
	desc = "A close-fitting mask that acts both as an air filter and a post-modern fashion statement."
	icon_state = "s-ninja"
	item_state = "s-ninja_mask"
	can_flip = null //a true ninja never reveals his identity
	vchange = 1

/obj/item/clothing/mask/gas/voice/space_ninja/speechModification(message)
	if(voice == "Unknown")
		if(copytext(message, 1, 2) != "*")
			var/list/temp_message = text2list(message, " ")
			var/list/pick_list = list()
			for(var/i = 1, i <= temp_message.len, i++)
				pick_list += i
			for(var/i=1, i <= abs(temp_message.len/3), i++)
				var/H = pick(pick_list)
				if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":")) continue
				temp_message[H] = ninjaspeak(temp_message[H])
				pick_list -= H
			message = list2text(temp_message, " ")
			message = replacetext(message, "o", "¤")
			message = replacetext(message, "p", "þ")
			message = replacetext(message, "l", "£")
			message = replacetext(message, "s", "§")
			message = replacetext(message, "u", "µ")
			message = replacetext(message, "b", "ß")
	return message


/obj/item/clothing/mask/gas/clown_hat
	name = "clown wig and mask"
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask."
	alloweat = 1
	icon_state = "clown"
	item_state = "clown_hat"
	can_flip = null

obj/item/clothing/mask/gas/clown_hat/attack_self(mob/user)

	var/mob/M = usr
	var/list/options = list()
	options["True Form"] = "clown"
	options["The Feminist"] = "sexyclown"
	options["The Madman"] = "joker"
	options["The Rainbow Color"] ="rainbow"

	var/choice = input(M,"To what form do you wish to Morph this mask?","Morph Mask") in options

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		M << "Your Clown Mask has now morphed into [choice], all praise the Honk Mother!"
		return 1

/obj/item/clothing/mask/gas/sexyclown
	name = "sexy-clown wig and mask"
	desc = "A feminine clown mask for the dabbling crossdressers or female entertainers."
	alloweat = 1
	icon_state = "sexyclown"
	item_state = "sexyclown"
	can_flip = null

//mime

/obj/item/clothing/mask/gas/mime
	name = "mime mask"
	desc = "The traditional mime's mask. It has an eerie facial posture."
	alloweat = 1
	icon_state = "mime"
	item_state = "mime"
	can_flip = null
	var/harl = 0

/obj/item/clothing/mask/gas/mime/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/toy/crayon))
		var/maskselect = input("Select a Mask:","Mask Selection") as null|anything in list("Solitare", "Cegorach", "Death", "Blinded Princess")
		switch(maskselect)
			if(null)
				return
			if("Solitare")
				spawn(0)
					if(istype(usr.l_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of purple.</span>", "<span class='notice'>She who thirsts, The great enemy, The unnamed prince. Everyone has a role to play in this dance. Even her.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.l_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/solitare (usr))
					else if(istype(usr.r_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of purple.</span>", "<span class='notice'>She who thirsts, The great enemy, The unnamed prince. Everyone has a role to play in this dance. Even her.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.r_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/solitare (usr))
			if("Cegorach")
				spawn(0)
					if(istype(usr.l_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of bright red and yellow.</span>", "<span class='notice'>The Laughing God. The prankster. One day his biggest prank will be to save the universe. What a laugh that will be.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.l_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/cegorach (usr))
					else if(istype(usr.r_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of bright red and yellow.</span>", "<span class='notice'>The Laughing God. The prankster. One day his biggest prank will be to save the universe. What a laugh that will be.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.r_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/cegorach (usr))
			if("Death")
				spawn(0)
					if(istype(usr.l_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of black.</span>", "<span class='notice'>Death. You will find him in every sector. On every planet. In the eyes of every living creature.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.l_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/death (usr))
					else if(istype(usr.r_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of black.</span>", "<span class='notice'>Death. You will find him in every sector. On every planet. In the eyes of every living creature.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.r_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/death (usr))
			if("Blinded Princess")
				spawn(0)
					if(istype(usr.l_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of white and wraps it with a blindfold.</span>", "<span class='notice'>The Blinded Princess.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.l_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/blind (usr))
					else if(istype(usr.r_hand, /obj/item/clothing/mask/gas/mime))
						usr.visible_message("<span class='notice'>[usr] draws on the mask with deep shades of white and wraps it with a blindfold.</span>", "<span class='notice'>The Blinded Princess.</span>", "<span class='warning>HOLY CRAP WHAT?!</span>")
						qdel(usr.r_hand)
						usr.put_in_hands(new /obj/item/clothing/mask/gas/mime/blind (usr))

/obj/item/clothing/mask/gas/monkeymask
	name = "monkey mask"
	desc = "A mask used when acting as a monkey."
	alloweat = 1
	icon_state = "monkeymask"
	item_state = "monkeymask"
	can_flip = null

/obj/item/clothing/mask/gas/sexymime
	name = "sexy mime mask"
	desc = "A traditional female mime's mask."
	alloweat = 1
	icon_state = "sexymime"
	item_state = "sexymime"
	can_flip = null

/obj/item/clothing/mask/gas/death_commando
	name = "Death Commando Mask"
	icon_state = "death_commando_mask"
	item_state = "death_commando_mask"
	can_flip = null

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop"
	icon_state = "death"
	can_flip = null

/obj/item/clothing/mask/gas/owl_mask
	name = "owl mask"
	desc = "Twoooo!"
	alloweat = 1
	icon_state = "owl"
	can_flip = null

/*
Mechadendrite Mask? No way!
*/

/obj/item/clothing/mask/gas/TRAP
	name = "Complex Construction Mechadendrite"
	desc = "A face-covering mask that can be connected to an air supply. Also a highly compicated turret construction device"
	icon_state = "24"
	flags = MASKCOVERSMOUTH | MASKCOVERSEYES | BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | NODROP | STOPSPRESSUREDMAGE
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	w_class = 3.0
	action_button_name = "Toggle Mask"
	item_state = "24"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	var/can_toggle = 1
	var/is_toggled = 1
	can_flip = 0

	verb/toggleTRAP()
		set name = "Equip Turret Interface Device"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This item cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/device/turretprobe)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] unhinges a digital display and returns it to a storage state.</span>", "<span class='notice'>You put away the interface device.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/device/turretprobe)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] unhinges a digital display and returns it to a storage state.</span>", "<span class='notice'>You put away the interface device.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			src.is_toggled = 1
		else
			usr << "You unfold a turret interface device and calibrate it for use. Omnissiah be praised!"
			usr.put_in_hands(new /obj/item/device/turretprobe (usr))
			src.is_toggled = 2

	verb/toggleTURR()
		set name = "Begin Turret Construction"
		set category = "Biotics"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return
		if(!can_toggle)
			usr << "This item cannot be toggled!"
			return
		if(src.is_toggled == 2)
			if(istype(usr.l_hand, /obj/item/turretblueprint)) //Not the nicest way to do it, but eh
				qdel(usr.l_hand)
				usr.visible_message("<span class='warning'> [usr] stuffs some blueprints into a pocket.</span>", "<span class='notice'>You put the blueprints away.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			if(istype(usr.r_hand, /obj/item/turretblueprint)) //Not the nicest way to do it, but eh
				qdel(usr.r_hand)
				usr.visible_message("<span class='warning'>  [usr] stuffs some blueprints into a pocket.</span>", "<span class='notice'>You put the blueprints away.</span>", "<span class='warning>What was that sound?</span>")
				usr.update_inv_hands()
			src.icon_state = initial(icon_state)
			src.is_toggled = 1
		else
			usr << "You unfold a set of documents. Omnissiah be praised!"
			usr.put_in_hands(new /obj/item/turretblueprint(usr))
			src.is_toggled = 2

/obj/item/clothing/mask/gas/TRAP/dropped()
	qdel(src)

/obj/item/clothing/mask/gas/TRAP/attack_self()
	return