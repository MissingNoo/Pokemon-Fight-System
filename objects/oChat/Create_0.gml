ui = new window(global.game_uis.chat);
text_input = new textbox();
text_input.backtext = "Chat here";
text_input
	.set_function(method(self, function() {
		var text = text_input.text;
		if (text != "") {
			new packet("chatMessage")
				.write("player", AirNet.username)
				.write("message", text)
				.send()
			text_input.text = "";
		}
	}));
chat = [];
chatsurf = undefined;
over = 0;


ui.add_draw("messages", 
	AirUIFunctionStart
	chatsurf = surface_recreate(chatsurf, _w, _h);
			surface_set_target(chatsurf);
			draw_clear_alpha(c_black, 0);
			for (var offset = 0, i = 0; i < array_length(chat); i++) {
				var msg = chat[i];
				var strh = string_height(msg.message);
				scribble($"{msg.player}: {msg.message}").draw(2, over + offset);
				if (
					mouse_in_area_gui([_x, _y, _x + _w, _y + _h])
					&& mouse_in_area_gui(
						[
							_x + 2,
							_y + over + offset,
							_x + 2 + string_width(msg.player),
							_y + over + offset + strh
						]
					)
					&& device_mouse_check_button_pressed(0, mb_right)
				) {
					player_context_menu(msg.player);
				}
				offset += strh + 2;
				if (over + offset > _h) {
					over--;
				}
			}
			surface_reset_target();
			draw_surface(chatsurf, _x, _y);
	AirUIFunctionEnd
);

ui.add_draw("text_input",
	AirUIFunctionStart
	text_input.position_area(area);
	text_input.draw();
	AirUIFunctionEnd
);
ui.finish();