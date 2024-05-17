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
switch (cutscene.steps[currentstep].func) {
    case CutsceneFunction.MovePlayer:
		show_debug_message($"[Cutscene] Moving player to {cutscene.steps[currentstep].v}!");
        variable_instance_set(instance_find(oPlayer, 0), cutscene.steps[currentstep].varname, cutscene.steps[currentstep].v);
		oPlayer.cutmoving = true;
		currentstep++;
        break;
	case CutsceneFunction.WaitPlayerVar:
		if (variable_instance_get(instance_find(oPlayer, 0), cutscene.steps[currentstep].varname) == cutscene.steps[currentstep].v) {
		    currentstep++
			show_debug_message($"[Cutscene] Player movement ended!");
		}
		break;
	case CutsceneFunction.Dialog:
		var _d = instance_create_depth(0, 0, oPlayer.depth - 1, oDialog, {npc : cutscene.steps[currentstep].npc, text : cutscene.steps[currentstep].text});
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
		array_push(alarms, [cutscene.steps[currentstep].time, cutscene.steps[currentstep].call]);
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
		if (room == cutscene.steps[currentstep].roomname) {
		    currentstep++;
		}
		break;
	case CutsceneFunction.SpawnNpc:
		instance_create_depth()
		if (room == cutscene.steps[currentstep].roomname) {
		    currentstep++;
		}
		break;
	case CutsceneFunction.WaitForRoom:
		if (room == cutscene.steps[currentstep].roomname) {
		    currentstep++;
		}
		break;
	case CutsceneFunction.WaitForRoom:
		if (room == cutscene.steps[currentstep].roomname) {
		    currentstep++;
		}
		break;
    case CutsceneFunction.End:
		show_debug_message($"[Cutscene] Cutscene Finished!");
		instance_destroy();
        break;
}