//Feather disable GM2017
global.__PFS.playerPokemons = [
	{
		name : "Bulbasaur",
		type : [__PFSTypes.Grass, __PFSTypes.Poison],
		level : 25,
		basecalc : {
			hp : 45,
			attack : 49,
			defense : 49,
			spatk : 65,
			spdef : 65,
			speed : 45
		},
		base : {
			hp : 45,
			attack : 49,
			defense : 49,
			spatk : 65,
			spdef : 65,
			speed : 45
		},
		ivs : {
			hp : 0,
			attack : 0,
			defense : 0,
			spatk : 0,
			spdef : 0,
			speed : 0
		},
		evs : {
			hp : 0,
			attack : 0,
			defense : 0,
			spatk : 0,
			spdef : 0,
			speed : 0
		},
		sprite : [sPFSBulbasaurFront, sPFSBulbasaurBack],
		moves : [__PFS_add_move("Growl"), __PFS_add_move("Tackle"), __PFS_add_move("Vine Whip"), __PFS_add_move("Growth")]
	}
];

//show_message(global.__PFS.playerPokemons[0]);
global.__PFS.playerPokemons[0] = __PFS_recalculate_stats(global.__PFS.playerPokemons[0], true);
//show_message(global.__PFS.playerPokemons[0]);
