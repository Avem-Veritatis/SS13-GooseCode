/*
Ideas for the subtle effects of hallucination:

Light up oxygen/plasma indicators (done)
Cause health to look critical/dead, even when standing (done)
Characters silently watching you
Brief flashes of fire/space/bombs/c4/dangerous shit (done)
Items that are rare/traitorous/don't exist appearing in your inventory slots (done)
Strange audio (should be rare) (done)
Gunshots/explosions/opening doors/less rare audio (done)

//Meh this stuff is /alright/ but most people know to expect it. Time to spice things up a bit. -Drake

*/

mob/living/carbon/
	var/image/halimage
	var/image/halbody
	var/image/haloverlay
	var/obj/halitem
	var/hal_screwyhud = 0 //1 - critical, 2 - dead, 3 - oxygen indicator, 4 - toxin indicator
	var/handling_hal = 0
	var/hal_crit = 0
	var/soundevent = 0
	var/soundtime = 0

mob/living/carbon/proc/handle_hallucinations()
	if(handling_hal) return
	handling_hal = 1
	while(hallucination > 20)
		sleep(rand(200,500)/(hallucination/25))
		var/halpick = rand(1,100)
		switch(halpick)
			if(0 to 15)
				hal_screwyhud = pick(1,2,3,3,4,4)
				spawn(rand(100,250))
					hal_screwyhud = 0
			if(16 to 25)
				if(!halitem)
					halitem = new
					var/list/slots_free = list(ui_lhand,ui_rhand)
					if(l_hand) slots_free -= ui_lhand
					if(r_hand) slots_free -= ui_rhand
					if(istype(src,/mob/living/carbon/human))
						var/mob/living/carbon/human/H = src
						if(!H.belt) slots_free += ui_belt
						if(!H.l_store) slots_free += ui_storage1
						if(!H.r_store) slots_free += ui_storage2
					if(slots_free.len)
						halitem.screen_loc = pick(slots_free)
						halitem.layer = 50
						switch(rand(1,6)) //Lets mix things up and make them more interesting. -Drake
							if(1)
								halitem.icon = 'icons/obj/clothing/masks.dmi'
								halitem.icon_state = "spliffon"
								halitem.name = pick("Lho Leaf Cigarette", "420 Stick", "Food", "Plant Flavored Cigarette","Drugs")
							if(2)
								halitem.icon = 'icons/obj/chemical.dmi'
								halitem.icon_state = "bottle13"
								halitem.name = pick("Laserbrain Dust Bottle", "Bottle of... what?", "Heretical Looking Bottle","Drugs")
							if(3)
								halitem.icon = 'icons/obj/weapons.dmi'
								halitem.icon_state = "swordrainbow"
								halitem.name = "[pick("Glowy","Shiny")] [pick("Wierd","Heretical")] [pick("Stick","Weapon","Thingy")]"
							if(4)
								halitem.icon = 'icons/mob/hallucination.dmi'
								halitem.icon_state = "corpse_vision"
								halitem.name = pick("The Emperor", "Plague Ridden Corpse", "Dead Body", "[src.name]")
							if(5)
								halitem.icon = 'icons/obj/singularity.dmi'
								halitem.icon_state = "singularity_s1"
								halitem.name = pick("Lord Singuloth","Dafuq?","Vortex","Problem","Black Hole","Daemon")
							if(6)
								halitem.icon = 'icons/mob/hallucination.dmi'
								halitem.icon_state = "waagh"
								halitem.name = pick("Orky Banner","Waaagh...","Crude Thingy","Ork Infestation","Ork's Rights Sign")
						if(client) client.screen += halitem
						spawn(rand(100,250))
							qdel(halitem)
			if(26 to 40)
				//Flashes of danger
				//src << "Danger Flash" //Meh this was always a boring one. Lets make it better.
				if(!halimage)
					var/list/possible_points = list()
					for(var/turf/simulated/floor/F in view(src,world.view))
						possible_points += F
					if(possible_points.len)
						var/turf/simulated/floor/target = pick(possible_points)

						switch(rand(1,3))
							if(1)
								if(hallucination > 30)
									halimage = image('icons/effects/96x96.dmi',target,"singularity_s3",FLY_LAYER) //...lol this should be a little scary than sphess.
							if(2)
								if(prob(10)) //This one can't be too common if it will have its full effect. That should do it.
									if(hallucination > 30) //You can't be tripping just a little for some of these.
										src << "<font size='15' color='red'><b>A WARP STORM HAS APPEARED</b></font>"
										halimage = image('icons/obj/narsie.dmi',target,"",MOB_LAYER)
								else
									halimage = image('icons/mob/hallucination.dmi',target,"corpse_vision",MOB_LAYER)
							if(3)
								halimage = image('icons/mob/hallucination.dmi',target,"corpse_vision",MOB_LAYER)

						if(client) client.images += halimage
						spawn(rand(10,50)) //Only seen for a brief moment.
							if(client) client.images -= halimage
							halimage = null


			if(41 to 65)
				//Strange audio
				//src << "Strange Audio"
				switch(rand(1,18))
					if(1) src << 'sound/machines/airlock.ogg'
					if(2)
						if(prob(50))src << 'sound/effects/Explosion1.ogg'
						else src << 'sound/effects/Explosion2.ogg'
					if(3) src << 'sound/effects/explosionfar.ogg'
					if(4) src << 'sound/effects/Glassbr1.ogg'
					if(5) src << 'sound/effects/Glassbr2.ogg'
					if(6) src << 'sound/effects/Glassbr3.ogg'
					if(7) src << 'sound/machines/twobeep.ogg'
					if(8) src << 'sound/machines/windowdoor.ogg'
					if(9)
						//To make it more realistic, I added two gunshots (enough to kill)
						src << 'sound/weapons/Gunshot.ogg'
						spawn(rand(10,30))
							src << 'sound/weapons/Gunshot.ogg'
					if(10) src << 'sound/weapons/smash.ogg'
					if(11)
						//Same as above, but with tasers.
						src << 'sound/weapons/Taser.ogg'
						spawn(rand(10,30))
							src << 'sound/weapons/Taser.ogg'
				//Rare audio //Now made more common. Yay for insanity! -Drake
					if(12 to 18)
					//No more crap sounds. Time to get awesome.
						if(world.time < soundtime + 730 && prob(3)) //Awesome, but a bit too common. Lets keep mixing it up. This rolls for about 1/5 of hallucinations and prob(3) can cut it down a bit.
							var/contents = "[pick("++VOX PRIMARIS++","++VOX PRIMARIS++","++VOX SECONDUS++","++VOX XENOS++","++VOX UNKNOWN++","++VOX HERESYHERESY++")]<br><br>This is [pick("Your Mother","Your Father","Mythra Redd","Norc","Briton","Trevor Kirby", "The Holy Goose God")], of the [pick("Goose Marines","Admins","rock group Led Zeppelin","Chaos Gods","Federal Reserve Bank","Ork Waaagh","Frito Lay Corperation","KOALA COALITION FOR WORLD DOMINATION","Necrontyr Empire","Adeptus Goose","Bread Factory","Tyranid Hive Fleet Chicken","Tyranid's Rights Initiative","The Greater Good")].<br>It has come to [pick("our","my")] attention that [pick("you are in a video game!","you are on drugs!","the geese are coming!")]" //Mixing it up.
							var/message = ""
							message += "<h1 class='alert'>Priority Announcement</h1>"
							message += "<br><span class='alert'>[contents]</span><br>"
							message += "<br>"
							src << sound('sound/AI/commandreport.ogg')
							src << message
						else
							soundtime = world.time
							hallucinationsong()

			if(66 to 70)
				//Flashes of danger
				//src << "Danger Flash"
				if(!halbody)
					var/list/possible_points = list()
					for(var/turf/simulated/floor/F in view(src,world.view))
						possible_points += F
					if(possible_points.len)
						var/turf/simulated/floor/target = pick(possible_points)
						switch(rand(1,4))
							if(1)
								if(hallucination > 30)
									halbody = image('icons/mob/hallucination.dmi',target,"lictor",TURF_LAYER)
							if(2)
								halbody = image('icons/mob/hallucination.dmi',target,"ripper",TURF_LAYER)
							if(3)
								halbody = image('icons/mob/human.dmi',target,"husk_s",TURF_LAYER)
							if(4)
								if(hallucination > 30)
									halbody = image('icons/mob/hallucination.dmi',target,"gretchkin",TURF_LAYER)
	//						if(5)
	//							halbody = image('xcomalien.dmi',target,"chryssalid",TURF_LAYER)

						if(client) client.images += halbody
						spawn(rand(50,80)) //Only seen for a brief moment.
							if(client) client.images -= halbody
							halbody = null
			if(71 to 72) //...This one is dumb. Lets change it. -Drake
				//Overlays the person hallucinating with something or other. Change complete.
				if(!haloverlay)
					switch(rand(1,3))
						if(1)
							if(hallucination > 50)
								haloverlay = image('icons/obj/warp_crazy.dmi',src,"aura",MOB_LAYER+0.1) //Lol this will be fun
								haloverlay.pixel_x = -74 //This should make it centered on the player. This will be amazing lol.
						if(2)
							haloverlay = image('icons/mob/hallucination.dmi',src,"invincible",MOB_LAYER+0.1)
						if(3)
							haloverlay = image('icons/mob/hallucination.dmi',src,"heretic",MOB_LAYER+0.1)
					if(client) client.images += haloverlay
					spawn(rand(30,50)) //Only seen for a brief moment.
						if(client) client.images -= haloverlay
						haloverlay = null
				//Fake death
