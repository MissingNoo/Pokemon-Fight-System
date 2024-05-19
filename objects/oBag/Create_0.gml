//Feather disable GM2017
if (instance_number(oBag) > 1) { instance_destroy(); }
windowSize = [700, 400];
startPosition = [GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2)];
reclerp = 0;
bagoffset = 0;
drawalpha = 1;
enum ItemType {
	Item,
	KeyItem,
	Pokeball
}

selecteditem = 0;
tabselected = 0;

fsm = new SnowState("Items");
fsm.add("Items", {
	enter: function() {
		reclerp = 284;
		selecteditem = 0;
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
		selecteditem = 0;
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
		selecteditem = 0;
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