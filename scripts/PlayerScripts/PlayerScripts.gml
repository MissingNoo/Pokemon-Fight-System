//Feather disable GM2017
function show_debug_message_debugmode(str) {
	if (DEBUGMODE) {
	    show_debug_message(str);
	}
}
global.dialogdata = {};
enum Gender { Male, Female }

global.playerdata = {
	gender : Gender.Male,
	name : "",
	rivalname : ""
}
#macro PlayerData global.playerdata

function player_movement(){
	if (!moving and !instance_exists(PFSFightSystem) and canmove and global.blackfade[0] < 0.2) {
		if (input_check("left")) {
			if (dir != 180) {
			    dir = 180;
				canmove = false;
				exit;
			}
			if (!place_meeting(x - 16, y, oColision) and dir == 180) {
			    image_speed = 5;
				placeToGo = [x - 16, y];
				moving = true;
			}
		
		}
		if (input_check("right")) {
			if (dir != 0) {
			    dir = 0;
				canmove = false;
				exit;
			}
			if (!place_meeting(x + 16, y, oColision) and dir == 0) {
			    image_speed = 5;
				placeToGo = [x + 16, y];
				moving = true;
			}
		}
		if (input_check("up")) {
			if (dir != 90) {
			    dir = 90;
				canmove = false;
				exit;
			}
			if (!place_meeting(x, y - 16, oColision) and dir == 90) {
			    image_speed = 5;
				placeToGo = [x, y - 16];
				moving = true;
			}
		}
		if (input_check("down")) {
			if (dir != 270) {
				dir = 270;
				canmove = false;
				exit;
			}		
			if (!place_meeting(x, y + 16, oColision) and dir == 270) {
			    image_speed = 5;
				placeToGo = [x, y + 16];
				moving = true;
			}
		}
	}
	if (placeToGo[0] != x and moving) {
	    x += sign(placeToGo[0] - x);
	}
	if (placeToGo[1] != y and moving) {
	    y += sign(placeToGo[1] - y);
	}
	if (placeToGo[0] == x and placeToGo[1] == y) {
		cutmoving = false;
		if (!input_check("down") and !input_check("up") and !input_check("left") and !input_check("right")) {
		    image_speed = 0;
			image_index = 1;
		}
		moving = false;
		cansend = true;
	}
}
function cutscene_movement(){
	if (placeToGo[0] != x) {
	    x += sign(placeToGo[0] - x);
		image_speed = 5;
		if (placeToGo[0] > x and placeToGo[0] != x) {
		    dir = 0;
		}
		else if (placeToGo[0] < x and placeToGo[0] != x) {
			dir = 180;
		}
	}
	if (placeToGo[1] != y) {
	    y += sign(placeToGo[1] - y);
		image_speed = 5;
		if (placeToGo[1] > y and placeToGo[1] != y) {
		    dir = 270;
		}
		else if (placeToGo[1] < y and placeToGo[1] != y) {
			dir = 90;
		}
	}
	if (placeToGo[0] == x and placeToGo[1] == y) {
		cutmoving = false;
		if (instance_exists(oCutscene) and variable_instance_exists(self, "cutscenenpc") and oCutscene.lastnpcinteracted == npc.nid) {
		    oCutscene.cancontinue = true;
		}
		image_speed = 0;
		image_index = 1;
	}
}
function player_interact(){
	if (input_check_pressed("accept")) {
		var _xoffset = 0;
		var _yoffset = 0;
		switch (dir) {
		    case 0:
				_xoffset = 16;
		        _yoffset = 0;
		        break;
		    case 90:
				_xoffset = 0;
		        _yoffset = -16;
		        break;
		    case 180:
				_xoffset = -16;
		        _yoffset = 0;
		        break;
		    case 270:
				_xoffset = 0;
		        _yoffset = 16;
		        break;
		}
	    #region Sign
		var _sign = noone;
		if (collision_line(x, y - 8, x + _xoffset, y + _yoffset - 8, oSign, false, true)) {
		    _sign = instance_place(x + _xoffset, y + _yoffset - 8, oSign);
		}
		if (_sign != noone) {
		    var npc = _sign.npc;
			var text = _sign.text;
			var optionsFalas = _sign.optionsFalas;
			var options = _sign.options;
			if (!instance_exists(oDialog)) {
			    instance_create_depth(x, y, depth - 1, oDialog, {npc : npc, text : text, options : options, optionsFalas : optionsFalas});
				oDialog.onMap();
				oPlayer.fsm.change("dialog");
			}
		}
		#endregion
	    #region Sign
		var _npc = noone;
		if (collision_line(x, y - 8, x + _xoffset, y + _yoffset - 8, oNpc, false, true)) {
		    _npc = instance_place(x + _xoffset, y + _yoffset - 8, oNpc);
		}
		if (_npc != noone) {
		    var npc = _npc.npc.npcname;
			var text = _npc.npc.text;
			var optionsFalas = [];
			var options = [];
			if (!instance_exists(oDialog)) {
			    instance_create_depth(x, y, depth - 1, oDialog, {npc : npc, text : text, options : options, optionsFalas : optionsFalas});
				oDialog.onMap();
				_npc.fsm.change("talk");
				oPlayer.fsm.change("dialog");
			}
		}
		#endregion
	}
}
//Feather disable GM2017
global.gameitems = [];
#macro GameItems global.gameitems

