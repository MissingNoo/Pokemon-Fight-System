if (pokemon_released) {
    draw_replace_timer = clamp(draw_replace_timer - 1, 0, 60);
}
fsm.step();
var enemy_poke = EnemyTeam[enemy_pokemon_out];
if (enemy_pokemon_out != last_enemy_pokemon and current_animation == battle_animations.enemy_fainted) {
	enemy_poke = EnemyTeam[last_enemy_pokemon];
}
enemy_hp = approach(enemy_hp, enemy_poke.hp, 1);
poke_hp = approach(poke_hp, PlayerTeam[pokemon_out].hp, 1);