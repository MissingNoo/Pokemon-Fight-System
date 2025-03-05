#region Lexicon
lexicon_index_declare_from_json("ptbr.json");
lexicon_index_declare_from_json("en.json");
lexicon_language_set("en");
#endregion

ping = 0;
ping_step = 0;
ping_timeout = 60 * 3;

if (!ONLINE) {
	room_goto(rConfig);
    instance_destroy();
}
characters = [];
socket = network_create_socket(network_socket_tcp);
connected = network_connect_raw(socket, "192.168.0.105", 10103);
buffer = buffer_create(16, buffer_grow, 2);
new packet(Contype.Ping)
.send();
alarm[0] = -1;
alarm[1] = 60 * 1;
//new packet(Contype.Login).write(buffer_text, "test").send();