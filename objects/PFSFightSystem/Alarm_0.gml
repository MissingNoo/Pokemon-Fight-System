if (bally >= ballendy) {
    battlestartfinished = true;
	animationended = true;
	pokemonhplerp = PFS.playerPokemons[pokemonOut].hp;
	playerpokesizelerp = 1;
	if (lastanimation == "comeback") {
	    instance_destroy(oDialog);
	}
	load_sprite(PFS.playerPokemons[pokemonOut], 1);
	var _pemit1 = part_emitter_create(ps);
	part_emitter_region(ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(ps, _pemit1, ptype1, 30);
}
else {
	alarm[0] = 1;
}
