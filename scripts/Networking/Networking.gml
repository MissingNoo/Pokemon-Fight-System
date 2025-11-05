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