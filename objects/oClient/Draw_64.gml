if (instance_exists(oUIElement)) {
	exit;
}
var dbg = $"UUID: {AirNet.connection.uuid} \nUsername: {
	AirNet.username ?? "Logged out"
} \nPing: {AirNet.connection.ping} \nRoom: {AirNet.connection.current_room} \nPlayers: {
	array_length(AirNet.players_in_room)
} \nFriends: {AirNet.friendlist}";
infosurf = surface_recreate(infosurf, string_width(dbg) + 5, string_height(dbg) + 7);
surface_set_target(infosurf);
draw_set_color(c_black);
draw_set_alpha(0.75);
draw_rectangle(0, 0, surface_get_width(infosurf), surface_get_height(infosurf), false);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text(5, 5, dbg);
draw_rectangle(
	0,
	0,
	surface_get_width(infosurf) - 2,
	surface_get_height(infosurf) - 2,
	true
);
surface_reset_target();
draw_surface(
	infosurf,
	gui_x_percent(100) - surface_get_width(infosurf) - 10,
	gui_y_percent(100) - offset
);
if (!is_undefined(room_code)) {
	scribble($"[fa_bottom][fa_center]Room Code: {room_code}").draw(
		gui_x_percent(50),
		gui_y_percent(98)
	);
}
