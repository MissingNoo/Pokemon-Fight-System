//Feather disable GM2017
#macro GW display_get_gui_width()
#macro GH display_get_gui_height()
#macro DEBUG if (global.debug) {
#macro ENDDEBUG }
global.__PFS = {};
#macro PFS global.__PFS
PFS.playerPokemons = [];
PFS.moves = [];
PFS.move_flags = [];
PFS.PokeSpecies = [];
PFS.Pokes = [];
PFS.Abilities = [];
PFS.__PFSTypes = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy", "NoType"];
PFS.PFSMoveCategory = [["Physical", sPFSPhysicalIcon], ["Special", sPFSSpecialIcon], ["Status", sPFSStatusIcon]];
PFS.StatusAilments = [];
PFS.StatusAilmentsData = [];
PFS.Natures = [[0]];
PFS.Initialized = false;
PFS.NatureStatusNames = [
 "",
 "",
 "attack",
 "defense",
 "spattack",
 "spdefense",
 "speed"
]
PFS.GrowthRates = [];
enum __PFSStatId {
	Attack = 2,
	Defense = 3,
	SPAtk = 4,
	SPDef = 5,
	Speed = 6,
}
enum PFSTurnType {
	Move,
	ChangePokemon,
	EnemyChangePokemon,
	UseItem,
	Run
}

enum PFSBattleBackground {
	Normal,
	Grass,
	Water,
	Cave,
	Wet,
	Ice,
	Ground,
	Idk1,
	Idk2,
	Idk3
}

enum __PFSTypes {
	Normal, 
	Fire, 
	Water, 
	Grass, 
	Flying, 
	Fighting, 
	Poison, 
	Electric, 
	Ground, 
	Rock, 
	Psychic, 
	Ice, 
	Bug, 
	Ghost, 
	Steel, 
	Dragon, 
	Dark, 
	Fairy,
	NoType
	//Normal = 1, 
	//Fire = 10, 
	//Water = 11, 
	//Grass = 12, 
	//Flying = 3, 
	//Fighting = 2, 
	//Poison = 4, 
	//Electric = 13, 
	//Ground = 5, 
	//Rock = 6, 
	//Psychic = 14, 
	//Ice = 15, 
	//Bug = 7, 
	//Ghost = 8, 
	//Steel = 9, 
	//Dragon = 16, 
	//Dark = 17, 
	//Fairy = 18,
	//NoType = 0
};
	
enum PFSMoveCategory {
	Physical,
	Special,
	Status
}
	
enum PFSMoveMethods {
	Null,
	Levelup
}
	
enum PFSBattleMenus {
	Battle,
	Item,
	Pokemon,
	Run
}
	
enum PFSBattleSides {
	Player,
	Enemy
}
	
enum PFSStatusAilments {
	None,
	Paralysis,
	Sleep,
	Freeze,
	Burn,
	Poison,
	Confusion,
	Infatuation,
	Trap,
	Nightmare,
	Torment,
	Disable,
	Yawn,
	Heal_block,
	No_type_immunity = 16,
	Leech_seed = 18,
	Embargo = 19,
	Perish_song = 20,
	Ingrain = 21,
	Silence = 22,
	Tar_shot = 43,
}
	
