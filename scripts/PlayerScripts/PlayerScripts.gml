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
			if (dir != 180) {
			    dir = 180;
				canmove = false;
				exit;
			}
			if (!place_meeting(x - 16, y, oColision) and dir == 180) {
			    image_speed = 5;
				placeToGo = [x - 16, y];
				moving = true;
			}
		
		}
		if (keyboard_check(vk_right)) {
			if (dir != 0) {
			    dir = 0;
				canmove = false;
				exit;
			}
			if (!place_meeting(x + 16, y, oColision) and dir == 0) {
			    image_speed = 5;
				placeToGo = [x + 16, y];
				moving = true;
			}
		}
		if (keyboard_check(vk_up)) {
			if (dir != 90) {
			    dir = 90;
				canmove = false;
				exit;
			}
			if (!place_meeting(x, y - 16, oColision) and dir == 90) {
			    image_speed = 5;
				placeToGo = [x, y - 16];
				moving = true;
			}
		}
		if (keyboard_check(vk_down)) {
			if (dir != 270) {
				dir = 270;
				canmove = false;
				exit;
			}		
			if (!place_meeting(x, y + 16, oColision) and dir == 270) {
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
		cutmoving = false;
		if (!keyboard_check(vk_down) and !keyboard_check(vk_up) and !keyboard_check(vk_left) and !keyboard_check(vk_right)) {
		    image_speed = 0;
			image_index = 1;
		}
		moving = false;
		cansend = true;
	}
}
function cutscene_movement(){
	if (placeToGo[0] != x) {
	    x += sign(placeToGo[0] - x);
		image_speed = 5;
		if (placeToGo[0] > x and placeToGo[0] != x) {
		    dir = 0;
		}
		else if (placeToGo[0] < x and placeToGo[0] != x) {
			dir = 180;
		}
	}
	if (placeToGo[1] != y) {
	    y += sign(placeToGo[1] - y);
		image_speed = 5;
		if (placeToGo[1] > y and placeToGo[1] != y) {
		    dir = 270;
		}
		else if (placeToGo[1] < y and placeToGo[1] != y) {
			dir = 90;
		}
	}
	if (placeToGo[0] == x and placeToGo[1] == y) {
		cutmoving = false;
		if (instance_exists(oCutscene) and variable_instance_exists(self, "cutscenenpc") and oCutscene.lastnpcinteracted == npc.nid) {
		    oCutscene.cancontinue = true;
		}
		image_speed = 0;
		image_index = 1;
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
	    #region Sign
		var _npc = noone;
		if (collision_line(x, y - 8, x + _xoffset, y + _yoffset - 8, oNpc, false, true)) {
		    _npc = instance_place(x + _xoffset, y + _yoffset - 8, oNpc);
		}
		if (_npc != noone) {
		    var npc = _npc.npc.npcname;
			var text = _npc.npc.text;
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