/n_Interpreter/Robo_Interpreter
	var/datum/Robo_Compiler/Compiler
	var/used_CPU = 0
	var/available_CPU = 0
	var/overclocked = 0

	HandleError(runtimeError/e)
		Compiler.Holder.stderr += (e.ToString() + "<br>")

	GC()
		..()
		Compiler = null

	Eval(node/expression/exp) //Tracks how many pieces of code are used. Overclocking gives you a bit extra, but doing it too much risks blowing up the whole robot.
		used_CPU ++
		if(used_CPU > available_CPU)
			if(!overclocked)
				RaiseError(new/runtimeError/MaxAutomataCPU())
				return
			else
				if(used_CPU > round(available_CPU*1.25))
					if(used_CPU > round(available_CPU*1.5)) //Don't want it running /too/ much code, that could end badly with lag and all.
						Compiler.Holder.visible_message("<b>[Compiler.Holder] overheats!</b>")
						Compiler.Holder.Die()
						return
					if(prob(10))
						Compiler.Holder.visible_message("<b>[Compiler.Holder] overheats!</b>")
						Compiler.Holder.Die()
						return
		..()


/datum/Robo_Compiler

	var/n_Interpreter/Robo_Interpreter/interpreter
	var/mob/living/simple_animal/hostile/retaliate/automata/Holder	// the automata that is running the code
	var/ready = 1 // 1 if ready to run code

	/* -- Set ourselves to Garbage Collect -- */

	proc/GC()

		Holder = null
		if(interpreter)
			interpreter.GC()


	/* -- Compile a raw block of text -- */

	proc/Compile(code as message)
		var/n_scriptOptions/nS_Options/options = new()
		var/n_Scanner/nS_Scanner/scanner       = new(code, options)
		var/list/tokens                        = scanner.Scan()
		var/n_Parser/nS_Parser/parser          = new(tokens, options)
		var/node/BlockDefinition/GlobalBlock/program   	 = parser.Parse()

		var/list/returnerrors = list()

		returnerrors += scanner.errors
		returnerrors += parser.errors

		if(returnerrors.len)
			return returnerrors

		interpreter 		= new(program)
		interpreter.persist	= 1
		interpreter.Compiler= src

		return returnerrors

	/* -- Execute the compiled code -- */

	proc/Run(CPU, overclocked)

		if(!ready)
			return

		if(!interpreter)
			return

		interpreter.container = src

		interpreter.used_CPU = 0 //Brings the interpreter up-to-date on the cogitator's status.
		interpreter.available_CPU = CPU
		interpreter.overclocked = overclocked

		interpreter.SetVar("PI"		, 	3.141592653)	// value of pi
		interpreter.SetVar("E" 		, 	2.718281828)	// value of e
		interpreter.SetVar("SQURT2" , 	1.414213562)	// value of the square root of 2
		interpreter.SetVar("FALSE"  , 	0)				// boolean shortcut to 0
		interpreter.SetVar("false"  , 	0)				// boolean shortcut to 0
		interpreter.SetVar("TRUE"	,	1)				// boolean shortcut to 1
		interpreter.SetVar("true"	,	1)				// boolean shortcut to 1

		interpreter.SetVar("NORTH" 	, 	NORTH)			// NORTH (1)
		interpreter.SetVar("SOUTH" 	, 	SOUTH)			// SOUTH (2)
		interpreter.SetVar("EAST" 	, 	EAST)			// EAST  (4)
		interpreter.SetVar("WEST" 	, 	WEST)			// WEST  (8)

		// Set up the script procs

		/*
			-> Send a code signal.
					@format: signal(frequency, code)

					@param frequency:		Frequency to send the signal to
					@param code:			Encryption code to send the signal with
		*/
		//interpreter.SetProc("signal", "signaler", signal, list("freq", "code")) //For now, not very important. I do want to add a signal utility eventually though.

		/*
			-> Store a value permanently to the server machine (not the actual game hosting machine, the ingame machine)
					@format: mem(address, value)

					@param address:		The memory address (string index) to store a value to
					@param value:		The value to store to the memory address
		*/
		//Moved so that the memory is stored in the automata.

		/*
			-> Delay code for a given amount of deciseconds
					@format: sleep(time)

					@param time: 		time to sleep in deciseconds (1/10th second)
		*/

		/*
		Combat Robot Procs, I don't really feel like writing a big comment entry for self explanatory code.
		*/
		interpreter.SetProc("list_targets", "list_targets", src.Holder, params = list())
		interpreter.SetProc("target_name", "target_name", src.Holder, params = list("target_mob"))
		interpreter.SetProc("shoot", "shoot", src.Holder, params = list("target_mob"))
		interpreter.SetProc("movement", "movement", src.Holder, params = list("direction"))
		interpreter.SetProc("mem", "mem", src.Holder, params = list("address", "value"))
		interpreter.SetProc("sleep", /proc/delay)

		interpreter.SetProc("debug_stuff", /proc/debug_stuff)

		/*
			-> Replaces a string with another string
					@format: replace(string, substring, replacestring)

					@param string: 			the string to search for substrings (best used with $content$ constant)
					@param substring: 		the substring to search for
					@param replacestring: 	the string to replace the substring with

		*/
		interpreter.SetProc("replace", /proc/string_replacetext)

		/*
			-> Locates an element/substring inside of a list or string
					@format: find(haystack, needle, start = 1, end = 0)

					@param haystack:	the container to search
					@param needle:		the element to search for
					@param start:		the position to start in
					@param end:			the position to end in

		*/
		interpreter.SetProc("find", /proc/smartfind)

		/*
			-> Finds the length of a string or list
					@format: length(container)

					@param container: the list or container to measure

		*/
		interpreter.SetProc("length", /proc/smartlength)

		/* -- Clone functions, carried from default BYOND procs --- */

		// vector namespace
		interpreter.SetProc("vector", /proc/n_list)
		interpreter.SetProc("at", /proc/n_listpos)
		interpreter.SetProc("copy", /proc/n_listcopy)
		interpreter.SetProc("push_back", /proc/n_listadd)
		interpreter.SetProc("remove", /proc/n_listremove)
		interpreter.SetProc("cut", /proc/n_listcut)
		interpreter.SetProc("swap", /proc/n_listswap)
		interpreter.SetProc("insert", /proc/n_listinsert)

		interpreter.SetProc("pick", /proc/n_pick)
		interpreter.SetProc("prob", /proc/prob_chance)
		interpreter.SetProc("substr", /proc/docopytext)

		// Donkie~
		// Strings
		interpreter.SetProc("lower", /proc/n_lower)
		interpreter.SetProc("upper", /proc/n_upper)
		interpreter.SetProc("explode", /proc/string_explode)
		interpreter.SetProc("repeat", /proc/n_repeat)
		interpreter.SetProc("reverse", /proc/n_reverse)
		interpreter.SetProc("tonum", /proc/n_str2num)

		// Numbers
		interpreter.SetProc("tostring", /proc/n_num2str)
		interpreter.SetProc("sqrt", /proc/n_sqrt)
		interpreter.SetProc("abs", /proc/n_abs)
		interpreter.SetProc("floor", /proc/n_floor)
		interpreter.SetProc("ceil", /proc/n_ceil)
		interpreter.SetProc("round", /proc/n_round)
		interpreter.SetProc("clamp", /proc/n_clamp)
		interpreter.SetProc("inrange", /proc/n_inrange)
		interpreter.SetProc("rand", /proc/rand_chance)
		// End of Donkie~

		// Time
		interpreter.SetProc("time", /proc/time)
		interpreter.SetProc("timestamp", /proc/gameTimestamp)

		// Run the compiled code
		interpreter.Run()

		// Backwards-apply variables onto signal data
		/* sanitize EVERYTHING. fucking players can't be trusted with SHIT */

		/*

		signal.data["message"] 	= interpreter.GetCleanVar("$content", signal.data["message"])
		signal.frequency 		= interpreter.GetCleanVar("$freq", signal.frequency)

		var/setname = interpreter.GetCleanVar("$source", signal.data["name"])

		if(signal.data["name"] != setname)
			signal.data["realname"] = setname
		signal.data["name"]		= setname
		signal.data["job"]		= interpreter.GetCleanVar("$job", signal.data["job"])
		signal.data["reject"]	= !(interpreter.GetCleanVar("$pass")) // set reject to the opposite of $pass

		// If the message is invalid, just don't broadcast it!
		if(signal.data["message"] == "" || !signal.data["message"])
			signal.data["reject"] = 1
		*/

