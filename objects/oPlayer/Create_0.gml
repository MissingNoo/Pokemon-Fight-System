//event_inherited();
visible = false;
display_set_gui_size(832*1.5, 640*1.5);
window_center();
moving = false;
placeToGo = [x, y];
image_speed = 0;
image_index = 1;
PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);