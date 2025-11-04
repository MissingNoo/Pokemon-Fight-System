ui = new window(global.game_uis.main_menu);
ui.fit_to_gui();
options = ["singleplayer", "create", "join", "settings", "quit"];
option_data = {};
selected_size = 50;
unselected_size = 30;
min_size = 35;
base_offset = 7;
for (var i = 0; i < array_length(options); i += 1) {
	option_data[$ options[i]] = {height: 30, __y: 0, btn: new button(options[i])};
}

option_data
	.create
	.btn
	.set_function(function() {
		instance_create_depth(x, y, depth, oCreate);
		instance_deactivate_object(self);
	});

option_data
	.join
	.btn
	.set_function(function() {
		instance_create_depth(x, y, depth, oJoin);
		instance_deactivate_object(self);
	});

option_data[$ "quit"]
	.btn
	.set_function(function() {
		game_end();
	});

maxyy = 0;

dbg = dbg_view("Main Menu", false, 10, 10);
create_view_from_instance(self);

ui.add_draw("menu_options", method(self, function(name, pos, data) {
	var _x = pos.left, _y = pos.top, _w = pos.width, _h = pos.height;
	var y_offset = base_offset;
	var base_height = _h / array_length(options);
	var offset = base_offset;
	for (var names = options, i = 0; i < array_length(names); i += 1) {
		var opt = option_data[$ names[i]];
		var area;
		var yy = _y;
		if (i == 0) {
			area = [_x, yy, _x + _w, _y + opt.height];
			//draw_rectangle(_x, yy, _x + _w, yy + opt.height, true);
		} else {
			var lastopt = option_data[$ names[i - 1]];
			yy = _y + lastopt.height + y_offset;
			area = [_x, yy, _x + _w, yy + opt.height];
			//draw_rectangle(_x, yy, _x + _w, yy + opt.height, true);
			y_offset += lastopt.height + offset;
		}
		opt.btn.position(area[0], area[1], area[2], area[3]);
		opt.btn.set_selected_area(area[0], area[1], area[2], area[3]);
		//draw_text(_x - 90, yy, $"{opt.height}:{names[i]}:{global[$ "__opt"] ?? "" == names[i]}:{global.__mouse_over}");
		if (mouse_in_area_gui(area)) {
			global.__mouse_over = i;
			global.__opt = names[i];
			struct_foreach(option_data, function(n, e) {
				if (global.__opt != n) {
					e.height = lerp(e.height, unselected_size, 0.1);
				}
			});
			opt.height = lerp(opt.height, selected_size, 0.1);
		}
		if (!mouse_in_area_gui([_x, _y, _x + _w, maxyy])) {
			struct_foreach(option_data, function(n, e) {
				e.height = lerp(e.height, min_size, 0.05);
			});
		}
		if (yy + opt.height > maxyy) {
			maxyy = yy + opt.height;
		}
		opt.btn.draw();
	}
	draw_rectangle(_x, _y, _x + _w, maxyy, true);
}));
ui.finish();
