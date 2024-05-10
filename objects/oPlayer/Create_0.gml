//event_inherited();
//show_message_async(connected);
cansend = true;
if (!instance_exists(oDepthManager)) {
	instance_create_depth(x, y, depth, oDepthManager);
}
if (ONLINE and !instance_exists(oClient)) {
    instance_create_depth(x, y, depth, oClient);
}
if (instance_number(oPlayer) > 1) { instance_destroy(); }
visible = false;
canmove = true;
display_set_gui_size(720*1.5, 480*1.5);
//window_center();
moving = false;
placeToGo = [x, y];
image_speed = 0;
image_index = 1;
PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);
PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[4]);
PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[7]);
function sendPos(){
	var data = json_stringify({
		type : Contype.Update,
		room : room_get_name(room),
		x : placeToGo[0],
		y : placeToGo[1]
		});
	buffer_seek(oClient.buffer, buffer_seek_start, 0);
	buffer_write(oClient.buffer, buffer_text, data);
	network_send_raw(oClient.socket, oClient.buffer, buffer_get_size(oClient.buffer));
}
room_goto(room);