x = -1000;
y = -1000;
load = function(r) {
	RoomLoader.DataInit(r);
	RoomLoader.Load(r, 0, 0);
	var n = room_get_name(r);
	with (all) {
		if (!self.persistent) {
			if (object_index == asset_get_index("oCol")) {
				self[$ "rid"] ??= n;
			} else {
				instance_destroy();
			}
		}
	}
};
load(R2);
load(R3);
