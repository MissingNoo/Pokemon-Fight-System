//scribble_font_set_default("Font3");
offset = -1000; //new lerper(-1000);
tween(self, "offset", -10);
//offset.lerp_to(10);
infosurf = undefined;
count = 0;
lastroom = "test";
AirNet[$ "connection"] ??= new connection(AirNet.ip, AirNet.port, network_socket_udp);
AirNet.connection.connect();
AirNet.host = false;
AirNet.players_in_room = [];
if (!ONLINE) {
	room_goto(rConfig);
    instance_destroy();
} else {
	instance_create_depth(x, y, depth + 1, oLogin);
}
mx = mouse_x;
my = mouse_y;
room_code = undefined;
dbglog = false;
depth = 1000;
