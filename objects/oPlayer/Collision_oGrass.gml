if (x == other.x and y == other.y) {
	if (!other.collided) {
        var current_map = $"PFS/Maps/{room_get_name(room)}.json";
        if (file_exists(current_map)) {
            var jmap = json_parse(buffer_read(buffer_load(current_map), buffer_string));
            pokelist = [];
            array_foreach(jmap[$"grass"], function(_element, _index){
                var add_to_list = true;
                if (_element[$"area"] != undefined) {
                    var pos = _element[$"area"];
                    if (!point_in_rectangle(x, y, pos[0][0], pos[0][1], pos[1][0], pos[1][1])) {
                        add_to_list = false;
                    }
                }
                if (add_to_list) {
                    oPlayer.pokelist = array_concat(oPlayer.pokelist, _element[$"pokes"]);
                }
            });
            trace($"Avaliable pokemon on this spot are {oPlayer.pokelist}");
            if (array_length(pokelist) > 0 and irandom_range(0, 100) <= 30) {
                //Feather disable GM2017
                var selected_pokemon = irandom_range(0, array_length(pokelist) - 1);
                trace($"Pokemon found on Grass was {pokelist[selected_pokemon]}");
                var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[pokelist[selected_pokemon]])];
                instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
                pokelist = [];
                //Feather enable GM2017
            }
        }
		
	    other.collided = true;
	}
}
else {
	other.collided = false;
}