//Feather disable GM2017
enum Gender { Male, Female }

global.playerdata = {
	gender : Gender.Male,
	name : "",
	rivalname : ""
}
#macro PlayerData global.playerdata

function player_movement(){
	if (!moving and !instance_exists(PFSFightSystem) and canmove) {
		if (keyboard_check(vk_left)) {
			if (sprite_index != sRedWL) {
			    sprite_index = sRedWL;
				canmove = false;
				exit;
			}
			if (!place_meeting(x - 16, y, oColision) and sprite_index == sRedWL) {
			    image_speed = 5;
				placeToGo = [x - 16, y];
				moving = true;
			}
		
		}
		if (keyboard_check(vk_right)) {
			if (sprite_index != sRedWR) {
			    sprite_index = sRedWR;
				canmove = false;
				exit;
			}
			if (!place_meeting(x + 16, y, oColision) and sprite_index == sRedWR) {
			    image_speed = 5;
				placeToGo = [x + 16, y];
				moving = true;
			}
		}
		if (keyboard_check(vk_up)) {
			if (sprite_index != sRedWU) {
			    sprite_index = sRedWU;
				canmove = false;
				exit;
			}
			if (!place_meeting(x, y - 16, oColision) and sprite_index == sRedWU) {
			    image_speed = 5;
				placeToGo = [x, y - 16];
				moving = true;
			}
		}
		if (keyboard_check(vk_down)) {
			if (sprite_index != sRedWD) {
			    sprite_index = sRedWD;
				canmove = false;
				exit;
			}		
			if (!place_meeting(x, y + 16, oColision) and sprite_index == sRedWD) {
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
		if (!keyboard_check(vk_down) and !keyboard_check(vk_up) and !keyboard_check(vk_left) and !keyboard_check(vk_right)) {
		    image_speed = 0;
			image_index = 1;
		}
		moving = false;
		cansend = true;
	}
}