//Feather disable GM2017
//Feather disable GM1014
enum AbilityTime {
	Start,
	BeforeDamage,
	AfterDamage
}
/// @function                set_ability_code(name, struct)
/// @description             Set the code to run when a pokemon is hit and have the ability
/// @param {String}     name    The unique instance ID value of the instance to check.
/// @param {Struct}  struct The object index to be checked against.
function set_ability_code(name, struct) {
	PFS.AbilitiesCode[__PFS_get_ability_id(name)] = struct;
}
#macro AbilityCodeStart code: function(pokemon, enemy, move, status, isCritical, _damage, _side) {
#macro AbilityResult [pokemon, enemy, move, status, isCritical, _damage]
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
		when : AbilityTime.BeforeDamage,
		AbilityCodeStart
			if (isCritical == 2) {
				isCritical = 1;
				show_debug_message($"{enemy.internalName}'s Battle Armor cancels the critical damage!");
				array_push(global.nextdialog, {npc : "Battle", text : $"BattleArmor", onBattle : true});
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	set_ability_code("shield-dust", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (move.effect_chance < 100) {
				show_debug_message($"{enemy.internalName}'s Shield Dust cancelled the status effect!");
				//array_push(global.nextdialog, {npc : "Battle", text : $"ShieldDust", onBattle : true});
				status = 0;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	set_ability_code("soundproof", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (__PFS_move_have_flag(move, "sound")) {
				show_debug_message($"{enemy.internalName}'s Soundproof ignored {move.internalName}!");
				DialogData[$ "movename"] = move.internalName;
				DialogData[$ "pokename"] = enemy.internalName;
				array_push(global.nextdialog, {npc : "Battle", text : $"SoundProof", onBattle : true});
				status = 0;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	set_ability_code("sturdy", {
		when : AbilityTime.AfterDamage,
		AbilityCodeStart
			if (enemy.base.hp == enemy.hp and _damage > enemy.hp and !__PFS_pokemon_have_ability(pokemon, "mold-breaker")) {
				_damage = enemy.hp - 1;
				show_debug_message($"{enemy.internalName} held out thanks to Sturdy!");
				global.dialogdata[$"pokename"] = enemy.internalName;
				spawn_dialog("Sturdy");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	set_ability_code("static", {
		when : AbilityTime.AfterDamage,
		AbilityCodeStart
			if (__PFS_move_have_flag(move, "contact")
				and __PFS_rng() <= 30
				and !__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Paralysis)
				and __PFS_pokemon_have_ability(enemy, "static")
				and !__PFS_pokemon_have_type(pokemon, __PFSTypes.Electric)) {
				pokemon = __PFS_apply_status(pokemon, PFSStatusAilments.Paralysis);
				show_debug_message($"{pokemon.internalName} was paralyzed due to {enemy.internalName}'s Static!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("volt-absorb", {
		when : AbilityTime.AfterDamage,
		AbilityCodeStart
			if (move.type == __PFSTypes.Electric and _damage > 0 and __PFS_pokemon_have_ability(enemy, "volt-absorb")) {
				_damage = round(pokemon.base.hp / 4) * -1;
				show_debug_message($"{enemy.internalName} recovered {_damage * -1} hp due to Volt Absorb!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("water-absorb", {
		when : AbilityTime.AfterDamage,
		AbilityCodeStart
			if (move.type == __PFSTypes.Water and _damage > 0 and __PFS_pokemon_have_ability(enemy, "water-absorb")) {
				_damage = round(pokemon.base.hp / 4) * -1;
				show_debug_message($"{enemy.internalName} recovered {_damage * -1} hp due to Volt Absorb!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("pixilate", {
		when : AbilityTime.Start,
		AbilityCodeStart
			move = variable_clone(move);
			if (move.type == __PFSTypes.Normal) {
			    show_debug_message($"{move.internalName} has changed type from Normal to Fairy by {pokemon.internalName}'s Pixilate!");
				if (move.mpower != "") {
				    move.mpower = round(real(move.mpower) * 1.3);
				}
				move.type = __PFSTypes.Fairy;
			}
			return AbilityResult;
		AbilityCodeEnd
	});
	
	set_ability_code("oblivious", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (pokemon.taunted) { //TODO: test this
			    pokemon.taunted = false;
				show_debug_message($"{pokemon.internalName} Taunt was removed due to Oblivious!");
			}
			if (__PFS_pokemon_affected_by_status(enemy, PFSStatusAilments.Infatuation)) {
			    enemy = __PFS_remove_status(enemy, PFSStatusAilments.Infatuation);
				show_debug_message($"{enemy.internalName} was cured from infatuation due to Oblivious!");
			}
			if (status[0] == PFSStatusAilments.Infatuation or move.internalName == "captivate") {
				status = 0;
				show_debug_message($"{enemy.internalName} ignored infatuation/captivate due to Oblivious!");
			}
			return AbilityResult;
		AbilityCodeEnd
	});
}