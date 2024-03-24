//Feather disable GM2017
if (keyboard_check_pressed(vk_numpad2)) {
    instance_destroy(PFSFightSystem);
}
if (keyboard_check_pressed(vk_numpad3)) {
    global.__PFS.playerPokemons[0] = __PFS_generate_pokemon(global.__PFS.Pokes[2]);
	//show_message(global.__PFS.playerPokemons[0]);
}
if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
	global.__PFS.playerPokemons[0] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 151)]);
	global.__PFS.playerPokemons[1] = __PFS_generate_pokemon(global.__PFS.Pokes[irandom_range(1, 151)]);
	var _randompoke = global.__PFS.Pokes[irandom_range(1, 151)];
	var _enemyPokemon = [__PFS_generate_pokemon(_randompoke)]
    instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
}
