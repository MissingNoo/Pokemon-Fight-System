//Feather disable GM2017
if (PFS.Initialized) { instance_destroy(); }
#region CSV Base
file = working_directory + "/PFS/Data/file.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "id","identifier","generation_id","evolves_from_species_id","evolution_chain_id","color_id","shape_id","habitat_id","gender_rate","capture_rate","base_happiness","is_baby","hatch_counter","has_gender_differences","growth_rate_id","forms_switchable","is_legendary","is_mythical","order","conquest_order" ];
	while (!file_text_eof(_fs)) {
		//var _line = string_split(file_text_read_string(_fs), ",");
		//show_debug_message(_line);
		//exit;
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		//var _value = _line[array_get_index(_pos, "index")];
	}
	file_text_close(_fs);
}
//else { show_message($"missing file {file} on installation"); }
#endregion

#region CSV Base
file = working_directory + "/PFS/Data/abilities.csv";
if (file_exists(file)) {
	PFS.Abilities[0] = {identifier : "null", internalName : "null"}
	var _fs = file_text_open_read(file);
	var _pos = [ "id","identifier" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		var _id = _line[array_get_index(_pos, "id")];
		if (_id == "") { continue; }
		var _identifier = _line[array_get_index(_pos, "identifier")];
		var _name = string_concat(string_upper(string_copy(_identifier, 1, 1)), string_copy(_identifier, 2, string_length(_identifier)));
		PFS.Abilities[_id] = { identifier : _identifier, internalName : _name }
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }
#endregion

#region Pokemons
file = working_directory + "/PFS/Data/pokemon.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "id","identifier","species_id","height","weight","base_experience","order","is_default" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		if (array_length(_line) == 1) { continue; }
		var _id = _line[array_get_index(_pos, "id")];
		if (_id == "") { continue; }
		var _name = _line[array_get_index(_pos, "identifier")];
		//Set first letter to higher
		_name = string_concat(string_upper(string_copy(_name, 1, 1)), string_copy(_name, 2, string_length(_name)));
		var _poke = {
			internalName : _name,
			type : [__PFSTypes.NoType, __PFSTypes.NoType],
			wildlevelrange : [5, 100],
			canLearn : {
				level : [],
			},
			basecalc : {},
			effort : {},
			ability : [[0, 1], [0, 1], [0, 1]],
			flinch : false
		}
		for (var i = 0; i < array_length(_pos); ++i) {
		    _poke[$ _pos[i]] = _line[i];
		}
		_poke.sprite = [string(_poke.internalName + "Front"), string(_poke.internalName + "Back")];
		PFS.Pokes[_id] = variable_clone(_poke);
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }

//Species
gen = 0;
file = working_directory + "/PFS/Data/pokemon_species.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "id","identifier","generation_id","evolves_from_species_id","evolution_chain_id","color_id","shape_id","habitat_id","gender_rate","capture_rate","base_happiness","is_baby","hatch_counter","has_gender_differences","growth_rate_id","forms_switchable","is_legendary","is_mythical","order","conquest_order" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		var _id = _line[array_get_index(_pos, "id")];
		if (_id == "") { continue; }
		var _poke = { }
		for (var i = 0; i < array_length(_pos); ++i) {
		    _poke[$ _pos[i]] = _line[i];
		}
		PFS.PokeSpecies[_id] = variable_clone(_poke);
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }

//Base Stats
file = working_directory + "/PFS/Data/pokemon_stats.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "pokemon_id","stat_id","base_stat","effort" ];
	var _statNames = ["null", "hp", "attack", "defense", "spattack", "spdefense", "speed", "accuracy", "evasion"];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		var _id = _line[array_get_index(_pos, "pokemon_id")];
		if (_id == "" or _id > array_length(PFS.Pokes) - 1 or _id > 5000) { continue; }
		var _statid = _line[array_get_index(_pos, "stat_id")];
		var _basestat = _line[array_get_index(_pos, "base_stat")];
		var _effort = _line[array_get_index(_pos, "effort")];
		PFS.Pokes[_id].basecalc[$ _statNames[_statid]] = real(_basestat);
		PFS.Pokes[_id].effort[$ _statNames[_statid]] = real(_effort);
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }

