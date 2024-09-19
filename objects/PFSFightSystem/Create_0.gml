//Feather disable GM2017
enemyDead = false;
show_debug_message(json_stringify(PlayerTeam[0]))
EnemyTeam = enemyPokemon;
if (instance_number(PFSFightSystem) > 1) { instance_destroy(); }
if (!wildPokemon) {
    enemyPokemon = trainer.team;
	for (var i = 0; i < array_length(enemyPokemon); ++i) {
	    enemyPokemon[i] = __PFS_recalculate_stats(enemyPokemon[i], true);
	}
}
#region System
fightsurface = surface_create(240*3, 160*3);
caninteract = true;
laststate = "";
escape_attempts = 0;
#endregion

#region Turn data
lastpokemon = 0;
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
#endregion

#region Battle
enemyOut = 0;
pokemonOut = 0;
pokemonOutNext = 0;
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
	var _side = side == PFSBattleSides.Player ? "Front/" : "Back/";
	var _sprite_path = working_directory + "PFS/Sprites/Pokemon/"  + _side + string_upper(pokemon.identifier) + _extension;
	if (file_exists(_sprite_path)) {
		switch (side) {
			case 0:
		        if (sprite_exists(enemySprite)) {
				    sprite_delete(enemySprite);
				}
			    enemySprite = sprite_add(_sprite_path, _imgnumb, false, false, 192/2, 192);
		        break;
		    case 1:
		        if (sprite_exists(pokemonSprite)) {
				    sprite_delete(pokemonSprite);
				}
			    pokemonSprite = sprite_add(_sprite_path, _imgnumb, false, false, 192/1.5, 192);
		        break;
		}
	}
}
#region PokeInfoVariables
playerpokesize = 0;
playerpokesizelerp = 0;
enemypokesizelerp = 0;
enemypokesize = 0;
if (wildPokemon) {
    enemypokesizelerp = 1;
	enemypokesize = 1;
}
enemyHpX = 26;
enemyHpY = 35;
enemyHpScale = 2.98;
playerHpX = 388;
playerHpY = 224;
playerHpScale = 2.98;
#endregion
function poke_info(_startx, _starty, _x, _y, _boxEndX, _boxEndY, _pokemon, _side){
	_startx = 0;
	_starty = 0;
	_x = 0;
	_y = 0;
	#region Poke Sprites
	var _sprite = _side == PFSBattleSides.Player ? pokemonSprite : enemySprite;
	if (sprite_exists(_sprite)) {
		//var _pos = _side == PFSBattleSides.Player ? [_px - sprite_get_width(_sprite) / 2, _boxEndY - 250 - sprite_get_height(_sprite) / 2] : [_px + 120 + sprite_get_width(_sprite) / 2, _py - 200 - sprite_get_height(_sprite) / 2];
		var _pos = _side == PFSBattleSides.Player ? [playerpathx[0], playerpathy - 60] : [enemypathx[0], enemypathy + 20  + enemyyoffset];
		var _scale = _side == PFSBattleSides.Player ? 1 * playerpokesize : 1.5 * enemypokesize;
		var _alpha = _side == PFSBattleSides.Player ? 1: enemyalpha;
		var _draw = true;
		if (_side == PFSBattleSides.Player and (!battlestartfinished or _scale <= 0.2)) {
		    _draw = false;
			draw_sprite_ext(sPlayerBallThrow, playerthrow[1], _pos[0] + playerthrow[4], _pos[1], 3, 3, 0, c_white, 1);
		}
		if (_side == PFSBattleSides.Enemy and !enemybattlestartfinished and !wildPokemon) {
		    _draw = false;
			draw_sprite_ext(trainer.sprite, 0, _pos[0] + enemytraineroffset, _pos[1] - 60, 3, 3, 0, c_white, 1);
		}
		if (_draw) {
		    draw_sprite_ext(_sprite, animatedSprites ? -1 : 0, _pos[0], _pos[1], _scale, _scale, 0, c_white, _alpha);
			if (_side == PFSBattleSides.Enemy and wildPokemon) {
			    draw_sprite_ext(_sprite, animatedSprites ? -1 : 0, _pos[0], _pos[1], _scale, _scale, 0, c_black, wildenemyalpha);
			}
		}
	}
	#endregion
	#region HP
	var _hpx = _x;
	var _hpy = _y;
	var _hp = _side == PFSBattleSides.Player ? pokemonhplerp : enemyhplerp;
	var _draw = true;
	if (_side == PFSBattleSides.Enemy) {
		_hpx += enemyHpX + wildenemyhpoffset;
		_hpy += enemyHpY;
		draw_healthbar(_hpx + 115, _hpy + 50, _hpx + 259, _hpy + 60, ((_hp / _pokemon.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
	    draw_sprite_ext(PFSEnemyHpBar, 0, _hpx, _hpy, enemyHpScale, enemyHpScale, 0, c_white, 1);
		var ailoffset = 0;
		for (var i = 0; i < array_length(EnemyTeam[enemyOut].statusAilments); ++i) {
			var status = EnemyTeam[enemyOut].statusAilments[i][0];
			if (status > 5) { continue; }
		    draw_sprite_ext(PFSStatusIcons, status, _hpx + 66 + ailoffset, _hpy + 86, 2, 2, 0, c_white, 1);
			ailoffset += 50;
		}
	}
	if (_side == PFSBattleSides.Player) {
		_hpx += playerHpX;
		_hpy += playerHpY;
		if (!battlestartfinished) {
		    _draw = false;
		}
		if (_draw) {
		    draw_healthbar(_hpx + 143, _hpy + 50, _hpx + 285, _hpy + 60, ((_hp / _pokemon.base.hp) * 100), #536C5B, c_lime, c_lime, 0, 1, 0);
			draw_sprite_ext(PFSPlayerHpBar, 0, _hpx, _hpy, playerHpScale, playerHpScale, 0, c_white, 1);
			var ailoffset = 0;
			for (var i = 0; i < array_length(PlayerTeam[pokemonOut].statusAilments); ++i) {
				var status = PlayerTeam[pokemonOut].statusAilments[i][0];
				if (status > 5) { continue; }
			    draw_sprite_ext(PFSStatusIcons, status, _hpx + 60 + ailoffset, _hpy + 78, 2, 2, 0, c_white, 1);
				ailoffset += 50;
			}
		}
		_hpx += 28;
	}
	if (_draw) {
		scribble($"{_pokemon.identifier}").scale(1, 1).draw(_hpx + 15, _hpy + 15);
		scribble(_pokemon.level).scale(0.5, 0.5).draw(_hpx + 242, _hpy + 16);
	}
	#endregion
}
#endregion
if (!wildPokemon) {
	global.dialogdata[$"trainername"] = trainer.name;
	spawn_dialog("Trainer");
}
#region animations
playerthrow = [false, 0, sprite_get_number(sPlayerBallThrow), sprite_get_speed(sPlayerBallThrow), 0];
currentanimation = "battlestart";
lastanimation = "";
animationended = false;
#region battle start
#region systems
//ParticleSystem1
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_spark);
part_type_size(ptype1, 1, 1, 0, 0);
part_type_scale(ptype1, 1, 1);
part_type_speed(ptype1, 5, 5, 0, 0);
part_type_direction(ptype1, 0, 360, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(ptype1, 1, 1, 1);
part_type_blend(ptype1, false);
part_type_life(ptype1, 20, 40);
part_system_automatic_draw(ps, false);

#endregion
currentside = PFSBattleSides.Enemy;
#region enemy
enemyrelease = false;
startenemyanimation = false;
enemybattlestartfinished = false;
enemytraineroffset = 0;
drawenemyball = false;
enemyyoffset = 0;
enemyalpha = 1;
#endregion

ballrotation = 0;
ballx = 90;
bally = 220;
ballyoff = -1;
ballendy = 340;
drawball = false;
battlestartfinished = false;
enemypathx = [-240, 542];
enemypathy = 240;
playerpathx = [800, 200];
playerpathy = 400;
wildenemyalpha = 0.75;
wildenemyhpoffset = -320;
#endregion
#endregion

load_sprite(PFS.playerPokemons[pokemonOut], 1);
load_sprite(enemyPokemon[enemyOut], 0);

#region Battle Start
//show_debug_log(true);
for (var i = 0; i < 100; ++i) {
	if (global.testing) {
	    continue;
	}
    show_debug_message("");
}
show_debug_message("[PFS] Starting battle!");
#endregion
dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : "Battle", text : "Enter", onBattle : true});
nextstate = "menu";
sys = new SnowState("animation");
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
		__PFS_turn_begin();
	},
})
.add("turn", {
	enter: function() {
		if (array_length(turnSteps) == 0) {
		    sys.change("menu");
		}
	},
	step: function() {
		__PFS_turn_step();
	},
	endturn: function(){
		if (array_length(turnSteps) == 0) {
			PFS.playerPokemons[pokemonOut] = __PFS_tick_status_effect(PFS.playerPokemons[pokemonOut]);
			enemyPokemon[enemyOut] = __PFS_tick_status_effect(enemyPokemon[enemyOut]);
			show_debug_message("[PFS] Turn End!");
			show_debug_message("");
			currentTurn++;
			playerLastOneWasDead = false;
			if (PFS.playerPokemons[pokemonOut].hp <= 0) {
				pokePlayerDead = true;
			}
			if (!__PFS_enemy_alive()) {
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
		if (pokePlayerDead) {
		    sys.change("pokeplayerdead");
		}
	},
	step: function() {
		var _leftRight = - input_check_pressed("left") + input_check_pressed("right");
		var _upDown = (- input_check_pressed("up") + input_check_pressed("down")) * 2;
		//if (selectingMenu) {
		selectedMenu += _leftRight + _upDown;
		if (selectedMenu < 0) { selectedMenu = 0; }
		if (selectedMenu > 3) { selectedMenu = 3; }
		if (caninteract and input_check_pressed("accept")) {
			startturn = true;
			switch (selectedMenu) {
				case PFSBattleMenus.Run:
					array_push(turnSteps, [PFSTurnType.Run]);
					sys.change("preturn");
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
		var _startx = 0;
		var _starty = 0;
		var _yoff = 0;
		var _xoff = 0;
		var _x = _startx + 361;
		var _y = _starty + 337;
		draw_sprite_ext(PFSBehindBar, 0, _x - 360, _y, 3, 3, 0, c_white, 1);
		draw_sprite_ext(PFSOptionsMenu, 0, _x, _y, 3, 3, 0, c_white, 1);
		//draw_rectangle(_x, _y, _startx + windowSize[0], _starty + windowSize[1], true);
		_yoff = 0;
		_xoff = 0;
		var _optionsPos = [[35, 55], [205, 55], [35, 100], [205, 100]];
		draw_sprite_ext(PFSOptionSelected, 0, _x + _optionsPos[selectedMenu][0], _y + _optionsPos[selectedMenu][1], 3, 3, 0, c_white, 1);
	},
	leave: function() {caninteract = false;},
	
})
.add("selectattack", {
	enter: function() {
		show_debug_message("selectattack");
	},
	step: function() {
		var _leftRight = - input_check_pressed("left") + input_check_pressed("right");
		var _upDown = (- input_check_pressed("up") + input_check_pressed("down")) * 2;
		selectedMove += _leftRight + _upDown;
		if (selectedMove < 0) { selectedMove = 0; }
		if (selectedMove > array_length(PFS.playerPokemons[pokemonOut].moves) - 1) { selectedMove = array_length(PFS.playerPokemons[pokemonOut].moves) - 1; }
		if (caninteract and input_check_pressed("accept")) {
			array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[enemyOut], PFS.playerPokemons[pokemonOut].moves[selectedMove], PFSBattleSides.Player]);
			sys.change("preturn");
			exit;
		}
	},
	draw: function() {
		var _startx = 0;
		var _starty = 0;
		var _yoff = 0;
		var _xoff = 0;
		var _x = _startx + 1;
		var _y = _starty + 337;
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
			scribble(move.identifier).draw(_x + _xoff, _y + _yoff + 6);
			#region unused
			//if (createbutton(_x, _y + _yoff, $"{move.identifier} {move.pp}/{move.maxpp}", 1, true, undefined) and move.pp > 0) {
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
		show_debug_message("choosing pokemon");
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
			currentanimation = "changepokemon";
			sys.change("animation");
		}
	},
	leave: function() {instance_destroy(PFSPokemonManager); caninteract = false;},
	
})
.add("animation", {
	enter: function(){
		show_debug_message($"show animation: {currentanimation}");
		animationended = false;
		if (currentanimation == "enemyfainted") {
			enemyyoffset = 0;
		}
		if (currentanimation == "enemyrelease") {
			startenemyanimation = true;
			enemyrelease = true;
		}
		if (currentanimation == "comeback") {
			drawball = true;
			ballrotation = 0;
		}
		if (currentanimation == "releasepokemon") {
			if (lastanimation == "comeback") {
				ballrotation = 0;
				ballx = -10;
				bally = 240;
				ballyoff = -1;
				ballendy = 340;
				drawball = true;
			}
			playerthrow[0] = true;
		}
		if (currentanimation == "changepokemon") {
		    animationended = true;
		}
	},
	step: function() {
		switch (currentanimation) {
			case "enemyrelease":{
				currentside = PFSBattleSides.Enemy;
				if (alarm[0] == -1) {
				    alarm[0] = 38;
				}
				sys.change("menu");
				break;}
			case "enemyfainted":{
				if (enemyyoffset < 200) {
				    enemyyoffset += 1.80;
				}
				if (enemyalpha > 0) {
				    enemyalpha -= 0.025;
					exit;
				}
				drawenemyball = true;
				currentanimation = "enemyrelease";
				sys.change("animation");
				break;}
			case "enemyenter":{
					if (instance_exists(oDialog)) {
					    exit;
					}
					if (enemytraineroffset < 300) {
						drawenemyball = true;
						enemytraineroffset += 6;
					    exit;
					}
					currentanimation = "enemyrelease";
					sys.change("animation");
				break;}
			case "comeback":{
				lastanimation = currentanimation;
				if (playerpokesize > 0.05) {
				    playerpokesize = lerp(playerpokesize, playerpokesizelerp, 0.1);
					exit;
				}
				currentanimation = "releasepokemon";
				sys.change("animation");
				break;}
			case "releasepokemon":{
				currentside = PFSBattleSides.Player;
				#region playerballthrown
				if (playerthrow[0]) {
					if (playerthrow[1] > 0) {
						playerthrow[4] -= 5;
					}
					if (playerthrow[1] <= playerthrow[2]) {
					    playerthrow[1] += playerthrow[3] / 60;
					}
					else {
						if (alarm[0] == -1) {
							alarm[0] = 38;
						}
					}
				}
				if (playerthrow[1] > 3) {
					if (bally < ballendy) {
						ballrotation += 13;
						drawball = true;
						bally += 7 * ballyoff;
						if (lastanimation == "comeback") {
						    ballx += 4;
						}
						else {
							ballx += 2;
						}
						ballyoff = lerp(ballyoff, 1, 0.05);
					}
				}
				#endregion
				break;}
		    case "battlestart":{
				if (enemypathx[0] < enemypathx[1]) {
					if (enemypathx[0] + 8 >= enemypathx[1]) {
					    enemypathx[0] = enemypathx[1];
						exit;
					}
				    enemypathx[0] += 8;
				}
				else {
					enemypathx[0] = enemypathx[1];
				}
				if (playerpathx[0] > playerpathx[1]) {
					if (playerpathx[0] - 8 <= playerpathx[1]) {
					    playerpathx[0] = playerpathx[1];
						exit;
					}
				    playerpathx[0] -= 8;
				}
				else {
					playerpathx[0] = playerpathx[1];
				}
				if (enemypathx[0] >= enemypathx[1]-100 and wildPokemon) {
					if (wildenemyalpha > 0) {
					    wildenemyalpha -= 0.05;
						exit;
					}
					else {
						wildenemyalpha = 0;
					}
				}
				if (wildenemyalpha == 0 or (!wildPokemon and enemyrelease)) {
				    if (wildenemyhpoffset < 0) {
						if (wildenemyhpoffset + 10 >= 0) {
						    wildenemyhpoffset = 0;
							exit;
						}
					    wildenemyhpoffset += 10;
					}
				}
				if (enemypathx[0] == enemypathx[1] and !instance_exists(oDialog)) {
					if (wildPokemon and wildenemyalpha != 0 ) {
					    exit;
					}
					if (!wildPokemon and !startenemyanimation) {
						currentanimation = "enemyenter";
						sys.change("animation");
						exit;
					}
					if (wildPokemon and wildenemyhpoffset != 0) {
					    exit;
					}
					if (enemyrelease and wildenemyhpoffset != 0) {
					    exit;
					}
					else {
						currentside = PFSBattleSides.Player;
					}
					global.dialogdata[$"releasepoke"] = PFS.playerPokemons[pokemonOut].identifier;
					spawn_dialog("Release");
					if (__PFS_pokemon_have_ability(PFS.playerPokemons[pokemonOut], "mold-breaker")) {
						global.dialogdata[$"pokename"] = PFS.playerPokemons[pokemonOut].identifier;
						spawn_dialog("BreaksTheMold");
						show_debug_message($"{PFS.playerPokemons[pokemonOut].identifier} breaks the mold!");
					}
					currentanimation = "releasepokemon";
					sys.change("animation");
				}
			    break;}
		}
		if (animationended) {
		    switch (sys.get_previous_state()) {
				case "animation":
					if (lastanimation == "comeback") {
						lastanimation = "";
						spawn_dialog("SentOut");
						sys.change("turn");
					}
					else {
						sys.change("menu");	
					}
					break;
				case "choosingpokemon":
					if (pokemonOut != lastpokemon) {
						if (playerLastOneWasDead) {
							playerLastOneWasDead = false;
						    sys.change("turn");
						}
						else {
							sys.change("preturn");
						}
					}
					else {
						sys.change("turn");
					}
				    break;
			}
		}
	},
	leave: function() {
		caninteract = false; 
		drawball = false;
	},
	draw: function() {
		if (drawball) {
		    draw_sprite_ext(sPokeballNormal, 0, ballx, bally, 3, 3, ballrotation, c_white, 1);
		}
		if (drawenemyball) {
		    draw_sprite_ext(sPokeballNormal, 0, 550 + DebugManager.a, 180 + DebugManager.b, 3, 3, 0, c_white, 1);
		}
	}
	
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
		show_debug_message("open bag");
		instance_create_depth(0, 0, -1, oBag, {onBattle : true});
	},
	step: function(){
		
	},
	leave: function() {caninteract = false;}
});