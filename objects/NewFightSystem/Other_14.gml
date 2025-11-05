///UI
str = variable_clone(global.game_uis.battle);
surf = surface_create(720, 480);
battleui = new window(str, false);

draw_move = function(mnum, pos) {
	var si = sine_wave(current_time / 2000, 1, 2, 0);
	var _x = pos.left;
	var _y = pos.top;
	if (array_length(PlayerTeam[pokemon_out].moves) == 0) { exit; }
	if (array_length(PlayerTeam[pokemon_out].moves) <= mnum) { exit; }
	var move = PlayerTeam[pokemon_out].moves[mnum];
	scribble($"[fa_middle][sPokeFont1]{move.internalName}").scale(2).scale_to_box(pos.width, pos.height, false).draw(_x + 20, _y + (pos.height / 2));
	if (selected_option == mnum) {
		draw_sprite_ext(PFSOptionSelected, 0, _x + si + 10, _y + (pos.height / 2), 2, 2, 0, c_white, 1);
	}
}


battleui.add_draw("enemy_poke_spr",
	AirUIFunctionStart
	AirUIDefaultSpr
		draw_set_alpha(enemy_alpha);
		_x -= enemy_sprite_offset;
		si = 0;//sine_wave(current_time / 2000, 1, 2, 0);
		_y += si;
		if (enemy_sprite_offset_y != 0) {
			_y += - si + enemy_sprite_offset_y;
		}
		draw_sprite_ext(PFSBattleBgsPaths, 0, _x + 97, _y - si + 184 - enemy_sprite_offset_y, 3, 3, 0, c_white, 1);
		draw_sprite_ext(global.pokemon_sprites.get_sprite(EnemyTeam[foe_out], "Front"), 0, _x + foe_x_offset, _y - si + foe_y_offset - enemy_sprite_offset_y, foe_scale, foe_scale, 0, c_white, 1);
	AirUIFunctionEnd
);
battleui.add_draw("enemy_poke_life_panel",
	AirUIFunctionStart
	AirUIDefaultSpr
		_x -= hp_offset;
		draw_sprite_stretched(spr, 0, _x, _y, _w, _h);
	AirUIFunctionEnd
);
battleui.add_draw("enemy_hp_bar",
	AirUIFunctionStart
	AirUIDefaultSpr
		_x -= hp_offset;
		draw_healthbar(_x, _y, _x + _w, _y + _h, ((enemy_poke.hp / enemy_poke.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
	AirUIFunctionEnd
);
battleui.add_draw("enemy_poke_name",
	AirUIFunctionStart
		_x -= hp_offset;
		scribble($"[sBattleFont1]{enemy_poke.internalName}").scale_to_box(_w, _h, true).draw(_x, _y);
	AirUIFunctionEnd
);
battleui.add_draw("enemy_poke_level",
	AirUIFunctionStart
		_x -= hp_offset;
		scribble($"[fa_bottom][sBattleFont1]{enemy_poke.level}").scale_to_box(_w, _h, true).draw(_x, _y + _h);
	AirUIFunctionEnd
);
battleui.add_draw("own_poke_life_panel",
	AirUIFunctionStart
	AirUIDefaultSpr
		_x += hp_offset;
		if (show_player_hp) {
 			draw_sprite_stretched(spr, 0, _x, _y, _w, _h);
		}
	AirUIFunctionEnd
);
battleui.add_draw("hp_bar",
	AirUIFunctionStart
		_x += hp_offset;
		poke = PlayerTeam[pokemon_out];
		if (show_player_hp) {
			draw_healthbar(_x, _y, _x + _w, _y + _h, ((poke.hp / poke.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
		}
	AirUIFunctionEnd
);
battleui.add_draw("poke_name",
	AirUIFunctionStart
		_x += hp_offset;
		if (show_player_hp) {
			var n = PlayerTeam[pokemon_out][$ "nickname"] ?? PlayerTeam[pokemon_out].internalName;
			scribble($"[sBattleFont1]{n}").scale_to_box(_w, _h, true).draw(_x, _y);
		}
	AirUIFunctionEnd
);
battleui.add_draw("poke_level",
	AirUIFunctionStart
		_x += hp_offset;
		if (show_player_hp) {
			scribble($"[fa_bottom][sBattleFont1]{PlayerTeam[pokemon_out].level}").scale_to_box(_w, _h, true).draw(_x, _y + _h);
		}
	AirUIFunctionEnd
);
battleui.add_draw("own_poke_spr",
	AirUIFunctionStart
	AirUIDefaultSpr
		bally_end = _y + _h;
		
		_x += pokemon_offset;
		si = 0;//sine_wave(current_time / 2000, 1, 2, 0);
		_y += si;
		//_yy = 192 + si;
		var sc = gpu_get_scissor();
		draw_sprite_ext(PFSBattleBgsPaths, 0, _x + 105, _y - si + 180, 3.15, 3.15, 0, c_white, 1);
		if (pokemon_released) {// and draw_replace_timer == 0) {
			spr = global.pokemon_sprites.get_sprite(PlayerTeam[pokemon_out], "Back");
			draw_sprite_ext(spr, 0, _x + own_x_offset, _y + own_y_offset, 1, 1, 0, c_white, 1);
		}
		_y -= si;
		if (bally != undefined and draw_ball) {
			draw_sprite_ext(sPokeballNormal, 0, _x + (_w / 2), bally, 3, 3, 0, c_white, 1);
		}
		if (bally == bally_end) {
			if (can_restart_particle) {
				can_restart_particle = false;
				part_system_position(ps, _x + (_w / 2), _y + _h);
				var _pemit1 = part_emitter_create(ps);
				part_emitter_region(ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
				part_emitter_burst(ps, _pemit1, ptype1, 30);
				draw_ball = false;
				pokemon_released = true;
				show_player_hp = true;
				draw_replace_timer = 60;
			}
			part_system_drawit(ps);
		}
		draw_sprite_ext(playerthrow.sprite, playerthrow.get_frame(), _x + 75 + player_offset, _y + 112, 3, 3, 0, c_white, 1);
	AirUIFunctionEnd
);
battleui.add_draw("info_area_panel_transparent",
	AirUIFunctionStart
	AirUIDefaultSpr
		draw_set_alpha(1);
		draw_sprite_stretched(spr, 0, _x, _y, _w, _h);
	AirUIFunctionEnd
);
battleui.add_draw("info_area2_panel_transparent",
	AirUIFunctionStart
	AirUIDefaultSpr
		if (battleui.get_child_data("info_area2_panel_transparent", "image") == PFSOptionsMenu) {
			si = sine_wave(current_time / 2000, 1, 2, 0);
			var arr = [
				[_x + 35, _y + 52],
				[_x + 35, _y + 101],
				[_x + 203, _y + 52],
				[_x + 203, _y + 101],
			]
			custom_draw = true;
			draw_sprite_stretched(spr, 0, _x, _y, _w, _h);
			draw_sprite_ext(PFSOptionSelected, 0, arr[selected_option][0] + si, arr[selected_option][1], 2, 2, 0, c_white, 1);
		}
	AirUIFunctionEnd
);
battleui.finish();