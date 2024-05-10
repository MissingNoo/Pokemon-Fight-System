/// @description Change Room
var data = json_stringify({
	type : Contype.ChangeRoom,
	room : room_get_name(room)
});
buffer_seek(oClient.buffer, buffer_seek_start, 0);
buffer_write(oClient.buffer, buffer_text, data);
network_send_raw(oClient.socket, oClient.buffer, buffer_get_size(oClient.buffer));