#region Move effectiveness
PFS.typesEffect = [];
PFS.typesEffect[__PFSTypes.Normal] = {
	strong : [],
	weak : [__PFSTypes.Fighting],
	immune : [__PFSTypes.Ghost]
};
PFS.typesEffect[__PFSTypes.Fire] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Grass, __PFSTypes.Ice, __PFSTypes.Bug, __PFSTypes.Steel, __PFSTypes.Fairy],
	weak : [__PFSTypes.Water, __PFSTypes.Ground, __PFSTypes.Rock],
	immune : []
};
PFS.typesEffect[__PFSTypes.Water] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Water, __PFSTypes.Ice, __PFSTypes.Steel],
	weak : [__PFSTypes.Electric, __PFSTypes.Grass],
	immune : []
};
PFS.typesEffect[__PFSTypes.Grass] = {
	strong : [__PFSTypes.Water, __PFSTypes.Electric, __PFSTypes.Grass, __PFSTypes.Ground],
	weak : [__PFSTypes.Fire, __PFSTypes.Ice, __PFSTypes.Poison, __PFSTypes.Flying, __PFSTypes.Bug],
	immune : []
};
PFS.typesEffect[__PFSTypes.Flying] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Bug],
	weak : [__PFSTypes.Electric, __PFSTypes.Ice, __PFSTypes.Rock],
	immune : [__PFSTypes.Ground]
};
PFS.typesEffect[__PFSTypes.Fighting] = {
	strong : [__PFSTypes.Bug, __PFSTypes.Rock, __PFSTypes.Dark],
	weak : [__PFSTypes.Flying, __PFSTypes.Psychic, __PFSTypes.Fairy],
	immune : []
};
PFS.typesEffect[__PFSTypes.Poison] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Poison, __PFSTypes.Bug, __PFSTypes.Fairy],
	weak : [__PFSTypes.Ground, __PFSTypes.Psychic],
	immune : []
};
PFS.typesEffect[__PFSTypes.Electric] = {
	strong : [__PFSTypes.Electric, __PFSTypes.Flying, __PFSTypes.Steel],
	weak : [__PFSTypes.Ground],
	immune : []
};
PFS.typesEffect[__PFSTypes.Ground] = {
	strong : [__PFSTypes.Poison, __PFSTypes.Rock],
	weak : [__PFSTypes.Water, __PFSTypes.Grass, __PFSTypes.Ice],
	immune : [__PFSTypes.Electric]
};
PFS.typesEffect[__PFSTypes.Rock] = {
	strong : [__PFSTypes.Normal, __PFSTypes.Fire, __PFSTypes.Poison, __PFSTypes.Flying],
	weak : [__PFSTypes.Water, __PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Ground, __PFSTypes.Steel],
	immune : []
};
PFS.typesEffect[__PFSTypes.Psychic] = {
	strong : [__PFSTypes.Fighting, __PFSTypes.Psychic],
	weak : [__PFSTypes.Bug, __PFSTypes.Ghost, __PFSTypes.Dark],
	immune : []
};
PFS.typesEffect[__PFSTypes.Ice] = {
	strong : [__PFSTypes.Ice],
	weak : [__PFSTypes.Fire, __PFSTypes.Fighting, __PFSTypes.Rock, __PFSTypes.Steel],
	immune : []
};
PFS.typesEffect[__PFSTypes.Bug] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Ground],
	weak : [__PFSTypes.Fire, __PFSTypes.Flying, __PFSTypes.Rock],
	immune : []
};
PFS.typesEffect[__PFSTypes.Ghost] = {
	strong : [__PFSTypes.Poison, __PFSTypes.Bug],
	weak : [__PFSTypes.Ghost, __PFSTypes.Dark],
	immune : [__PFSTypes.Normal, __PFSTypes.Fighting]
};
PFS.typesEffect[__PFSTypes.Steel] = {
	strong : [__PFSTypes.Normal, __PFSTypes.Grass, __PFSTypes.Ice, __PFSTypes.Flying, __PFSTypes.Psychic, __PFSTypes.Bug, __PFSTypes.Rock, __PFSTypes.Dragon, __PFSTypes.Steel, __PFSTypes.Fairy],
	weak : [__PFSTypes.Fire, __PFSTypes.Fighting, __PFSTypes.Ground],
	immune : [__PFSTypes.Poison]
};
PFS.typesEffect[__PFSTypes.Dragon] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Water, __PFSTypes.Electric, __PFSTypes.Grass],
	weak : [__PFSTypes.Ice, __PFSTypes.Dragon, __PFSTypes.Fairy],
	immune : []
};
PFS.typesEffect[__PFSTypes.Dark] = {
	strong : [__PFSTypes.Ghost, __PFSTypes.Dark],
	weak : [__PFSTypes.Fighting, __PFSTypes.Bug, __PFSTypes.Fairy],
	immune : [__PFSTypes.Psychic]
};
PFS.typesEffect[__PFSTypes.Fairy] = {
	strong : [__PFSTypes.Fighting, __PFSTypes.Bug, __PFSTypes.Dark],
	weak : [__PFSTypes.Poison, __PFSTypes.Steel],
	immune : [__PFSTypes.Dragon]
};
PFS.typesEffect[__PFSTypes.NoType] = {
	strong : [],
	weak : [],
	immune : []
};
#endregion

