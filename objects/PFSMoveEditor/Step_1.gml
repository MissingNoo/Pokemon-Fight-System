if (keyboard_check_pressed(vk_numpad0)) { show = !show; }
if (!show) { exit; }
var _updown = -keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down);

#region Move Information
if (_updown != 0) {
	set = false;
    selected += _updown;
	if (selected < 0) { selected = optionsLenght - 1; }
	if (selected >= optionsLenght) { selected = 0; }
}
try{
	if ((keyboard_check(vk_anykey) and !keyboard_check(vk_down) and !keyboard_check(vk_up)) and keyboard_string != "" and selected == 0 and is_real(real(keyboard_string))) {
	    loadMove(real(keyboard_string));
	}
}
catch (err){
	
}
#endregion

#region Move List
var _vkupdown = -keyboard_check(vk_pageup) + keyboard_check(vk_pagedown);
moveListOffset += _vkupdown * 30;
#endregion