EnemyTeam = enemyPokemon;

can_interact = true;
enemy_dead = false;
poke_player_dead = false;
player_last_one_was_dead = false;
current_turn = 0;
last_enemy_used_move = -1;
last_used_move = -1;
pokemon_out = 0;
next_pokemon = 0;
enemy_pokemon_out = 0;
last_enemy_pokemon = 0;
selected_option = 0;
turn_steps = [];

#region systems
//ParticleSystem1
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_spark);
part_type_size(ptype1, 1, 1, 0, 0);
part_type_scale(ptype1, 1, 1);
part_type_speed(ptype1, 5, 5, 0, 0);
part_type_direction(ptype1, 0, 360, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(ptype1, 1, 1, 1);
part_type_blend(ptype1, false);
part_type_life(ptype1, 20, 40);
part_system_automatic_draw(ps, false);
can_restart_particle = true;
#endregion

enum battle_animations {
	none,
	battle_start,
	poke_enter,
	enemy_fainted
}

current_animation = battle_animations.battle_start;

#region animations
playerthrow = new animated_sprite(sPlayerBallThrow);
draw_ball = false;
draw_replace_timer = 60;
bally = undefined;
bally_end = 0;
enemy_hp = EnemyTeam[enemy_pokemon_out].hp;
poke_hp = 0;
#endregion

#region hp offset
hp_offset = 500;
enemy_sprite_offset = 700;
enemy_sprite_offset_y = 0;
enemy_alpha = 0.20;

pokemon_offset = 700;
player_offset = 0;
show_player_hp = false;
pokemon_released = false;
#endregion

fsm = new SnowState("Battle_Start");

fsm.add("Animation", {
	enter : function() {
		playerthrow.subimg = 0;
		can_restart_particle = true;
		draw_ball = true;
	},
	step : function() {
		switch (current_animation) {
		    case battle_animations.battle_start:
				pokemon_offset = approach(pokemon_offset, 0, 5);
				enemy_sprite_offset = approach(enemy_sprite_offset, 0, 5);
				if (enemy_sprite_offset <= 135) {
				    enemy_alpha = approach(enemy_alpha, 1, 0.10);
				}
				if (enemy_sprite_offset == 0) {
				    hp_offset = approach(hp_offset, 0, 5);
				}
				if (pokemon_offset == 0 and hp_offset == 0) {
					current_animation = battle_animations.poke_enter;
				}
		        break;
				
				case battle_animations.poke_enter:
					if (playerthrow.subimg > 3) {
					    player_offset = approach(player_offset, -300, 4);
						bally ??= 185;
						bally = approach(bally, bally_end, 3);
						if (bally == bally_end and player_offset == -300) {
						    current_animation = battle_animations.none;
							poke_hp = PlayerTeam[pokemon_out].hp;
							bally = undefined;
							fsm.change("Idle");
						}
					}
					playerthrow.animate();
					break;
				
				case battle_animations.enemy_fainted:
					enemy_sprite_offset_y = approach(enemy_sprite_offset_y, 80, 0.5);
					enemy_alpha = lerp(enemy_alpha, 0, 0.25);
					if (enemy_sprite_offset_y == 80 and enemy_alpha == 0) {
					    enemy_sprite_offset_y = 0;
					    enemy_alpha = 1;
						current_animation = battle_animations.none;
					}
					break;
				
				case battle_animations.none:
					fsm.change("Idle");
					break;
		}
	}
});

fsm.add("Idle", {
	enter : function() {
		battleui.set_data("info_area_panel_transparent", {image : PFSBehindBar});
		battleui.set_data("info_area2_panel_transparent", {image : PFSOptionsMenu});
		selected_option = 0;
	},
	step : function() {
        if (instance_exists(oDialog)) {
        	exit;
        }
		var updown = - input_check_pressed("up") + input_check_pressed("down");
		var leftright = (- input_check_pressed("left") + input_check_pressed("right")) * 2;
		selected_option = clamp(selected_option + updown + leftright, 0, 3);
		if (input_check_pressed("accept")) {
		    switch (selected_option) {
			    case 0:
			        fsm.change("Attack");
			        break;
			    default:
			        // code here
			        break;
			}
		}
	}
});

fsm.add("Attack", {
	enter : function() {
		battleui.set_data("info_area2_panel_transparent", {image : undefined});
		battleui.set_data("info_area_panel_transparent", {image : PFSMoveWindow});
		selected_option = 0;
	},
	step : function() {
		var updown = (- input_check_pressed("up") + input_check_pressed("down")) * 2;
		var leftright = (- input_check_pressed("left") + input_check_pressed("right"));
		selected_option = clamp(selected_option + updown + leftright, 0, 3);
		if (input_check_pressed("cancel")) {
			fsm.change("Idle");
		}
		if (input_check_pressed("accept")) {
			array_push(turn_steps, [
				PFSTurnType.Move,
				PlayerTeam[pokemon_out],
				EnemyTeam[enemy_pokemon_out],
				PlayerTeam[pokemon_out].moves[selected_option],
				PFSBattleSides.Player
			]);
			fsm.change("Pre_turn");
		    //switch (selected_option) {
			//    case 0:
			//        fsm.change("Attack");
			//        break;
			//    default:
			//        // code here
			//        break;
			//}
		}
	}
});

fsm.add("Battle_Start", {
	enter : function() {
		fsm.change("Animation");
	},
	step : function() {
	}
});

fsm.add("Pre_turn", {
	enter: function(){		
		__PFS_turn_begin();
	},
});

fsm.add("Turn", {
	enter: function() {
		if (array_length(turn_steps) == 0) {
		    fsm.change("Idle");
		}
	},
	step: function() {
		__PFS_turn_step();
	},
	endturn: function(){
		if (array_length(turn_steps) == 0) {
			__PFS_tick_status_effect(PlayerTeam[pokemon_out]);
			__PFS_tick_status_effect(EnemyTeam[enemy_pokemon_out]);
			show_debug_message("[PFS] Turn End!");
			show_debug_message("");
			current_turn++;
			player_last_one_was_dead = false;
			if (PlayerTeam[pokemon_out].hp <= 0) {
				poke_player_dead = true;
			}
			if (!__PFS_enemy_alive()) {
			    for (var i = 0; i < array_length(EnemyTeam); ++i) {
				    if (EnemyTeam[i].hp > 0) {
						array_push(turn_steps, [PFSTurnType.EnemyChangePokemon, i]);
						fsm.change("Turn");
						exit;
					}
				}
			}
			fsm.change("Idle");
		}
	},
	leave: function() {caninteract = false;}
})



str = 


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