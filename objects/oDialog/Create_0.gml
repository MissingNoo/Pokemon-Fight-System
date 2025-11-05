str = { 
	"nodes": [
		{
			"nodes": [
				{
					"width": 190.0,
					"minHeight": 1.0,
					"data": {"image": "sDialogAnswer"},
					"height": 60.0,
					"nodes": [
						{
							"nodes": [],
							"flex": 1.0,
							"margin": 15.0,
							"name": "options",
							"padding": 0.0,
							"data": {},
						}
					],
					"flex": 1.6000000238418579,
					"margin": 20.0,
					"aspectRatio": 1.0,
					"name": "options_panel",
					"marginBottom": 0.0,
					"padding": 0.0,
				},
				{
					"flex": 1.0,
					"name": "panel_41315",
					"padding": 10.0,
					"width": 60.0,
					"data": {},
					"height": 60.0,
				},
				{
					"nodes": [
						{
							"flex": 1.0,
							"margin": 15.0,
							"name": "text",
							"marginLeft": 35.0,
							"data": {},
							"marginRight": 35.0,
						}
					],
					"flex": 1.0,
					"margin": 10.0,
					"name": "bg",
					"padding": 10.0,
					"data": {"image": "sDialogWindow2"},
					"minHeight": 29.0,
					"height": 60.0,
					"maxHeight": 999.0,
				}
			],
			"flex": 1.0,
			"name": "panel_base",
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {"image": ""},
			"height": 300.0,
		}
	],
	"name": "base",
	"left": 300.0,
	"top": 300.0,
	"width": 720.0,
	"data": {},
	"height": 480.0,
};

ui = new window(str, false);
ui.fit_to_gui();
if (on_battle) {
	flexpanel_node_style_set_margin(ui.get_child("bg"), flexpanel_edge.all_edges, 0);
	ui.recalculate();
}
//text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis tempor nisi, sit amet rhoncus felis feugiat a. Vestibulum et felis at enim volutpat iaculis sit amet nec eros. In pharetra, ante et tempus maximus, nisl quam volutpat tellus, in ultrices sapien neque ac lorem. Curabitur volutpat risus enim, et vestibulum metus porttitor sed. Nullam nibh ipsum, sodales eget ex eu, efficitur dapibus elit. Fusce tempor egestas neque sed molestie. Integer nec interdum metus. Cras at porttitor lacus. Cras finibus lorem ut elit consequat maximus eget nec turpis. Praesent luctus sagittis erat, non tincidunt nulla pellentesque efficitur. Ut fermentum ultrices elit, venenatis commodo neque pharetra ut. Aenean eu gravida elit.";
typist = scribble_typist();
typist.in(1, 0);
font_size = 1;
spacing = 160;

can_interact = true;
selected_option = 0;
drew_opt = -1;

#region Functions

function nextPage() {
	if (typist.get_state() == 1) {
		var page = scr.get_page();
		var last_page = scr.get_page_count();
		if (page < last_page - 1) {
			scr.page(scr.get_page() + 1);
		} else {
			if (array_length(next_dialog) > 0) {
				text = array_shift(next_dialog);
				typist = scribble_typist();
				scr = scribble("");
			} else {
				instance_destroy();
			}
		}
	} else {
		typist.skip();
	}
}

options_height_start = 0;
options_height = 0;
update_options = function() {
	flexpanel_node_remove_all_children(ui.get_child("options"));
	var arr = options[$ text];
	for (var i = 0; i < array_length(arr); i++) {
		var o = {
			"flex": 1.0,
			"margin": 2.0,
			"data": {opttext: arr[i].text},
			"maxHeight": 35.0,
			"name": $"opt_label",
		};
		flexpanel_node_insert_child(
			ui.get_child("options"),
			flexpanel_create_node(o),
			flexpanel_node_get_num_children(ui.get_child("options"))
		);
	}
	ui.recalculate();
};
#endregion
ui.add_draw("text", 
	AirUIFunctionStart
		var str = $"NPC.{npc}.Falas.{text}";
		scr = scribble(lexicon_text_struct(str, DialogData))
			.scale(font_size)
			.line_spacing($"{spacing}%")
			.wrap(_w, _h);
		scr.draw(_x, _y, typist);
	AirUIFunctionEnd
);
ui.add_draw("bg",
	AirUIFunctionStart
	AirUIDefaultSpr
		draw_sprite_stretched(dialog_sprite, 0, _x, _y, _w, _h);
	AirUIFunctionEnd
);
ui.add_draw("options_panel",
	AirUIFunctionStart
	AirUIDefaultSpr
		if (show_options) {
			options_height_start = _y;
			draw_sprite_stretched(spr, 0, _x, _y, _w, options_height);
		}
	AirUIFunctionEnd
);

ui.finish();
dbg = dbg_view("Dialog", false);
create_view_from_instance(self);