if (!moving) {
	if (keyboard_check(vk_left)) {
		sprite_index = sRedWL;
	    image_speed = 5;
		placeToGo = [x - 16, y];
		moving = true;
	}
	if (keyboard_check(vk_right)) {
		sprite_index = sRedWR;
	    image_speed = 5;
		placeToGo = [x + 16, y];
		moving = true;
	}
	if (keyboard_check(vk_up)) {
		sprite_index = sRedWU;
	    image_speed = 5;
		placeToGo = [x, y - 16];
		moving = true;
	}
	if (keyboard_check(vk_down)) {
		sprite_index = sRedWD;
	    image_speed = 5;
		placeToGo = [x, y + 16];
		moving = true;
	}
}
if (placeToGo[0] != x and moving) {
    x += sign(placeToGo[0] - x);
}
if (placeToGo[1] != y and moving) {
    y += sign(placeToGo[1] - y);
}
if (placeToGo[0] == x and placeToGo[1] == y) {
    //image_speed = 0;
	//image_index = 1;
	moving = false;
}