if (!surface_exists(surf)) { surf = surface_create(239 * 2, 159 * 2); }
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
tab.draw();
surface_reset_target();
var scale = 1;
draw_surface_ext(surf, GW/2 - (surface_get_width(surf) * scale) / 2, GH/2 - (surface_get_height(surf) * scale) / 2, scale, scale, 0, c_white, 1);