function set_move_code(name, struct) {
	PFS.moves[__PFS_get_move_id(name)][$ "code"] = struct.code;
}
#macro MoveCodeStart code: function(pokemon, enemy) {
#macro MoveCodeEnd }

function PFSMoveScripts(){
	set_move_code("Self Destruct", {
		MoveCodeStart
			pokemon.hp = 0;
		MoveCodeEnd
	});
	
	set_move_code("Explosion", {
		MoveCodeStart
			pokemon.hp = 0;
		MoveCodeEnd
	});
	
	set_move_code("Perish Song", {
		MoveCodeStart
			if (__PFS_pokemon_have_ability(pokemon, "soundproof")) {
				show_debug_message($"{pokemon.identifier}'s Soundproof ignored Perish Song!");
			}
			else {
				__PFS_apply_status(pokemon, PFSStatusAilments.Perish_song, 3);
			}
		MoveCodeEnd
	});
}