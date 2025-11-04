/// @func debug_rooms()
/// @desc Provides control over room switching and displays room history in a neat Rooms debug overlay view.
/// Call once at the start of the game.
function debug_rooms() {
	static __ = new (function() constructor {
		__rooms = asset_get_ids(asset_room);
		__names = array_map(__rooms, function(_room, _index) {
			return $"{_index}: {room_get_name(_room)}";
		});
		__n = array_length(__rooms);
		__prevrm = room;
		__rm = room;
		__size = undefined;
		__history = {
			__n: 16,
			__pool: undefined,
			__init: function() {
				dbg_section("History");
				__pool = array_create(__n, "-");
				__add(room);
				for (var _i = 0; _i < __n; _i++) {
					var _ii = _i + 1;
					var _label = (_ii < 10) ? $"0{_ii}" : _ii;
					dbg_watch(ref_create(self, "__pool", _i), _label);
				}
			},
			__add: function(_room) {
				array_insert(__pool, 0, room_get_name(_room));
				if (array_length(__pool) > __n) {
					array_pop(__pool);
				}
			},
		};
		__goto = function(_room) {
			room_goto(_room);
			__rm = _room;
			__prevrm = __rm;
			__history.__add(_room);
		};

		dbg_view("Rooms", true, 16, 35);
		dbg_section("Control");
		dbg_drop_down(ref_create(self, "__rm"), __rooms, __names, "Room");
		dbg_watch(ref_create(self, "__size"), "Size");

		dbg_button("Previous", function() {
			var _index = array_get_index(__rooms, room) - 1;
			if (_index == -1) {
				_index = __n - 1;
			}
			__goto(__rooms[_index]);
		});
		dbg_same_line();
		dbg_button("Next", function() {
			var _index = array_get_index(__rooms, room) + 1;
			if (_index == __n) {
				_index = 0;
			}
			__goto(__rooms[_index]);
		});
		dbg_same_line();
		dbg_button("Restart", function() {
			__goto(room);
		});

		dbg_button("First", function() {
			__goto(room_first);
		});
		dbg_same_line();
		dbg_button("Last", function() {
			__goto(room_last);
		});

		__history.__init();

		call_later(
			1,
			time_source_units_frames,
			function() {
				if (__prevrm != room) {
					__rm = room;
					__prevrm = __rm;
					__history.__add(room);
				}
				if (__rm != __prevrm) {
					__goto(__rm);
				}
				__size = $"{room_width}x{room_height}";
			},
			true
		);
	})();
}