function __PFS_is_effective(pokemon, move, pos){
	var _movetype = move.type;
	var _poketype = pokemon.type[pos];
	var _effective = -1;
	if (_effective == -1) {
	    _effective = array_get_index(PFS.typesEffect[_poketype].strong, _movetype) >= 0 ? 0.5 : -1;
	}
	if (_effective == -1) {
		_effective = array_get_index(PFS.typesEffect[_poketype].weak, _movetype) >= 0 ? 2 : -1;
	}
	if (_effective == -1) {
	    _effective = array_get_index(PFS.typesEffect[_poketype].immune, _movetype) >= 0 ? 0 : -1;
	}
	if (_effective == -1) {
	    _effective = 1;
	}
	return _effective;
}

function __PFS_add_move(id_or_name){
	var _move = variable_clone(PFS.moves[1]);
	for (var i = 1; i < array_length(PFS.moves); ++i) {
	    if (PFS.moves[i][$ "identifier"] == id_or_name) {
		    _move = variable_clone(PFS.moves[i]);
		}
		if (PFS.moves[i][$ "id"] == id_or_name) {
		    _move = variable_clone(PFS.moves[id_or_name]);
		}
	}
	return _move;
}

function __PFS_apply_status(pokemon, status, turns = -99){
	if (__PFS_pokemon_affected_by_status(pokemon, status)) {
	    exit;
	}
	if (__PFS_pokemon_have_type(pokemon, __PFSTypes.Fire) and status == PFSStatusAilments.Burn) {
		show_debug_message($"{pokemon.identifier} is immune to Burn!");
		exit;
	}
	if (__PFS_pokemon_have_type(pokemon, __PFSTypes.Electric) and status == PFSStatusAilments.Paralysis) {
		show_debug_message($"{pokemon.identifier} is immune to Paralysis!");
		exit;
	}
	array_push(pokemon.statusAilments, [status, turns]);
}

function __PFS_remove_status(pokemon, status){
	for (var i = array_length(pokemon.statusAilments) - 1; i >= 0; --i) {
	    if (pokemon.statusAilments[i] == status) {
		    array_delete(pokemon.statusAilments, i, 1);
		}
	}
	return pokemon;
}

function __PFS_pokemon_affected_by_status(pokemon, status_id) {
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    if (pokemon.statusAilments[i][0] == status_id) {
		    return true;
		}
	}
	return false;
}

function __PFS_use_move(pokemon, enemy, move, side) {
	var battle = PFSFightSystem;
	var pokemonOut = battle.pokemonOut;
	var enemyOut = battle.enemyOut;
	if (pokemon.hp <= 0) { return; }
	var result = {
		damage : undefined,
		status : undefined,
		ability_status : undefined,
		affect_user : undefined,
		critical : undefined,
		pokemon : undefined,
		enemy : undefined
	};
	var _appliedStatus = "";
	result = __PFS_damage_calculation(pokemon, enemy, move);
	if (result.critical) {
		array_push(global.nextdialog, {npc : "Battle", text : $"Critical", onBattle : true});
	}
	//Apply status
	if (result.status != 0 and !__PFS_pokemon_affected_by_status(enemy, result.status[0])) {
	    _appliedStatus = $"{_appliedStatus} and applied {PFS.StatusAilments[result.status[0]]} status!";
		__PFS_apply_status(enemy, result.status[0], result.status[1]);
	}
	show_debug_message(string_concat($"{pokemon.identifier} used move {move.identifier}!", result.damage > 0 ? $" dealing {result.damage} damage!" : "", $" {_appliedStatus}"));
	//if (result.affect_user != false) { // Move that affects the user (Perish Song)
	//	pokemon = result.affect_user;
	//}
	
	switch (side) {
		case PFSBattleSides.Player:
			EnemyTeam[enemyOut].hp -= result.damage;
			if (EnemyTeam[enemyOut].hp <= 0) {
				EnemyTeam[enemyOut].hp = 0;
				show_debug_message($"{EnemyTeam[enemyOut].identifier} died");
				array_push(global.nextdialog, {npc : "Battle", text : $"EnemyPokemonFainted", onBattle : true});
				if (battle.lastEnemyUsedMove == __PFS_get_move_id("Destiny Bond")) {
					battle.lastEnemyUsedMove = 0;
					PlayerTeam[pokemonOut].hp = 0;
					show_debug_message($"{PlayerTeam[pokemonOut].identifier} died together due to {EnemyTeam[enemyOut].identifier}'s Destiny Bond!");
				}
			}
			break;
		case PFSBattleSides.Enemy:
			PlayerTeam[PFSFightSystem.pokemonOut].hp -= result.damage;
            if (PlayerTeam[PFSFightSystem.pokemonOut].hp <= 0) { 
                show_debug_message($"{PlayerTeam[PFSFightSystem.pokemonOut].identifier} died");
				battle.enemyDead = true;
				if (battle.lastUsedMove == __PFS_get_move_id("Destiny Bond")) {
					battle.lastUsedMove = 0;
					EnemyTeam[enemyOut].hp = 0;
					show_debug_message($"{EnemyTeam[enemyOut].identifier} died together due to {PlayerTeam[pokemonOut].identifier}'s Destiny Bond!");
				}
				PlayerTeam[pokemonOut].hp = 0; 
			}
			break;
	}
	if (move[$ "code"] != undefined) {
		move[$ "code"](pokemon, enemy);
	}
}

