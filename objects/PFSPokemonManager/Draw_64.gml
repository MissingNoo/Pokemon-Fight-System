//Feather disable GM2017
var _startx = startPosition[0];
var _starty = startPosition[1];
var _x = _startx;
var _y = _starty;
draw_sprite_ext(PFSPokemonScreenBG, 0, _startx + 1, _starty + 1, 3, 3, 0, c_white, 1);
var _offset = selectedPokemon == 0 ? 94 : 100;
draw_sprite_ext(PFSPokemonScreenFirst, selectedPokemon == 0 ? 1 : 0, _x + 133, _y + 132 + _offset, 3, 3, 0, c_white, 1);
_offset = selectedPokemon == 0 ? 3 : 3;
var _pokemon = PFS.playerPokemons[0];
var _hp = _pokemon.hp;
var _hpColor = 0;
if (((_hp / _pokemon.base.hp) * 100) < 60) { _hpColor = 1; }
if (((_hp / _pokemon.base.hp) * 100) < 25) { _hpColor = 2; }
draw_sprite_ext(PFSPokemonScreenHPTop, 0, _x + 52, _y + 169 + _offset, 3, 3, 0, c_white, 1);
draw_sprite_part_ext(PFSPokemonScreenHPValue, _hpColor, 0, 0, ((_hp / _pokemon.base.hp) * 48), 10, _x + 97, _y + 175 + _offset, 3, 3, c_white, 1);
var _yoff = 0;
draw_sprite_ext(PFSPokemonScreenCancel, selectedPokemon == 7 ? 1 : 0, _x + 552, _y + 396, 3, 3, 0, c_white, 1);
draw_set_font(PFS.Fonts.PokeSelectFont[3]);
draw_set_color(selectedPokemon == 7 ? c_white : c_gray);
draw_text(_x + 614, _y + 420, "CANCEL");
draw_set_color(c_white);
for (var i = 1; i < 6; ++i) {
	if (i > array_length(PFS.playerPokemons) - 1) { break; }
	if (array_length(PFS.playerPokemons) == 1) { break; }
	_pokemon = PFS.playerPokemons[i];
	_hp = _pokemon.hp;
	_hpColor = 0;
	if (((_hp / _pokemon.base.hp) * 100) < 60) { _hpColor = 1; }
	if (((_hp / _pokemon.base.hp) * 100) < 25) { _hpColor = 2; }
    draw_sprite_ext(PFSPokemonScreenOther, selectedPokemon == i ? 1 : 0, _x + 292, _y + 28 + _yoff, 3, 3, 0, c_white, 1);
    draw_sprite_ext(PFSPokemonScreenHPTop, 0, _x + 508, _y + 49 + _yoff, 3, 3, 0, c_white, 1);
    draw_sprite_part_ext(PFSPokemonScreenHPValue, _hpColor, 0, 0, ((_hp / _pokemon.base.hp) * 48), 10, _x + 553, _y + 55 + _yoff, 3, 3, c_white, 1);
	draw_set_font(PFS.Fonts.PokeSelectFont[3]);
	draw_set_color(_hp > 0 ? c_white : c_gray);
	draw_text(_x + 330, _y + 42 + _yoff, string_upper(_pokemon.internalName));
	draw_set_color(c_white)
	draw_set_font(PFS.Fonts.PokeSelectFont[2]);
	draw_text(_x + 410, _y + 74 + _yoff, _pokemon.level);
	_yoff += 72;
}
draw_set_font(PFS.Fonts.PokeFont[3]);