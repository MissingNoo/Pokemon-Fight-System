with (object) {
	other.percent += 1 / other.time;
	other.percent = clamp(other.percent, 0, 1);
	other.position = animcurve_channel_evaluate(other.anim_curve, other.percent);
	if (other.percent < 1) {
		self[$ other.variable_name] =
			other.base_value
			+ (other.value - other.base_value) * other.position;
	} else {
		self[$ other.variable_name] =
			other.base_value
			+ (other.value - other.base_value) * other.position;
		if (other.callback != -1) {
			other.callback();
		}
		instance_destroy(other);
	}
}
