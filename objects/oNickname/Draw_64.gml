if (pokemon == undefined) { exit; }
surf = surface_recreate(surf, 64, 64);
ui.foreach(function(name, pos, data) {
	var spr = data[$ "image"] != undefined ? asset_get_index(data.image) : undefined;
	var _x = pos.left, _y = pos.top, _w = pos.width, _h = pos.height;
	switch (name) {
	    case "pokespr":
	        spr = global.pokemon_sprites.get_sprite(pokemon, "Icons");
			surface_set_target(surf);
			draw_sprite(spr, 0, 0, 0);
			surface_reset_target();
			draw_surface_stretched(surf, _x, _y, _w, _h);
	        break;
			
		case "pkmnname":
			scribble(lexicon_text_struct("GUI.SetNickname", {name : pokemon.internalName})).scale_to_box(_w, _h, true).draw(_x, _y);
			break;
			
		case "nameinput":
			var nick = "____________";
			if (string_length(keyboard_string) > string_length(nick)) {
			    keyboard_string = string_copy(keyboard_string, 1, string_length(nick));
			}
			nickname = keyboard_string;
			nick = string_delete(nick, 1, string_length(nickname));
			nick = string_concat(nickname, nick);
			scribble(nick).scale_to_box(_w, _h, true).draw(_x, _y);
			if (input_check_released("action")) {
			    pokemon.nickname = keyboard_string;
				DialogData[$ "nickname"] = keyboard_string;
				f();
				instance_destroy();
			}
			break;
			
	    default:
			draw_sprite_stretched(spr != undefined ? spr : sBlank , 0, _x, _y, _w, _h);
	        break;
	}
});