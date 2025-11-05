array_foreach(AirNet.players_in_room, function(e, i) {
	var exists = false;
	with (oOtherPlayer) {
		if (!exists) {
			exists = self.player.uuid == e.uuid;
		}
	}
	if (!exists && e.uuid != AirNet.connection.uuid) {
		instance_create_depth(e.x, e.y, 0, oOtherPlayer, {player: e});
	}
});
