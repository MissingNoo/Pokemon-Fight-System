if (can_interact) {
    if (options != undefined) {
        var up_down = - input_check_pressed("up") + input_check_pressed("down");
    	selected_option = clamp(selected_option + up_down, 0, array_length(options[$ text]) - 1);
    }
    
    if (input_check_pressed("accept")) {
        if (!show_options) {
        	nextPage();
        } else {
        	var o = options[$ text][selected_option];
            if (o[$ "go_to"] != undefined) {
            	text = o.go_to;
            }
            if (o[$ "f"] != undefined) {
            	o.f();
            }
            show_options = false;
        }
    }
}