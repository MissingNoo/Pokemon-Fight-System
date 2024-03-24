if (keyboard_check_pressed(vk_numpad8)) {
    display_set_gui_size(window_get_width(), window_get_height());
	startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
}