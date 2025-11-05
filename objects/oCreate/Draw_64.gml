ui.draw();
array_sort(droplist, function(e1, e2) {
	return e1.area[1] < e2.area[1];
});
array_foreach(droplist, function(e, i) {
	e.draw();
});
