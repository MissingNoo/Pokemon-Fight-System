//Feather disable GM2017
var _startx = startPosition[0];
var _starty = startPosition[1];
var _x = _startx;
var _y = _starty;
var a = PFSFightSystem.a;
var b = PFSFightSystem.b;
var c = PFSFightSystem.c;
var d = PFSFightSystem.d;
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
for (var i = 1; i < 6; ++i) {
	if (selectedPokemon != 7) {
	    if (selectedPokemon > array_length(PFS.playerPokemons) - 1) { break; }
	}
	_pokemon = PFS.playerPokemons[i];
	_hp = _pokemon.hp;
	_offset = selectedPokemon == i ? 3 : 0;
	_hpColor = 0;
	if (((_hp / _pokemon.base.hp) * 100) < 60) { _hpColor = 1; }
	if (((_hp / _pokemon.base.hp) * 100) < 25) { _hpColor = 2; }
    draw_sprite_ext(PFSPokemonScreenOther, selectedPokemon == i ? 1 : 0, _x + 292, _y + 31 + _yoff, 3, 3, 0, c_white, 1);
    draw_sprite_ext(PFSPokemonScreenHPTop, 0, _x + 508, _y + 49 + _yoff + _offset, 3, 3, 0, c_white, 1);
    draw_sprite_part_ext(PFSPokemonScreenHPValue, _hpColor, 0, 0, ((_hp / _pokemon.base.hp) * 48), 10, _x + 553, _y + 55 + _yoff + _offset, 3, 3, c_white, 1);
	draw_text(_x + 330, _y + 50 + _yoff, _pokemon.internalName);
	draw_text(_x + 410, _y + 75 + _yoff, _pokemon.level);
	_yoff += 72;
}
draw_rectangle(_x, _y, _x + windowSize[0], _y + windowSize[1], true);