//				src.sleeping_willingly = 1
				/*
				src.sleeping = 20
				hal_crit = 1
				hal_screwyhud = 1
				spawn(rand(50,100))
//					src.sleeping_willingly = 0
					src.sleeping = 0
					hal_crit = 0
					hal_screwyhud = 0
				*/
			if(73 to 95)
				//make it fake nearby people saying stuff
				var/list/people = list()
				for(var/mob/living/carbon/human/H in oview(src))
					people.Add(H)
				if(people.len)
					var/mob/living/carbon/human/speaker = pick(people)
					var/message = pick("WE GOT ORKS!","I am sorry, but nurgle requires that I kill you.","Thank Tzeench...","'NIDS!!!!!","HERETIC! I WILL BURN YOU!","LET THE GALAXY BURN!","DEATH TO THE CORPSE EMPEROR!","Leave this place, foolish mon'keigh.","Nurgle loves us...","Tzeench grant sight to the followers of nurgle!","Slaanesh will devour their souls...","Oxygen is toxic to heretics!","There are too many Atmospherics Technicians!","Lho erry day...","FUCKING CLOWNS!!!","Always feed the bartender a toolbox.","MEKKA MEH GOZILLA!!!","HOLY FUCKING SHIT A NECRON!","Purge the heretics!","B- But you can't- no...","Are you dense?","I am going to eat your left foot if you aren't careful.","PARTY IN THE BRIG!","HEEEELP!!!!","Kill... me...","You are not real.","And tell them you don't exist.","Rocks can't eat lollipops.","You are a heretic? Well ain't that a BURNING shame...","Fun fact: I am a xeno.","Praise... Khorne... Blood...","Can I get a pan galactic gargle blaster?","Hey, I need meds.","Somebody hacked the servo skull...","Who blew up the [pick("brig","medbay","RnD lab","bridge","chapel")]?","PRAISE THE EMPEROR!","My toes are absolutely livid!","How's life?","Hey, follow me.","Take off your jumpsuit, right now.","What was that?","Can I have your headset?","I need a pair of shoes...","Hey, whats with all the bloody flooring?","Emperor I'm hungry though...","Well fuck. That's not good.","XENOS!!! AAAHH!!!","OY!","Pray to the emperor for guidance.","Hey, can we get a better paint job here?","I need you to build me a rocket ship.","Hey, can I borrow a gun?","GET TO ESCAPE!","Hey, what time is it?","Huh... Can you please punch me?","THROW ME YOUR BAG AND PUT YOUR HANDS IN THE AIR!","What do you think?","Hey, stop.","What... Is... That...","OW!","NOOOOOOOO!","Wait a sec...","Hm...","Wait, what's your name again?","How is life?","FOR TEH GREATER GOOD!!!!!!!!","git gud scrub","NERF HALLUCINATIONS!!!!")
					if(prob(40)) message = "[pick("I","You","They","We","Orks","Heretics", "Inquisitors","Monkeys","Janitors","Tech Preists")][pick(" don't"," can't"," can"," should"," always","","","","","","","","")] [pick("like","eat","steal","execute","repair","clean","repurpose","run away from","convert","blow up","capture","drink","design","lick","sacrifice")] [pick("heretical rituals","heretics","lollipops","tech preists","lho leaf","monkeys","toolboxes","vendors","inquisitors","lord generals","the emperor","the imperium of man","floor tiles","godzilla","all the clowns","that fucking eldar","the medicus")]." //Another element of randomization ot the message.
					src << "<span class='name'>[speaker]</span> <span class='game say'>says, \"[message]\"</span>"
			if(96 to 100)
				if(prob(20)) //These were WAY to common.
					var/contents = "[pick("++VOX PRIMARIS++","++VOX PRIMARIS++","++VOX SECONDUS++","++VOX XENOS++","++VOX UNKNOWN++","++VOX REDACTED++")]<br><br>This is [pick("Uthyr Drage","Terminus Grinnman","Callistarius Maxim","John Richards","Alexander Ybkrik","Lord Bradigan","The Emperor","The Silent King","THE BLOOD GOD","John Cena","your local Eversor","Richard Odell","Lord Byron","Emperor Napoleon","Edgar Allen Poe","Walt Whitman","Donald Trump","Comissar Yarrick","Zeus","Joseph Smith")], of the [pick("Ordo Xenos","Ordo Hereticus","Officio Munitorium","Ecclesiarchy","Officio REDACTED","Imperial Guard","Adeptus Arbites")].<br>It has come to [pick("my","our","my","our","our","my","your","slaanesh's","the emperor's","the ork's")] attention that [pick("excessive","very few","red","green","heretical","imperial","mechanical","explosive","unusual","slaaneshi","orky","blue","shitty","dank")] [pick("rituals","marines","supplies","drinks","research finds","inquisitors","geese","drugs","goose marines","invasive eucalyptus plants","plagues")] [pick("have boarded the outpost","have been detected in the area","have been shot recently","are being eaten on the outpost","are being followed","are guilty of acts of heresy","are to be executed by dawn","are to be considered impure","are to be worshipped with utmost zeal")]. [pick("An inquisitor will be dispatched to handle the issue.","We will be monitering the situation.","An exterminatus has been ordered on this planet to put an end to this.","It is advised that this is halted.","We trust you will handle the situation intelligently.","Please amass supplies at the barracks to deal with this.","Please begin evacuation.","Further infractions will be met with force.","A task force is inbound.","It is absolutely vital that you--*STATIC*","Bake some bread immediately or things will get out of hand.")]<br><br>[pick("PRAISE THE EMPEROR!","AVE IMPERATOR!","EMPEROR BE PRAISED!","THE EMPEROR PROTECTS!")]"
					var/message = ""
					message += "<h1 class='alert'>Priority Announcement</h1>"
					message += "<br><span class='alert'>[contents]</span><br>"
					message += "<br>"
					src << sound('sound/AI/commandreport.ogg')
					src << message
				//make it fake a centcomm report
	handling_hal = 0




