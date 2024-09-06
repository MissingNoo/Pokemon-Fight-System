if (!surface_exists(surf)) { surf = surface_create(239, 159); }
surface_set_target(surf);
draw_sprite(PFSDexPokeInfo, 0, 0, 16);
draw_sprite(PFSDexTab, 0, 0, 0);
draw_sprite(PFSDexPokeArea, 0, 0, 16);
var d = DebugManager;
//scribble($"Lv{PFS.Pokes[pokemon].level} {PlayerTeam[0].internalName}").scale(0.35).draw(5, 21);
scribble($"{PFS.Pokes[pokemon].internalName}").scale(0.35).draw(5, 21);
draw_sprite_ext(sprite, 0, 75, 110, 0.50, 0.50, 0, c_white, 1);
surface_reset_target();
var scale = 3;
draw_surface_ext(surf, GW/2 - (surface_get_width(surf) * scale) / 2, GH/2 - (surface_get_height(surf) * scale) / 2, 3, 3, 0, c_white, 1);