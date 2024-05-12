//Feather disable GM2017
if (!DEBUGMODE or instance_number(PFSMoveEditor) > 1) { instance_destroy(); }
#region Move Editor
show = false;
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
selected = 0;
#endregion

#region Move List
moveListOffset = 0;
#endregion

#region Functions
function loadMove(move){
	if (move >= array_length(PFS.moves)) { exit; }
	selected = move;
	var _move = PFS.moves[move];
	internalName = _move.internalName;
	type = _move.type;
	category = _move.category;
	mpower = _move.mpower;
	accuracy = _move.accuracy;
	pp = _move.pp;
	probability = _move.probability;
}
loadMove(1);
#endregion