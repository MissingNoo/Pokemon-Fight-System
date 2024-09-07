/// @description Insert description here
// You can write your code in this editor
var laststep = 14;
draw_rectangle_color(GW/2 - 200, GH/2 - 16, GW/2 - 200 + ((400/laststep) * step), GH/2 + 15, c_green, c_green, c_green, c_green, false);
draw_rectangle_color(GW/2 - 202, GH/2 + 17, GW/2 + 202, GH/2 + 17, c_white, c_white, c_white, c_white, true);
scribble("[fa_center][fa_middle]Loading!").scale(2).draw(GW/2, GH/2 - 60);