if (x == other.x and y == other.y) {
	if (!other.collided) {
		if (irandom_range(0,100) <= 30) {
			//Feather disable GM2017
			var _poke = __PFS_generate_pokemon(PFS.Pokes[127]);
	_poke.level = 100;
	_poke = __PFS_recalculate_stats(_poke, true);
	_poke.moves = [__PFS_add_move("Screee")];
		    var _enemyPokemon = [_poke];
			instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
			//Feather enable GM2017
		}
	    other.collided = true;
	}
}
else {
	other.collided = false;
}