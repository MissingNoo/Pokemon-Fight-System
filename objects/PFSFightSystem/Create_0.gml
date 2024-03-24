//Feather disable GM2017
#region Battle
pokemonOut = 0;
a = 0;
b = 0;
c = 0;
d = 0;
#endregion
enemySprite = sPFSBulbasaurBack;
pokemonSprite = sPFSBulbasaurBack;
function load_sprite(pokemon, side){
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png")) {
		switch (side) {
		    case 0:
		        if (sprite_exists(enemySprite)) {
				    sprite_delete(enemySprite);
				}
			    enemySprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[0] + ".png", 0, false, false, 0, 0);
		        break;
		    case 1:
		        if (sprite_exists(pokemonSprite)) {
				    sprite_delete(pokemonSprite);
				}
			    pokemonSprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokemon.internalName + "/" + pokemon.sprite[1] + ".png", 0, false, false, 0, 0);
		        break;
		}
	    
	}
}
#region Window
startPosition = [display_get_gui_width() / 2 - 300, display_get_gui_height() / 2 - 200];
windowXScale = 7;
windowYScale = 4;
windowSize = [700, 400];
namePosition = [100, 100];
selectedMenu = 0;
menus = ["Battle", "Pokemon", "Item", "Run"];
#endregion

#region Function

#endregion

enum PFSBattleMenus {
	Battle, 
	Pokemon,
	Item,
	Run
}
load_sprite(global.__PFS.playerPokemons[0], 1);
load_sprite(enemyPokemon[0], 0);