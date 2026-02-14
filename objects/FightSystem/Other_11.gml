///UI
str = variable_clone(global.game_uis.battle);
surf = surface_create(720, 480);
battleui = new window(str, false);
battleui.add_draw("Battle_area_panel_transparent", 
	AirUIFunctionStart
		draw_sprite_stretched(PFSBattleBgs, 1, _x, _y, _w, _h);
	AirUIFunctionEnd
);

battleui.add_draw("own_poke_spr", 
	AirUIFunctionStart
		draw_sprite_ext(poke_spr, 0, _x + own_x_offset, _y + own_y_offset, 1, 1, 0, c_white, 1);
	AirUIFunctionEnd
);

battleui.add_draw("enemy_poke_life_panel", 
	AirUIFunctionStart
		draw_sprite_stretched(PFSEnemyHpBar, 0, _x - other_offset, _y, _w, _h);
	AirUIFunctionEnd
);

battleui.add_draw("enemy_poke_spr", 
	AirUIFunctionStart
		draw_sprite_ext(PFSBattleBgsPaths, 0, _x + 97, _y + 184 - other_offset_y, 3, 3, 0, c_white, 1);
		draw_sprite_ext(other_spr, 0, _x + other_x_offset + other_offset, _y + other_y_offset, 1, 1, 0, c_white, 1);
	AirUIFunctionEnd
);

battleui.set_data("info_area_panel_transparent", {image: PFSBehindBar});
battleui.set_data("info_area2_panel_transparent", {image: PFSOptionsMenu});
battleui.add_draw("info_area_panel_transparent", 
	AirUIDefaultDraw
);

for (var i = 0; i <= 3; i++) {
	battleui.add_draw($"mname{i}", 
		AirUIFunctionStart
			if (state.get_current_state() == "Use_Move") {
				draw_move(real(string_digits(name)), pos);
			}
		AirUIFunctionEnd
	);
}

battleui.add_draw("info_area2_panel_transparent", 
	AirUIFunctionStart
	AirUIDrawDefaultSpr
	draw_sprite_ext(PFSOptionSelected, 0, _x + 10, _y + 10, 1, 1, 0, c_white, 1);
	AirUIFunctionEnd
);
battleui.finish();