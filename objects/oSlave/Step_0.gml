var _dir = 0;
if (placeToGo[0] != x) {
	_dir = sign(placeToGo[0] - x);
	switch (_dir) {
	    case 1:
	        sprite_index = sRedWR;
	        break;
	    case -1:
	        sprite_index = sRedWL;
	        break;
	}
    x += _dir;
}
if (placeToGo[1] != y) {
	_dir = sign(placeToGo[1] - y);
	switch (_dir) {
	    case 1:
	        sprite_index = sRedWD;
	        break;
	    case -1:
	        sprite_index = sRedWU;
	        break;
	}
    y += _dir;
}
if (placeToGo[0] == x and placeToGo[1] == y) {
	image_speed = 0;
	image_index = 1;
}
else {
	image_speed = 5;
}