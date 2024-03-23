//Feather disable GM2017
global.__PFS = {};
global.__PFS.moves = [];
global.__PFS.moveTypes = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy"];
global.__PFS.moveCategory = [["Physical", sPFSPhysicalIcon], ["Special", sPFSSpecialIcon], ["Status", sPFSStatusIcon]];
enum MoveTypes {
	Normal, 
	Fire, 
	Water, 
	Grass, 
	Flying, 
	Fighting, 
	Poison, 
	Electric, 
	Ground, 
	Rock, 
	Psychic, 
	Ice, 
	Bug, 
	Ghost, 
	Steel, 
	Dragon, 
	Dark, 
	Fairy
};
enum MoveCategory {
	Physical,
	Special,
	Status
}

function __PFS_addMove(internalName){
	var _struct = {};
	for (var i = 0; i < array_length(global.__PFS.moves); ++i) {
	    if (global.__PFS.moves[i].internalName == internalName) {
		    return variable_clone(global.__PFS.moves[i]);
		}
	}
	show_debug_message("Move not found!");
	return global.__PFS.moves[0];
}

#region Functions
#endregion
function createbutton(_x, _y, text, textscale, show_border = true, bgalpha = 0.25, _color = c_white) {
	var _clicked = false;
	var w = string_width(text) * textscale;
	var h = string_height(text) * textscale;	
	draw_set_color(c_black);
	draw_set_alpha(bgalpha);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, false);
	}
	draw_set_color(c_white);
	draw_set_alpha(1);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_text_transformed_color(_x, _y, text, textscale, textscale, 0, _color, _color, _color, _color, 1);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function createbuttonspr(_x, _y, spr, subimg, sprscale, show_border = true, _color = c_white, align = "topleft") {
	var _clicked = false;
	var pw = 0;
	var ph = 0;
	var w = sprite_get_width(spr) * sprscale;
	var h = sprite_get_height(spr) * sprscale;
	switch (align) {
	    case "middlecenter":
			w = w / 2;
			h = h / 2;
			ph = h;
			pw = w
	        break;
	    default:
	        // code here
	        break;
	}
	if (show_border) {
	    draw_rectangle(_x - pw - 3, _y - ph - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_sprite_ext(spr, subimg, _x, _y, sprscale, sprscale, 0, _color, 1);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x - pw, _y - ph, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function textbox(x, y, name, value, editing) {
	var _x = x;
	var _y = y;
	var _value = variable_instance_get(self, value);
	var _set = variable_instance_get(self, "set");
	if (editing) {
		if (!_set) {
		    keyboard_string = _value;
			variable_instance_set(self, "set", true);
		}
		variable_instance_set(self, value, keyboard_string);
	}
	draw_text(_x, _y, name);
	_x += string_width(name);
	draw_text(_x, _y, _value);
	var _color = editing ? c_yellow : c_white;
	draw_rectangle_color(_x, _y, _x + string_width(_value), _y + string_height(_value), _color, _color, _color, _color, true);
}