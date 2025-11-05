if (can_interact) {
	var option_data;
	if (!is_undefined(options) and !is_undefined(options[$ text])) {
		var up_down = -input_check_pressed("up") + input_check_pressed("down");
		selected_option = clamp(
			selected_option + up_down,
			0,
			array_length(options[$ text]) - 1
		);
		option_data = options[$ text][selected_option];
	} else {
		show_options = false;
	}

	if (input_check_pressed("accept")) {
		if (!show_options) {
			nextPage();
		} else {
			if (option_data.use_function) {
				option_data.func();
			}
			if (option_data.goto) {
				text = option_data.next_text;
			}
			show_options = false;
		}
	}
}
