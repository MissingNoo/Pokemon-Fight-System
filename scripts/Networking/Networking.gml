global.online = os_get_config() == "Online" or os_get_config() == "Online-Debug";
#macro ONLINE global.online

enum Contype {
	Join,
	Update,
	ChangeRoom,
	Ping,
	Disconnect,
	Login,
	GetCharacters,
	SelectCharacter,	
	Null
}

function send_data(json){
	if (!ONLINE) { exit; }
	var data = json_stringify(json);
	buffer_seek(oClient.buffer, buffer_seek_start, 0);
	buffer_write(oClient.buffer, buffer_text, data);
	network_send_raw(oClient.socket, oClient.buffer, buffer_get_size(oClient.buffer));
}