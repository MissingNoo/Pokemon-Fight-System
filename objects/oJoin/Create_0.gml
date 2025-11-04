ui = new window(global.game_uis.rooms);
roundness_x = AirLibRoundX;
roundness_y = AirLibRoundY;
room_list_offset = 53;
room_list_h = 50;
room_list_title_x = 15;
room_list_title_y = 5;
room_list_title_scale = 1;
room_list_btn_x = 120;
room_list_btn_y = 10;
room_list_btn_w = 110;
room_list_btn_h = 32;
room_list_online_x = 5;
room_list_online_y = 25;
room_list_scroll = 0;
scrolltime = 0;
code_input = new textbox();
code_input.textcolor = "c_white";
code_input.only_numbers = false;
code_input.backtext = "Code Here";
code_button = new button("Join Lobby");
code_button
	.set_function(method(self, function() {
		new packet("joinCode").write("roomCode", code_input.text).send()
	}));
reload_button = new button("R");
reload_button
	.set_function(function() {
		new packet("getRoomList").send()
	});
bg = AirLibBG;
fg = AirLibFG;
roomsurf = undefined;
dbg = dbg_view("Join", false, 10, 10);
create_view_from_instance(self);
room_list = undefined;

quit_button = new button("X");
quit_button
	.set_function(method(self, function() {
		instance_activate_object(oMainMenu);
		instance_destroy(self);
	}));

new packet("getRoomList").send()

ui.add_draw("join_panel", 
	AirUIFunctionStart 
	quit_button.position(_x + _w - 20, _y - 20, _x + _w + 20, _y + 20);
			quit_button.draw();
	AirUIFunctionEnd 
);
ui.add_draw("code_label", 
	AirUIFunctionStart 
	scribble($"[c_black][fa_middle]Join game from code")
				.scale(room_list_title_scale)
				.draw(_x + room_list_title_x, _y + _h / 2);
	AirUIFunctionEnd 
);
ui.add_draw("join_label", 
	AirUIFunctionStart 
	scribble($"[c_black][fa_middle]Join game")
				.scale(room_list_title_scale)
				.draw(_x + room_list_title_x, _y + _h / 2);
	AirUIFunctionEnd 
);
ui.add_draw("join_button", 
	AirUIFunctionStart 
	code_button.position_area(area);
			code_button.draw();
	AirUIFunctionEnd 
);
ui.add_draw("code_input", 
	AirUIFunctionStart 
	draw_roundrect_ext(_x, _y, _x + _w, _y + _h, roundness_x, roundness_y, true);
			code_input.position(_x, _y, _x + _w, _y + _h);
			code_input.draw();
	AirUIFunctionEnd 
);
ui.add_draw("room_list", 
	AirUIFunctionStart
	if (mouse_in_area_gui(area)) {
				var newscroll = (-mouse_wheel_up() + mouse_wheel_down()) * 10;
				room_list_scroll += newscroll;
				scrolltime = newscroll != 0 ? 5 : scrolltime;
			}
			scrolltime = clamp(scrolltime - 1, 0, 5);
			if (scrolltime == 0 && room_list_scroll > 0) {
				room_list_scroll = lerp(room_list_scroll, 0, 0.1);
			}
			//draw_rectangle(_x, _y, _x + _w, _y + _h, true);
			roomsurf = surface_recreate(roomsurf, gui_x_percent(100), gui_y_percent(100));
			surface_set_target(roomsurf);
			draw_clear_alpha(c_black, 0);
			if (is_array(room_list)) {
				for (var yoff = 0, i = 0; i < array_length(room_list); ++i) {
					var yy = _y + yoff + room_list_scroll;
					var r = room_list[i];
					r[$ "join_btn"] ??= new button("Join");
					r.join_btn
						.set_function(method(r, function() {
							new packet("joinRoom").write("roomName", name).send()
						}));
					r.join_btn.position(
						_x + _w - room_list_btn_x,
						yy + room_list_btn_y,
						_x + _w - room_list_btn_x + room_list_btn_w,
						yy + room_list_title_y + room_list_btn_h
					);
					draw_set_color(bg);
					draw_roundrect_ext(
						_x,
						yy,
						_x + _w,
						yy + room_list_h,
						roundness_x,
						roundness_y,
						false
					);
					draw_set_color(c_white);
					scribble($"[c_black]{r.name}")
						.scale(room_list_title_scale)
						.draw(_x + room_list_title_x, yy + room_list_title_y);
					scribble($"[c_black][fa_middle][fa_right]{r.players}/{r.maxPlayers}")
						.scale(room_list_title_scale)
						.draw(
							_x + _w - room_list_btn_x - room_list_online_x,
							yy + room_list_online_y
						);
					r.join_btn.draw();
					yoff += room_list_offset;
				}
			}
			surface_reset_target();
			draw_surface_part_area(roomsurf, area); 

	AirUIFunctionEnd 
);
ui.add_draw("reload_button", 
	AirUIFunctionStart 
	reload_button.position(_x, _y, _x + _w, _y + _h);
			reload_button.draw();
	AirUIFunctionEnd 
);
ui.finish();
