/obj/effect/proc_holder/changeling/evasion
	name = "Evade Capture"
	desc = "Gets you away from your attackers."
	helptext = "Allows you to dodge bullets, run very fast and hide in plain sight."
	chemical_cost = 50
	dna_cost = 1


//Starts healing you every second for 10 seconds. Can be used whilst unconscious.
/obj/effect/proc_holder/changeling/evasion/sting_action(var/mob/living/user)
	user << "<span class='notice'>RUN FOR IT!!</span>"
	var/mob/living/carbon/C = usr
	C.dodging = 1
	user.stat = 0
	user.SetParalysis(0)
	user.SetStunned(0)
	user.SetWeakened(0)
	user.lying = 0
	user.update_canmove()
	C.setToxLoss(0)
	C.setOxyLoss(0)
	C.setCloneLoss(0)
	sleep(80)
	C.alpha = 0
	sleep(80) //8 seconds of being defended against a lot of attacks.
	C.dodging = 0
	C.alpha = 255

	feedback_add_details("changeling_powers","RR")
	return 1