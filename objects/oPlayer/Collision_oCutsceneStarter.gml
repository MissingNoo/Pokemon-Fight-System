if (instance_exists(oCutscene)) {
    exit;
}
if (x == other.x and y == other.y) {
	instance_create_depth(0, 0, 0, oCutscene, {cutscene : Cutscenes[other.cutscene]});
}