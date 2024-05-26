#region Lexicon
lexicon_index_declare_from_json("ptbr.json");
lexicon_index_declare_from_json("en.json");
lexicon_language_set("en");
#endregion
if (!ONLINE) {
	room_goto(rConfig);
    instance_destroy();
}
characters = [];
socket = network_create_socket(network_socket_tcp);
//connected = network_connect_raw(socket, "140.238.187.191", 21337);
//connected = network_connect_raw(socket, "127.0.0.1", 21337);
connected = network_connect_raw(socket, "192.168.0.107", 21337);
buffer = buffer_create(16, buffer_grow, 2);
send_data({type : Contype.Login, username : "airgeadlamh", password : "123"});