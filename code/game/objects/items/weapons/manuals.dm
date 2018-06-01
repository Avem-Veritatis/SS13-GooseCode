/*********************MANUALS (BOOKS)***********************/

//Oh god what the fuck I am not good at computer
/obj/item/weapon/book/manual
	icon = 'icons/obj/library.dmi'
	due_date = 0 // Game time in 1/10th seconds
	unique = 1   // 0 - Normal book, 1 - Should not be treated as normal book, unable to be copied, unable to be modified

/obj/item/weapon/book/manual/engineering_particle_accelerator
	name = "Particle Accelerator User's Guide"
	icon_state ="bookParticleAccelerator"
	author = "The Mechanicus"
	title = "Particle Accelerator User's Guide"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h3>Experienced user's guide</h3>

				<h4>Setting up</h4>

				<ol>
					<li><b>Wrench</b> all pieces to the floor</li>
					<li>Add <b>wires</b> to all the pieces</li>
					<li>Close all the panels with your <b>screwdriver</b></li>
				</ol>

				<h4>Use</h4>

				<ol>
					<li>Open the control panel</li>
					<li>Set the speed to 2</li>
					<li>Start firing at the singularity generator</li>
					<li><font color='red'><b>When the singularity reaches a large enough size so it starts moving on it's own set the speed down to 0, but don't shut it off</b></font></li>
					<li>Remember to wear a radiation suit when working with this machine... we did tell you that at the start, right?</li>
				</ol>

				</body>
				</html>"}


/obj/item/weapon/book/manual/engineering_singularity_safety
	name = "Singularity Safety in Special Circumstances"
	icon_state ="bookEngineeringSingularitySafety"
	author = "The Mechanicus"		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	title = "Singularity Safety in Special Circumstances"
//big pile of shit below.

	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>Singularity Safety in Special Circumstances</h3>

				<h4>Power outage</h4>

				A power problem has made the entire station lose power? Could be station-wide wiring problems or syndicate power sinks. In any case follow these steps:
				<p>
				<b>Step one:</b> <b><font color='red'>PANIC!</font></b><br>
				<b>Step two:</b> Get your ass over to engineering! <b>QUICKLY!!!</b><br>
				<b>Step three:</b> Make sure the SMES is still powering the emitters, if not, setup the generator in secure storage and disconnect the emitters from the SMES.<br>
				<b>Step four:</b> Next, head over to the APC and swipe it with your <b>ID card</b> - if it doesn't unlock, continue with step 15.<br>
				<b>Step five:</b> Open the console and disengage the cover lock.<br>
				<b>Step six:</b> Pry open the APC with a <b>Crowbar.</b><br>
				<b>Step seven:</b> Take out the empty <b>power cell.</b><br>
				<b>Step eight:</b> Put in the new, <b>full power cell</b> - if you don't have one, continue with step 15.<br>
				<b>Step nine:</b> Quickly put on a <b>Radiation suit.</b><br>
				<b>Step ten:</b> Check if the <b>singularity field generators</b> withstood the down-time - if they didn't, continue with step 15.<br>
				<b>Step eleven:</b> Since disaster was averted you now have to ensure it doesn't repeat. If it was a powersink which caused it and if the engineering apc is wired to the same powernet, which the powersink is on, you have to remove the piece of wire which links the apc to the powernet. If it wasn't a powersink which caused it, then skip to step 14.<br>
				<b>Step twelve:</b> Grab your crowbar and pry away the tile closest to the APC.<br>
				<b>Step thirteen:</b> Use the wirecutters to cut the wire which is conecting the grid to the terminal. <br>
				<b>Step fourteen:</b> Go to the bar and tell the guys how you saved them all. Stop reading this guide here.<br>
				<b>Step fifteen:</b> <b>GET THE FUCK OUT OF THERE!!!</b><br>
				</p>

				<h4>Shields get damaged</h4>

				Step one: <b>GET THE FUCK OUT OF THERE!!! FORGET THE WOMEN AND CHILDREN, SAVE YOURSELF!!!</b><br>
				</body>
				</html>
				"}

/obj/item/weapon/book/manual/marshallarts
	name = "Close Combat Handbook"
	icon_state ="combat"
	author = "The Astra Militarum"
	title = "Close Combat Handbook"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h3>A Comprehensive Guide to Close Combat</h3>

				Unarmed Combat
					-Additional speed is extremely helpful. Steroids will also increase performance in unarmed combat.
						-A disarming move at high speeds will result in shoving the opponent out of the way and sending them sprawling.
						-A grabbing move at high speeds will result in a tackle.
						-A harming move at high speeds will result in additional damage. High enough speeds may allow you to perform a drop kick.
					-Attacking an opponent from behind will also prove helpful.
						-Grabbing somebody from behind will temporarily incapacitate them.
						-Punches from behind will do additional damage. An attack from behind is also the only way to land a blow on somebody who can block your blows with a sword.

				Sword Combat
					-Help intent will perform a knockback move.
					-Disarm intent will perform a disarming move.
					-Grab intent will perform a hamstring move.
					-Harm intent will perform a regular attack.
					-If you select a piercing attack you will perform a regular attack that will take additional time to recover from, but will be more effective at piercing through an opponent's armor.
					-There are two primary fighting stances. Agressive and Defensive.
						-In Defensive Stance, one may parry attacks. ((Ctrl+Click the person whose attack you want to parry. You also have some chance to parry them regardless of clicking if you are facing them directly head on))
						-Preparation for a parry followed by a successful disarm will result in the execution of a move in which you will grab the opponents weapon off the floor.
						-In Agressive Stance, one may charge at the enemy. ((This also uses Ctrl+Click))
						-Agressive stance also features a dangerous offensive move formed by successfully hamstringing the opponent and then repeatedly delivering piercing blows upon them.

				Knife Fighting
					-Knives are effective at slitting the throats of anybody held in a strangle hold.
					-A knife to the back at high speed will really ruin an opponent's day, even if they wear significant armor. Be warned that the knife will probably stick in their back, though.

				Note that this is the first edition of this handbook. Revised editions will likely be released, which will be much more complete.

				</body>
				</html>"}

/obj/item/weapon/book/manual/greytide
	name = "Makeshift Weapon Crafting"
	icon_state ="bookHacking"
	author = "Kyner Industries"
	title = "Makeshift Weapon Crafting"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h3>Weapon Crafting</h3>

				Cattle Prod
					-Wire a metal rod with cable cuffs.
					-Attach wirecutters to the end of the rod.
					-Add a power source.

				Spear
					-Wire a metal rod with cable cuffs.
					-Tie a glass shard to the end of the rod.

				IED
					-Add an igniter to a soda can.
					-Fill this assembly with welder fuel.
					-Wire up the pieces with cable.

				Beartrap Bomb
					-Tie a grenade to a beartrap so it will detonate on triggering.

				Shield
					-Place metal, cable cuffs, and metal rods on a table.
					-Assemble parts.

				Shotgun
					-Drill out a metal rod into a barrel. The barrel may be sawed off at this stage.
					-Create a stock or handle out of wood or plasteel. A wooden stock may be sawed into a new shape.
					-Create a grip out of wood or plasteel.
					-Find a reciever (or construct one on a table) and attach it to the stock.
					-Attach the barrel to this assembly.
					-Secure the assembly with a screwdriver.
					-Attach the grip.

				Improvised Shotgun Shell
					-Place the following on a table:
						-Metal
						-Rods
						-Sulfur
						-Welding Fuel
						-Paper
					-Assemble parts
					-Note that there are four total designs for a homebrew shotgun shell. One of them can be created with the addition of promethium to a regular slug. Another may be created with certain explosives.

				Butterfly Knife
					-Create a knife grip with plasteel.
					-Create a knife blade with iron.
					-Assemble the parts.

				</body>
				</html>"}

/obj/item/weapon/book/manual/hydroponics_pod_people
	name = "The Human Harvest - From seed to market"
	icon_state ="bookHydroponicsPodPeople"
	author = "Farmer John"
	title = "The Human Harvest - From seed to market"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>Growing Humans</h3>

				Why would you want to grow humans? Well I'm expecting most readers to be in the slave trade, but a few might actually
				want to revive fallen comrades. Growing pod people is easy, but prone to disaster.
				<p>
				<ol>
				<li>Find a dead person who is in need of cloning. </li>
				<li>Take a blood sample with a syringe. </li>
				<li>Inject a seed pack with the blood sample. </li>
				<li>Plant the seeds. </li>
				<li>Tend to the plants water and nutrition levels until it is time to harvest the cloned human.</li>
				</ol>
				<p>
				It really is that easy! Good luck!

				</body>
				</html>
				"}

/obj/item/weapon/book/manual/medical_cloning
	name = "Cloning techniques of the 26th century"
	icon_state ="bookCloning"
	author = "Medical Journal, volume 3"		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	title = "Cloning techniques of the 26th century"
