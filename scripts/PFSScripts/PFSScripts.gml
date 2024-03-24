//Feather disable GM2017
global.__PFS = {};
global.__PFS.playerPokemons = [];
global.__PFS.moves = [];
global.__PFS.Pokes = [];
global.__PFS.__PFSTypes = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy", "NoType"];
global.__PFS.__PFSMoveCategory = [["Physical", sPFSPhysicalIcon], ["Special", sPFSSpecialIcon], ["Status", sPFSStatusIcon]];
enum __PFSTypes {
	Normal, 
	Fire, 
	Water, 
	Grass, 
	Flying, 
	Fighting, 
	Poison, 
	Electric, 
	Ground, 
	Rock, 
	Psychic, 
	Ice, 
	Bug, 
	Ghost, 
	Steel, 
	Dragon, 
	Dark, 
	Fairy,
	NoType
};
enum __PFSMoveCategory {
	Physical,
	Special,
	Status
}
enum __PFSMoveMethods {
	Null,
	Levelup
}
enum __PFSBattleMenus {
	Battle, 
	Pokemon,
	Item,
	Run
}
enum __PFSBattleSides {
	Player,
	Enemy
}
#region Move effectiveness
global.__PFS.typesEffect = [];
global.__PFS.typesEffect[__PFSTypes.Normal] = {
	strong : [],
	weak : [__PFSTypes.Fighting],
	immune : [__PFSTypes.Ghost]
};
global.__PFS.typesEffect[__PFSTypes.Fire] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Grass, __PFSTypes.Ice, __PFSTypes.Bug, __PFSTypes.Steel, __PFSTypes.Fairy],
	weak : [__PFSTypes.Water, __PFSTypes.Ground, __PFSTypes.Rock],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Water] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Water, __PFSTypes.Ice, __PFSTypes.Steel],
	weak : [__PFSTypes.Electric, __PFSTypes.Grass],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Grass] = {
	strong : [__PFSTypes.Water, __PFSTypes.Electric, __PFSTypes.Grass, __PFSTypes.Ground],
	weak : [__PFSTypes.Fire, __PFSTypes.Ice, __PFSTypes.Poison, __PFSTypes.Flying, __PFSTypes.Bug],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Flying] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Bug],
	weak : [__PFSTypes.Electric, __PFSTypes.Ice, __PFSTypes.Rock],
	immune : [__PFSTypes.Ground]
};
global.__PFS.typesEffect[__PFSTypes.Fighting] = {
	strong : [__PFSTypes.Bug, __PFSTypes.Rock, __PFSTypes.Dark],
	weak : [__PFSTypes.Flying, __PFSTypes.Psychic, __PFSTypes.Fairy],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Poison] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Poison, __PFSTypes.Bug, __PFSTypes.Fairy],
	weak : [__PFSTypes.Ground, __PFSTypes.Psychic],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Electric] = {
	strong : [__PFSTypes.Electric, __PFSTypes.Flying, __PFSTypes.Steel],
	weak : [__PFSTypes.Ground],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Ground] = {
	strong : [__PFSTypes.Poison, __PFSTypes.Rock],
	weak : [__PFSTypes.Water, __PFSTypes.Grass, __PFSTypes.Ice],
	immune : [__PFSTypes.Electric]
};
global.__PFS.typesEffect[__PFSTypes.Rock] = {
	strong : [__PFSTypes.Normal, __PFSTypes.Fire, __PFSTypes.Poison, __PFSTypes.Flying],
	weak : [__PFSTypes.Water, __PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Ground, __PFSTypes.Steel],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Psychic] = {
	strong : [__PFSTypes.Fighting, __PFSTypes.Psychic],
	weak : [__PFSTypes.Bug, __PFSTypes.Ghost, __PFSTypes.Dark],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Ice] = {
	strong : [__PFSTypes.Ice],
	weak : [__PFSTypes.Fire, __PFSTypes.Fighting, __PFSTypes.Rock, __PFSTypes.Steel],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Bug] = {
	strong : [__PFSTypes.Grass, __PFSTypes.Fighting, __PFSTypes.Ground],
	weak : [__PFSTypes.Fire, __PFSTypes.Flying, __PFSTypes.Rock],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Ghost] = {
	strong : [__PFSTypes.Poison, __PFSTypes.Bug],
	weak : [__PFSTypes.Ghost, __PFSTypes.Dark],
	immune : [__PFSTypes.Normal, __PFSTypes.Fighting]
};
global.__PFS.typesEffect[__PFSTypes.Steel] = {
	strong : [__PFSTypes.Normal, __PFSTypes.Grass, __PFSTypes.Ice, __PFSTypes.Flying, __PFSTypes.Psychic, __PFSTypes.Bug, __PFSTypes.Rock, __PFSTypes.Dragon, __PFSTypes.Steel, __PFSTypes.Fairy],
	weak : [__PFSTypes.Fire, __PFSTypes.Fighting, __PFSTypes.Ground],
	immune : [__PFSTypes.Poison]
};
global.__PFS.typesEffect[__PFSTypes.Dragon] = {
	strong : [__PFSTypes.Fire, __PFSTypes.Water, __PFSTypes.Electric, __PFSTypes.Grass],
	weak : [__PFSTypes.Ice, __PFSTypes.Dragon, __PFSTypes.Fairy],
	immune : []
};
global.__PFS.typesEffect[__PFSTypes.Dark] = {
	strong : [__PFSTypes.Ghost, __PFSTypes.Dark],
	weak : [__PFSTypes.Fighting, __PFSTypes.Bug, __PFSTypes.Fairy],
	immune : [__PFSTypes.Psychic]
};
global.__PFS.typesEffect[__PFSTypes.Fairy] = {
	strong : [__PFSTypes.Fighting, __PFSTypes.Bug, __PFSTypes.Dark],
	weak : [__PFSTypes.Poison, __PFSTypes.Steel],
	immune : [__PFSTypes.Dragon]
};
global.__PFS.typesEffect[__PFSTypes.NoType] = {
	strong : [],
	weak : [],
	immune : []
};
#endregion

