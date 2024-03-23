//Feather disable GM2017
var _startx = startPosition[0];
var _starty = startPosition[1];
var _yoff = 0;
var _xoff = 0;
#region Main Window
windowSize = [windowXScale * 100, windowYScale * 100];
DebugManager.debug_add_config($"Window X Size:{windowXScale}", DebugTypes.UpDown, self, "windowXScale", undefined, "Battle");
DebugManager.debug_add_config($"Window Y Size:{windowYScale}", DebugTypes.UpDown, self, "windowYScale", undefined, "Battle");
var _x = _startx;
var _y = _starty;
draw_rectangle(_x, _y, _x + windowSize[0], _y + windowSize[1], true);
#endregion

#region Selected Menu
_x = _startx + (windowSize[0] * 0.75);
_y = _starty;
draw_rectangle(_x, _y, _startx + windowSize[0], _starty + (windowSize[1] * 0.65), true);
_x += 10;
_y += 10;
switch (selectedMenu) {
    case PFSBattleMenus.Battle:
		_yoff = 0;
		var moves = global.__PFS.playerPokemons[pokemonOut].moves;
        for (var i = 0; i < array_length(moves); ++i) {
			var move = moves[i];
		    createbutton(_x, _y + _yoff, move.internalName, 1, true, undefined);
			draw_sprite_ext(sPFSTypeIcons, move.type, _x + 8, _y + 36 + _yoff, 0.25, 0.25, 0, c_white, 1);
			_yoff += 60;
		}
        break;
	case PFSBattleMenus.Pokemon:
		_yoff = 0;
		for (var i = 0; i < array_length(global.__PFS.playerPokemons); ++i) {
		    if (createbutton(_x, _y + _yoff, global.__PFS.playerPokemons[i].name, 1)) {
			    pokemonOut = i;
			}
			_yoff += 30;
		}
		break;
    default:
        // code here
        break;
}
#endregion

#region Battle Area
DebugManager.debug_add_config($"a:{a}", DebugTypes.UpDown, self, "a", undefined, "Battle");
DebugManager.debug_add_config($"b:{b}", DebugTypes.UpDown, self, "b", undefined, "Battle");
DebugManager.debug_add_config($"c:{c}", DebugTypes.UpDown, self, "c", undefined, "Battle");
DebugManager.debug_add_config($"d:{d}", DebugTypes.UpDown, self, "d", undefined, "Battle");
var _pokemon = global.__PFS.playerPokemons[pokemonOut];
#region Player Pokemon Info
_x = _startx + (windowSize[0] * 0.40);
_y = _starty + (windowSize[1] * 0.75);
var _boxEndX = _startx + (windowSize[0] * 0.70);
var _boxEndY = _starty + (windowSize[1] * 0.95);
draw_rectangle(_x, _y, _boxEndX, _boxEndY, true);
_x += 10;
_y += 10;
draw_text(_x, _y, _pokemon.name);
draw_healthbar(_x, _y + 20, _boxEndX - 10, _y + 25, ((_pokemon.hp / _pokemon.basehp) * 100), c_red, c_lime, c_lime, 0, 1, 0);
_y += 40;
_xoff = 0;
for (var i = 0; i < array_length(global.__PFS.playerPokemons); ++i) {
    draw_circle(_boxEndX - 15 - _xoff, _y, 7, global.__PFS.playerPokemons[i].hp <= 0);
	_xoff += 20;
}
_x = _startx + (windowSize[0] * 0.20);
_y = _starty + (windowSize[1] * 0.85);
draw_sprite_ext(_pokemon.sprite[1], -1, _x, _y, 3, 3, 0, c_white, 1);
#endregion
#region Enemy Pokemon Info
_pokemon = enemyPokemon[0];
_x = _startx + (windowSize[0] * 0.02);
_y = _starty + (windowSize[1] * 0.03);
_boxEndX = _startx + (windowSize[0] * 0.30);
_boxEndY = _starty + (windowSize[1] * 0.23);
draw_rectangle(_x, _y, _boxEndX, _boxEndY, true);
_x += 10;
_y += 10;
draw_text(_x, _y, _pokemon.name);
draw_healthbar(_x, _y + 20, _boxEndX - 10, _y + 25, ((_pokemon.hp / _pokemon.basehp) * 100), c_red, c_lime, c_lime, 0, 1, 0);
_y += 40;
_xoff = 0;
if (!wildPokemon) {
    for (var i = 0; i < array_length(enemyPokemon); ++i) {
	    draw_circle(_boxEndX - 15 - _xoff, _y, 7, enemyPokemon[i].hp <= 0);
		_xoff += 20;
	}
}
_x = _startx + (windowSize[0] * 0.50);
_y = _starty + (windowSize[1] * 0.45);
draw_sprite_ext(_pokemon.sprite[0], -1, _x, _y, 2, 2, 0, c_white, 1);
#endregion
#endregion

#region Options
_x = _startx + (windowSize[0] * 0.75);
_y = _starty + (windowSize[1] * 0.65);
draw_rectangle(_x, _y, _startx + windowSize[0], _starty + windowSize[1], true);
_yoff = 0;
for (var i = 0; i < array_length(menus); ++i) {
	if (createbutton(_x + 10, _y + 10 + _yoff, menus[i], 1, true, undefined, selectedMenu == i ? c_yellow : c_white)) {
	    selectedMenu = i;
	}
    _yoff += 30;
}
#endregion
draw_set_color(c_white);