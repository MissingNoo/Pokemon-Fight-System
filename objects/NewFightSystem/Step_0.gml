if (pokemon_released) {
    draw_replace_timer = clamp(draw_replace_timer - 1, 0, 60);
}
fsm.step();