//Feather disable GM2017
//Feather disable GM1014
enum AbilityTime {
	Start,
	BeforeDamageCalculation,
	AfterDamageCalculation
}
/// @function                set_ability_code(name, struct)
/// @description             Set the code to run when a pokemon is hit and have the ability
/// @param {String}     name    The unique instance ID value of the instance to check.
/// @param {Struct}  struct The object index to be checked against.
function set_ability_code(name, struct) {
	PFS.AbilitiesCode[__PFS_get_ability_id(name)] = struct;
}
#macro AbilityCodeStart code: function(pokemon, enemy, move, status, isCritical, _damage) {
#macro AbilityResult {status : status, critical : isCritical, damage : _damage, move : move}
#macro AbilityCodeEnd }
function populate_abilities() {
	PFS.AbilitiesCode = array_create(array_length(PFS.Abilities), undefined);
	//set_ability_code("", {
	//	when : AbilityTime.Start,
	//	AbilityCodeStart
	//		return AbilityResult;
	//	AbilityCodeEnd
	//});
	set_ability_code("battle-armor", {
		when : AbilityTime.BeforeDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(enemy, "battle-armor")) { return AbilityResult; }
			if (isCritical == 2) {
				isCritical = 1;
				show_debug_message($"{enemy.identifier}'s Battle Armor cancels the critical damage!");
				array_push(global.nextdialog, {npc : "Battle", text : $"BattleArmor", onBattle : true});
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("shield-dust", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "shield-dust")) { return AbilityResult; }
			if (move.effect_chance > 0 and move.effect_chance < 100) {
				show_debug_message($"{pokemon.identifier}'s Shield Dust cancelled the status effect!");
				//array_push(global.nextdialog, {npc : "Battle", text : $"ShieldDust", onBattle : true});
				status = 0;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("soundproof", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "soundproof")) { return AbilityResult; }
			if (__PFS_move_have_flag(move, "sound")) {
				show_debug_message($"{pokemon.identifier}'s Soundproof ignored {move.identifier}!");
				DialogData[$ "movename"] = move.identifier;
				DialogData[$ "pokename"] = pokemon.identifier;
				array_push(global.nextdialog, {npc : "Battle", text : $"SoundProof", onBattle : true});
				status = 0;
				_damage = 0;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("sturdy", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "sturdy")) { return AbilityResult; }
			if (pokemon.base.hp == pokemon.hp and _damage > pokemon.hp and !__PFS_pokemon_have_ability(enemy, "mold-breaker")) {
				_damage = pokemon.hp - 1;
				show_debug_message($"{pokemon.identifier} held out thanks to Sturdy!");
				global.dialogdata[$"pokename"] = pokemon.identifier;
				spawn_dialog("Sturdy");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("static", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "static")) { return AbilityResult; }
			if (__PFS_move_have_flag(move, "contact")
				and __PFS_rng() <= 30
				and !__PFS_pokemon_affected_by_status(enemy, PFSStatusAilments.Paralysis)) {
				__PFS_apply_status(enemy, PFSStatusAilments.Paralysis);
				show_debug_message($"{enemy.identifier} was paralyzed due to {pokemon.identifier}'s Static!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("volt-absorb", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(enemy, "volt-absorb")) { return AbilityResult; }
			if (move.type == __PFSTypes.Electric and _damage > 0) {
				_damage = round(enemy.base.hp / 4) * -1;
				show_debug_message($"{enemy.identifier} recovered {_damage * -1} hp due to Volt Absorb!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("water-absorb", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(enemy, "water-absorb")) { return AbilityResult; }
			if (move.type == __PFSTypes.Water and _damage > 0 and __PFS_pokemon_have_ability(enemy, "water-absorb")) {
				_damage = round(enemy.base.hp / 4) * -1;
				show_debug_message($"{enemy.identifier} recovered {_damage * -1} hp due to Volt Absorb!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("pixilate", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "pixilate")) { return AbilityResult; }
			if (move.type == __PFSTypes.Normal) {
			    show_debug_message($"{move.identifier} has changed type from Normal to Fairy by {pokemon.identifier}'s Pixilate!");
				if (move.mpower != "") {
				    move.mpower = round(real(move.mpower) * 1.3);
				}
				move.type = __PFSTypes.Fairy;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	//set_ability_code("oblivious", {
	//	when : AbilityTime.Start,
	//	AbilityCodeStart
	//		if (!__PFS_pokemon_have_ability(pokemon, "oblivious")) { return AbilityResult; }
	//		if (pokemon.taunted) { //TODO: test this
	//		    pokemon.taunted = false;
	//			show_debug_message($"{pokemon.identifier} Taunt was removed due to Oblivious!");
	//		}
	//		if (__PFS_pokemon_affected_by_status(enemy, PFSStatusAilments.Infatuation)) {
	//		    enemy = __PFS_remove_status(enemy, PFSStatusAilments.Infatuation);
	//			show_debug_message($"{enemy.identifier} was cured from infatuation due to Oblivious!");
	//		}
	//		if (status[0] == PFSStatusAilments.Infatuation or move.identifier == "captivate") {
	//			status = 0;
	//			show_debug_message($"{enemy.identifier} ignored infatuation/captivate due to Oblivious!");
	//		}
	//		return AbilityResult;
	//	AbilityCodeEnd
	//});
	
	set_ability_code("overgrow", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "overgrow")) { return AbilityResult; }
			if (pokemon.hp < pokemon.base.hp / 3 and move.type == __PFSTypes.Grass) {
			    _damage = _damage * 1.5;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("blaze", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "blaze")) { return AbilityResult; }
			if (pokemon.hp < pokemon.base.hp / 3 and move.type == __PFSTypes.Fire) {
			    _damage = _damage * 1.5;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("torrent", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "torrent")) { return AbilityResult; }
			if (pokemon.hp < pokemon.base.hp / 3 and move.type == __PFSTypes.Water) {
			    _damage = _damage * 1.5;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("shed-skin", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "shed-skin")) { return AbilityResult; }
			var chance = __PFS_rng();
			if (chance <= 33) {
			    pokemon.statusAilments = [];
				__PFS_debug_msg($"{pokemon.identifier} shedded his skin!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("swarm", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "swarm")) { return AbilityResult; }
			if (pokemon.hp < pokemon.base.hp / 3 and move.type == __PFSTypes.Bug) {
			    _damage = _damage * 1.5;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("Own Tempo", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			//show_message($"{enemy.identifier}:{__PFS_pokemon_have_ability(enemy, "own-tempo")}:{__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Confusion)}");
			if (!__PFS_pokemon_have_ability(pokemon, "Own Tempo")) { return AbilityResult; } 
			if (__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Confusion) or (status != 0 and status[0] == PFSStatusAilments.Confusion)) {
			    __PFS_remove_status(pokemon, PFSStatusAilments.Confusion);
				status = 0;
				show_debug_message($"{pokemon.identifier}'s Own Tempo cleansed confusion");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("Guts", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "Guts")) { return AbilityResult; }
			var effects = [PFSStatusAilments.Sleep, PFSStatusAilments.Burn, PFSStatusAilments.Poison];
			var afflicted = false;
			for (var i = 0; i < array_length(pokemon.statusAilments); ++i) {
				for (var j = 0; j < array_length(effects); ++j) {
				    if (pokemon.statusAilments[i][0] == effects[j]) {
						afflicted = true;
					}
				}
			}
			if (afflicted) {
			    _damage = _damage * 1.5;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("poison-point", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "poison-point")) { return AbilityResult; } 
			if (__PFS_move_have_flag(move, "contact")) {
			    var chance = __PFS_rng();
				if (chance <= 30 and !__PFS_pokemon_affected_by_status(enemy, PFSStatusAilments.Poison)) {
				    __PFS_apply_status(enemy, PFSStatusAilments.Poison, -99);
				}
			}
			return AbilityResult;
		AbilityCodeEnd
	});

	set_ability_code("rivalry", {
		when : AbilityTime.AfterDamageCalculation,
		AbilityCodeStart
			if (!__PFS_pokemon_have_ability(pokemon, "rivalry")) { return AbilityResult; }
			if (enemy.gender == pokemon.gender) {
			    _damage = round(_damage * 1.25);
			}
			else {
				_damage = round(_damage * 0.75);
			}
			return AbilityResult;
		AbilityCodeEnd
	});

}