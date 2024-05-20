if (x == other.x and y == other.y) {
	if (other.go and global.blackfade[0] > 0.99) {
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
			if (global.blackfade[1] == 0) {
				global.blackfade[1] = 1;
			}
		}
		if (other.dir == "Down" and keyboard_check_pressed(vk_down)) {
		    other.go = true;
			if (global.blackfade[1] == 0) {
				global.blackfade[1] = 1;
			}
		}
		if (other.dir == "Left" and keyboard_check_pressed(vk_left)) {
		    other.go = true;
			if (global.blackfade[1] == 0) {
				global.blackfade[1] = 1;
			}
		}
		if (other.dir == "Right" and keyboard_check_pressed(vk_right)) {
		    other.go = true;
			if (global.blackfade[1] == 0) {
				global.blackfade[1] = 1;
			}
		}
	}
	other.collided = true;
}
else {
	movecam = other.movecam;
	if (!other.confirmation and global.blackfade[1] == 0) {
		global.blackfade[1] = 1;
	}
	switch (other.stair) {
	    case "Up":
	        stairoffset -= other.stairoff;
	        break;
	    case "Down":
	        stairoffset += other.stairoff;
	        break;
	    default:
	        // code here
	        break;
	}
	other.collided = false;
}