function __PFS_is_effective(pokemon, move, pos){
	var _movetype = move.type;
	var _poketype = pokemon.type[pos];
	var _effective = -1;
	if (_effective == -1) {
	    _effective = array_get_index(global.__PFS.typesEffect[_poketype].strong, _movetype) >= 0 ? 0.5 : -1;
	}
	if (_effective == -1) {
		_effective = array_get_index(global.__PFS.typesEffect[_poketype].weak, _movetype) >= 0 ? 2 : -1;
	}
	if (_effective == -1) {
	    _effective = array_get_index(global.__PFS.typesEffect[_poketype].immune, _movetype) >= 0 ? 0 : -1;
	}
	if (_effective == -1) {
	    _effective = 1;
	}
	return _effective;
}

function __PFS_add_move(internalName){
	return variable_clone(global.__PFS.moves[internalName]);
}

function __PFS_damage_calculation(pokemon, enemy, move){
	var _critChance = irandom_range(0, 255);
	var _critTreshold = pokemon.speed / 2; //TODO: High crit chance atk and items
	var _isCritical = _critChance <= _critTreshold ? 2 : 1; //TODO _isCritical = 1 if target ability is Battle Armor or Shell Armor or with Luck Chant
	var _level = real(pokemon.level);
	var _power = real(move.mpower);
	var _stab = array_get_index(pokemon.type, move.type) != -1 ? 1.5 : 1;
	var _type1 = __PFS_is_effective(enemy, move, 0);
	var _type2 = array_length(enemy.type) > 1 ? __PFS_is_effective(enemy, move, 1) : 1;
	var _type = 1 * _type1 * _type2;
	var _rnd = random_range(0.85, 1);
	#region //TODO
	var _targets = 1; //TODO: 0.75 if more than one target (0.5 in battle royale)
	var _pb = 1; //TODO: Parental Bond second hit = 0.25
	var _weather = 1 //TODO: Weather
	var _glaiverush = 1; //TODO: Glaive Rush = 2 if the move was used in the previous turn
	var _burn = 1;
	var _other = 1;
	#endregion
	var _a = 1;
	var _d = 1;
	switch (move.type) { //TODO: unmodified on criticals, light screen, reflect, 
	    case __PFSMoveCategory.Physical:
	        _a = pokemon.attack;
			_d = enemy.defense;
	        break;
	    case __PFSMoveCategory.Special:
	        _a = pokemon.spatk;
			_d = enemy.spdef;
	        break;
	}
	if (_a > 255 or _d > 255) {
	    _a = floor(_a / 4);
	    _d = floor(_d / 4);
	}
	var _damage = ( ( ( 2 * _level / 5 + 2) * _power * (_a / _d) ) / 50 + 2 );
	_damage = _damage * _targets * _pb * _weather * _glaiverush * _isCritical * _rnd * _stab * _type * _burn * _other;
	_damage = round(_damage);
	show_debug_message($"Dealt ( ( ( 2 * {_level} / 5 + 2) * {_power} * ({_a} / {_d}) ) / 50 + 2 )  * {_targets} * {_pb} * {_weather} * {_glaiverush} * {_isCritical} * {_rnd} * {_stab} * {_type} * {_burn} * {_other} = {_damage} damage");
	return _damage;
}

