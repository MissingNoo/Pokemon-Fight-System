if (sprite_exists(enemySprite)) {
    sprite_delete(enemySprite);
}
if (sprite_exists(pokemonSprite)) {
    sprite_delete(pokemonSprite);
}
if (surface_exists(fightsurface)) {
    surface_free(fightsurface);
}
