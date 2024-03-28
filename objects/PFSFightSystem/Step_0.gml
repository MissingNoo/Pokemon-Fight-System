//Feather disable GM2017
if (pokePlayerDead) {
    selectedMenu = PFSBattleMenus.Pokemon;
}
if (keyboard_check_pressed(vk_numpad8)) {
    display_set_gui_size(window_get_width(), window_get_height());
	startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
}

if (keyboard_check_pressed(vk_f1)) {
    doTurn = true;
	show_message(turnSteps);
}

if (doTurn) {
	var _rnd = irandom_range(0, array_length(enemyPokemon[0].moves) - 1);
	array_push(turnSteps, [PFSTurnType.Move, enemyPokemon[0], PFS.playerPokemons[pokemonOut], enemyPokemon[0].moves[_rnd], PFSBattleSides.Enemy]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	if (enemy_alive()) {
	    show_debug_message($"");
		order_turn();
		show_debug_message($"Turn step: {currentTurn}");
	}
	for (var i = 0; i < array_length(turnSteps); ++i) {
		if (!enemy_alive() and turnSteps[i][0] != PFSTurnType.Run) {
		    doTurn = false;
			exit;
		}
	    switch (turnSteps[i][0]) {
		    case PFSTurnType.Move:
				var _ability_result = __PFS_ability_before_move(turnSteps[i][1], turnSteps[i][3]);
				turnSteps[i][1] = _ability_result[0];
				turnSteps[i][3] = _ability_result[1];
				switch (turnSteps[i][4]) {
				    case PFSBattleSides.Player:
						if (__PFS_pokemon_affected_by_status(PFS.playerPokemons[pokemonOut], PFSStatusAilments.Paralysis)) {
							var _chance = irandom_range(0, 100);
							if (_chance <= 25) {
								show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} is paralyzed! It can't move!");
								array_shift(turnSteps);
								i--;
								continue;
							}
						}
						if (PFS.playerPokemons[pokemonOut].flinch) {
							if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "inner-focus")) {
							    show_debug_message($"{PFS.playerPokemons[pokemonOut]} won't flinch because of its Inner Focus!");
							}
							else {
								show_debug_message($"{turnSteps[i][1].internalName} flinched due to {turnSteps[i][2].internalName}'s Stench");
								array_shift(turnSteps);
								i--;
								continue;
							}
						}
						lastUsedMove = turnSteps[i][3].id;
				        turnSteps[i][1].hp = PFS.playerPokemons[pokemonOut].hp;
						for (var j = 0; j < array_length(PFS.playerPokemons[pokemonOut].moves); ++j) {
					    if (PFS.playerPokemons[pokemonOut].moves[j].id == turnSteps[i][3].id) {
							    PFS.playerPokemons[pokemonOut].moves[j].pp--;
								break;
							}
						}
				        break;
				    case PFSBattleSides.Enemy:
						if (__PFS_pokemon_affected_by_status(enemyPokemon[0], PFSStatusAilments.Paralysis)) {
							var _chance = irandom_range(0, 100);
							if (_chance <= 25) {
								show_debug_message($"{enemyPokemon[0].internalName} is paralyzed! It can't move!");
								array_shift(turnSteps);
								i--;
								continue;
							}
						}
						if (enemyPokemon[0].flinch) {
							if (__PFS_pokemon_have_ability(enemyPokemon[0], "inner-focus")) {
							    show_debug_message($"{enemyPokemon[0]} won't flinch because of its Inner Focus!");
							}
							else {
								show_debug_message($"{turnSteps[i][1].internalName} flinched due to {turnSteps[i][2].internalName}'s Stench");
								array_shift(turnSteps);
								i--;
								continue;
							}
						}
						lastEnemyUsedMove = turnSteps[i][3].id;
				        turnSteps[i][1].hp = enemyPokemon[0].hp;
						for (var j = 0; j < array_length(enemyPokemon[0].moves); ++j) {
					    if (enemyPokemon[0].moves[j].id == turnSteps[i][3].id) {
							    enemyPokemon[0].moves[j].pp--;
								break;
							}
						}
				        break;
				}
		        __PFS_use_move(turnSteps[i][1], turnSteps[i][2], turnSteps[i][3], turnSteps[i][4]);
		        break;
			case PFSTurnType.ChangePokemon:
				pokemonOut = turnSteps[i][1];
				show_debug_message($"Sent {PFS.playerPokemons[pokemonOut].internalName} out!");
				load_sprite(PFS.playerPokemons[pokemonOut], 1);
				break;
			case PFSTurnType.Run:
				PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
				show_debug_message("Ran from battle");
				instance_destroy();
				break;
		    default:
		        // code here
		        break;
		}
		array_shift(turnSteps);
		i--;
	}
	PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
	enemyPokemon[0] = __PFS_tick_status_effect(enemyPokemon[0]);
	currentTurn++;
	if (PFS.playerPokemons[pokemonOut].hp <= 0) {
	    pokePlayerDead = true;
	}
	lastUsedMove = 0;
	lastEnemyUsedMove = 0;
    doTurn = false;
}