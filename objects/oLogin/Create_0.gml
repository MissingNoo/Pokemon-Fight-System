global.username = "";
global.password = "";
//show_debug_overlay(true);
n_root = flexpanel_create_node(
{
    "name" : "root",
    "left" : room_width / 2 - (250 / 2),
    "top": room_height / 2 - (200 / 2),
    "position" : "absolute",
    "width" : 250,
    "height" : 200,
    "padding" : 10,
    "nodes" : [
        {  
            "flex": 1,
            "rowGap" : 10,
            "nodes" : [
                { "name" : "center_label", "height":20, "data" : { "text" : "Login" }},
                {
                    "name" : "textbox_username", 
                    "marginInline" : 30, 
                    "flex" : 1,
                    "data" : {
                        "f" : function() {
                            global.username = global.currenttextbox[$ "text"];
                        }
                    }
                },
                {
                    "name" : "textbox_password", 
                    "marginInline" : 30, 
                    "flex" : 1,
                    "data" : {
                        "f" : function() {
                            global.password = global.currenttextbox[$ "text"];
                        }
                    }
                },
                {
                    "flex" : 1,
                    "flexDirection" : "row",
                    "nodes" : [
                        {
                            "name" : "button_accept", 
                            "height" : 30, 
                            "marginInline" : 10, 
                            "flex" : 1,
                            "data" : {
                                "f" : function() {
                                    new packet(Contype.Login)
                                    .write(buffer_text, global.username)
                                    .write(buffer_text, global.password)
                                    .send();
                                },
                                "text" : "Accept"
                            },
                        },
                        {
                        "name" : "button_register", 
                            "height" : 30, 
                            "marginInline" : 10, 
                            "flex" : 1,
                            "data" : {
                                "f" : function() {
                                    new packet(Contype.Login)
                                    .write(buffer_text, global.username)
                                    .write(buffer_text, global.password)
                                    .send();
                                },
                                "text" : "Register"
                            }
                        }
                    ],
                },
                {}
            ]
        }
    ]
}
);
target_w = room_width;
target_h = room_height;
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
			height: _pos.height,
            data: _data
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
        _inst.data = _data;
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