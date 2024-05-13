lecture_startup();
naming = "player";
dialog = noone;
screen = 0;
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
if (ini_read_real("Game", "SeenLecture", false)) {
    //room_goto(rPlayerHouse2f);
}
ini_close();
#region State Machine
fsm = new SnowState("idle");
fsm.add("idle", {
	enter : function() {
		instance_activate_object(oDialog);
	},
	step: function() {
		if (keyboard_check_pressed(ord("Z")) and !lerping and !blacklerping) {
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
					[
						[
							["BOY", "Selected", true, function(){PlayerData.gender = Gender.Male}],
							["GIRL", "Selected", true, function(){PlayerData.gender = Gender.Female}],
						],
						[
							["Yes", "RivalIntro", false],
							["No", "Selected", true, function() { oLecture.screen = 6; oLecture.fsm.change("typing"); naming = "player"; }],
						],	
						[
							["NEWNAME", "AfterRivalName", true, function() { oLecture.fsm.change("typing"); naming = "rival"; }],
							["GREEN", "AfterRivalName", true, function() { PlayerData.rivalname = "GREEN"; dialog.struc[$ "rivalname"] = PlayerData.rivalname; }],
							["GARY", "AfterRivalName", true, function() { PlayerData.rivalname = "GARY"; dialog.struc[$ "rivalname"] = PlayerData.rivalname; }],
						],
					]
					if (dialog == noone) {
					    dialog = instance_create_depth(x, y, depth - 1, oDialog, {npc : npc, text : text, options : options, optionsFalas : optionsFalas});
					}
				}
				screen++;
				blacklerping = true;
				blacklerp = 0;
			}
		}
		oakalpha[0] = lerp(oakalpha[0], oakalpha[1], 0.1);
		playeralpha[0] = lerp(playeralpha[0], playeralpha[1], 0.1);
		rivalalpha[0] = lerp(rivalalpha[0], rivalalpha[1], 0.1);
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
		  instance_deactivate_object(oDialog);
		  keyboard_string = "Airgead";
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
				      dialog.struc[$ "playername"] = PlayerData.name;
					  dialog.text = "AfterName";
			          break;
			      case "rival":
			          PlayerData.rivalname = keyboard_string;
				      dialog.struc[$ "rivalname"] = PlayerData.rivalname;
					  dialog.text = "AfterRivalName";
			          break;
			  }
			  screen = 7;
			  fsm.change("idle");
		  }
	  },
	  draw : function() {
		  draw_sprite_ext(sTypingBG, -1, 0, 0, scale, scale, 0, c_white, 1);
		  string_foreach(keyboard_string, function (character, position) {
			  draw_set_color(c_black);
			  draw_text_transformed(270 + (position * 24), 265, character, 2, 2, 0);
			  draw_set_color(c_white);
			});
	  }
  });
#endregion