//feather disable GM2016
//feather disable GM2017
var _yoff = 0;
var _text = "";
var _x = GW/2 - 100;
var _y = GH/2 - 100;
#region Function Buttons
_text = "Generate Team";
_x = GW - 2;
_y = GH - string_height(_text) * 2 - 5;
_x -= string_width(_text) * 2 + 9;
if (createbutton(_x, _y, _text, 2) and !instance_exists(PFSFightSystem)) {
	//Random test team
	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 600)]);
	PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 600)]);
	PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 600)]);
	//PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[700]);
	//PFS.playerPokemons[0].moves[0] = __PFS_add_move("Perish Song");
	//PFS.playerPokemons[0].moves[0].mpower = 0;
	//PFS.playerPokemons[0].moves[1] = __PFS_add_move("Pound");
	//PFS.playerPokemons[0].moves[1].mpower = 1;
	//PFS.playerPokemons[0].moves[2] = __PFS_add_move("Sing");
	//PFS.playerPokemons[0].level = 100;
	//PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
	
	//PFS.playerPokemons[0].moves[3] = __PFS_add_move("Thunder Wave");
	//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[338]);
	//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[700]);
	//PFS.playerPokemons[2].moves[0] = __PFS_add_move("Destiny Bond");
	//PFS.playerPokemons[2].moves[1] = __PFS_add_move("Moonblast");
	//PFS.playerPokemons[2].moves[2] = __PFS_add_move("Pound");
	//PFS.playerPokemons[2].level = 100;
	//PFS.playerPokemons[2] = __PFS_recalculate_stats(PFS.playerPokemons[2], true);
	PFS.playerPokemons[3] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)]);
	PFS.playerPokemons[4] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)]);
	PFS.playerPokemons[5] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)]);
	//Random enemy
	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 151)])];
	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[295])];
	//_enemyPokemon[enemyOut].moves = [];
	//_enemyPokemon[enemyOut].moves[0] = __PFS_add_move("Pound");
	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[10])];
	//_enemyPokemon[enemyOut].level = 100;
	//_enemyPokemon[enemyOut] = __PFS_recalculate_stats(_enemyPokemon[enemyOut], true);
	//_enemyPokemon[enemyOut].moves[0] = __PFS_add_move("Destiny Bond");
	//_enemyPokemon[enemyOut].moves[0].pp = 9999;
	//Start Battle
	//instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
}
_text = "Exit Battle";
_x -= string_width(_text) * 2 + 9;
if (createbutton(_x, _y, _text, 2)) {
	instance_destroy(PFSFightSystem);
}
#endregion