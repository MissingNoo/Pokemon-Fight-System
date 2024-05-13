fsm.draw();
draw_set_alpha(blackalpha);
draw_rectangle_color(0,0, GW, GH, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
if (DEBUGMODE) {
	draw_set_color(c_black);
	draw_text(10, 10, $"Screen: {screen}");
	draw_text(10, 20, $"{oakalpha[0]}");
	draw_text(10, 30, $"{playeralpha[0]}");
	draw_set_color(c_white);
}