/*  -- Actual language proc code --  */

/*
var/const/SIGNAL_COOLDOWN = 20 // 2 seconds

datum/signal

	proc/mem(var/address, var/value)

		if(istext(address))
			var/mob/living/simple_animal/hostile/retaliate/automata/S = Holder

			if(!value && value != 0)
				return S.memory[address]

			else
				S.memory[address] = value

	proc/signaler(var/freq = 1459, var/code = 30)

		if(isnum(freq) && isnum(code))

			var/mob/living/simple_animal/hostile/retaliate/automata/S = Holder

			if(S.last_signal + SIGNAL_COOLDOWN > world.timeofday && S.last_signal < MIDNIGHT_ROLLOVER)
				return
			S.last_signal = world.timeofday

			var/datum/radio_frequency/connection = radio_controller.return_frequency(freq)

			if(findtext(num2text(freq), ".")) // if the frequency has been set as a decimal
				freq *= 10 // shift the decimal one place

			freq = sanitize_frequency(freq)

			code = round(code)
			code = Clamp(code, 0, 100)

			var/datum/signal/signal = new
			signal.source = S
			signal.encryption = code
			signal.data["message"] = "ACTIVATE"

			connection.post_signal(S, signal)

			var/time = time2text(world.realtime,"hh:mm:ss")
			lastsignalers.Add("[time] <B>:</B> [S.id] sent a signal command, which was triggered by NTSL.<B>:</B> [format_frequency(freq)]/[code]")
*/

	//Extra procs attached to the compiler itself that act on the holder automata. The above is redundant, given its affiliation with the telecomms signal proc.

