//Feather disable GM2017
if (instance_exists(PFSPokemonManager)) {
    exit;
}
var _leftRight = - keyboard_check_pressed(vk_left) + keyboard_check_pressed(vk_right);
	var _upDown = (- keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down)) * 2;
if (selectingMenu) {
    selectedMenu += _leftRight + _upDown;
	if (selectedMenu < 0) { selectedMenu = 0; }
	if (selectedMenu > 3) { selectedMenu = 3; }
	if (keyboard_check_pressed(ord("Z"))) {
		switch (selectedMenu) {
			case PFSBattleMenus.Run:
			    array_push(turnSteps, [PFSTurnType.Run]);
				doTurn = true;
			    break;
			case PFSBattleMenus.Pokemon:
				instance_create_depth(0, 0, -1, PFSPokemonManager, {onBattle : true});
				break;
			case PFSBattleMenus.Item:
				instance_create_depth(0, 0, -1, oBag, {onBattle : true});
				break;
			case PFSBattleMenus.Battle:
			    if (selectedMove > array_length(PFS.playerPokemons[pokemonOut].moves) - 1) { selectedMove = array_length(PFS.playerPokemons[pokemonOut].moves) - 1; }
			    break;
		}
	    selectingMenu = false;
		exit;
	}
}
if (!selectingMenu) {
	if (selectedMenu == PFSBattleMenus.Battle) {
	    selectedMove += _leftRight + _upDown;
		if (selectedMove < 0) { selectedMove = 0; }
		if (selectedMove > array_length(PFS.playerPokemons[pokemonOut].moves) - 1) { selectedMove = array_length(PFS.playerPokemons[pokemonOut].moves) - 1; }
		if (keyboard_check_pressed(ord("Z"))) {
			array_push(turnSteps, [PFSTurnType.Move, PFS.playerPokemons[pokemonOut], enemyPokemon[0], PFS.playerPokemons[pokemonOut].moves[selectedMove], PFSBattleSides.Player]);
			doTurn = true;
		    selectingMenu = true;
			exit;
		}
	}
}