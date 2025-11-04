function tween(
	_object,
	_variable_name,
	_value,
	_animation = "back",
	_time = room_speed,
	_callback = -1
) {
	var _tween = instance_create_depth(
		x,
		y,
		depth,
		obj_tween,
		{
			object: _object,
			variable_name: _variable_name,
			value: _value,
			animation: _animation,
			time: _time,
			anim_curve: animcurve_get_channel(tween_curves, _animation),
			callback: _callback,
		}
	);

	return _tween;
}
