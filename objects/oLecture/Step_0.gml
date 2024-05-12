if (keyboard_check_pressed(ord("Z")) and !lerping and !blacklerping) {
	if (screen < 2) {
	    lerping = true;
		lerpto = 0;
		exit;
	}
	if (screen == 2) {
	    blacklerping = true;
		blacklerp = 1;
		exit;
	}
	if (screen > 2 and screen < 5) {
		screen++;
		exit;
	}
	if (screen == 5) {
		blacklerping = true;
		blacklerp = 1;
		exit;
	}
}
#region controls
if (alpha != lerpto) {
	if (lerping) {
	    alpha = lerp(alpha, lerpto, 0.25);
	}
}
else {
	lerping = false;
	if (alpha == 0) {
		screen++;
	    lerping = true;
		lerpto = 1;
	}
}
#endregion

#region Fade
if (blackalpha != blacklerp) {
	if (blacklerping) {
	    blackalpha = lerp(blackalpha, blacklerp, 0.25);
	}
}
else {
	blacklerping = false;
	if (blackalpha == 1) {
		if (screen == 5) {
			global.blackfade = 1;
			ini_open("Game.ini");
			ini_write_real("Game", "SeenLecture", true);
			ini_close();
		    room_goto(rPlayerHouse2f);
		}
		screen++;
		blacklerping = true;
		blacklerp = 0;
	}
}
#endregion