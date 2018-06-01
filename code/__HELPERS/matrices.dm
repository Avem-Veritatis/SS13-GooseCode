/matrix/proc/TurnTo(old_angle, new_angle)
	. = new_angle - old_angle
	Turn(.) //BYOND handles cases such as -270, 360, 540 etc. DOES NOT HANDLE 180 TURNS WELL, THEY TWEEN AND LOOK LIKE SHIT


/atom/proc/SpinAnimation(speed = 10)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120)
	var/matrix/m240 = matrix(transform)
	m240.Turn(240)
	var/matrix/m360 = matrix(transform)
	speed /= 3      //Gives us 3 equal time segments for our three turns.
	                //Why not one turn? Because byond will see that the start and finish are the same place and do nothing
	                //Why not two turns? Because byond will do a flip instead of a turn
	animate(src, transform = m120, time = speed, loop = -1)
	animate(transform = m240, time = speed)
	animate(transform = m360, time = speed)

/atom/proc/GlichAnimation(speed = 10, loops = 1, changecolor = 1) //An animation for decayed cameleoline to make things get pretty screwy.
	var/matrix/m30 = matrix(transform)
	m30.Turn(30)
	var/matrix/m90 = matrix(transform)
	m90.Turn(90)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120)
	var/matrix/mn30 = matrix(transform)
	mn30.Turn(330)
	var/matrix/mn90 = matrix(transform)
	mn90.Turn(270)
	var/matrix/mn120 = matrix(transform)
	mn120.Turn(240)
	speed /= 3
	for(var/loop = 1, loop<=loops, loop++)
		sleep(5)
		src.pixel_y = rand(-20,20)
		src.pixel_x = rand(-20,20)
		if(changecolor) src.color = pick("#C73232","#5998FF","#2A9C3B","#CFB52B","#AE4CCD","#FFFFFF","#333333")
		var/selection = rand(1,6)
		switch(selection)
			if(1)
				animate(src, transform = m30, time = speed)
			if(2)
				animate(src, transform = m90, time = speed)
			if(3)
				animate(src, transform = m120, time = speed)
			if(4)
				animate(src, transform = mn30, time = speed)
			if(5)
				animate(src, transform = mn90, time = speed)
			if(6)
				animate(src, transform = mn120, time = speed)
	src.pixel_y = 0
	src.pixel_x = 0
	animate(src, transform = initial(src.transform), time = speed) //set us back in the regular orientation
	spawn(5)
		src.color = initial(src.color)