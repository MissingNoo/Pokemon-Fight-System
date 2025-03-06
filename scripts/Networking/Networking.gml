global.online = os_get_config() == "Online" or os_get_config() == "Online-Debug";
#macro ONLINE global.online

enum Contype {
	Join,
	Update,
	ChangeRoom,
	Ping,
	ServerPing,
	Disconnect,
	Login,
	GetCharacters,
	SelectCharacter,
    Register,
	Null
}

function packet(type) constructor {
    buffer = buffer_create(16, buffer_grow, 2)
    buffer_seek(oClient.buffer, buffer_seek_start, 2);
    buffer_write(buffer, buffer_u8, type);
    
    static write = function(const, data) {
        buffer_write(buffer, const, data);
        return self;
    }
    
    static send = function() {
        if (!ONLINE) { exit; } 
        network_send_raw(oClient.socket, buffer, buffer_get_size(buffer));
        buffer_delete(buffer);
        show_debug_message("Sending Packet!");
    } 
}