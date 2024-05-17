scribble_typists_add_event("closeDialog", function(_element, _parameter_array, _character_index){ oDialog.alarm[2] = _parameter_array[0]; show_debug_message("teste")});
enum CutsceneFunction {
	SetPlayerVar,
	MovePlayer,
	WaitPlayerVar,
	Dialog,
	DialogEnd,
	AddAlarm,
	WaitAlarm,
	WaitForRoom,
	End
}
enum CutsceneNames {
	OakLab
}
function Cutscene(name) constructor
{
	cname = name;
	steps = [];
    static setPlayerVar = function(varname, v) {
        array_push(steps, {func : CutsceneFunction.SetPlayerVar, varname, v});
    }
    static movePlayer = function(position) {
        array_push(steps, {func : CutsceneFunction.SetPlayerVar, varname : "placeToGo", v : position});
		array_push(steps, {func : CutsceneFunction.WaitPlayerVar, varname : "cutmoving", v : false});
    }
    static waitPlayerVar = function(varname, v) {
        array_push(steps, {func : CutsceneFunction.WaitPlayerVar, varname, v});
    }
    static dialog = function(npc, text) {
        array_push(steps, {func : CutsceneFunction.Dialog, npc, text});
        array_push(steps, {func : CutsceneFunction.DialogEnd});
    }
    static addAlarm = function(time, call) {
		static alarmnum = 0;
        array_push(steps, {func : CutsceneFunction.AddAlarm, alarmnum, time, call});
        array_push(steps, {func : CutsceneFunction.WaitAlarm, alarmnum});
		alarmnum++;
    }
    static waitForRoom = function(roomname) {
        array_push(steps, {func : CutsceneFunction.WaitForRoom, roomname});
    }
    static finish = function() {
        array_push(steps, {func : CutsceneFunction.End});
    }
}

global.cutscenes = [];
#macro Cutscenes global.cutscenes
Cutscenes[CutsceneNames.OakLab] = new Cutscene("OakLab");
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "ExitingPallet1");
Cutscenes[CutsceneNames.OakLab].addAlarm(50, function(){oCutscene.alarmdone = true;});
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "ExitingPallet2");
Cutscenes[CutsceneNames.OakLab].movePlayer([1384, 944]);
Cutscenes[CutsceneNames.OakLab].movePlayer([1368, 944]);
Cutscenes[CutsceneNames.OakLab].movePlayer([1368, 1120]);
Cutscenes[CutsceneNames.OakLab].movePlayer([1432, 1120]);
Cutscenes[CutsceneNames.OakLab].movePlayer([1448, 1120]);
Cutscenes[CutsceneNames.OakLab].movePlayer([1448, 1104]);
Cutscenes[CutsceneNames.OakLab].waitForRoom(rOakLab);
Cutscenes[CutsceneNames.OakLab].movePlayer([648, 624]);
//Cutscenes[CutsceneNames.OakLab].addAlarm(100, function(){oCutscene.alarmdone = true;});
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "InsideLab1");
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "InsideLab2");
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "InsideLab3");
Cutscenes[CutsceneNames.OakLab].finish();