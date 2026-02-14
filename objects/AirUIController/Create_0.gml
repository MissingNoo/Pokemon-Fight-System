if (instance_number(AirUIController) > 1) {
	instance_destroy();
}
scribble_font_set_default("Fnt");
AirLib = {frame: 0, listframe: 0, waitframe: 0, lib_uis: {}, lerpers: []};
