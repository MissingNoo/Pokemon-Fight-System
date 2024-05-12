//show_debug_message($"{text} / {acceptedOption}");
var _currentText = array_get_index(optionsFalas, text);
var _state = typist.get_state();
if (scr.get_page() < scr.get_page_count() - 1) {
    showOptions = false;
}
if (scr.get_page() == scr.get_page_count() - 1 and _state == 1) {
	interaction = Interactions.AcceptOption;
}
if (canInteract and input_check("accept")) {	
	switch (interaction) {
	    case Interactions.Skip:
				show_debug_message("Skipping text");
			    typist.skip();
				interaction = Interactions.NextPage;
	        break;
		case Interactions.NextPage:
			if (scr.get_page() < scr.get_page_count()) {
			    scr.page(scr.get_page() + 1);
				show_debug_message("Next page");
				interaction = Interactions.Skip;
			}
			break;
		case Interactions.AcceptOption:
			if (!showOptions) {
			    break;
			}
			show_debug_message($"Accept {options[_currentText][selectedOption][1]}");
			if (options[_currentText][selectedOption][1] == "Sair") {
			    instance_destroy();
			}
			else {
				interaction = Interactions.Skip;
				text = options[_currentText][selectedOption][1];
			}
			selectedOption = 0;
			break;
	}
	canInteract = false;
	alarm[1] = 10;
}