/*obj/machinery/proc/mockpanel(list/buttons,start_txt,end_txt,list/mid_txts) //Lol this looks great. I don't really want to tackle someone else's buggy code but it looks like a good idea. -Drake

	if(!mocktxt)

		mocktxt = ""

		var/possible_txt = list("Launch Escape Pods","Self-Destruct Sequence","\[Swipe ID\]","De-Monkify",\
		"Reticulate Splines","Plasma","Open Valve","Lockdown","Nerf Airflow","Kill Traitor","Nihilism",\
		"OBJECTION!","Arrest Stephen Bowman","Engage Anti-Trenna Defenses","Increase Captain IQ","Retrieve Arms",\
		"Play Charades","Oxygen","Inject BeAcOs","Ninja Lizards","Limit Break","Build Sentry")

		if(mid_txts)
			while(mid_txts.len)
				var/mid_txt = pick(mid_txts)
				mocktxt += mid_txt
				mid_txts -= mid_txt

		while(buttons.len)

			var/button = pick(buttons)

			var/button_txt = pick(possible_txt)

			mocktxt += "<a href='?src=\ref[src];[button]'>[button_txt]</a><br>"

			buttons -= button
			possible_txt -= button_txt

	return start_txt + mocktxt + end_txt + "</TT></BODY></HTML>"

proc/check_panel(mob/M)
	if (istype(M, /mob/living/carbon/human) || istype(M, /mob/living/silicon/ai))
		if(M.hallucination < 15)
			return 1
	return 0*/

