fsm.beginstep();
if (keyboard_check_pressed(vk_up)) {
    selecteditem = previous_item_from_tab(tabselected, selecteditem);
}
if (keyboard_check_pressed(vk_down)) {
    selecteditem = next_item_from_tab(tabselected, selecteditem);
}