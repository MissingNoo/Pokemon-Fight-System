surf = surface_recreate(surf, 720, 480);
surface_set_target(surf);
draw_clear_alpha(c_black, 1);

battleui.foreach(function(name, pos, data) {
	var D = DebugManager;
	var spr = undefined;
	if (data[$ "image"] != undefined) { spr = asset_get_index(data.image); }
	if (spr == undefined or spr == -1) { spr = sBlank; }
	var _x = pos.left;
	var _y = pos.top;
	var _xx = pos.width;
	var _yy = pos.height;
	var si;
	
	var custom_draw = false;
	var draw = true;
	switch (name) {
		#region Enemy
	    case "enemy_poke_spr":
			draw_set_alpha(enemy_alpha);
			_x -= enemy_sprite_offset;
			si = sine_wave(current_time / 2000, 1, 2, 0);
			_y += si;
			spr = global.pokemon_sprites.get_sprite(enemyPokemon[0], "Front");
			draw_sprite_ext(PFSBattleBgsPaths, 0, _x + 97, _y - si + 184, 3, 3, 0, c_white, 1);
	        break;
	    case "enemy_poke_life_panel":
			_x -= hp_offset;
	        break;
	    case "enemy_hp_bar":
			_x -= hp_offset;
	        break;
	    case "enemy_poke_name":
			_x -= hp_offset;
	        scribble($"[sBattleFont1]{enemyPokemon[0].internalName}").scale_to_box(pos.width, pos.height, true).draw(_x, _y);
	        break;
		case "enemy_poke_level":
			_x -= hp_offset;
	        scribble($"[fa_bottom][sBattleFont1]{enemyPokemon[0].level}").scale_to_box(pos.width, pos.height, true).draw(_x, _y + pos.height);
	        break;
		#endregion
		#region Own Pokemon
		case "own_poke_life_panel":
			draw = show_player_hp;
			_x += hp_offset;
	        break;
		case "hp_bar":
			draw = show_player_hp;
			_x += hp_offset;
	        break;
	    case "poke_name":
			draw = show_player_hp;
			_x += hp_offset;
			if (draw) 
				scribble($"[sBattleFont1]{PlayerTeam[pokemon_out].internalName}").scale_to_box(pos.width, pos.height, true).draw(_x, _y);
	        break;
	    case "poke_level":
			draw = show_player_hp;
			_x += hp_offset;
			if (draw) 
				scribble($"[fa_bottom][sBattleFont1]{PlayerTeam[pokemon_out].level}").scale_to_box(pos.width, pos.height, true).draw(_x, _y + pos.height);
	        break;
		case "own_poke_spr":
			bally_end = pos.top + pos.height;
			
			_x += pokemon_offset;
			si = sine_wave(current_time / 2000, 1, 2, 0);
			_y += si;
			_yy = 192 + si;
			
			draw_sprite_ext(PFSBattleBgsPaths, 0, _x + 105, _y - si + 180, 3.15, 3.15, 0, c_white, 1);
			if (pokemon_released and draw_replace_timer == 0) {
			    spr = global.pokemon_sprites.get_sprite(PlayerTeam[0], "Back");
			} else {
				custom_draw = true;
				if (pokemon_released) {
					spr = global.pokemon_sprites.get_sprite(PlayerTeam[0], "Back");
				    draw_sprite_stretched(spr, 0, _x, _y, _xx, _yy);
				}
			}
			_y -= si;
			if (bally != undefined and draw_ball) {
				draw_sprite_ext(sPokeballNormal, 0, _x + (pos.width / 2), bally, 3, 3, 0, c_white, 1);
			}
			if (bally == bally_end) {
				if (can_restart_particle) {
					can_restart_particle = false;
					part_system_position(ps, pos.left + (pos.width / 2), pos.top + pos.height);
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
			draw_sprite_ext(playerthrow.sprite, playerthrow.subimg, _x + 75 + player_offset, _y + 112, 3, 3, 0, c_white, 1);
			
			//custom_draw = true;
			//48 = half from half of spr
	        //draw_sprite_general(spr, 0, 0, 0, pos.width, pos.height + 192, pos.left + 24, pos.top - 72 + si, 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	        break;
		#endregion
		case "info_area_panel_transparent":
			break;
		case "info_area2_panel_transparent":
			if (battleui.get_child_data("info_area2_panel_transparent", "image") == PFSOptionsMenu) {
				si = sine_wave(current_time / 2000, 1, 2, 0);
				var d = DebugManager;
			    var arr = [
					[_x + 35, _y + 52],
					[_x + 35, _y + 101],
					[_x + 203, _y + 52],
					[_x + 203, _y + 101],
				]
				custom_draw = true;
				draw_sprite_stretched(spr, 0, _x, _y, _xx, _yy);
				draw_sprite_ext(PFSOptionSelected, 0, arr[selected_option][0] + si, arr[selected_option][1], 2, 2, 0, c_white, 1);
			}
			break;
		case "mname1":
		case "mname2":
		case "mname3":
		case "mname4":
			if (fsm.get_current_state() == "Attack") {
			    draw_move(real(string_digits(name)) - 1, pos);
			}
			
			break;
	    default:
	        break;
	}
	if (!custom_draw and draw) {
	    draw_sprite_stretched(spr, 0, _x, _y, _xx, _yy);
	}
	draw_set_alpha(1);
});
surface_reset_target();
draw_rectangle_color(0, 0, GW, GH, c_black, c_black, c_black, c_black, false);
draw_surface_stretched(surf, 0, 0, GW, GH);