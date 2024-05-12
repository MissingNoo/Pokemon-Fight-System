//Feather disable GM2017
if (instance_number(PFSFightSystem) > 1) { instance_destroy(); }
#region Turn data
playerLastOneWasDead = false;
lastUsedMove = 0;
lastEnemyUsedMove = 0;
currentTurn = 0;
pokePlayerDead = false;
turnSteps = [];
doTurn = false;
enemyhplerp = 0;
pokemonhplerp = 0;
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

#region Battle
enemyOut = 0;
pokemonOut = 0;
for (var i = 0; i < array_length(PFS.playerPokemons); ++i) {
    if (PFS.playerPokemons[i].hp > 0) {
	    pokemonOut = i;
		break;
	}
}
enemySprite = sPFSBulbasaurBack;
pokemonSprite = sPFSBulbasaurBack;
selectedMove = 0;
#endregion

#region Window
windowSize = [700, 400];
startPosition = [GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2)];
stx = startPosition[0];
sty = startPosition[1];
windowXScale = 7.21;
windowYScale = 4.81;
selectedMenu = 0;
selectingMenu = true;
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
#region PokeInfoVariables
enemyHpX = 26;
enemyHpY = 35;
enemyHpScale = 2.98;
playerHpX = 92;
playerHpY = -138;
playerHpScale = 2.98;
#endregion
function poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, _side){
	#region Poke Sprites
	var _px = _startx + (windowSize[0] * 0.07);
	var _py = _starty + (windowSize[1] * 0.45);
	var _sprite = _side == PFSBattleSides.Player ? pokemonSprite : enemySprite;
	if (sprite_exists(_sprite)) {
		//var _pos = _side == PFSBattleSides.Player ? [_px - sprite_get_width(_sprite) / 2, _boxEndY - 250 - sprite_get_height(_sprite) / 2] : [_px + 120 + sprite_get_width(_sprite) / 2, _py - 200 - sprite_get_height(_sprite) / 2];
		var _pos = _side == PFSBattleSides.Player ? [_px, _py - 60] : [_px + 360, _py - 230];
		draw_sprite_ext(_sprite, animatedSprites ? -1 : 0, _pos[0], _pos[1], 3, 3, 0, c_white, 1);
	}
	#endregion
	#region HP
	var _hpx = _x;
	var _hpy = _y;
	var _hp = _side == PFSBattleSides.Player ? pokemonhplerp : enemyhplerp;
	if (_side == PFSBattleSides.Enemy) {
		_hpx += enemyHpX;
		_hpy += enemyHpY;
		draw_healthbar(_hpx + 115, _hpy + 50, _hpx + 259, _hpy + 60, ((_hp / _pokemon.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
	    draw_sprite_ext(PFSEnemyHpBar, 0, _hpx, _hpy, enemyHpScale, enemyHpScale, 0, c_white, 1);
	}
	if (_side == PFSBattleSides.Player) {
		_hpx += playerHpX;
		_hpy += playerHpY;
		draw_healthbar(_hpx + 143, _hpy + 50, _hpx + 285, _hpy + 60, ((_hp / _pokemon.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
		draw_sprite_ext(PFSPlayerHpBar, 0, _hpx, _hpy, playerHpScale, playerHpScale, 0, c_white, 1);
	    
		_hpx += 28;
	}
	draw_set_color(c_black);
	draw_text_transformed(_hpx + 10, _hpy + 2, $"{_pokemon.internalName}", 2, 2, 0);
	draw_text_transformed(_hpx + 242, _hpy + 22, _pokemon.level, 1, 1, 0);
	draw_set_color(c_white);
	#endregion
	//var _status = "";
	//for (var i = 0; i < array_length(_pokemon.statusAilments); ++i) {
	//    _status = $"{_status} {PFS.StatusAilments[_pokemon.statusAilments[i][0]]} turns: {_pokemon.statusAilments[i][1]} ;";
	//}
	//draw_text(_x, _y - 50, _status);
	//draw_set_halign(fa_right);
	//draw_text(_boxEndX - 10, _y, $"{_pokemon.hp}/{_pokemon.base.hp}");
	
	//draw_set_halign(fa_left);
	//_y += 40;
	//var _xoff = 0;
	//var _array = _side == PFSBattleSides.Player ? PFS.playerPokemons : enemyPokemon;
	//for (var i = 0; i < array_length(_array); ++i) {
	//    draw_circle(_boxEndX - 15 - _xoff, _y, 7, PFS.playerPokemons[i].hp <= 0);
	//	_xoff += 20;
	//}
}
#endregion

load_sprite(PFS.playerPokemons[pokemonOut], 1);
load_sprite(enemyPokemon[enemyOut], 0);

#region Battle Start
//show_debug_log(true);
for (var i = 0; i < 100; ++i) {
    show_debug_message("");
}
show_debug_message("Starting battle!");
if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
	show_debug_message($"{PFS.playerPokemons[pokemonOut].internalName} breaks the mold!");
}
if (__PFS_pokemon_have_ability(enemyPokemon[0], "mold-breaker")) {
	show_debug_message($"{enemyPokemon[0].internalName} breaks the mold!");
}
#endregion