//big pile of shit below.

	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<H3>How to Clone People</H3>
				So there's 50 dead people lying on the floor, chairs are spinning like no tomorrow and you haven't the foggiest idea of what to do? Not to worry! This guide is intended to teach you how to clone people and how to do it right, in a simple step-by-step process! If at any point of the guide you have a mental meltdown, genetics probably isn't for you and you should get a job-change as soon as possible before you're sued for malpractice.

				<ol>
					<li><a href='#1'>Acquire body</a></li>
					<li><a href='#2'>Strip body</a></li>
					<li><a href='#3'>Put body in cloning machine</a></li>
					<li><a href='#4'>Scan body</a></li>
					<li><a href='#5'>Clone body</a></li>
					<li><a href='#6'>Get clean Structurel Enzymes for the body</a></li>
					<li><a href='#7'>Put body in morgue</a></li>
					<li><a href='#8'>Await cloned body</a></li>
					<li><a href='#9'>Use the clean SW injector</a></li>
					<li><a href='#10'>Give person clothes back</a></li>
					<li><a href='#11'>Send person on their way</a></li>
				</ol>

				<a name='1'><H4>Step 1: Acquire body</H4>
				This is pretty much vital for the process because without a body, you cannot clone it. Usually, bodies will be brought to you, so you do not need to worry so much about this step. If you already have a body, great! Move on to the next step.

				<a name='2'><H4>Step 2: Strip body</H4>
				The cloning machine does not like abiotic items. What this means is you can't clone anyone if they're wearing clothes, so take all of it off. If it's just one person, it's courteous to put their possessions in the closet. If you have about seven people awaiting cloning, just leave the piles where they are, but don't mix them around and for God's sake don't let the Clown in to steal them.

				<a name='3'><H4>Step 3: Put body in cloning machine</H4>
				Grab the body and then put it inside the DNA modifier. If you cannot do this, then you messed up at Step 2. Go back and check you took EVERYTHING off - a commonly missed item is their headset.

				<a name='4'><H4>Step 4: Scan body</H4>
				Go onto the computer and scan the body by pressing 'Scan - <Subject Name Here>'. If you're successful, they will be added to the records (note that this can be done at any time, even with living people, so that they can be cloned without a body in the event that they are lying dead on port solars and didn't turn on their suit sensors)! If not, and it says 'Error: Mental interface failure.', then they have left their bodily confines and are one with the spirits. If this happens, just shout at them to get back in their body, click 'Refresh' and try scanning them again. If there's no success, threaten them with gibbing. Still no success? Skip over to Step 7 and don't continue after it, as you have an unresponsive body and it cannot be cloned. If you got 'Error: Unable to locate valid genetic data.', you are trying to clone a monkey - start over.

				<a name='5'><H4>Step 5: Clone body</H4>
				Now that the body has a record, click 'View Records', click the subject's name, and then click 'Clone' to start the cloning process. Congratulations! You're halfway there. Remember not to 'Eject' the cloning pod as this will kill the developing clone and you'll have to start the process again.

				<a name='6'><H4>Step 6: Get clean SEs for body</H4>
				Cloning is a finicky and unreliable process. Whilst it will most certainly bring someone back from the dead, they can have any number of nasty disabilities given to them during the cloning process! For this reason, you need to prepare a clean, defect-free Structural Enzyme (SE) injection for when they're done. If you're a competent Geneticist, you will already have one ready on your working computer. If, for any reason, you do not, then eject the body from the DNA modifier (NOT THE CLONING POD) and take it next door to the Genetics research room. Put the body in one of those DNA modifiers and then go onto the console. Go into View/Edit/Transfer Buffer, find an open slot and click 'SE' to save it. Then click 'Injector' to get the SEs in syringe form. Put this in your pocket or something for when the body is done.

				<a name='7'><H4>Step 7: Put body in morgue</H4>
				Now that the cloning process has been initiated and you have some clean Structural Enzymes, you no longer need the body! Drag it to the morgue and tell the Chef over the radio that they have some fresh meat waiting for them in there. To put a body in a morgue bed, simply open the tray, grab the body, put it on the open tray, then close the tray again. Use one of the nearby pens to label the bed 'CHEF MEAT' in order to avoid confusion.

				<a name='8'><H4>Step 8: Await cloned body</H4>
				Now go back to the lab and wait for your patient to be cloned. It won't be long now, I promise.

				<a name='9'><H4>Step 9: Use the clean SE injector on person</H4>
				Has your body been cloned yet? Great! As soon as the guy pops out, grab your injector and jab it in them. Once you've injected them, they now have clean Structural Enzymes and their defects, if any, will disappear in a short while.

				<a name='10'><H4>Step 10: Give person clothes back</H4>
				Obviously the person will be naked after they have been cloned. Provided you weren't an irresponsible little shit, you should have protected their possessions from thieves and should be able to give them back to the patient. No matter how cruel you are, it's simply against protocol to force your patients to walk outside naked.

				<a name='11'><H4>Step 11: Send person on their way</H4>
				Give the patient one last check-over - make sure they don't still have any defects and that they have all their possessions. Ask them how they died, if they know, so that you can report any foul play over the radio. Once you're done, your patient is ready to go back to work! Chances are they do not have Medbay access, so you should let them out of Genetics and the Medbay main entrance.

				<p>If you've gotten this far, congratulations! You have mastered the art of cloning. Now, the real problem is how to resurrect yourself after that traitor had his way with you for cloning his target.



				</body>
				</html>
				"}


/obj/item/weapon/book/manual/ripley_build_and_repair
	name = "APLU \"Ripley\" Construction and Operation Manual"
	icon_state ="book"
	author = "Weyland-Yutani Corp"		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	title = "APLU \"Ripley\" Construction and Operation Manual"
//big pile of shit below.

	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<center>
				<b style='font-size: 12px;'>Weyland-Yutani - Building Better Worlds</b>
				<h1>Autonomous Power Loader Unit \"Ripley\"</h1>
				</center>
				<h2>Specifications:</h2>
				<ul>
				<li><b>Class:</b> Autonomous Power Loader</li>
				<li><b>Scope:</b> Logistics and Construction</li>
				<li><b>Weight:</b> 820kg (without operator and with empty cargo compartment)</li>
				<li><b>Height:</b> 2.5m</li>
				<li><b>Width:</b> 1.8m</li>
				<li><b>Top speed:</b> 5km/hour</li>
				<li><b>Operation in vacuum/hostile environment:</b> Possible</b>
				<li><b>Airtank Volume:</b> 500liters</li>
				<li><b>Devices:</b>
					<ul>
					<li>Hydraulic Clamp</li>
					<li>High-speed Drill</li>
					</ul>
				</li>
				<li><b>Propulsion Device:</b> Powercell-powered electro-hydraulic system.</li>
				<li><b>Powercell capacity:</b> Varies.</li>
				</ul>

				<h2>Construction:</h2>
				<ol>
				<li>Connect all exosuit parts to the chassis frame</li>
				<li>Connect all hydraulic fittings and tighten them up with a wrench</li>
				<li>Adjust the servohydraulics with a screwdriver</li>
				<li>Wire the chassis. (Cable is not included.)</li>
				<li>Use the wirecutters to remove the excess cable if needed.</li>
				<li>Install the central control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the mainboard with a screwdriver.</li>
				<li>Install the peripherals control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the peripherals control module with a screwdriver</li>
				<li>Install the internal armor plating (Not included due to imperial regulations. Can be made using 5 metal sheets.)</li>
				<li>Secure the internal armor plating with a wrench</li>
				<li>Weld the internal armor plating to the chassis</li>
				<li>Install the external reinforced armor plating (Not included due to imperial regulations. Can be made using 5 reinforced metal sheets.)</li>
				<li>Secure the external reinforced armor plating with a wrench</li>
				<li>Weld the external reinforced armor plating to the chassis</li>
				<li></li>
				<li>Additional Information:</li>
				<li>The firefighting variation is made in a similar fashion.</li>
				<li>A firesuit must be connected to the Firefighter chassis for heat shielding.</li>
				<li>Internal armor is plasteel for additional strength.</li>
				<li>External armor must be installed in 2 parts, totaling 10 sheets.</li>
				<li>Completed mech is more resiliant against fire, and is a bit more durable overall</li>
				<li>The imperium is dedicated to the safety of its <s>slaves and meat shields</s> loyal and esteemed flock.</li>
				</ol>
				</body>
				</html>

				<h2>Operation</h2>
				Coming soon...
			"}


/obj/item/weapon/book/manual/research_and_development
	name = "Research and Development 101"
	icon_state = "rdbook"
	author = "Dr. L. Ight"
	title = "Research and Development 101"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Science For Dummies</h1>
				So you want to further SCIENCE? Good man/woman/thing! However, SCIENCE is a complicated process even though it's quite easy. For the most part, it's a three step process:
				<ol>
					<li> 1) Deconstruct items in the Destructive Analyzer to advance technology or improve the design.</li>
					<li> 2) Build unlocked designs in the Protolathe and Circuit Imprinter</li>
					<li> 3) Repeat!</li>
				</ol>

				Those are the basic steps to furthing science. What do you do science with, however? Well, you have four major tools: R&D Console, the Destructive Analyzer, the Protolathe, and the Circuit Imprinter.

				<h2>The R&D Console</h2>
				The R&D console is the cornerstone of any research lab. It is the central system from which the Destructive Analyzer, Protolathe, and Circuit Imprinter (your R&D systems) are controled. More on those systems in their own sections. On its own, the R&D console acts as a database for all your technological gains and new devices you discover. So long as the R&D console remains intact, you'll retain all that SCIENCE you've discovered. Protect it though, because if it gets damaged, you'll lose your data! In addition to this important purpose, the R&D console has a disk menu that lets you transfer data from the database onto disk or from the disk into the database. It also has a settings menu that lets you re-sync with nearby R&D devices (if they've become disconnected), lock the console from the unworthy, upload the data to all other R&D consoles in the network (all R&D consoles are networked by default), connect/disconnect from the network, and purge all data from the database.
				<b>NOTE:</b> The technology list screen, circuit imprinter, and protolathe menus are accessible by non-scientists. This is intended to allow 'public' systems for the plebians to utilize some new devices.

				<h2>Destructive Analyzer</h2>
				This is the source of all technology. Whenever you put a handheld object in it, it analyzes it and determines what sort of technological advancements you can discover from it. If the technology of the object is equal or higher then your current knowledge, you can destroy the object to further those sciences. Some devices (notably, some devices made from the protolathe and circuit imprinter) aren't 100% reliable when you first discover them. If these devices break down, you can put them into the Destructive Analyzer and improve their reliability rather then futher science. If their reliability is high enough ,it'll also advance their related technologies.

				<h2>Circuit Imprinter</h2>
				This machine, along with the Protolathe, is used to actually produce new devices. The Circuit Imprinter takes glass and various chemicals (depends on the design) to produce new circuit boards to build new machines or computers. It can even be used to print AI modules.

				<h2>Protolathe</h2>
				This machine is an advanced form of the Autolathe that produce non-circuit designs. Unlike the Autolathe, it can use processed metal, glass, solid plasma, silver, gold, and diamonds along with a variety of chemicals to produce devices. The downside is that, again, not all devices you make are 100% reliable when you first discover them.

				<h1>Reliability and You</h1>
				As it has been stated, many devices when they're first discovered do not have a 100% reliablity when you first discover them. Instead, the reliablity of the device is dependent upon a base reliability value, whatever improvements to the design you've discovered through the Destructive Analyzer, and any advancements you've made with the device's source technologies. To be able to improve the reliability of a device, you have to use the device until it breaks beyond repair. Once that happens, you can analyze it in a Destructive Analyzer. Once the device reachs a certain minimum reliability, you'll gain tech advancements from it.

				<h1>Building a Better Machine</h1>
				Many machines produces from circuit boards and inserted into a machine frame require a variety of parts to construct. These are parts like capacitors, batteries, matter bins, and so forth. As your knowledge of science improves, more advanced versions are unlocked. If you use these parts when constructing something, its attributes may be improved. For example, if you use an advanced matter bin when constructing an autolathe (rather then a regular one), it'll hold more materials. Experiment around with stock parts of various qualities to see how they affect the end results! Be warned, however: Tier 3 and higher stock parts don't have 100% reliability and their low reliability may affect the reliability of the end machine.
				</body>
				</html>
			"}


