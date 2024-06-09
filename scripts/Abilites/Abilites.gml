//Feather disable GM2017
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
#macro AbilityCodeStart code: function(pokemon, enemy, move, status, isCritical, _damage) {
#macro AbilityCode [pokemon, enemy, move, status, isCritical, _damage]
#macro AbilityCodeEnd }
function populate_abilities() {
	PFS.AbilitiesCode = array_create(array_length(PFS.Abilities), undefined);
	//set_ability_code("", {
	//	when : AbilityTime.Start,
	//	AbilityCodeStart
	//		return AbilityCode;
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
			return AbilityCode;
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
			return AbilityCode;
		AbilityCodeEnd
	});
	set_ability_code("soundproof", {
		when : AbilityTime.Start,
		AbilityCodeStart
			if (status[0] == PFSStatusAilments.Perish_song) {
				show_debug_message($"{enemy.internalName}'s Soundproof ignored Perish Song!");
				array_push(global.nextdialog, {npc : "Battle", text : $"SoundProofPerish", onBattle : true});
				status = 0;
			}
			return AbilityCode;
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
			return AbilityCode;
		AbilityCodeEnd
	});
	set_ability_code("static", {
		when : AbilityTime.AfterDamage,
		AbilityCodeStart
			if (move.category == PFSMoveCategory.Status or move.category == PFSMoveCategory.Special) { 
				return AbilityCode;
			}
			var _chance = irandom_range(0, 100);
			if (_chance <= 30 and !__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Paralysis)) {
				__PFS_apply_status(pokemon, PFSStatusAilments.Paralysis);				
				show_debug_message($"{pokemon.internalName} was paralyzed due to {enemy.internalName}'s Static!");
			}
			return AbilityCode;
		AbilityCodeEnd
	});
}