function __PFS_pokemon_have_type(pokemon, type) {
	return array_contains(pokemon.type, type);
}

function __PFS_damage_calculation(pokemon, enemy, _move){
	#region Start Variables
	var move = variable_clone(_move);
	var _damage = 0;
	var _affectUser = false;
	var _status = 0;
	var _ability_status = 0;
	var _critChance = __PFS_rng(0, 255);
	var _critTreshold = pokemon.speed / 2; //TODO: High crit chance atk and items
	var _isCritical = _critChance <= _critTreshold ? 2 : 1; //TODO _isCritical = 1 if target ability is Battle Armor or Shell Armor or with Luck Chant
	#region Tests
	if (global.testing) { // Do not crit if running tests
		if (global.testingforcecrit) {
		    _isCritical = 2;
		}
	    else {
			_isCritical = 1;
		}
	}
	#endregion
	var _level = real(pokemon.level);
	var _power  = 0;
	try { _power = real(move.mpower); } catch (err) { }
	#endregion
	#region Abilities
	for (var i = 0; i < array_length(pokemon.ability); ++i) {
		if (pokemon.ability[i][1] == 1) { continue; }
		if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.Start) {
			var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, _isCritical, _damage);
			_status = _abresult.status;
			_isCritical = _abresult.critical;
			_damage = _abresult.damage;
		}
	}
	for (var i = 0; i < array_length(enemy.ability); ++i) {
		if (enemy.ability[i][1] == 1) { continue; }
		if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.Start) {
			var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(enemy, pokemon, move, _status, _isCritical, _damage);
			_status = _abresult.status;
			_isCritical = _abresult.critical;
			_damage = _abresult.damage;
		}
	}
	#endregion
	var _stab = array_get_index(pokemon.type, move.type) != -1 ? 1.5 : 1;
	var _type1 = __PFS_is_effective(enemy, move, 0);
	var _type2 = array_length(enemy.type) > 1 ? __PFS_is_effective(enemy, move, 1) : 1;
	var _type = 1 * _type1 * _type2;
	var _rnd = __PFS_rngr(0.85, 1);
	var _burn = move.category == PFSMoveCategory.Physical and __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Burn) and !__PFS_pokemon_have_ability(pokemon, "guts") ? 0.5 : 1; //TODO: don't affect fixed damage moves like Foul Play and ignore if its ability is guts
	DEBUG
		if (move.category == PFSMoveCategory.Physical and __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Burn) and __PFS_pokemon_have_ability(pokemon, "guts")) {
		    show_debug_message("Burn damage halving ignored by Guts ability")
		}
		if (_burn != 1) {
		    show_debug_message($"{pokemon.identifier} damage is halved because it's burning");
		}
	ENDDEBUG
	#region //TODO
	var _targets = 1; //TODO: 0.75 if more than one target (0.5 in battle royale)
	var _pb = 1; //TODO: Parental Bond second hit = 0.25
	var _weather = 1 //TODO: Weather
	var _glaiverush = 1; //TODO: Glaive Rush = 2 if the move was used in the previous turn
	var _other = 1;
	#endregion
	var _a = 1;
	var _d = 1;
	switch (move.category) { //TODO: unmodified on criticals, light screen, reflect, 
	    case PFSMoveCategory.Physical:
	        _a = pokemon.attack;
			_d = enemy.defense;
			//var _result = __PFS_ability_on_contact(pokemon, enemy, move); //TODO: change to new system
			//pokemon = _result[0];
			//enemy = _result[1];
			//_ability_status = _result[2];
	        break;
	    case PFSMoveCategory.Special:
			_a = pokemon.spattack;
			_d = enemy.spdefense;
			break;
	}
	if (move.category == PFSMoveCategory.Status or move.effect_chance != "") {
		var _chance = __PFS_rng();
		if (move.category == PFSMoveCategory.Status or _chance <= move.effect_chance) {
			_isCritical = 1;
			var _turns = -99;
			var _effectData = PFS.StatusAilmentsData[move.id];
			_turns = irandom_range(_effectData.min_turns, _effectData.max_turns);
			if (_effectData.max_turns == 0) {
				_turns = -99;
			}
			_status = [real(PFS.StatusAilmentsData[move.id].meta_ailment_id), _turns];
		}
	}
	if (_a > 255 or _d > 255) {
	    _a = floor(_a / 4);
	    _d = floor(_d / 4);
	}
	#region Right before damage calculation
		#region Abilities
		for (var i = 0; i < array_length(pokemon.ability); ++i) {
			if (pokemon.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.BeforeDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, _isCritical, _damage);
				_status = _abresult.status;
				_isCritical = _abresult.critical;
				_damage = _abresult.damage;
			}
		}
		for (var i = 0; i < array_length(enemy.ability); ++i) {
			if (enemy.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.BeforeDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(enemy, pokemon, move, _status, _isCritical, _damage);
				_status = _abresult.status;
				_isCritical = _abresult.critical;
				_damage = _abresult.damage;
			}
		}
		#endregion
	#endregion
	_damage = ( ( ( 2 * _level / 5 + 2) * _power * (_a / _d) ) / 50 + 2 );
	_damage = _damage * _targets * _pb * _weather * _glaiverush * _isCritical * _rnd * _stab * _type * _burn * _other;
	_damage = round(_damage);
	if (_power == 0) { _damage = 0; }
	#region Right after damage calculation
		#region Abilities
		for (var i = 0; i < array_length(pokemon.ability); ++i) {
			if (pokemon.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.AfterDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, _isCritical, _damage);
				_status = _abresult.status;
				_isCritical = _abresult.critical;
				_damage = _abresult.damage;
			}
		}
		for (var i = 0; i < array_length(enemy.ability); ++i) {
			if (enemy.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.AfterDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(enemy, pokemon, move, _status, _isCritical, _damage);
				_status = _abresult.status;
				_isCritical = _abresult.critical;
				_damage = _abresult.damage;
			}
		}
		#endregion
		#region Items
			#region Focus Sash
			#endregion
		#endregion
	#endregion
	
	//show_debug_message($"Dealt ( ( ( 2 * {_level} / 5 + 2) * {_power} * ({_a} / {_d}) ) / 50 + 2 )  * {_targets} * {_pb} * {_weather} * {_glaiverush} * {_isCritical} * {_rnd} * {_stab} * {_type} * {_burn} * {_other} = {_damage} damage");
	
	return {
		damage : _damage,
		status : _status,
		ability_status : _ability_status,
		affect_user : _affectUser,
		critical : _isCritical == 2 ? true : false,
		pokemon : pokemon,
		enemy : enemy
	};
}

