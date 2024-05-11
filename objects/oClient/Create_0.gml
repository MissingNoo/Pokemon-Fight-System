characters = [];
socket = network_create_socket(network_socket_tcp);
connected = network_connect_raw(socket, "127.0.0.1", 21337);
buffer = buffer_create(16, buffer_grow, 2);
send_data({type : Contype.Login, username : "airgeadlamh", password : "123"});