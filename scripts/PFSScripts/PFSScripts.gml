//Feather disable GM2017
global.__PFS = {};
#macro PFS global.__PFS
PFS.playerPokemons = [];
PFS.moves = [];
PFS.PokeSpecies = [];
PFS.Pokes = [];
PFS.Abilities = [];
PFS.__PFSTypes = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy", "NoType"];
PFS.PFSMoveCategory = [["Physical", sPFSPhysicalIcon], ["Special", sPFSSpecialIcon], ["Status", sPFSStatusIcon]];
PFS.StatusAilments = [];
PFS.StatusAilmentsData = [];



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
	Pokemon,
	Item,
	Run
}
	
enum PFSBattleSides {
	Player,
	Enemy
}
	
enum PFSStatusAilments {
	Unknown,
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
	No_type_immunity = 15,
	Leech_seed = 17,
	Embargo = 18,
	Perish_song = 19,
	Ingrain = 20,
	Silence = 23,
	Tar_shot = 41,
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

function __PFS_pokemon_affected_by_status(pokemon, status_id) {
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    if (pokemon.statusAilments[i][0] == status_id) {
		    return true;
		}
	}
	return false;
}

function __PFS_use_move(pokemon, enemy, move, side) {
	if (pokemon.hp <= 0) { return; }
	var _calc = [0, [0, 0]];
	var _appliedStatus = "";
	_calc = __PFS_damage_calculation(pokemon, enemy, move);
	if (_calc[1] != 0 and !__PFS_pokemon_affected_by_status(enemy, _calc[1][0])) {
		_appliedStatus = $" and applied {PFS.StatusAilments[_calc[1][0]]} status!";
		array_push(side == PFSBattleSides.Player ? enemyPokemon[0].statusAilments : PFS.playerPokemons[pokemonOut].statusAilments, _calc[1]);
	}
	show_debug_message(string_concat($"{pokemon.internalName} used move {move.internalName}!", _calc[0] > 0 ? $" dealing {_calc[0]} damage!" : "", $" {_appliedStatus}"));
	switch (side) {
		case PFSBattleSides.Player:
			enemyPokemon[0].hp -= _calc[0];
			if (enemyPokemon[0].hp <= 0) {
				enemyPokemon[0].hp = 0;
				show_debug_message($"{enemyPokemon[0].internalName} died");
				if (lastEnemyUsedMove == __PFS_get_move_id("Destiny Bond")) {
					PFS.playerPokemons[pokemonOut].hp = 0;
					show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} died together due to {enemyPokemon[0].internalName}'s Destiny Bond!");
				}
			}
			break;
		case PFSBattleSides.Enemy:
			PFS.playerPokemons[pokemonOut].hp -= _calc[0];
			if (PFS.playerPokemons[pokemonOut].hp <= 0) { 
				show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} died");
				if (lastUsedMove == __PFS_get_move_id("Destiny Bond")) {
					enemyPokemon[0].hp = 0;
					show_debug_message($"{enemyPokemon[0].internalName} died together due to {PFS.playerPokemons[pokemonOut].internalName}'s Destiny Bond!");
				}
				PFS.playerPokemons[pokemonOut].hp = 0; 
			}
			break;
	}
}

