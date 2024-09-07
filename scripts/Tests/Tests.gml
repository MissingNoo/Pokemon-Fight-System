//Feather disable all
#macro runningtests false
#macro Tests:runningtests true
global.testing = runningtests;

function gen_enemy_poke(poke, level, move) {
	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[poke])];
	_enemyPokemon[0].level = level;
	_enemyPokemon[0].moves[0] = __PFS_add_move(move);
	_enemyPokemon[0] = __PFS_recalculate_stats(_enemyPokemon[0], true);
	return _enemyPokemon;
}

function set_player_poke(poke, level, move) {
	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[poke]);
	PFS.playerPokemons[0].level = level;
	PFS.playerPokemons[0].moves[0] = __PFS_add_move(move);
	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
}

function tests(){
	suite(function() {
		
		section("Status", function() {
			afterEach(function() {
				if (instance_exists(PFSFightSystem)) {
				    instance_destroy(PFSFightSystem);
				}
			});
			#region Paralysis
			test("Paralyze - Player", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Shield Dust|- Absorb");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(true);
			});
			
			test("Paralyze - Foe", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Shield Dust|- Absorb");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(true);
			});
			
			test("Paralyze - Player Immunity", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(false);
			});
			
			test("Paralyze - Enemy Immunity", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(false);
			});
			#endregion
		});
		
		section("Moves", function() {
			//test("Thunder Shock: Immunity", function() {
			//	var move = "Thunder Shock";
			//	var status = PFSStatusAilments.Paralysis;
			//	var enemy = [25, 1, move];
			//	set_player_poke(25, 1, move);
			//	_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
			//	with (_obj) {
			//		__PFS_use_move(PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0].moves[0], PFSBattleSides.Player);
			//	}
			//	expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(false);
			//	instance_destroy(_obj);
				
			//	var enemy = [25, 1, move];
			//	set_player_poke(25, 1, move);
			//	_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
			//	with (_obj) {
			//		__PFS_use_move(PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
			//	}
			//	expect(__PFS_pokemon_affected_by_status(PFS.playerPokemons[0], status)).toBe(false);
			//	instance_destroy(_obj);
			//});
			var tr = 0;
			repeat(3){
				tr++;
				test($"Lvl 50 Bulbasaur Vine Whip vs. Lvl 1 Weedle: Damage between 87-103 (Try {tr})", function() {
					var p1 = __PFS_generate_pokemon_from_showdown("Bulbasaur|Level: 50|Hardy Nature|Ability: Overgrow|- Vine Whip");
					var p2 = __PFS_generate_pokemon_from_showdown("Weedle|Level: 1|Hardy Nature|Ability: Shield Dust|- Absorb");
					var calculation = __PFS_damage_calculation(p1, p2, p1.moves[0], PFSBattleSides.Player);
					expect(calculation.damage).toBeBetween(87, 103);
				});
			}
		});
	});
}

function __PFS_set_pokemon_ivs(pokemon, hp, attack, defense, spatk, spdef, spd) {
	pokemon.ivs.hp = hp;
	pokemon.ivs.attack = attack;
	pokemon.ivs.defense = defense;
	pokemon.ivs.spattack = spatk;
	pokemon.ivs.spdefense = spdef;
	pokemon.ivs.speed = spd;
}

function __PFS_set_pokemon_evs(pokemon, hp, attack, defense, spatk, spdef, spd) {
	pokemon.evs.hp = hp;
	pokemon.evs.attack = attack;
	pokemon.evs.defense = defense;
	pokemon.evs.spattack = spatk;
	pokemon.evs.spdefense = spdef;
	pokemon.evs.speed = spd;
}

function __PFS_set_pokemon_nature(pokemon, nature) {
	var natureid = 0;
	for (var i = 1; i < array_length(PFS.Natures); ++i) {
	    if (PFS.Natures[i].identifier == string_lower(nature)) {
		    natureid = PFS.Natures[i].id;
			break;
		}
	}
	pokemon.nature = natureid;
}

function __PFS_set_pokemon_ability(pokemon, ability) {
	pokemon.ability = [
					[ __PFS_get_ability_id(string_lower(ability)), 0 ],
					[ 0, 1 ],
					[ 0, 1 ]
				];
}

