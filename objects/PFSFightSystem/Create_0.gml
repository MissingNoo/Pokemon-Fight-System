//Feather disable GM2017
global.__PFS.playerPokemons = [
	{
		name : "Bulbasaur",
		level : 5,
		hp : 45,
		basehp : 45,
		attack : 49,
		defense : 49,
		spatk : 65,
		spdef : 65,
		speed : 45,
		sprite : [sPFSBulbasaurFront, sPFSBulbasaurBack],
		moves : [__PFS_addMove("Growl"), __PFS_addMove("Tackle"), __PFS_addMove("Vine Whip"), __PFS_addMove("Growth")]
	},
	{
		name : "Ivysaur",
		level : 7,
		basehp : 60,
		attack : 62,
		defense : 63,
		spatk : 80,
		spdef : 80,
		speed : 60,
		sprite : [sPFSIvysaurFront, sPFSIvysaurBack],
		hp : 50,
		moves : [__PFS_addMove("Growl"), __PFS_addMove("Tackle"), __PFS_addMove("Vine Whip"), __PFS_addMove("Growth")]
	},
];
enemyPokemon = [
	{
		name : "Bulbasaur",
		level : 5,
		hp : 45,
		basehp : 45,
		attack : 49,
		defense : 49,
		spatk : 65,
		spdef : 65,
		speed : 45,
		sprite : [sPFSBulbasaurFront, sPFSBulbasaurBack],
		moves : [__PFS_addMove("Growl"), __PFS_addMove("Tackle"), __PFS_addMove("Vine Whip"), __PFS_addMove("Growth")]
	},
];

#region Battle
wildPokemon = true;
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
function damage(pokemon, move){
	var _critChance = irandom_range(0, 255);
	var _critTreshold = pokemon.speed / 2; //TODO: High crit chance atk and items
	var _isCritical = _critChance <= _critTreshold ? 2 : 1;
	var _level = pokemon.level;
	var _a = 1;
	switch (move.type) { //TODO: unmodified on criticals
	    case MoveCategory.Physical:
	        _a = pokemon.atk;
	        break;
	    case MoveCategory.Special:
	        _a = pokemon.spatk;
	        break;
	}
	var damage = (((((((2 * _level * _isCritical) / 5) + 2) * move.mpower * _a / _d) / 50) +2)) * _stab * _type1 * _type2 * _rnd;
}
#endregion


enum PFSBattleMenus {
	Battle, 
	Pokemon,
	Item,
	Run
}