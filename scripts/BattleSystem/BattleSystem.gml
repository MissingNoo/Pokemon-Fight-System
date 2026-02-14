function PokeSystem() constructor {
	static generate_pokemon = function(id) {
		var pokemon = variable_clone(PFS.Pokes[id]);
		pokemon.gender = choose(Gender.Male, Gender.Female); //TODO %
		pokemon.level = irandom_range(
			real(pokemon.wildlevelrange[0]),
			real(pokemon.wildlevelrange[1])
		);
		pokemon.moves = [];
		for (var i = 0; i < array_length(pokemon.canLearn.level); ++i) {
			if (array_length(pokemon.moves) < 4) {
				if (pokemon.canLearn.level[i].level < pokemon.level) {
					array_push(
						pokemon.moves,
						__PFS_add_move(pokemon.canLearn.level[i].id)
					);
				}
			}
		}
		pokemon.ivs = {
			hp: irandom_range(0, 31),
			attack: irandom_range(0, 31),
			defense: irandom_range(0, 31),
			spattack: irandom_range(0, 31),
			spdefense: irandom_range(0, 31),
			speed: irandom_range(0, 31),
			accuracy: irandom_range(0, 31),
			evasion: irandom_range(0, 31),
		};
		pokemon.evs = {
			hp: 0,
			attack: 0,
			defense: 0,
			spattack: 0,
			spdefense: 0,
			speed: 0,
			accuracy: 0,
			evasion: 0,
		};
		pokemon.statusAilments = [];
		if (pokemon.ability[0][0] != 0 && pokemon.ability[1][0] != 0) {
			var _rnd = __PFS_rng(0, 1);
			switch (_rnd) {
				case 0:
					pokemon.ability[1][0] = 0;
					break;
				case 1:
					pokemon.ability[0][0] = 0;
					break;
			}
		}
		pokemon.nature = PFS.Natures[irandom_range(1, array_length(PFS.Natures) - 1)].id;
		pokemon.shiny = irandom_range(1, 4096) == 1; //TODO: Locked shinies
		recalculate_stats(pokemon, true);
		return pokemon;
	};

	static recalculate_stats = function(pokemon, pokecenter) {
		if (pokemon[$ "base"] == undefined) {
			pokemon[$ "base"] = {};
		}
		var _names = variable_struct_get_names(pokemon.basecalc);
		for (var i = 0; i < array_length(_names); ++i) {
			switch (_names[i]) {
				case "hp":
					variable_struct_set(
						pokemon.base,
						"hp",
						floor(
								0.01
									* (
										2 * real(pokemon.basecalc.hp)
											+ real(pokemon.ivs.hp)
											+ floor(0.25 * real(pokemon.evs.hp))
									)
									* real(pokemon.level)
							)
							+ real(pokemon.level)
							+ 10
					);
					if (pokecenter) {
						variable_struct_set(
							pokemon,
							"hp",
							floor(
									0.01
										* (
											2 * real(pokemon.basecalc.hp)
												+ real(pokemon.ivs.hp)
												+ floor(0.25 * real(pokemon.evs.hp))
										)
										* real(pokemon.level)
								)
								+ real(pokemon.level)
								+ 10
						);
						pokemon.statusAilments = [];
					}
					break;
				default:
					var _basestat = variable_struct_get(pokemon.basecalc, _names[i]);
					var _iv = variable_struct_get(pokemon.ivs, _names[i]);
					var _ev = variable_struct_get(pokemon.evs, _names[i]);
					var _nature = pokemon.nature; //TODO: nature
					var increase_multiplier = 0;
					var decrease_multiplier = 0;
					if (
						PFS.NatureStatusNames[PFS.Natures[_nature].increased_stat_id]
						== _names[i]
					) {
						increase_multiplier = 10;
					}
					if (
						PFS.NatureStatusNames[PFS.Natures[_nature].decreased_stat_id]
						== _names[i]
					) {
						decrease_multiplier = 10;
					}
					variable_struct_set(
						pokemon.base,
						_names[i],
						(
							floor(
								0.01
									* (
										2 * real(_basestat)
											+ real(_iv)
											+ floor(0.25 * real(_ev))
									)
									* real(pokemon.level)
							) + 5
						) * 1
					);
					pokemon.base[$ _names[i]] +=
						(pokemon.base[$ _names[i]] * increase_multiplier) / 100;
					pokemon.base[$ _names[i]] -=
						(pokemon.base[$ _names[i]] * decrease_multiplier) / 100;
					pokemon.base[$ _names[i]] = round(pokemon.base[$ _names[i]]);
					if (pokecenter) {
						variable_struct_set(
							pokemon,
							_names[i],
							(
								floor(
									0.01
										* (
											2 * real(_basestat)
												+ real(_iv)
												+ floor(0.25 * real(_ev))
										)
										* real(pokemon.level)
								) + 5
							) * 1
						);
					}
					break;
			}
		}
		if (pokecenter) {
			pokemon.taunted = false;
			for (var i = 0; i < array_length(pokemon.moves); ++i) {
				pokemon.moves[i].pp = pokemon.moves[i].maxpp;
			}
		}
	};
}
new PokeSystem();
function Battle() constructor {
	team = [PokeSystem.generate_pokemon(700)]; 
	this = self;
	static start = function() {
		instance_create_depth(0, 0, 0, FightSystem, {battle : this});
	};
}
