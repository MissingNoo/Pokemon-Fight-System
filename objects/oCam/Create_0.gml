if (instance_number(oCam) > 1) { instance_destroy(); }
done = false;
baseW = 240;
baseH = 160;
offsetW = 0;
offsetH = 0;
view_enabled = true;
view_visible[0] = true;
var xport = 0;
var yport = 0;
var wport = baseW;
var hport = baseH;
view_camera[0] = camera_create_view(0, 0, wport, hport, 0, oCam, -1, -1, 240, 160);
