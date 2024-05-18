if (instance_exists(oCutscene) or other.started) {
    exit;
}
if (x == other.x and y == other.y) {
	other.started = true;
	instance_create_depth(0, 0, 0, oCutscene, {cutscene : Cutscenes[other.cutscene]});
}