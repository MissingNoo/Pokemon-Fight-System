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
	["Move:", "move"],
	["internalName:", "internalName"],
	["Power:", "mpower"],
	["Accuracy:", "accuracy"],
	["PP:", "pp"],
	["Probability:", "probability"]
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