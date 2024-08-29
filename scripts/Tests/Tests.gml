//Feather disable all
if (string_contains(os_get_config(), "Tests")) {
	global.testing = true;
}
else {
	global.testing = false;
}

function gen_enemy_poke(poke, level, move) {
	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[poke])];
	_enemyPokemon[0].level = level;
	_enemyPokemon[0].moves[0] = __PFS_add_move(move);
	_enemyPokemon[0] = __PFS_recalculate_stats(_enemyPokemon[0], true);
	return _enemyPokemon;
}

function set_player_poke(poke, level, move) {
	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[poke]);
	PFS.playerPokemons[0].level = level;
	PFS.playerPokemons[0].moves[0] = __PFS_add_move(move);
	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
}

function tests(){
	suite(function() {
		section("Moves", function() {
			beforeAll(function() {
				
			});
	
			afterAll(function() {
				if (string_contains(os_get_config(), "Tests")) {
					game_end();
				}
			});
			
			test("Ember: Apply Burn", function() {
				var enemy = [1, 1, "Ember"];
				set_player_poke(4, 1, "Ember");
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], PFSStatusAilments.Burn)).toBe(true);
				instance_destroy(_obj);
				
				var enemy = [4, 1, "Ember"];
				set_player_poke(1, 1, "Pound");
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PFS.playerPokemons[0], PFSStatusAilments.Burn)).toBe(true);
				instance_destroy(_obj);
			});
			
			test("Ember: Immunity", function() {
				var enemy = [4, 1, "Ember"];
				set_player_poke(4, 1, "Ember");
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], PFSStatusAilments.Burn)).toBe(false);
				instance_destroy(_obj);
				
				var enemy = [4, 1, "Ember"];
				set_player_poke(4, 1, "Pound");
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PFS.playerPokemons[0], PFSStatusAilments.Burn)).toBe(false);
				instance_destroy(_obj);
			});
			
			test("Thunder Shock", function() {
				var move = "Thunder Shock";
				var enemy = [1, 1, move];
				set_player_poke(25, 1, move);
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(true);
				instance_destroy(_obj);
				
				var enemy = [25, 1, move];
				set_player_poke(1, 1, move);
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PFS.playerPokemons[0], status)).toBe(true);
				instance_destroy(_obj);
			});
			
			test("Thunder Shock: Immunity", function() {
				var move = "Thunder Shock";
				var status = PFSStatusAilments.Paralysis;
				var enemy = [25, 1, move];
				set_player_poke(25, 1, move);
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(false);
				instance_destroy(_obj);
				
				var enemy = [25, 1, move];
				set_player_poke(25, 1, move);
				_obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : gen_enemy_poke(enemy[0], enemy[1], enemy[2])});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PFS.playerPokemons[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PFS.playerPokemons[0], status)).toBe(false);
				instance_destroy(_obj);
			});
		});
		//section("", function() {
		//});
	});
}


	//test("Should move obj_Player to the right", function() {
	//	var _obj = create(0, 0, obj_player);
		
	//	simulateKeyHold(vk_right);
	//	simulateFrameWait(1);
	//	simulateKeyRelease(vk_right);
		
	//	expect(_obj.x).toBeGreaterThan(_obj.xstart);
		
	//	instance_destroy(_obj);
	//	});
		
	//	test("Should move obj_Player to the left", function() {
	//		var _obj = create(0, 0, obj_player);
			
	//		simulateKeyHold(vk_left);
	//		simulateFrameWait(1);
	//		simulateKeyRelease(vk_left);
	//		z
    //  expect(_obj.x).toBeLessThan(_obj.xstart);

    //  instance_destroy(_obj);
    //});