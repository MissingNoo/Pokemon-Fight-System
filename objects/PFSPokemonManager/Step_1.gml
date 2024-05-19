//Feather disable GM2017
var _upDown = (- keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down));
if (keyboard_check_pressed(vk_left)) {
    selectedPokemon = 0;
}
if (keyboard_check_pressed(vk_right) and selectedPokemon == 0 and array_length(PFS.playerPokemons) > 1) {
    selectedPokemon = 1;
}

if (selectedPokemon == 0 and _upDown == -1) {
    selectedPokemon = 7;
}
else {
	selectedPokemon += _upDown;
	if (selectedPokemon < 0) { selectedPokemon = 7; }
	if (selectedPokemon > 7) { selectedPokemon = 0; }
	if (selectedPokemon > array_length(PFS.playerPokemons) - 1) { selectedPokemon = 7; }
	if (selectedPokemon == 7 and _upDown == -1) { selectedPokemon = array_length(PFS.playerPokemons) - 1; }
}

if (keyboard_check_pressed(ord("Z"))) {
    if (selectedPokemon == 7 and !PFSFightSystem.pokePlayerDead) {
		PFSFightSystem.selectingMenu = true;
	    instance_destroy();
	}
	else {
		if (selectedPokemon != 7 and PFS.playerPokemons[selectedPokemon].hp == 0) {
		    exit;
		}
		if (selectedPokemon != 7 and selectedPokemon != PFSFightSystem.pokemonOut) {
			//Feather disable GM1041
		    array_push(PFSFightSystem.turnSteps, [PFSTurnType.ChangePokemon, selectedPokemon]);
			if (PFSFightSystem.pokePlayerDead) {
				PFSFightSystem.playerLastOneWasDead = true;
			}
			PFSFightSystem.pokePlayerDead = false;
			PFSFightSystem.doTurn = true;
		}
		PFSFightSystem.selectedMenu = 0;
		PFSFightSystem.selectingMenu = true;
		instance_destroy();
	}
}