drew_opt = -1;
ui.draw();
ui.foreach(function(name, pos, data) {
	AirUIDefaultSpr
	AirUIArea
	switch (name) {
		case "opt_label":
			if (show_options) {
				if (options_height < options_height_start + _y) {
					options_height = options_height_start + _y + _h;
				}
				drew_opt++;
				var color = drew_opt == selected_option ? "c_yellow" : "c_white";
				scribble($"[{color}]{data.opttext}").draw(_x, _y); 
			}
			break;
	}
});