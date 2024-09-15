//Feather disable all
#macro runningtests false
#macro Tests:runningtests true
global.testing = runningtests;
global.testingforcecrit = false;
global.testingrandomdamage = true;
global.testingforcefail = false;

function tests(){
	suite(function() {
		section("Abilities", function() {			
			afterEach(function() {
				global.testingrandomdamage = true;
				global.testingforcefail = false;
				if (instance_exists(PFSFightSystem)) {
				    instance_destroy(PFSFightSystem);
				}
			});
			
			test("Own Tempo (Confusion Immunity) -- Player Side", function() {
				var status = PFSStatusAilments.Confusion;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Slowpoke|Level: 100|Hardy Nature|Ability: Own Tempo|- Confusion");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(false);
			});
			
			test("Own Tempo (Confusion Immunity) -- Foe Side", function() {
				var status = PFSStatusAilments.Confusion;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Confusion");
				var enemy = __PFS_generate_pokemon_from_showdown("Slowpoke|Level: 100|Hardy Nature|Ability: Own Tempo|- Confusion");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(false);
			});
			
			test("Overgrow", function() {
				global.testingrandomdamage = false;
				var p1 = __PFS_generate_pokemon_from_showdown("Bulbasaur|Ability: Overgrow|- Vine Whip");
				var p2 = __PFS_generate_pokemon_from_showdown("Slowpoke");
				
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				var pside = calcfirst.damage < calcsecond.damage;
				
				var p1 = __PFS_generate_pokemon_from_showdown("Bulbasaur|Ability: Overgrow|- Vine Whip");
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				var eside = calcfirst.damage < calcsecond.damage;
				
				expect(pside and eside).toBe(true);
			});
			
			test("Torrent", function() {
				global.testingrandomdamage = false;
				var p1 = __PFS_generate_pokemon_from_showdown("Squirtle|Ability: Torrent|- Water Gun");
				var p2 = __PFS_generate_pokemon_from_showdown("Slowpoke");
				
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				var pside = calcfirst.damage < calcsecond.damage;
				
				var p1 = __PFS_generate_pokemon_from_showdown("Squirtle|Ability: Torrent|- Water Gun");
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				var eside = calcfirst.damage < calcsecond.damage;
				
				expect(pside and eside).toBe(true);
			});
			
			test("Blaze", function() {
				global.testingrandomdamage = false;
				var p1 = __PFS_generate_pokemon_from_showdown("Charmander|Ability: Blaze|- Flamethrower");
				var p2 = __PFS_generate_pokemon_from_showdown("Slowpoke");
				
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				var pside = calcfirst.damage < calcsecond.damage;
				
				var p1 = __PFS_generate_pokemon_from_showdown("Charmander|Ability: Blaze|- Flamethrower");
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				p1.hp = 5;
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				var eside = calcfirst.damage < calcsecond.damage;
				
				expect(pside and eside).toBe(true);
			});
			
			test("Static", function() {
				var p1 = __PFS_generate_pokemon_from_showdown("Slowpoke|- Headbutt");
				var p2 = __PFS_generate_pokemon_from_showdown("Pikachu|Ability: Static|- Pound");
				__PFS_damage_calculation(p1, p2, p1.moves[0]);
				var effected = __PFS_pokemon_affected_by_status(p1, PFSStatusAilments.Paralysis);
				var p3 = __PFS_generate_pokemon_from_showdown("Pikachu|Ability: Static|- Pound");
				var p4 = __PFS_generate_pokemon_from_showdown("Pikachu|Ability: Static|- Pound");
				__PFS_damage_calculation(p3, p4, p3.moves[0]);
				var noteffected = !__PFS_pokemon_affected_by_status(p3, PFSStatusAilments.Paralysis);
				expect(effected and noteffected).toBe(true);
			});
			
			test("Shield Dust - Player Side", function() {
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Caterpie|Ability: Shield Dust|- Flamethrower");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], PFSStatusAilments.Burn)).toBe(false);
			});
			
			test("Shield Dust - Foe Side", function() {
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|- Ember");
				var enemy = __PFS_generate_pokemon_from_showdown("Caterpie|Ability: Shield Dust|- Flamethrower");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], PFSStatusAilments.Burn)).toBe(false);
			});
			
			test("Shed Skin - Player Side - Sucess", function() {
				global.testingforcefail = false;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Metapod|Level: 100|Ability: Shed Skin|- Pound");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], PFSStatusAilments.Burn)).toBe(false);
			});
			
			test("Shed Skin - Player Side - Fail", function() {
				global.testingforcefail = false;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Metapod|Level: 100|Ability: Shed Skin|- Pound");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
					global.testingforcefail = true;
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], PFSStatusAilments.Burn)).toBe(true);
			});
				
			test("Guts", function() {
				global.testingrandomdamage = false;
				var p1 = __PFS_generate_pokemon_from_showdown("Rattata|Ability: Guts|- Tackle");
				var p2 = __PFS_generate_pokemon_from_showdown("Slowpoke");
				
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				__PFS_apply_status(p1, PFSStatusAilments.Burn, -99);
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0]);
				var pside = calcfirst.damage < calcsecond.damage;
				
				var p1 = __PFS_generate_pokemon_from_showdown("Rattata|Ability: Guts|- Tackle");
				var calcfirst = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				__PFS_apply_status(p1, PFSStatusAilments.Burn, -99);
				var calcsecond = __PFS_damage_calculation(variable_clone(p1), variable_clone(p2), p1.moves[0], PFSBattleSides.Enemy);
				var eside = calcfirst.damage < calcsecond.damage;
				
				expect(pside and eside).toBe(true);
			});
			
			test("Soundproof", function() {
				var p1 = __PFS_generate_pokemon_from_showdown("Rattata|Level: 100|- Perish Song");
				var p2 = __PFS_generate_pokemon_from_showdown("Exploud");
				
				//Status
				PlayerTeam[0] = variable_clone(p1);
				var enemy = variable_clone(p2);
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				var enemyaffected = __PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], PFSStatusAilments.Perish_song);
				instance_destroy(_obj);
				
				PlayerTeam[0] = variable_clone(p2);
				var enemy = variable_clone(p1);
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				var playeraffected = __PFS_pokemon_affected_by_status(PlayerTeam[0], PFSStatusAilments.Perish_song);
				instance_destroy(_obj);
				
				//Damage
				var p1 = __PFS_generate_pokemon_from_showdown("Rattata|Level: 100|- Hyper Voice");
				var p2 = __PFS_generate_pokemon_from_showdown("Exploud");
				
				PlayerTeam[0] = variable_clone(p1);
				var enemy = variable_clone(p2);
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				var enemydmgaffected = PFSFightSystem.enemyPokemon[0].hp < PFSFightSystem.enemyPokemon[0].base.hp;
				instance_destroy(_obj);
				
				PlayerTeam[0] = variable_clone(p2);
				var enemy = variable_clone(p1);
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				var playerdmgaffected = PlayerTeam[0].hp < PlayerTeam[0].base.hp;
				instance_destroy(_obj);
				
				expect(!enemyaffected and !playeraffected and !playerdmgaffected and !enemydmgaffected).toBe(true);
			});
			
			test("Pixilate", function() {
				var p1 = __PFS_generate_pokemon_from_showdown("Sylveon|Ability: Pixilate|- Pound");
				var p2 = __PFS_generate_pokemon_from_showdown("Rattata");
				
				var _abresult = PFS.AbilitiesCode[p1.ability[0][0]].code(p1, p2, p1.moves[0], 0, 1, 1, PFSBattleSides.Player);
				var psideconvert = _abresult.move.type == __PFSTypes.Fairy;
				var _abresult = PFS.AbilitiesCode[p1.ability[0][0]].code(p1, p2, p1.moves[0], 0, 1, 1, PFSBattleSides.Enemy);
				var esideconvert = _abresult.move.type == __PFSTypes.Fairy;
				
				expect(psideconvert and esideconvert).toBe(true);
			});
		});
		
		section("Status", function() {
			afterEach(function() {
				if (instance_exists(PFSFightSystem)) {
				    instance_destroy(PFSFightSystem);
				}
			});
			#region Paralysis
			test("Paralyze - Player", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(true);
			});
			
			test("Paralyze - Foe", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(true);
			});
			
			test("Paralyze - Player Immunity", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(false);
			});
			
			test("Paralyze - Enemy Immunity", function() {
				var status = PFSStatusAilments.Paralysis;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var enemy = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 50|Hardy Nature|Ability: Static|- Thunder Shock");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(false);
			});
			#endregion
			
			#region Burn
			test("Burn - Player", function() {
				var status = PFSStatusAilments.Burn;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var enemy = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(true);
			});
			
			test("Burn - Foe", function() {
				var status = PFSStatusAilments.Burn;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(true);
			});
			
			test("Burn - Player Immunity", function() {
				var status = PFSStatusAilments.Burn;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(false);
			});
			
			test("Burn - Enemy Immunity", function() {
				var status = PFSStatusAilments.Burn;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Ember");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(false);
			});
			#endregion
			
			#region Confusion
			test("Confusion - Player", function() {
				var status = PFSStatusAilments.Confusion;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Confusion");
				var enemy = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PlayerTeam[0], PFSFightSystem.enemyPokemon[0], PlayerTeam[0].moves[0], PFSBattleSides.Player);
				}
				expect(__PFS_pokemon_affected_by_status(PFSFightSystem.enemyPokemon[0], status)).toBe(true);
			});
			
			test("Confusion - Foe", function() {
				var status = PFSStatusAilments.Confusion;
				PlayerTeam[0] = __PFS_generate_pokemon_from_showdown("Weedle|Level: 100|Hardy Nature|Ability: Blaze|- Absorb");
				var enemy = __PFS_generate_pokemon_from_showdown("Charmander|Level: 100|Hardy Nature|Ability: Blaze|- Confusion");
				var _obj = instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : [enemy]});
				with (_obj) {
					__PFS_use_move(PFSFightSystem.enemyPokemon[0], PlayerTeam[0], PFSFightSystem.enemyPokemon[0].moves[0], PFSBattleSides.Enemy);
				}
				expect(__PFS_pokemon_affected_by_status(PlayerTeam[0], status)).toBe(true);
			});
			#endregion
		});
		margin = 30;
		section("Damage Calculation", function() {
			beforeEach(function(){
				global.testingrandomdamage = true;
			});
			
			afterEach(function(){
				global.testingrandomdamage = false;
			});
			
			afterAll(function(){
				if (global.testing) {
				    game_end();
				}
			});
			
			test($"Lvl 50 Bulbasaur Vine Whip vs. Lvl 1 Weedle: 87-103", function() {
				var mindmg = 87;
				var maxdmg = 103;
				var error = false;
				repeat(3) {
					var p1 = __PFS_generate_pokemon_from_showdown("Bulbasaur|Level: 50|Hardy Nature|Ability: Overgrow|- Vine Whip");
					var p2 = __PFS_generate_pokemon_from_showdown("Weedle|Level: 1|Hardy Nature|Ability: Shield Dust|- Absorb");
					var calculation = __PFS_damage_calculation(p1, p2, p1.moves[0]);
					if (!(calculation.damage >= mindmg - margin and calculation.damage <= maxdmg + margin)) {
					    error = true;
					}
				}
				expect(error).toBe(false);
			});
			
			test($"Pikachu Thunder Shock vs. Diglett: 0-0", function() {
				var mindmg = 0;
				var maxdmg = 0;
				var error = false;
				repeat(3) {
					var p1 = __PFS_generate_pokemon_from_showdown("Pikachu|Level: 100|Hardy Nature|Ability: Static|- Thunder Shock");
					var p2 = __PFS_generate_pokemon_from_showdown("Diglett|Level: 100|Hardy Nature|Ability: Sand Veil|- Absorb");
					var calculation = __PFS_damage_calculation(p1, p2, p1.moves[0]);
					if (!(calculation.damage >= mindmg - margin and calculation.damage <= maxdmg + margin)) {
					    error = true;
					}
				}
				expect(error).toBe(false);
			});
			
			test($"Garchomp Earthquake vs. Volcarona: 210-247", function() {
				var mindmg = 210;
				var maxdmg = 247;
				var error = false;
				repeat(3) {
					var p1 = __PFS_generate_pokemon_from_showdown("Garchomp|Level: 100|Ability: Rough Skin|EVs: 252 Atk / 4 SpD / 252 Spe|Timid Nature|- Earthquake");
					var p2 = __PFS_generate_pokemon_from_showdown("Volcarona|Level: 100|Timid Nature|Ability: Flame Body|EVs: 252 SpA / 4 SpD / 252 Spe|- Quiver Dance");
					var calculation = __PFS_damage_calculation(p1, p2, p1.moves[0]);
					if (!(calculation.damage >= mindmg - margin and calculation.damage <= maxdmg + margin)) {
						show_debug_message($"TEST ERROR: {calculation.damage}:{mindmg}:{maxdmg}");
					    error = true;
					}
				}
				expect(error).toBe(false);
			});
		});
	});
}

