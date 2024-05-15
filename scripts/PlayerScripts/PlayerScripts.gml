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
			dir = 180;
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
			dir = 0;
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
			dir = 90;
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
			dir = 270;
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
function player_interact(){
	if (keyboard_check_pressed(ord("Z"))) {
		var _xoffset = 0;
		var _yoffset = 0;
		switch (dir) {
		    case 0:
				_xoffset = 16;
		        _yoffset = 0;
		        break;
		    case 90:
				_xoffset = 0;
		        _yoffset = -16;
		        break;
		    case 180:
				_xoffset = -16;
		        _yoffset = 0;
		        break;
		    case 270:
				_xoffset = 0;
		        _yoffset = 16;
		        break;
		}
	    #region Sign
		var _sign = noone;
		if (collision_line(x, y - 8, x + _xoffset, y + _yoffset - 8, oSign, false, true)) {
		    _sign = instance_place(x + _xoffset, y + _yoffset - 8, oSign);
		}
		if (_sign != noone) {
		    var npc = "Sign";
			var text = _sign.text;
			var optionsFalas = [];
			var options = [];
			if (!instance_exists(oDialog)) {
			    instance_create_depth(x, y, depth - 1, oDialog, {npc : npc, text : text, options : options, optionsFalas : optionsFalas});
				oDialog.onMap();
				oPlayer.fsm.change("dialog");
			}
		}
		#endregion
	}
}