//Types
file = working_directory + "/PFS/Data/pokemon_types.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "pokemon_id","type_id","slot" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		var _id = _line[array_get_index(_pos, "pokemon_id")];
		if (_id == "" or _id > array_length(PFS.Pokes) - 1 or _id > 5000) { continue; }
		var _slot = _line[array_get_index(_pos, "slot")] - 1;
		var _type = real(_line[array_get_index(_pos, "type_id")]);
		switch (_type) {
			case 1:
				_type = __PFSTypes.Normal;
				break;
			case 2:
				_type = __PFSTypes.Fighting;
				break;
			case 3:
				_type = __PFSTypes.Flying;
				break;
			case 4:
				_type = __PFSTypes.Poison;
				break;
			case 5:
				_type = __PFSTypes.Ground;
				break;
			case 6:
				_type = __PFSTypes.Rock;
				break;
			case 7:
				_type = __PFSTypes.Bug;
				break;
			case 8:
				_type = __PFSTypes.Ghost;
				break;
			case 9:
				_type = __PFSTypes.Steel;
				break;
			case 10:
				_type = __PFSTypes.Fire;
				break;
			case 11:
				_type = __PFSTypes.Water;
				break;
			case 12:
				_type = __PFSTypes.Grass;
				break;
			case 13:
				_type = __PFSTypes.Electric;
				break;
			case 14:
				_type = __PFSTypes.Psychic;
				break;
			case 15:
				_type = __PFSTypes.Ice;
				break;
			case 16:
				_type = __PFSTypes.Dragon;
				break;
			case 17:
				_type = __PFSTypes.Dark;
				break;
			case 18:
				_type = __PFSTypes.Fairy;
				break;
			default:
				_type = __PFSTypes.NoType;
				break;
		}
		PFS.Pokes[_id].type[_slot] = _type;
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }

file = working_directory + "/PFS/Data/pokemon_abilities.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "pokemon_id","ability_id", "is_hidden", "slot" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		var _id = _line[array_get_index(_pos, "pokemon_id")];
		if (_id == "" or _id > array_length(PFS.Pokes) - 1 or _id > 5000) { continue; }
		var _slot = _line[array_get_index(_pos, "slot")] - 1;
		var _ability = real(_line[array_get_index(_pos, "ability_id")]);
		var _hidden = real(_line[array_get_index(_pos, "is_hidden")]);
		PFS.Pokes[_id].ability[_slot] = [_ability, _hidden];
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }
#endregion

#region Generate Move List
if (file_exists(working_directory + "/PFS/Data/moves.csv")) {
	var fs = file_text_open_read(working_directory + "/PFS/Data/moves.csv");
    var jsonStr = "";
	var _pos = [ "id","identifier","generation_id","type_id","power","pp","accuracy","priority","target_id","damage_class_id","effect_id","effect_chance","contest_type_id","contest_effect_id","super_contest_effect_id" ];
	var _others = [ "priority","damage_class_id","effect_id","effect_chance" ];
	var _lastid = 0;
	while (!file_text_eof(fs)) {
		var _move = string_split(file_text_read_string(fs), ",");
		var _id = _move[array_get_index(_pos, "id")];
		try {
			//Feather disable once GM2022
			int64(_id);
			_lastid = _id;
		}
		catch (err) {
		}
		#region Get move type
		var _type = _move[array_get_index(_pos, "type_id")];
		switch (_type) {
			case 1:
				_type = __PFSTypes.Normal;
				break;
			case 2:
				_type = __PFSTypes.Fighting;
				break;
			case 3:
				_type = __PFSTypes.Flying;
				break;
			case 4:
				_type = __PFSTypes.Poison;
				break;
			case 5:
				_type = __PFSTypes.Ground;
				break;
			case 6:
				_type = __PFSTypes.Rock;
				break;
			case 7:
				_type = __PFSTypes.Bug;
				break;
			case 8:
				_type = __PFSTypes.Ghost;
				break;
			case 9:
				_type = __PFSTypes.Steel;
				break;
			case 10:
				_type = __PFSTypes.Fire;
				break;
			case 11:
				_type = __PFSTypes.Water;
				break;
			case 12:
				_type = __PFSTypes.Grass;
				break;
			case 13:
				_type = __PFSTypes.Electric;
				break;
			case 14:
				_type = __PFSTypes.Psychic;
				break;
			case 15:
				_type = __PFSTypes.Ice;
				break;
			case 16:
				_type = __PFSTypes.Dragon;
				break;
			case 17:
				_type = __PFSTypes.Dark;
				break;
			case 18:
				_type = __PFSTypes.Fairy;
				break;
			default:
				_type = __PFSTypes.NoType;
				break;
		}
		#endregion
		#region Get move category
		var _category = _move[array_get_index(_pos, "damage_class_id")];
		switch (_category) {
		    case 1:
		        _category = PFSMoveCategory.Status;
		        break;
		    case 2:
		        _category = PFSMoveCategory.Physical;
		        break;
		    case 3:
		        _category = PFSMoveCategory.Special;
		        break;
		    default:
		        _category = PFSMoveCategory.Physical;
		        break;
		}
		#endregion
		#region Get move name
		var _name = _move[array_get_index(_pos, "identifier")];
		var _identifier = _move[array_get_index(_pos, "identifier")];
		var _splitName = string_split(_name, "-");
		_name = "";
		for (var i = 0; i < array_length(_splitName); ++i) {
		    var _firstLetter = string_upper(string_copy(_splitName[i], 1,1));
			var _firstLetterRemoved = string_copy(_splitName[i], 2, string_length(_splitName[i]));
			_splitName[i] = _firstLetter + _firstLetterRemoved;
			_name = $"{_name} {_splitName[i]}";
		}
		if (string_copy(_name, 1, 1) == " ") {
		    _name = string_copy(_name, 2, string_length(_name));
		}
		#endregion
		var _power = _move[array_get_index(_pos, "power")];
		var _pp = _move[array_get_index(_pos, "pp")];
		var _accuracy = _move[array_get_index(_pos, "accuracy")];
		try {
			PFS.moves[_id] = {
				"id" : real(_id),
				"identifier" : _identifier,
				"type": _type,
				"category": _category,
				"accuracy": _accuracy,
				"internalName": _name,
				"maxpp": _pp,
				"pp": _pp,
				"probability":"0",
				"mpower" : _power,
				"priority" : 0
				}
				for (var i = 0; i < array_length(_others); ++i) {
					var value = 0;
					try {
						_value = real(_move[array_get_index(_pos, _others[i])]);
					}
					catch (err) {
						_value = 0;
					}
				    PFS.moves[_id][$ _others[i]] = _value;
				}
				if (PFS.moves[_id].category == PFSMoveCategory.Status and PFS.moves[_id].effect_chance == 0) {
					PFS.moves[_id].effect_chance = 100;
				}
		}
		catch (err) {
			show_debug_message($"{_lastid+1} is empty");
			PFS.moves[_lastid+1] = {
				"id" : _id,
				"type": __PFSTypes.NoType,
				"category": 0,
				"accuracy": 0,
				"internalName": "Null",
				"pp": 0,
				"probability":"0",
				"mpower": 0,
				"priority" : 0
			}
		}
		file_text_readln(fs);
	}
	file_text_close(fs);
}
#endregion

