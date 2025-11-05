ui = new window(
	{
		"name": "friend_panel",
		"nodes": [
			{
				"flex": 1.0,
				"name": "text",
				"margin": 5.0,
				"padding": 10.0,
				"data": {"tags": ["fg"]},
				"height": 60.0,
			},
			{
				"name": "btn_panel",
				"margin": 5.0,
				"nodes": [
					{
						"padding": 10.0,
						"width": 60.0,
						"data": {},
						"flex": 1.0,
						"name": "panel_23659",
					},
					{
						"padding": 10.0,
						"width": 60.0,
						"data": {"tags": ["button"]},
						"flex": 3.0,
						"name": "accept",
					},
					{
						"padding": 10.0,
						"width": 60.0,
						"data": {},
						"flex": 1.0,
						"name": "panel_42815",
					},
					{
						"padding": 10.0,
						"width": 60.0,
						"data": {"tags": ["button"]},
						"flex": 3.0,
						"name": "refuse",
					},
					{
						"padding": 10.0,
						"width": 60.0,
						"data": {},
						"flex": 1.0,
						"name": "panel_28900",
					}
				],
				"padding": 5.0,
				"data": {"tags": ["fg"]},
				"height": 60.0,
				"flexDirection": "row",
			}
		],
		"left": 495.0,
		"top": 220.0,
		"width": 400.0,
		"data": {"tags": ["bg"]},
		"height": 200.0,
	}
);
ui.center();

accept = new button("Accept");
accept
	.set_function(method(self, function() {
		new packet("acceptFriend").write("player", player).send()
		instance_destroy();
	}));

refuse = new button("Refuse");
refuse
	.set_function(method(self, function() {
		instance_destroy();
	}));

ui.add_draw("text", 
	AirUIFunctionStart 
	scribble($"{player} wants to add you as a friend")
				.fit_to_box(_w, _h)
				.wrap(_w - 5)
				.draw(_x + 5, _y + 5);
	AirUIFunctionEnd 
);
ui.add_draw("accept", 
	AirUIFunctionStart 
	accept.position_area(area);
			accept.draw();
	AirUIFunctionEnd 
);
ui.add_draw("refuse", 
	AirUIFunctionStart 
	refuse.position_area(area);
			refuse.draw();
	AirUIFunctionEnd 
);
ui.finish();
