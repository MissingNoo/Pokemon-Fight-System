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
    if (selectedPokemon == 7 and !NewFightSystem.poke_player_dead) {
		//NewFightSystem.selectingMenu = true;
		NewFightSystem.fsm.change("Idle");
	    instance_destroy();
	}
	else {
		if (selectedPokemon != 7 and PFS.playerPokemons[selectedPokemon].hp == 0) {
		    exit;
		}
		if (selectedPokemon != 7 and selectedPokemon != NewFightSystem.pokemon_out) {
			//Feather disable GM1041
		    array_push(NewFightSystem.turn_steps, {
				type : PFSTurnType.ChangePokemon,
				next : selectedPokemon
			});
			NewFightSystem.next_out = selectedPokemon;
			//NewFightSystem.lastpokemon = selectedPokemon;
			if (NewFightSystem.poke_player_dead) {
				NewFightSystem.player_last_one_was_dead = true;
			}
			NewFightSystem.poke_player_dead = false;
			NewFightSystem.fsm.change("Pre_turn");
		}
		//NewFightSystem.selectedMenu = 0;
		//NewFightSystem.selectingMenu = true;
		instance_destroy();
	}
}