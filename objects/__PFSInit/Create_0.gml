//Feather disable GM2017
#region Generate pokedex
if (file_exists(working_directory + "/PFS/Data/pokedex.json")) {
	//show_message("pokedex");
	var fs = file_text_open_read(working_directory + "/PFS/Data/pokedex.json");
    var jsonStr = "";
	while (!file_text_eof(fs)) {
	  jsonStr += file_text_read_string(fs);
	  file_text_readln(fs);
	}
	file_text_close(fs);
	var _pokedex = json_parse(jsonStr);
	//for (var i = 0; i < array_length(_pokedex); ++i) {
	for (var i = 0; i < 650; ++i) {
		var _type = [];
		if (array_length(_pokedex[i][$ "type"]) == 2) {
		    _type = [array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[0]), array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[1])];
		}
		if (array_length(_pokedex[i][$ "type"]) == 1) {
			_type = [array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[0]), __PFSTypes.NoType];
		}
		if (_pokedex[i][$ "base"] == undefined) {
			show_debug_message($"base missing for {_pokedex[i].name.english}")
		    continue;
		}
		var _poke = {
			internalName : _pokedex[i].name.english,
			type : _type,
			evolution : _pokedex[i][$ "evolution"],
			wildlevelrange : [5, 100],
			gender : _pokedex[i][$ "profile"][$ "gender"],
			ability : _pokedex[i][$ "profile"][$ "ability"],
			canLearn : {
				level : [],
			},
			basecalc : {
				hp : _pokedex[i].base.HP,
				attack : _pokedex[i].base.Attack,
				defense : _pokedex[i].base.Defense,
				spatk : _pokedex[i].base[$ "Sp. Attack"],
				spdef : _pokedex[i].base[$ "Sp. Defense"],
				speed : _pokedex[i].base.Speed
			},
			//moves : [__PFS_add_move("Growl"), __PFS_add_move("Tackle"), __PFS_add_move("Vine Whip"), __PFS_add_move("Growth")]
		}
		_poke.sprite = [string(_poke.internalName + "Front"), string(_poke.internalName + "Back")];
	    global.__PFS.Pokes[_pokedex[i].id] = _poke;
	}
}
for (var i = 0; i < array_length(global.__PFS.Pokes); ++i) {
	//if (global.__PFS.Pokes[i][$ "base"] == undefined) {
	//    global.__PFS.Pokes[i].base = {};
	//}
}
#endregion

#region Generate Move List
if (file_exists(working_directory + "/PFS/Data/moves.csv")) {
	var fs = file_text_open_read(working_directory + "/PFS/Data/moves.csv");
    var jsonStr = "";
	var _pos = [ "id","identifier","generation_id","type_id","power","pp","accuracy","priority","target_id","damage_class_id","effect_id","effect_chance","contest_type_id","contest_effect_id","super_contest_effect_id" ];
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
		        _category = __PFSMoveCategory.Status;
		        break;
		    case 2:
		        _category = __PFSMoveCategory.Physical;
		        break;
		    case 3:
		        _category = __PFSMoveCategory.Special;
		        break;
		    default:
		        _category = __PFSMoveCategory.Physical;
		        break;
		}
		#endregion
		#region Get move name
		var _name = _move[array_get_index(_pos, "identifier")];
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
			global.__PFS.moves[_id] = {
				"id" : _id,
				"type": _type,
				"category": _category,
				"accuracy": _accuracy,
				"internalName": _name,
				"maxpp": _pp,
				"pp": _pp,
				"probability":"0",
				"mpower":_power
				}
		}
		catch (err) {
			show_debug_message($"{_lastid+1} is empty");
			global.__PFS.moves[_lastid+1] = {
			"id" : _id,
			"type": __PFSTypes.NoType,
			"category": 0,
			"accuracy": 0,
			"internalName": "Null",
			"pp": 0,
			"probability":"0",
			"mpower": 0
			}
		}
		file_text_readln(fs);
	}
	file_text_close(fs);
}
#endregion

#region Moves Pokemons can Learn
if (file_exists(working_directory + "/PFS/Data/pokemon_moves.csv")) {
	var fs = file_text_open_read(working_directory + "/PFS/Data/pokemon_moves.csv");
    var jsonStr = "";
	var _pos = [ "pokemon_id", "version_group_id", "move_id", "pokemon_move_method_id", "level", "order" ];
	while (!file_text_eof(fs)) {
		var _add = true;
		var _move = string_split(file_text_read_string(fs), ",");
		try {
			var _gen = _move[array_get_index(_pos, "version_group_id")];
			if (_gen != 5) {
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
				if (real(_learnMethod) == __PFSMoveMethods.Levelup) {
				    array_push(global.__PFS.Pokes[_pokemon].canLearn.level, { id: _moveId, level : _level });
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