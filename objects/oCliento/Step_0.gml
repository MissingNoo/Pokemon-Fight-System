if (room == rInit and input_check_pressed("accept")) {
    global.playerName = characters[0];
	//send_data({type : Contype.SelectCharacter, name : characters[0]});
	room_goto(rConfig);
}