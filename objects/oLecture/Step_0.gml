if (keyboard_check_pressed(vk_pageup)) {
	scale++;
}
if (keyboard_check_pressed(vk_pagedown)) {
	scale--;
}
if (keyboard_check_pressed(ord("Z")) and !lerping) {
	if (screen < 2) {
	    lerping = true;
		lerpto = 0;
	}
	if (screen == 2) {
	    blacklerping = true;
		blacklerp = 1;
	}
	if (screen > 2) {
		screen++;
	}
	if (screen == 5) {
		blacklerping = true;
		blacklerp = 1;
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
		    room_goto(rPlayerHouse2f);
		}
		screen++;
		blacklerping = true;
		blacklerp = 0;
	}
}
#endregion