function __PFS_get_poke_id(name) {
	for (var i = 0; i < array_length(PFS.Pokes); ++i) {
	    if (PFS.Pokes[i][$ "identifier"] == string_lower(name)) {
		    return PFS.Pokes[i].id;
		}
	}
	return -1;
}

function __PFS_generate_pokemon_from_showdown(export_string) {
	var pokedata = export_string;
	var data = string_split(string_replace(pokedata, "	", ""), "|");
	//[ "Charmander","Level: 5","Timid Nature","Ability: Blaze","EVs: 44 HP / 12 Def / 196 SpA / 236 Spe","IVs: 0 Atk","- Flamethrower","- Fire Blast","- Overheat","- Sleep Talk" ]
	var gen = __PFS_generate_pokemon(PFS.Pokes[__PFS_get_poke_id(data[0])]);
	gen.level = real(string_digits(data[array_find_index(data, function(e, i){return string_contains(e, "Level")})]));
	__PFS_set_pokemon_nature(gen, string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "Nature")})], " Nature", ""));
	__PFS_set_pokemon_ability(gen, string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "Ability")})], "Ability: ", ""));
	__PFS_set_pokemon_ivs(gen, 31, 31, 31, 31, 31, 31);
	var haveevs = array_find_index(data, function(e, i){return string_contains(e, "EVs")});
	if (haveevs != -1) {
	    var evs = string_split(string_replace(data[haveevs], "EVs: ", ""), "/");
		#region HP EV
		var ehp = 0;
		var c_ehp = array_find_index(evs, function(e, i) {
			return string_contains(e, "HP");
		})
		if (c_ehp != -1) {
			ehp = real(string_digits(evs[c_ehp]));
		}
		#endregion
		#region Atk EV
		var eatk = 0;
		var c_eatk = array_find_index(evs, function(e, i) {
			return string_contains(e, "Atk");
		})
		if (c_eatk != -1) {
			eatk = real(string_digits(evs[c_eatk]));
		}
		#endregion
		#region Def EV
		var edef = 0;
		var c_edef = array_find_index(evs, function(e, i) {
			return string_contains(e, "Def");
		})
		if (c_edef != -1) {
			edef = real(string_digits(evs[c_edef]));
		}
		#endregion
		#region SPAtk EV
		var espa = 0;
		var c_espa = array_find_index(evs, function(e, i) {
			return string_contains(e, "SpA");
		})
		if (c_espa != -1) {
			espa = real(string_digits(evs[c_espa]));
		}
		#endregion
		#region SPDef EV
		var espd = 0;
		var c_espd = array_find_index(evs, function(e, i) {
			return string_contains(e, "SpD");
		})
		if (c_espd != -1) {
			espd = real(string_digits(evs[c_espd]));
		}
		#endregion
		#region Speed EV
		var espe = 0;
		var c_espe = array_find_index(evs, function(e, i) {
			return string_contains(e, "Spe");
		})
		if (c_espe != -1) {
			espe = real(string_digits(evs[c_espe]));
		}
		#endregion
		__PFS_set_pokemon_evs(gen, ehp, eatk, edef, espa, espd, espe);
	}
	
	gen.moves = [ __PFS_add_move(string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "- ")})], "- ", ""))];
	gen = __PFS_recalculate_stats(gen, true);
	return gen;
}
	//test("Should move obj_Player to the right", function() {
	//	var _obj = create(0, 0, obj_player);
		
	//	simulateKeyHold(vk_right);
	//	simulateFrameWait(1);
	//	simulateKeyRelease(vk_right);
		
	//	expect(_obj.x).toBeGreaterThan(_obj.xstart);
		
	//	instance_destroy(_obj);
	//	});
		
	//	test("Should move obj_Player to the left", function() {
	//		var _obj = create(0, 0, obj_player);
			
	//		simulateKeyHold(vk_left);
	//		simulateFrameWait(1);
	//		simulateKeyRelease(vk_left);
	//		z
    //  expect(_obj.x).toBeLessThan(_obj.xstart);

    //  instance_destroy(_obj);
    //});