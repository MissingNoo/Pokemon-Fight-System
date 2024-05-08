if (keyboard_check_pressed(vk_end)) {
	x = 168;
	y = 96;
    room_goto(rPlayerHouse);
}

if (!moving and !instance_exists(PFSFightSystem)) {
	if (keyboard_check(vk_left)) {
		sprite_index = sRedWL;
		if (!place_meeting(x - 16, y, oColision)) {
		    image_speed = 5;
			placeToGo = [x - 16, y];
			moving = true;
		}
		
	}
	if (keyboard_check(vk_right)) {
		sprite_index = sRedWR;
		if (!place_meeting(x + 16, y, oColision)) {
		    image_speed = 5;
			placeToGo = [x + 16, y];
			moving = true;
		}
	}
	if (keyboard_check(vk_up)) {
		sprite_index = sRedWU;
		if (!place_meeting(x, y - 16, oColision)) {
		    image_speed = 5;
			placeToGo = [x, y - 16];
			moving = true;
		}
	}
	if (keyboard_check(vk_down)) {
		sprite_index = sRedWD;
		if (!place_meeting(x, y + 16, oColision)) {
		    image_speed = 5;
			placeToGo = [x, y + 16];
			moving = true;
		}
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