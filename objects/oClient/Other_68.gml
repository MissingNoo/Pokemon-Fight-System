if (async_load[? "type"] == network_type_data) {
	var buffer = buffer_read(async_load[? "buffer"], buffer_string);
	var json = json_parse(buffer);
	var return_type = json.type;
	var data = json_parse(json.message);
	var oouid, player;
	switch (return_type) {
		case "uuid":
			AirNet.connection.set_uuid(data.uuid);
			AirNet.username = undefined;
			AirNet.loggedin = false;
			if (AirNetUseColisionServer && data.rmanager) {
				room_goto(rColTest);
			}
			break;

		case "pong":
			var time = get_timer();
			AirNet.connection.ping = round(
				((time - AirNet.connection.pingtime) / 1000000) * 100
			);
			AirNet.connection.lastpong = get_timer();
			break;

		case "joinedRoom":
			AirNet.connection.current_room = data.roomName;
			instance_destroy(oJoin);
			instance_destroy(oCreate);
			instance_create_depth(0, 0, -5000, oChat);
			break;

		case "playersInRoom":
			AirNet.players_in_room = data.players;
			array_foreach(AirNet.players_in_room, function(e, i) {
				var exists = false;
				with (oOtherPlayer) {
					if (!exists) {
						exists = self.player.uuid == e.uuid;
					}
				}
				if (!exists && e.uuid != AirNet.connection.uuid) {
					instance_create_depth(e.x, e.y, 0, oOtherPlayer, {player: e});
					array_push(
						oChat.chat,
						{player: "[[Server]", message: $"{e.name} Joined the game!"}
					);
				}
			});
			break;

		case "playerMoved":
			var ouuid = data.uuid;
			global.search = ouuid;
			player = array_find_index(AirNet.players_in_room, function(e, i) {
				return e.uuid == global.search;
			});
			if (player != -1) {
				AirNet.players_in_room[player].x = data.x;
				AirNet.players_in_room[player].y = data.y;
			} else {
				array_push(
					AirNet.players_in_room,
					{uuid: data.uuid, x: data.x, y: data.y}
				);
			}
			break;

		case "playerLeft":
			var ouuid = data.uuid;
			var player = array_find_index(AirNet.players_in_room, function(e, i) {
				return e.uuid == global.search;
			});
			if (player != -1) {
				array_delete(AirNet.players_in_room, player, 1);
			}
			with (oOtherPlayer) {
				if (uuid == ouuid) {
					array_push(
						oChat.chat,
						{
							player: "[[Server]",
							message: $"{self.player.name} Left the game!",
						}
					);
					instance_destroy();
				}
			}
			break;

		case "roomCreated":
			room_code = data.roomCode;
			AirNet.host = true;
			new packet("joinRoom").write("roomName", data.roomName).send()
			break;

		case "roomList":
			oJoin.room_list = data.roomList;
			break;

		case "login":
			AirNet.username = data.username;
			AirNet.loggedin = true;
			instance_destroy(oLogin);
			new packet("getFriendList").send()
			break;

		case "chatMessage":
			array_push(oChat.chat, {player: data.player, message: data.message});
			break;

		case "addFriend":
			instance_create_depth(0, 0, -5000, oFriendRequest, {player: data.from});
			break;

		case "friendlist":
			AirNet.friendlist = data.friends;
			break;

		default:
			// code here
			break;
	}
}