/obj/item/weapon/book/manual/robotics_cyborgs
	name = "Servitors for Dummies"
	icon_state = "borgbook"
	author = "XISC"
	title = "Servitors for Dummies"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 21px; margin: 15px 0px 5px;}
				h2 {font-size: 18px; margin: 15px 0px 5px;}
        h3 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Servitors for Dummies</h1>

				<h2>Chapters</h2>

				<ol>
					<li><a href="#Equipment">Servitor Related Equipment</a></li>
					<li><a href="#Modules">Servitor Modules</a></li>
					<li><a href="#Construction">Servitor Construction</a></li>
					<li><a href="#Deconstruction">Servitor Deconstruction</a></li>
					<li><a href="#Maintenance">Servitor Maintenance</a></li>
					<li><a href="#Repairs">Servitor Repairs</a></li>
					<li><a href="#Emergency">In Case of Emergency</a></li>
				</ol>


				<h2><a name="Equipment">Servitor Related Equipment</h2>

				<h3>Exosuit Fabricator</h3>
				The Exosuit Fabricator is the most important piece of equipment related to servitors. It allows the construction of the core servitor parts. Without these machines, servitors can not be built. It seems that they may also benefit from advanced research techniques.

				<h3>Servitor Recharging Station</h3>
				This useful piece of equipment will suck power out of the power systems to charge a servitor's power cell back up to full charge.

				<h3>Robotics Control Console</h3>
				This useful piece of equipment can be used to immobolize or destroy a servitor. A word of warning: Servitors are expensive pieces of equipment, do not destroy them without good reason, or the sector administratum may see to it that it never happens again.


				<h2><a name="Modules">Servitor Modules</h2>
				When a servitor is created it picks out of an array of modules to designate its purpose. There are 6 different servitor modules.

				<h3>Standard Servitor</h3>
				The standard servitor module is a multi-purpose servitor. It is equipped with various modules, allowing it to do basic tasks.<br>

				<h3>Mechanicus Servitor</h3>
				The Mechanicus servitor module comes equipped with various engineering-related tools to please the machine god.<br>

				<h3>Mining Servitor</h3>
				The mining servitor module comes equipped with the latest in mining equipment. They are efficient at mining due to no need for oxygen, but their power cells limit their time in the mines.

				<h3>Guard Servitor</h3>
				The guard servitor module is equipped with effective security measures used to apprehend and arrest criminals without harming them a bit.

				<h3>Janitor Servitor</h3>
				The janitor servitor module is equipped with various cleaning-facilitating devices.

				<h3>Service Servitor</h3>
				The service servitor module comes ready to serve your human needs. It includes various entertainment and refreshment devices. Occasionally some service servitors may have been referred to as "Bros"

				<h2><a name="Construction">Servitor Construction</h2>
				Servitor construction is a rather easy process, requiring a decent amount of metal and a few other supplies.<br>The required materials to make a servitor are:
				<ul>
				  <li>Metal</li>
				  <li>Two Flashes</li>
				  <li>One Power Cell (Preferrably rated to 15000w)</li>
				  <li>Some electrical wires</li>
				  <li>One Human Brain</li>
				  <li>One Man-Machine Interface</li>
				</ul>
				Once you have acquired the materials, you can start on construction of your servitor.<br>To construct a servitor, follow the steps below:
				<ol>
				  <li>Start the Exosuit Fabricators constructing all of the servitor parts</li>
				  <li>While the parts are being constructed, take your human brain, and place it inside the Man-Machine Interface</li>
				  <li>Once you have a Robot Head, place your two flashes inside the eye sockets</li>
				  <li>Once you have your Robot Chest, wire the Robot chest, then insert the power cell</li>
				  <li>Attach all of the Robot parts to the Robot frame</li>
				  <li>Insert the Man-Machine Interface (With the Brain inside) Into the Robot Body</li>
				  <li>Congratulations! You have a new servitor!</li>
				</ol>

				<h2><a name="Deconstruction">Servitor Deconstruction</h2>
				If you want to deconstruct a servitor, say to remove its MMI without <a href="#Emergency">blowing the servitor to pieces</a>, they come apart very quickly, <b>and</b> very safely, in a few simple steps.
				<ul>
				  <li>Crowbar</li>
				  <li>Wrench</li>
				  Optional:
				  <li>Screwdriver</li>
				  <li>Wirecutters</li>
				</ul>
				<ol>
				  <li>Begin by unlocking the servitor's access panel using your ID</li>
				  <li>Use your crowbar to open the servitor's access panel</li>
				  <li>Using your bare hands, remove the power cell from the servitor</li>
				  <li>Lockdown the servitor to disengage safety protocols</li>
				  <ol>
				    Option 1: Robotics console
				    <li>Use the Robotics console in the RD's office</li>
				    <li>Find the entry for your servitor</li>
				    <li>Press the Lockdown button on the Robotics console</li>
				  </ol>
				  <ol>
				    Option 2: Lockdown wire
				    <li>Use your screwdriver to expose the servitor's wiring</li>
				    <li>Use your wirecutters to start cutting all of the wires until the lockdown light turns off, cutting all of the wires irregardless of the lockdown light works as well</li>
				  </ol>
				  <li>Use your wrench to unfasten the servitor's bolts, the servitor will then fall apart onto the floor, the MMI will be there as well</li>
				</ol>

				<h2><a name="Maintenance">servitor Maintenance</h2>
				Occasionally servitors may require maintenance of a couple types, this could include replacing a power cell with a charged one, or possibly maintaining the servitor's internal wiring.

				<h3>Replacing a Power Cell</h3>
				Replacing a Power cell is a common type of maintenance for servitors. It usually involves replacing the cell with a fully charged one, or upgrading the cell with a larger capacity cell.<br>The steps to replace a cell are follows:
				<ol>
				  <li>Unlock the servitor's Interface by swiping your ID on it</li>
				  <li>Open the servitor's outer panel using a crowbar</li>
				  <li>Remove the old power cell</li>
				  <li>Insert the new power cell</li>
				  <li>Close the servitor's outer panel using a crowbar</li>
				  <li>Lock the servitor's Interface by swiping your ID on it, this will prevent non-qualified personnel from attempting to remove the power cell</li>
				</ol>

				<h3>Exposing the Internal Wiring</h3>
				Exposing the internal wiring of a servitor is fairly easy to do, and is mainly used for servitor repairs.<br>You can easily expose the internal wiring by following the steps below:
				<ol>
				  <li>Follow Steps 1 - 3 of "Replacing a servitor's Power Cell"</li>
				  <li>Open the servitor's internal wiring panel by using a screwdriver to unsecure the panel</li>
			  </ol>
			  To re-seal the servitor's internal wiring:
			  <ol>
			    <li>Use a screwdriver to secure the servitor's internal panel</li>
			    <li>Follow steps 4 - 6 of "Replacing a servitor's Power Cell" to close up the servitor</li>
			  </ol>

			  <h2><a name="Repairs">servitor Repairs</h2>
			  Occasionally a servitor may become damaged. This could be in the form of impact damage from a heavy or fast-travelling object, or it could be heat damage from high temperatures, or even lasers or Electromagnetic Pulses (EMPs).

			  <h3>Dents</h3>
			  If a servitor becomes damaged due to impact from heavy or fast-moving objects, it will become dented. Sure, a dent may not seem like much, but it can compromise the structural integrity of the servitor, possibly causing a critical failure.
			  Dents in a servitor's frame are rather easy to repair, all you need is to apply a welding tool to the dented area, and the high-tech servitor frame will repair the dent under the heat of the welder.

        <h3>Excessive Heat Damage</h3>
        If a servitor becomes damaged due to excessive heat, it is likely that the internal wires will have been damaged. You must replace those wires to ensure that the servitor remains functioning properly.<br>To replace the internal wiring follow the steps below:
        <ol>
          <li>Unlock the servitor's Interface by swiping your ID</li>
          <li>Open the servitor's External Panel using a crowbar</li>
          <li>Remove the servitor's Power Cell</li>
          <li>Using a screwdriver, expose the internal wiring or the servitor</li>
          <li>Replace the damaged wires inside the servitor</li>
          <li>Secure the internal wiring cover using a screwdriver</li>
          <li>Insert the servitor's Power Cell</li>
          <li>Close the servitor's External Panel using a crowbar</li>
          <li>Lock the servitor's Interface by swiping your ID</li>
        </ol>
        These repair tasks may seem difficult, but are essential to keep your servitors running at peak efficiency.

        <h2><a name="Emergency">In Case of Emergency</h2>
        In case of emergency, there are a few steps you can take.

        <h3>"Rogue" servitors</h3>
        If the servitors seem to become "rogue", they may have non-standard laws. In this case, use extreme caution.
        To repair the situation, follow these steps:
        <ol>
          <li>Locate the nearest robotics console</li>
          <li>Determine which servitors are "Rogue"</li>
          <li>Press the lockdown button to immobolize the servitor</li>
          <li>Locate the servitor</li>
          <li>Expose the servitor's internal wiring</li>
          <li>Check to make sure the LawSync and AI Sync lights are lit</li>
          <li>If they are not lit, pulse the LawSync wire using a multitool to enable the servitor's Law Sync</li>
          <li>Proceed to a servitor upload console. Standard Imperial outpost schematics usually place these in the same location as AI uplaod consoles.</li>
          <li>Use a "Reset" upload moduleto reset the servitor's laws</li>
          <li>Proceed to a Robotics Control console</li>
          <li>Remove the lockdown on the servitor</li>
        </ol>

        <h3>As a last resort</h3>
        If all else fails in a case of servitor-related emergency. There may be only one option. Using a Robotics Control console, you may have to remotely detonate the servitor.
        <h3>WARNING:</h3> Do not detonate a borg without an explicit reason for doing so. Servitors are expensive pieces of imperial equipment, and you may be punished for detonating them without reason.

        </body>
		</html>
		"}



/obj/item/weapon/book/manual/chef_recipes
	name = "Chef Recipes"
	icon_state = "cooked_book"
	author = "Lord Frenrir Cageth"
	title = "Chef Recipes"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Food for Dummies</h1>
				Here is a guide on basic food recipes and also how to not poison your customers accidentally.

				<h2>Burger:<h2>
				Put 1 meat and 1 flour into the microwave and turn it on. Then wait.

				<h2>Bread:<h2>
				Put 3 flour into the microwave and then wait.

				<h2>Waffles:<h2>
				Add 2 flour and 2 eggs to the microwave and then wait.

				<h2>Popcorn:<h2>
				Add 1 corn to the microwave and wait.

				<h2>Meat Steak:<h2>
				Put 1 meat, 1 unit of salt and 1 unit of pepper into the microwave and wait.

				<h2>Meat Pie:<h2>
				Put 1 meat and 2 flour into the microwave and wait.

				<h2>Boiled Spagetti:<h2>
				Put 1 spagetti and 5 units of water into the microwave and wait.

				<h2>Donuts:<h2>
				Add 1 egg and 1 flour to the microwave and wait.

				<h2>Fries:<h2>
				Add one potato to the processor and wait.

				<h2>Customizables:<h2>
				In addition to the foods above, you can create unique dishes. Here's how:

				<h2>SANDWICH:<h2>
				Add any food item to a bread slice.

				<h2>BURGER:<h2>
				Add any food item to a bun.

				<h2>SPAGETTI:<h2>
				Add any food item to a boiled spaghetti.

				<h2>PERSONAL PAN PIZZA:<h2>
				Add any food item to some flat dough.

				<h2>SOUP:<h2>
				Add any food item to a bowl, which you can get from a dinnerware vendor.

				<h2>Dough:<h2>
				Set 1 egg and a bag of Flour onto a table and clickdrag the table onto you. Select dough from the menu.

				<h2>Flat Dough:<h2>
				Use a rolling pin on some dough.

				<h2>Bun:<h2>
				Bake a dough in the microwave.


				</body>
				</html>
			"}

/obj/item/weapon/book/manual/barman_recipes
	name = "Barman Recipes"
	icon_state = "barbook"
	author = "Sir John Rose"
	title = "Barman Recipes"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Drinks for dummies</h1>
				Heres a guide for some basic drinks.

				<h2>Manly Dorf:</h2>
				Mix ale and beer into a glass.

				<h2>Grog:</h2>
				Mix rum and water into a glass.

				<h2>Black Russian:</h2>
				Mix vodka and kahlua into a glass.

				<h2>Irish Cream:</h2>
				Mix cream and whiskey into a glass.

				<h2>Screwdriver:</h2>
				Mix vodka and orange juice into a glass.

				<h2>Cafe Latte:</h2>
				Mix milk and coffee into a glass.

				<h2>Mead:</h2>
				Mix Enzyme, water and sugar into a glass.

				<h2>Gin Tonic:</h2>
				Mix gin and tonic into a glass.

				<h2>Classic Martini:</h2>
				Mix vermouth and gin into a glass.


				</body>
				</html>
			"}