function __PFS_set_pokemon_ivs(pokemon, hp, attack, defense, spatk, spdef, spd) {
	pokemon.ivs.hp = hp;
	pokemon.ivs.attack = attack;
	pokemon.ivs.defense = defense;
	pokemon.ivs.spattack = spatk;
	pokemon.ivs.spdefense = spdef;
	pokemon.ivs.speed = spd;
}

function __PFS_set_pokemon_evs(pokemon, hp, attack, defense, spatk, spdef, spd) {
	pokemon.evs.hp = hp;
	pokemon.evs.attack = attack;
	pokemon.evs.defense = defense;
	pokemon.evs.spattack = spatk;
	pokemon.evs.spdefense = spdef;
	pokemon.evs.speed = spd;
}

function __PFS_set_pokemon_nature(pokemon, nature) {
	var natureid = 0;
	for (var i = 1; i < array_length(PFS.Natures); ++i) {
	    if (PFS.Natures[i].identifier == string_lower(nature)) {
		    natureid = PFS.Natures[i].id;
			break;
		}
	}
	pokemon.nature = natureid;
}

function __PFS_set_pokemon_ability(pokemon, ability) {
	pokemon.ability = [
					[ __PFS_get_ability_id(ability), 0 ],
					[ 0, 1 ],
					[ 0, 1 ]
				];
}

