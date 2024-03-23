//Feather disable GM2017
#region Battle
pokemonOut = 0;
a = 0;
b = 0;
c = 0;
d = 0;
#endregion

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