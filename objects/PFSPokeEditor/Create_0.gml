//Feather disable GM2017
#region Move Editor
show = false;
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
	//moves : [__PFS_add_move("Growl"), __PFS_add_move("Tackle"), __PFS_add_move("Vine Whip"), __PFS_add_move("Growth")]
}
pokedata = variable_clone(defaultpokedata);
#endregion

#region Information Window
x1=0;
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

#region Poke List
pokeListOffset = 0;
canLearnOffset = 0;
canLearnMaxY = 1028;
#endregion

#region Functions
function loadPoke(move){
	if (move >= array_length(PFS.Pokes)) { exit; }
	var _move = PFS.Pokes[move];
	pokedata = variable_clone(_move);
	lowerlevel = pokedata.wildlevelrange[0];
	higherlevel = pokedata.wildlevelrange[1];
	internalName = pokedata.internalName;	
	var _names = variable_struct_get_names(defaultpokedata.basecalc);
	for (var i = 0; i < array_length(_names); ++i) {
		variable_instance_set(self, _names[i], variable_struct_get(PFS.Pokes[move].basecalc, _names[i]));
	}
	if (file_exists(working_directory + "/PFS/Sprites/Pokemons/" + pokedata.internalName + "/" + pokedata.sprite[1] + ".png")) {
	    if (sprite_exists(showsprite)) {
		    sprite_delete(showsprite);
		}
	    showsprite = sprite_add(working_directory + "/PFS/Sprites/Pokemons/" + pokedata.internalName + "/" + pokedata.sprite[1] + ".png", 0, false, false, 0, 0);
	}
}
loadPoke(1);
#endregion