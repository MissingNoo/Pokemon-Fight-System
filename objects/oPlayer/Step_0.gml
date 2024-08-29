if (keyboard_check_pressed(vk_f5)) {
	instance_create_depth(x, y, oPlayer.depth, oBag);
}
if (keyboard_check_pressed(vk_f4)) {
	PlayerInventory.add_item("PokeBall");
	PlayerInventory.add_item("GreatBall");
	PlayerInventory.add_item("Potion");
	PlayerInventory.add_item("SuperPotion");
}
if (keyboard_check_pressed(vk_f3)) {
	room = rPallet;
	x = 1384;
	y = 912;
    instance_create_depth(0, 0, 0, oCutscene, {cutscene : Cutscenes[CutsceneNames.OakLab]});
}
fsm.step();
if (!instance_exists(oCam)) {
    instance_create_depth(0, 0, 0, oCam);
}
if (!canmove and alarm[0] == -1) {	
    alarm[0] = 4;
}
#region Alarms
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
#endregion