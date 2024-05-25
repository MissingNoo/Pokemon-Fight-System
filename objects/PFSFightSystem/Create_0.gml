//Feather disable GM2017
if (instance_number(PFSFightSystem) > 1) { instance_destroy(); }
lastpokemon = 0;
caninteract = true;
laststate = "";
#region Turn data
startturn = true;
waittime = 0;
caught = false;
ranaway = false;
dialog = noone;
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
	EnemyChangePokemon,
	UseItem,
	Run
}
function order_turn() {
	array_sort(turnSteps, function(elm1, elm2) {
		var _goAfter = false;
		if (elm1[0] == PFSTurnType.Move and elm2[0] == PFSTurnType.Move) {
			//show_debug_message_debugmode($"{elm1[1].internalName} speed: {elm1[1].speed} / {elm2[1].internalName} speed: {elm2[1].speed}");
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
	//for (var i = 0; i < array_length(enemyPokemon); ++i) {
	    if (enemyPokemon[enemyOut].hp > 0) {
		    return true;
		}
	//}
	return false;
}
function enemy_team_defeated() {
	//Feather disable once GM1041
	for (var i = 0; i < array_length(enemyPokemon); ++i) {
	    if (enemyPokemon[i].hp > 0) {
		    return false;
		}
	}
	return true;
}
#endregion

#region Battle
enemyOut = 0;
pokemonOut = 0;
for (var i = 0; i < array_length(PFS.playerPokemons); ++i) {
    if (PFS.playerPokemons[i].hp > 0) {
	    pokemonOut = i;
		lastpokemon = i;
		pokemonhplerp = PFS.playerPokemons[i].hp;
		break;
	}
}
enemyhplerp = enemyPokemon[enemyOut].hp;
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
	if (file_exists(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png")) {
	    _extension = ".png";
	}
	if (file_exists(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.internalName + ".ini")) {
		ini_open(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.internalName + ".ini");
		_imgnumb = ini_read_real("image", "frames", 1);
		_extension = string_concat("_strip", _imgnumb, ".png");
		ini_close()
	}
	if (file_exists(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + _extension)) {
		switch (side) {
			case 0:
		        if (sprite_exists(enemySprite)) {
				    sprite_delete(enemySprite);
				}
			    enemySprite = sprite_add(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[0] + _extension, _imgnumb, false, false, 0, 0);
		        break;
		    case 1:
		        if (sprite_exists(pokemonSprite)) {
				    sprite_delete(pokemonSprite);
				}
			    pokemonSprite = sprite_add(working_directory + "PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + _extension, _imgnumb, false, false, 0, 0);
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
	draw_set_font(PFS.Fonts.BattleFont[3]);
	draw_text_transformed(_hpx + 15, _hpy + 15, $"{_pokemon.internalName}", 1, 1, 0);
	draw_set_font(PFS.Fonts.BattleFont[2]);
	draw_text_transformed(_hpx + 242, _hpy + 16, _pokemon.level, 1, 1, 0);
	draw_set_font(PFS.Fonts.PokeFont[3]);
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
    show_debug_message_debugmode("");
}
show_debug_message_debugmode("[PFS] Starting battle!");
if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
	global.dialogdata[$"pokename"] = PFS.playerPokemons[pokemonOut].internalName;
	array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
	show_debug_message_debugmode($"{PFS.playerPokemons[pokemonOut].internalName} breaks the mold!");
}
if (__PFS_pokemon_have_ability(enemyPokemon[enemyOut], "mold-breaker")) {
	global.dialogdata[$"pokename"] = enemyPokemon[enemyOut].internalName;
	array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
	show_debug_message_debugmode($"{enemyPokemon[enemyOut].internalName} breaks the mold!");
}
#endregion
dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : "Battle", text : "Enter", onBattle : true});
function spawn_dialog(text) {
	if (instance_exists(oDialog)) {
	    exit;
	}
	dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : "Battle", text, onBattle : true});
}
nextstate = "menu";
sys = new SnowState("menu");
sys.add("idle", {	
	enter: function() {
		//waittime = 10;
	},
	step: function() {
		waittime--;
		if (waittime > 0) {
		    exit;
		}
	},
	endstep: function() {
	}
})
.add("preturn", {
	enter: function(){
		show_debug_message_debugmode("preturn");
		var _rnd = irandom_range(0, array_length(enemyPokemon[enemyOut].moves) - 1);
		if (!playerLastOneWasDead) {
			array_push(turnSteps, [PFSTurnType.Move, enemyPokemon[enemyOut], PFS.playerPokemons[pokemonOut], enemyPokemon[enemyOut].moves[_rnd], PFSBattleSides.Enemy]); //TODO: enemy don't attack if you released a new pokemon after the last one died
			if (enemy_alive()) {
				show_debug_message_debugmode($"");
				order_turn();
				show_debug_message_debugmode($"Turn step: {currentTurn}");
			}
		}
		sys.change("turn");
	},
})
.add("turn", {
	enter: function() {
		if (array_length(turnSteps) == 0) {
		    sys.change("menu");
		}
	},
	step: function() {
		lastUsedMove = 0;
		lastEnemyUsedMove = 0;
		PFS.playerPokemons[pokemonOut] = __PFS_count_status_effect(PFS.playerPokemons[pokemonOut]);
		enemyPokemon[enemyOut] = __PFS_count_status_effect(enemyPokemon[enemyOut]);
		var _rnd = irandom_range(0, array_length(enemyPokemon[enemyOut].moves) - 1);
		if (enemy_team_defeated() and turnSteps[0][0] != PFSTurnType.Run) {
		//if (turnSteps[0][0] != PFSTurnType.Run) {
			exit;
		}
		switch (turnSteps[0][0]) {
			case PFSTurnType.Move:
				var _string = "";
				var _ability_result = __PFS_ability_before_move(turnSteps[0][1], turnSteps[0][3]);
				turnSteps[0][1] = _ability_result[0];
				turnSteps[0][3] = _ability_result[1];
				var _pokeside = turnSteps[0][4] == PFSBattleSides.Player ? PFS.playerPokemons[pokemonOut] : enemyPokemon[enemyOut];
				global.dialogdata[$"pokename"] = _pokeside.internalName;
				#region Status
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Sleep)) {
					_string = $"{_pokeside.internalName} is fast asleep!";
					show_debug_message_debugmode(_string);
					spawn_dialog($"Asleep");
					break;
				}
				if (__PFS_pokemon_affected_by_status(_pokeside, PFSStatusAilments.Paralysis)) {
					var _chance = irandom_range(0, 100);
					if (_chance <= 25) {
						show_debug_message_debugmode($"{_pokeside.internalName} is paralyzed! It can't move!");
						spawn_dialog($"Paralyzed");
						break;
					}
				}
				if (_pokeside.flinch) {
					if (__PFS_pokemon_have_ability(_pokeside, "inner-focus")) {
						show_debug_message_debugmode($"{_pokeside} won't flinch because of its Inner Focus!");
						spawn_dialog($"WontFlinch");
					}
					else {
						show_debug_message_debugmode($"{turnSteps[0][1].internalName} flinched due to {turnSteps[0][2].internalName}'s Stench");
						spawn_dialog($"Flinched");
						break;
					}
				}
				for (var j = 0; j < array_length(_pokeside.moves); ++j) {
					if (_pokeside.moves[j].id == turnSteps[0][3].id) {
						_pokeside.moves[j].pp--;
						break;
					}
				}
				#endregion
			
				switch (turnSteps[0][4]) {
					case PFSBattleSides.Player:
						turnSteps[0][1].hp = PFS.playerPokemons[pokemonOut].hp;
						if (turnSteps[0][1].hp > 0) {
							spawn_dialog($"PlayerUsedMove");
						}
						lastUsedMove = turnSteps[0][3].id;
						break;
					case PFSBattleSides.Enemy:
						turnSteps[0][1].hp = enemyPokemon[enemyOut].hp;
						if (turnSteps[0][1].hp > 0) {
							spawn_dialog($"EnemyUsedMove");
						}
						lastEnemyUsedMove = turnSteps[0][3].id;
						break;
				}
				__PFS_use_move(turnSteps[0][1], turnSteps[0][2], turnSteps[0][3], turnSteps[0][4]);
				break;
			case PFSTurnType.ChangePokemon: //TODO: redo
				for (var j = 0; j < array_length(PFS.playerPokemons[pokemonOut].statusAilments); ++j) {
					if (PFS.playerPokemons[pokemonOut].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
						array_delete(PFS.playerPokemons[pokemonOut].statusAilments, j, 1);
						j = 0;
					}
				}
				pokemonOut = turnSteps[0][1];
				pokemonhplerp = PFS.playerPokemons[pokemonOut].hp; //TODO: enemy pokemon
				show_debug_message_debugmode($"Sent {PFS.playerPokemons[pokemonOut].internalName} out!");
				spawn_dialog("SentOut");
				if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
					global.dialogdata[$"pokename"] = enemyPokemon[enemyOut].internalName;
					show_debug_message_debugmode($"{PFS.playerPokemons[pokemonOut].internalName} breaks the mold!");
					array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
				}
				load_sprite(PFS.playerPokemons[pokemonOut], 1);
				break;
			case PFSTurnType.EnemyChangePokemon: //TODO: redo
				for (var j = 0; j < array_length(enemyPokemon[enemyOut].statusAilments); ++j) {
					if (enemyPokemon[enemyOut].statusAilments[j][0] == PFSStatusAilments.Perish_song) {
						array_delete(enemyPokemon[enemyOut].statusAilments, j, 1);
						j = 0;
					}
				}
				enemyOut = turnSteps[0][1];
				enemyhplerp = enemyPokemon[enemyOut].hp; //TODO: enemy pokemon
				show_debug_message_debugmode($"Foe sent {enemyPokemon[enemyOut].internalName} out!");
				spawn_dialog("EnemySentOut");
				if (__PFS_pokemon_have_ability(enemyPokemon[enemyOut], "mold-breaker")) {
					global.dialogdata[$"pokename"] = enemyPokemon[enemyOut].internalName;
					show_debug_message_debugmode($"{enemyPokemon[enemyOut].internalName} breaks the mold!");
					array_push(global.nextdialog, {npc : "Battle", text : $"BreaksTheMold", onBattle : true});
				}
				load_sprite(enemyPokemon[enemyOut], 0);
				break;
			case PFSTurnType.UseItem://TODO: Ball shakes
				switch (turnSteps[0][1].usetype) {
					case UseType.PokeBall:
						if (was_caught(enemyPokemon[enemyOut], turnSteps[0][1].catchrate)) {
							show_debug_message_debugmode($"[PFS] {enemyPokemon[enemyOut].internalName} was caught!");
							spawn_dialog($"Caught");
							array_push(PFS.playerPokemons, enemyPokemon[enemyOut]);
							turnSteps = [];
							doTurn = false;
							caught = true;
						}
						break;
				}
				break;
			case PFSTurnType.Run:
				PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
				show_debug_message_debugmode("Ran from battle");
				spawn_dialog($"RanAway");
				ranaway = true;
				break;
		}
		PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
		enemyPokemon[enemyOut] = __PFS_tick_status_effect(enemyPokemon[enemyOut]);
		array_shift(turnSteps);
		exit;
	},
	endturn: function(){
		if (array_length(turnSteps) == 0) {
			show_debug_message("[PFS] Turn End!");
			currentTurn++;
			playerLastOneWasDead = false;
			if (PFS.playerPokemons[pokemonOut].hp <= 0) {
				pokePlayerDead = true;
			}
			if (!enemy_alive()) {
			    for (var i = 0; i < array_length(enemyPokemon); ++i) {
				    if (enemyPokemon[i].hp > 0) {
						array_push(PFSFightSystem.turnSteps, [PFSTurnType.EnemyChangePokemon, i]);
						sys.change("turn");
						exit;
					}
				}
			}
			sys.change("menu");
		}
	},
	leave: function() {caninteract = false;}
})
.add("menu", {
	enter: function() {
		caninteract = false;
		show_debug_message_debugmode("menu");
		if (pokePlayerDead) {
		    sys.change("pokeplayerdead");
		}
	},
	step: function() {
		var _leftRight = - keyboard_check_pressed(vk_left) + keyboard_check_pressed(vk_right);
		var _upDown = (- keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down)) * 2;
		//if (selectingMenu) {
		selectedMenu += _leftRight + _upDown;
		if (selectedMenu < 0) { selectedMenu = 0; }
		if (selectedMenu > 3) { selectedMenu = 3; }
		if (caninteract and keyboard_check_pressed(ord("Z"))) {
			startturn = true;
			switch (selectedMenu) {
				case PFSBattleMenus.Run:
					array_push(turnSteps, [PFSTurnType.Run]);
					sys.change("turn");
					break;
				case PFSBattleMenus.Pokemon:
					sys.change("choosingpokemon");
					break;
				case PFSBattleMenus.Item:
					sys.change("bag");
					break;
				case PFSBattleMenus.Battle:
					if (selectedMove > array_length(PFS.playerPokemons[pokemonOut].moves) - 1) { selectedMove = array_length(PFS.playerPokemons[pokemonOut].moves) - 1; }
					sys.change("selectattack");
					break;
			}
			//selectingMenu = false;
			exit;
		}
	//	}
	},
	draw: function() {
		var _startx = startPosition[0];
		var _starty = startPosition[1];
		var _yoff = 0;
		var _xoff = 0;
		var _x = _startx + 361;
		var _y = _starty + 337;
		draw_sprite_ext(PFSBehindBar, 0, _x - 360, _y, 3, 3, 0, c_white, 1);
		draw_sprite_ext(PFSOptionsMenu, 0, _x, _y, 3, 3, 0, c_white, 1);
		//draw_rectangle(_x, _y, _startx + windowSize[0], _starty + windowSize[1], true);
		var _yoff = 0;
		var _xoff = 0;
		var _optionsPos = [[35, 55], [205, 55], [35, 100], [205, 100]];
		draw_sprite_ext(PFSOptionSelected, 0, _x + _optionsPos[selectedMenu][0], _y + _optionsPos[selectedMenu][1], 3, 3, 0, c_white, 1);
	},
	leave: function() {caninteract = false;},
	
})
.add("selectattack", {
	enter: function() {
		show_debug_message_debugmode("selectattack");
	},
	step: function() {
		var _leftRight = - keyboard_check_pressed(vk_left) + keyboard_check_pressed(vk_right);
		var _upDown = (- keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down)) * 2;
		selectedMove += _leftRight + _upDown;
		if (selectedMove < 0) { selectedMove = 0; }
		if (selectedMove > array_length(PFS.playerPokemons[pokemonOut].moves) - 1) { selectedMove = array_length(PFS.playerPokemons[pokemonOut].moves) - 1; }
		if (caninteract and keyboard_check_pressed(ord("Z"))) {
			array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[enemyOut], PFS.playerPokemons[pokemonOut].moves[selectedMove], PFSBattleSides.Player]);
			sys.change("preturn");
			exit;
		}
	},
	draw: function() {
		var _startx = startPosition[0];
		var _starty = startPosition[1];
		var _yoff = 0;
		var _xoff = 0;
		var _x = _startx + 1;
		var _y = _starty + 337;
		draw_sprite_ext(PFSMoveWindow, 0, _x, _y, 3, 3, 0, c_white, 1);
		var _yoff = 0;
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
			draw_text_transformed(_x + _xoff, _y + _yoff + 6, move.internalName, 1, 1, 0);
			#region unused
			//if (createbutton(_x, _y + _yoff, $"{move.internalName} {move.pp}/{move.maxpp}", 1, true, undefined) and move.pp > 0) {
			//	array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[enemyOut], move, PFSBattleSides.Player]);
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
	},
	leave: function() {caninteract = false;}
	
})
.add("choosingpokemon", {
	enter: function() {
		show_debug_message_debugmode("choosing pokemon");
		instance_create_depth(0, 0, -1, PFSPokemonManager, {onBattle : true});
	},
	step: function() {
		if (pokePlayerDead and !instance_exists(PFSPokemonManager)) {
		    selectedMenu = PFSBattleMenus.Pokemon;
			instance_create_depth(0, 0, -1, PFSPokemonManager, {onBattle : true});
		}
	},
	endstep: function() {
		if (!pokePlayerDead and !instance_exists(PFSPokemonManager)) {
			sys.change("animation");
		}
	},
	leave: function() {instance_destroy(PFSPokemonManager); caninteract = false;},
	
})
.add("animation", {
	enter: function(){
		show_debug_message_debugmode("show animation");
		switch (sys.get_previous_state()) {
		    case "animation":
				sys.change("menu");
				break;
		    case "choosingpokemon":
				if (pokemonOut != lastpokemon) {
				    sys.change("preturn");
				}
				else {
					sys.change("turn");
				}
		        break;
		}
	},
	leave: function() {caninteract = false;},
	
})
.add("pokeplayerdead", {
	enter: function() {
		spawn_dialog($"PlayerPokemonFainted");
	},
	endstep: function() {
		if (!instance_exists(oDialog)) {
		    sys.change("choosingpokemon");
		}
	}	
})
.add("bag", {
	enter: function() {
		show_debug_message_debugmode("open bag");
		instance_create_depth(0, 0, -1, oBag, {onBattle : true});
	},
	step: function(){
		
	},
	leave: function() {caninteract = false;}
});