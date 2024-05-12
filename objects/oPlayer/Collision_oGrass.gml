if (x == other.x and y == other.y) {
	if (!other.collided) {
		if (irandom_range(0,100) <= 30) {
			//Feather disable GM2017
		    var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)])];
			instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
			//Feather enable GM2017
		}
	    other.collided = true;
	}
}
else {
	other.collided = false;
}