mob/living/carbon/proc/hallucinationsong()
	soundevent = 1
	src << sound('sound/effects/hallucinatingbad.ogg')
	soundevent = 0

/obj/effect/fake_attacker
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = 0
	anchored = 1
	opacity = 0
	var/mob/living/carbon/human/my_target = null
	var/weapon_name = null
	var/obj/item/weap = null
	var/image/stand_icon = null
	var/image/currentimage = null
	var/icon/base = null
	var/skin_tone
	var/mob/living/clone = null
	var/image/left
	var/image/right
	var/image/up
	var/collapse
	var/image/down

	var/health = 100

/obj/effect/fake_attacker/attackby(var/obj/item/weapon/P as obj, mob/user as mob)
	step_away(src,my_target,2)
	for(var/mob/M in oviewers(world.view,my_target))
		M << "\red <B>[my_target] flails around wildly.</B>"
	my_target.show_message("\red <B>[src] has been attacked by [my_target] </B>", 1) //Lazy.

	src.health -= P.force


	return

/obj/effect/fake_attacker/Crossed(var/mob/M, somenumber)
	if(M == my_target)
		step_away(src,my_target,2)
		if(prob(30))
			for(var/mob/O in oviewers(world.view , my_target))
				O << "\red <B>[my_target] stumbles around.</B>"

