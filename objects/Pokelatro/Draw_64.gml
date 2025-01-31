if (surface_exists(gamesurf)) {
    surface_set_target(gamesurf);
    draw_clear_alpha(c_black, 1);
    fsm.draw();
    draw_rectangle(0, 0, surface_get_width(gamesurf) - 1, surface_get_height(gamesurf) - 1, true);
    surface_reset_target();
}
else {
    gamesurf = surface_create(1920, 1080);
}
draw_surface_stretched(gamesurf, 0, 0, GW, GH);

