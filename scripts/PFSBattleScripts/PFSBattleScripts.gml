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
	Side,
}

function __PFS_turn_begin() {
	//TODO: Enemy move AI
	var rng = __PFS_rngr(0, array_length(EnemyTeam[foe_out].moves) - 1);
	current_animation = battle_animations.none;
	pfs_debug_message("Turn Begin");
	//Select random attack from enemy pokemon
	//If Player is changing pokemon, attack hits the next pokemon
	//if (pokemon_out != next_pokemon) {
	//array_push(turn_steps, [
	//PFSTurnType.Move,
	//EnemyTeam[enemy_pokemon_out],
	//PlayerTeam[next_pokemon],
	//EnemyTeam[enemy_pokemon_out].moves[rng],
	//PFSBattleSides.Enemy
	//]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	//}
	//else {
	array_push(
		turn_steps,
		{
			type: PFSTurnType.Move,
			pokemon: EnemyTeam[foe_out],
			foe: PlayerTeam[pokemon_out],
			move: EnemyTeam[foe_out].moves[rng],
		}
	); //TODO: enemy don't attack if you released a new pokemon after the last one died
	//}
	if (__PFS_enemy_alive()) {
		__PFS_order_turn();
		pfs_debug_message($"Turn step: {current_turn}");
	}
	fsm.change("Turn");
}

