//Feather disable GM2017
var _startx = startPosition[0];
var _starty = startPosition[1];
var _x = _startx;
var _y = _starty;
draw_set_font(PFS.Fonts.PokeFont[3]);
draw_sprite_ext(sBagBG, 0, _startx + 1, _starty + 1, 3, 3, 0, c_white, 1);
draw_set_font(PFS.Fonts.PokeFont[3]);
var _subimg = 0;
var a = DebugManager.a;
var b = DebugManager.b;
var c = DebugManager.c;
var d = DebugManager.d;
switch (fsm.get_current_state()) {
    case "Items":
        _subimg = 0;
        break;
    case "KeyItems":
        _subimg = 1;
        break;
    case "Pokeballs":
        _subimg = 2;
        break;
}
draw_sprite_ext(sBagButtons, _subimg, _startx + 10, _starty + 4, 3, 3, 0, c_white, drawalpha);
draw_sprite_ext(PlayerData.gender == Gender.Male ? sBagMale : sBagMale, _subimg, _startx + 122, _starty + 285 + bagoffset, 3, 3, 0, c_white, 1);
var _reccolor = #D6B552;
draw_rectangle_color(_startx + 265, _starty + 25, _startx + 696, _starty + 25 + reclerp, _reccolor, _reccolor, _reccolor, _reccolor, false);
fsm.draw();