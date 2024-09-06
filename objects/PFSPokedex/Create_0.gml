surf = surface_create(239, 159);
sprite = undefined;
function load_sprite(pokemon){
	var _sprite_path = working_directory + "PFS/Sprites/Pokemon/Front/" + string_upper(pokemon.internalName) + ".png";
	if (file_exists(_sprite_path)) {
		if (sprite != undefined) {
		    sprite_delete(sprite);
		}
		sprite = sprite_add(_sprite_path, 0, false, false, 192/1.5, 192);
	}
}
load_sprite(PFS.Pokes[pokemon]);