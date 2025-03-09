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
	    if (PFS.moves[i][$ "internalName"] == id_or_name) {
		    _move = variable_clone(PFS.moves[i]);
		}
		if (PFS.moves[i][$ "id"] == id_or_name) {
		    _move = variable_clone(PFS.moves[id_or_name]);
		}
	}
	return _move;
}

function __PFS_apply_status(pokemon, status, turns = -99){
	array_push(pokemon.statusAilments, [status, turns]);
	return pokemon;
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
	result = __PFS_damage_calculation(pokemon, enemy, move, side);
	//switch (side) {
		//case PFSBattleSides.Player: {
			//PlayerTeam[pokemonOut] = result.pokemon;
			//EnemyTeam[enemyOut] = result.enemy;
			//break; 
		//}
		//case PFSBattleSides.Enemy:{
			//PlayerTeam[pokemonOut] = result.enemy;
			//EnemyTeam[enemyOut] = result.pokemon;
			//break;
		//}
	//}
	if (result.critical) {
		array_push(global.nextdialog, {npc : "Battle", text : $"Critical", onBattle : true});
	}
	//Apply status
	if (result.status != 0 and !__PFS_pokemon_affected_by_status(enemy, result.status[0])) {
	    _appliedStatus = $"{_appliedStatus} and applied {PFS.StatusAilments[result.status[0]]} status!";
		__PFS_apply_status(enemy, result.status[0], result.status[1]);
	}
	show_debug_message(string_concat($"{pokemon.internalName} used move {move.internalName}!", result.damage > 0 ? $" dealing {result.damage} damage!" : "", $" {_appliedStatus}"));
	//if (result.affect_user != false) { // Move that affects the user (Perish Song)
		//pokemon = result.affect_user;
	//}
	
	switch (side) {
		case PFSBattleSides.Player:
			EnemyTeam[enemyOut].hp -= result.damage;
			if (EnemyTeam[enemyOut].hp <= 0) {
				EnemyTeam[enemyOut].hp = 0;
				show_debug_message($"{EnemyTeam[enemyOut].internalName} died");
				array_push(global.nextdialog, {npc : "Battle", text : $"EnemyPokemonFainted", onBattle : true});
				if (battle.lastEnemyUsedMove == __PFS_get_move_id("Destiny Bond")) {
					battle.lastEnemyUsedMove = 0;
					PlayerTeam[pokemonOut].hp = 0;
					show_debug_message($"{PlayerTeam[pokemonOut].internalName} died together due to {EnemyTeam[enemyOut].internalName}'s Destiny Bond!");
				}
			}
			break;
		case PFSBattleSides.Enemy:
			PlayerTeam[pokemonOut].hp -= result.damage;
			if (PlayerTeam[pokemonOut].hp <= 0) { 
				show_debug_message($"{PlayerTeam[pokemonOut].internalName} died");
				battle.enemyDead = true;
				if (battle.lastUsedMove == __PFS_get_move_id("Destiny Bond")) {
					battle.lastUsedMove = 0;
					EnemyTeam[enemyOut].hp = 0;
					show_debug_message($"{EnemyTeam[enemyOut].internalName} died together due to {PlayerTeam[pokemonOut].internalName}'s Destiny Bond!");
				}
				PlayerTeam[pokemonOut].hp = 0; 
			}
			break;
	}
}

function __PFS_pokemon_have_type(pokemon, type) {
	return array_contains(pokemon.type, type);
}