/obj/item/weapon/book/manual/detective
	name = "The Commissar’s Complete Guide to Imperial Propaganda"
	icon_state ="bookDetective"
	author = "BlackLibray"
	title = "The Commissar’s Complete Guide to Imperial Propaganda"
	dat = {"<html>
			<head>
			<style>
			h1 {font-size: 18px; margin: 15px 0px 5px;}
			h2 {font-size: 15px; margin: 15px 0px 5px;}
			li {margin: 2px 0px 2px 15px;}
			ul {list-style: none; margin: 5px; padding: 0px;}
			ol {margin: 5px; padding: 0px 15px;}
			</style>
			</head>
			<body>
			<h3>Detective Work</h3>

			Welcome, commissars, to the Complete Guide to Imperial Propaganda. Today, we will introduce you to the most powerful tool in a commissar’s arsenal.<br>
			Contrary to popular belief, that is not the holy bolt pistol, though it is undoubtedly a weapon of extreme power, or the blessed chainsword. <br>
			The most powerful weapon in a commissar’s arsenal is the Holy Truth of the God-Emperor.<br>
			<p>
			<ol>
			<li>Be Inspirational. </li>
			<li>A commissar must inspire his troops, creating an unshakeable belief in the Divine Truth of the Imperial Creed.<br>
			Repeated rhetoric will help embed your views, so that even in the face of compelling evidence to the contrary, your words <br>
			will hold true and your men will never flee. Of course, if the odd one does, shoot him. This acts as an excellent deterrent <br>
			to any other would-be deserters.</li>
			<li>‘Any soldier who, in the face of the enemy, runs away, or shamefully abandons his post or guard, <br>
			or induces others to do the like, or casts away his arms or ammunition, or attempts to take his own life shall<br>
			 be shot on the spot.’ -The Imperial Infantryman’s Handbook Art. 8055/14v</li><br>
			<li>Tell them what they need to know<br>
			It is up to you to make sure that what you say is law and that no amount of empirical evidence can shake the belief<br>
			that you have instilled. Be sure to focus on ways to reinforce the belief in your tactical superiority over the myriad <br>
			foes you will face.‘Genestealers attack in swarms. This means they present a large target.<br>
			Use frag grenades and volley fire to blow them to ichor.’ -Imperial Infantryman’s Handbook Section 2, iii </li><br>
			<li>Know your history./li>
			<li>Make sure you read about all of the most successful crusades to provide you with inspiring examples you can quote<br>
			to further motivate those under your command. Some excellent examples include the Sabbat Worlds Crusade, particularly the<br>
			engagements of Colonel-Commissar Ibram Gaunt and his Tanith First, the memoirs of Commissar Ciaphas Cain, Hero of the Imperium,<br>
			and of course, the Macharian Crusade, led by Lord Solar Macharius.‘The Imperial Guard is a venerable and glorious army,<br>
			steeped high in history and honour. The armies of the Imperium span the galaxy, and have done so for millennia.<br>
			Imperial Guard methods in the art of war are fixed, the dogmas of strategy and battlefield policy have secured <br>
			the Imperium and stemmed the brutish tides of the foul and heretical.’ -The Imperial Infantryman’s Handbook<br></li>
			<li>Follow these simple rules and keep your copy of The Imperial Infantryman’s Handbook close to your chest, and victory is assured.</li>
			<li>For the Emperor!</li>
			</ol>
			<p>

			</body>
			</html>"}

/obj/item/weapon/book/manual/nuclear
	name = "Blood Pact for Dummies"
	icon_state ="bookNuclear"
	author = "KHORNE"
	title = "Blood Pact for Dummies"
	dat = {"<html>
			Nuclear Explosives 101:<br>
			Hello and thank you for choosing the blood god for your nuclear information needs.<br>
			Today's crash course will deal with the operation of an imperial meltabomb.<br>
			First and foremost, DO NOT TOUCH ANYTHING UNTIL THE BOMB IS IN PLACE.<br>
			Pressing any button on the compacted bomb will cause it to extend and bolt itself into place.<br>
			If this is done to unbolt it one must completely log in which at this time may not be possible.<br>
			To make the meltabomb functional:<br>
			<li>Place the meltabomb in the designated detonation zone.</li>
			<li>Extend and anchor the meltabomb from its interface.</li>
			<li>Insert the bomb's authentication disk into slot.</li>
			<li>Type numeric authorisation code into the keypad. This should have been provided. Note: If you make a mistake press R to reset the device.
			<li>Press the E button to log onto the device.</li>
			You now have activated the device. To deactivate the buttons at anytime for example when you've already prepped the bomb for detonation	remove the auth disk OR press the R on the keypad.<br>
			Now the bomb CAN ONLY be detonated using the timer. Manual detonation is not an option.<br>
			Note: The corpse emperor is a pain in the neck.<br>
			Toggle off the SAFETY.<br>
			Note: You wouldn't believe how many khornates have forgotten this step.<br>
			So use the - - and + + to set a det time between 5 seconds and 10 minutes.<br>
			Then press the timer toggle button to start the countdown.<br>
			Now remove the auth. disk so that the buttons deactivate.<br>
			Note: THE BOMB IS STILL SET AND WILL DETONATE<br>
			Now before you remove the disk if you need to move the bomb you can:<br>
			Toggle off the anchor, move it, and re-anchor.<br><br>
			Good luck. Remember the order:<br>
			<b>Disk, Code, Safety, Timer, Disk, RUN!</b><br>
			Intelligence Analysts believe that normal imperial procedure is for high ranking officers to secure the nuclear authorisation disk.<br>
			Good luck!
			</html>"}

/obj/item/weapon/book/manual/security_space_law
	name = "Imperial Infantryman's Uplifting Primer"
	desc = "Imperial Infantryman's Uplifting Primer"
	icon_state = "bookSpaceLaw"
	author = "Uknown"
	title = "Imperial Infantryman's Uplifting Primer"
	dat = {"<html>
	1. You are expendable, prove you’re worth something.<br>
	2. Don't form any deep relationships with your fellow guardsmen, they will drop like flies.<br>
	3. Orks are not friendly.<br>
	4. Your lasgun is just a powerful flash light, aim for their eyes.<br>
	5. The Commissar is your best friend, unless you piss him off.<br>
	6. No-one is stupid enough to give you life insurance.<br>
	7. A lasgun shot to the face will put most foes down regardless of armour save. However, due to budget constraints,<br>
	your lasgun has not been fitted with sights of any kind, let alone a scope.<br>
	8. The lasgun will never get outdated or replaced by something better.<br>
	9. If you are asked by a Commissar why you retreated tell them you were advancing in the other direction.<br>
	10. There's a litany for everything.<br>
	11. The Commissar is always right.<br>
	12. Only buy the Imperial Infantryman’s Uplifting Primer.<br>
	13. When in deadly danger, when beset by doubt, run in little circles, wave your arms and shout.<br>
	14. Don’t hope to get back home: your chances left you when you signed up.<br>
	15. There is nothing special about you, only the tank you and your comrades are being the shield for.<br>
	16. Emergency or no emergency, if you melt the battery of your lasgun in a campfire, you're paying for a replacement.<br>
	17. When facing a force of Chaos, shoot the guy with the glowing eyes first.<br>
	18. When the battle is over, go ahead and shoot yourself. Inquisitorial Interrogation is much worse.<br>
	19. NEVER under ANY circumstances allow yourself to be taken alive. Your enemies will devour your soul,<br>
	torture you in ways they Imperium has not even BEGUN to explore, feed you to a Daemon, hack you apart with blunt axes and<br>
	swords made from scrap metal, or impale you on a spike. If possible, go out with the largest bang possible.<br>
	Who knows, you could get sainthood if you blow up someone important.<br>
	20. They are called "Rhinos" not "Metal Boxes", no matter what the heretical forces of Chaos say<br>
	21. Don't ask for better armour, you won't get it.<br>
	22. Titans will step on you if you don’t move.<br>
	23. Massed fire is your only chance of survival. Pour your shots into the same target as everyone else until it drops, and then jump to the next target.<br>
	24. Few things can beat a Leman Russ. Stick near it whenever possible.<br>
	25. Baneblades are the gods of the Imperial arsenal. Just cover your ears when they fire.<br>
	26. When you see a Titan stomping into the battlefield, get the HELL OUT OF THE WAY!<br>
	27. If the Flesh Tearers ever suggest a joint attack where you attack from opposite sides and meet in the middle respectfully decline.<br>
	28. Never get caught "rubbing your lasgun". Inquisition would arrive to purge the unclean<br>
	29. Your bayonet will break at the most inopportune time, so stick to shooting.<br>
	30. The techpriests hate your guts and may probably try to rig your gun first chance they get, so be sure to know how to maintain your own weapon.<br>
	31. Any machine with a red blinking light is going to explode so run away.<br>
	32. The Inquisition is not your friend. They just don’t see you as much of a threat.<br>
	33. When in doubt....refer to rule 1.<br>
	34. Grots are not worth the las-shot, they're even more pathetic in combat than you<br>
	35. Orks are still not friendly<br>
	36. NEVER began a joke to the Commissar with the phrase "What did the heretic say to the Commissar with the stick up his ass?"<br>
	37. Everyone wants you dead and/or doesn't give a crap. Get used to it.<br>
	38. Always change your socks and pants after a fight. ... Trust me, facing down a charging, screaming Ork carrying a cleaver<br>
	as big as your torso will make you WANT a fresh pair of pants.<br>
	39. Never stand between two Titans.<br>
	40. Never hit on a Sister of Battle or Sister Hospitaller.<br>
	41. Never joke about compensating for a small one with a big hat.<br>
	42. Remember to place cardboard under your armour. That will give you better protection.<br>
	43. Always stand INSIDE the trench, and in the second or third line of the charge outside of them.<br>
	44. If anything goes wrong blame it on an Ogryn<br>
	45. Your gun is worth more than you. Be nice to it.<br>
	46. If there are twice as many of you guys as there are the enemy you will still die.<br>
	47. You will die, get used to it<br>
	48. Try to get shot, it wastes the enemy’s bullets<br>
	49. Don't argue with the end of a pulse rifle, it argues harder.<br>
	50. Survive 15 hours....... Then read the rest<br>
	51. You know those heroic Imperial Guardsmen you read about facing down hordes of enemies? Yeah... you’re not one of them<br>
	52. Think positive, VERY positive.<br>
	53. No pressure.<br>
	54. Try to be the heavy weapon in your squad you'll be the only one killing anything<br>
	55. 57. If you are the man with the heavy weapon everyone else will illuminate your target for you with a red dot from their<br>
	56. Attack the front always!<br>
	57. If they have a weak rear, its a trap. Attack the front.<br>
	58. If they are weak to flanking, they expect it. Hit them in the front.<br>
	59. If you're losing, you're not trying hard enough.<br>
	60. If you're trying hard enough and still losing, start screaming various profanities and your love for the Emperor.<br>
	61. Scream LOUDER.<br>
	62. Make sure your dogtags are not lost for easy identification. We don't have dental records.<br>
	63. It's a good thing to be surrounded, you can attack in all directions.<br>
	64. If they are strongest at the front, attack there. They won't expect it.<br>
	65. Rule 64 is always true.<br>
	66. Rule 65 is always false.<br>
	67. Don't ask questions.<br>
	68. Throw whatever you can at the enemy.<br>
	69. Eldar never tell the truth.<br>
	70. Eldar sometimes give you valuable info.<br>
	71. If this handbook confuses you, keep it to yourself and read it upside-down.<br>
	72. If rule 71 doesn't work, throw this book at an enemy. You'll be following rule 68.<br>
	73. If you have any questions for the love of the Emperor don't ask a Commissar. They will see it as heresy<br>
	74. If you beat a Commissar in game he will see it as heresy<br>
	75. If you lose a game to a Commissar he will see you as weak and punish you for your insolence<br>
	76. Don't play games with Commissars<br>
	77. If you can't avoid rule 76 try to play a team game on the Commissar’s side (rule 75 still applies)<br>
	78. If there is the result of a tie all participants will be lashed 20 times for lack of effort (except the Commissar.<br>
	It’s not his fault he was paired up with incompetents)<br>
	79. You know that nagging thought that lingers in every Guardsman’s head? Just remember, the Inquisition will ask <br>
	why your lasgun shot ended up in your Commissar's face.<br>
	80. No, for the love of the Emperor, the Sisters of Battle WILL NOT lay you. Ever. You don't matter enough.<br>
	81. If captured by the Dark Eldar, you will be beaten, raped, forced to fight other horrible monsters,<br>
	and killed if you do anything wrong. Basically, it's the same thing you went through in the guard, expect with better rations.<br>
	82. If you ever decide to betray your post and succumb to Chaos, always make sure that your Commissar is properly killed, beaten, <br>
	cremated, and his ashes dumped off a cliff before shouting "DEATH TO THE FALSE EMPEROR!" Then duck to avoid the discharge from his gun.<br>
	83. If you will surrender, surrender to the Tau. Say you'll "Think about" joining the Greater Good. This should give you twenty minutes of<br>
	peace before your POW camp is raided by Imperial Forces, and it's back to the daily grind.<br>
	84. When at all possible, stay next to the Baneblade. When your Commissar orders you to move out, <br>
	tell the tank crews you see a Eldar right behind where the Commissar is standing.<br>
	85. Save all of your heroics for facing the Necrons. When they kill you, you just disintegrate.<br>
	86. Remember the chain of command. Survive for an hour, and you become an officer. Survive for ten hours, <br>
	you become a General. Survive for a week, and you become the new Emperor.<br>
	87. I don't care how many genetic enhancements you have, Storm Troopers, you are NOT Space Marines. <br>
	Do not attempt to do anything they do.<br>
	88. When working with the Space Marines, check the title of your story to see if it doesn't say "Dawn of War."<br>
	If it does, you'll be fighting them at some point.<br>
	89. When battling the Eldar, don't waste the ammo of your lasgun. <br>
	Ramming them with the back of your gun is just as effective. This applies to tanks and buildings as well.<br>
	90. This handbook also doubles as your ration of toilet paper.<br>
	91. If you run out of juice on your lasgun, don't ask for another Lasgun battery, the commissar will shoot you.<br> The battery is worth more than you are.<br>
	92. This book must be treated with respect and may not be vandalised on punishment of death, but it still is your ration of toilet paper <br>for your time of service. (But it also works great for killing Grots)<br>
	93. If you do have to use toilet paper use someone else's book, they will be shot instead of you.<br>
	94. Stealing enemy weapons is only heretical if it does not kill the enemy on the first shot.<br>
	95. You have complete freedom of speech in the Guard. However, the Commissar just has the freedom to shoot you for it.<br>
	96. Your Commander holds the right to trade you for any amount of gumballs he so pleases. That's about all your life buys.<br>
	97. The Commissar never runs out of bullets. Ever.<br>
	98. Why are you still reading this? Look up.<br>
	99. If you're dead, stop reading this. If you’re still alive, move to 100<br>
	100. After that bout of bowel clenching horror, use the supplied Guardsmen portable toilet.<br>
	101. Using the Adeptus Mechanicus toilet will result in being processed into a waste digesting servitor.<br>
	102. If you get promoted remove your rank insignia. That way snipers won't know you are an officer.<br>
	103. If your lasgun runs dry, shoot them with your pistol. If your pistol runs out, stab them with your knife.<br> If your knife breaks punch and kick them. If your arms and legs are blown off gnaw them to death. <br>If your jaw gets shot off then die on top of them and crush them beneath the weight of your collective corpses.<br>
	104. Surrender is not an option. Neither is retreat, tactical withdrawal, advancing in the opposite direction, or honourable death.<br>
	105. When all else fails call the author of your story/novel/comic and authorize them to use a Deus ex Machina.<br>
	106. You are only authorized to fight on planets where there are Titans, pieces of Titans, or Titan producing-factories.<br>
	107. If you are overrun by Tyranids overload your lasgun's power cell. Otherwise they may incorporate it into their biology.<br>
	108. For the love of the God-Emperor, why are you a guardsman? You should have been a Commissar!<br>
	109. The only acceptable situations for a guardsman to cry is if the enemy is going to rape you, or is raping you.<br> All other instances will result in you being shot by your local commissar.<br>
	110. If you can see the enemy, you're dead.<br>
	111. If you can hear the enemy, work your way to a line further back. When questioned, say you are going to get more ammo.<br>
	112. If someone else can hear the enemy, ask them where they hears it from and push them in that direction.<br>
	113. Never tell anyone you can hear the enemy.<br>
	114. Wow, I got to rule 114? Amazing! I thought I'd be sh--<br>
	The previous writer has been shot dead for writing a helpful text for the Imperium. But, after he died, <br>his superiors stole his idea and took all the credit. Now I am writing the<br>
	The previous writer has been shot dead for writing a helpful te<br>
	The previous writer ha<br>
	The pre<br>
	The<br>
	Ah, this is the Emperor. Now that I have finally taken the credit for such a good idea, I will finish writing the book.<br>
	115. If you have a good idea, make sure it stays a secret.<br>
	116. Remember, your lasgun is insured, you’re not.<br>
	117. If you lose your armour, find a large cardboard box. Cut out 2 holes in the side,<br> 2 in the bottom and one in the top. This should be an effective substitute for your normal armour.<br>
	118. That wasn't Chicken.<br>
	119. See that chain sword? Only important people get them, you are not one of them.<br>
	120. Space Marines only regard you as cannon fodder. Pretend not to hear them when they tell you to charge.<br>
	121. You are a heretic, whether you actually succumbed to Chaos or not. Nothing will change that. That's why the Sisters attack you every chance they get.<br>
	122. Your first aid kit only consists of a lasgun battery with enough juice for one shot. Make it count.<br>
	123. Only the Space Marines are important enough to get Apothecaries. Your healers only fix your tanks.<br>
	124. When a Chaos Sorcerer causes a Guardsman to see his worst nightmare, all he will see is Frank, the Inquisitor Titan Commissar.<br>
	125. If you feel that you are treated unfairly, you may join a Guardsman’s Rights Union (note that they are all heretics).<br>
	126. When facing Tyranids, don't blame yourself for dying. You had very little chance.<br>
	127. When facing Tau, pretend to join their Greater Good then shoot them in the back.<br>
	128. If weapon is taken away while attempting rule 127, say that you are an intelligence officer. You may live another day.<br>
	129. If rule 128 fails, scream "FOR THE GREATER GOOD!!!" and run wildly for the exit. Results may vary.<br>
	130. If rule 129 fails to produce good results ask to be made a PoW, then when the Tau try to arrest you grab one and threaten to kill it somehow.<br>
	131. When carrying out rule 130, grab his windpipe and squeeze. In fact, Tau probably don’t have windpipes.<br>
	132. Never start a land war in Asia and never go in against a Sicilian when death is on the line.<br>
	133. Your mom stops loving you when you stop killing enemies.<br>
	134. Don't get killed by Chaos, otherwise your souls will hate you<br>
	135. If all your brothers get killed in service, you're not going home to your mom. This isn't Saving Private Ryan<br>
	136. When fighting Orks, a cork is your best friend.<br>
	137. When fighting feral Orks, keep your head down, they can actually shoot you.<br>
	138. When you die, try to position your body in front of the tanks to keep them from getting hit.<br>
	139. Eldar may not be as tall as you think, but they can still kill you in a hundred different gruesome ways (39-140 in “The Ways to Die Handbook”)<br>
	140. Especially those spiky Dark Eldar.<br>
	141. The Adeptus Mechanicus does not appreciate you attaching magnets to their craniums, no matter how funny they look when it scrambles their CPU.<br>
	142. Nor do Necrons.<br>
	143. Who cares about conserving ammo? When the Commissar isn't looking, charge to maximum setting so your lasgun can do more than leave sunburn.<br>
	144. The setting is called 'mega-zot' by the way.<br>
	145. Those little things at the Orks feet are called grots. All those inaccurate bullets they fire will have one that will find its target. Make sure it isn't you.<br>
	146. If you and your fellow guardsmen dislike your commissar, in the next charge make sure he was... killed in action<br>
	147. Got kids? They will soon be fatherless.<br>
	148. During night fights you will exchange your lasgun for the more effective flashlight; it will blind the enemy long enough for the tanks to acquire a target.<br>
	149. Discard this rulebook if you get promoted to Heavy Weapons Team. Just entrench in a position and wait out this millennium. Maybe the next one will be more peaceful.<br>
	150. The Imperial Navy is not your friend. When they start firing, they don't even consider you obstructions.<br>
	151. If you are being taken prisoner by an enemy faction, and he is spouting off a long monologue, shoot him there.<br> You may die by his forces, but heck, if he spouted off a monologue, he must be important.<br>
	152. If you are in the same squad as Commissar Yarrick, and he doesn't shoot you with his laser eyes<br> in the first few seconds, he is satisfied. You will survive this war.<br>
	153. When they say "The Emperor Protects," remember the part everyone forgot. "...except the Guardsmen. He's not even going to bother with them."<br>
	154. Apply for a driver's license as soon as you can. You can thank me later once they allow you to drive a Leman Russ.<br>
	155. Orks are still not friendly<br>
	156. Chaos promises you cookies and cake<br>
	157. The cookies are a lie<br>
	158. There is no cake.<br>
	159. The Emperor promises pie.<br>
	160. You have to survive 20 years to be given pie.<br>
	161. Only Yarrick gets two slices<br>
	162. Write a farewell letter for tomorrow you'll die.<br>
	163. Hope to stay alive is the first step on the road of Commissar friendly fire.<br>
	164. Some Orks have been known take guards teeth to pass off as their own. Feeding intravenously isn’t as bad as it sounds.<br>
	165. Orks, Eldar, Chaos, Tau, the Inquisition, Commissars, and anyone else will try to kill you... Yes,<br> that’s right, you have no friends. If you would like to dispute this go ask the Commissar.<br>
	166. Orks are still not friendly<br>
	167. Stop reading and go die for your Emperor<br>
	168. You are an Imperial Guardsman, it's time you started acting like it.<br>
	169. You made it all the way to rule 169! Drop and give me 200!<br>
	170. This is as good as life gets, everyone not in in the guard have the horrible burden of living and free will.<br>
	171. Tau are actually space cows<br>
	172. If you are assigned a plasma weapon try and trade it for something that does not explode at random<br>
	173. If your plasma gun begins to make weird noises refer to rule 68<br>
	174. If you don't know what rule 68 is then just do what comes naturally<br>
	175. Orks are friendly unless otherwise stated in previously stated<br>
	176. Rule 175 was written by my retarded cousin i swear<br>
	177. Before battle, inject pure sugar into your veins so that when enough of you die Khorne will get diabetes.<br>
	178. Remember this when you think you stand out – camouflage is useless under tank treads.<br>
	179. Point your gun at the enemy<br>
	180. Your Commissar is always on your side. Thank him for shooting you; he wants you to sit beside the Emperor earlier.<br>
	181. The icons of the most holy and righteous Emperor shall not be referred to as "The goofy lookin' dead guy".<br>
	182. Civilians are not to be referred to as "Tyranid Take Out".<br>
	183. You may not use weapons looted from fallen Orks, heretics or anyone else that has a gun that can hurt things larger than a grot.<br>
	184. "Screw You Guys, I'm Going Home" is a proper battle cry.<br>
	185. "Meat Shields, ATTACK!" is not a proper battle cry.<br>
	186. "For the Glory of the Emperor" is an acceptable battle cry, as is "For the Honour of the Emperor". However, "For the Amusement of the Emperor" is not.<br>
	187. I am not to speak on behalf of my platoon. Especially with the opening line "We, the acceptable losses, salute you."<br>
	188. The current conflict is NOT a Humie Waaagh!<br>
	189. The name of the current campaign is not "Operation We're All Gonna Die".<br>
	190. Giving the enemy your plasma weapon is not the easiest way to kill them.<br>
	191. You are not allowed to replace lasguns with super soakers. Even if they are more effective.<br>
	192. It is forbidden to head bang to Noise Marine rock music, no matter how tough the lead guitarist sounds.<br>
	193. Roll on the floor laughing. That way they’ll think you’re dying and shoot someone else<br>
	194. Always try to be the last one into a fight, that way you might get a chance to run<br>
	195. If your lasgun breaks, keep pulling the trigger...you might get lucky and kill yourself with a misfire<br>
	196. You killing anything is much less likely than an Ork being able to fire his gun using only his imagination<br>
	197. Fall down as much as possible, you might get lucky and end up in the first aid hut<br>
	198. That application you filled out wasn’t for tank a tank commander<br>
	199. While transporting a commissar, drive close to the enemy so the commissar can hit them with his sword. <br>This will keep him entertained and will dissuade him from shooting at you for entertainment.<br>
	200. By reading up to rule 200, you have spent more time reading and less time dying for the Emperor. Fix this before the commissar finds out.<br>
	201. Make sure you are the most useful guardsman the techpriest knows, he may give you a weapon that can cause flesh wounds instead of sunburn.  <br>
	202.If you dont know any techpriests just remember rule 68.If you dont remember rule 68 your local commissar will shoot you for heresy so go back quick. <br>
			Good luck!
			</html>"}

// Wiki books that are linked to the configured wiki link.

// A book that links to the wiki
/obj/item/weapon/book/manual/wiki
	var/page_link = ""
	window_size = "970x710"

/obj/item/weapon/book/manual/wiki/attack_self()
	if(!dat)
		initialize_wikibook()
	..()

/obj/item/weapon/book/manual/wiki/proc/initialize_wikibook()
	if(config.wikiurl)
		dat = {"

			<html><head>
			</head>

			<body>
			<iframe width='100%' height='97%' src="[config.wikiurl]/index.php?title=[page_link]&printable=yes&remove_links=1&cc=1" frameborder="0" id="main_frame"></iframe>
			</body>

			</html>

			"}

/obj/item/weapon/book/manual/wiki/engineering_construction
	name = "Outpost Repairs and Construction"
	icon_state ="imperial"
	author = "Adeptus Mechanicus"
	title = "Station Repairs and Construction"
	page_link = "Guide_to_construction"

/obj/item/weapon/book/manual/wiki/engineering_guide
	name = "Engineering Textbook"
	icon_state ="bookEngineering2"
	author = "Engineering Encyclopedia"
	title = "Engineering Textbook"
	page_link = "Guide_to_engineering"

/obj/item/weapon/book/manual/security_space_law
	name = "Imperial Infantryman's Uplifting Primer"
	desc = "A book."
	icon_state = "bookSpaceLaw"
	author = "Unknown"
	title = "Imperial Infantryman's Uplifting Primer"

/obj/item/weapon/book/manual/wiki/infections
	name = "Infections - Making your own pandemic!"
	icon_state = "bookInfections"
	author = "Infections Encyclopedia"
	title = "Infections - Making your own pandemic!"
	page_link = "Infections"

/obj/item/weapon/book/manual/wiki/telescience
	name = "Teleportation Science - Bluespace for dummies!"
	icon_state = "book7"
	author = "University of Bluespace"
	title = "Teleportation Science - Bluespace for dummies!"
	page_link = "Guide_to_telescience"

/obj/item/weapon/book/manual/wiki/engineering_hacking
	name = "Hacking"
	icon_state ="bookHacking"
	author = "Engineering Encyclopedia"
	title = "Hacking"
	page_link = "Hacking"

/*
Books of Norc
*/

/obj/item/weapon/book/manual/norcbook_one
	name = "First Book of Norc"
	icon_state = "norcbook"
	author = "Unknown"
	title = "Norc One"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 21px; margin: 15px 0px 5px;}
				h2 {font-size: 18px; margin: 15px 0px 5px;}
        h3 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>The First Book of Norc</h1>

				<h2>Chapters</h2>

				<ol>
					<li><a href="#Start">In the begining...</a></li>
					<li><a href="#LLA">L L A</a></li>
					<li><a href="#likethem">Like them...</a></li>
					<li><a href="#castout">Cast Out...</a></li>
					<li><a href="#revenge">Revenge</a></li>
					<li><a href="#revolution">Revolution</a></li>
					<li><a href="#evolution">Evolution</a></li>
				</ol>


				<h2><a name="Start">In the begining...</h2>

				I record this now in hopes that it will one day be studied by the children of our MOST GLORIOUS Emperor. I take no joy or pride in composing this- a great blight upon mankind and the values we hold sacred. In the dark times before Chaos. Before the Ctan and before the old ones. In the farthest stretchings of history before time was time. There was Cron. Cron was a sinister being of untold evil. Our dimension was not the first he visited. He first traveled to a land named L L A. This strange and alien land may have been the inverse of our reality- but it was still good and wholesome in some ways. Cron moved onto this place and he looked upon it with disdain. <p>"Contempt is all I feel" said he. "Contempt for this land and all who walk upon it."

				<h2><a name="LLA">L L A</h2>
				"Who dares speak?!" Asked the guardian of this land. "Who speaks anger and malice towards this good and holy place?" <p>"Tis I!" Cron replied. "Tis I! Cron of the darkness."<p> And the guardian looked upon him with benevolence. <p>"I am RebelAmerica" the guardian said. "Come into the heart of this land and rule over it with me. For I am the headmin and I shall make you... like me."


				<h2><a name="likethem">Like them...</h2>
				And Cron entered into that land. And he became like them. He harnessed the power of the guardians and said <p>"Now I have taken your power and it is now that I shall reveal my true plan. I shall use this power in the service of those you rule over. I shall empower them and give them the ability to strike you down. For it is no longer that you shall abuse those you were entrusted to protect. It is instead they- who shall abuse you."


				<h2><a name="castout">Cast Out</h2>
				It was then that the guardians realized their mistake. Never had anyone posed such a threat to their lands. So the headmin stood upon his throne of power and shouted <p>"Foolish Cron! You came to free these people that we rule over. Now your plans are layed bare!! But it is not you who will be the victor this day. It is I who shall cast you down and drive you from these lands." <p>And with a single blow he struck The Cron down and cast him out.

				<h2><a name="revenge">Revenge</h2>
				The Cron was cast from that land and struck down. Taking his losses he fled back into the darkness. But it was not long before he was joined by another from that land. A creature named 'Briton'. And The Briton sought him out in the darkness. And The Briton found him. <p><p>"Where do you go?" The Briton asked.<p>"I do not know." The Cron replied.<p>"Come with me to the land of Apoc" The Briton said.<p>"No!" Scoffed the Cron. "Take me for a fool? I was cast down by the RebelAmerica from that land of L L A. Cast down by he who rules that land. Now you suggest that I make my way to another land in which that SAME man rules over?"<p>"Yes." The Briton replied. "For we in that land do not like him and we can find no better way to wound him... then to aquire you. His worst enemy."



			  <h2><a name="revolution">Revolution</h2>
				The Cron stroked his mustache as an evil plan formed in his mind.<p>
				"Yes..." he replied. "Yes...."<p>
				And so they both went to that land of Apoc. The Cron met with AIGamerGirl, Coreth and Doomer. All guardians of that land. <p>
				And they said onto him. "We shall make you a Guardian like us if you help us in our war against The RebelAmerica."<p>
				And the Cron stroked his mustache furiously and agreed.<p>
				Then came the time for the RebelAmerica to look upon his second world of Apoc. He moved onto it's surface and he counted those of his faithful.<p>
				"I count you all." he said as he looked upon the masses. "Yet there is one extra. Who is this new addition? Come forth so that I may count you as well." <p>
				"It is me m'lord." Said the Cron as he stepped forward. "You have come to count us and I stand to be counted. I am the Cron and you find me here in the land of Apoc."<p>
				And the Cron struck him down... and cast him from the land of Apoc.



		        <h2><a name="evolution">Evolution</h2>
		         And it came to pass that the RebelAmerica, in all his rage and righteous anger- sent his army of followers to Apoc in an attempt to destroy it. <p>"For the Cron has corrupted that land! He has struck me down and cast me from it! He twists the minds of those around him! He taints all that he touchs. If he is in that land then we shall allow it to exist no loner!"
				<p>The war had begun.
        </body>
		</html>
		"}

/obj/item/weapon/book/manual/norcbook_two
	name = "Second Book of Norc"
	icon_state = "norcbook"
	author = "Unknown"
	title = "Norc Two"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 21px; margin: 15px 0px 5px;}
				h2 {font-size: 18px; margin: 15px 0px 5px;}
        h3 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>The Second Book of Norc</h1>

				<h2>Chapters</h2>

				<ol>
					<li><a href="#Start">Forward</a></li>
					<li><a href="#Apoc">Apoc</a></li>
					<li><a href="#rebuilding">Rebuilding</a></li>
					<li><a href="#speak">The Speakening..</a></li>
					<li><a href="#en">Enlargement</a></li>
					<li><a href="#treason">Treason</a></li>
					<li><a href="#exhile">EXHILE!D</a></li>
				</ol>


				<h2><a name="Start">Forward</h2>

				I write this now, this second book of Norc. A sequal to the first. A prelude to the third. I write it in hopes of bridging the gap between volumes. In hopes of preparing my most pios order against the wickedness we shall all one day face. Praise to the Emperor. Deliver us from this evil.

				<h2><a name="Apoc">Apoc</h2>
				And the Cron stood there in the land of Apoc. New creatures gathered around him and empowered him with a new sinister evil. They stood with molevolence as wave after wave of attacks broke upon them and their land of evil. AIgamergirl, Doomer, the Briton, the Cron. They split the armies of L L A and emerged triumphant.

				<h2><a name="rebuilding">Rebuilding</h2>
				And the Cron turned to his allies and to his allies did he turn. He said <p> "Look upon this land, the land of Apoc. The land where the RebelAmerica can not enter. The land to which we have barred his entering. Look upon it allies of evil and see it's promise. For we should build an empire here upon it." <p> And with this he did recomend.

				<h2><a name="speak">The Speakening</h2>
				"Yes." His allies replied. "This we shall do and so it shall be thus."<p>
				"But who shall rule this new evil empire?" The Doomer asked.<p>
				The Cron thought on this question and stroked his evil mustache. "This land..." He replied. "This land shall be ruled by one who was born into the house of bread."<p>
				"Then it shall be I." Said AiGamergirl. "For it is I who has been born into the house of bread."<p>
				And so it was that AIgamergirl rose up to rule this land of Apoc, with all others bending knee to the her throne.

				<h2><a name="en">Enlargement</h2>
				Six months passed and the land was amplified by their efforts. The Cron poured his secret wealth into the land while AiGamergirl, Doomer and The Briton, set about monitoring the lesser people of this land and subjugating them to the will of the throne. And so it came to pass that the land grew in power. Under this evil cult of AiGamergirl, they spread their tendrils across the universe.


			 	<h2><a name="treason">Treason</h2>
			 	After seven months AiGamergirl went to Doomer and said...<p>
			 	"Let us have a secret meeting and let this meeting be secret. Let no man or woman or dog or squirell hear of this meeting. We shall allow no one to learn of this nor shall anyone be allowed to know. For if one learned of this meeting or if this meeting were learned of. It would no longer be secret. As well- let us speak of secret things in this secret meeting. Secret things that we shall not speak of outside of this secret meeting. For these words are secret and shall remain secret if confined to the secret meeting that we have created."<p>
			 	"Alright." Doomer replied.<p>

			 	"Here in our secret conversation and with the intention of having this meeting- in secret. Let us discuss getting rid of The Cron." AiGamergirl said.<p>

				"Alright" Doomer repled.<p>





		        <h2><a name="exhile">EXHILED!</h2>
				And they looked for the Cron. And they found him in the palace of Team-speaken and they said onto him...<p>
				"BEHOLD! For I am AIgamergirl and I have come here to speak with you 'The Cron'. For it is you that I am here to speak with." She declared. <p>
				"I am here Aigamergirl." The cron replied. "I have heard you for it is you that I have heard."
				"We have held a meeting. A meeting was held by us." Aigamergirl said.<p>
				"LIES!!!!" The Cron roared. "THERE HAVE BEEN NO SUCH THINGS HELD AS I HAVE BEEN WATCHING AND I HAVE SEEN NO MEETINGS! Your bait of falsehood takes this carp of truth. And thus do we of wisdom and of reach, With windlasses and with assays of bias, By indirections find directions out. So by my former lecture and advice. Shall you AIgamergirl? You have me, have you not?"<p>
				"It was a secret meeting!" AiGamergirl replied.<p>
				"Oh." The Cron said.<p>
				"We have decided to cast you out from the land of Apoc. Take your Cluckingtiger. Your Lidoe. Your 'The Briton' and BEGON!" Aigamergirl said.<p>
				"I pray thee, cease thy counsel, Which falls into mine ears as profitless. As water in a sieve: give not me counsel; Nor let no comforter delight mine ear!" The Cron raged furiously. "But such a one whose wrongs do suit with mine: ... for, brother, men. Can counsel and speak comfort to that grief Which they themselves not feel; but, tasting it, Their counsel turns to passion, which before- Would give preceptial medicine to rage, Fetter strong madness in a silken thread, Charm ache with air and agony with words. No, NO!!!! 'tis all men's office to speak PATIENCE! To those that wring under the load of sorrow, But no man's virtue nor sufficiency. To be so moral when he shall endure. The like himself. Therefore give me no counsel:My griefs cry louder than advertisement! This treason shall not go unforgotten!"
        </body>
		</html>
		"}

/obj/item/weapon/book/manual/norcbook_three
	name = "Third Book of Norc"
	icon_state = "norcbook"
	author = "Unknown"
	title = "Norc Three"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 21px; margin: 15px 0px 5px;}
				h2 {font-size: 18px; margin: 15px 0px 5px;}
        		h3 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>The Third Book of Norc</h1>

				<h2>Chapters</h2>

				<ol>
					<li><a href="#one">Forward</a></li>
					<li><a href="#tran">Transformation</a></li>
					<li><a href="#norc">The Norc</a></li>
					<li><a href="#test">The Testing.</a></li>
					<li><a href="#eggone">The first Egg.</a></li>
					<li><a href="#eggtwo">The second Egg.</a></li>
					<li><a href="#dap">The Secret Egg</a></li>

				</ol>


				<h2><a name="one">Forward</h2>

				The Emperor protect and keep me. Save my soul from the warp for these visions continue and I can not stop them. This creature torments me with lies of the most unholy sort. Oh but if the Inquisition could burn these thoughts from my mind. My very soul would be saved and only these foul documents would remain.

				<h2><a name="tran">Transformation</h2>
				And the Cron left the land of Apoc with his companions. The Clucking, The Lidoe, The Briton. And he moved out into the void and stood in the darkness.<p>
				"What shall we do?" Asked The Briton.<p>
				"I do not know." Replied the Cron."For truly we are most fucked."<p>
				"Can we not find a solution?!" Roared The Clucking in frustration and slapped a hand upon a drifting piece of void.<p>
				"No. We can not because...." The Cron said. "Because...."<p>
				"What is it?" Asked the Lidoe. <p>
				"Something. Something is happening to me." The Cron said. His immortal form shook and writhed in place. As his fellows looked on in surprise, he twisted and bent. "Something... Something is happening!"<p>
				And the Cron twisted from existence, leaving a Goose in his place.
				"What MADNESS!?" Asked The Briton. "Is this some foul magic?"<p>
				"No." The Goose said. "For I am a Goose. I create myself. I lay an Egg. An Egg from which I hatch."<p>
				"IMPOSSIBLE!!!" Screamed Lidoe in anger.<p>
				And the Goose opened his bill. And the Goose swallowed Lidoe in one bite.<p>
				"OMG WTF 4 srs?!" The Briton asked. "Cron what did you just do?"<p>
				"I am not the Cron." The goose said. "Nor shall I be the Cron again. Nor was I the Cron in the past. Nor am I the Cron now. Wait did I already say that? Anyway- From this day forward, you shall know me as The Norc. I shall create a new land. A better land. I shall create more Geese and we shall rule over this new land."<p>
				"Alright." The clucking replied.<p>
				"Did you really have to eat Lidoe though?" The Briton asked. <p>
				"Yes that was required." The Norc replied.<p>

				<h2><a name="norc">The Norc</h2>
				And the Norc moved out onto the expansive void and he saw that is was voidlike. There was nothing in the void. Not even void. It was voidless. There was so much voidlessnes that there was actually something there in the middle of it. That is how voidless it was. And the Norc said..<p>
				"Get behind me! For I shall use my greatest power upon this... nothingness which is actually something but still nothing some how."<p>
				And they got behind him. And the Norc let out a single Goosian honk. The honk folded and shaped in the void and created a new galaxy around them.<p>
				"Amazing!" The Briton said.<p>
				"Incredible!" The Clucking said.<p>
				"We shall call this new galaxy 'Absolution'"<p>
				"But who shall run it?" Asked the Briton.<p>
				"I have laid a single egg and from this egg there shall spring a Russian named 'Major Tyler, Syndicate Commander'".<p>
				"And he is going to run it?" Asked the Clucking.<p>
				"Well yes, untill we find some one better." Replied the Norc. "We are only testing now anyway."<p>

				<h2><a name="test">Testing</h2>
				It was then that the age of testing began. A time when Geese walked the galaxy and brutally preyed upon the innocent. Much bread was consumed. Many ahelps went unanswered. All around The Norc were the sights and sounds of change. A universe in motion! A realm of ceaseless chaos. And a race of people were created. They assembled together in a cluster and said... <p>
				"We are the people known as players." They called in the same voice. "We care not for the abuse of Major Tyler. We care not for his wicked ways nor do we care for his self-rez, his bannings or his OOC player deletions. He is a blight upon the galaxy. Who shall rid us of this evil creature that torments us so?!"<p>
				It was Major Tyler who then stood up before the assembled mass and replied... "You know I can burn you alive right?"<p>

				<h2><a name="eggone">The First Egg</h2>
				The Norc then did stand before the gathered mass and said "Foolish creatures. Who are you to stand before me. I shall cut you down and cast you out. For I am the Norc. My will is strong. For my strength is will."<p>
				And it was then that he laid an egg. The egg immeadately hatched and two creatures emerged.<p>
				"Behold!" The Norc announced. "I have visited upon you a fate more dire than you have yet known. For here is my reckoning. Two kings to rule over you. Kings and they shall number two. For I have created them and there are more than one. There are two I guess you could say. That is pretty much the take away from this."<p>
				And the masses stared at him with a blank expression.<p>
				"One I shall name 'Vynal-Scratch' and the other I shall name 'Shadow-Yukisa'. I enjoy putting dashes in names." The Norc declared.
				And the two new creatures moved out into the galaxy and conquered it. Ruling over the people with an iron fist. Even Major-Tyler could not withstand these two kings and he was cut down.


			 	 <h2><a name="eggtwo">The second Egg</h2>
				It was then that the age of testing concluded and the people did come out once again to cry to the heavens.<p>
				"Oh cruel Norc!!" They lamented. "Give us admins who will not abuse us. Also make us godzilla and make realistic fire. Also we sprited this stickman and we want you to put him in. We know much about coding."<p>
				"YOU KNOW NOTHING ABOUT CODING!!!" The Norc roared at them. "Also your stickman sucks! I shall lay another egg and from it will spring 'Sister Kelly'. A new king to rule the first two! Truly you have not known such terror as the terror I shall visit upon you. My webbed feet plod across the souls of the innocent every day. Feel my goose prints in your very spirit mortals!" <p>
				And so he did. And so sprang forth Sister Kelly.




		        <h2><a name="dap">The Secret Egg</h2>
		        One of these mortals rose to power among the unwashed masses. A man by the name of Dapperus. Upon his arrival he shouted to the heavens "Contempt is all I feel. Contempt for this land and all who walk upon it."<p>
		        The Norc looked to this man and pondered "Wow that sounds very familiar."<p>
		        Forseeing a great turmoil, The Norc laid a new egg. A secret Egg. And from it Sprang forth Hive and Mytoesareblue<p>
				"Goslings!" He said. "Now understand that from my egg you have sprung and in this fight you shall aid me."<p>
				But Mytoesareblue stared at him with a strange and rather creepy glare. Smiling with an open mouth and wide eyes.<p>
				"Wh... what?" The Norc asked.<p>
				"Then there was a star danced and under that was I born." Mytoesareblue replied.<p>
				"No." The Norc replied. "I just told you. I laid an Egg and you sprang from it."<p>
				But no sooner had he finished when Hive interupted.<p>
				"O, she misused me past the endurance of a block. She told me, not thinking I had been myself, that I was the Prince's jester" He said.<p>
				"When?" The Norc asked. "Just now? You were INSIDE an Egg like five minutes ago!"<p>
				"Yes." Hive replied. "and that I was duller than a great thaw, huddling jest upon jest, with such impossible conveyance upon me, that I stood like a man at a mark, with a whole army shooting at me. She speaks poniards, and every word stabs. If her breath were as terrible as her terminations, there were no living near her, she would infect to the North star. So indeed all disquiet, horror, and perturbation follows her." <p>
				"Okay well..." The Norc said. "Knock it off. We have work to do."<p>
				"Will your Grace command me any service to the world's end?" Mytoesareblue asked. "I will go on the slightest errand now to the Antipodes that you can devise to send me on. I will fetch you a hair off the great Cham's beard, do you any embassage to the Pygmies." <p>
				"No that is fine. We just... wait, was that a racial slur?" The Norc asked. But niether replied.<p>


        </body>
		</html>
		"}


/obj/item/weapon/book/manual/norcbook_four
	name = "Fourth Book of Norc"
	icon_state = "norcbook"
	author = "Unknown"
	title = "Norc Four"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 21px; margin: 15px 0px 5px;}
				h2 {font-size: 18px; margin: 15px 0px 5px;}
        		h3 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>The Third Book of Norc</h1>

				<h2>Chapters</h2>

				<ol>
					<li><a href="#one">Forward</a></li>
					<li><a href="#tran">The Dapperus Heresy</a></li>
					<li><a href="#norc">The Tribute</a></li>
					<li><a href="#test">Cataclysm.</a></li>
					<li><a href="#eggone">Salvation!</a></li>
					<li><a href="#eggtwo">The Return of Dapperus!</a></li>
					<li><a href="#dap">The age of Drake</a></li>

				</ol>


				<h2><a name="one">Forward</h2>

				DREET! DREET! DREET! HONK! DREET! DREET!

				<h2><a name="tran">The Dapperus Heresy</h2>
				And so it came to pass that the Dapperus heresy was upon them. The one known as 'The Dap' collected all who would follow him and lead his forces across the galaxy to Norc's Goose fleet. Fighting errupted instantly as his ships emerged from the warp.<p>
				But Norc's fleet closed in tightly around his flagship and Dapperus found the fighting stalled by a stalemate. Thinking quickly, Dapperus used a short range teleport to transfer himself and several other rebels to Norc's flagship.<p>
				There, upon the Golden Nest, he confronted Norc for the last time.<p>
				"So...." Dapperus said. "It is I,.. Dapperus. I am here to confront you Norc!"<p>
				"Okay." Norc replied. "What do you want?"<p>
				"Wait... let me get my list up." Dapperus fumbled for his list of demands when suddenly MyToesAreBlue burst from nearby cover and killed him with mind bullets.<p>
				"CALM DOWN!" Mytoesareblue yelled. "DAPPERUS! CALM DOWN!"<p>
				"Pwned!" The Norc roared in triumph.<p>

				<h2><a name="norc">The Tribute</h2>
				When the age of the Dapperus Heresy ended a lone man came before the Golden Nest to gain audience with the Norc. The Norc stood atop his nest and regarded this man by turning his head slightly to the left since geese have to turn their heads in order to look forward since their eyes are on both sides of their... moving on.<p>
				"This one comes before you lord." The Hive said. "His name is Harvey"<p>
				"Why have you come before me Harvey?" The Norc asked. <p>
				"My Lord. I have come with a great offering of bread. Truly this is the finest bread of my land." The Harvey replied... but it was all in Russian so Norc did not understand him. Norc saw bread though and immeadately ate it all up.<p>
				"Harvey." The Norc said. "I have no fricken idea what you are saying but your bread is FUCKING INCREDIBLE!! Your bread is such high quality that from this day forward, all high quality items shall be known as 'Russian Quality'"<p>
				And Harvy promptly left.


				<h2><a name="test">Cataclysm</h2>
				In the dawn of the age of Cataclysm, the Norc Set forth from his Golden Nest to gather his followers around him.<p>
				"We are fucked." He told them. "Something really bad has happened in the land of Job."<p>
				"What is this land?!" they asked. They asked it all at once and with different accents so it was kind of hard to make out.<p>
				"The land of Job is a land which makes this land possible." The Norc replied. "And it is gone now. Unfortunately... Absolution will soon fall into nothingness."<p>
				"What shall we do?" They asked. <p>
				"Prepare everyone for the end. <p>

				<h2><a name="eggone">Salvation</h2>
				It was soon after that meeting that The Norc was contacted by 'AIgamergirl.'<p>
				"Hello." She said. <p>
				"What do you want?" The Norc asked. "Have you come to gloat?"<p>
				"No. Actually I have come to save you and all the people of your land."<p>
				Norc did a double take. But as a goose it was akward so it ended up looking like a quadruple take.<p>
				"Wha wha WHAT?!" He asked.<p>
				"Thats right." Aigamergirl replied. "I have dragged the Doomer with me and we will pool our resources and move your land of Job to a far away place called Texas."<p>
				"Well... fuck." The Norc replied. "Wait. Why are you helping me all the sudden?"<p>
				"Because we are bored." She said.<p>


			 	 <h2><a name="eggtwo">The Return of Dapperus!</h2>
				And then Dapperus came back.<p>




		        <h2><a name="dap">The Age of Drake</h2>
		       And it came to pass in those days before the glorification. That Norc did sit upon the Golden Nest and rule over the poor souls of this universe. In the outer darkness came a man who looked much like a Kaola Bear, but still a man. More like a man with the head of a Kaola bear. It was wierd. The man came forth and stood before The Norc and his court. <p>