function __PFS_damage_calculation(pokemon, enemy, move){
	var _status = 0;
	var _critChance = irandom_range(0, 255);
	var _critTreshold = pokemon.speed / 2; //TODO: High crit chance atk and items
	var _isCritical = _critChance <= _critTreshold ? 2 : 1; //TODO _isCritical = 1 if target ability is Battle Armor or Shell Armor or with Luck Chant
	var _level = real(pokemon.level);
	var _power  = 0;
	try {
	    _power = real(move.mpower);
	}
	catch (err) { }
	var _stab = array_get_index(pokemon.type, move.type) != -1 ? 1.5 : 1;
	var _type1 = __PFS_is_effective(enemy, move, 0);
	var _type2 = array_length(enemy.type) > 1 ? __PFS_is_effective(enemy, move, 1) : 1;
	var _type = 1 * _type1 * _type2;
	var _rnd = random_range(0.85, 1);
	#region //TODO
	var _targets = 1; //TODO: 0.75 if more than one target (0.5 in battle royale)
	var _pb = 1; //TODO: Parental Bond second hit = 0.25
	var _weather = 1 //TODO: Weather
	var _glaiverush = 1; //TODO: Glaive Rush = 2 if the move was used in the previous turn
	var _burn = 1;
	var _other = 1;
	#endregion
	var _a = 1;
	var _d = 1;
	switch (move.type) { //TODO: unmodified on criticals, light screen, reflect, 
	    case PFSMoveCategory.Physical:
	        _a = pokemon.attack;
			_d = enemy.defense;
	        break;
	    case PFSMoveCategory.Special:
	        _a = pokemon.spattack;
			_d = enemy.spdefense;
			if (move.effect_chance != "") {
			    var _chance = irandom_range(0, 100);
				_chance = 3;
				if (_chance <= move.effect_chance) {
					var _turns = -1;
					var _effectData = PFS.StatusAilmentsData[move.id];
					_turns = irandom_range(_effectData.min_turns, _effectData.max_turns);
					_status = [real(move.effect_id), _turns];
				}
			}
	        break;
	}
	if (_a > 255 or _d > 255) {
	    _a = floor(_a / 4);
	    _d = floor(_d / 4);
	}
	var _damage = ( ( ( 2 * _level / 5 + 2) * _power * (_a / _d) ) / 50 + 2 );
	_damage = _damage * _targets * _pb * _weather * _glaiverush * _isCritical * _rnd * _stab * _type * _burn * _other;
	_damage = round(_damage);
	if (_power == 0) { _damage = 0; }
	#region Status Effects
	if (_damage > 0 and __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Burn)) {
		var _oDamage = _damage;
		_damage = round(_damage / 2);
		show_debug_message($"{pokemon.internalName} damage is halved from {_oDamage} to {_damage} because it's burning");
	}
	#endregion
	//show_debug_message($"Dealt ( ( ( 2 * {_level} / 5 + 2) * {_power} * ({_a} / {_d}) ) / 50 + 2 )  * {_targets} * {_pb} * {_weather} * {_glaiverush} * {_isCritical} * {_rnd} * {_stab} * {_type} * {_burn} * {_other} = {_damage} damage");
	return [_damage, _status];
}

function __PFS_generate_pokemon(pokemon){
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
	return __PFS_recalculate_stats(pokemon, true);
}

function __PFS_recalculate_stats(pokemon, pokecenter = false){
	if (pokemon[$ "base"] == undefined) {
	    pokemon[$ "base"] = {};
	}
	var _names = variable_struct_get_names(pokemon.basecalc);
	var _result = "";
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
				var _nature = 1; //TODO: nature
		        variable_struct_set(pokemon.base, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				if (pokecenter) {
				    variable_struct_set(pokemon, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				}
		        break;
		}
	}
	for (var i = 0; i < array_length(pokemon.moves); ++i) {
	    pokemon.moves[i].pp = pokemon.moves[i].maxpp;
	}
	//show_debug_message($"{pokemon.internalName}: {json_stringify(pokemon)}");
	//show_debug_message("");
	return pokemon;
}

function __PFS_get_ability_id(name) {
	for (var i = 0; i < array_length(PFS.Abilities); ++i) {
	    if (PFS.Abilities[i][$ "internalName"] == name or PFS.Abilities[i][$ "identifier"] == name) {
		    return i;
		}
	}
	show_debug_message("Move id not found");
	return 0;
}

function __PFS_ability_before_move(pokemon, move){
	for (var i = 0; i < array_length(pokemon.ability); ++i) {
	    if (pokemon.ability[i][0] == __PFS_get_ability_id("pixilate")) {
		    if (move.type == __PFSTypes.Normal) {
			    show_debug_message($"{move.internalName} has changed type from Normal to Fairy by {pokemon.internalName} Pixilate!");
				if (move.mpower != "") {
				    move.mpower = round(real(move.mpower) * 1.3);
				}
				move.type = __PFSTypes.Fairy;
			}
		}
	}
	return [pokemon, move];
}

function __PFS_ability_on_contact(pokemon, enemy){
	//for (var i = 0; i < array_length(pokemon); ++i) {
	    
	//}
	return [pokemon, enemy];
}

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
function __PFS_tick_status_effect(pokemon) {
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
	    var _status = pokemon.statusAilments[i][0];
		if (pokemon.statusAilments[i][1] != -1) {
			pokemon.statusAilments[i][1]--;
		}
		switch (_status) {
		    case PFSStatusAilments.Burn:
				var _hploss = round(pokemon.hp / 16);
				pokemon.hp -= _hploss;
				show_debug_message($"{pokemon.internalName} lost {_hploss}hp to Burn");
		        break;
		}
	}
	for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
		if (pokemon.statusAilments[i][1] == 0) {
			show_debug_message($"{pokemon.internalName} {PFS.StatusAilments[pokemon.statusAilments[i][0]]} status ran out!");
			array_delete(pokemon.statusAilments, i, 1);
			continue;
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