var _stepdata = cutscene.steps[currentstep];
for (var i = 0; i < array_length(alarms); ++i) {
	if (alarms[i][0] == -1) { continue;	}
	if (alarms[i][0] > 0) {
	    alarms[i][0] -= 1;
	}
	else { 
		alarms[i][1]();
		alarms[i][0] = -1;
	}
}
switch (_stepdata.func) {
    case CutsceneFunction.MovePlayer:
		show_debug_message($"[Cutscene] Moving player to {_stepdata.v}!");
        variable_instance_set(instance_find(oPlayer, 0), _stepdata.varname, _stepdata.v);
		oPlayer.cutmoving = true;
		currentstep++;
        break;
	case CutsceneFunction.WaitPlayerVar:
		if (variable_instance_get(instance_find(oPlayer, 0), _stepdata.varname) == _stepdata.v) {
		    currentstep++
			show_debug_message($"[Cutscene] Player movement ended!");
		}
		break;
	case CutsceneFunction.Dialog:
		var _d = instance_create_depth(0, 0, oPlayer.depth - 1, oDialog, {npc : _stepdata.npc, text : _stepdata.text});
		_d.onMap();
		_d.dialogSprite = sDialogWindow;
		currentstep++;
		break;
	case CutsceneFunction.DialogEnd:
		if (currentmessage != currentstep) {
			show_debug_message($"[Cutscene] Waiting for dialog to end!");
		    currentmessage = currentstep;
		}
		if (!instance_exists(oDialog)) {
			show_debug_message($"[Cutscene] Dialog ended!");
		    currentstep++;
		}
		break;
	case CutsceneFunction.AddAlarm:
		array_push(alarms, [_stepdata.time, _stepdata.call]);
		alarmdone = false;
		currentstep++;
		break;
	case CutsceneFunction.WaitAlarm:
		if (currentmessage != currentstep) {
			show_debug_message($"[Cutscene] Waiting Alarm!");
		    currentmessage = currentstep;
		}
		if (alarmdone) {
			show_debug_message($"[Cutscene] Alarm done!");
		    currentstep++;
		}
		break;
	case CutsceneFunction.WaitForRoom:
		if (room == _stepdata.roomname) {
		    currentstep++;
		}
		break;
	case CutsceneFunction.SpawnNpc:
		instance_create_depth(_stepdata.npcx, _stepdata.npcy, oPlayer.depth, oNpc, {npc : Npcs[_stepdata.npcid], cutscenenpc : true});
		currentstep++;
		break;
	case CutsceneFunction.MoveNpc:
		with (oNpc) {
		    if (cutscenenpc and npc.nid == _stepdata.npcid) {
				oCutscene.lastnpcinteracted = npc.nid;
				placeToGo = _stepdata.place;
			}
		}
		cancontinue = false;
		currentstep++;
		break;
	case CutsceneFunction.RotateNpc:
		with (oNpc) {
		    if (cutscenenpc and npc.nid == _stepdata.npcid) {
				dir = _stepdata.dir;
			}
		}
		currentstep++;
		break;
	case CutsceneFunction.WaitNpcMove:
		if (cancontinue) {
			currentstep++;
		}
		break;
	case CutsceneFunction.DestroyNpc:
		with (oNpc) {
		    if (cutscenenpc and npc.nid == _stepdata.npcid) {
				instance_destroy();
			}
		}
		currentstep++;
		break;
    case CutsceneFunction.End:
		show_debug_message($"[Cutscene] Cutscene Finished!");
		instance_destroy();
        break;
}