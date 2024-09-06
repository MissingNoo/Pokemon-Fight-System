global.__PFSEnemyTeam = [];
#macro EnemyTeam global.__PFSEnemyTeam
#macro PlayerTeam PFS.playerPokemons
#macro DialogData global.dialogdata
#macro CurrentTurn battle.turnSteps[0]
enum __PFS_tsnames {
	Type,
	Pokemon,
	Enemy,
	Move,
	Side
}

function __PFS_turn_begin() {
	var battle = PFSFightSystem;
	var pokemonOut = battle.pokemonOut;
	var enemyOut = battle.enemyOut;
	var rng = irandom_range(0, array_length(EnemyTeam[battle.enemyOut].moves) - 1);
	battle.lastanimation = "";
	show_debug_message("[PFS] Turn Begin");
	//Select random attack from enemy pokemon
	//If Player is changing pokemon, attack hits the next pokemon
	if (pokemonOut != battle.pokemonOutNext) {
		array_push(battle.turnSteps, [
			PFSTurnType.Move,
			EnemyTeam[enemyOut],
			PlayerTeam[battle.pokemonOutNext],
			EnemyTeam[enemyOut].moves[rng],
			PFSBattleSides.Enemy
		]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	}
	else {
		array_push(battle.turnSteps, [
			PFSTurnType.Move,
			EnemyTeam[enemyOut],
			PlayerTeam[pokemonOut],
			EnemyTeam[enemyOut].moves[rng],
			PFSBattleSides.Enemy]
		); //TODO: enemy don't attack if you released a new pokemon after the last one died
	}
	if (__PFS_enemy_alive()) {
		show_debug_message($"");
		__PFS_order_turn();
		show_debug_message($"Turn step: {currentTurn}");
	}
	battle.sys.change("turn");
}

function __PFS_turn_step() {
	var battle = PFSFightSystem;
	var pokemonOut = battle.pokemonOut;
	var enemyOut = battle.enemyOut;
	PlayerTeam[pokemonOut] = __PFS_count_status_effect(PlayerTeam[pokemonOut]);
	EnemyTeam[enemyOut] = __PFS_count_status_effect(EnemyTeam[enemyOut]);
	if (__PFS_enemy_team_defeated() and CurrentTurn[__PFS_tsnames.Type] != PFSTurnType.Run) {
		exit;
	}
	switch (CurrentTurn[__PFS_tsnames.Type]) {
		case PFSTurnType.Move: {
			var current_pokemon = CurrentTurn[__PFS_tsnames.Side] == PFSBattleSides.Player ? PlayerTeam[pokemonOut] : EnemyTeam[enemyOut];
			DialogData[$"pokename"] = current_pokemon.internalName;
			#region Status
			if (__PFS_pokemon_affected_by_status(current_pokemon, PFSStatusAilments.Sleep)) {
				show_debug_message($"{current_pokemon.internalName} is fast asleep!");
				spawn_dialog($"Asleep");
				break;
			}
			if (__PFS_pokemon_affected_by_status(current_pokemon, PFSStatusAilments.Paralysis) and __PFS_rng() <= 25) {
				show_debug_message($"{current_pokemon.internalName} is paralyzed! It can't move!");
				spawn_dialog($"Paralyzed");
				break;
			}
			if (current_pokemon.flinch) {
				if (__PFS_pokemon_have_ability(current_pokemon, "inner-focus")) {
					show_debug_message($"{current_pokemon.internalName} won't flinch because of its Inner Focus!");
					spawn_dialog($"WontFlinch");
				}
				else {
					show_debug_message($"{current_pokemon.internalName} flinched due to {CurrentTurn[__PFS_tsnames.Enemy].internalName}'s Stench");
					spawn_dialog($"Flinched");
					break;
				}
			}
			CurrentTurn[__PFS_tsnames.Move].pp--;
			//for (var j = 0; j < array_length(current_pokemon.moves); ++j) { if (_pokeside.moves[j].id == turnSteps[0][3].id) { _pokeside.moves[j].pp--; break; } }
			#endregion
			
			switch (CurrentTurn[__PFS_tsnames.Side]) {
				case PFSBattleSides.Player: {
					if (current_pokemon.hp > 0) {
						spawn_dialog($"PlayerUsedMove");
					}
					battle.lastUsedMove = CurrentTurn[__PFS_tsnames.Move].id;
					break;
				}
				
				case PFSBattleSides.Enemy: {
					if (current_pokemon.hp > 0) {
						spawn_dialog($"EnemyUsedMove");
					}
					battle.lastEnemyUsedMove = CurrentTurn[__PFS_tsnames.Move].id;
					break;
				}
			}
			
			__PFS_use_move(CurrentTurn[__PFS_tsnames.Pokemon], CurrentTurn[__PFS_tsnames.Enemy], CurrentTurn[__PFS_tsnames.Move], CurrentTurn[__PFS_tsnames.Side]);
			break;
		}
		
		case PFSTurnType.ChangePokemon: {
			//When Changing pokemon, erase Perish Song from the party
			array_foreach(PlayerTeam, function(e, i){
				__PFS_remove_status(e, PFSStatusAilments.Perish_song); 
			});
			if (pokemonOut != CurrentTurn[__PFS_tsnames.Pokemon]) {
				global.dialogdata[$"comebackpoke"] = PlayerTeam[pokemonOut].internalName;
			}
			battle.pokemonOut = CurrentTurn[__PFS_tsnames.Pokemon];
			show_debug_message($"Sent {PlayerTeam[pokemonOut].internalName} out!");
			spawn_dialog("ComeBack");
			battle.currentanimation = "comeback";
			battle.playerpokesizelerp = 0;
			battle.sys.change("animation");
			break;
		}
			//case PFSTurnType.EnemyChangePokemon: //TODO: redo
			//	currentanimation = "enemyfainted";
			//	sys.change("animation");
			//	for (var j = 0; j < array_length(enemyPokemon[enemyOut].statusAilments); ++j) {
			//		if (enemyPokemon[enemyOut].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
			//			array_delete(enemyPokemon[enemyOut].statusAilments, j, 1);
			//			j = 0;
			//		}
			//	}
			//	enemyOut = turnSteps[0][1];
			//	enemyhplerp = enemyPokemon[enemyOut].hp; //TODO: enemy pokemon
			//	show_debug_message($"Foe sent {enemyPokemon[enemyOut].internalName} out!");
			//	spawn_dialog("EnemySentOut");
			//	if (__PFS_pokemon_have_ability(enemyPokemon[enemyOut], "mold-breaker")) {
			//		global.dialogdata[$"pokename"] = enemyPokemon[enemyOut].internalName;
			//		array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
			//		show_debug_message($"{enemyPokemon[enemyOut].internalName} breaks the mold!");
			//	}
				
			//	break;
			//case PFSTurnType.UseItem://TODO: Ball shakes
			//	switch (turnSteps[0][1].usetype) {
			//		case UseType.PokeBall:
			//			if (was_caught(enemyPokemon[enemyOut], turnSteps[0][1].catchrate)) {
			//				show_debug_message($"[PFS] {enemyPokemon[enemyOut].internalName} was caught!");
			//				spawn_dialog($"Caught");
			//				array_push(PFS.playerPokemons, enemyPokemon[enemyOut]);
			//				turnSteps = [];
			//				doTurn = false;
			//				caught = true;
			//			}
			//			break;
			//	}
			//	break;
			//case PFSTurnType.Run:
			//	PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
			//	show_debug_message("Ran from battle");
			//	spawn_dialog($"RanAway");
			//	ranaway = true;
			//	break;
		}
		array_shift(battle.turnSteps);
		exit;
}

function __PFS_turn_end() {
	
}

#region Battle functions
function __PFS_enemy_alive() {
	var battle = PFSFightSystem;
	var enemyOut = battle.enemyOut;
	if (EnemyTeam[enemyOut].hp > 0) {
		    return true;
		}
	return false;
}

function __PFS_order_turn() {
	var battle = PFSFightSystem;
	array_sort(battle.turnSteps, function(elm1, elm2) {
		var _goAfter = false;
		if (elm1[0] == PFSTurnType.Move and elm2[0] == PFSTurnType.Move) {
			var p1 = variable_clone(elm1);
			var p2 = variable_clone(elm2);
			#region Paralysis
			if (__PFS_pokemon_affected_by_status(p1[1], PFSStatusAilments.Paralysis)) {
			    p1[1].speed = p1[1].speed * 0.5;
			}
			if (__PFS_pokemon_affected_by_status(p2[1], PFSStatusAilments.Paralysis)) {
			    p2[1].speed = p2[1].speed * 0.5;
			}
			#endregion
			if (p1[1].speed < p2[1].speed) {
			    _goAfter = true;
			}
		    if (p1[3].priority < p2[3].priority) {
			    _goAfter = true;
			}
		}
		else {
			_goAfter =  elm1[0] < elm2[0];
		}
	    return _goAfter;
	});
}

function __PFS_enemy_team_defeated() {
	for (var i = 0; i < array_length(EnemyTeam); ++i) {
	    if (EnemyTeam[i].hp > 0) {
		    return false;
		}
	}
	return true;
}
#endregion