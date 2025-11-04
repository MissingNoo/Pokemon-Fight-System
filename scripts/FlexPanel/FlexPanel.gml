//feather ignore all
#macro AirUIDefaultSpr var spr = (data[$ "image"] != undefined and data[$ "image"] != "") ? asset_get_index(data.image) : undefined; spr = (spr != undefined and spr != -1) ? spr : sBlank
#macro AirUIArea var _x = pos.left, _y = pos.top, _w = pos.width, _h = pos.height, area = [_x, _y, _x + _w, _y + _h]
#macro AirUIFunctionStart method(self, function(name, pos, data) { var _x = pos.left, _y = pos.top, _w = pos.width, _h = pos.height, area = [_x, _y, _x + _w, _y + _h] if (!is_undefined(data[$ "tags"])) { flexpanel_draw_tags(name, pos, data) }
#macro AirUIFunctionEnd })
global.edit_mode = false;
global.edit_node = undefined;
global.edit_node_owner = undefined;

function flexpanel_draw_tags(name, pos, data) {
	if (!is_undefined(data[$ "tags"])) {
		var tags = data.tags;
		for (var i = 0; i < array_length(tags); i++) {
			var tag = tags[i];
			draw_bg_fg(pos, {type: undefined, tags});
		}
	}
	if (!is_undefined(data[$ "text"])) {
		var text = data.text;
		scribble(text).draw(pos.left, pos.top + pos.height / 2);
	}
	
}

function draw_bg_fg(pos = {}, element = {type: undefined, tags: []}) {
	var spr = sBlank;
	var color = c_white;
	var check = "on_area";
	switch (element.type) {
		case "button":
			spr = AirLibDefaultButtonSprite;
			color = AirLibButtonBG;
			break;
		case "textbox":
			spr = AirLibDefaultTextBoxSprite;
			color = AirLibInputBG;
			break;
		case "checkbox":
						spr = AirLibDefaultCheckboxSprite;
		check = "checked";
			if (!element.checked) {
				color = AirLibCheckboxBG;
			} else {
				color = AirLibCheckboxBGC;
			}
			
			break;
		case "listbox":
			spr = AirLibDefaultListSprite;
			color = AirLibListBG;
			break;
		default:
			if (array_contains(element.tags, "button")) {
				spr = AirLibDefaultButtonSprite;
				color = AirLibButtonBG;
			}
			if (array_contains(element.tags, "input")) {
				spr = AirLibDefaultTextBoxSprite;
				color = AirLibInputBG;
			}
			if (array_contains(element.tags, "bg")) {
				spr = AirLibDefaultBGSprite;
				color = AirLibBG;
			}
			if (array_contains(element.tags, "fg")) {
				spr = AirLibDefaultFGSprite;
				color = AirLibFG;
			}
			break;
	}
	switch (AirLibDefaultStyle) {
		case AirLibBtnStyle.Default:
			draw_sprite_stretched(
				spr,
				element[$ check] ?? 0,
				pos.left,
				pos.top,
				pos.width,
				pos.height
			);
			break;
		case AirLibBtnStyle.Flat:
			draw_set_color(color);
			draw_rectangle(
				pos.left,
				pos.top,
				pos.left + pos.width,
				pos.top + pos.height,
				false
			);
			draw_set_color(c_white);
			break;
		case AirLibBtnStyle.Rounded:
			draw_set_color(color);
			draw_roundrect_ext(
				pos.left,
				pos.top,
				pos.left + pos.width,
				pos.top + pos.height,
				AirLibRoundX,
				AirLibRoundY,
				false
			);
			draw_set_color(c_white);
			break;
	}
}

