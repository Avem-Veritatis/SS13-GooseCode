/*
New atmospherics system.
This should be a hell of a lot simpler without losing any functionality whatsoever. I am forgoing being perfectly accurate to every damn gas equation for the sake of optimal simplicity.
Turfs will normally have static atmopshere variables.
There will be a diffusion proc that spreads a new gas mixture over surrounding tiles. This spread proc will keep diffusing to a fixed limit or until all avenues of spreading are blocked off, then it will stop. If the spreading proc encounters tiles that have similar air as what it is trying to spread it will consider this unpassable.
This will have a static air composition that stacks on top of the tile's air... It will spread out its affecting radius and thus average its effects... When the spreading effect is finished it will make its final modifications to the tiles within its affected radius then delete itself.
There will also be a proc called specially next to space turfs to create violent depressurization and empty all the turfs instantly and throw everything towards the breach.
These will be called depending on any conditions when either a turf is deleted or a canister is opened.

-Drake
*/

/datum/gas_mixture2
	var/oxygen = 0 //If you really want to be scientific about this, you could call these numbers the partial pressure of each gas... It really doesn't matter though I'm sure as hell not using ideal gas law.
	var/co2 = 0
	var/promethium = 0 //Makes more sense than plasma for wh40k... Promethium is a very broad term and while it can refer to the imperial incendiary gel in flamers it can also refer to a type of hydrogen gas fuel that burns particularly well.
	var/sleepgas = 0
	var/poison = 0
	var/temperature = T20C //Sick and tired of things freezing for no reason. By default should be room temp.

/datum/gas_mixture2/proc/get_pressure()
	return oxygen+co2+promethium+sleepgas+poison

/datum/gas_mixture2/proc/average_gas(var/datum/gas_mixture2/O)
	var/new_oxygen = (src.oxygen+O.oxygen)/2
	src.oxygen = new_oxygen
	O.oxygen = new_oxygen
	var/new_co2 = (src.co2+O.co2)/2
	src.co2 = new_co2
	O.co2 = new_co2
	var/new_promethium = (src.promethium+O.promethium)/2
	src.promethium = new_promethium
	O.promethium = new_promethium
	var/new_sleepgas = (src.sleepgas+O.sleepgas)/2
	src.sleepgas = new_sleepgas
	O.sleepgas = new_sleepgas
	var/new_poison = (src.poison+O.poison)/2 //Basic average for all things but temperature, since partial pressures literally just average out. Technically volume matters but this makes a difference in-game to absolutely nobody.
	src.poison = new_poison
	O.poison = new_poison
	var/new_temperature = ((src.temperature*src.get_pressure())+(O.temperature*O.get_pressure()))/(src.get_pressure()+O.get_pressure()) //Weighted average of temperature. Here we assume they all have identical heat capacities, see the above explanation.
	src.temperature = new_temperature
	O.temperature = new_temperature

/datum/gas_mixture2/proc/merge_gas(var/datum/gas_mixture2/O)
	var/datum/gas_mixture2/G = new /datum/gas_mixture2()
	G.oxygen = (src.oxygen+O.oxygen)
	G.co2 = (src.co2+O.co2)
	G.promethium = (src.promethium+O.promethium)
	G.sleepgas = (src.sleepgas+O.sleepgas)
	G.poison = (src.poison+O.poison)
	if((src.get_pressure()+O.get_pressure()) == 0)
		G.temperature = 0
	else
		G.temperature = ((src.temperature*src.get_pressure())+(O.temperature*O.get_pressure()))/(src.get_pressure()+O.get_pressure())
	return G

/datum/gas_mixture2/proc/merge(var/datum/gas_mixture2/O) //Legacy merge() proc
	src.oxygen = (src.oxygen+O.oxygen)
	src.co2 = (src.co2+O.co2)
	src.promethium = (src.promethium+O.promethium)
	src.sleepgas = (src.sleepgas+O.sleepgas)
	src.poison = (src.poison+O.poison)
	if((src.get_pressure()+O.get_pressure()) == 0)
		src.temperature = 0
	else
		src.temperature = ((src.temperature*src.get_pressure())+(O.temperature*O.get_pressure()))/(src.get_pressure()+O.get_pressure())
	return

/datum/gas_mixture2/proc/remove(var/amount)
	var/pressure = src.get_pressure()
	if(pressure == 0)
		return new /datum/gas_mixture2()
	amount = min(pressure, amount)
	var/oxy = (amount*src.oxygen)/pressure
	var/co = (amount*src.co2)/pressure
	var/fuel = (amount*src.promethium)/pressure
	var/n2o = (amount*src.sleepgas)/pressure
	var/tox = (amount*src.poison)/pressure
	src.oxygen -= oxy
	src.co2 -= co
	src.promethium -= fuel
	src.sleepgas -= n2o
	src.poison -= tox
	var/datum/gas_mixture2/G = new /datum/gas_mixture2()
	G.oxygen = oxy
	G.co2 = co
	G.promethium = fuel
	G.sleepgas = n2o
	G.poison = tox
	G.temperature = src.temperature
	return G

/datum/gas_mixture2/proc/burn() //This simulates ONLY gasses burning inside of canisters and such. Turfs have their own burn proc.
	if(src.promethium && src.oxygen && src.temperature >= 1000)
		var/consumed = (min(src.promethium, src.oxygen)%20)+1
		src.promethium -= consumed
		src.oxygen -= consumed
		src.co2 += consumed*4 //We can have thermal expansion here, because it isn't on turfs it is in canisters and tanks and stuff.
		src.temperature += consumed*60
		return 1
	else
		return 0