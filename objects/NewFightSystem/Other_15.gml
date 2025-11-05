///State Machine

fsm = new SnowState("Battle_Start");

fsm.add("Animation", {
	enter: function() {
		playerthrow.f = 0;
		playerthrow.repeat_animation = false;
		can_restart_particle = true;
		draw_ball = true;
	},
	step: function() {
		do_animation();
	},
});

fsm.add("Idle", {
	enter: function() {
		battleui.set_data("info_area_panel_transparent", {image: PFSBehindBar});
		battleui.set_data("info_area2_panel_transparent", {image: PFSOptionsMenu});
		selected_option = 0;
		if (PlayerTeam[pokemon_out].hp == 0 or poke_player_dead) {
			fsm.change("Changing_Pokemon");
		}
	},
	step: function() {
		if (instance_exists(oDialog)) {
			exit;
		}
		var updown = -input_check_pressed("up") + input_check_pressed("down");
		var leftright = (-input_check_pressed("left") + input_check_pressed("right")) * 2;
		selected_option = clamp(selected_option + updown + leftright, 0, 3);
		if (input_check_pressed("accept")) {
			switch (selected_option) {
				case 0:
					fsm.change("Attack");
					break;
				case 2:
					instance_create_depth(x, y, depth - 1, PFSPokemonManager);
					break;
				default:
					// code here
					break;
			}
		}
	},
});

fsm.add("Attack", {
	enter: function() {
		battleui.set_data("info_area2_panel_transparent", {image: undefined});
		battleui.set_data("info_area_panel_transparent", {image: PFSMoveWindow});
		selected_option = 0;
	},
	step: function() {
		var updown = (-input_check_pressed("up") + input_check_pressed("down")) * 2;
		var leftright = -input_check_pressed("left") + input_check_pressed("right");
		selected_option = clamp(selected_option + updown + leftright, 0, 3);
		if (input_check_pressed("cancel")) {
			fsm.change("Idle");
		}
		if (input_check_pressed("accept")) {
			array_push(turn_steps, {
				type : PFSTurnType.Move,
				pokemon : PlayerTeam[pokemon_out],
				foe : EnemyTeam[foe_out],
				move : PlayerTeam[pokemon_out].moves[selected_option]
			});
			fsm.change("Pre_turn");
		}
	},
});

fsm.add("Battle_Start", {
	enter: function() {
		fsm.change("Animation");
	},
	step: function() {},
});

fsm.add("Pre_turn", {
	enter: function() {
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
	endturn: function() {
		if (array_length(turn_steps) == 0) {
			__PFS_tick_status_effect(PlayerTeam[pokemon_out]);
			__PFS_tick_status_effect(EnemyTeam[foe_out]);
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
						array_push(turn_steps, {
							type : PFSTurnType.EnemyChangePokemon,
							next : i
						});
						fsm.change("Turn");
						exit;
					}
				}
			}
			fsm.change("Idle");
		}
	},
	leave: function() {
		if (__PFS_enemy_team_defeated()) {
			instance_destroy();
		}
	},
});

fsm.add("Changing_Pokemon",{
	enter : function () {
		pfs_debug_message("Changing Pokemon");
		instance_create_depth(x, y, depth - 1, PFSPokemonManager);
	},
	step : function () {},
	leave : function () {},
});
