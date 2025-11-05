if (
	device_mouse_check_button_released(0, mb_left)
	&& !mouse_in_area_gui([left, top, left + width, top + height])
) {
	instance_destroy();
}
