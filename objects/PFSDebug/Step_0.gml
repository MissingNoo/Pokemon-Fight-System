//Feather disable GM2017
if (keyboard_check_pressed(vk_numpad2)) {
    instance_destroy(PFSFightSystem);
}
if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
	var _randompoke = {
		name : "Bulbasaur",
		type : [__PFSTypes.Grass, __PFSTypes.Poison],
		level : irandom_range(3, 15),
		basecalc : {
			hp : 45,
			attack : 49,
			defense : 49,
			spatk : 65,
			spdef : 65,
			speed : 45
		},
		base : {
			hp : 0,
			attack : 0,
			defense : 0,
			spatk : 0,
			spdef : 0,
			speed : 0
		},
		ivs : {
			hp : irandom_range(0, 31),
			attack : irandom_range(0, 31),
			defense : irandom_range(0, 31),
			spatk : irandom_range(0, 31),
			spdef : irandom_range(0, 31),
			speed : irandom_range(0, 31)
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
	};
	var _enemyPokemon = [__PFS_recalculate_stats(_randompoke, true)]
    instance_create_depth(0, 0, 0, PFSFightSystem, {enemyPokemon : _enemyPokemon});
}
