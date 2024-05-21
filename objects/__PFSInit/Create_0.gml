//Feather disable GM2017
if (PFS.Initialized) { instance_destroy(); }
timer = 0;
start = 0;
step = 0;
mapstring = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?,-."
PFS.Fonts = {};
PFS.Fonts.PokeFont[1] = font_add_sprite_ext(sPokeFont1, mapstring, true, 0);
PFS.Fonts.PokeFont[2] = font_add_sprite_ext(sPokeFont2, mapstring, true, 0);
PFS.Fonts.PokeFont[3] = font_add_sprite_ext(sPokeFont3, mapstring, true, 0);
PFS.Fonts.PokeFont[4] = font_add_sprite_ext(sPokeFont4, mapstring, true, 0);
PFS.Fonts.BattleFont[1] = font_add_sprite_ext(sBattleFont1, mapstring, true, 0);
PFS.Fonts.BattleFont[2] = font_add_sprite_ext(sBattleFont2, mapstring, true, 0);
PFS.Fonts.BattleFont[3] = font_add_sprite_ext(sBattleFont3, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[1] = font_add_sprite_ext(sPokeSelectFont1, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[2] = font_add_sprite_ext(sPokeSelectFont2, mapstring, true, 0);
PFS.Fonts.PokeSelectFont[3] = font_add_sprite_ext(sPokeSelectFont3, mapstring, true, 0);
//feather disable once GM1041
draw_set_font(PFS.Fonts.PokeFont[3]);
global.defaultFont = draw_get_font();
scribble_font_set_default("sPokeFont3");
//Feather disable GM2017