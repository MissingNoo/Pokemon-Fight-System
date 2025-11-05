//feather ignore all
if (!editable) {
	exit;
}
if (
	mouse_in_area_gui([x, y, x + width, y + height])
	&& device_mouse_check_button_released(0, mb_left)
	&& data.owner != oUI.ui
	&& oUI.editingdepth >= depth
	&& name != undefined
	&& !mouse_in_area_gui(editor_area)
	&& !mouse_in_area_gui(editor_area2)
	&& !instance_exists(oTagManager)
	&& !instance_exists(oTextManager)
) {
	oUI.load_info();
	oUI.editingdepth = 999999;
	global.elementselected = noone;
	global.currenttextbox = noone;
	AirLib.listframe = AirLib.frame + 10;
	//oUI.last_edit = oUI.editing;
}

#region delete
if (oUI.editing != undefined && name == oUI.editing) {
	var ele = flexpanel_node_get_child(oEditableUI.ui.root, oUI.editing);
	var parent = undefined;
	if (ele != undefined) {
		parent = flexpanel_node_get_parent(ele);
	}
	//show_debug_message($"{global.edit_node} - {parent} : {ele}");
	if (
		keyboard_check_released(vk_delete)
		&& parent != undefined
		&& ele != undefined
		&& mouse_in_area_gui([x, y, x + width, y + height])
		&& deltimer == 0
	) {
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
	var move_offset =
		-keyboard_check_released(vk_pageup)
		- oUI.up
		+ keyboard_check_released(vk_pagedown)
		+ oUI.down;
	//show_debug_message(move_offset);
	//show_debug_message($"{oUI.up}:{oUI.down}");
	//if ((keyboard_check_released(vk_pagedown) or keyboard_check_released(vk_pageup) or oUI.down or oUI.up) and parent != undefined and ele != undefined and deltimer == 0) {
	if (
		(
			keyboard_check_released(vk_pagedown)
				|| keyboard_check_released(vk_pageup)
				|| oUI.down
				|| oUI.up
		)
		&& parent != undefined
		&& ele != undefined
		&& mouse_in_area_gui([x, y, x + width, y + height])
		&& deltimer == 0
	) {
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
		if (
			(move_offset == 1 && pos < array_length(str.nodes) - 1)
			|| (move_offset == -1 && pos > 0)
		) {
			str.nodes[pos] = str.nodes[pos + move_offset];
			str.nodes[pos + move_offset] = change;
		}
		//change parent to new structure
		var parent_parent = flexpanel_node_get_parent(
			flexpanel_node_get_child(oEditableUI.ui.root, flexpanel_node_get_name(parent))
		);
		if (parent_parent != undefined) {
			var parent_str = flexpanel_node_get_struct(parent_parent);
			var parent_pos;
			for (var i = 0; i < array_length(parent_str.nodes); ++i) {
				if (parent_str.nodes[i].name == flexpanel_node_get_name(parent)) {
					parent_pos = i;
				}
			}
			flexpanel_node_remove_child(parent_parent, parent);
			flexpanel_node_insert_child(
				parent_parent,
				flexpanel_create_node(str),
				parent_pos
			);
		}
		oEditableUI.ui.recalculate();
	}
}

#endregion
