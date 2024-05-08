if (x == other.x and y == other.y) {
	if (!other.collided) {
		show_debug_message("on center of grass");
		if (irandom_range(0,100) <= 30) {
		    var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)])];
			instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
		}
	    other.collided = true;
	}
}
else {
	other.collided = false;
}