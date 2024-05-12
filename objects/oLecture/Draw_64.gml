if (screen < 5) {
    draw_sprite_ext(sLectureBBG, 0, 0, 0, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sLecture1, screen, 0, 0, scale, scale, 0, c_white, alpha);
}
if (screen > 5) {
    draw_sprite_ext(sLectureBase, 0, 0, 0, scale, scale, 0, c_white, 1);
}

draw_set_alpha(blackalpha);
draw_rectangle_color(0,0, GW, GH, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);