function window(struct, _generate = false) constructor {
	visible = true;
	ostruct = variable_clone(struct);
	bstruct = variable_clone(struct);
	generate = _generate;
	lastdepth = 0;
	ownername = struct[$ "name"];
	root = flexpanel_create_node(struct);
	instances = [];
	editing = false;
	startingdepth = 0;
	draw_list = [];
	draw_func = {};
	recalculate();
	var js = json_stringify(struct);
	if (!string_contains(js, "template") and string_contains(js, "grid") and room != rUIEditor) {
		fit_to_gui();
	}

	static set_visible = function(boolean) {
		visible = boolean;
	};

	static foreach = function(_function, node = undefined) {
		//fit_to_gui();
		if (!visible) {
			exit;
		}
		node ??= root;
		var pos = flexpanel_node_layout_get_position(node, false);
		var _name = flexpanel_node_get_name(node);
		var _data = flexpanel_node_get_data(node);
		if (!is_undefined(draw_func[$ _name]) and is_undefined(_data[$ "added"])) {
			_data[$ "added"] = true;
			array_push(draw_list, [_name, pos, _data, draw_func[$ _name]]);
		}
		
		#region tags
		if (!is_undefined(_data[$ "tags"])) {
			if (is_undefined(_data[$ "added"])) {
				_data[$ "added"] = true;
				array_push(draw_list, [_name, pos, _data, flexpanel_draw_tags]);
			}
			flexpanel_draw_tags(_name, pos, _data);
		}
		#endregion
		#region text
		if (!is_undefined(_data[$ "text"])) {
			if (is_undefined(_data[$ "added"])) {
				_data[$ "added"] = true;
				array_push(draw_list, [_name, pos, _data, flexpanel_draw_tags]);
			}
			flexpanel_draw_tags(_name, pos, _data);
		}
		#endregion
		_function(_name, pos, _data);

		var _children_count = flexpanel_node_get_num_children(node);
		for (var i = 0; i < _children_count; i++) {
			var _child = flexpanel_node_get_child(node, i);
			foreach(_function, _child);
		}
	};
	
	static add_draw = function (name, func) {
		draw_func[$ name] = func;
		return self;
	}
	
	static finish = function() {
		draw_list = [];
		foreach(function(){}, undefined);
	}
	
	static draw = function() {
		for (var i = 0; i < array_length(draw_list); i++) {
			var name = draw_list[i][0];
			var pos = draw_list[i][1];
			var data = draw_list[i][2];
			draw_list[i][3](name, pos, data);
		}
	}

	static set_node_function = function(node, _function) {
		set_data(node, {f: _function});
	};

	static fit_to_gui = function() {
		ostruct = variable_clone(bstruct);
		ostruct.top = 0;
		ostruct.left = 0;
		ostruct.width = display_get_gui_width();
		ostruct.height = display_get_gui_height();
		root = flexpanel_create_node(ostruct);
		recalculate();
		return self;
	};

	static center = function() {
		ostruct = variable_clone(bstruct);
		ostruct.top = gui_y_percent(50) - (ostruct.height / 2);
		ostruct.left = gui_x_percent(50) - (ostruct.width / 2);
		root = flexpanel_create_node(ostruct);
		recalculate();
		return self;
	};

	static fit_to_dimension = function(w, h) {
		ostruct = variable_clone(bstruct);
		ostruct.top = 0;
		ostruct.left = 0;
		ostruct.width = w;
		ostruct.height = h;
		root = flexpanel_create_node(ostruct);
		recalculate();
		return self;
	};

	static set_data = function(node, newdata) {
		var olddata = flexpanel_node_get_data(flexpanel_node_get_child(root, node));
		var newnames = variable_struct_get_names(newdata);
		for (var i = 0; i < array_length(newnames); ++i) {
			olddata[$ newnames[i]] = newdata[$ newnames[i]];
		}
		recalculate();
	};

	static set_inst_data = function(node, newdata) {
		var olddata = flexpanel_node_get_data(flexpanel_node_get_child(root, node));
		var newnames = variable_struct_get_names(newdata);
		for (var i = 0; i < array_length(newnames); ++i) {
			olddata[$ newnames[i]] = newdata[$ newnames[i]];
		}
		recalculate();
	};

	static node_visible = function(n, b = undefined) {
		var nn = flexpanel_node_get_child(root, n);
        if (is_undefined(b)) {
        	flexpanel_node_style_set_display(nn, !flexpanel_node_style_get_display(nn));
        } else {
        	flexpanel_node_style_set_display(nn, !b);
        }
		
		recalculate();
	};
	
	static node_is_visible = function(n) {
		var nn = flexpanel_node_get_child(root, n);
		return !flexpanel_node_style_get_display(nn);
	};

	static edit_mode = function(_bool = undefined) {
		editing = !editing;
		if (!is_undefined(_bool)) {
			editing = _bool;
		}
		for (var i = 0; i < array_length(instances); ++i) {
			if (instance_exists(instances[i])) {
				instances[i].editable = editing;
			} else {
				array_delete(instances, i, 1);
				i = 0;
			}
		}
	};

	static get_child = function(node) {
		return flexpanel_node_get_child(root, node);
	};

	static get_child_data = function(node, str = undefined) {
		if (str != undefined) {
			var _data = flexpanel_node_get_data(get_child(node));
			return _data[$ str];
		} else {
			return flexpanel_node_get_data(get_child(node));
		}
	};

	static generate_instance = function(_node, _depth) {
		// Get layout data
		var _pos = flexpanel_node_layout_get_position(_node, false);
		var _name = flexpanel_node_get_name(_node);
		//show_message(_name);
		if (_name == "undefined") {
			flexpanel_node_set_name(_node, irandom(999999));
		}

		// Update instance
		var _data = flexpanel_node_get_data(_node);
		_data.owner = self;
		if (
			(
				struct_exists(_data, "inst")
					&& (is_string(_data.inst) || !instance_exists(_data.inst))
			) || !struct_exists(_data, "inst")
		) {
			// Create instance
			var _depth2 = _data[$ "options"] != undefined
				? -100 + lastdepth
				: startingdepth;
			if (_depth2 == -100) {
				lastdepth++;
			}
			var _inst = instance_create_depth(
				_pos.left,
				_pos.top,
				_depth + _depth2,
				oUIElement,
				{
					name: _name,
					width: _pos.width,
					height: _pos.height,
					data: _data,
					editable: editing,
				}
			);

			_data.inst = _inst;
			array_push(instances, _inst);
		} else {
			var _inst = _data.inst;
			_inst.name = _name;
			_inst.x = _pos.left;
			_inst.y = _pos.top;
			_inst.width = _pos.width;
			_inst.height = _pos.height;
			_inst.editable = editing;
			_inst.data = _data;
			with (_inst) {
				event_perform(ev_create, 0);
			}
		}

		// Call for children (recursive)
		var _children_count = flexpanel_node_get_num_children(_node);
		for (var i = 0; i < _children_count; i++) {
			var _child = flexpanel_node_get_child(_node, i);
			generate_instance(_child, _depth - 1);
		}
	};

	static recalculate = function() {
		//dispose();
		target_w = display_get_gui_width();
		target_h = display_get_gui_height();
		flexpanel_calculate_layout(root, target_w, target_h, flexpanel_direction.LTR);
		if (generate) {
			generate_instance(root, 0);
		}
	};

	static dispose = function() {
		var f = function(e, i) {
			if (instance_exists(e)) {
				instance_destroy(e);
			}
		};
		array_foreach(instances, f);
	};

	static get_element_data = function(element, variable) {
		var el = flexpanel_node_get_child(root, element);
		var data = flexpanel_node_get_data(el);
		return data.inst.element[$ variable];
	};
}

