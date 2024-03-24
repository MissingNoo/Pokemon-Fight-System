if (keyboard_check_pressed(vk_numpad9)) { show = !show; }
if (!show) { exit; }
#region Poke List
var _vkupdown = -keyboard_check(vk_pageup) + keyboard_check(vk_pagedown);
pokeListOffset += _vkupdown * 30;
var _heupdown = -keyboard_check(vk_insert) + keyboard_check(vk_delete);
canLearnOffset += _heupdown * 30;
#endregion