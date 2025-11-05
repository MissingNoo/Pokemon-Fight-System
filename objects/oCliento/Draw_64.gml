if (room != rInit) {
    exit;
}
for (var i = 0; i < array_length(characters); ++i) {
    draw_sprite_ext(sRedWD, 1, GW/2, GH/2, 3, 3, 0, c_white, 1);
	draw_text_transformed(GW/2, GH/2 - 30, characters[i], 3, 3, 0);
}