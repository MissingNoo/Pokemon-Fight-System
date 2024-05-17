scribble_typists_add_event("closeDialog", function(_element, _parameter_array, _character_index){ oDialog.alarm[2] = _parameter_array[0]});
enum CutsceneFunction {
	MovePlayer,
	WaitPlayerVar,
	Dialog,
	DialogEnd,
	AddAlarm,
	WaitAlarm,
	WaitForRoom,
	SpawnNpc,
	MoveNpc,
	DestroyNpc,
	End
}
enum CutsceneNames {
	OakLab
}
function Cutscene(name) constructor
{
	cname = name;
	steps = [];
    static movePlayer = function(position) {
        array_push(steps, {func : CutsceneFunction.MovePlayer, varname : "placeToGo", v : position});
		array_push(steps, {func : CutsceneFunction.WaitPlayerVar, varname : "cutmoving", v : false});
		return self;
    }
    static waitPlayerVar = function(varname, v) {
        array_push(steps, {func : CutsceneFunction.WaitPlayerVar, varname, v});
		return self;
    }
    static dialog = function(npc, text) {
        array_push(steps, {func : CutsceneFunction.Dialog, npc, text});
        array_push(steps, {func : CutsceneFunction.DialogEnd});
		return self;
    }
    static addAlarm = function(time, call) {
		static alarmnum = 0;
        array_push(steps, {func : CutsceneFunction.AddAlarm, alarmnum, time, call});
        array_push(steps, {func : CutsceneFunction.WaitAlarm, alarmnum});
		alarmnum++;
		return self;
    }
    static waitForRoom = function(roomname) {
        array_push(steps, {func : CutsceneFunction.WaitForRoom, roomname});
		return self;
    }
	static spawnNpc = function(npcx, npcy, npcid){
		array_push(steps, {func : CutsceneFunction.SpawnNpc, npcid, npcx, npcy });
		return self;
	}
	static moveNpc = function(npcid, npcx, npcy){
		array_push(steps, {func : CutsceneFunction.MoveNpc, npcid, npcx, npcy});
		return self;
	}
	static destroyNpc = function(npcid){
		array_push(steps, {func : CutsceneFunction.DestroyNpc, npcid});
		return self;
	}
    static finish = function() {
        array_push(steps, {func : CutsceneFunction.End});
		return self;
    }
}

global.cutscenes = [];
#macro Cutscenes global.cutscenes
Cutscenes[CutsceneNames.OakLab] = new Cutscene("OakLab");
Cutscenes[CutsceneNames.OakLab].dialog("Oak", "ExitingPallet1")
.addAlarm(50, function(){oCutscene.alarmdone = true;})
.dialog("Oak", "ExitingPallet2")
.movePlayer([1384, 944])
.movePlayer([1368, 944])
.movePlayer([1368, 1120])
.movePlayer([1432, 1120])
.movePlayer([1448, 1120])
.movePlayer([1448, 1104])
.waitForRoom(rOakLab)
.movePlayer([648, 624])
//b].addAlarm(100, function(){oCutscene.alarmdone = true;});
.dialog("Oak", "InsideLab1")
.dialog("Oak", "InsideLab2")
.dialog("Oak", "InsideLab3")
.finish();