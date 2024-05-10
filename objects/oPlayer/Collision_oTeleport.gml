if (x == other.x and y == other.y) {
	if (other.go) {
	    room_goto(other.destination);
		alarm[1] = 10;
		sendPos();
		x = other.xTo;
		y = other.yTo;
		canmove = false;
		alarm[0] = 10;
	}
	if (other.confirmation) {
		if (other.dir == "Up" and keyboard_check_pressed(vk_up)) {
		    other.go = true;
		}
		if (other.dir == "Down" and keyboard_check_pressed(vk_down)) {
		    other.go = true;
		}
		if (other.dir == "Left" and keyboard_check_pressed(vk_left)) {
		    other.go = true;
		}
		if (other.dir == "Right" and keyboard_check_pressed(vk_right)) {
		    other.go = true;
		}
	}
	other.collided = true;
}
else {
	other.collided = false;
}