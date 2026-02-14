if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_enter)) {
	file_copy("/tmp/export.ui", "/tmp/export.ui.bkp");
	oEditableUI.save("/tmp/export.ui");
}