AirLib.frame++;
array_foreach(AirLib.lerpers, function(e, i) {
	e.tick();
});
