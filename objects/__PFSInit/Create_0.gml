//Feather disable GM2017
//show_message(__PFS_generate_pokemon_from_showdown("Charizard"));
function copy_csv_line_to_struct(struct, names, array){
	for (var i = 0; i < array_length(names); ++i) {
		var value = array[i];
		try {
			struct[$ names[i]] = real(value);
		} catch(err) {
			struct[$ names[i]] = value;
		}
	}
}
function read_csv_to_array(basestruct = {}) {
	var arr = [];
	var _pos = [];
	var firstline = true;
	while (!file_text_eof(__PFSInit.cf)) { //Latest
		var _line = string_split(file_text_read_string(__PFSInit.cf), ",");
		if (firstline) {
			firstline = false;
			_pos = _line;
			file_text_readln(__PFSInit.cf);
			continue;
		}
		if (array_length(_line) == 1 or array_length(_line) == 0) { continue; }
		var struct = variable_clone(basestruct);
		copy_csv_line_to_struct(struct, _pos, _line);
		array_push(arr, struct);
		file_text_readln(__PFSInit.cf);
	}
	return arr;
}
cf = -1;
if (PFS.Initialized) { instance_destroy(); }
timer = 0;
start = 0;
step = -1;
mapstring = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?,-.:%"
PFS.Fonts = {};
PFS.Fonts.PokeFont[1] = font_add_sprite_ext(sPokeFont1, mapstring, true, 0);
PFS.Fonts.PokeFont[2] = font_add_sprite_ext(sPokeFont2, mapstring, true, 0);
PFS.Fonts.PokeFont[3] = font_add_sprite_ext(sPokeFont3, mapstring, true, 0);
PFS.Fonts.PokeFont[4] = font_add_sprite_ext(sPokeFont4, mapstring, true, 0);
PFS.Fonts.BattleFont[1] = font_add_sprite_ext(sBattleFont1, mapstring, true, 0);
PFS.Fonts.BattleFont[2] = font_add_sprite_ext(sBattleFont2, mapstring, true, 0);
PFS.Fonts.BattleFont[3] = font_add_sprite_ext(sBattleFont3, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[1] = font_add_sprite_ext(sPokeSelectFont1, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[2] = font_add_sprite_ext(sPokeSelectFont2, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[3] = font_add_sprite_ext(sPokeSelectFont3, mapstring, true, 0);
//feather disable once GM1041
draw_set_font(PFS.Fonts.PokeFont[2]);
//global.defaultFont = draw_get_font();
scribble_font_set_default("sPokeFont3");
//Feather disable GM2017
function loaded(str) {
	show_debug_message($"[PFS] Loading {str}: {(get_timer() - timer) / 1000000}s");
	try {
		file_text_close(cf);
	}
	catch(err) {}
}