//Feather disable GM2017
#region Debug
a = 0;
b = 0;
c = 0;
d = 0;
#endregion

#region Battle
enemyOut = 0;
pokemonOut = 0;
enemySprite = sPFSBulbasaurBack;
pokemonSprite = sPFSBulbasaurBack;
#endregion

#region Window
startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
windowXScale = 7;
windowYScale = 5.70;
windowSize = [700, 400];
selectedMenu = 0;
menus = ["Battle", "Pokemon", "Item", "Run"];
#endregion

#region Function
function load_sprite(pokemon, side){
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png")) {
		switch (side) {
			case 0:
		        if (sprite_exists(enemySprite)) {
				    sprite_delete(enemySprite);
				}
			    enemySprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[0] + ".png", 0, false, false, 0, 0);
		        break;
		    case 1:
		        if (sprite_exists(pokemonSprite)) {
				    sprite_delete(pokemonSprite);
				}
			    pokemonSprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png", 0, false, false, 0, 0);
		        break;
		}
	}
}

function poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, _side){
	draw_rectangle(_x, _y, _boxEndX, _boxEndY, true);
	_x += 10;
	_y += 10;
	draw_text(_x, _y, _pokemon.internalName);
	draw_healthbar(_x, _y + 20, _boxEndX - 10, _y + 25, ((_pokemon.hp / _pokemon.base.hp) * 100), c_red, c_lime, c_lime, 0, 1, 0);
	draw_set_halign(fa_right);
	draw_text(_boxEndX - 10, _y, $"{_pokemon.hp}/{_pokemon.base.hp}");
	draw_text(_boxEndX - 10, _y + 45, $"LV:{_pokemon.level}");
	draw_set_halign(fa_left);
	_y += 40;
	var _xoff = 0;
	var _array = _side == __PFSBattleSides.Player ? global.__PFS.playerPokemons : enemyPokemon;
	for (var i = 0; i < array_length(_array); ++i) {
	    draw_circle(_boxEndX - 15 - _xoff, _y, 7, global.__PFS.playerPokemons[i].hp <= 0);
		_xoff += 20;
	}
	_x = _startx + (windowSize[0] * 0.07);
	_y = _starty + (windowSize[1] * 0.45);
	var _sprite = _side == __PFSBattleSides.Player ? pokemonSprite : enemySprite;
	var _pos = _side == __PFSBattleSides.Player ? [_x - sprite_get_width(_sprite) / 2, _boxEndY - 250 - sprite_get_height(_sprite) / 2] : [_x + 120 + sprite_get_width(_sprite) / 2, _y - 200 - sprite_get_height(_sprite) / 2];
	if (sprite_exists(_sprite)) {
		draw_sprite_ext(_sprite, -1, _pos[0], _pos[1], 3, 3, 0, c_white, 1);
	}
}
#endregion

load_sprite(global.__PFS.playerPokemons[0], 1);
load_sprite(enemyPokemon[enemyOut], 0);