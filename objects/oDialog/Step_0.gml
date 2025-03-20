//show_debug_message($"{text} / {acceptedOption}");
if (!visible or instance_exists(oNickname)) { exit; }
battlecoords();
//feather disable once GM1041
var _currentText = array_get_index(optionsFalas, text);
var _state = typist.get_state();
if (scr.get_page() == scr.get_page_count() - 1 and _state == 1) {
	interaction = Interactions.AcceptOption;
}
if (canInteract and input_check("accept")) {	
	switch (interaction) {
	    case Interactions.Skip:
			if (!canskip) {
			    break;
			}
				if (typist.get_state() == 1) {
				    nextPage();
					break;
				}
				show_debug_message("Skipping text");
			    typist.skip();
				interaction = Interactions.NextPage;
	        break;
		case Interactions.NextPage:
			nextPage();
			break;
		case Interactions.AcceptOption:
		//feather disable once GM1041
			if (array_length(options) == 0) {
			    instance_destroy();
			}
			if (!showOptions) {
			    break;
			}
			show_debug_message($"Accept {options[_currentText][selectedOption][1]}");
			if (options[_currentText][selectedOption][2]) {
			    options[_currentText][selectedOption][3]();
			}
			if (options[_currentText][selectedOption][1] == "Exit") {
			    instance_destroy();
			}
			else {
				interaction = Interactions.Skip;
				text = options[_currentText][selectedOption][1];
			}
			selectedOption = 0;
			showOptions = false;
			break;
	}
	canInteract = false;
	alarm[1] = 10;
}

