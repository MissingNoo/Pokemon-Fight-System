//Feather disable GM2017
#region Start Variables
var _startx = startPosition[0];
var _starty = startPosition[1];
var _yoff = 0;
var _xoff = 0;
#endregion

#region Debug
//DebugManager.debug_add_config({
//	name : $"a: {a}",
//	type : DebugTypes.UpDown,
//	object : self,
//	variable : "a",
//	//func: function(){},
//	tab : "Battle"
//});
DebugManager.debug_add_config($"a:{a}", DebugTypes.UpDown, self, "a", undefined, "Battle");
DebugManager.debug_add_config($"b:{b}", DebugTypes.UpDown, self, "b", undefined, "Battle");
DebugManager.debug_add_config($"c:{c}", DebugTypes.UpDown, self, "c", undefined, "Battle");
DebugManager.debug_add_config($"d:{d}", DebugTypes.UpDown, self, "d", undefined, "Battle");
#endregion

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
		var moves = PFS.playerPokemons[pokemonOut].moves;
        for (var i = 0; i < array_length(moves); ++i) {
			var move = moves[i];
		    if (createbutton(_x, _y + _yoff, $"{move.internalName} {move.pp}/{move.maxpp}", 1, true, undefined) and move.pp > 0) {
				array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[0], move, PFSBattleSides.Player]);
				doTurn = true;
			}
			draw_sprite_ext(sPFSTypeIcons, move.type, _x + 8, _y + 36 + _yoff, 0.25, 0.25, 0, c_white, 1);
			var _cat = sPFSPhysicalIcon;
			switch (move.category) {
			    case PFSMoveCategory.Physical:
			        _cat = sPFSPhysicalIcon;
			        break;
			    case PFSMoveCategory.Special:
			        _cat = sPFSSpecialIcon;
			        break;
			    case PFSMoveCategory.Status:
			        _cat = sPFSStatusIcon;
			        break;
			}
			draw_sprite_ext(_cat, 0, _x + 25, _y + 27 + _yoff, 0.15, 0.15, 0, c_white, 1);
			_yoff += 60;
		}
        break;
	case PFSBattleMenus.Pokemon:
		_yoff = 0;
		for (var i = 0; i < array_length(PFS.playerPokemons); ++i) {
		    if (createbutton(_x, _y + _yoff, PFS.playerPokemons[i].internalName, 1) and PFS.playerPokemons[i].hp > 0) {
				array_push(turnSteps, [PFSTurnType.ChangePokemon, i]);
				pokePlayerDead = false;
				selectedMenu = 0;
				doTurn = true;
			}
			draw_sprite_ext(sPFSTypeIcons, PFS.playerPokemons[i].type[0], _x + 8, _y + 36 + _yoff, 0.25, 0.25, 0, c_white, 1);
			if (PFS.playerPokemons[i].type[1] != __PFSTypes.NoType) {
			    draw_sprite_ext(sPFSTypeIcons, PFS.playerPokemons[i].type[1], _x + 40, _y + 36 + _yoff, 0.25, 0.25, 0, c_white, 1);
			}
			_yoff += 60;
		}
		break;
}
#endregion

#region Battle Area
var _pokemon = PFS.playerPokemons[pokemonOut];
#region Player Pokemon Info
_x = _startx + (windowSize[0] * 0.40);
_y = _starty + (windowSize[1] * 0.75);
var _boxEndX = _startx + (windowSize[0] * 0.70);
var _boxEndY = _starty + (windowSize[1] * 0.95);
poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, PFSBattleSides.Player);
#endregion
#region Enemy Pokemon Info
_pokemon = enemyPokemon[0];
_x = _startx + (windowSize[0] * 0.02);
_y = _starty + (windowSize[1] * 0.03);
_boxEndX = _startx + (windowSize[0] * 0.30);
_boxEndY = _starty + (windowSize[1] * 0.23);
poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, PFSBattleSides.Enemy);
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
		switch (selectedMenu) {
		    case PFSBattleMenus.Run:
		        array_push(turnSteps, [PFSTurnType.Run]);
				doTurn = true;
		        break;
		    default:
		        // code here
		        break;
		}
	}
    _yoff += 30;
}
#endregion
draw_set_color(c_white);