function get_align(str) {
	var align = flexpanel_align.flex_start;
	switch (str) {
		case "stretch":
			align = flexpanel_align.stretch;
			break;
		case "flex_start":
			align = flexpanel_align.flex_start;
			break;
		case "flex_end":
			align = flexpanel_align.flex_end;
			break;
		case "center":
			align = flexpanel_align.center;
			break;
		case "baseline":
			align = flexpanel_align.baseline;
			break;
		case "space_between":
			align = flexpanel_align.space_between;
			break;
		case "space_around":
			align = flexpanel_align.space_around;
			break;
		case "space_evenly":
			align = flexpanel_align.space_evenly;
			break;
		case "column":
			align = flexpanel_flex_direction.column;
			break;
		case "row":
			align = flexpanel_flex_direction.row;
			break;
		case "column-reverse":
			align = flexpanel_flex_direction.column_reverse;
			break;
		case "row-reverse":
			align = flexpanel_flex_direction.row_reverse;
			break;
		case "none":
			align = flexpanel_display.none;
			break;
		case "flex":
			align = flexpanel_display.flex;
			break;
		case "relative":
			align = flexpanel_position_type.relative;
			break;
		case "absolute":
			align = flexpanel_position_type.absolute;
			break;
		case "static":
			align = flexpanel_position_type.static;
			break;
		default:
			align = -1;
			break;
	}
	return align;
}

