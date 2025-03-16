/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_released(vk_insert)) {
	ui.edit_mode(true);
}
if (keyboard_check_released(vk_f6)) {
	ui.dispose();
	ui.recalculate();
}

switch (node) {
    case "panel":
        node = flexpanel_create_node({padding : 10, width : 60, height : 60, name : $"panel_{irandom(99999)}" });
        break;
    case "button":
        node = flexpanel_create_node({ width : 60, height : 60, name : $"button_{irandom(99999)}"});
        break;
    case "textbox":
        node = flexpanel_create_node({flex : 1, name : $"textbox_{irandom(99999)}"});
        break;
    case "label":
        node = flexpanel_create_node({flex : 1, name : $"label_{irandom(99999)}"});
        break;
    //case "panel":
    //    node = flexpanel_create_node({padding : 10, flexDirection : "row", flex : 1, name : $"panel_{irandom(99999)}" });
    //    break;
	default:
		node = undefined;
		break;
}

//if (keyboard_check_released(vk_numpad5)) {
//	creating = true;
//	node = flexpanel_create_node({padding : 10, height : 10, flex : 1, name : $"draggable_label_{irandom(99999)}" });
//}

if (global.edit_node != undefined and node != undefined and !is_string(node)) {
	//creating = false;
	var panel = flexpanel_node_get_child(ui.root, global.edit_node);
	//show_message($"{edit_node} : {panel}");
    if (panel == undefined) {
    	exit;
    }
	flexpanel_node_insert_child(panel, node, 0);
    ui.recalculate();
	node = undefined;
}
if (keyboard_check_released(vk_home)) {
    //save();
	//global.cur_struct = str;
	//global.clear = function(name, value) {
	//	var cur = global.cur_struct
	//	if (is_struct(value)) {
	//		global.cur_struct = value;
	//	    struct_foreach(value, global.clear);
	//	}
	//	global.cur_struct = cur;
	//	if (name == "instances") {
	//	    global.cur_struct.instances = [];
	//	}
	//	if (name == "inst") {
	//	    struct_remove(global.cur_struct, "inst");
	//	}
	//	if (name == "owner") {
	//	    global.cur_struct.owner = noone;
	//	}
	//}
	//struct_foreach(str, global.clear);
}
if (keyboard_check_released(vk_end)) {
	//load();
}

