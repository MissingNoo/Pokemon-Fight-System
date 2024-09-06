var last = pokemon;
pokemon = clamp(pokemon - keyboard_check_pressed(vk_pageup) + keyboard_check_pressed(vk_pagedown), 1, array_length(PFS.Pokes) - 1);
if (pokemon != last) {
    load_sprite(PFS.Pokes[pokemon]);
}