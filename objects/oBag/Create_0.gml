//Feather disable GM2017
if (instance_number(oBag) > 1) { instance_destroy(); }
windowSize = [700, 400];
startPosition = [GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2)];
reclerp = 0;
bagoffset = 0;
drawalpha = 1;
selecteditem = 0;
tabselected = 0;
interactoptions = ["Use", "Give", "Toss", "Cancel"];
interactoption = 0;

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
		if (input_check_pressed("right") and fsn.get_current_state() == "Idle") {
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
		if (input_check_pressed("right") and fsn.get_current_state() == "Idle") {
		    fsm.change("Pokeballs");
		}
		if (input_check_pressed("left") and fsn.get_current_state() == "Idle") {
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
		if (input_check_pressed("left") and fsn.get_current_state() == "Idle") {
		    fsm.change("KeyItems");
		}
	},
    step: function() {
		
    },
	draw: function() {
		
	}
  })
  
fsn = new SnowState("Idle");
fsn.add("Idle", {
	enter: function() {
	},
	beginstep: function() {
		if (input_check_pressed("accept")) {
		    fsn.change("Interacting");
		}
	}
})
.add("Interacting", {
	enter: function() {
		if (onBattle) {
			interactoptions = ["Use", "Cancel"];
		}
	},
	step: function() {
		if (keyboard_check_pressed(ord("X"))) {
		    fsn.change("Idle");
		}
		interactoption += -input_check_pressed("up") + input_check_pressed("down");
		if (interactoption < 0) {
		    interactoption = 0;
		}
		if (interactoption > array_length(interactoptions) - 1) {
		    interactoption = array_length(interactoptions) - 1;
		}
		if (input_check_pressed("accept")) {
			if (interactoption == array_length(PlayerInventory.items)) {
				if (onBattle) {
				    PFSFightSystem.selectingMenu = true;
				}
			    instance_destroy();
				exit;
			}
		    switch (interactoptions[interactoption]) {
				case "Use":
					if (onBattle) {
						if (selecteditem != array_length(PlayerInventory.items)) {
							PFSFightSystem.selectedMenu = 0;
							//PFSFightSystem.selectingMenu = true;
						    array_push(PFSFightSystem.turnSteps, [PFSTurnType.UseItem, PlayerInventory.items[selecteditem]]);
							//PFSFightSystem.doTurn = true;
							PFSFightSystem.sys.change("preturn");
						}
						else {
							PFSFightSystem.sys.change("menu");
						}
						instance_destroy();
					}
					break;
			    case "Cancel":
			        fsn.change("Idle");
			        break;
			    default:
			        // code here
			        break;
			}
		}
	}
})