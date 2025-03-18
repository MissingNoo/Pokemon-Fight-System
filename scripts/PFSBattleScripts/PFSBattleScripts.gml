//feather disable GM2017
global.__PFSEnemyTeam = [];
#macro EnemyTeam global.__PFSEnemyTeam
#macro PlayerTeam PFS.playerPokemons
#macro DialogData global.dialogdata
#macro CurrentTurn turn_steps[0]
enum __PFS_tsnames {
	Type,
	Pokemon,
	Enemy,
	Move,
	Side
}

function __PFS_turn_begin() {
	//var poke = battle.pokemon_out;
	//var enemy = battle.enemy_pokemon_out;
    //TODO: Enemy move AI
	var rng = __PFS_rngr(0, array_length(EnemyTeam[enemy_pokemon_out].moves) - 1);
	current_animation = battle_animations.none;
	show_debug_message("[PFS] Turn Begin");
	//Select random attack from enemy pokemon
	//If Player is changing pokemon, attack hits the next pokemon
	if (pokemon_out != next_pokemon) {
		array_push(turn_steps, [
			PFSTurnType.Move,
			EnemyTeam[enemy_pokemon_out],
			PlayerTeam[next_pokemon],
			EnemyTeam[enemy_pokemon_out].moves[rng],
			PFSBattleSides.Enemy
		]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	}
	else {
		array_push(turn_steps, [
			PFSTurnType.Move,
			EnemyTeam[enemy_pokemon_out],
			PlayerTeam[pokemon_out],
			EnemyTeam[enemy_pokemon_out].moves[rng],
			PFSBattleSides.Enemy
			]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	}
	if (__PFS_enemy_alive()) {
		show_debug_message($"");
		__PFS_order_turn();
		show_debug_message($"Turn step: {current_turn}");
	}
	fsm.change("Turn");
}

function __PFS_turn_step() {
    show_debug_message("Turn step");
	var battle = NewFightSystem;
    if (!instance_exists(battle)) { exit; }
	__PFS_count_status_effect(PlayerTeam[pokemon_out]);
	__PFS_count_status_effect(EnemyTeam[enemy_pokemon_out]);
	if (__PFS_enemy_team_defeated() and CurrentTurn[__PFS_tsnames.Type] != PFSTurnType.Run) { exit; }
	switch (CurrentTurn[__PFS_tsnames.Type]) {
		case PFSTurnType.Move: {
			var current_pokemon = CurrentTurn[__PFS_tsnames.Pokemon]; //CurrentTurn[__PFS_tsnames.Side] == PFSBattleSides.Player ? PlayerTeam[pokemonOut] : EnemyTeam[enemyOut];
			trace($"{current_pokemon.internalName}:{current_pokemon.hp}");
			DialogData[$"pokename"] = current_pokemon.internalName;
			#region Status
			if (__PFS_pokemon_affected_by_status(current_pokemon, PFSStatusAilments.Sleep)) {
				trace($"{current_pokemon.internalName} is fast asleep!");
				spawn_dialog($"Asleep");
				break;
			}
			if (__PFS_pokemon_affected_by_status(current_pokemon, PFSStatusAilments.Paralysis) and __PFS_rng() <= 25) {
				trace($"{current_pokemon.internalName} is paralyzed! It can't move!");
				spawn_dialog($"Paralyzed");
				break;
			}
			if (current_pokemon.flinch) {
				if (__PFS_pokemon_have_ability(current_pokemon, "inner-focus")) {
					trace($"{current_pokemon.internalName} won't flinch because of its Inner Focus!");
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
			
			if (array_contains(PlayerTeam, CurrentTurn[__PFS_tsnames.Pokemon])) {
			    if (current_pokemon.hp > 0) {
					spawn_dialog($"PlayerUsedMove");
				}
				last_used_move = CurrentTurn[__PFS_tsnames.Move].id;
			} else {
				if (current_pokemon.hp > 0) {
					spawn_dialog($"EnemyUsedMove");
				}
				last_enemy_used_move = CurrentTurn[__PFS_tsnames.Move].id;
			}			
			__PFS_use_move(CurrentTurn[__PFS_tsnames.Pokemon], CurrentTurn[__PFS_tsnames.Enemy], CurrentTurn[__PFS_tsnames.Move], CurrentTurn[__PFS_tsnames.Side]);
			break;
		}
		
		case PFSTurnType.ChangePokemon:
			//When Changing pokemon, erase Perish Song from the party
			array_foreach(PlayerTeam, function(e, i){
				__PFS_remove_status(e, PFSStatusAilments.Perish_song); 
			});
			if (pokemonOut != CurrentTurn[__PFS_tsnames.Pokemon]) {
				global.dialogdata[$"comebackpoke"] = PlayerTeam[pokemonOut].internalName;
			}
			battle.pokemonOut = CurrentTurn[__PFS_tsnames.Pokemon];
            battle.pokemonhplerp = PlayerTeam[battle.pokemonOut].hp;
			show_debug_message($"Sent {PlayerTeam[pokemonOut].internalName} out!");
			spawn_dialog("ComeBack");
			battle.currentanimation = "comeback";
			battle.playerpokesizelerp = 0;
			battle.sys.change("animation");
			break;
        
        case PFSTurnType.EnemyChangePokemon: //TODO: redo
				current_animation = battle_animations.enemy_fainted;
				fsm.change("Animation");
				for (var j = 0; j < array_length(EnemyTeam[enemy_pokemon_out].statusAilments); ++j) {
					if (EnemyTeam[enemy_pokemon_out].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
						array_delete(EnemyTeam[enemy_pokemon_out].statusAilments, j, 1);
						j = 0;
					}
				}
				last_enemy_pokemon = enemy_pokemon_out;
				enemy_pokemon_out = turn_steps[0][1];
				enemyhplerp = EnemyTeam[enemy_pokemon_out].hp; //TODO: enemy pokemon
				show_debug_message($"Foe sent {EnemyTeam[enemy_pokemon_out].internalName} out!");
				spawn_dialog("EnemySentOut");
				if (__PFS_pokemon_have_ability(EnemyTeam[enemy_pokemon_out], "mold-breaker")) {
					DialogData[$"pokename"] = EnemyTeam[enemy_pokemon_out].internalName;
					array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
					show_debug_message($"{EnemyTeam[enemy_pokemon_out].internalName} breaks the mold!");
				}
				
				break;
			case PFSTurnType.UseItem://TODO: Ball shakes
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
				break;
			case PFSTurnType.Run:
				escape_attempts++;
				PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
				if (PlayerTeam[pokemonOut].speed > enemyPokemon[enemyOut].speed) {
				    ranaway = true;
				}
				else {
					var p = PlayerTeam[pokemonOut];
					var w = enemyPokemon[enemyOut];
					var odds = (((p.base.speed * 32) / (w.base.speed / 4)) + 30 * escape_attempts) / 256;
					if (odds >= 1) {
					    ranaway = true;
					}
				}
				#region Abilities
				var shadow_tag = __PFS_pokemon_have_ability(enemyPokemon[enemyOut], "Shadow Tag") and !__PFS_pokemon_have_ability(PlayerTeam[pokemonOut], "Shadow Tag");
				var grounded = false; //TODO: https://bulbapedia.bulbagarden.net/wiki/Grounded
				var arenatrap = __PFS_pokemon_have_ability(enemyPokemon[enemyOut], "Arena Trap");
				var magnet_pull = __PFS_pokemon_have_ability(enemyPokemon[enemyOut], "Magnet Pull") and __PFS_pokemon_have_type(PlayerTeam[pokemonOut], __PFSTypes.Steel);
				var trapped = false; //TODO
				if (shadow_tag or (arenatrap and grounded) or magnet_pull or trapped) {
				    ranaway = false;
				}
				if (__PFS_pokemon_have_ability(PlayerTeam[pokemonOut], "run-away")) {
				    ranaway = true;
				}
				#endregion
				if (!canflee) {
				    ranaway = false;
				}
				if (ranaway or forceflee) {
					if (array_length(turnSteps) > 1) {
					    turnSteps = [turnSteps[0]];
					}					
				    show_debug_message("Ran from battle");
					spawn_dialog($"RanAway");
				}
				break;
		}
		array_shift(turn_steps);
		exit;
}

function __PFS_turn_end() {
	
}

#region Battle functions
function __PFS_enemy_alive() {
	//var battle = NewFightSystem;
	//var enemy = battle.enemy_pokemon_out;
	if (EnemyTeam[enemy_pokemon_out].hp > 0) {
		    return true;
		}
	return false;
}

function __PFS_order_turn() {
	array_sort(turn_steps, function(elm1, elm2) {
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
                trace($"{p2[1].internalName}:{p2[1].speed} is faster than {p1[1].internalName}:{p1[1].speed}, going first!");
            }
            if (p1[3].priority > p2[3].priority) {
                _goAfter = false;
                trace($"{p1[1].internalName}:{p1[3].internalName}:{p1[3].priority} has higher priority than {p2[1].internalName}:{p2[3].internalName}:{p2[3].priority}, going first!");
            }			
		}
		else {
			_goAfter = elm1[0] < elm2[0];
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