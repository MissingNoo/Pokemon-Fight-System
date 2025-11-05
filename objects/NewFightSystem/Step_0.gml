enemy_poke = EnemyTeam[foe_out];
//if (pokemon_released) {
//draw_replace_timer = clamp(draw_replace_timer - 1, 0, 60);
//}
//#region HP
//var enemy_poke = EnemyTeam[enemy_pokemon_out];
//if (enemy_pokemon_out != last_enemy_pokemon and current_animation == battle_animations.enemy_fainted) {
//enemy_poke = EnemyTeam[last_enemy_pokemon];
//} else if (current_animation == battle_animations.none and enemy_hp == 0 and enemy_alpha == 1) {
//enemy_hp = enemy_poke.hp;
//}
//
//var app = clamp((abs(enemy_hp - enemy_poke.hp) + 1) / 30, 1, infinity);
//enemy_hp = approach(enemy_hp, enemy_poke.hp, app);
//app = clamp((abs(poke_hp - PlayerTeam[pokemon_out].hp) + 1) / 30, 1, infinity);
//poke_hp = approach(poke_hp, PlayerTeam[pokemon_out].hp, 1);
//#endregion
fsm.step();
