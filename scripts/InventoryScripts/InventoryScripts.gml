//Feather disable GM2017
global.gameitems = [];
#macro GameItems global.gameitems

#macro PlayerInventory PlayerData.inventory
enum ItemType {
	Common_Item,
	Key_Item,
	Poke_ball
}

function Inventory() constructor {
	items = [];
	static add_item = function(itemname, quantity = 1) {
		for (var i = 0; i < array_length(GameItems); ++i) {
			for (var j = 0; j < array_length(items); ++j) {
			    if (items[j].name == itemname) {
				    items[j].quantity++;
					return;
				}
			}
			if (GameItems[i].name == itemname) {
			    array_push(items, GameItems[i]);
				return;
			}
		}
	}
}
PlayerData.inventory = new Inventory();

function Item(_name, _type, _sprite) constructor {
	static itemID = 0;
	itemid = itemID;
	name = _name;
	itemType = _type;
	sprite = _sprite;
	quantity = 1;
	itemID++;
}

array_push(GameItems, new Item("PokeBall", ItemType.Poke_ball, sIPokeball));