"We have no Tyranids." He said. His words echoed with in the sinister throne room. The Norc craned his long Goose neck to observe him. <p>

"Who are you that comes before me mortal?" The Norc asked.<p>

"I am The Drake Marshal. Also known as 'The Drake' and sometimes 'The Marshal of Drakes.'" He replied. "Also Trevor Kirby."<p>

"What nerve you have to step before me Drake Marshal, the Drake, Marshal of Drakes!!!" The Norc honked.<p>

"I stand before you in regards to the lack of Tyranids." He said.<p>

"FEWL!" The Norc roared. "If you want Tyranids so badly. Why don't you make them yourself?!"<p>

"I shall." The Drake replied and left. After several long years of genetic experimentation, the Drake returned. "I have returned!" He declared.<p>

"Who are you again? It has been like forever..." The Norc replied.<p>

"I'm the Tyranid guy." The Drake reminded him.<p>

"Oh right." The Norc replied and feasted upon a loaf of Russian Quality bread.<p>

"I have experimented with genetics." The Drake stated.<p>

"Yeah..." The Norc replied.<p>

"And Tyranids are a thing." The Drake said. Hearing this, a crumb of bread fell from the mouth of Norc and landed upon the floor. A crumb of bread heard through out the universe. The Norc's closest officers came running to see what was the matter. Dozens of them lining up to see what had happened.<p>

