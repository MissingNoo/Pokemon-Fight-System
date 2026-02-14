///Vars
#region Poke vars
move_x = 30;
move_x_off = 0;
move_y = 30;
move_y_off = 0;

own_x_offset = 80;
own_y_offset = 130;
other_offset = 700;
other_offset_y = 0;
other_x_offset = 130;
other_y_offset = 200;
other_scale = 1;

other_out = 0;
self_out = 0;
other_spr = undefined;
poke_spr = undefined;
#endregion

#region Options
option = 0;
#endregion

update_sprites = function () {
	other_spr = global.pokemon_sprites.get_sprite(battle.team[other_out], "Front");
	//other_spr = global.pokemon_sprites.get_sprite(PlayerTeam[self_out], "Front");
	poke_spr = global.pokemon_sprites.get_sprite(PlayerTeam[self_out], "Back");
	poke_spr2 = global.pokemon_sprites.get_sprite(PlayerTeam[self_out], "Front");
}
update_sprites();

draw_move = function(mnum, pos) {
	var si = sine_wave(current_time / 2000, 1, 2, 0);
	var _x = pos.left;
	var _y = pos.top;
	if (array_length(PlayerTeam[self_out].moves) == 0) { exit; }
	if (array_length(PlayerTeam[self_out].moves) <= mnum) { exit; }
	var move = PlayerTeam[self_out].moves[mnum];
	scribble($"[fa_middle][sPokeFont1]{move.internalName}").scale(2).scale_to_box(pos.width, pos.height, false).draw(_x + 20, _y + (pos.height / 2));
	if (option == mnum) {
		draw_sprite_ext(PFSOptionSelected, 0, _x + si + 10, _y + (pos.height / 2), 2, 2, 0, c_white, 1);
	}
}