function __PFS_generate_pokemon(poke){
	var pokemon = variable_clone(poke);
	pokemon.level = irandom_range(real(pokemon.wildlevelrange[0]), real(pokemon.wildlevelrange[1]));
	pokemon.moves = [];
	for (var i = 0; i < array_length(pokemon.canLearn.level); ++i) {
	    if (array_length(pokemon.moves) < 4) {
		    if (pokemon.canLearn.level[i].level < pokemon.level) {
			    array_push(pokemon.moves, __PFS_add_move(pokemon.canLearn.level[i].id));
			}
		}
	}
	pokemon.ivs = {
		hp : irandom_range(0, 31),
		attack : irandom_range(0, 31),
		defense : irandom_range(0, 31),
		spattack : irandom_range(0, 31),
		spdefense : irandom_range(0, 31),
		speed : irandom_range(0, 31),
		accuracy : irandom_range(0, 31),
		evasion : irandom_range(0, 31)
	}
	pokemon.evs = {
		hp : 0,
		attack : 0,
		defense : 0,
		spattack : 0,
		spdefense : 0,
		speed : 0,
		accuracy : 0,
		evasion : 0
	}
	pokemon.statusAilments = [];
	if (pokemon.ability[0][0] != 0 and pokemon.ability[1][0] != 0) {
		var _rnd = __PFS_rng(0, 1);
	    //show_message($"multiple abilities \n{pokemon.ability}\nkeeping {pokemon.ability[_rnd][0]}");
		switch (_rnd) {
		    case 0:
		        pokemon.ability[1][0] = 0;
		        break;
		    case 1:
		        pokemon.ability[0][0] = 0;
		        break;
		}
	    //show_message($"{pokemon.ability}");
	}
	pokemon.nature = PFS.Natures[irandom_range(1, array_length(PFS.Natures) - 1)].id;
	return __PFS_recalculate_stats(pokemon, true);
}

