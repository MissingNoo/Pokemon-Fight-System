uistr = {
	"name": "main",
	"nodes": [
		{"padding": 10.0, "data": {}, "height": 30.0, "name": "title"},
		{
			"flex": 1.0,
			"name": "body_panel",
			"nodes": [
				{
					"flex": 1.0,
					"name": "main_panel",
					"nodes": [
						{
							"name": "tag_drop_panel",
							"nodes": [
								{
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"flex": 1.0,
									"text": "Text",
									"name": "tags",
								},
								{
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"flex": 1.0,
									"name": "dropdown_tags",
								}
							],
							"padding": 0.0,
							"data": {},
							"height": 60.0,
							"flexDirection": "row",
						},
						{
							"flex": 0.0,
							"name": "hpanel",
							"nodes": [
								{
									"flex": 1.0,
									"name": "panel_12460",
									"padding": 10.0,
									"width": 60.0,
									"data": {
										"tags": [],
										"text": "Halign",
										"base_text": "Halign",
									},
									"height": 60.0,
								},
								{
									"flex": 1.0,
									"name": "dropdown_halign",
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"height": 60.0,
								}
							],
							"padding": 0.0,
							"data": {},
							"height": 60.0,
							"flexDirection": "row",
						},
						{
							"name": "v_panel",
							"nodes": [
								{
									"flex": 1.0,
									"name": "panel_30784",
									"padding": 10.0,
									"width": 60.0,
									"data": {"text": "Valign", "base_text": "Valign"},
									"height": 60.0,
								},
								{
									"flex": 1.0,
									"name": "dropdown_valign",
									"padding": 10.0,
									"width": 60.0,
									"data": {},
									"height": 60.0,
								}
							],
							"padding": 0.0,
							"data": {},
							"height": 60.0,
							"flexDirection": "row",
						}
					],
					"padding": 10.0,
					"data": {},
					"height": 60.0,
				},
				{
					"name": "btn_panel",
					"nodes": [
						{
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"flex": 1.0,
							"name": "spacer1",
						},
						{
							"padding": 10.0,
							"width": 61.0,
							"data": {"tags": ["button"]},
							"flex": 2.0,
							"name": "button_accept",
						},
						{
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"flex": 1.0,
							"name": "spacer3",
						}
					],
					"padding": 10.0,
					"data": {},
					"height": 60.0,
					"flexDirection": "row",
				}
			],
			"padding": 10.0,
			"data": {"tags": ["fg"]},
			"height": 60.0,
		}
	],
	"left": 275.0,
	"padding": 10.0,
	"top": 50.0,
	"width": 400.0,
	"data": {"tags": ["bg"]},
	"height": 453.0,
};
global.game_uis.textmanager = uistr;
ui = new window(uistr);
ui.center();
h = new listbox();
v = new listbox();
h.add_item("fa_left").add_item("fa_center").add_item("fa_right");
v.add_item("fa_top").add_item("fa_middle").add_item("fa_bottom");
text = new textbox();
if (!is_undefined(data[$ "base_text"])) {
	text.text = data.base_text;
	h.text = string_split(data.text_pos, ":")[0];
	v.text = string_split(data.text_pos, ":")[1];
}
addbtn = new button("Set");
addbtn
	.set_function(method(self, function() {
		var hh = "";
		var vv = "";
		if (h.text != "") {
			hh = $"[{h.text}]";
		}
		if (v.text != "") {
			vv = $"[{v.text}]";
		}
		data.text = $"{hh}{vv}{text.text}";
		data.base_text = text.text;
		data.text_pos = $"{h.text}:{v.text}";
		oEditableUI.ui.dispose();
		oEditableUI.ui.recalculate();
		instance_destroy();
	}));
depth = -5000;
