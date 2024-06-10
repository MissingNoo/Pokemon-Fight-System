//Feather disable GM2017
var _upDown = (- input_check_pressed("up") + input_check_pressed("down"));
if (input_check_pressed("left")) {
    selectedPokemon = 0;
}
if (input_check_pressed("right") and selectedPokemon == 0 and array_length(PFS.playerPokemons) > 1) {
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

if (input_check_pressed("accept")) {
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
			PFSFightSystem.pokemonOutNext = selectedPokemon;
			PFSFightSystem.lastpokemon = selectedPokemon;
			if (PFSFightSystem.pokePlayerDead) {
				PFSFightSystem.playerLastOneWasDead = true;
			}
			PFSFightSystem.pokePlayerDead = false;
			//PFSFightSystem.doTurn = true;
		}
		//PFSFightSystem.selectedMenu = 0;
		//PFSFightSystem.selectingMenu = true;
		instance_destroy();
	}
}