//Feather disable GM2017
//DebugManager.debug_add_config($"x1:{x1}", DebugTypes.UpDown, self, "x1", undefined, "PokesLearn");
if (!show) { exit; }
#region Local Vars
var _yoff = 0;
var _text = "";
var GW = display_get_gui_width();
var GH = display_get_gui_height();
var _x = GW/2 - 100;
var _y = GH/2 - 100;
#endregion

#region Move information
draw_rectangle(_x, _y, _x + 300, _y + 300, true);
if (sprite_exists(showsprite)) {
    draw_sprite(showsprite, 0, _x - 100, _y);
}
_x += 10;
_y += 10;
_yoff = 0;
for (var i = 0; i <= optionsLenght; ++i) {
	if (i == optionsLenght) {
	    if (createbutton(_x, _y + _yoff + 10, "Save", 1)) {
			pokedata.internalName = internalName;
			pokedata.wildlevelrange = [lowerlevel, higherlevel];
			var _names = variable_struct_get_names(defaultpokedata.basecalc);
			for (var j = 0; j < array_length(_names); ++j) {
				variable_struct_set(pokedata.basecalc, _names[j], variable_instance_get(self, _names[j]));
			}
			pokedata.sprite = [string(internalName + "Front"), string(internalName + "Back")];
			global.__PFS.Pokes[poke] = variable_clone(pokedata);
		}
		break;
	}
    draw_text(_x, _y + _yoff, $"{options[i][0]} : {variable_instance_get(self, options[i][1])}");
	_yoff += 23;
}
#endregion

#region Move List
_yoff = 0;
for (var i = 1; i < array_length(global.__PFS.Pokes); ++i) {
	if (createbutton(10, 10 + moveListOffset + _yoff, $"{i}:{global.__PFS.Pokes[i].internalName}", 1, true, 0, poke == i ? c_yellow : c_white)) {
		set = false;
		selected = 0;
		poke = i;
		loadPoke(i);
	}
    _yoff += 30;
}
#endregion
_yoff = 0;
#region can learn
for (var i = 0; i < array_length(global.__PFS.Pokes[poke].canLearn.level); ++i) {
	var _move = $"{global.__PFS.moves[global.__PFS.Pokes[poke].canLearn.level[i].id].internalName}: {global.__PFS.Pokes[poke].canLearn.level[i].level}";
	draw_text(140, 10 + _yoff + canLearnOffset, _move);
    _yoff += 30;
	if (_y + _yoff + canLearnOffset > canLearnMaxY) {
	    break;
	}
}
_yoff = 0;
//for (var i = 0; i < array_length(global.__PFS.Pokes[poke].evolution); ++i) {
	var _evolutions = global.__PFS.Pokes[poke].evolution
	draw_text(415, 10, _evolutions);
//    _yoff += 30;
//}
#endregion	

#region Move Types and Category
_x += 310;
draw_rectangle(_x, _y, _x + 300, _y + 300, true);
_yoff = 0;
var _length = array_length(global.__PFS.__PFSTypes);
_x += 16;
_y += 16;
//draw_text(device_mouse_x_to_gui(0), device_mouse_y(0), pokedata);
for (var i = 0; i < _length; ++i) {
	if (createbuttonspr(_x, _y + _yoff, sPFSTypeIcons, i, 0.25, pokedata.type[0] == i, pokedata.type[0] == i ? c_red : c_white, "middlecenter", mb_left)) {
		pokedata.type[0] = i;
	}
	if (createbuttonspr(_x, _y + _yoff, sPFSTypeIcons, i, 0.25, pokedata.type[1] == i, pokedata.type[1] == i ? c_purple : c_white, "middlecenter", mb_right)) {
		pokedata.type[1] = i;
	}
	_yoff += 40;
	if (i == __PFSTypes.Poison or i == __PFSTypes.Ghost) {
	    _x += 80;
		_yoff = 0;
	}
}
#endregion

#region Function Buttons
_text = "Print";
_x = GW - 2;
_y = GH - string_height(_text) * 2 - 5;
if (createbutton(_x, _y, _text, 2)) {
	show_debug_message(json_stringify(global.__PFS.Pokes[poke], true));
}
#endregion