randomize();
__AirLibLoadTemplates();
copy = {};
copymode = "node";
down = false;
up = false;
edit_node = undefined;
node = undefined;
creating = false;
template = AirLib.templates.grid_template;
//template = clear_template;
ui = new window(template, true);
ui.edit_mode();

new_window = function() {
	ui.dispose();
	ui = new window(template, true);
	ui.edit_mode();
};

clearstr = function(struct) {
	var names = struct_get_names(struct);
	if (array_contains(names, "instances")) {
		struct_remove(struct, "instances");
	}
	if (struct_exists(struct.data, "owner")) {
		struct_remove(struct.data, "owner");
	}
	if (struct_exists(struct.data, "inst")) {
		struct_remove(struct.data, "inst");
	}
	if (array_contains(names, "nodes")) {
		array_foreach(struct.nodes, function(e, i) {
			clearstr(e);
		});
	}
};

save = function(name = "test") {
	var f = file_text_open_write(name);
	var str = variable_clone(flexpanel_node_get_struct(ui.root));
	clearstr(str);
	file_text_write_string(f, json_stringify(str, true));
	file_text_close(f);
};

load = function() {
	ui.dispose();
	ui = new window(
		json_parse(
			buffer_read(
				buffer_load(global.filename),
				buffer_text
			)
		),
		true
	);
	ui.edit_mode(true);
};

depth = depth + 1;
