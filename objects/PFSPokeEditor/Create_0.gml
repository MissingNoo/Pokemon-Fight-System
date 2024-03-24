//Feather disable GM2017
#region Move Editor
show = false;
#endregion

#region Files
file = game_save_id + "Pokes.json";
savedFile = game_save_id + "Pokes.bin";
#endregion

#region Move
poke = 1;
internalName = "Bulbasaur";
lowerlevel = 0;
higherlevel = 0;
hp = 45;
attack = 49;
defense = 49;
spatk = 65;
spdef = 65;
speed = 45;
gender = 0;
defaultpokedata = {
	internalName : "Bulbasaur",
	type : [__PFSTypes.Grass, __PFSTypes.Poison],
	wildlevelrange : [5, 7],
	gender : 0,
	basecalc : {
		hp : 45,
		attack : 49,
		defense : 49,
		spatk : 65,
		spdef : 65,
		speed : 45
	},
	sprite : ["sPFSBulbasaurFront", "sPFSBulbasaurBack"],
	moves : [__PFS_add_move("Growl"), __PFS_add_move("Tackle"), __PFS_add_move("Vine Whip"), __PFS_add_move("Growth")]
}
pokedata = variable_clone(defaultpokedata);
#endregion

#region Information Window
showsprite = sPFSBulbasaurBack;
options = [
	["internalName", "internalName"],
	["Lower level", "lowerlevel"],
	["Higher level", "higherlevel"],
];
var _names = variable_struct_get_names(defaultpokedata.basecalc);
for (var i = 0; i < array_length(_names); ++i) {
    array_push(options, [_names[i], _names[i]]);
}
optionsLenght = array_length(options);
selected = 0;
set = false;
#endregion

#region Move List
moveListOffset = 0;
#endregion

#region Functions
function loadMove(move){
	if (move >= array_length(global.__PFS.Pokes)) { exit; }
	var _move = global.__PFS.Pokes[move];
	pokedata = variable_clone(_move);
	lowerlevel = pokedata.wildlevelrange[0];
	higherlevel = pokedata.wildlevelrange[1];
	internalName = pokedata.internalName;	
	var _names = variable_struct_get_names(defaultpokedata.basecalc);
	for (var i = 0; i < array_length(_names); ++i) {
		variable_instance_set(self, _names[i], variable_struct_get(global.__PFS.Pokes[move].basecalc, _names[i]));
	}
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokedata.internalName + "/" + pokedata.sprite[1] + ".png")) {
	    if (sprite_exists(showsprite)) {
		    sprite_delete(showsprite);
		}
	    showsprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokedata.internalName + "/" + pokedata.sprite[1] + ".png", 0, false, false, 0, 0);
	}
}
if (file_exists(savedFile)) {
	var fs = file_text_open_read(savedFile);
	var _json = file_text_read_string(fs);
	file_text_close(fs);
	global.__PFS.Pokes = json_parse(_json);
}
loadMove(0);
#endregion
for (var i = 0; i < array_length(global.__PFS.Pokes); ++i) {
    global.__PFS.Pokes[i].base = {};
}


if (file_exists("pokedex.json")) {
	//show_message("pokedex");
	var fs = file_text_open_read("pokedex.json");
    var jsonStr = "";
	while (!file_text_eof(fs)) {
	  jsonStr += file_text_read_string(fs);
	  file_text_readln(fs);
	}
	file_text_close(fs);
	var _pokedex = json_parse(jsonStr);
	for (var i = 0; i < array_length(_pokedex); ++i) {
		var _type = [];
		if (array_length(_pokedex[i][$ "type"]) == 2) {
		    _type = [array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[0]), array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[1])];
		}
		if (array_length(_pokedex[i][$ "type"]) == 1) {
			_type = [array_get_index(global.__PFS.__PFSTypes, _pokedex[i].type[0]), __PFSTypes.NoType];
		}
		if (_pokedex[i][$ "base"] == undefined) {
			show_debug_message($"base missing for {_pokedex[i].name.english}")
		    continue;
		}
		var _poke = {
			internalName : _pokedex[i].name.english,
			type : _type,
			evolution : _pokedex[i][$ "evolution"],
			wildlevelrange : [5, 7],
			gender : _pokedex[i][$ "profile"][$ "gender"],
			ability : _pokedex[i][$ "profile"][$ "ability"],
			basecalc : {
				hp : _pokedex[i].base.HP,
				attack : _pokedex[i].base.Attack,
				defense : _pokedex[i].base.Defense,
				spatk : _pokedex[i].base[$ "Sp. Attack"],
				spdef : _pokedex[i].base[$ "Sp. Defense"],
				speed : _pokedex[i].base.Speed
			},
			moves : [__PFS_add_move("Growl"), __PFS_add_move("Tackle"), __PFS_add_move("Vine Whip"), __PFS_add_move("Growth")]
		}
		_poke.sprite = [string(_poke.internalName + "Front"), string(_poke.internalName + "Back")];
	    global.__PFS.Pokes[_pokedex[i].id] = _poke;
	}
	//show_message(global.__PFS.Pokes);
}