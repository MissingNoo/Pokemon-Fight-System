function context_menu(title, width = 100, height = 200) constructor {
	inst = noone;
	left = device_mouse_x_to_gui(0);
	top = device_mouse_y_to_gui(0);
	instance_destroy(oContextMenu);
	inst = instance_create_depth(
		0,
		0,
		-6000,
		oContextMenu,
		{title, left, top, width, height}
	);

	static add_button = function(btn) {
		if (instance_exists(inst)) {
			array_push(inst.buttons, btn);
		}
		return self;
	};
}
