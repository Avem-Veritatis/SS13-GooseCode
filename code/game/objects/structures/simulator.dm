/*
A combat simulator. Should be pretty cool.
TODO: Make this do something interesting when emagged.

-Drake
*/

/obj/structure/stool/bed/chair/simulator
	name = "combat simulator"
	desc = "Simulates a combat situation. Good for practicing and such."
	icon_state = "VR"
	var/on = 0
	var/mob/living/carbon/human/simulation/simulated = null
	var/cooldown = 0

/obj/structure/stool/bed/chair/simulator/New()
	..()
	overlays += image('icons/obj/objects.dmi', src, "echair_over", MOB_LAYER + 1, dir)
	return

/obj/structure/stool/bed/chair/simulator/verb/toggle()
	set name = "Activate Simulation"
	set category = "Object"
	set src in oview(1)
	if(cooldown)
		usr << "Not so fast!"
		return
	if(buckled_mob)
		usr << "<span class='notice'>You switch [on ? "off" : "on"] [src].</span>"
	else
		usr << "<span class='notice'>There is no occupant.</span>"
	toggle_on()
	return

/obj/structure/stool/bed/chair/simulator/rotate()
	..()
	overlays.Cut()
	overlays += image('icons/obj/objects.dmi', src, "echair_over", MOB_LAYER + 1, dir)	//there's probably a better way of handling this, but eh. -Pete
	return

/obj/structure/stool/bed/chair/simulator/unbuckle()
	if(on)
		toggle_on()
	..()

/obj/structure/stool/bed/chair/simulator/proc/toggle_on()
	if(cooldown)
		return
	cooldown = 1 //Should keep this proc from screwing itself up by running in paralell
	if(buckled_mob)
		if(on && simulated)
			simulated.U.key = simulated.key
			simulated.key = 0
			for(var/mob/living/E in simulated.enemies)
				qdel(E)
			qdel(simulated)
			on = 0
		else if(!on && !simulated)
			var/list/dests = list()
			for(var/obj/effect/landmark/simulator/S in world)
				dests += get_turf(S)
			var/turf/T = pick(dests)
			simulated = new /mob/living/carbon/human/simulation(T)
			simulated.simulator = src
			simulated.U = buckled_mob
			simulated.key = buckled_mob.key
			buckled_mob.key = null
			on = 1
	spawn(10) cooldown = 0
	return