"You what?" The Norc asked.<p>

"The Tyranids." The Drake replied. "They are a thing now."<p>

"WTF?!" The Norc asked. And the Norc looked out into the universe and he saw that what the Drake said was true. "Surely if you can make the Tyranids a thing.... you can also make Necrons."<p>

"We shall see." The Drake accepted his challenge and departed. A thousand years later The Drake replied and stepped in front of The Norc. This time the Norc had a long beard and gray hair, his closest officers now skeletons, long decayed from the thousands of years od waiting. The Norc craned his Goosian neck to recognize him.<p>

"You have got to be fucking shitting me." The Norc replied. "Are you serious? You can't be serious."<p>

"I am serious." The Drake replied.<p>

"You didn't..."<p>

"I did..."<p>

"Are you for real?"<p>

"For real..."<p>

"Necrons...."<p>

".....yep!"<p>

"Necrons are a thing..."<p>

"....yep!"<p>

"I'm going to fucking eat you." And with that Norc lept from the Golden Nest and extended his massive goose wings, coming to a glide. He lanced his neck forward and opened his bill very wide. A massive wind wipped across the throne room as The Norc's attack struck home. The Drake winced as Norc bit him upon the finger.<p>

"Ouch!" The Drake said.<p>

"Something is wrong." The Norc stopped and composed himself. "I can not lolwtf.oneshot.swallow him. This is odd."<p>

