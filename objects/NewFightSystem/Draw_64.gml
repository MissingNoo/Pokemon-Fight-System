surf = surface_recreate(surf, 720, 480);
surface_set_target(surf);
draw_clear_alpha(c_black, 1);
draw_sprite_stretched(PFSBattleBgs, 1, 0, 0, 720, 480);
try {
	battleui.draw();
} catch (error) {
	show_debug_message(error);
	instance_destroy();
}

battleui
	.foreach(function(name, pos, data) {
		switch (name) {
			case "mname0":
			case "mname1":
			case "mname2":
			case "mname3":
				if (fsm.get_current_state() == "Attack") {
					draw_move(real(string_digits(name)), pos);
				}
				break;
		}
		draw_set_alpha(1);
	});
surface_reset_target();
//draw_rectangle_color(0, 0, GW, GH, c_black, c_black, c_black, c_black, false);
draw_surface_stretched(surf, 0, 0, GW, GH);
