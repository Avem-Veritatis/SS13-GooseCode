/*
Electoos

Able to draw in electricity from external sources to charge a tech priests internal power cell.
Able to discharge electricity in melee combat using said power cell or a configured nearby source.
With enough electricity, able to fire ranged arcs of electricity like the electropriests.
Also grants ability to interface with technology nearby, ie a data interface triggered on touch where normally it would take one or more tools to interface technology.
Some of this stuff will definitely not be manifest in the initial incarnation of electoos. Right now I want to work on space hulk things some more.

-Drake
*/

/obj/item/ammo_casing/energy/beamshot/electricity
	name = "capacitor array"
	beam_icon = "arc"
	cap_icon = "electricity2"
	beam_name = "electricity arc"
	damage = 5
	damage_type = BURN
	flag = "laser"
	select_name = "electric arc"
	var/power_source = null

/obj/item/ammo_casing/energy/beamshot/electricity/beam_hit(var/atom/A, var/p_x, var/p_y, var/mob/living/user)
	if(iscarbon(A))
		if(power_source)
			electrocute_mob(A, src.power_source, src.loc, 1.0, 1)
		else
			A.visible_message("\red The electricity arc fizzles uselessly around [A]!")

/obj/item/clothing/gloves/electoos
	desc = "A fine upgrade to the human form. Insulated, unbreakable, it opens up the biotics tab for you. Look in the upper right hand corner."
	name = "Electoos"
	icon_state = "s-ninjan"
	item_state = "s-ninjan"
	flags = NODROP|THICKMATERIAL | STOPSPRESSUREDMAGE
	flags_inv = HIDEJUMPSUIT|HANDS|CHEST|LEGS|FEET|ARMS|GROIN
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	var/obj/item/ammo_casing/energy/beamshot/electricity/E
	var/atom/selected_source

/obj/item/clothing/gloves/electoos/New()
	E = new /obj/item/ammo_casing/energy/beamshot/electricity(src)

/obj/item/clothing/gloves/electoos/Touch(atom/A, proximity)
	if(istype(A,/obj/machinery/power/apc) || istype(A,/obj/structure/cable) || istype(A,/obj/structure/grille) || istype(A,/obj/machinery/power/smes))
		usr << "\red You configure the electoos to draw power from [A]."
		selected_source = A
		E.power_source = A
		return 1
	if(get_turf(selected_source) == get_turf(src) || selected_source in range(1, get_turf(src)))
		usr.visible_message("\red <b>[usr] creates an electricity arc with the electoos!</b>", "\red You direct power from the [selected_source] towards [A].")
		E.fire(A,usr, 0, 0, 0)
		return 1
	return 0