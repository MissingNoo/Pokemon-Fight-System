//Feather disable GM2017
if (keyboard_check_pressed(vk_numpad2)) {
    instance_destroy(PFSFightSystem);
}

if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
	//Random test team
	global.__PFS.playerPokemons[0] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	global.__PFS.playerPokemons[1] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	global.__PFS.playerPokemons[2] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	global.__PFS.playerPokemons[3] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	global.__PFS.playerPokemons[4] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	global.__PFS.playerPokemons[5] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 651)]);
	//Random enemy
	var _enemyPokemon = [__PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 151)])];
	//Start Battle
    instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
}
