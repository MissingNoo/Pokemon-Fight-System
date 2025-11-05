lecture_startup();
naming = "player";
dialog = noone;
screen = 5;
alpha = 1;
lerpto = 1;
lerping = false;
lerped = false;
blackalpha = 0;
blacklerp = 0;
blacklerping = false;
scale = 3;
oakalpha = [1, 1];
playeralpha = [0, 0];
rivalalpha = [0, 0];
ini_open("Game.ini");
var _lectureDone = bool(ini_read_real("Game", "SeenLecture", false));
ini_close();
if ((_lectureDone or string_contains(os_get_config(), "No-Lecture")) and !string_contains(os_get_config(), "Force-Lecture")) {
    room_goto(rPlayerHouse2f);
}

#region State Machine
fsm = new SnowState("idle");
fsm.add("idle", {
	enter : function() {
		instance_activate_object(oDialog);
	},
	step: function() {
		if (input_check_pressed("accept") and !lerping and !blacklerping) {
			if (dialog != noone) {
			    exit;
			}
			if (screen < 2) {
			    lerping = true;
				lerpto = 0;
				exit;
			}
			if (screen == 2) {
			    blacklerping = true;
				blacklerp = 1;
				exit;
			}
			if (screen > 2 and screen < 5) {
				screen++;
				exit;
			}
			if (screen == 5) {
				blacklerping = true;
				blacklerp = 1;
				exit;
			}
		}
		#region controls
		if (alpha != lerpto) {
			if (lerping) {
			    alpha = lerp(alpha, lerpto, 0.25);
			}
		}
		else {
			lerping = false;
			if (alpha == 0) {
				screen++;
			    lerping = true;
				lerpto = 1;
			}
		}
		#endregion

		#region Fade
		if (blackalpha != blacklerp) {
			if (blacklerping) {
			    blackalpha = lerp(blackalpha, blacklerp, 0.25);
			}
		}
		else {
			blacklerping = false;
			if (blackalpha == 1) {
				if (screen == 5) {
					var npc = "OakLecture";
					var text = "Intro";
					var optionsFalas = ["Intro", "AfterName", "RivalIntro"];
					var options = 
					{
						"Intro" :  [
							new dialog_option("BOY").set_goto("Selected").set_function(function(){PlayerData.gender = Gender.Male}),
							new dialog_option("GIRL").set_goto("Selected").set_function(function(){PlayerData.gender = Gender.Female})
						],
						"AfterName" : [
							new dialog_option("Yes").set_goto("RivalIntro").set_function(function(){PlayerData.gender = Gender.Male}),
							new dialog_option("No").set_goto("Selected").set_function(function() { oLecture.screen = 6; oLecture.fsm.change("typing"); oLecture.naming = "player"; }),
						],
						"RivalIntro" : [
							new dialog_option("NEW NAME").set_goto("AfterRivalName").set_function(function() { oLecture.fsm.change("typing"); oLecture.naming = "rival"; }),
							new dialog_option("Green").set_goto("AfterRivalName").set_function(function() { PlayerData.rivalname = "Green"; DialogData[$ "rivalname"] = PlayerData.rivalname; }),
							new dialog_option("Gary").set_goto("AfterRivalName").set_function(function() { PlayerData.rivalname = "Gary"; DialogData[$ "rivalname"] = PlayerData.rivalname; }),
						]
					}
					if (dialog == noone) {
					    dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : npc, text : text, options : options, dialog_sprite: sDialogWindow2});
					}
				}
				screen++;
				blacklerping = true;
				blacklerp = 0;
			}
		}
		oakalpha[0] = lerp(oakalpha[0], oakalpha[1], 0.1);
		if (rivalalpha[0] == 0) {
		    playeralpha[0] = lerp(playeralpha[0], playeralpha[1], 0.1);
		}
		if (playeralpha[0] == 0) {
		    rivalalpha[0] = lerp(rivalalpha[0], rivalalpha[1], 0.1);
		}		
		#endregion
    },
	draw : function() {
		switch (screen) {
		    case 0:
		    case 1:
		    case 2:
		    case 3:
		    case 4:
		    case 5:
		        draw_sprite_ext(sLectureBBG, 0, 0, 0, scale, scale, 0, c_white, 1);
				draw_sprite_ext(sLecture1, screen, 0, 0, scale, scale, 0, c_white, alpha);
		        break;
			case 6:
				draw_sprite_ext(sLectureBG, 0, 0, 0, scale, scale, 0, c_white, 1);
				draw_sprite_ext(sLectureGround, 0, GW/2, GH/2, scale, scale, 0, c_white, oakalpha[0]);
				draw_sprite_ext(sLectureOak, 0, GW/2, GH/2, scale, scale, 0, c_white, oakalpha[0]);
				draw_sprite_ext(sLectureGround, 0, GW/2, GH/2, scale, scale, 0, c_white, playeralpha[0]);
				draw_sprite_ext(PlayerData.gender == Gender.Male ? sLectureBoy : sLectureGirl, 0, GW/2, GH/2, scale, scale, 0, c_white, playeralpha[0]);
				break;
			case 7:
				draw_sprite_ext(sLectureBG, 0, 0, 0, scale, scale, 0, c_white, 1);
				draw_sprite_ext(sLectureGround, 0, GW/2, GH/2, scale, scale, 0, c_white, rivalalpha[0]);
				draw_sprite_ext(sLectureRival, 0, GW/2, GH/2, scale, scale, 0, c_white, rivalalpha[0]);
				draw_sprite_ext(sLectureGround, 0, GW/2 + (GW/4), GH/2, scale, scale, 0, c_white, playeralpha[0]);
				draw_sprite_ext(PlayerData.gender == Gender.Male ? sLectureBoy : sLectureGirl, 0, GW/2 + (GW/4), GH/2, scale, scale, 0, c_white, playeralpha[0]);
				dialog.dialogAnswerX = 20;
				dialog.dialogAnswerY = 20;
				break;
		    default:
		        // code here
		        break;
		}
	}
  })
  .add("typing", {
	  enter : function() {
		  keyboard_string = "";
		  instance_deactivate_object(dialog);
	  },
	  step : function() {
		  if (string_length(keyboard_string) > 7) {
		      keyboard_string = string_copy(keyboard_string, 1, 7);
		  }
		  if (keyboard_check_pressed(vk_enter)) {
			  instance_activate_object(oDialog);
			  switch (naming) {
			      case "player":
			          PlayerData.name = keyboard_string;
					  DialogData[$ "playername"] = PlayerData.name;
				      dialog.struc[$ "playername"] = PlayerData.name;
					  dialog.text = "AfterName";
			          break;
			      case "rival":
			          PlayerData.rivalname = keyboard_string;
					  DialogData[$ "rivalname"] = PlayerData.rivalname;
				      dialog.struc[$ "rivalname"] = PlayerData.rivalname;
					  dialog.text = "AfterRivalName";
			          break;
			  }
			  screen = 7;
			  fsm.change("idle");
		  }
	  },
	  draw : function() {
		  //draw_set_font(PFS.Fonts.PokeFont[3]);
		  draw_sprite_ext(sTypingBG, -1, 0, 0, scale, scale, 0, c_white, 1);
		  string_foreach(keyboard_string, function (character, position) {
			  draw_text_transformed(270 + (position * 24), 271, character, 1, 1, 0);
			});
	  }
  });
#endregion
dbg = dbg_view("Lecture", false);
create_view_from_instance(self);