randomize();
down = false;
up = false;
edit_node = undefined;
node = undefined;
creating = false;
str = {
	//{ 
		name : "base",
		width : display_get_gui_width(),
		height : display_get_gui_height(),
		nodes : [
			{
				  "name":"panel_base",
				  "left" :300,
				  "top" :150,
				  "padding":0.0,
				  "width":400.0,
				  "data":{
				    image : sButton,
				  },
				  "height":300.0,
			},
			{
				  "name":"panel_base2",
				  "left" :800,
				  "top" :150,
				  "padding":0.0,
				  "width":400.0,
				  "data":{
				    image : sButton,
				  },
				  "height":300.0,
			}
		]
	//}
}
global.player_info_ui.left = 300;
global.player_info_ui.top = 150;
//ui = new window(global.player_info_ui);
ui = new window(str);

new_window = function() {
	ui.dispose();
	ui = new window(str);
	ui.edit_mode();
}

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
}

save = function(name = "test") {
	var f = file_text_open_write(name);
	var str = variable_clone(flexpanel_node_get_struct(ui.root));
	clearstr(str);
	file_text_write_string(f, json_stringify(str, true));
	file_text_close(f);
}

load = function() {
	ui.dispose();
	ui = new window(json_parse(buffer_read(buffer_load("test"), buffer_text)));
	ui.edit_mode();
}