/obj/effect/fake_attacker/New()
	..()
	spawn(300)
		if(my_target)
			my_target.hallucinations -= src
		qdel(src)
	step_away(src,my_target,2)
	spawn attack_loop()


/obj/effect/fake_attacker/proc/updateimage()
//	del src.currentimage


	if(src.dir == NORTH)
		del src.currentimage
		src.currentimage = new /image(up,src)
	else if(src.dir == SOUTH)
		del src.currentimage
		src.currentimage = new /image(down,src)
	else if(src.dir == EAST)
		del src.currentimage
		src.currentimage = new /image(right,src)
	else if(src.dir == WEST)
		del src.currentimage
		src.currentimage = new /image(left,src)
	my_target << currentimage


/obj/effect/fake_attacker/proc/attack_loop()
	while(1)
		sleep(rand(5,10))
		if(src.health < 0)
			collapse()
			continue
		if(get_dist(src,my_target) > 1)
			src.dir = get_dir(src,my_target)
			step_towards(src,my_target)
			updateimage()
		else
			if(prob(15))
				if(weapon_name)
					my_target << sound(pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg'))
					my_target.show_message("<span class='danger'>[my_target] has been attacked with [weapon_name] by [src.name]!</span>", 1)
					my_target.staminaloss += 30
					if(prob(20)) my_target.eye_blurry += 3
					if(prob(33))
						if(!locate(/obj/effect/overlay) in my_target.loc)
							fake_blood(my_target)
				else
					my_target << sound(pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg'))
					my_target.show_message("\red <B>[src.name] has punched [my_target]!</B>", 1)
					my_target.staminaloss += 30
					if(prob(33))
						if(!locate(/obj/effect/overlay) in my_target.loc)
							fake_blood(my_target)

		if(prob(15))
			step_away(src,my_target,2)

/obj/effect/fake_attacker/proc/collapse()
	collapse = 1
	updateimage()

/proc/fake_blood(var/mob/target)
	var/obj/effect/overlay/O = new/obj/effect/overlay(target.loc)
	O.name = "blood"
	var/image/I = image('icons/effects/blood.dmi',O,"floor[rand(1,7)]",O.dir,1)
	target << I
	spawn(300)
		qdel(O)
	return

var/list/non_fakeattack_weapons = list(/obj/item/weapon/gun/projectile, /obj/item/ammo_box/a357,\
	/obj/item/weapon/gun/energy/crossbow, /obj/item/weapon/melee/energy/sword,\
	/obj/item/weapon/storage/box/syndicate, /obj/item/weapon/storage/box/emps,\
	/obj/item/weapon/cartridge/syndicate, /obj/item/clothing/under/chameleon,\
	/obj/item/clothing/shoes/syndigaloshes, /obj/item/weapon/card/id/syndicate,\
	/obj/item/clothing/mask/gas/voice, /obj/item/clothing/glasses/thermal,\
	/obj/item/device/chameleon, /obj/item/weapon/card/emag,\
	/obj/item/weapon/storage/toolbox/syndicate, /obj/item/weapon/aiModule,\
	/obj/item/device/radio/headset/syndicate,	/obj/item/weapon/plastique,\
	/obj/item/device/powersink, /obj/item/weapon/storage/box/syndie_kit,\
	/obj/item/toy/syndicateballoon, /obj/item/weapon/gun/energy/laser/captain,\
	/obj/item/weapon/hand_tele, /obj/item/weapon/rcd, /obj/item/weapon/tank/jetpack,\
	/obj/item/clothing/under/rank/captain, /obj/item/device/aicard,\
	/obj/item/clothing/shoes/magboots, /obj/item/blueprints, /obj/item/weapon/disk/nuclear,\
	/obj/item/clothing/suit/space/nasavoid, /obj/item/weapon/tank)

/proc/fake_attack(var/mob/living/target)
//	var/list/possible_clones = new/list()
	var/mob/living/carbon/human/clone = null
	var/clone_weapon = null

	for(var/mob/living/carbon/human/H in living_mob_list)
		if(H.stat || H.lying) continue
//		possible_clones += H
		clone = H
		break	//changed the code a bit. Less randomised, but less work to do. Should be ok, world.contents aren't stored in any particular order.

//	if(!possible_clones.len) return
//	clone = pick(possible_clones)
	if(!clone)	return

	//var/obj/effect/fake_attacker/F = new/obj/effect/fake_attacker(outside_range(target))
	var/obj/effect/fake_attacker/F = new/obj/effect/fake_attacker(target.loc)
	if(clone.l_hand)
		if(!(locate(clone.l_hand) in non_fakeattack_weapons))
			clone_weapon = clone.l_hand.name
			F.weap = clone.l_hand
	else if (clone.r_hand)
		if(!(locate(clone.r_hand) in non_fakeattack_weapons))
			clone_weapon = clone.r_hand.name
			F.weap = clone.r_hand

	F.name = clone.name
	F.my_target = target
	F.weapon_name = clone_weapon
	target.hallucinations += F


	F.left = image(clone,dir = WEST)
	F.right = image(clone,dir = EAST)
	F.up = image(clone,dir = NORTH)
	F.down = image(clone,dir = SOUTH)

	if(prob(80)) //Make the percieved attacker more interesting. -Drake
		switch(rand(1,34))
			if(1)
				F.left = image('icons/mob/hallucination.dmi',F,"ork",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"ork",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"ork",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"ork",MOB_LAYER, dir = SOUTH)
				F.name = pick("Ork Nob", "Ork Nob", "Big Green Mushroom", "Assistant")
				F.weapon_name = pick("choppa", "BIG CHOPPA", "power klaw","ultramarine chainsword","syringe")
			if(2)
				F.left = image('icons/mob/hallucination.dmi',F,"gretchkin",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"gretchkin",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"gretchkin",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"gretchkin",MOB_LAYER, dir = SOUTH)
				F.name = "Gretchin"
				F.weapon_name = pick("choppa", "sharp stikk", "plague knife")
			if(3)
				F.left = image('icons/mob/hallucination.dmi',F,"wraith",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"wraith",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"wraith",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"wraith",MOB_LAYER, dir = SOUTH)
				F.name = "Wraith"
				F.weapon_name = pick("phase claw","gravitational singularity","bliss razor")
			if(4)
				F.left = image('icons/mob/hallucination.dmi',F,"necron",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"necron",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"necron",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"necron",MOB_LAYER, dir = SOUTH)
				F.name = "Necron Warrior"
				F.weapon_name = pick("phase blade", "gauss rifle", "gauss thingy", "wand of kayoss")
			if(5)
				F.left = image('icons/mob/hallucination.dmi',F,"lictor",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"lictor",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"lictor",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"lictor",MOB_LAYER, dir = SOUTH)
				F.name = "lictor ([rand(111,999)])"
				F.weapon_name = pick("claws", "HOLY SHIT TENTACLE RAPE", "drugs")
			if(6)
				F.left = image('icons/mob/hallucination.dmi',F,"ripper",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"ripper",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"ripper",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"ripper",MOB_LAYER, dir = SOUTH)
				F.name = pick("ripper", "TYRANIDS OH NOES!!!", "ITS A THNAKE!")
				F.weapon_name = pick("fangs", "drug overdose")
			if(7)
				F.left = image('icons/mob/hallucination.dmi',F,"pirate",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"pirate",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"pirate",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"pirate",MOB_LAYER, dir = SOUTH)
				F.name = pick("Piracy","Heretic","Arrgh!","Mutant")
				F.weapon_name = "cutlass"
			if(8)
				F.left = image('icons/mob/hallucination.dmi',F,"clown",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"clown",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"clown",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"clown",MOB_LAYER, dir = SOUTH)
				F.name = pick("Slaaneshi","Heretic","Acrobat","Brain Damaged Git","Honk Infestation","Rude Lord General")
				F.weapon_name = pick("bike horn", "power fist")
			if(9)
				F.left = image('icons/mob/hallucination.dmi',F,"spider",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"spider",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"spider",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"spider",MOB_LAYER, dir = SOUTH)
				F.name = pick("Cuddly Friend","Heretic","Venomous Problem","Kek Spider","Drugs", "THE SKULL THRONE")
				F.weapon_name = pick("mandibles", "amasec")
			if(10)
				F.left = image('icons/mob/hallucination.dmi',F,"cow",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"cow",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"cow",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"cow",MOB_LAYER, dir = SOUTH)
				F.name = pick("Cow","Heretic","MOOO!","Veally Big Cow","Blue Moo","Mutant","Xeno","Lord General", "[target.name]")
				F.weapon_name = pick("fangs", "UTTER DESTRUCTION", "huge ass sword")
			if(11)
				F.left = image('icons/mob/hallucination.dmi',F,"cat",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"cat",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"cat",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"cat",MOB_LAYER, dir = SOUTH)
				F.name = pick("Warp Kitten","Xeno","Spazzy Cat", "Runtime", "Heresy with fur")
				F.weapon_name = pick("claws", "mandibles", "THE EMPRAH")
			if(12)
				F.left = image('icons/mob/hallucination.dmi',F,"parrot",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"parrot",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"parrot",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"parrot",MOB_LAYER, dir = SOUTH)
				F.name = pick("Enraged Parrot","Goose","Daemon","Salamander Marine","Lord Goose")
				F.weapon_name = pick("beak","choppa","sword","chain beak")
			if(13)
				F.left = image('icons/mob/hallucination.dmi',F,"what",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"what",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"what",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"what",MOB_LAYER, dir = SOUTH)
				F.name = pick("Wtf?","WIERD RED SHIT","Scientist","HERESY","Drugs and Shit", "THE KOALA LORD!!!")
				F.weapon_name = pick("chain axe","scything talons","heresy")
			if(14)
				F.left = image('icons/mob/hallucination.dmi',F,"wierdassxeno",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"wierdassxeno",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"wierdassxeno",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"wierdassxeno",MOB_LAYER, dir = SOUTH)
				F.name = pick("A TYRANID!","Daemonette","plague induced hallucination","ALIUMS!","Inquisitor","WIERDASSXENO")
				F.weapon_name = pick("chain axe","scything talons","heresy","a space marine's weight in laserbrain dust")
			if(15)
				F.left = image('icons/mob/hallucination.dmi',F,"tripping",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"tripping",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"tripping",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"tripping",MOB_LAYER, dir = SOUTH)
				F.name = pick("A TYRANID!","Wizard","Albus Dumbledore","Zoanthrope","Sanctioned Psyker", "Lord Tzeench")
				F.weapon_name = pick("fireball","shit","heresy", "fell goose magiks")
			if(16)
				F.left = image('icons/mob/hallucination.dmi',F,"humanoid",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"humanoid",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"humanoid",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"humanoid",MOB_LAYER, dir = SOUTH)
				F.name = pick("Problem","Kroot","XENO!! BUUUURN","[target.name]","Papa Nurgle")
				F.weapon_name = pick("power knife","sharp stikk","vending machine", "unholy water")
			if(17)
				F.left = image('icons/mob/hallucination.dmi',F,"goose!",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"goose!",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"goose!",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"goose!",MOB_LAYER, dir = SOUTH)
				F.name = pick("An Assistant","Goose?","OHGODRUN","The Goose God","Lord Tzeench, Changer of Ways")
				F.weapon_name = pick("beak","bread","fell goose magiks","ALL THE BREAD IN THE WHOLE WORLD")
			if(18)
				F.left = image('icons/mob/hallucination.dmi',F,"solitaire",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"solitaire",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"solitaire",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"solitaire",MOB_LAYER, dir = SOUTH)
				F.name = pick("Knife Eared Git","A Mime?","Solitaire","LITERALLY SLAANESH")
				F.weapon_name = pick("kiss of death","spirit stone","all the books in the black archive","drugs from beyond")
			if(19)
				F.left = image('icons/mob/hallucination.dmi',F,"mandrake",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"mandrake",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"mandrake",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"mandrake",MOB_LAYER, dir = SOUTH)
				F.name = pick("Nightmare","Grimdark Shit")
				F.weapon_name = pick("soul render","curved dagger")
			if(20)
				F.left = image('icons/mob/hallucination.dmi',F,"muhreen",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"muhreen",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"muhreen",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"muhreen",MOB_LAYER, dir = SOUTH)
				F.name = pick("SPHESS MUHREEN","Imperial Diplomat","BEAKIE","BIG ARMOR DUDE")
				F.weapon_name = pick("chain axe","\"stunbaton\"","multimelta","claws")
			if(21)
				F.left = image('icons/mob/hallucination.dmi',F,"ghost",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"ghost",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"ghost",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"ghost",MOB_LAYER, dir = SOUTH)
				F.name = pick("ghost","spirit from the beyond","tainted spirit","chained soul")
				F.weapon_name = pick("transdimensional beamer","SORD","bike horn","spooooky ghost")
			if(22)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq1",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq1",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq1",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq1",MOB_LAYER, dir = SOUTH)
				F.name = pick("DAFUQ","Dodo?","Beakie","Greater Daemon","Horror of Tzeench")
				F.weapon_name = pick("scything talons")
			if(23)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq2",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq2",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq2",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq2",MOB_LAYER, dir = SOUTH)
				F.name = pick("SHARKNADOE","the imperial guard","Comissar Yarrick","The Greater Good")
				F.weapon_name = pick("Tau Rail Rifle","the fourth wall","a fridge")
			if(24)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq3",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq3",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq3",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq3",MOB_LAYER, dir = SOUTH)
				F.name = pick("PURGE THE MUTANT","strange xeno","The God Emperor of Mankind","Attack Squig")
				F.weapon_name = pick("the comissar's whip","gork and mork","space aids","servo-arm")
			if(25)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq4",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq4",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq4",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq4",MOB_LAYER, dir = SOUTH)
				F.name = pick("Blue Toes!")
				F.weapon_name = pick("Mind Bullets")
			if(26)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq5",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq5",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq5",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq5",MOB_LAYER, dir = SOUTH)
				F.name = pick("A BUG IN THE CODE!!!!","Buzzing Bee","A New Tyranid Bioform","The Ordo Xenos")
				F.weapon_name = pick("death")
			if(27)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq6",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq6",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq6",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq6",MOB_LAYER, dir = SOUTH)
				F.name = pick("Lizard","A Bloodletter","Magos Sidonius")
				F.weapon_name = pick("The Imperial Infantryman's Uplifting Primer","Shock Maul","Magical Stabby Thing")
			if(28)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq7",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq7",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq7",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq7",MOB_LAYER, dir = SOUTH)
				F.name = pick("CRABBY MAN","A Rogue Trader","Gork")
				F.weapon_name = pick("The Comissar's Hat","sandbag","monkeys")
			if(29)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq8",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq8",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq8",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq8",MOB_LAYER, dir = SOUTH)
				F.name = pick("VRISKAWHY")
				F.weapon_name = pick("snake")
			if(30)
				F.left = image('icons/mob/hallucination.dmi',F,"dafuq9",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"dafuq9",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"dafuq9",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"dafuq9",MOB_LAYER, dir = SOUTH)
				F.name = pick("PAPA NURGLE")
				F.weapon_name = pick("plague marines","syphillis","biohazardous plague infected shit")
			if(31)
				F.left = image('icons/mob/hallucination.dmi',F,"thingy",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"thingy",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"thingy",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"thingy",MOB_LAYER, dir = SOUTH)
				F.name = pick("Ogryn","Ork","Thousand Sons Sorceror")
				F.weapon_name = pick("bayonette","broken bottle","toolbox")
			if(32)
				F.left = image('icons/mob/hallucination.dmi',F,"honkrod",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"honkrod",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"honkrod",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"honkrod",MOB_LAYER, dir = SOUTH)
				F.name = pick("Intense Honk","Honkrod")
				F.weapon_name = pick("MEGA BIKE HORN")
			if(33)
				F.left = image('icons/mob/hallucination.dmi',F,"CCCP",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"CCCP",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"CCCP",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"CCCP",MOB_LAYER, dir = SOUTH)
				F.name = pick("The USSR","COMMUNISM")
				F.weapon_name = pick("The Hydraulic Clamp")
			if(34)
				F.left = image('icons/mob/hallucination.dmi',F,"guard1",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"guard1",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"guard1",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"guard1",MOB_LAYER, dir = SOUTH)
				F.name = pick("Imperial Guard")
				F.weapon_name = pick("Lasgun","Combat Knife")
			if(34)
				F.left = image('icons/mob/hallucination.dmi',F,"guard2",MOB_LAYER, dir = WEST)
				F.right = image('icons/mob/hallucination.dmi',F,"guard2",MOB_LAYER, dir = EAST)
				F.up = image('icons/mob/hallucination.dmi',F,"guard2",MOB_LAYER, dir = NORTH)
				F.down = image('icons/mob/hallucination.dmi',F,"guard2",MOB_LAYER, dir = SOUTH)
				F.name = pick("Imperial Guard")
				F.weapon_name = pick("Lasgun","Combat Knife")

//	F.base = new /icon(clone.stand_icon)
//	F.currentimage = new /image(clone)

/*



	F.left = new /icon(clone.stand_icon,dir=WEST)
	for(var/icon/i in clone.overlays)
		F.left.Blend(i)
	F.up = new /icon(clone.stand_icon,dir=NORTH)
	for(var/icon/i in clone.overlays)
		F.up.Blend(i)
	F.down = new /icon(clone.stand_icon,dir=SOUTH)
	for(var/icon/i in clone.overlays)
		F.down.Blend(i)
	F.right = new /icon(clone.stand_icon,dir=EAST)
	for(var/icon/i in clone.overlays)
		F.right.Blend(i)

	target << F.up
	*/

	F.updateimage()