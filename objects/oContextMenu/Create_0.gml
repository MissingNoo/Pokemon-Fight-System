uistr = variable_clone(global.game_uis.context_menu);
while (top + height > display_get_gui_height()) {
	top--;
}
while (left + width > display_get_gui_width()) {
	left--;
}
uistr.left = left;
uistr.top = top;
uistr.width = width;
uistr.height = height;

ui = new window(uistr);
offset = 22;
button_height = 22;
dbg = dbg_view("Context Menu", false);
depth = -9000;
create_view_from_instance(self);

ui.add_draw("title", 
	AirUIFunctionStart 
	scribble($"[fa_center][fa_middle][c_black]{title}")
				.fit_to_box(_w, _h)
				.draw(_x + _w / 2, _y + _h / 2);
	AirUIFunctionEnd 
);
ui.add_draw("list", 
	AirUIFunctionStart 
	offset = 0;
			for (var i = 0; i < array_length(buttons); i++) {
				e = buttons[i];
				e.position(_x, _y + offset, _x + _w, _y + offset + button_height);
				offset += button_height + 5;
				e.draw();
			}
			if (device_mouse_check_button_released(0, mb_left) && mouse_in_area_gui(area)) {
				instance_destroy();
			}
	AirUIFunctionEnd 
);
ui.finish();