var/safe_weapons = list(\
		/obj/item/weapon/gun/energy/laser/bluetag,\
		/obj/item/weapon/gun/energy/laser/redtag,\
		/obj/item/weapon/gun/energy/laser/practice)

/mob/living/simple_animal/hostile/retaliate/automata/proc/list_targets() //Lists the apparent names of those nearby.
	world << "List targets called"
	var/list/returnlist = list()
	for(var/mob/living/M in view(src, 7))
		if(M != src)
			var/list/target_data = list()
			target_data["name"] = M.name
			target_data["humanoid"] = 0 //Track if it is human. I need to make a list of pets that are "sanctioned" animals.
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				target_data["humanoid"] = 1
				target_data["species"] = "human"
				if(istype(H, /mob/living/carbon/human/ork))
					target_data["species"] = "ork"
				if(istype(H, /mob/living/carbon/human/tau))
					target_data["species"] = "tau"
				target_data["realname"] = H.real_name
				target_data["hasid"] = 0
				target_data["access_weapons"] = 0
				var/obj/item/weapon/card/id/idcard = H.get_idcard()
				if(idcard)
					target_data["hasid"] = 1
					if(access_security in idcard.access) //Technically not weapons access, but I guess that isn't an access flag here and I can't really imagine this being a problem...
						target_data["access_weapons"] = 1
				target_data["armed"] = 0
				if(check_for_weapons(H.l_hand))
					target_data["armed"] = 1
				if(check_for_weapons(H.r_hand))
					target_data["armed"] = 1
				if(check_for_weapons(H.belt))
					target_data["armed"] = 1
				target_data["criminal"] = 0
				var/perpname = H.get_face_name(H.get_id_name())
				var/datum/data/record/R = find_record("name", perpname, data_core.security)
				if(R && R.fields["criminal"])
					if(R.fields["criminal"] == "*Arrest*")
						target_data["criminal"] = 1
			returnlist.Add(target_data)
	world << "length of targets: [returnlist.len]"
	world << "target list: [returnlist]"
	return returnlist

/mob/living/simple_animal/hostile/retaliate/automata/proc/target_name(var/target_mob) //Adds the mob to the robot's target list.
	if(istext(target_mob))
		world << target_mob
		for(var/mob/living/M in view(src, 7))
			if(M.name == target_mob)
				src.enemies |= M

/mob/living/simple_animal/hostile/retaliate/automata/proc/shoot(var/target_mob)
	if(!ranged_weapon) return
	for(var/mob/living/M in view(src, 7))
		if(M.name == target_mob)
			spawn(pick(2,3,4,5,6,7,8))
				if(istype(ranged_weapon, /obj/item/weapon/gun/energy)) //energy guns need this to run first for them to successfully fire
					var/obj/item/weapon/gun/energy/E = ranged_weapon
					E.newshot()
				else
					if(!C.use(200)) //For ballistics, the weapon still runs on the power cell. Don't even ask how.
						return
				if(ranged_weapon.chambered.fire(M, src, null, 0, 0))
					if(istype(ranged_weapon, /obj/item/weapon/gun/energy))
						var/obj/item/weapon/gun/energy/E = ranged_weapon
						var/obj/item/ammo_casing/energy/shot = E.ammo_type[E.select]
						if(C.use(shot.e_cost))
							E.power_supply.give(shot.e_cost)
				ranged_weapon.process_chamber()
				ranged_weapon.update_icon()

/mob/living/simple_animal/hostile/retaliate/automata/proc/movement(var/direction)
	if(moving) return
	if(motor.current_output == 0) return
	var/speed = ((armor.weight*7)-motor.current_output)
	var/power = (motor.current_output*motor.efficiency_multiplier)*2
	if(!C.use(power)) return //Tries to move with the cell's power, factoring in
	moving = 1 //So a faster CPU can't spam the motor and make it go faster than it should.
	spawn(speed*5)
		step(src, direction)
		spawn(2)
			moving = 0 //If the speed is literally 0, it needs to have /some/ delay before it can move again. Even if not that much.

/mob/living/simple_animal/hostile/retaliate/automata/proc/mem(var/address, var/value)
	if(istext(address))
		if(!value && value != 0)
			return src.memory_data[address]
		else
			src.memory_data[address] = value