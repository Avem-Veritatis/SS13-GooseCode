/obj/item/clothing/gloves/captain
	desc = "Regal blue gloves, with a nice gold trim and insulated fingertips. Swanky."
	name = "captain's gloves"
	icon_state = "captain"
	item_state = "egloves"
	item_color = "captain"
	siemens_coefficient = 0

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/cyborg
	desc = "beep boop borp"
	name = "cyborg gloves"
	icon_state = "black"
	item_state = "r_hands"
	siemens_coefficient = 1.0

/obj/item/clothing/gloves/combat
	name = "combat gloves"
	desc = "These tactical gloves are fire and shock resistant."
	icon_state = "black"
	item_state = "swat_gl"
	siemens_coefficient = 0
	permeability_coefficient = 0.05

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/combat/inquisitor
	name = "inquisitor gloves"
	desc = "These inquisitor's gloves are fire and shock resistant."
	icon_state = "inquisitor"

/obj/item/clothing/gloves/corsair
	name = "corsair gloves"
	desc = "Heat resistant, impermeable eldar gloves."
	icon_state = "corsair"
	item_state = "corsair"
	siemens_coefficient = 0.20
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/latex
	name = "latex gloves"
	desc = "A pair of sterile latex gloves. They're so thin you doubt they could stop anything."
	icon_state = "latex"
	item_state = "lgloves"
	siemens_coefficient = 0.30
	permeability_coefficient = 0.01
	item_color = "white"
	transfer_prints = TRUE

	cmo
		item_color = "medical"		//Exists for washing machines. Is not different from latex gloves in any way.

/obj/item/clothing/gloves/botanic_leather
	desc = "These leather gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin.  They're also quite warm."
	name = "botanist's leather gloves"
	icon_state = "leather"
	item_state = "ggloves"
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/fingerless
	desc = "These gloves have the fingers cut off!"
	name = "fingerless gloves"
	icon_state = "fingerless"
	item_state = "fingerless"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE

/obj/item/clothing/gloves/um
	desc = "Ultramarine gloves."
	name = "Ultramarine glove"
	icon_state = "umgloves"
	item_state = "um_gloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/rg
	desc = "Raven Guard gloves."
	name = "Raven Guard glove"
	icon_state = "rggloves"
	item_state = "rggloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/rg/shadowcaptain
	desc = "Shadow Captain gloves."
	name = "Shadow Captain glove"
	icon_state = "rggloves2"
	item_state = "rggloves2"

/obj/item/clothing/gloves/sm
	desc = "SalamanderMarine gloves."
	name = "SalamanderMarine glove"
	icon_state = "smgloves"
	item_state = "sl_gloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/sm/captain
	desc = "SalamanderMarine gloves."
	name = "Reskinned SalamanderMarine gloves. Because fatigue keeps spriting this shit."
	icon_state = "smcap"
	item_state = "slcpt_gloves"

/obj/item/clothing/gloves/warlock
	desc = "Warlock gloves."
	name = "Warlock gloves"
	icon_state = "warlock"
	item_state = "warlock"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/pm
	desc = "Plaguemarine gloves."
	name = "Plaguemarine glove"
	icon_state = "umgloves"
	item_state = "umgloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/ksons
	desc = "Chaos Gloves."
	name = "Chaos Gloves."
	icon_state = "umgloves"
	item_state = "1k_gloves"
	item_color = null
	transfer_prints = TRUE
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05