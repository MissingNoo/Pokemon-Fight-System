ui = new window(global.game_uis.create);

droplist = [];

name_input = new textbox();
name_input.only_numbers = false;
name_input.can_be_null = false;
name_input.backtext = "Insert the room name here";
name_input.backspr = undefined;

type_dropdown = new listbox();
type_dropdown.add_item("Public").add_item("Private").add_item("Offline");
type_dropdown.text = "Public";
type_dropdown.backspr = undefined;
array_push(droplist, type_dropdown);

maxp = new listbox();
for (var i = 1; i <= 12; i++) {
	maxp.add_item(i);
}
maxp.text = 12;
maxp.backspr = undefined;
array_push(droplist, maxp);

quit_button = new button("X");
quit_button
	.set_function(method(self, function() {
		instance_activate_object(oMainMenu);
		instance_destroy(self);
	}));

create_button = new button("Create");
create_button
	.set_function(method(self, function() {
		if (name_input.text != "") {
			new packet("newRoom")
				.write("roomName", name_input.text)
				.write("password", "")
				.write("maxPlayers", maxp.text)
				.write("roomType", type_dropdown.text)
				.write("joinRequest", request.checked)
				.send()
		}
	}));

ask_to_join = false;
request = new checkbox(false);
request.set_on_change(method(self,function(checked){
	ask_to_join = checked;
}));

ui.add_draw("create_panel", 
	AirUIFunctionStart 
		quit_button.position(_x + _w - 20, _y - 20, _x + _w + 20, _y + 20);
		quit_button.draw();
	AirUIFunctionEnd 
);
ui.add_draw("name_input", 
	AirUIFunctionStart 
		name_input.position(_x, _y, _x + _w, _y + _h);
		name_input.draw();
	AirUIFunctionEnd 
);
ui.add_draw("type_selection", 
	AirUIFunctionStart 
		type_dropdown.position(_x, _y, _x + _w, _y + _h);
	AirUIFunctionEnd 
);
ui.add_draw("maxp_selection", 
	AirUIFunctionStart 
		maxp.position(_x, _y, _x + _w, _y + _h);
	AirUIFunctionEnd 
);
ui.add_draw("create_button", 
	AirUIFunctionStart 
		create_button.position(_x, _y, _x + _w, _y + _h);
		create_button.draw();
	AirUIFunctionEnd 
);
ui.add_draw("request_selection", 
	AirUIFunctionStart 
		request.position(_x, _y, _x + _w, _y + _h);
		request.draw();
	AirUIFunctionEnd 
);
ui.finish();