function __PFS_damage_calculation(pokemon, enemy, move, _side){
    //Critical
    var critChance = __PFS_rng(0, 255);
	var critTreshold = pokemon.speed / 2; //TODO: High crit chance atk and items
	var critical = critChance <= critTreshold ? 2 : 1; //TODO _isCritical = 1 if target ability is Battle Armor or Shell Armor or with Luck Chant
    if (global.testing) { // Do not crit if running tests
		if (global.testingforcecrit) {
		    critical = 2;
		}
	    else {
			critical = 1;
		}
	}
    //TODO: Conversely, unless critical hits are prevented entirely by one of the above effects, Critical will always be 1.5 (or 2 in Generation V) if the used move is Storm Throw, Frost Breath, Zippy Zap, Surging Strikes, Wicked Blow, or Flower Trick, the target is poisoned and the attacker's Ability is Merciless, or if the user is under the effect of Laser Focus.
    //
    var damage = 0;
    var _status = 0;
    var level = pokemon.level;
    //A
    var A = 1;
    var D = 1;
    switch (move.category) { //TODO: unmodified on criticals, light screen, reflect, (ignoring positive stat stages for a critical hit).
	    case PFSMoveCategory.Physical:
	        A = pokemon.attack;
			D = enemy.defense;
            //TODO: Contact abilities
	        break;
	    case PFSMoveCategory.Special:
			A = pokemon.spattack;
			D = enemy.spdefense; //TODO: move that uses the normal defense stat
			break;
	}
    if (move.category == PFSMoveCategory.Status or move.effect_chance != "") {
		var _chance = __PFS_rng();
		
		if (move.category == PFSMoveCategory.Status or _chance <= move.effect_chance) {
			critical = 1;
			var _turns = -99;
			var _effectData = PFS.StatusAilmentsData[move.id];
			_turns = irandom_range(_effectData.min_turns, _effectData.max_turns);
			if (_effectData.max_turns == 0) {
				_turns = -99;
			}
			_status = [real(PFS.StatusAilmentsData[move.id].meta_ailment_id), _turns];
			#region Status that affect the user 
            //TODO: make weapon functions
				#region Perish Song
					if (_status[0] == PFSStatusAilments.Perish_song) {
					    if (!__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Perish_song)) {
							if (__PFS_pokemon_have_ability(pokemon, "soundproof")) {
							    show_debug_message($"{pokemon.internalName}'s Soundproof ignored Perish Song!");
							}
							else {
								array_push(pokemon.statusAilments, _status);
								//_affectUser = pokemon;
							}
						}
					}
				#endregion
			#endregion
			#region Invulnerabilities to status effects
				#region Types
					#region Burn
						if (__PFS_pokemon_have_type(enemy, __PFSTypes.Fire) and PFS.StatusAilmentsData[move.id].meta_ailment_id == PFSStatusAilments.Burn) {
							show_debug_message($"{enemy.internalName} is immune to Burn!");
							_status = 0;
						}
					#endregion
					#region Paralysis
						if (__PFS_pokemon_have_type(enemy, __PFSTypes.Electric) and PFS.StatusAilmentsData[move.id].meta_ailment_id == PFSStatusAilments.Paralysis) {
							show_debug_message($"{enemy.internalName} is immune to Paralysis!");
							_status = 0;
						}
					#endregion
				#endregion
			#endregion
		}
	}
    //Move power
    var movepower = 0;
    try {
        movepower = real(move.mpower);
    }
    catch (error) { }
    //
    var targets = 1; //TODO: 0.75 if more than one target
    var PB = 1; //TODO: if it's the second hit of parental bond, set to 0.25;
    /*TODO: weather is 1.5 if a Water-type move is being used during rain 
    or a Fire-type move or Hydro Steam during harsh sunlight, 
    and 0.5 if a Water-type move (besides Hydro Steam) is used during harsh sunlight 
    or a Fire-type move during rain, 
    and 1 otherwise or if any Pokémon on the field have the Ability Cloud Nine or Air Lock.
    */
    var weather = 1; 
    var glaive_rush = 1; //TODO: set to 2 ig Glaive rush was used last turn
    #region Abilities before all
		for (var i = 0; i < array_length(enemy.ability); ++i) {
			if (enemy.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.Start) {
				var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
				_status = _abresult.status;
				critical = _abresult.critical;
				damage = _abresult.damage;
				move = _abresult.move;
			}
		}
		for (var i = 0; i < array_length(pokemon.ability); ++i) {
			if (pokemon.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.Start) {
				var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
				_status = _abresult.status;
				critical = _abresult.critical;
				damage = _abresult.damage;
				move = _abresult.move;
			}
		}
	#endregion
    var rnd = __PFS_rngr(0.85, 1);
    var STAB = array_get_index(pokemon.type, move.type) != -1 ? 1.5 : 1;
    if (__PFS_pokemon_have_ability(pokemon, "adaptability")) {
        STAB = 2;
    }
    //TODO: Terastilize things
	var _type1 = __PFS_is_effective(enemy, move, 0);
	var _type2 = array_length(enemy.type) > 1 ? __PFS_is_effective(enemy, move, 1) : 1;
	var type = 1 * _type1 * _type2;
	//TODO: type things
	var burn = (move.category == PFSMoveCategory.Physical and __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Burn) and !__PFS_pokemon_have_ability(pokemon, "guts")) ? 0.5 : 1; //TODO: don't affect fixed damage moves like Foul Play
    var oth = 1; //TODO: todo this
    #region Right before damage calculation
		#region Abilities
			for (var i = 0; i < array_length(enemy.ability); ++i) {
				if (enemy.ability[i][1] == 1) { continue; }
				if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.BeforeDamageCalculation) {
					var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
					_status = _abresult.status;
					critical = _abresult.critical;
					damage = _abresult.damage;
					move = _abresult.move;
				}
			}
			for (var i = 0; i < array_length(pokemon.ability); ++i) {
				if (pokemon.ability[i][1] == 1) { continue; }
				if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.BeforeDamageCalculation) {
					var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
					_status = _abresult.status;
					critical = _abresult.critical;
					damage = _abresult.damage;
					move = _abresult.move;
				}
			}
		#endregion
	#endregion
    var zmove = 1, tera_shield = 1;
    //Damage Calculation
    var step1 = ((2 * level) / 5) + 2;
    var step2 = ((step1 * movepower * (A/D)) / 50) + 2;
    damage = (step2) * targets * PB * weather * glaive_rush * critical * rnd * STAB * type * burn * oth * zmove * tera_shield;
    //
    #region Right after damage calculation
		#region Abilities
		for (var i = 0; i < array_length(enemy.ability); ++i) {
			if (enemy.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[enemy.ability[i][0]] != undefined and PFS.AbilitiesCode[enemy.ability[i][0]].when == AbilityTime.AfterDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[enemy.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
				_status = _abresult.status;
				critical = _abresult.critical;
				damage = _abresult.damage;
				move = _abresult.move;
			}
		}
		for (var i = 0; i < array_length(pokemon.ability); ++i) {
			if (pokemon.ability[i][1] == 1) { continue; }
			if (PFS.AbilitiesCode[pokemon.ability[i][0]] != undefined and PFS.AbilitiesCode[pokemon.ability[i][0]].when == AbilityTime.AfterDamageCalculation) {
				var _abresult = PFS.AbilitiesCode[pokemon.ability[i][0]].code(pokemon, enemy, move, _status, critical, damage, _side);
				_status = _abresult.status;
				critical = _abresult.critical;
				damage = _abresult.damage;
				move = _abresult.move;
			}
		}
		#endregion
		#region Items
			#region Focus Sash
			#endregion
		#endregion
	#endregion
    trace($"[PFS] Move did {damage} damage");
    return {
		damage : round(damage),
		status : _status,
		critical : critical == 2 ? true : false,
	};
	
}

