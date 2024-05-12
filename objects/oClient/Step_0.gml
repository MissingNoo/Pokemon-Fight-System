if (room == rInit and keyboard_check_pressed(ord("Z"))) {
    global.playerName = characters[0];
	send_data({type : Contype.SelectCharacter, name : characters[0]});
	room_goto(rConfig);
}