function __PFS_get_flag_id(flag) {
	return array_get_index(PFS.move_flags, string_lower(flag));
}

function __PFS_move_have_flag(move, flag) {
	var pos = array_get_index(move.flags, __PFS_get_flag_id(flag));
	return pos != -1
}

function __PFS_recalculate_stats(pokemon, pokecenter = false){
	if (pokemon[$ "base"] == undefined) {
	    pokemon[$ "base"] = {};
	}
	var _names = variable_struct_get_names(pokemon.basecalc);
	for (var i = 0; i < array_length(_names); ++i) {
		switch (_names[i]) {
		    case "hp":
		        variable_struct_set(pokemon.base, "hp", floor(0.01 * (2 * real(pokemon.basecalc.hp) + real(pokemon.ivs.hp) + floor(0.25 * real(pokemon.evs.hp))) * real(pokemon.level)) + real(pokemon.level) + 10);
				if (pokecenter) {
				    variable_struct_set(pokemon, "hp", floor(0.01 * (2 * real(pokemon.basecalc.hp) + real(pokemon.ivs.hp) + floor(0.25 * real(pokemon.evs.hp))) * real(pokemon.level)) + real(pokemon.level) + 10);
					pokemon.statusAilments = [];
				}
		        break;
		    default:
				var _basestat = variable_struct_get(pokemon.basecalc, _names[i]);
				var _iv = variable_struct_get(pokemon.ivs, _names[i]);
				var _ev = variable_struct_get(pokemon.evs, _names[i]);
				var _nature = pokemon.nature; //TODO: nature
				var increase_multiplier = 0;
				var decrease_multiplier = 0;
				if (PFS.NatureStatusNames[PFS.Natures[_nature].increased_stat_id] == _names[i]) {
				    increase_multiplier = 10;
				}
				if (PFS.NatureStatusNames[PFS.Natures[_nature].decreased_stat_id] == _names[i]) {
				    decrease_multiplier = 10;
				}
		        variable_struct_set(pokemon.base, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				pokemon.base[$ _names[i]] += (pokemon.base[$ _names[i]] * increase_multiplier) / 100;
				pokemon.base[$ _names[i]] -= (pokemon.base[$ _names[i]] * decrease_multiplier) / 100;
				pokemon.base[$ _names[i]] = round(pokemon.base[$ _names[i]]);				
				if (pokecenter) {
				    variable_struct_set(pokemon, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				}
		        break;
		}
	}
	if (pokecenter) {
		pokemon.taunted = false;
	    for (var i = 0; i < array_length(pokemon.moves); ++i) {
		    pokemon.moves[i].pp = pokemon.moves[i].maxpp;
		}
	}
	//show_debug_message($"{pokemon.identifier}: {json_stringify(pokemon)}");
	//show_debug_message("");
	return pokemon;
}

#region Abilities
function __PFS_get_ability_id(name) {
	name = string_replace_all(string_lower(name), " ", "-");
	for (var i = 0; i < array_length(PFS.Abilities); ++i) {
	    if (string_lower(PFS.Abilities[i][$ "identifier"]) == name) {
		    return i;
		}
	}
	show_debug_message($"Ability {name} not found");
	return -1;
}
	
function __PFS_pokemon_have_ability(pokemon, abilityname){
	abilityname = string_lower(string_replace(abilityname, " ", "-"));
	var _ability_id = __PFS_get_ability_id(abilityname);
	for (var i = 0; i < array_length(pokemon.ability); ++i) {
	    if (pokemon.ability[i][0] == _ability_id and pokemon.ability[i][1] == 0) {
		    return true;
		}
	}
	return false;
}

function __PFS_ability_before_move(pokemon, move){
	
}

//function __PFS_ability_before_contact(pokemon, enemy){
//	for (var i = 0; i < array_length(pokemon.ability); ++i) {
//	    if (pokemon.ability[i][0] == __PFS_get_ability_id("indentifier")) {
//		}
//	}
//	return [pokemon, enemy];
//}

function __PFS_ability_on_contact(pokemon, enemy, move){//TODO:
	show_debug_message("TODO");
	//var _status = 0;
	//var _chance = __PFS_rng();
	//if (__PFS_pokemon_have_ability(pokemon, "stench")) {
	//    if (_chance <= 10 and move.mpower > 0) {
	//		enemy.flinch = true;
	//	}
	//}
	//if (__PFS_pokemon_have_ability(pokemon, "poison-touch")) {
	//    if (_chance <= 30) {
	//		var _counters = ["shield-dust", "immunity"];
	//		var _counter_ability = "";
	//		var _countered = false;
	//		for (var i = 0; i < array_length(_counters); ++i) {
	//		    if (__PFS_pokemon_have_ability(enemy, _counters[i])) {
	//				_counter_ability = _counters[i];
	//				_countered = true;
	//				break;
	//			}
	//		}
	//		if (!_countered){
	//			_status = [PFSStatusAilments.Poison, -1, "Poison Touch"];
	//		}
	//		else {
	//			show_debug_message($"{pokemon.identifier}'s Poison Touch canceled by {enemy.identifier}'s {_counter_ability}");
	//		}
	//	}
	//}
	//return [pokemon, enemy, _status];
}
#endregion

function __PFS_get_move_id(name) {
	var oname = name
	name = string_replace_all(string_lower(name), " ", "-");
	//show_message(name);
	for (var i = 0; i < array_length(PFS.moves); ++i) {
		var identifier = PFS.moves[i][$ "identifier"];
	    if (identifier == name or identifier == oname) {
		    return PFS.moves[i].id;
		}
	}
	show_debug_message("Move id not found");
	return 0;
}

#region Status Effects
function __PFS_count_status_effect(pokemon, side) {
	var _status = PFSStatusAilments.None;
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    _status = pokemon.statusAilments[i][0];
		if (pokemon.statusAilments[i][1] != -99) {
			pokemon.statusAilments[i][1] -= 0.5;
			show_debug_message($"{pokemon.identifier}'s {pokemon.statusAilments[i][0]} diminished by one");
		}
	}
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
		_status = pokemon.statusAilments[i][0];
		if (pokemon.statusAilments[i][1] <= 0 and pokemon.statusAilments[i][1] != -99) {
			switch (_status) {
			    case PFSStatusAilments.Perish_song:
					switch (side) {
					    case PFSBattleSides.Player:
					        pokePlayerDead = true;
					        break;
					    case PFSBattleSides.Enemy:
					        enemyDead = false;
							for (var j = 0; j < array_length(PFSFightSystem.enemyPokemon); ++j) {
								if (PFSFightSystem.enemyPokemon[j].hp > 0 and j != PFSFightSystem.enemyOut) {
									array_push(PFSFightSystem.turnSteps, [PFSTurnType.EnemyChangePokemon, j]);
									show_debug_message("Enemy died, changing");
								}
							}
					        break;
					}
					show_debug_message($"{pokemon.identifier} fainted due to Perish Song!");
					DialogData[$ "pokename"] = pokemon.identifier;
					spawn_dialog("PerishSong");
					pokemon.hp = 0;
					break;
			    case PFSStatusAilments.Sleep:
			        show_debug_message($"{pokemon.identifier} woke up!");
			        break;
			    default:
			        show_debug_message($"{pokemon.identifier} {PFS.StatusAilments[pokemon.statusAilments[i][0]]} status ran out!");
			        break;
			}			
			array_delete(pokemon.statusAilments, i, 1);
			continue;
		}
	}
	return pokemon;
}

