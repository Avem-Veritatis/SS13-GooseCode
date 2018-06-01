/datum/intepreter
	var/name = "An Intepreter"

/datum/intepreter/proc/get_indent_block(var/text) //Accepts the thing that prompts the indent (ie an if statement or some such) and everything following it. Returns lines with +1 indent than the first line given it that are directly after the first line.
	return

/datum/intepreter/proc/Execute(var/text) //Runs a block of code. This can be the entire thing to execute, or simple the contents of an if statement.
	return