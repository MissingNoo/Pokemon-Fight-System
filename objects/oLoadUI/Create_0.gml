uistr = {
	"name": "main_panel",
	"left": 275.0,
	"padding": 10.0,
	"top": 50.0,
	"width": 400.0,
	"data": {"tags": ["bg"]},
	"height": 300.0,
	"nodes": [
		{"padding": 10.0, "data": {}, "height": 30.0, "name": "title"},
		{
			"name": "body_panel",
			"flex": 1.0,
			"padding": 10.0,
			"data": {"tags": ["fg"]},
			"height": 60.0,
			"nodes": [
				{
					"name": "tags_panel",
					"flex": 1.0,
					"padding": 10.0,
					"data": {},
					"height": 60.0,
					"nodes": [
						{
							"name": "spacer4",
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						},
						{
							"flexDirection": "row",
							"name": "tag_drop_panel",
							"padding": 0.0,
							"data": {},
							"height": 60.0,
							"nodes": [
								{
									"flex": 1.0,
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"name": "tags_label",
								},
								{
									"flex": 1.0,
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"name": "dropdown_tags",
								}
							],
						},
						{
							"name": "spacer5",
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						}
					],
				},
				{
					"flexDirection": "row",
					"name": "btn_panel",
					"padding": 10.0,
					"data": {},
					"height": 60.0,
					"nodes": [
						{
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"name": "spacer1",
						},
						{
							"flex": 2.0,
							"padding": 10.0,
							"width": 61.0,
							"data": {"tags": ["button"]},
							"name": "button_accept",
						},
						{"flex": 1.0, "padding": 10.0, "data": {}, "name": "spacer2"},
						{
							"flex": 2.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {"tags": ["button"]},
							"name": "button_cancel",
						},
						{
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"name": "spacer3",
						}
					],
				}
			],
		}
	],
};
ui = new window(uistr);
ui.center();
uisdrop = new listbox();
addbtn = new button("Load");
addbtn
	.set_function(method(self, function() {
		oEditableUI.ui.dispose();
		oEditableUI.ui = new window(global.game_uis[$ uisdrop.text], true);
		instance_destroy();
	}));
delbtn = new button("Close");
delbtn
	.set_function(method(self, function() {
		instance_destroy();
	}));
struct_foreach(global.game_uis, method(self, function(name) {
	uisdrop.add_item(name);
}));
depth = -5000;
//data.tags = ["bg"];
//data = variable_clone(data);
//struct_remove(data, "owner");
//show_debug_message(data); 
