//event_inherited();
if (instance_number(oPlayer) > 1) { instance_destroy(); }
visible = false;
canmove = true;
display_set_gui_size(720*1.5, 480*1.5);
window_center();
moving = false;
placeToGo = [x, y];
image_speed = 0;
image_index = 1;
PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);
PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[4]);
PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[7]);
x = 120;
y = 112;
room_goto(rPlayerHouse2f);