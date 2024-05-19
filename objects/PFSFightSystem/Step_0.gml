//Feather disable GM2017
pokemonhplerp = lerp(pokemonhplerp, PFS.playerPokemons[pokemonOut].hp, 0.1);
enemyhplerp = lerp(enemyhplerp, enemyPokemon[0].hp, 0.1);
if (pokePlayerDead and !instance_exists(PFSPokemonManager)) {
    selectedMenu = PFSBattleMenus.Pokemon;
	selectingMenu = false;
	instance_create_depth(0, 0, -1, PFSPokemonManager, {onBattle : true});
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
	PFS.playerPokemons[pokemonOut] = __PFS_count_status_effect(PFS.playerPokemons[pokemonOut]);
	enemyPokemon[0] = __PFS_count_status_effect(enemyPokemon[0]);
	var _rnd = irandom_range(0, array_length(enemyPokemon[0].moves) - 1);
	if (!playerLastOneWasDead) {
	    array_push(turnSteps, [PFSTurnType.Move, enemyPokemon[0], PFS.playerPokemons[pokemonOut], enemyPokemon[0].moves[_rnd], PFSBattleSides.Enemy]); //TODO: enemy don't attack if you released a new pokemon after the last one died
		if (enemy_alive()) {
		    show_debug_message($"");
			order_turn();
			show_debug_message($"Turn step: {currentTurn}");
		}
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
				var _pokeside = turnSteps[i][4] == PFSBattleSides.Player ? PFS.playerPokemons[pokemonOut] : enemyPokemon[0];
				
				#region Status
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Sleep)) {
						show_debug_message($"{_pokeside.internalName} is fast asleep!");
						array_shift(turnSteps);
						i--;
						continue;
				}
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Paralysis)) {
					var _chance = irandom_range(0, 100);
					if (_chance <= 25) {
						show_debug_message($"{_pokeside.internalName} is paralyzed! It can't move!");
						array_shift(turnSteps);
						i--;
						continue;
					}
				}
				if (_pokeside.flinch) {
					if (__PFS_pokemon_have_ability(_pokeside, "inner-focus")) {
						show_debug_message($"{_pokeside} won't flinch because of its Inner Focus!");
					}
					else {
						show_debug_message($"{turnSteps[i][1].internalName} flinched due to {turnSteps[i][2].internalName}'s Stench");
						array_shift(turnSteps);
						i--;
						continue;
					}
				}
				for (var j = 0; j < array_length(_pokeside.moves); ++j) {
					if (_pokeside.moves[j].id == turnSteps[i][3].id) {
						_pokeside.moves[j].pp--;
						break;
					}
				}
				#endregion
				
				switch (turnSteps[i][4]) {
				    case PFSBattleSides.Player:
						lastUsedMove = turnSteps[i][3].id;
				        turnSteps[i][1].hp = PFS.playerPokemons[pokemonOut].hp;
				        break;
				    case PFSBattleSides.Enemy:
						lastEnemyUsedMove = turnSteps[i][3].id;
				        turnSteps[i][1].hp = enemyPokemon[0].hp;
				        break;
				}
		        __PFS_use_move(turnSteps[i][1], turnSteps[i][2], turnSteps[i][3], turnSteps[i][4]);
		        break;
			case PFSTurnType.ChangePokemon: //TODO: redo
				for (var j = 0; j < array_length(PFS.playerPokemons[pokemonOut].statusAilments); ++j) {
				    if (PFS.playerPokemons[pokemonOut].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
					    array_delete(PFS.playerPokemons[pokemonOut].statusAilments, j, 1);
						j = 0;
					}
				}
				pokemonOut = turnSteps[i][1];
				pokemonhplerp = PFS.playerPokemons[pokemonOut].hp; //TODO: enemy pokemon
				show_debug_message($"Sent {PFS.playerPokemons[pokemonOut].internalName} out!");
				if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
				    show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} breaks the mold!");
				}
				load_sprite(PFS.playerPokemons[pokemonOut], 1);
				break;
			case PFSTurnType.UseItem:
				switch (turnSteps[i][1].usetype) {
				    case UseType.PokeBall:
				        if (was_caught(enemyPokemon[enemyOut], turnSteps[i][1].catchrate)) {
						    show_debug_message($"[PFS] {enemyPokemon[enemyOut].internalName} was caught!");
							array_push(PFS.playerPokemons, enemyPokemon[enemyOut]);
							instance_destroy();
						}
				        break;
				    default:
				        // code here
				        break;
				}
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
	playerLastOneWasDead = false;
	if (PFS.playerPokemons[pokemonOut].hp <= 0) {
	    pokePlayerDead = true;
	}
	lastUsedMove = 0;
	lastEnemyUsedMove = 0;
    doTurn = false;
}