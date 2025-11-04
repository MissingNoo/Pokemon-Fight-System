if (instance_exists(oLogin)) {
	exit;
}
global[$ "__mouse_over"] ??= -1;
ui.draw();