function __PFS_generate_pokemon(pokemon){
	pokemon.level = irandom_range(real(pokemon.wildlevelrange[0]), real(pokemon.wildlevelrange[1]));
	pokemon.moves = [];
	for (var i = 0; i < array_length(pokemon.canLearn.level); ++i) {
	    if (array_length(pokemon.moves) < 4) {
		    if (pokemon.canLearn.level[i].level < pokemon.level) {
			    array_push(pokemon.moves, __PFS_add_move(pokemon.canLearn.level[i].id));
			}
		}
	}
	pokemon.ivs = {
		hp : irandom_range(0, 31),
		attack : irandom_range(0, 31),
		defense : irandom_range(0, 31),
		spatk : irandom_range(0, 31),
		spdef : irandom_range(0, 31),
		speed : irandom_range(0, 31),
	}
	pokemon.evs = {
		hp : 0,
		attack : 0,
		defense : 0,
		spatk : 0,
		spdef : 0,
		speed : 0
	}
	return __PFS_recalculate_stats(pokemon, true);
}

function __PFS_recalculate_stats(pokemon, pokecenter = false){
	if (pokemon[$ "base"] == undefined) {
	    pokemon[$ "base"] = {};
	}
	var _names = variable_struct_get_names(pokemon.basecalc);
	var _result = "";
	for (var i = 0; i < array_length(_names); ++i) {
		switch (_names[i]) {
		    case "hp":
		        variable_struct_set(pokemon.base, "hp", floor(0.01 * (2 * real(pokemon.basecalc.hp) + real(pokemon.ivs.hp) + floor(0.25 * real(pokemon.evs.hp))) * real(pokemon.level)) + real(pokemon.level) + 10);
				if (pokecenter) {
				    variable_struct_set(pokemon, "hp", floor(0.01 * (2 * real(pokemon.basecalc.hp) + real(pokemon.ivs.hp) + floor(0.25 * real(pokemon.evs.hp))) * real(pokemon.level)) + real(pokemon.level) + 10);
				}
		        break;
		    default:
				var _basestat = variable_struct_get(pokemon.basecalc, _names[i]);
				var _iv = variable_struct_get(pokemon.ivs, _names[i]);
				var _ev = variable_struct_get(pokemon.evs, _names[i]);
				var _nature = 1; //TODO: nature
		        variable_struct_set(pokemon.base, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				if (pokecenter) {
				    variable_struct_set(pokemon, _names[i], ((floor(0.01 * (2 * real(_basestat) + real(_iv) + floor(0.25 * real(_ev))) * real(pokemon.level))) + 5) * 1);
				}
		        break;
		}
	}
	return pokemon;
}

#region Functions
#endregion
function createbutton(_x, _y, text, textscale, show_border = true, bgalpha = 0.25, _color = c_white) {
	var _clicked = false;
	var w = string_width(text) * textscale;
	var h = string_height(text) * textscale;	
	draw_set_color(c_black);
	draw_set_alpha(bgalpha);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, false);
	}
	draw_set_color(c_white);
	draw_set_alpha(1);
	if (show_border) {
	    draw_rectangle(_x - 3, _y - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_text_transformed_color(_x, _y, text, textscale, textscale, 0, _color, _color, _color, _color, 1);
	if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function createbuttonspr(_x, _y, spr, subimg, sprscale, show_border = true, _color = c_white, align = "topleft", button = mb_left) {
	var _clicked = false;
	var pw = 0;
	var ph = 0;
	var w = sprite_get_width(spr) * sprscale;
	var h = sprite_get_height(spr) * sprscale;
	switch (align) {
	    case "middlecenter":
			w = w / 2;
			h = h / 2;
			ph = h;
			pw = w
	        break;
	    default:
	        // code here
	        break;
	}
	if (show_border) {
	    draw_rectangle(_x - pw - 3, _y - ph - 4, _x + w + 2, _y + h + 4, true);
	}
	draw_sprite_ext(spr, subimg, _x, _y, sprscale, sprscale, 0, _color, 1);
	if (mouse_check_button_pressed(button) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x - pw, _y - ph, _x + w, _y + h)) {
		_clicked = true;
	}
	return _clicked;
}
function textbox(x, y, name, value, editing) {
	var _x = x;
	var _y = y;
	var _value = variable_instance_get(self, value);
	var _set = variable_instance_get(self, "set");
	if (editing) {
		if (!_set) {
		    keyboard_string = _value;
			variable_instance_set(self, "set", true);
		}
		if (keyboard_string != "") {
		    variable_instance_set(self, value, keyboard_string);
		}
	}
	draw_text(_x, _y, $"{name}: ");
	_x += string_width($"{name}: ");
	draw_text(_x, _y, _value);
	var _color = editing ? c_yellow : c_white;
	draw_rectangle_color(_x, _y, _x + string_width(_value), _y + string_height(_value), _color, _color, _color, _color, true);
}	
	
