//Feather disable GM2017
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
_x += 10;
_y += 10;
_yoff = 0;
for (var i = 0; i <= optionsLenght; ++i) {
	if (i == optionsLenght) {
	    if (createbutton(_x, _y + _yoff + 10, "Save", 1)) {
			global.__PFS.moves[move] = {
				internalName,
				type,
				category,
				mpower,
				accuracy,
				pp,
				probability
			}
		}
		break;
	}
    textbox(_x, _y + _yoff, options[i][0], options[i][1], selected == i);
	_yoff += 20;
}
#endregion

#region Move List
_yoff = 0;
for (var i = 0; i < array_length(global.__PFS.moves); ++i) {
	if (createbutton(10, 10 + moveListOffset + _yoff, $"{i}:{global.__PFS.moves[i].internalName}", 1, true, 0, move == i ? c_yellow : c_white)) {
		set = false;
		selected = 1;
		move = i;
		loadMove(i);
	}
    _yoff += 30;
}
#endregion	

#region Move Types and Category
_x += 310;
draw_rectangle(_x, _y, _x + 300, _y + 300, true);
_yoff = 0;
var _length = array_length(global.__PFS.__PFSTypes);
_x += 16;
_y += 16;
for (var i = 0; i < _length; ++i) {
	if (createbuttonspr(_x, _y + _yoff, sPFSTypeIcons, i, 0.25, false, type == i ? c_purple : c_white, "middlecenter")) {
		type = i;
	}
	_yoff += 40;
	if (i == __PFSTypes.Poison or i == __PFSTypes.Ghost) {
	    _x += 80;
		_yoff = 0;
	}
}
_length = array_length(global.__PFS.moveCategory);
for (var i = 0; i < _length; ++i) {
    var _spr = global.__PFS.moveCategory[i][1];
	if (createbuttonspr(_x, _y + _yoff, _spr, 0, 0.20, false, category == i ? c_yellow : c_white)) {
		category = i;
	}
	_yoff += 40;
}
#endregion

#region Function Buttons
_text = "Export";
_x = GW - 2;
_y = GH - string_height(_text) * 2 - 5;
_x -= string_width(_text) * 2 + 9;
if (createbutton(_x, _y, _text, 2)) {
	var f = file_text_open_write(file);
	file_text_write_string(f, string(json_stringify(global.__PFS.moves, true)));
	file_text_close(f);
	var _fs = file_text_open_write(savedFile);
	file_text_write_string(_fs, json_stringify(global.__PFS.moves));
	file_text_close(_fs);
	show_message_async($"Exported to {file}");
}
_text = "Load";
_x -= string_width(_text) * 2 + 9;
if (createbutton(_x, _y, _text, 2)) {
	if (file_exists(savedFile)) {
		var fs = file_text_open_read(savedFile);
		var _json = file_text_read_string(fs);
		file_text_close(fs);
		global.__PFS.moves = json_parse(_json);
	}
}
_text = "New";
_x -= string_width(_text) * 2 + 9;
if (createbutton(_x, _y, _text, 2)) {
	var _newmove = array_length(global.__PFS.moves);
	global.__PFS.moves[_newmove] = {
		internalName : "New",
		type : 0,
		category : 0,
		mpower : 0,
		accuracy : 0,
		pp : 0,
		probability : 0,
	}
	selected = 1;
	move = _newmove;
	set = false;
	loadMove(_newmove);
}
#endregion