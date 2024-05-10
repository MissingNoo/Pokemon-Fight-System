draw_self();
if (ONLINE) {
	draw_set_halign(fa_center);
	draw_set_color(c_red);
    draw_text_transformed(x, y - 5 - sprite_height, global.playerName, 0.25, 0.25, 0);
    draw_text_transformed(x, y - 15 - sprite_height, uid, 0.25, 0.25, 0);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
}
if (instance_exists(oSlave)) {
    with (oSlave) {
	    draw_line(x, y, oPlayer.x, oPlayer.y);
	}
}