#region Moves Pokemons can Learn
gen = 0;
if (file_exists(working_directory + "/PFS/Data/pokemon_moves.csv")) {
	var fs = file_text_open_read(working_directory + "/PFS/Data/pokemon_moves.csv");
    var jsonStr = "";
	var _pos = [ "pokemon_id", "version_group_id", "move_id", "pokemon_move_method_id", "level", "order" ];
	while (!file_text_eof(fs)) {
		var _add = true;
		var _move = string_split(file_text_read_string(fs), ",");
		try {
			var _gen = _move[array_get_index(_pos, "version_group_id")];
			if (_gen != 9) {
			    _add = false;
			}
		}
		catch (err) {}
		if (_add) {
		    var _pokemon = _move[array_get_index(_pos, "pokemon_id")];		
			var _moveId = _move[array_get_index(_pos, "move_id")];
			var _learnMethod = _move[array_get_index(_pos, "pokemon_move_method_id")];
			var _level = _move[array_get_index(_pos, "level")];
			try {
				if (real(_pokemon) > 650) {
				    break;
				}
				if (real(_learnMethod) == PFSMoveMethods.Levelup) {
				    array_push(PFS.Pokes[_pokemon].canLearn.level, { id: _moveId, level : _level });
				}
			}
			catch (err) {
				//show_message($"error on {_move}");
			}
		}
		file_text_readln(fs);
	}
	file_text_close(fs);
}
#endregion

#region Status
file = working_directory + "/PFS/Data/move_meta_ailments.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "id","identifier"];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		if (array_length(_line) == 1) { continue; }
		var _id = _line[array_get_index(_pos, "id")];
		var _identifier = _line[array_get_index(_pos, "identifier")];
		_identifier = string_concat(string_upper(string_copy(_identifier, 1, 1)), string_copy(_identifier, 2, string_length(_identifier)));
		if (_id == -1) { continue; }
		PFS.StatusAilments[_id] = _identifier;
	}
	//array_insert(PFS.StatusAilments, 0, "Unknown");
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }

//data for moves
file = working_directory + "/PFS/Data/move_meta.csv";
if (file_exists(file)) {
	var _fs = file_text_open_read(file);
	var _pos = [ "move_id","meta_category_id","meta_ailment_id","min_hits","max_hits","min_turns","max_turns","drain","healing","crit_rate","ailment_chance","flinch_chance","stat_chance" ];
	while (!file_text_eof(_fs)) {
		file_text_readln(_fs);
		var _line = string_split(file_text_read_string(_fs), ",");
		if (array_length(_line) == 1 or array_length(_line) == 0) { continue; }
		var _id = real(_line[array_get_index(_pos, "move_id")]);
		PFS.StatusAilmentsData[_id] = {};
		for (var i = 0; i < array_length(_pos); ++i) {
			try {
				PFS.StatusAilmentsData[_id][$ _pos[i]] = real(_line[array_get_index(_pos, _pos[i])]);
			}
		    catch (err) {
				PFS.StatusAilmentsData[_id][$ _pos[i]] = 0;
			}
		}
	}
	file_text_close(_fs);
}
else { show_message($"missing file {file} on installation"); }
#endregion
PFS.Initialized = true;
room_goto(rConfig);