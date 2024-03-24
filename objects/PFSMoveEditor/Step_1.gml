if (keyboard_check_pressed(vk_numpad0)) { show = !show; }
if (!show) { exit; }
#region Move List
var _vkupdown = -keyboard_check(vk_pageup) + keyboard_check(vk_pagedown);
moveListOffset += _vkupdown * 30;
#endregion