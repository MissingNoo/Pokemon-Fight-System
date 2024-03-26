//Feather disable GM2017
if (keyboard_check_pressed(vk_numpad2)) {
    instance_destroy(PFSFightSystem);
}

if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
	//Random test team
	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[4]);
	PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[338]);
	PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[700]);
	PFS.playerPokemons[3] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
	PFS.playerPokemons[4] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
	PFS.playerPokemons[5] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
	//Random enemy
	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 151)])];
	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[1])];
	_enemyPokemon[0].level = 100;
	//Start Battle
    instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
}
