x = oPlayer.x;
y = oPlayer.y;
if (keyboard_check_pressed(vk_enter)) {
	var data = json_stringify({
		type : Contype.Ping,
		uid : uid,
		name : global.playerName,
		room : room_get_name(room),
		x : x,
		y : y
	});
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_text, data);
	network_send_raw(socket, buffer, buffer_get_size(buffer));
}