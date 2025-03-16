if (!editable) {
    exit;
}
if (mouse_in_area_gui([x, y, x + width, y + height]) and device_mouse_check_button_released(0, mb_left) and data.owner != oUI.ui and oUI.editingdepth >= depth and name != undefined and !mouse_in_area_gui(editor_area) and !mouse_in_area_gui(editor_area2)) {
	oUI.load_info();
	oUI.editingdepth = 999999;
	//oUI.last_edit = oUI.editing;
}

#region delete
if (oUI.editing != undefined and name == oUI.editing) {
	var ele = flexpanel_node_get_child(oEditableUI.ui.root, oUI.editing);
	var parent = undefined;
	if (ele != undefined) {
		parent = flexpanel_node_get_parent(ele);
	}
	//show_debug_message($"{global.edit_node} - {parent} : {ele}");
	if (keyboard_check_released(vk_delete) and parent != undefined and ele != undefined and mouse_in_area_gui([x, y, x + width, y + height]) and deltimer == 0) {
		deltimer = 60;
		flexpanel_node_remove_child(parent, ele);
		ele = undefined;
		with (oUIElement) {
		    if (data.owner == oEditableUI.ui) {
			    instance_destroy();
			}
		}
		oEditableUI.ui.recalculate();
	}
	var move_offset = - keyboard_check_released(vk_pageup) - oUI.up + keyboard_check_released(vk_pagedown) + oUI.down;
	//show_debug_message(move_offset);
	//show_debug_message($"{oUI.up}:{oUI.down}");
	//if ((keyboard_check_released(vk_pagedown) or keyboard_check_released(vk_pageup) or oUI.down or oUI.up) and parent != undefined and ele != undefined and deltimer == 0) {
	if ((keyboard_check_released(vk_pagedown) or keyboard_check_released(vk_pageup) or oUI.down or oUI.up) and parent != undefined and ele != undefined and mouse_in_area_gui([x, y, x + width, y + height]) and deltimer == 0) {
		//show_message(flexpanel_node_get_parent(flexpanel_node_get_parent(ele)));
		deltimer = 60;
		var str = flexpanel_node_get_struct(parent);
		var pos;
		for (var i = 0; i < array_length(str.nodes); ++i) {
		    if (str.nodes[i].name == oUI.editing) {
			    pos = i;
			}
		}
		var change = str.nodes[pos];
		if ((move_offset == 1 and pos < array_length(str.nodes) - 1) or (move_offset == -1 and pos > 0)) {
		    str.nodes[pos] = str.nodes[pos + move_offset];
		    str.nodes[pos + move_offset] = change;
		}
		//change parent to new structure
		var parent_parent = flexpanel_node_get_parent(flexpanel_node_get_child(oEditableUI.ui.root, flexpanel_node_get_name(parent)));
		if (parent_parent != undefined) {
		    var parent_str = flexpanel_node_get_struct(parent_parent);
			var parent_pos;
			for (var i = 0; i < array_length(parent_str.nodes); ++i) {
			    if (parent_str.nodes[i].name == flexpanel_node_get_name(parent)) {
				    parent_pos = i;
				}
			}
			flexpanel_node_remove_child(parent_parent, parent);
			flexpanel_node_insert_child(parent_parent, flexpanel_create_node(str), parent_pos);
		}		
		oEditableUI.ui.recalculate();
	}
}

#endregion