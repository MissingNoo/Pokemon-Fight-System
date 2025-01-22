surf = surface_create(239 * 2, 159 * 2);
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
load_sprite(PlayerTeam[pokemon]);
states = ["pokemon", "2", "3", "4"];
curstate = 0;

tab = new SnowState("pokemon");
tab.add("pokemon", {
	enter : function() {
	},
	draw : function() {
		var d = DebugManager;
		//Background
		draw_sprite_ext(PFSDexPokeInfo, 0, 0, 32, 2, 2, 0, c_white, 1);
		draw_sprite_ext(PFSDexTab, 0, 0, 0, 2, 2, 0, c_white, 1);
		draw_sprite_ext(PFSDexPokeArea, 0, 0, 32, 2, 2, 0, c_white, 1);
		scribble($"Lv{PlayerTeam[pokemon].level} {PlayerTeam[pokemon].internalName}").scale(0.75).draw(10, 40);
		//Dex ID
		scribble($"{PlayerTeam[pokemon].id}").scale(0.75).draw(335, 44); //+30
		//Nickname
		scribble($"{PlayerTeam[pokemon].internalName}").scale(0.75).draw(335, 74); //+30
		//Types
		draw_sprite_ext(PFSTypes, PlayerTeam[pokemon].type[0], 365.50, 104 + 10, 1.50, 1.50, 0, c_white, 1);
		if (PlayerTeam[pokemon].type[1] != __PFSTypes.NoType) {
		    draw_sprite_ext(PFSTypes, PlayerTeam[pokemon].type[1], 426.50, 104 + 10, 1.50, 1.50, 0, c_white, 1);
		}
		//Trainer Name
		scribble($"Red").scale(0.75).draw(335, 134); //+30
		//Catch id
		scribble($"28592").scale(0.75).draw(335, 164); //+30
		//Held Item
		scribble($"NONE").scale(0.75).draw(335, 194); //+30
		//Nature
		scribble($"{string_upper(PFS.Natures[PlayerTeam[pokemon].nature].identifier)} nature. {PFS.NatureStatusNames[PFS.Natures[PlayerTeam[pokemon].nature].increased_stat_id]} {PFS.NatureStatusNames[PFS.Natures[PlayerTeam[pokemon].nature].decreased_stat_id]}").scale(0.75).draw(18, 236); //+30
		//Capture map, level
		scribble($"Met at PALLET TOWN at Lv5.").scale(0.75).draw(18, 262); //+30
		//Poke Sprite
		draw_sprite_ext(global.pokemon_sprites.get_sprite(PlayerTeam[pokemon], "Front"), 0, 150, 190, 0.75, 0.75, 0, c_white, 1);
	},
	step : function() {
	}
});
tab.add("2", {
	enter : function() {
	},
	draw : function() {
		draw_sprite_ext(PFSDexPokeInfo, 1, 0, 32, 2, 2, 0, c_white, 1);
		draw_sprite_ext(PFSDexTab, 1, 0, 0, 2, 2, 0, c_white, 1);
		draw_sprite_ext(PFSDexPokeArea, 0, 0, 32, 2, 2, 0, c_white, 1);
		//draw_sprite_ext(PFSDexPokeArea, 0, 0, 32, 2, 2, 0, c_white, 1);
		//scribble($"Lv{PFS.Pokes[pokemon].level} {PlayerTeam[0].internalName}").scale(0.35).draw(5, 21);
		//draw_sprite_ext(sprite, 0, 150, 190, 0.75, 0.75, 0, c_white, 1);
	},
	step : function() {
	}
});
tab.add("3", {
	enter : function() {
	},
	draw : function() {
		draw_sprite_ext(PFSDexTab, 2, 0, 0, 2, 2, 0, c_white, 1);
		//draw_sprite_ext(PFSDexPokeArea, 0, 0, 32, 2, 2, 0, c_white, 1);
		//scribble($"Lv{PFS.Pokes[pokemon].level} {PlayerTeam[0].internalName}").scale(0.35).draw(5, 21);
		//draw_sprite_ext(sprite, 0, 150, 190, 0.75, 0.75, 0, c_white, 1);
	},
	step : function() {
	}
});
tab.add("4", {
	enter : function() {
	},
	draw : function() {
		draw_sprite_ext(PFSDexTab, 3, 0, 0, 2, 2, 0, c_white, 1);
		//draw_sprite_ext(PFSDexPokeArea, 0, 0, 32, 2, 2, 0, c_white, 1);
		//scribble($"Lv{PFS.Pokes[pokemon].level} {PlayerTeam[0].internalName}").scale(0.35).draw(5, 21);
		//draw_sprite_ext(sprite, 0, 150, 190, 0.75, 0.75, 0, c_white, 1);
	},
	step : function() {
	}
});