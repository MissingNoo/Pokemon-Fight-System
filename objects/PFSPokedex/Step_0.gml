var last = pokemon;
var laststate = curstate;
pokemon = clamp(pokemon - keyboard_check_pressed(vk_pageup) + keyboard_check_pressed(vk_pagedown), 0, array_length(PlayerTeam) - 1);
curstate = clamp(curstate - keyboard_check_pressed(vk_f1) + keyboard_check_pressed(vk_f2), 0, array_length(states) - 1);
if (pokemon != last) { load_sprite(PlayerTeam[pokemon]); }
if (curstate != laststate) { tab.change(states[curstate]); }
tab.step();