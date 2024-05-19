//Feather disable GM2017
if (instance_number(oBag) > 1) { instance_destroy(); }
windowSize = [700, 400];
startPosition = [GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2)];
reclerp = 0;
bagoffset = 0;
drawalpha = 1;
selecteditem = 0;
tabselected = 0;

function next_item_from_tab(tab, startfrom = -1) {
	var _invlen = array_length(PlayerInventory.items);
	for (var i = startfrom + 1; i <= _invlen ; ++i) {
	    if (i >= _invlen) {
		    return _invlen;
		}
		if (PlayerInventory.items[i].itemType == tab) {
			return i;
		}
	}
	return next_item_from_tab(tabselected, -1);
}
function previous_item_from_tab(tab, startfrom = -1) {
	var _invlen = array_length(PlayerInventory.items);
	for (var i = startfrom - 1; i >= 0; --i) {
	    if (i < 0) {
		    return 0;
		}
		if (PlayerInventory.items[i].itemType == tab) {
			return i;
		}
	}
	return _invlen;
}

fsm = new SnowState("Items");
fsm.add("Items", {
	enter: function() {
		reclerp = 284;
		selecteditem = next_item_from_tab(ItemType.Common_Item);
		bagoffset = -10;
	},
	beginstep: function() {
		if (keyboard_check_pressed(vk_right)) {
		    fsm.change("KeyItems");
		}
	},
    step: function() {
		
    },
	draw: function() {
		
	}
  })
  .add("KeyItems", {
	enter: function() {
		reclerp = 284;
		selecteditem = next_item_from_tab(ItemType.Key_Item);
		bagoffset = -10;
	},
	beginstep: function() {
		if (keyboard_check_pressed(vk_right)) {
		    fsm.change("Pokeballs");
		}
		if (keyboard_check_pressed(vk_left)) {
		    fsm.change("Items");
		}
	},
    step: function() {
		
    },
	draw: function() {
		
	}
  })
  .add("Pokeballs", {
	enter: function() {
		reclerp = 284;
		selecteditem = next_item_from_tab(ItemType.Poke_ball);
		bagoffset = -10;
	},
	beginstep: function() {
		if (keyboard_check_pressed(vk_left)) {
		    fsm.change("KeyItems");
		}
	},
    step: function() {
		
    },
	draw: function() {
		
	}
  })