fsm.beginstep();
fsn.beginstep();
if (keyboard_check_pressed(vk_up) and fsn.get_current_state() != "Interacting") {
    selecteditem = previous_item_from_tab(tabselected, selecteditem);
}
if (keyboard_check_pressed(vk_down) and fsn.get_current_state() != "Interacting") {
    selecteditem = next_item_from_tab(tabselected, selecteditem);
}