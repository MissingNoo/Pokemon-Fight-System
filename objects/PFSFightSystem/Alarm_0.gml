battlestartfinished = true;
animationended = true;
var _pemit1 = part_emitter_create(ps);
part_emitter_region(ps, _pemit1, -32, 32, -32, 32, ps_shape_rectangle, ps_distr_linear);
part_emitter_burst(ps, _pemit1, ptype1, 30);