//Feather disable GM2017
#region Move Editor
show = false;
#endregion

#region Files
file = game_save_id + "moves.json";
savedFile = game_save_id + "moves.bin";
#endregion

#region Move
move = 0;
internalName = "Tackle";
type = 0;
category = 0;
mpower = 0;
accuracy = 0;
pp = 0;
probability = 0;
#endregion

#region Information Window
options = [
	["Move", "move"],
	["internalName", "internalName"],
	["Power", "mpower"],
	["Accuracy", "accuracy"],
	["PP", "pp"],
	["Probability", "probability"]
];
optionsLenght = array_length(options);
selected = 0;
set = false;
#endregion

#region Move List
moveListOffset = 0;
#endregion

#region Functions
function loadMove(move){
	if (move >= array_length(global.__PFS.moves)) { exit; }
	var _move = global.__PFS.moves[move];
	internalName = _move.internalName;
	type = _move.type;
	category = _move.category;
	mpower = _move.mpower;
	accuracy = _move.accuracy;
	pp = _move.pp;
	probability = _move.probability;
}
if (file_exists(savedFile)) {
	var fs = file_text_open_read(savedFile);
	var _json = file_text_read_string(fs);
	file_text_close(fs);
	global.__PFS.moves = json_parse(_json);
}
loadMove(0);
#endregion

#region Generate Move List
if (file_exists("moves.csv")) {
	var fs = file_text_open_read("moves.csv");
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