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
pokemonhplerp = approach(pokemonhplerp, PFS.playerPokemons[pokemonOut].hp, 1);
enemyhplerp = approach(enemyhplerp, enemyPokemon[enemyOut].hp, 1);
enemypokesize = approach(enemypokesize, enemypokesizelerp, 0.1);
if (sys.get_current_state() != "animation") {
	playerpokesize = approach(playerpokesize, playerpokesizelerp, 0.1);
}
if (instance_exists(oDialog) and sys.get_current_state() != "animation") {
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
if (__PFS_enemy_team_defeated() and !instance_exists(oDialog)) {
	instance_destroy();
}
sys.step();