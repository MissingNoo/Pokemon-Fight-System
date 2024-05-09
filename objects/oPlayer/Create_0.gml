//event_inherited();
if (instance_number(oPlayer) > 1) { instance_destroy(); }
visible = false;
canmove = true;
display_set_gui_size(832*1.5, 640*1.5);
window_center();
moving = false;
placeToGo = [x, y];
image_speed = 0;
image_index = 1;
PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);
//PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[4]);
//PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[7]);
x = 168;
y = 96;
room_goto(rPlayerHouse);