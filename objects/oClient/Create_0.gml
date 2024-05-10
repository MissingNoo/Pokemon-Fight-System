x = oPlayer.x;
y = oPlayer.y;
socket = network_create_socket(network_socket_tcp);
connected = network_connect_raw(socket, "127.0.0.1", 21337);
buffer = buffer_create(16, buffer_grow, 2);
function sendData(json){
	var data = json_stringify(json);
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_text, data);
network_send_raw(socket, buffer, buffer_get_size(buffer));
}

sendData({
	type : Contype.Join,
	name : global.playerName,
	room : room_get_name(room),
	x : x,
	y : y
});