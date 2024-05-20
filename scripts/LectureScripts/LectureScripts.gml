function lecture_startup(){
	scribble_typists_add_event("showoptions", function(){showOptions = true;});
	scribble_typists_add_event("lectureNextScreen", function(){oLecture.screen++});
	scribble_typists_add_event("oakalpha", function(_element, _parameter_array, _character_index){ oLecture.oakalpha[1] = real(_parameter_array[0]) });
	scribble_typists_add_event("playeralpha", function(_element, _parameter_array, _character_index){ oLecture.playeralpha[1] = real(_parameter_array[0]) });
	scribble_typists_add_event("rivalalpha", function(_element, _parameter_array, _character_index){ oLecture.rivalalpha[1] = real(_parameter_array[0]) });
	scribble_typists_add_event("lecturestate", function(_element, _parameter_array, _character_index){ oLecture.fsm.change(_parameter_array[0]) });
	scribble_typists_add_event("gohome", function() {
		global.blackfade[0] = 1;
		ini_open("Game.ini");
		ini_write_real("Game", "SeenLecture", true);
		ini_close();
		room_goto(rPlayerHouse2f);
	});
}