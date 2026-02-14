surface_set_target(surf);
battleui.draw();
draw_text(10, 30, $"State: {state.get_current_state()}\n Option: {option}");
surface_reset_target();
draw_surface_stretched(surf, 0, 0, GW, GH);