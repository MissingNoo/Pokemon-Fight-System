//Feather disable GM2017
//Feather disable GM2016
//if (keyboard_check_pressed(vk_numpad3)) {
//	instance_create_depth(x, y, depth - 1, oDialog, {npc : "Battle", text : "Enter", onBattle : true});
//}
//if (keyboard_check_pressed(vk_numpad4)) {
//	instance_create_depth(x, y, depth - 1, oDialog, {npc : "Sign", text : "Test", onBattle : true});
//}
//if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
//	//Random test team
//	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[135]);
//	//PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 600)]);
//	//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[88]);
//	//PFS.playerPokemons[0].moves[0] = __PFS_add_move("Bite");
//	PFS.playerPokemons[0].level = 1;
//	//PFS.playerPokemons[0].moves[0] = __PFS_add_move("Destiny Bond");
//	PFS.playerPokemons[0].moves[0] = __PFS_add_move("Thunder Shock");
//	PFS.playerPokemons[0].moves[1] = __PFS_add_move("Moonblast");
//	PFS.playerPokemons[0].moves[2] = __PFS_add_move("Pound");
//	PFS.playerPokemons[0].moves[3] = __PFS_add_move("Bite");
//	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
//	//PFS.playerPokemons[0].moves[0].mpower = 0;
//	//PFS.playerPokemons[0].moves[1] = __PFS_add_move("Pound");
//	//PFS.playerPokemons[0].moves[1].mpower = 1;
//	//PFS.playerPokemons[0].moves[2] = __PFS_add_move("Sing");
//	//PFS.playerPokemons[0].level = 100;
//	//PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
	
//	//PFS.playerPokemons[0].moves[3] = __PFS_add_move("Thunder Wave");
//	//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[338]);
//	//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[700]);
//	//PFS.playerPokemons[2].level = 100;
//	//PFS.playerPokemons[2] = __PFS_recalculate_stats(PFS.playerPokemons[2], true);
//	//PFS.playerPokemons[3] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[4] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[5] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//Random enemy
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)]), __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)])];
//	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[81])];
//	_enemyPokemon[0].moves = [];
//	_enemyPokemon[0].moves[0] = __PFS_add_move("Thunder Shock");
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[6])];
//	//_enemyPokemon[enemyOut].moves = [];
//	//_enemyPokemon[enemyOut].moves[0] = __PFS_add_move("Pound");
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[10])];
//	//_enemyPokemon[enemyOut].level = 100;
//	//_enemyPokemon[enemyOut] = __PFS_recalculate_stats(_enemyPokemon[enemyOut], true);
//	//_enemyPokemon[enemyOut].moves[0] = __PFS_add_move("Destiny Bond");
//	//_enemyPokemon[enemyOut].moves[0].pp = 9999;
//	//Start Battle
//	instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
//	//instance_create_depth(0, 0, 0, PFSFightSystem, {trainer : Trainers[0], wildPokemon : false});
//}

//if (keyboard_check_pressed(vk_numpad9) and !instance_exists(PFSFightSystem)) {
//	//Random test team
//	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[25]);
//	//PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 600)]);
//	//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[88]);
//	//PFS.playerPokemons[0].moves[0] = __PFS_add_move("Bite");
//	PFS.playerPokemons[0].level = 100;
//	//PFS.playerPokemons[0].moves[0] = __PFS_add_move("Destiny Bond");
//	PFS.playerPokemons[0].moves[0] = __PFS_add_move("Thunder Shock");
//	PFS.playerPokemons[0].moves[1] = __PFS_add_move("Moonblast");
//	PFS.playerPokemons[0].moves[2] = __PFS_add_move("Pound");
//	PFS.playerPokemons[0].moves[3] = __PFS_add_move("Bite");
//	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
//	//PFS.playerPokemons[0].moves[0].mpower = 0;
//	//PFS.playerPokemons[0].moves[1] = __PFS_add_move("Pound");
//	//PFS.playerPokemons[0].moves[1].mpower = 1;
//	//PFS.playerPokemons[0].moves[2] = __PFS_add_move("Sing");
//	//PFS.playerPokemons[0].level = 100;
//	//PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
	
//	//PFS.playerPokemons[0].moves[3] = __PFS_add_move("Thunder Wave");
//	//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[338]);
//	//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[700]);
//	//PFS.playerPokemons[2].level = 100;
//	//PFS.playerPokemons[2] = __PFS_recalculate_stats(PFS.playerPokemons[2], true);
//	//PFS.playerPokemons[3] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[4] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//PFS.playerPokemons[5] = __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 650)]);
//	//Random enemy
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)]), __PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)])];
//	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[135])];
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[6])];
//	_enemyPokemon[0].moves = [];
//	_enemyPokemon[0].moves[0] = __PFS_add_move("Bite");
//	//var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[10])];
//	//_enemyPokemon[enemyOut].level = 100;
//	//_enemyPokemon[enemyOut] = __PFS_recalculate_stats(_enemyPokemon[enemyOut], true);
//	//_enemyPokemon[enemyOut].moves[0] = __PFS_add_move("Destiny Bond");
//	//_enemyPokemon[enemyOut].moves[0].pp = 9999;
//	//Start Battle
//	instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
//	//instance_create_depth(0, 0, 0, PFSFightSystem, {trainer : Trainers[0], wildPokemon : false});
//}

//if (keyboard_check_pressed(vk_f5) and !instance_exists(PFSFightSystem)) {
//	//Random test team
//	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[700]);
//	PFS.playerPokemons[0].level = 100;
//	PFS.playerPokemons[0].moves[0] = __PFS_add_move("Destiny Bond");
//	PFS.playerPokemons[0].moves[1] = __PFS_add_move("Moonblast");
//	PFS.playerPokemons[0].moves[2] = __PFS_add_move("Pound");
//	PFS.playerPokemons[0].moves[3] = __PFS_add_move("Bite");
//	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
	
//	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 152)])];
//	instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
//}
