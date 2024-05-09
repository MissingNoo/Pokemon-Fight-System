//Feather disable GM2017
var _upDown = (- keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down));
if (keyboard_check_pressed(vk_left)) {
    selectedPokemon = 0;
}
if (keyboard_check_pressed(vk_right) and selectedPokemon == 0 and array_length(PFS.playerPokemons) > 1) {
    selectedPokemon = 1;
}
selectedPokemon += _upDown;
if (selectedPokemon > array_length(PFS.playerPokemons) - 1 and selectedPokemon < 7) { selectedPokemon = array_length(PFS.playerPokemons) - 1; }
if (selectedPokemon < 0) { selectedPokemon = 7; }
if (selectedPokemon > array_length(PFS.playerPokemons) - 1) { selectedPokemon = 7; }
if (selectedPokemon > 7) { selectedPokemon = 0; }
if (keyboard_check_pressed(ord("Z"))) {
    if (selectedPokemon == 7 and !PFSFightSystem.pokePlayerDead) {
		PFSFightSystem.selectingMenu = true;
	    instance_destroy();
	}
	else {
		if (selectedPokemon != 7 and selectedPokemon != PFSFightSystem.pokemonOut) {
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