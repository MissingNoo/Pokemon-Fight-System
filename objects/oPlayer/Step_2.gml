//oCam.x += (oPlayer.x - oCam.x) / 16;
//oCam.y += (oPlayer.y - oCam.y) / 16;
oCam.x = oPlayer.x;
oCam.y = oPlayer.y;
if (keyboard_check(vk_down) or keyboard_check(vk_up) or keyboard_check(vk_left) or keyboard_check(vk_right)) {
	sendPos();
	cansend = false;
}