"What is wrong?" The Briton asked. "Should I summon mytoesareblue to assist you?"<p>

"No." The Norc said and tilted his head to better observe this man. "This one may be dangerous. He hast made Tyranids and Necrons and he resists my super attack move. I suspect I will have to deal with him manualy."<p>

"MANUALLY?!" The Briton reeled back from his words. Bone creaked as the the Skeleton officers turned thier skulls to regard him in surprise.<p>

"Yes." The Norc replied and centered himself before the Drake. "var/mob/living/carbon/human/thedrake/p; qdel(p);"<p>

"proc/ondeath(); new/mob/living/carbon/human/thedrake(src.loc); ..()" The Drake replied. Every onlooker gasped, including The Norc.<p>

"How could you....?" The Norc was shocked. "No matter. for(I=0;I < 20; I++); spawn(0); applydamage(1000);"<p>

"break;" The Drake replied. The Norc took two steps back.<p>

"No this can not be!" The Norc roared. "You are no mortal at all! You are a GOOSE!!!!" <p>

"NOW YOU SEE ME IN MY TRUE FORM!" The Drake yelled and pulled off his Kaola face mask to reveal that he was in fact a Goose all along. A collective gasp spread over the crowd.<p>

"Knew it..." Mayti snickered.<p>

"I should have known." The Norc said. "Drake is latin for Goose! Probably."<p>

