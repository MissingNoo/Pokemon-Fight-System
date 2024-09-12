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
pokemonhplerp = lerp(pokemonhplerp, PFS.playerPokemons[pokemonOut].hp, 0.05);
enemyhplerp = lerp(enemyhplerp, enemyPokemon[enemyOut].hp, 0.05);
enemypokesize = lerp(enemypokesize, enemypokesizelerp, 0.1);
if (sys.get_current_state() != "animation") {
	playerpokesize = lerp(playerpokesize, playerpokesizelerp, 0.1);
}
if (instance_exists(oDialog) and sys.get_current_state() != "animation") {
	exit;
}
if (__PFS_enemy_team_defeated() and !instance_exists(oDialog)) {
	instance_destroy();
}
sys.step();