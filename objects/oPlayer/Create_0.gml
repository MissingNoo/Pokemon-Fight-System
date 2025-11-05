//Feather disable GM2017
if (file_exists("pdata.gme")) {
    PlayerData = json_load("pdata.gme");
	PlayerData.inventory = new Inventory();
	if (PlayerData[$ "inventory_data"] != undefined) {
	    var items = string_split(PlayerData.inventory_data, ";");
		array_foreach(items, function(e, i) { 
			var item = string_split(e, ":");
			if (e != "") { 
				PlayerData.inventory.add_item(item[0], real(item[1]));
			}
		});
	}
    DialogData[$"playername"] = PlayerData.name;
    DialogData[$"rivalname"] = PlayerData.rivalname;
}
sprites = [sRedWR, sRedWU, sRedWL, sRedWD];
cutmoving = false;
alarms = [
	[0, function(){  }]
];
#region State Machine
fsm = new SnowState("idle");
fsm.add("idle", {
	beginstep: function() {
		if (instance_exists(oDialog) and !instance_exists(NewFightSystem) and !instance_exists(oCutscene)) { fsm.change("dialog"); }
		if (!instance_exists(oDialog) and instance_exists(NewFightSystem)) { fsm.change("battle"); }
		if (!instance_exists(oDialog) and instance_exists(oCutscene)) { fsm.change("cutscene"); }
	},
    step: function() {
		player_interact();
		if (input_check("down") or input_check("up") or input_check("left") or input_check("right")) {
			fsm.change("walk");
		}
    }
  })
  .add("walk", {
    step: function() {
		if (instance_exists(oDialog) and !instance_exists(NewFightSystem) and !instance_exists(oCutscene)) { fsm.change("dialog"); }
		if (!instance_exists(oDialog) and instance_exists(NewFightSystem)) { fsm.change("battle"); }
		if (!instance_exists(oDialog) and instance_exists(oCutscene)) { fsm.change("cutscene"); }
		player_movement();
    },
	endstep: function() {
		if (input_check("down") or input_check("up") or input_check("left") or input_check("right")) {
			sendPos();
			cansend = false;
		}
		else if (x == placeToGo[0] and y == placeToGo[1]){
			fsm.change("idle");
		}
	}
  })
  .add("battle", {
	  enter: function() {
		  image_speed = 0;
		  image_index = 1;
	  },
	  endstep: function() {
		  if (!instance_exists(NewFightSystem)) {
		      fsm.change("idle");
		  }
	  },
	  draw: function() {
		  draw_sprite_ext(sLectureBall, 0, x, y - sprite_height - 10, .5, .5, 0, c_white, .5);
	  }
  })
  .add("bag", {
	  enter: function() {
		  image_speed = 0;
		  image_index = 1;
	  },
	  endstep: function() {
		  if (!instance_exists(oBag)) {
		      fsm.change("idle");
		  }
	  },
	  draw: function() {
		  draw_sprite_ext(sLectureBall, 0, x, y - sprite_height - 10, .5, .5, 0, c_white, .5);
	  }
  })
  .add("dialog", {
	  enter: function() {
		  image_speed = 0;
		  image_index = 1;
	  },
	  endstep: function() {
		  if (!instance_exists(oDialog)) {
		      fsm.change("idle");
		  }
	  }
  })
  .add("cutscene", {
	  enter: function() {
		  image_speed = 0;
		  image_index = 1;
	  },
	  step: function(){
		  cutscene_movement();
	  },
	  draw: function() {
		  draw_sprite_ext(sLectureBall, 0, x, y - sprite_height - 10, .5, .5, 0, c_white, .5);
		  //draw_text(x + 20, y, $"x:{x}\ny:{y}");
	  },
	  endstep: function() {
		  if (!instance_exists(oCutscene)) {
		      fsm.change("idle");
		  }
	  }
  });

#endregion
if (!instance_exists(oDepthManager)) {
	instance_create_depth(x, y, depth, oDepthManager);
}
if (instance_number(oPlayer) > 1) { instance_destroy(); }
visible = false;
display_set_gui_size(720*1.5, 480*1.5);
moving = false;
image_speed = 0;
image_index = 1;
stairoffset = 0;
movecam = true;
PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);
PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[4]);
PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[7]);
#region Multiplayer
function sendPos(){
	if (!ONLINE) { exit; }
	//send_data({
		//type : Contype.Update,
		//room : room_get_name(room),
		//x : placeToGo[0],
		//y : placeToGo[1]
	//});
}
if (ONLINE) {
	//send_data({
		//type : Contype.Join,
		//room : room_get_name(room),
		//x : x,
		//y : y
	//});
}
#endregion
DebugManager.debug_add_config(self, {
	text : "x",
	type : DebugTypes.UpDown,
	variable : "x",
	//func: function(){},
	page : "Player"
});
DebugManager.debug_add_config(self, {
	text : "y",
	type : DebugTypes.UpDown,
	variable : "y",
	//func: function(){},
	page : "Player"
});
DebugManager.debug_add_config(self, {
	text : "Get pos",
	type : DebugTypes.Button,
	func: function(){ show_debug_message($"[{oPlayer.x}, {oPlayer.y}]"); },
	page : "Player"
});
//PlayerInventory.add_item("PokeBall");
//PlayerInventory.add_item("GreatBall");
//PlayerInventory.add_item("Potion");
//PlayerInventory.add_item("SuperPotion");
var _enemyPokemon = [__PFS_generate_pokemon(PFS.Pokes[irandom_range(1, 255)]), __PFS_generate_pokemon(PFS.Pokes[27])];
_enemyPokemon[0].level = 16;
_enemyPokemon[0] = __PFS_recalculate_stats(_enemyPokemon[0], true);
instance_destroy(NewFightSystem);
if (!instance_exists(NewFightSystem)) {
	instance_create_depth(0, 0, 0, NewFightSystem, {enemyPokemon : _enemyPokemon});
}