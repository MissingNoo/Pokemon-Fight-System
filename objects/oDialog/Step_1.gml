var _updown = - input_check_pressed("up") + input_check_pressed("down");
selectedOption += _updown;
var _currentText = array_get_index(optionsFalas, text);
if (showOptions and canInteract and _currentText != -1) {
    if (selectedOption > array_length(options[_currentText]) - 1) {
	    selectedOption = 0;
	}
	if (selectedOption < 0) {
	    selectedOption = array_length(options[_currentText]) - 1;
	}
}
