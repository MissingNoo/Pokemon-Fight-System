global.online = true;
#macro ONLINE global.online

enum Contype {
	Join,
	Update,
	ChangeRoom,
	Ping,
	Disconnect,
	Null
}