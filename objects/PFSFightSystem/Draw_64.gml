draw_rectangle_color(GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2), GW/2 - (windowSize[0] / 2) + windowSize[0], GH/2 - (windowSize[1] / 2) + windowSize[1], c_black, c_black, c_black, c_black, false);
surface_set_target(fightsurface);
//Feather disable GM2017
//draw_sprite_ext(sEndResult, 0, GW/2, GH/2, 3, 3, 0, c_white, 1);
#region Start Variables
var _yoff = 0;
var _xoff = 0;
draw_sprite_ext(PFSBattleBgs, 1, 1, 1, 3, 3, 0, c_white, 1);
draw_sprite_ext(PFSBattleBgsPaths, 1, enemypathx[0], enemypathy, 3, 3, 0, c_white, 1);
draw_sprite_ext(PFSBattleBgsPaths, 1, playerpathx[0], playerpathy, 3, 3, 0, c_white, 1);
//draw_sprite_ext(sEndResult, 1, 1, 1, 3, 3, 0, c_white, 1);

#endregion

#region Main Window
draw_rectangle(0, 0, windowSize[0], windowSize[1], true);
#endregion

#region Battle Area
var _pokemon;
var _boxEndX;
var _boxEndY;
#region Enemy Pokemon Info
_pokemon = enemyPokemon[enemyOut];
var _x = (windowSize[0] * 0.02);
var _y = (windowSize[1] * 0.03);
_boxEndX = (windowSize[0] * 0.30);
_boxEndY = (windowSize[1] * 0.23);
poke_info(0, 0, _x, _y, _boxEndX, _boxEndY, _pokemon, PFSBattleSides.Enemy);
#endregion
_pokemon = PFS.playerPokemons[pokemonOut];
#region Player Pokemon Info
_x = (windowSize[0] * 0.40);
_y = (windowSize[1] * 0.75);
_boxEndX = (windowSize[0] * 0.70);
_boxEndY = (windowSize[1] * 0.95);
poke_info(0, 0, _x, _y, _boxEndX, _boxEndY, _pokemon, PFSBattleSides.Player);
part_system_drawit(ps);
draw_sprite_ext(PFSBehindBar, 0, 0, 336, 3, 3, 0, c_white, 1);
#endregion
#endregion
sys.draw();
if (!battlestartfinished or drawball) {
    draw_sprite_ext(PFSBehindBar, 0, 0, 336, 3, 3, 0, c_white, 1);
}
draw_set_color(c_white);
if (DEBUGMODE) {
    scribble($"state: {sys.get_current_state()}\ncurrentanimation: {currentanimation}\ncaninteract: {caninteract}").scale(1).draw(10, 10);
}
surface_reset_target();
if (surface_exists(fightsurface)) {
	draw_surface_ext(fightsurface, GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2), 1, 1, 0, c_white, 1);
}