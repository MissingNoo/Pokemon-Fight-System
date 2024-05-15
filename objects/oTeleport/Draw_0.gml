var _rot = 0;
var _xoff = 0;
var _yoff = 0;
if (collided and confirmation) {
	switch (dir) {
	    case "Up":
	        _rot = 180;
			_xoff = 0;
			_yoff = -4;
	        break;
	    case "Down":
	        _rot = 0;
			_xoff = 0;
			_yoff = 4;
	        break;
	    case "Left":
	        _rot = 90;
			_xoff = -4;
			_yoff = 0;
	        break;
	    case "Right":
	        _rot = 270;
			_xoff = 4;
			_yoff = 0;
	        break;
	}
    draw_sprite_ext(sTeleportArrow, subimg, x + _xoff, y + _yoff, 1, 1, _rot, c_white, 1);
}