global.options = [
	[
		"name",
		"textbox-char",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_set_name(node, a.text);
			oUI.editing = a.text;
			oUI.load_info();
			oEditableUI.ui.recalculate();
		}
	],
	[
		"width",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_width(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"height",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_height(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"minHeight",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_min_height(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"maxHeight",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_max_height(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"minWidth",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_min_width(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"maxWidth",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_max_width(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"padding",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_padding(node, flexpanel_edge.all_edges, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"border",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_border(node, flexpanel_edge.all_edges, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"alignContent",
		"listbox",
		[
			"flex-start",
			"flex-end",
			"stretch",
			"center",
			"space-between",
			"space-around",
			"space-evenly"
		],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_align_content(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"flex",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_flex(node, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"flexWrap",
		"listbox",
		["no-wrap", "wrap", "wrap-reverse"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_flex_wrap(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"flexDirection",
		"listbox",
		["column", "row", "row-reverse", "column-reverse"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_flex_direction(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"flexBasis",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_flex_basis(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"margin",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_margin(node, flexpanel_edge.all_edges, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"marginTop",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_margin(node, flexpanel_edge.top, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"marginBottom",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_margin(node, flexpanel_edge.bottom, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"marginLeft",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_margin(node, flexpanel_edge.left, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"marginRight",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_margin(node, flexpanel_edge.right, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"alignItems",
		"listbox",
		["flex-start", "flex-end", "center", "baseline"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_align_items(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"alignSelf",
		"listbox",
		["flex-start", "flex-end", "center", "baseline"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_align_self(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"aspectRatio",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_aspect_ratio(node, a.text);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"display",
		"listbox",
		["none", "flex"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_display(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"gap",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_gap(node, a.text, flexpanel_unit.point);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"top",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_position(
				node,
				flexpanel_edge.top,
				a.text,
				flexpanel_unit.point
			);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"left",
		"textbox",
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_position(
				node,
				flexpanel_edge.left,
				a.text,
				flexpanel_unit.point
			);
			oEditableUI.ui.recalculate();
		}
	],
	[
		"justifyContent",
		"listbox",
		[
			"flex-start",
			"flex-end",
			"center",
			"space-between",
			"space-around",
			"space-evenly"
		],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_justify_content(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	],
	[
		"position",
		"listbox",
		["relative", "absolute"],
		function(a) {
			var node = flexpanel_node_get_child(oEditableUI.ui.root, oUI.last_edit);
			if (node == undefined) {
				exit;
			}
			flexpanel_node_style_set_position_type(node, get_align(a.text));
			oEditableUI.ui.recalculate();
		}
	]
];

array_sort(global.options, function(e, i) {
	if (e[1] == "listbox") {
		return false;
	}
	if (e[0] == "name") {
		return false;
	}
	return true;
});

global.inspector = flexpanel_create_node(
	{
		name: "panel_side_ignore",
		maxWidth: 270,
		flex: 0.2,
		data: {image: sButton},
		nodes: [{name: "inspector-label-center", height: 30, data: {text: "Inspector"}}],
	}
);
for (var i = 0; i < array_length(global.options); ++i) {
	var o = global.options[i];
	var s = {
		name: $"{o[0]}",
		flex: 0.25,
		flexDirection: "row",
		nodes: [
			{name: "label-center", flex: 1, data: {text: $"{o[0]}"}},
			{
				name: $"{o[1]}-{o[0]}-ignore",
				flex: 1,
				data: {
					options: array_length(o) > 2 && is_array(o[2]) ? o[2] : [],
					f: array_length(o) > 2
					&& is_callable(o[2])
						? method(self, o[2])
						: method(self, o[3]),
				},
			}
		],
	};
	if (array_length(o) > 2) {
		//s.data.options = o[2];
	}
	var node = flexpanel_create_node(s);
	flexpanel_node_insert_child(
		global.inspector,
		node,
		flexpanel_node_get_num_children(global.inspector)
	);
}

//global.inspector = flexpanel_node_get_struct(global.inspector); 
