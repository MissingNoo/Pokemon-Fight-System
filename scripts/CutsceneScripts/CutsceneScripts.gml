scribble_typists_add_event("closeDialog", function(_element, _parameter_array, _character_index){ oDialog.alarm[2] = _parameter_array[0]});
nextdialog = [];
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
	WaitNpcMove,
	RotateNpc,
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
	static moveNpc = function(npcid, place){
		array_push(steps, {func : CutsceneFunction.MoveNpc, npcid, place});
		array_push(steps, {func : CutsceneFunction.WaitNpcMove});
		return self;
	}
	static destroyNpc = function(npcid){
		array_push(steps, {func : CutsceneFunction.DestroyNpc, npcid});
		return self;
	}
	static rotateNpc = function(npcid, dir){
		array_push(steps, {func : CutsceneFunction.RotateNpc, npcid, dir});
		return self;
	}
	static moveNpcAndPlayer = function(npcid, place, playerplace){
		array_push(steps, {func : CutsceneFunction.MoveNpc, npcid, place});
		array_push(steps, {func : CutsceneFunction.MovePlayer, varname : "placeToGo", v : playerplace});		
		array_push(steps, {func : CutsceneFunction.WaitPlayerVar, varname : "cutmoving", v : false});
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
.spawnNpc(1336, 1040, NpcNames.Oak)
.addAlarm(1, function(){ PlayerData.tried_to_exit_pallet = true; oCutscene.alarmdone = true; })
.moveNpc(NpcNames.Oak, [1336, 1024])
.moveNpc(NpcNames.Oak, [1352, 1024])
.moveNpc(NpcNames.Oak, [1352, 992])
.moveNpc(NpcNames.Oak, [1368, 992])
.moveNpc(NpcNames.Oak, [1368, 944])
.moveNpc(NpcNames.Oak, [1384, 944])
.moveNpc(NpcNames.Oak, [1384, 928])
.addAlarm(50, function(){oCutscene.alarmdone = true;})
.dialog("Oak", "ExitingPallet2")
Cutscenes[CutsceneNames.OakLab].moveNpcAndPlayer(NpcNames.Oak, [1384, 944], [1384, 928])
.moveNpcAndPlayer(NpcNames.Oak, [1368, 944], [1384, 944])
.moveNpcAndPlayer(NpcNames.Oak, [1368, 960], [1368, 944])
.moveNpcAndPlayer(NpcNames.Oak, [1368, 1120], [1368, 1104])
.moveNpcAndPlayer(NpcNames.Oak, [1384, 1120], [1368, 1120])
.moveNpcAndPlayer(NpcNames.Oak, [1448, 1120], [1448 - 16, 1120])
.moveNpcAndPlayer(NpcNames.Oak, [1448, 1104], [1448, 1120])
.addAlarm(20, function(){oCutscene.alarmdone = true;})
.destroyNpc(NpcNames.Oak)
.movePlayer([1448, 1104])
.waitForRoom(rOakLab)
.spawnNpc(648, 736, NpcNames.Oak)
.moveNpc(NpcNames.Oak, [648, 608])
Cutscenes[CutsceneNames.OakLab].addAlarm(45, function(){oCutscene.alarmdone = true;})
.destroyNpc(NpcNames.Oak)
.spawnNpc(632, 624, NpcNames.Gary)
.rotateNpc(NpcNames.Gary, 90)
.addAlarm(60, function(){oCutscene.alarmdone = true;})
.movePlayer([648, 624])
.dialog("Oak", "InsideLab1")
.addAlarm(80, function(){oCutscene.alarmdone = true;})
.dialog("Oak", "InsideLab2")
.addAlarm(80, function(){oCutscene.alarmdone = true;})
.dialog("Oak", "InsideLab3")
.finish();