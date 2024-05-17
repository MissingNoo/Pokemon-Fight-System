switch (dir) {
    case 0:
        sprite_index = sprites[0];
        break;
    case 90:
        sprite_index = sprites[1];
        break;
    case 180:
        sprite_index = sprites[2];
        break;
    case 270:
        sprite_index = sprites[3];
        break;
}
draw_sprite_ext(sprite_index, image_index, x, y + stairoffset, 1, 1, 0, c_white, 1);
fsm.draw();
//draw_text_transformed(x, y - 20 - sprite_height, fsm.get_current_state(), 0.25, 0.25, 0);
if (ONLINE) {
	draw_set_halign(fa_center);
	draw_set_color(c_red);
    draw_text_transformed(x, y - 5 - sprite_height, global.playerName, 0.25, 0.25, 0);
	if (DEBUGMODE) {
	    draw_text_transformed(x, y - 15 - sprite_height, uid, 0.25, 0.25, 0);
	}
	draw_set_color(c_white);
	draw_set_halign(fa_left);
}