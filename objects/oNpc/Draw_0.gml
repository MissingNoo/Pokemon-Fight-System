switch (dir) {
    case 0:
        sprite_index = npc.sprites[0];
        break;
    case 90:
        sprite_index = npc.sprites[1];
        break;
    case 180:
        sprite_index = npc.sprites[2];
        break;
    case 270:
        sprite_index = npc.sprites[3];
        break;
}
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);