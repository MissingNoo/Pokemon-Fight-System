copy_style = function (ele) {
	oEditableUI.copy = flexpanel_node_get_struct(ele);
	oEditableUI.copymode = "style";
}

copy = function (parent, ele, cut = false) {
	if (is_undefined(ele)) {
		return;
	}
	deltimer = 60;
	oEditableUI.copy = flexpanel_node_get_struct(ele);
	oEditableUI.copymode = "node";
	if (cut) {
		delete_el(ele);
	}
}

delete_el = function (ele) {
	var parent = flexpanel_node_get_parent(global.__air.last_ele);
	flexpanel_node_remove_child(parent, ele);
	with (oUIElement) {
		if (data.owner == oEditableUI.ui) {
			instance_destroy();
		}
	}
	oEditableUI.ui.recalculate();
}

paste = function () {
	deltimer = 60;
	var ele = flexpanel_node_get_child(oEditableUI.ui.root, flexpanel_node_get_name(global.__air.last_ele));
	if (oEditableUI.copymode == "node") {
		var ndata = variable_clone(oEditableUI.copy);
		if (flexpanel_node_get_child(ele, oEditableUI.copy.name) != undefined) {
			 ndata.name = ndata.name + "_1";
		}
		var paste_node = flexpanel_create_node(ndata);
		flexpanel_node_insert_child(ele, paste_node, flexpanel_node_get_num_children(ele));
		with (oUIElement) {
			if (data.owner == oEditableUI.ui) {
				instance_destroy();
			}
		}
		oEditableUI.ui.recalculate();
	}
	if (oEditableUI.copymode == "style") {
		var style = variable_clone(oEditableUI.copy);
		variable_struct_remove(style, "nodes");
		variable_struct_remove(style, "name");
		variable_struct_remove(style, "data");
		var names = struct_get_names(style);
		var p = flexpanel_node_get_struct(global.__air.last_ele);
		for (var i = 0; i < array_length(names); i++) {
			p[$names[i]] = style[$names[i]];
		}
		var parent = flexpanel_node_get_parent(global.__air.last_ele);
		delete_el(global.__air.last_ele);
		flexpanel_node_insert_child(parent, flexpanel_create_node(p), 0);
		oEditableUI.ui.recalculate();
	}
}