function __PFS_get_poke_id(name) {
	for (var i = 1; i < array_length(PFS.Pokes); ++i) {
		var a = PFS.Pokes[i][$ "identifier"];
	    if (string_lower(PFS.Pokes[i][$ "identifier"]) == string_lower(name)) {
		    return PFS.Pokes[i].id;
		}
	}
	return -1;
}

function __PFS_generate_pokemon_from_showdown(export_string) {
	var pokedata = export_string;
	var data = string_split(string_replace(pokedata, "	", ""), "|");
	//[ "Charmander","Level: 5","Timid Nature","Ability: Blaze","EVs: 44 HP / 12 Def / 196 SpA / 236 Spe","IVs: 0 Atk","- Flamethrower","- Fire Blast","- Overheat","- Sleep Talk" ]
	var gen = __PFS_generate_pokemon(PFS.Pokes[__PFS_get_poke_id(data[0])]);
	if (string_contains(pokedata, "Level")) {
		gen.level = real(string_digits(data[array_find_index(data, function(e, i){return string_contains(e, "Level")})]));
	}
	else {
		gen.level = irandom_range(1, 100);
	}
	
	if (string_contains(pokedata, "Nature")) {
		__PFS_set_pokemon_nature(gen, string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "Nature")})], " Nature", ""));
	}
	
	if (string_contains(pokedata, "Ability")) {
		__PFS_set_pokemon_ability(gen, string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "Ability")})], "Ability: ", ""));
	}
	
	__PFS_set_pokemon_ivs(gen, 31, 31, 31, 31, 31, 31);
	
	var haveevs = array_find_index(data, function(e, i){return string_contains(e, "EVs")});
	if (haveevs != -1) {
	    var evs = string_split(string_replace(data[haveevs], "EVs: ", ""), "/");
		#region HP EV
		var ehp = 0;
		var c_ehp = array_find_index(evs, function(e, i) {
			return string_contains(e, "HP");
		})
		if (c_ehp != -1) {
			ehp = real(string_digits(evs[c_ehp]));
		}
		#endregion
		#region Atk EV
		var eatk = 0;
		var c_eatk = array_find_index(evs, function(e, i) {
			return string_contains(e, "Atk");
		})
		if (c_eatk != -1) {
			eatk = real(string_digits(evs[c_eatk]));
		}
		#endregion
		#region Def EV
		var edef = 0;
		var c_edef = array_find_index(evs, function(e, i) {
			return string_contains(e, "Def");
		})
		if (c_edef != -1) {
			edef = real(string_digits(evs[c_edef]));
		}
		#endregion
		#region SPAtk EV
		var espa = 0;
		var c_espa = array_find_index(evs, function(e, i) {
			return string_contains(e, "SpA");
		})
		if (c_espa != -1) {
			espa = real(string_digits(evs[c_espa]));
		}
		#endregion
		#region SPDef EV
		var espd = 0;
		var c_espd = array_find_index(evs, function(e, i) {
			return string_contains(e, "SpD");
		})
		if (c_espd != -1) {
			espd = real(string_digits(evs[c_espd]));
		}
		#endregion
		#region Speed EV
		var espe = 0;
		var c_espe = array_find_index(evs, function(e, i) {
			return string_contains(e, "Spe");
		})
		if (c_espe != -1) {
			espe = real(string_digits(evs[c_espe]));
		}
		#endregion
		__PFS_set_pokemon_evs(gen, ehp, eatk, edef, espa, espd, espe);
	}
	
	if (string_contains(pokedata, "-")) {
	    gen.moves = [ __PFS_add_move(string_replace(data[array_find_index(data, function(e, i){return string_contains(e, "- ")})], "- ", ""))];
	}
	
	gen = __PFS_recalculate_stats(gen, true);
	return gen;
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