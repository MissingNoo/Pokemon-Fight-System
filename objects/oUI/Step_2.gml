if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_enter)) {
	file_copy(global.filename, global.filename + ".bkp");
	oEditableUI.save(global.filename);
}