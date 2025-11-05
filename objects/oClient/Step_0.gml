if (room != rUIEditor) {
	//display_set_gui_size(window_get_width(), window_get_height());
}

if (keyboard_check_pressed(ord("F"))) {
	if (!AirNet.loggedin || global.currenttextbox.selected) {
		exit;
	}
	if (!instance_exists(oFriendList)) {
		instance_create_depth(0, 0, -1000, oFriendList);
	} else {
		instance_destroy(oFriendList);
	}
}
if (keyboard_check_pressed(ord("Z"))) {
	
}
if (keyboard_check_pressed(vk_f1)) {
	dbglog = !dbglog;
	show_debug_log(dbglog);
}
if (keyboard_check_pressed(vk_f3)) {
	//offset.lerp_to(offset.get_value() > 0 ? -1000 : 10)
	tween(self, "offset", offset < 0 ? surface_get_height(infosurf) + 10 : -10);
}
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("R"))) {
	AirNet.connection.reconnect();
	alarm[0] = 120;
	count = 0;
}

if (mx != mouse_x || my != mouse_y) {
	mx = mouse_x;
	my = mouse_y;
	with (oOtherPlayer) {
		if (uuid == AirNet.connection.uuid) {
			//player.x = mouse_x;
			//player.y = mouse_y;
		}
	}
	if (AirNet.connection.current_room != "") {
		new packet("movePlayer").write("x", mx).write("y", my).send()
	}
}
