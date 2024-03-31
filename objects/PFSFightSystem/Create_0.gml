//Feather disable GM2017
show_debug_log(true);
show_debug_message("Starting battle!");
#region Turn data
lastUsedMove = 0;
lastEnemyUsedMove = 0;
currentTurn = 0;
pokePlayerDead = false;
turnSteps = [];
doTurn = false;
enum PFSTurnType {
	Move,
	ChangePokemon,
	UseItem,
	Run
}
function order_turn() {
	array_sort(turnSteps, function(elm1, elm2) {
		var _goAfter = false;
		if (elm1[0] == PFSTurnType.Move and elm2[0] == PFSTurnType.Move) {
			//show_debug_message($"{elm1[1].internalName} speed: {elm1[1].speed} / {elm2[1].internalName} speed: {elm2[1].speed}");
			elm1[1] = variable_clone(elm1[1]);
			elm2[1] = variable_clone(elm2[1]);
			#region Paralysis
			if (__PFS_pokemon_affected_by_status(elm1[1], PFSStatusAilments.Paralysis)) {
			    elm1[1].speed = elm1[1].speed * 0.5;
			}
			if (__PFS_pokemon_affected_by_status(elm2[1], PFSStatusAilments.Paralysis)) {
			    elm2[1].speed = elm2[1].speed * 0.5;
			}
			#endregion
			if (elm1[1].speed < elm2[1].speed) {
			    _goAfter = true;
			}
		    if (elm1[3].priority < elm2[3].priority) {
			    _goAfter = true;
			}
		}
		else {
			_goAfter =  elm1[0] < elm2[0];
		}
	    return _goAfter;
	});
}

function enemy_alive() {
	//Feather disable once GM1041
	for (var i = 0; i < array_length(enemyPokemon); ++i) {
	    if (enemyPokemon[i].hp > 0) {
		    return true;
		}
	}
	return false;
}
#endregion

#region Debug
a = 0;
b = 0;
c = 0;
d = 0;
DebugManager.debug_add_config(self, {
	text : "a",
	type : DebugTypes.UpDown,
	variable : "a",
	//func: function(){},
	page : "Battle"
});
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
animatedSprites = false;
#endregion

#region Function
function load_sprite(pokemon, side){
	var _extension = ".png";
	var _imgnumb = 0;
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png")) {
	    _extension = ".png";
	}
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.internalName + ".ini")) {
		ini_open(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.internalName + ".ini");
		_imgnumb = ini_read_real("image", "frames", 1);
		_extension = string_concat("_strip", _imgnumb, ".png");
		ini_close()
	}
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + _extension)) {
		switch (side) {
			case 0:
		        if (sprite_exists(enemySprite)) {
				    sprite_delete(enemySprite);
				}
			    enemySprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[0] + _extension, _imgnumb, false, false, 0, 0);
		        break;
		    case 1:
		        if (sprite_exists(pokemonSprite)) {
				    sprite_delete(pokemonSprite);
				}
			    pokemonSprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + _extension, _imgnumb, false, false, 0, 0);
		        break;
		}
	}
}

function poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, _side){
	draw_rectangle(_x, _y, _boxEndX, _boxEndY, true);
	_x += 10;
	_y += 10;
	draw_text(_x, _y, $"{_pokemon.internalName}");
	var _status = "";
	for (var i = 0; i < array_length(_pokemon.statusAilments); ++i) {
	    _status = $"{_status} {PFS.StatusAilments[_pokemon.statusAilments[i][0]]} turns: {_pokemon.statusAilments[i][1]} ;";
	}
	draw_text(_x, _y - 50, _status);
	draw_healthbar(_x, _y + 20, _boxEndX - 10, _y + 25, ((_pokemon.hp / _pokemon.base.hp) * 100), c_red, c_lime, c_lime, 0, 1, 0);
	draw_set_halign(fa_right);
	draw_text(_boxEndX - 10, _y, $"{_pokemon.hp}/{_pokemon.base.hp}");
	draw_text(_boxEndX - 10, _y + 45, $"LV:{_pokemon.level}");
	draw_set_halign(fa_left);
	_y += 40;
	var _xoff = 0;
	var _array = _side == PFSBattleSides.Player ? PFS.playerPokemons : enemyPokemon;
	for (var i = 0; i < array_length(_array); ++i) {
	    draw_circle(_boxEndX - 15 - _xoff, _y, 7, PFS.playerPokemons[i].hp <= 0);
		_xoff += 20;
	}
	_x = _startx + (windowSize[0] * 0.07);
	_y = _starty + (windowSize[1] * 0.45);
	var _sprite = _side == PFSBattleSides.Player ? pokemonSprite : enemySprite;
	if (sprite_exists(_sprite)) {
		var _pos = _side == PFSBattleSides.Player ? [_x - sprite_get_width(_sprite) / 2, _boxEndY - 250 - sprite_get_height(_sprite) / 2] : [_x + 120 + sprite_get_width(_sprite) / 2, _y - 200 - sprite_get_height(_sprite) / 2];
		draw_sprite_ext(_sprite, animatedSprites ? -1 : 0, _pos[0], _pos[1], 3, 3, 0, c_white, 1);
	}
}
#endregion

load_sprite(PFS.playerPokemons[0], 1);
load_sprite(enemyPokemon[enemyOut], 0);