//Feather disable GM2017
ini_open("debug.ini");
poke = ini_read_real("debug", "poke", 1);
pokelvl = ini_read_real("debug", "poke", 1);
ppoke = ini_read_real("debug", "ppoke", 1);
ppokelvl = ini_read_real("debug", "ppokelvl", 1);
ini_close();
randomize();
PFS.playerPokemons = [];
if (!DEBUGMODE) { instance_destroy(); }
show_debug_overlay(true, true);
dbg_view("PFS", true);
dbg_section("Systems");
dbg_slider_int(ref_create(self, "poke"), 1, 152, "Poke:", 1);
dbg_slider_int(ref_create(self, "pokelvl"), 1, 100, "Level:", 1);
dbg_button("Start Battle", function() { 
	var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[poke])];
	_enemyPokemon[0].level = pokelvl;
	_enemyPokemon[0] = __PFS_recalculate_stats(_enemyPokemon[0], true);
	if (!instance_exists(PFSFightSystem)) {
		instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
	}
	else {
		PFSFightSystem.enemyPokemon = _enemyPokemon;
		PFSFightSystem.load_sprite(_enemyPokemon[0], PFSBattleSides.Enemy);
	}
});
dbg_same_line();
dbg_button("End Battle", function() { instance_destroy(PFSFightSystem); });
dbg_button("Pokemon Manager", function() { instance_destroy(PFSPokemonManager); });
dbg_same_line();
dbg_button("Close", function() { instance_destroy(PFSPokemonManager); });
dbg_slider_int(ref_create(self, "ppoke"), 1, 152, "Poke:", 1);
dbg_slider_int(ref_create(self, "ppokelvl"), 1, 100, "Level:", 1);
dbg_button("Set Player pokemon", function() { 
	PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[ppoke]);	
	PFS.playerPokemons[0].level = ppokelvl;
	PFS.playerPokemons[0] = __PFS_recalculate_stats(PFS.playerPokemons[0], true);
	if (instance_exists(PFSFightSystem)) {
		PFSFightSystem.load_sprite(PFS.playerPokemons[0], PFSBattleSides.Player);
	}
});

if (string_contains(os_get_config(), "Tests")) {
	tests();
	__gmtl_init();
}