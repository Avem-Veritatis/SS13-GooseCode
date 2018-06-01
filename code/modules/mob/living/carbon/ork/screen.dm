/obj/screen/zone_sel/human/ork/update_icon()
	overlays.Cut()
	overlays += selecting

/mob/living/carbon/human/ork/proc/updateWaaghDisplay()
	if(hud_used) //clientless aliens
		hud_used.alien_plasma_display.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'> <font color='magenta'>[storedwaagh]</font></div>"