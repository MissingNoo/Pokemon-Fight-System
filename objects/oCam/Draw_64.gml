if (global.blackfade[0] > 0) {
	draw_set_alpha(global.blackfade[0]);
    draw_rectangle_color(0, 0, GW, GH, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}