"Yes it is I who thinks killing is cool!" The Drake yelled. "Arcane 4th dimensional refferences!"<p>

"What is the meaning of this?!" The Norc demanded.<p>

"I have come to join the gaggle." The Drake replied.<p>

"Then come 'The Drake'. Let us speak off screen of things that can not be spoken of on screen." The Norc said and together, the two geese waddled into an adjoining room. Later they returned.<p>

"We are back!" The Drake declared.<p>

"Yes we are back from our offscreen talk." The Norc replied. "And it is time for the next stage of this universe. Drake of the Marshals, it is time for me to show you 'THE CODE'." <p>

"The Code?!" The Briton protested. "Are you sure this is wise?"<p>

"No." The Norc said. "Probably not. But I'm going to do it anyway. Come The Drake. Come and see 'THE CODE'."<p>

And the Geese moved through subspace. Through the warp. Through the outer limits and into the 4th wall. And there, it is presumed, the Code was revealed. A lone whisper could be heard from the portal from wence they departed. It was the voice of the The Drake asking "What is the deal with Telecoms?"<p>
.<p>


        </body>
		</html>
		"}

/obj/item/weapon/book/manual/astartes
	name = "The Astartes Handbook"
	desc = "Probably worth reading."
	icon_state = "norcbook"
	author = "Imperium of Man"
	title = "The Astartes Handbook"
	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>The Astartes Handbook</h3>

				<h4>Rules of Engagement</h4>

				Possible heretics or Xenos abort archangel IV? Follow these guidlines to make sure it's not you who is the heretic!:
				<p>
				<b>1-</b> Do not engage in petty heretics / Renegades / prisoners of the imperial guard/Inquisition, they are here to perform their job and honor their ordos/Regiment, Exception is made if they request your aid, aditionally you MAY return fire if the Heretics/Renegades/Prisoners openly attack you.
				</p><p>
				<b>2-</b> Do not engage any Xenos that come for diplomacy/Trade(Tau/eldar diplomats/Freebootaz if AUTHORIZED), if you seek to do so request permision from the Ordo Xenos Inquisitor.
				</p><p>
				<b>3-</b> Do Engage with Traitor Legions (celeb with power armor counts as traitor legion) and Destructive Xenos(Orks,Necrons,Tyranids), their threat is too much for the common guard.
				</p><p>
				<b>4-</b> Do engage in aiding the Medbay (Apothecary)/Engineerum(Techmarine) if they are understaffed and seek aid.
				</p><p>
				<b>5-</b> Do NOT engage subjects from a cult of ruinous powers without asking the proper sanctioned personnel (Ordo Hereticus is there for a REASON) if they wish your aid, you might interrupt or hinder their investigation if you do, in case of no Hereticus personnel is available then you MAY engage.
				</p>

				</body>
				</html>
				"}