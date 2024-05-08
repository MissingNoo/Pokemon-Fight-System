//Feather disable GM2017
draw_sprite_ext(sEndResult, 0, GW/2, GH/2, 3, 3, 0, c_white, 1);
#region Start Variables
startPosition[0] = stx;
startPosition[1] = sty;
DebugManager.debug_add_config(self, {
	text : "Stx",
	type : DebugTypes.UpDown,
	variable : "stx",
	//func: function(){},
	page : "Battle"
});
DebugManager.debug_add_config(self, {
	text : "Sty",
	type : DebugTypes.UpDown,
	variable : "sty",
	//func: function(){},
	page : "Battle"
});
var _startx = startPosition[0];
var _starty = startPosition[1];
var _yoff = 0;
var _xoff = 0;
#endregion

#region Debug
//DebugManager.debug_add_config($"a:{a}", DebugTypes.UpDown, self, "a", undefined, "Battle");
//DebugManager.debug_add_config($"b:{b}", DebugTypes.UpDown, self, "b", undefined, "Battle");
//DebugManager.debug_add_config($"c:{c}", DebugTypes.UpDown, self, "c", undefined, "Battle");
//DebugManager.debug_add_config($"d:{d}", DebugTypes.UpDown, self, "d", undefined, "Battle");
#endregion

#region Main Window
windowSize = [windowXScale * 100, windowYScale * 100];
DebugManager.debug_add_config(self, {
	text : "Window X Size",
	type : DebugTypes.UpDown,
	variable : "windowXScale",
	//func: function(){},
	page : "Battle"
});
DebugManager.debug_add_config(self, {
	text : "Window Y Size",
	type : DebugTypes.UpDown,
	variable : "windowYScale",
	//func: function(){},
	page : "Battle"
});
//DebugManager.debug_add_config($"Window X Size:{windowXScale}", DebugTypes.UpDown, self, "windowXScale", undefined, "Battle");
//DebugManager.debug_add_config($"Window Y Size:{windowYScale}", DebugTypes.UpDown, self, "windowYScale", undefined, "Battle");
var _x = _startx;
var _y = _starty;
draw_rectangle(_x, _y, _x + windowSize[0], _y + windowSize[1], true);
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

#region Selected Menu
if (!selectingMenu) {
	//_x = _startx + a;
	//_y = _starty + b;
	////draw_rectangle(_x, _y, _startx + windowSize[0], _starty + (windowSize[1] * 0.65), true);
	//_x += 10;
	//_y += 10;
	_xoff = 0;
	_yoff = 0;
	switch (selectedMenu) {
	    case PFSBattleMenus.Battle:
			_x = _startx + 1;
			_y = _starty + 337;
			draw_sprite_ext(PFSMoveWindow, 0, _x, _y, 3, 3, 0, c_white, 1);
			_yoff = 0;
			var moves = PFS.playerPokemons[pokemonOut].moves;
	        for (var i = 0; i < array_length(moves); ++i) {
				switch (i) {
				    case 0:
				        _xoff = 35;
				        _yoff = 25;
				        break;
				    case 1:
				        _xoff = 260;
				        _yoff = 25;
				        break;
				    case 2:
				        _xoff = 35;
				        _yoff = 75;
				        break;
				    case 3:
				        _xoff = 260;
				        _yoff = 75;
				        break;
				}
				var move = moves[i];
				if (selectedMove == i) {
				    draw_sprite_ext(PFSOptionSelected, 0, _x - 7 + _xoff, _y + 20 + _yoff, 2, 2, 0, c_white, 1);
				}
				draw_set_color(c_black);
				draw_text_transformed(_x + _xoff, _y + _yoff, move.internalName, 2, 2, 0);
				draw_set_color(c_white);
				#region unused
				//if (createbutton(_x, _y + _yoff, $"{move.internalName} {move.pp}/{move.maxpp}", 1, true, undefined) and move.pp > 0) {
				//	array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[0], move, PFSBattleSides.Player]);
				//	doTurn = true;
				//}
				//draw_sprite_ext(sPFSTypeIcons, move.type, _x + 8, _y + 36 + _yoff, 0.25, 0.25, 0, c_white, 1);
				//var _cat = sPFSPhysicalIcon;
				//switch (move.category) {
				//    case PFSMoveCategory.Physical:
				//        _cat = sPFSPhysicalIcon;
				//        break;
				//    case PFSMoveCategory.Special:
				//        _cat = sPFSSpecialIcon;
				//        break;
				//    case PFSMoveCategory.Status:
				//        _cat = sPFSStatusIcon;
				//        break;
				//}
				//draw_sprite_ext(_cat, 0, _x + 25, _y + 27 + _yoff, 0.15, 0.15, 0, c_white, 1);
				#endregion
			}
	        break;
		case PFSBattleMenus.Pokemon:
			_yoff = 0;
			for (var i = 0; i < array_length(PFS.playerPokemons); ++i) {
			    if (createbutton(_x, _y + _yoff, PFS.playerPokemons[i].internalName, 1) and PFS.playerPokemons[i].hp > 0) {
					array_push(turnSteps, [PFSTurnType.ChangePokemon, i]);
					if (pokePlayerDead) {
					    playerLastOneWasDead = true;
					}
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
}
#endregion

#region Options
if (selectingMenu) {
	_x = _startx + 361;
	_y = _starty + 337;
	draw_sprite_ext(PFSBehindBar, 0, _x - 360, _y, 3, 3, 0, c_white, 1);
	draw_sprite_ext(PFSOptionsMenu, 0, _x, _y, 3, 3, 0, c_white, 1);
	//draw_rectangle(_x, _y, _startx + windowSize[0], _starty + windowSize[1], true);
	_yoff = 0;
	_xoff = 0;
	var _optionsPos = [[35, 55], [205, 55], [35, 100], [205, 100]];
	draw_sprite_ext(PFSOptionSelected, 0, _x + _optionsPos[selectedMenu][0], _y + _optionsPos[selectedMenu][1], 3, 3, 0, c_white, 1);
	//for (var i = 0; i < array_length(menus); ++i) {
		//if (createbutton(_x + a, _y + b + _yoff, menus[i], 1, true, undefined, selectedMenu == i ? c_yellow : c_white)) {
		//    selectedMenu = i;
		//	switch (selectedMenu) {
		//	    case PFSBattleMenus.Run:
		//	        array_push(turnSteps, [PFSTurnType.Run]);
		//			doTurn = true;
		//	        break;
		//	    default:
		//	        // code here
		//	        break;
		//	}
		//}
	    //_yoff += 30;
	//}
}
#endregion
draw_set_color(c_white);