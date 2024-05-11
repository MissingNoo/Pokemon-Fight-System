fsm.step();
if (keyboard_check_pressed(vk_backspace) and ONLINE and !instance_exists(oClient)) {
	show_debug_message("spawn Client");
    instance_create_depth(x, y, depth, oClient);
}
if (keyboard_check_pressed(vk_delete)) {
    instance_destroy(oClient);
}
if (!instance_exists(oCam)) {
    instance_create_depth(0, 0, 0, oCam);
}
if (!canmove and alarm[0] == -1) {	
    alarm[0] = 4;
}