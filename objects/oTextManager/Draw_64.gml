//feather ignore all
ui.foreach(function(name, pos, data) {
	AirUIArea;
	switch (name) {
		case "title":
			scribble("[fa_center][fa_middle][c_black]Tag Editor").draw(
				_x + _w / 2,
				_y + _h / 2
			);
			break;
		case "dropdown_tags":
			text.position(_x, _y, _x + _w, _y + _h);
			break;
		case "dropdown_valign":
			v.position(_x, _y, _x + _w, _y + _h);
			break;
		case "dropdown_halign":
			h.position(_x, _y, _x + _w, _y + _h);
			break;
		case "button_accept":
			addbtn.position(_x, _y, _x + _w, _y + _h);
			break;
	}
});
addbtn.draw();
text.draw();
v.draw();
h.draw();
