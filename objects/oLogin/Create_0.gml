n_root = flexpanel_create_node(
{
    "width" : 250,
    "height" : 200,
    "padding" : 10,
    "nodes" : [
        {  
            "name" : "root",
            "flex": 1,
            "rowGap" : 10,
            "nodes" : [
                {"name" : "title", "height":20},
                {"name" : "username", "marginInline" : 30, "flex" : 1},
                {"name" : "password", "marginInline" : 30, "flex" : 1},
                {"name" : "accept", "height" : 10, "marginInline" : 30, "flex" : 1},
            ]
        }
    ]
}
);
target_w = room_width;
target_h = room_height;
// Shared element properties
ui_padding = 10; // ‘ui_’ prefix as it’s for the root canvas only
gap = 5;
padding = 5;
flexpanel_calculate_layout(n_root, target_w, target_h, flexpanel_direction.LTR);
////// Generate object instances
generate_instance = function(_node, _depth)
{
	// Get layout data
	var _pos = flexpanel_node_layout_get_position(_node, false);
	var _name = flexpanel_node_get_name(_node);
	
	// Update instance
	var _data = flexpanel_node_get_data(_node);
	if (!struct_exists(_data, "inst"))
	{
		// Create instance
		var _inst = instance_create_depth(_pos.left, _pos.top, _depth, oUIElement,
		{
			name: _name,
			width: _pos.width,
			height: _pos.height
		});
	
		_data.inst = _inst;
	}
	else
	{
		var _inst = _data.inst;
		_inst.x = _pos.left;
		_inst.y = _pos.top;
		_inst.width = _pos.width;
		_inst.height = _pos.height;
	}
	
	// Call for children (recursive)
	var _children_count = flexpanel_node_get_num_children(_node);
	for (var i = 0; i < _children_count; i++)
	{
		var _child = flexpanel_node_get_child(_node, i);
		generate_instance(_child, _depth - 1);
	}
}

generate_instance(n_root, 0);