#macro PlayerInventory PlayerData.inventory
enum ItemType {
	Common_Item,
	Key_Item,
	Poke_ball
}
enum UseType {
	Null,
	Pokemon,
	PokeBall
}
enum PotionType {
	Heal
}

function Inventory() constructor {
	items = [];
	static add_item = function(itemname, quantity = 1) {
		for (var i = 0; i < array_length(GameItems); ++i) {
			for (var j = 0; j < array_length(items); ++j) {
			    if (items[j].name == itemname) {
				    items[j].quantity += quantity;
					if (DEBUGMODE) {
					    show_debug_message($"Added {quantity} to {itemname}");
						show_debug_message(PlayerInventory);
					}
					return;
				}
			}
			if (GameItems[i].name == itemname) {
				var _item = GameItems[i];
				_item.quantity += quantity;
			    array_push(items, _item);
				if (DEBUGMODE) {
				    show_debug_message($"Added {itemname} to inventory");
				}
				return;
			}
		}
	}
}
PlayerData.inventory = new Inventory();

function Pokeball(_name, _sprite, _subimg, _catchrate = 1) : Item(_name, _sprite, _subimg) constructor {
	usetype = UseType.PokeBall;
	itemType = ItemType.Poke_ball;
	catchrate = _catchrate;
}

function Potion(_name, _sprite, _subimg, _potionType) : Item(_name, _sprite, _subimg) constructor {
	usetype = UseType.Pokemon;
	itemType = ItemType.Common_Item;
	potionType = _potionType;
}

function Item(_name, _sprite, _subimg) constructor {
	static itemID = 0;
	usetype = UseType.Null;
	name = _name;
	itemType = ItemType.Common_Item;
	sprite = _sprite;
	subimg = _subimg;
	quantity = 0;
	itemID++;
}
//Net Ball
//B = 3 if one of the Pokémon's types is Water or Bug; B = 1 otherwise
//Nest Ball
//B = ((41 - Pokémon's level) / 10), minimum 1
//Dive Ball
//B = 3.5 when on water; B = 1 otherwise
//Repeat Ball
//B = 3 if the Pokémon's species is already registered as caught in the Pokédex; B = 1 otherwise
//Timer Ball
//B = 1 + (number of turns passed in battle * 1229/4096), maximum 4. Since 1229/4096 is approximately 0.3, the bonus reaches its cap on the eleventh turn.
//Quick Ball
//B = 5 on the first turn of a battle; B = 1 otherwise
//Dusk Ball
//B = 3.5 outside at night and inside caves or dark places; B = 1 otherwise (including lit indoor areas at night)
array_push(GameItems, new Pokeball("PokeBall", sPokeballs, 0, 1));
array_push(GameItems, new Pokeball("GreatBall", sPokeballs, 1, 1.5));
array_push(GameItems, new Pokeball("UltraBall", sPokeballs, 2, 2));
array_push(GameItems, new Pokeball("MasterBall", sPokeballs, 3, 0));
array_push(GameItems, new Potion("Potion", sMedicines, 0, PotionType.Heal));
array_push(GameItems, new Potion("SuperPotion", sMedicines, 1, PotionType.Heal));
array_push(GameItems, new Potion("HyperPotion", sMedicines, 2, PotionType.Heal));
array_push(GameItems, new Potion("MaxPotion", sMedicines, 3, PotionType.Heal));


#region Balls
function was_caught(pokemon, ballrate){
	var M = pokemon.base.hp;
	var H = pokemon.hp;
	var G = 1; //Dark Grass
	var C = real(PFS.PokeSpecies[pokemon.species_id].capture_rate);
	var S = 1;
	if (__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Poison) or __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Paralysis) or __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Burn)) {
		S = 1.5;
	}
	if (__PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Sleep) or __PFS_pokemon_affected_by_status(pokemon, PFSStatusAilments.Freeze)) {
		S = 2.5;
	}
	var B = ballrate;
	var E = 100; //unused
	var aa = floor(round(floor(round(round((3 * M - 2 * H) * G) * C * B) / 3 * M) * S) * E / 100);
	var shakes = 0;
	var bb = 65536 * (sqrt(sqrt((aa/1044480))));
	repeat (4) {
	    var _rnd = irandom_range(0, 65535);
		if (_rnd < bb) {
		    shakes++;
		}
	}
	if (shakes == 4) {
	    return true;
	}
	return false;
}
#endregion