function __PFS_tick_status_effect(pokemon) {
	pokemon.flinch = false;
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    var _status = pokemon.statusAilments[i][0];
		var _statusName = PFS.StatusAilments[_status];
		var _hploss = 0;
		switch (_status) {
		    case PFSStatusAilments.Burn:
				_hploss = round(pokemon.hp / 16);
		        break;
		    case PFSStatusAilments.Poison:
				_hploss = round(pokemon.hp / 8);
		        break;
		}
		if (_hploss != 0) {
		    pokemon.hp -= _hploss;
			global.dialogdata[$"pokename"] = pokemon.identifier;
			global.dialogdata[$"damage"] = _hploss;
			global.dialogdata[$"statusname"] = _statusName;
			array_push(global.nextdialog, {npc : "Battle", text : $"StatusDamage", onBattle : true});
			show_debug_message($"{pokemon.identifier} lost {_hploss}hp due to {_statusName}");
		}
	}
	return pokemon;
}
#endregion

#region Functions
function createbutton(_x, _y, text, textscale, show_border = true, bgalpha = 0.25, _color = c_white) {
	var _clicked = false;
	var w = string_width(text) * textscale;
	var h = string_height(text) * textscale;	
	draw_set_color(c_black);
	draw_set_alpha(bgalpha);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, false);
	}
	draw_set_color(c_white);
	draw_set_alpha(1);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_text_transformed_color(_x, _y, text, textscale, textscale, 0, _color, _color, _color, _color, 1);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function createbuttonspr(_x, _y, spr, subimg, sprscale, show_border = true, _color = c_white, align = "topleft", button = mb_left) {
	var _clicked = false;
	var pw = 0;
	var ph = 0;
	var w = sprite_get_width(spr) * sprscale;
	var h = sprite_get_height(spr) * sprscale;
	switch (align) {
	    case "middlecenter":
			w = w / 2;
			h = h / 2;
			ph = h;
			pw = w
	        break;
	    default:
	        // code here
	        break;
	}
	if (show_border) {
	    draw_rectangle(_x - pw - 3, _y - ph - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_sprite_ext(spr, subimg, _x, _y, sprscale, sprscale, 0, _color, 1);
	if (mouse_check_button_pressed(button) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x - pw, _y - ph, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function textbox(x, y, name, value, editing) {
	var _x = x;
	var _y = y;
	var _value = variable_instance_get(self, value);
	var _set = variable_instance_get(self, "set");
	if (editing) {
		if (!_set) {
		    keyboard_string = _value;
			variable_instance_set(self, "set", true);
		}
		if (keyboard_string != "") {
		    variable_instance_set(self, value, keyboard_string);
		}
	}
	draw_text(_x, _y, $"{name}: ");
	_x += string_width($"{name}: ");
	draw_text(_x, _y, _value);
	var _color = editing ? c_yellow : c_white;
	draw_rectangle_color(_x, _y, _x + string_width(_value), _y + string_height(_value), _color, _color, _color, _color, true);
}	
#endregion
function spawn_dialog(text) {
	if (instance_exists(oDialog)) {
		array_push(global.nextdialog, {npc : "Battle", text : text, onBattle : true});
	    exit;
	}
	dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : "Battle", text, onBattle : true});
}

#region Trainers
global.trainers = [];
#macro Trainers global.trainers
function Trainer(_name, _sprite, _team) constructor {
	name = _name;
	sprite = _sprite;
	team = [];
	for (var i = 0; i < array_length(_team); ++i) {
	    array_push(team, __PFS_generate_pokemon(PFS.Pokes[_team[i]]));
	}
}

function populate_trainers(){
	array_push(Trainers, new Trainer("Gary", sGaryBody, [3, 6, 9]));
}
#endregion

function __PFS_rng(minv = 0, maxv = 100) {
	if (global.testingforcefail) {
	    return 100;
	}
	if (global.testing) {
		return 1;
	}
	return irandom_range(minv, maxv);
}

function __PFS_rngr(minv = 0, maxv = 100) {
	if (global.testing and !global.testingrandomdamage) {
		return 1;
	}
	return random_range(minv, maxv);
}

function __PFS_debug_msg(str) {
	show_debug_message("[PFS] " + str);
}
	
function __PFS_get_growth_rate(pokemon) {
	show_debug_message(pokemon);
}