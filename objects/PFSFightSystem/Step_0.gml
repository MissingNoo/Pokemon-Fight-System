//Feather disable GM2017
//Feather disable GM1041
global.dialogdata[$ "pokeplayer"] = PFS.playerPokemons[pokemonOut].internalName;
global.dialogdata[$ "enemypoke"] = enemyPokemon[enemyOut].internalName;
if (lastUsedMove != 0) {
	global.dialogdata[$ "playermove"] = PFS.moves[lastUsedMove].internalName;
}
if (lastEnemyUsedMove != 0) {
	global.dialogdata[$ "enemymove"] = PFS.moves[lastEnemyUsedMove].internalName;
}
pokemonhplerp = lerp(pokemonhplerp, PFS.playerPokemons[pokemonOut].hp, 0.1);
enemyhplerp = lerp(enemyhplerp, enemyPokemon[enemyOut].hp, 0.1);
if (instance_exists(oDialog)) {
	exit;
}
//if (dialog != noone) {
//	dialog = instance_find(oDialog, 0);
	
	//waittime = 10;
    //dialog.battlecoords();
	//exit;
//}
//if (keyboard_check_pressed(vk_numpad8)) {
//    display_set_gui_size(window_get_width(), window_get_height());
//	startPosition = [display_get_gui_width() / 2 - 350, display_get_gui_height() / 2 - 300];
//}
if (!enemy_alive()) {
	instance_destroy();
}
sys.step();