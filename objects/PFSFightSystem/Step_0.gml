if (!instance_exists(oDialog)) {
	if (ranaway or caught) {
	    instance_destroy();
	}
    dialog = noone;
}
pokemonhplerp = lerp(pokemonhplerp, PFS.playerPokemons[pokemonOut].hp, 0.1);
enemyhplerp = lerp(enemyhplerp, enemyPokemon[0].hp, 0.1);
if (dialog != noone) {
	dialog = instance_find(oDialog, 0);
	dialog.struc[$ "pokeplayer"] = PFS.playerPokemons[pokemonOut].internalName;
	dialog.struc[$ "enemypoke"] = enemyPokemon[enemyOut].internalName;
	if (lastUsedMove != 0) {
	    dialog.struc[$ "playermove"] = PFS.moves[lastUsedMove].internalName;
	}
	if (lastEnemyUsedMove != 0) {
		dialog.struc[$ "enemymove"] = PFS.moves[lastEnemyUsedMove].internalName;
	}
	
	waittime = 10;
    dialog.battlecoords();
	exit;
}
waittime -= 1;
if (waittime > 0) {
    exit;
}
//Feather disable GM2017
//Feather disable GM1041
if (pokePlayerDead and !instance_exists(PFSPokemonManager)) {
    selectedMenu = PFSBattleMenus.Pokemon;
	selectingMenu = false;
	instance_create_depth(0, 0, -1, PFSPokemonManager, {onBattle : true});
}
if (keyboard_check_pressed(vk_numpad8)) {
    display_set_gui_size(window_get_width(), window_get_height());
	startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
}
if (!enemy_alive()) {
	instance_destroy();
}
if (doTurn) {
	lastUsedMove = 0;
	lastEnemyUsedMove = 0;
	PFS.playerPokemons[pokemonOut] = __PFS_count_status_effect(PFS.playerPokemons[pokemonOut]);
	enemyPokemon[0] = __PFS_count_status_effect(enemyPokemon[0]);
	var _rnd = irandom_range(0, array_length(enemyPokemon[0].moves) - 1);
	if (!playerLastOneWasDead) {
		if (startturn) {
		    array_push(turnSteps, [PFSTurnType.Move, enemyPokemon[0], PFS.playerPokemons[pokemonOut], enemyPokemon[0].moves[_rnd], PFSBattleSides.Enemy]); //TODO: enemy don't attack if you released a new pokemon after the last one died
			if (enemy_alive()) {
			    show_debug_message($"");
				order_turn();
				show_debug_message($"Turn step: {currentTurn}");
			}
			startturn = false;
		}
		
	}
	//for (var i = 0; i < array_length(turnSteps); ++i) {
		if (!enemy_alive() and turnSteps[0][0] != PFSTurnType.Run) {
		    doTurn = false;
			exit;
		}
	    switch (turnSteps[0][0]) {
		    case PFSTurnType.Move:
				var _string = "";
				var _ability_result = __PFS_ability_before_move(turnSteps[0][1], turnSteps[0][3]);
				turnSteps[0][1] = _ability_result[0];
				turnSteps[0][3] = _ability_result[1];
				var _pokeside = turnSteps[0][4] == PFSBattleSides.Player ? PFS.playerPokemons[pokemonOut] : enemyPokemon[0];
				#region Status
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Sleep)) {
						_string = $"{_pokeside.internalName} is fast asleep!";
						show_debug_message(_string);
						spawn_dialog($"Asleep");
						//array_shift(turnSteps);
						//i--;
						break;
				}
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Paralysis)) {
					var _chance = irandom_range(0, 100);
					if (_chance <= 25) {
						show_debug_message($"{_pokeside.internalName} is paralyzed! It can't move!");
						spawn_dialog($"Paralyzed");
						//array_shift(turnSteps);
						//i--;
						break;
					}
				}
				if (_pokeside.flinch) {
					if (__PFS_pokemon_have_ability(_pokeside, "inner-focus")) {
						show_debug_message($"{_pokeside} won't flinch because of its Inner Focus!");
						spawn_dialog($"WontFlinch");
					}
					else {
						show_debug_message($"{turnSteps[0][1].internalName} flinched due to {turnSteps[0][2].internalName}'s Stench");
						spawn_dialog($"Flinched");
						//array_shift(turnSteps);
						//i--;
						break;
					}
				}
				for (var j = 0; j < array_length(_pokeside.moves); ++j) {
					if (_pokeside.moves[j].id == turnSteps[0][3].id) {
						_pokeside.moves[j].pp--;
						break;
					}
				}
				#endregion
				
				switch (turnSteps[0][4]) {
				    case PFSBattleSides.Player:
						turnSteps[0][1].hp = PFS.playerPokemons[pokemonOut].hp;
						if (turnSteps[0][1].hp > 0) {
						    spawn_dialog($"PlayerUsedMove");
						}
						lastUsedMove = turnSteps[0][3].id;
				        break;
				    case PFSBattleSides.Enemy:
						turnSteps[0][1].hp = enemyPokemon[0].hp;
						if (turnSteps[0][1].hp > 0) {
						    spawn_dialog($"EnemyUsedMove");
						}
						lastEnemyUsedMove = turnSteps[0][3].id;
				        break;
				}
				__PFS_use_move(turnSteps[0][1], turnSteps[0][2], turnSteps[0][3], turnSteps[0][4]);
				//else {
				//	spawn_dialog($"Fainted");
				//}
				//array_shift(turnSteps);
		        break;
			case PFSTurnType.ChangePokemon: //TODO: redo
				for (var j = 0; j < array_length(PFS.playerPokemons[pokemonOut].statusAilments); ++j) {
				    if (PFS.playerPokemons[pokemonOut].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
					    array_delete(PFS.playerPokemons[pokemonOut].statusAilments, j, 1);
						j = 0;
					}
				}
				pokemonOut = turnSteps[0][1];
				pokemonhplerp = PFS.playerPokemons[pokemonOut].hp; //TODO: enemy pokemon
				show_debug_message($"Sent {PFS.playerPokemons[pokemonOut].internalName} out!");
				spawn_dialog("SentOut");
				if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
				    show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} breaks the mold!");
					spawn_dialog($"BreakTheMold");
				}
				load_sprite(PFS.playerPokemons[pokemonOut], 1);
				break;
			case PFSTurnType.UseItem:
				switch (turnSteps[0][1].usetype) {
				    case UseType.PokeBall:
				        if (was_caught(enemyPokemon[enemyOut], turnSteps[0][1].catchrate)) {
						    show_debug_message($"[PFS] {enemyPokemon[enemyOut].internalName} was caught!");
							spawn_dialog($"Caught");
							array_push(PFS.playerPokemons, enemyPokemon[enemyOut]);
							turnSteps = [];
							doTurn = false;
							caught = true;
						}
				        break;
				}
				//array_shift(turnSteps);
				break;
			case PFSTurnType.Run:
				PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
				show_debug_message("Ran from battle");
				spawn_dialog($"RanAway");
				ranaway = true;
				break;
		    default:
		        // code here
		        break;
		}
		//array_shift(turnSteps);
		//i--;
	//}
	PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
	enemyPokemon[0] = __PFS_tick_status_effect(enemyPokemon[0]);
	array_shift(turnSteps);
	if (array_length(turnSteps) == 0) {
		currentTurn++;
		playerLastOneWasDead = false;
		if (PFS.playerPokemons[pokemonOut].hp <= 0) {
		    pokePlayerDead = true;
		}
	    doTurn = false;
		startturn = true;
		selectingMenu = true;
	}
	else { 
		selectingMenu = false;
	}
    exit;
}