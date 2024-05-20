//Feather disable GM2017
sprites = [sRedWR, sRedWU, sRedWL, sRedWD];
cutmoving = false;
alarms = [
	[0, function(){  }]
];
#region State Machine
fsm = new SnowState("idle");
fsm.add("idle", {
    step: function() {
		player_interact();
		if (keyboard_check(vk_down) or keyboard_check(vk_up) or keyboard_check(vk_left) or keyboard_check(vk_right)) {
			fsm.change("walk");
		}
    }
  })
  .add("walk", {
    step: function() {
		if (instance_exists(oDialog) and !instance_exists(PFSFightSystem) and !instance_exists(oCutscene)) { fsm.change("dialog"); }
		if (!instance_exists(oDialog) and instance_exists(PFSFightSystem)) { fsm.change("battle"); }
		if (!instance_exists(oDialog) and instance_exists(oCutscene)) { fsm.change("cutscene"); }
		player_movement();
    },
	endstep: function() {
		if (keyboard_check(vk_down) or keyboard_check(vk_up) or keyboard_check(vk_left) or keyboard_check(vk_right)) {
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
		  if (!instance_exists(PFSFightSystem)) {
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
//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[4]);
//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[7]);
#region Multiplayer
function sendPos(){
	if (!ONLINE) { exit; }
	send_data({
		type : Contype.Update,
		room : room_get_name(room),
		x : placeToGo[0],
		y : placeToGo[1]
	});
}
if (ONLINE) {
	send_data({
		type : Contype.Join,
		room : room_get_name(room),
		x : x,
		y : y
	});
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