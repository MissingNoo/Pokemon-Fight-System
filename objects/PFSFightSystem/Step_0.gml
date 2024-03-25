//Feather disable GM2017
if (pokePlayerDead) {
    selectedMenu = __PFSBattleMenus.Pokemon;
}
if (keyboard_check_pressed(vk_numpad8)) {
    display_set_gui_size(window_get_width(), window_get_height());
	startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
}

if (keyboard_check_pressed(vk_f1)) {
    doTurn = true;
	show_message(turnSteps);
}

if (doTurn) {
	if (!enemy_alive()) {
	    doTurn = false;
		exit;
	}
	var _rnd = irandom_range(0, array_length(enemyPokemon[0].moves) - 1);
	array_push(turnSteps, [__PFSTurnType.Move, enemyPokemon[0], global.__PFS.playerPokemons[pokemonOut], enemyPokemon[0].moves[_rnd], __PFSBattleSides.Enemy]); //TODO: enemy don't attack if you released a new pokemon after the last one died
	show_debug_message($"");
	order_turn();
	show_debug_message($"Turn step: {currentTurn}");
	for (var i = 0; i < array_length(turnSteps); ++i) {
	    switch (turnSteps[i][0]) {
		    case __PFSTurnType.Move:
				switch (turnSteps[i][4]) {
				    case __PFSBattleSides.Player:
				        turnSteps[i][1].hp = global.__PFS.playerPokemons[pokemonOut].hp;
						for (var j = 0; j < array_length(global.__PFS.playerPokemons[pokemonOut].moves); ++j) {
					    if (global.__PFS.playerPokemons[pokemonOut].moves[j].id == turnSteps[i][3].id) {
							    global.__PFS.playerPokemons[pokemonOut].moves[j].pp--;
								break;
							}
						}
				        break;
				    case __PFSBattleSides.Enemy:
				        turnSteps[i][1].hp = enemyPokemon[0].hp;
						for (var j = 0; j < array_length(enemyPokemon[0].moves); ++j) {
					    if (enemyPokemon[0].moves[j].id == turnSteps[i][3].id) {
							    enemyPokemon[0].moves[j].pp--;
								break;
							}
						}
				        break;
				}
		        __PFS_use_move(turnSteps[i][1], turnSteps[i][2], turnSteps[i][3], turnSteps[i][4]);
		        break;
			case __PFSTurnType.ChangePokemon:
				show_debug_message("Changed Pokemon");
				pokemonOut = turnSteps[i][1];
				load_sprite(global.__PFS.playerPokemons[pokemonOut], 1);
				break;
			case __PFSTurnType.Run:
				show_debug_message("Ran from battle");
				instance_destroy();
				break;
		    default:
		        // code here
		        break;
		}
		array_shift(turnSteps);
		i--;
	}
	currentTurn++;
	if (global.__PFS.playerPokemons[pokemonOut].hp <= 0) {
	    pokePlayerDead = true;
	}
    doTurn = false;
}