function __PFS_generate_pokemon(poke){
	var pokemon = variable_clone(poke);
    pokemon.gender = choose(Gender.Male, Gender.Female);
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
    pokemon.shiny = irandom_range(1, 4096) == 1; //TODO: Locked shinies
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
	//show_debug_message($"{pokemon.internalName}: {json_stringify(pokemon)}");
	//show_debug_message("");
	return pokemon;
}

#region Abilities
function __PFS_get_ability_id(name) {
	name = string_replace_all(string_lower(name), " ", "-");
	for (var i = 0; i < array_length(PFS.Abilities); ++i) {
	    if (PFS.Abilities[i][$ "internalName"] == name or PFS.Abilities[i][$ "identifier"] == name) {
		    return i;
		}
	}
	show_debug_message($"Ability {name} not found");
	return 0;
}
	
function __PFS_pokemon_have_ability(pokemon, abilityname){
	abilityname = string_lower(string_replace(abilityname, " ", "-"));
	var _ability_id = __PFS_get_ability_id(abilityname);
	for (var i = 0; i < array_length(pokemon.ability); ++i) {
	    if (pokemon.ability[i][0] == _ability_id) {
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

function __PFS_ability_on_contact(pokemon, enemy, move){
	var _status = 0;
	var _chance = __PFS_rng();
	if (__PFS_pokemon_have_ability(pokemon, "stench")) {
	    if (_chance <= 10 and move.mpower > 0) {
			enemy.flinch = true;
		}
	}
	if (__PFS_pokemon_have_ability(pokemon, "poison-touch")) {
	    if (_chance <= 30) {
			var _counters = ["shield-dust", "immunity"];
			var _counter_ability = "";
			var _countered = false;
			for (var i = 0; i < array_length(_counters); ++i) {
			    if (__PFS_pokemon_have_ability(enemy, _counters[i])) {
					_counter_ability = _counters[i];
					_countered = true;
					break;
				}
			}
			if (!_countered){
				_status = [PFSStatusAilments.Poison, -1, "Poison Touch"];
			}
			else {
				show_debug_message($"{pokemon.internalName}'s Poison Touch canceled by {enemy.internalName}'s {_counter_ability}");
			}
		}
	}
	return [pokemon, enemy, _status];
}

#endregion

function __PFS_get_move_id(name) {
	for (var i = 0; i < array_length(PFS.moves); ++i) {
	    if (PFS.moves[i][$ "internalName"] == name or PFS.moves[i][$ "identifier"] == name) {
		    return PFS.moves[i].id;
		}
	}
	show_debug_message("Move id not found");
	return 0;
}

#region Status Effects
function __PFS_count_status_effect(pokemon) {
	var _status = PFSStatusAilments.None;
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    _status = pokemon.statusAilments[i][0];
		if (pokemon.statusAilments[i][1] != -99) {
			pokemon.statusAilments[i][1]-=0.5;
			//show_debug_message($"{pokemon.internalName}'s {pokemon.statusAilments[i][0]} diminished by one");
		}
	}
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
		_status = pokemon.statusAilments[i][0];
		if (pokemon.statusAilments[i][1] <= 0 and pokemon.statusAilments[i][1] != -99) {
			switch (_status) {
			    case PFSStatusAilments.Perish_song:
					show_debug_message($"{pokemon.internalName} fainted due to Perish Song!");
					pokemon.hp = 0;
					break;
			    case PFSStatusAilments.Sleep:
			        show_debug_message($"{pokemon.internalName} woke up!");
			        break;
			    default:
			        show_debug_message($"{pokemon.internalName} {PFS.StatusAilments[pokemon.statusAilments[i][0]]} status ran out!");
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
			global.dialogdata[$"pokename"] = pokemon.internalName;
			global.dialogdata[$"damage"] = _hploss;
			global.dialogdata[$"statusname"] = _statusName;
			array_push(global.nextdialog, {npc : "Battle", text : $"StatusDamage", onBattle : true});
			show_debug_message($"{pokemon.internalName} lost {_hploss}hp due to {_statusName}");
		}
	}
	return pokemon;
}
#endregion

#region Functions
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

function sprite_container() constructor {
    sprites = {};
    static load_sprite = function(pokemon) {
        var sprites_path = working_directory + "PFS/Sprites/Pokemon/";
        variable_struct_set(sprites, pokemon.internalName, {});
        var arr = ["Front", "Back", "Front shiny", "Back shiny"];
        for (var i = 0; i < array_length(arr); i++) {
            sprites[$pokemon.internalName][$ arr[i]] = sprite_add(sprites_path + arr[i] + "/" + string_upper(pokemon.internalName) + ".png", 1, false, false, 192/1.5, 192);
        }
    }
    static get_sprite = function(pokemon, side) {
        if (sprites[$pokemon.internalName] == undefined) {
            load_sprite(pokemon);
        }
        return sprites[$pokemon.internalName][$side + (pokemon.shiny ? " shiny" : "")];
    }
}

function pokeinfo(_pokemon) constructor {
	pokemon = _pokemon;
	xx = 0;
	yy = 0;
	static position = function(x, y, x2, y2) {
		xx = x + (x2 / 8);
		yy = y + (y2 / 3);
	}
	static draw = function() {
		var spr = global.pokemon_sprites.get_sprite(pokemon, "Front");
		draw_sprite_ext(spr, 0, xx, yy, 0.5, 0.5, 0, c_white, 1);
	}
}
