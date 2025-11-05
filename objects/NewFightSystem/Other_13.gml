///Animation data
enum battle_animations {
	none,
	battle_start,
	poke_enter,
	enemy_fainted,
}

current_animation = battle_animations.battle_start;
pfs_debug_message("Change Animation to Battle Start");
#region animations
show_player_hp = false;
playerthrow = new animated_sprite(sPlayerBallThrow);
draw_ball = false;
draw_replace_timer = 60;
bally = undefined;
bally_end = 0;
//enemy_hp = EnemyTeam[enemy_pokemon_out].hp;
poke_hp = 0;
pokemon_released = false;
#endregion

do_animation = function() {
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
			if (pokemon_offset == 0 && hp_offset == 0) {
				current_animation = battle_animations.poke_enter;
				pfs_debug_message("Change Animation to Release Pokemon");
			}
			break;

		case battle_animations.poke_enter:
			if (playerthrow.get_frame() > 3) {
				player_offset = approach(player_offset, -300, 4);
				bally ??= 185;
				bally = approach(bally, bally_end, 3);
				if (bally == bally_end && player_offset == -300) {
					current_animation = battle_animations.none;
					pfs_debug_message("Change Animation to None");
					bally = undefined;
					fsm.change("Idle");
				}
			}
			playerthrow.animate();
			break;

		case battle_animations.enemy_fainted:
			enemy_sprite_offset_y = approach(enemy_sprite_offset_y, 80, 0.5);
			enemy_alpha = lerp(enemy_alpha, 0, 0.25);
			if (enemy_sprite_offset_y == 80 && enemy_alpha == 0) {
				enemy_sprite_offset_y = 0;
				enemy_alpha = 1;
				current_animation = battle_animations.none;
			}
			break;

		case battle_animations.none:
			fsm.change("Idle");
			break;
	}
};