function __PFS_turn_step() {
	pfs_debug_message("Turn step");
	__PFS_count_status_effect(PlayerTeam[pokemon_out]);
	__PFS_count_status_effect(EnemyTeam[foe_out]);
	//if (__PFS_enemy_team_defeated() && CurrentTurn.type != PFSTurnType.Run) {
		//exit;
	//}
	switch (CurrentTurn.type) {
		case PFSTurnType.Move: {
			var current_pokemon = CurrentTurn.pokemon; //CurrentTurn[__PFS_tsnames.Side] == PFSBattleSides.Player ? PlayerTeam[pokemonOut] : EnemyTeam[enemyOut];
			#region Status
			if (
				__PFS_pokemon_affected_by_status(current_pokemon, PFSStatusAilments.Sleep)
			) {
				pfs_debug_message($"{current_pokemon.internalName} is fast asleep!");
				spawn_dialog($"Asleep");
				break;
			}
			if (
				__PFS_pokemon_affected_by_status(
					current_pokemon,
					PFSStatusAilments.Paralysis
				)
				&& __PFS_rng() <= 25
			) {
				pfs_debug_message($"{current_pokemon.internalName} is paralyzed! It can't move!");
				spawn_dialog($"Paralyzed");
				break;
			}
			if (current_pokemon.flinch) {
				if (__PFS_pokemon_have_ability(current_pokemon, "inner-focus")) {
					pfs_debug_message(
						$"{
							current_pokemon.internalName
						} won't flinch because of its Inner Focus!"
					);
					spawn_dialog($"WontFlinch");
				} else {
					show_debug_message(
						$"{current_pokemon.internalName} flinched due to {
							CurrentTurn.foe.internalName
						}'s Stench"
					);
					spawn_dialog($"Flinched");
					break;
				}
			}
			CurrentTurn.move.pp--;
			//for (var j = 0; j < array_length(current_pokemon.moves); ++j) { if (_pokeside.moves[j].id == turnSteps[0][3].id) { _pokeside.moves[j].pp--; break; } }
			#endregion
			switch (PFS_get_pokemon_side(CurrentTurn.pokemon)) {
				case PFSBattleSides.Player:
					if (current_pokemon.hp > 0) {
						DialogData[$ "pokeplayer"] = CurrentTurn.pokemon.internalName;
						DialogData[$ "playermove"] = CurrentTurn.move.internalName;
						spawn_dialog($"PlayerUsedMove");
					}
					last_used_move = CurrentTurn.move.id;
					break;
				case PFSBattleSides.Enemy:
					if (current_pokemon.hp > 0) {
						DialogData[$ "enemypoke"] = CurrentTurn.pokemon.internalName;
						DialogData[$ "enemymove"] = CurrentTurn.move.internalName;
						spawn_dialog($"EnemyUsedMove");
					}
					last_enemy_used_move = CurrentTurn.move.id;
					break;
			}
			__PFS_use_move(
				CurrentTurn.pokemon,
				CurrentTurn.foe,
				CurrentTurn.move
				//CurrentTurn[__PFS_tsnames.Side]
			);
			break;
		}

		case PFSTurnType.ChangePokemon:
			//When Changing pokemon, erase Perish Song from the party
			array_foreach(PlayerTeam, function(e, i) {
				__PFS_remove_status(e, PFSStatusAilments.Perish_song);
			});
			if (PlayerTeam[pokemon_out] != CurrentTurn.next) {
				global.dialogdata[$ "comebackpoke"] = PlayerTeam[pokemon_out].internalName;
			}
			pokemon_out = CurrentTurn.next;
			//battle.pokemonhplerp = PlayerTeam[battle.pokemonOut].hp;
			pfs_debug_message($"Sent {PlayerTeam[pokemon_out].internalName} out!");
			spawn_dialog("ComeBack");
			currentanimation = "comeback";
			//playerpokesizelerp = 0;
			fsm.change("Animation");
			break;

		case PFSTurnType.EnemyChangePokemon: //TODO: redo
			current_animation = battle_animations.enemy_fainted; 
			pfs_debug_message("Change Animation to Enemy Fainted");
			fsm.change("Animation");
			__PFS_remove_status(EnemyTeam[foe_out], PFSStatusAilments.Perish_song);
			last_enemy_pokemon = foe_out;
			foe_out = CurrentTurn.next;
			var enemy_name = EnemyTeam[foe_out].internalName;
			pfs_debug_message($"Foe sent {enemy_name} out!");
			DialogData[$ "enemypoke"] = enemy_name;
			spawn_dialog("EnemySentOut");
			if (__PFS_pokemon_have_ability(EnemyTeam[foe_out], "mold-breaker")) {
				DialogData[$ "pokename"] = enemy_name;
				array_push(
					global.nextdialog,
					{npc: "Battle", text: $"BreaksTheMold", onBattle: true}
				);
				pfs_debug_message($"{enemy_name} breaks the mold!");
			}

			break;
		case PFSTurnType.UseItem: //TODO: Ball shakes
			//switch (turnSteps[0][1].usetype) {
				//case UseType.PokeBall:
					//if (was_caught(enemyPokemon[enemyOut], turnSteps[0][1].catchrate)) {
						//show_debug_message(
							//$"[PFS] {enemyPokemon[enemyOut].internalName} was caught!"
						//);
						//spawn_dialog($"Caught");
						//array_push(PFS.playerPokemons, enemyPokemon[enemyOut]);
						//turnSteps = [];
						//doTurn = false;
						//caught = true;
					//}
					//break;
			//}
			break;
		case PFSTurnType.Run:
			escape_attempts++;
			PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(
				PFS.playerPokemons[pokemonOut]
			);
			if (PlayerTeam[pokemonOut].speed > enemyPokemon[enemyOut].speed) {
				ranaway = true;
			} else {
				var p = PlayerTeam[pokemonOut];
				var w = enemyPokemon[enemyOut];
				var odds =
					(((p.base.speed * 32) / (w.base.speed / 4)) + 30 * escape_attempts)
					/ 256;
				if (odds >= 1) {
					ranaway = true;
				}
			}
			#region Abilities
			var shadow_tag =
				__PFS_pokemon_have_ability(enemyPokemon[enemyOut], "Shadow Tag")
				&& !__PFS_pokemon_have_ability(PlayerTeam[pokemonOut], "Shadow Tag");
			var grounded = false; //TODO: https://bulbapedia.bulbagarden.net/wiki/Grounded
			var arenatrap = __PFS_pokemon_have_ability(
				enemyPokemon[enemyOut],
				"Arena Trap"
			);
			var magnet_pull =
				__PFS_pokemon_have_ability(enemyPokemon[enemyOut], "Magnet Pull")
				&& __PFS_pokemon_have_type(PlayerTeam[pokemonOut], __PFSTypes.Steel);
			var trapped = false; //TODO
			if (shadow_tag || (arenatrap && grounded) || magnet_pull || trapped) {
				ranaway = false;
			}
			if (__PFS_pokemon_have_ability(PlayerTeam[pokemonOut], "run-away")) {
				ranaway = true;
			}
			#endregion
			if (!canflee) {
				ranaway = false;
			}
			if (ranaway || forceflee) {
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

function __PFS_turn_end() {}

#region Battle functions

function __PFS_enemy_alive() {
	//var battle = NewFightSystem;
	//var enemy = battle.enemy_pokemon_out;
	if (EnemyTeam[foe_out].hp > 0) {
		return true;
	}
	return false;
}

function __PFS_order_turn() {
	array_sort(turn_steps, function(elm1, elm2) {
		var _goAfter = false;
		if (elm1.type == PFSTurnType.Move && elm2.type == PFSTurnType.Move) {
			var p1 = variable_clone(elm1);
			var p2 = variable_clone(elm2);
			#region Paralysis
			if (__PFS_pokemon_affected_by_status(p1.pokemon, PFSStatusAilments.Paralysis)) {
				p1.pokemon.speed = p1.pokemon.speed * 0.5;
			}
			if (__PFS_pokemon_affected_by_status(p2.pokemon, PFSStatusAilments.Paralysis)) {
				p2.pokemon.speed = p2.pokemon.speed * 0.5;
			}
			#endregion
			if (p1.pokemon.speed < p2.pokemon.speed) {
				_goAfter = true;
				pfs_debug_message(
					$"{p2.pokemon.internalName}:{p2.pokemon.speed} is faster than {
						p1.pokemon.internalName
					}:{p1.pokemon.speed}, going first!"
				);
			}
			if (p1.move.priority > p2.move.priority) {
				_goAfter = false;
				pfs_debug_message(
					$"{p1.pokemon.internalName}:{p1.move.internalName}:{
						p1.move.priority
					} has higher priority than {p2.pokemon.internalName}:{p2.move.internalName}:{
						p2.move.priority
					}, going first!"
				);
			}
		} else {
			_goAfter = elm1.type < elm2.type; //TODO: the hell?
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
