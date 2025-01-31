if (instance_number(oCam) > 1) { instance_destroy(); }
baseW = 240;
baseH = 160;
view_enabled = true;
view_visible[0] = true;
view_camera[0] = camera_create_view(0, 0, baseW, baseH, 0, oCam, -1, -1, baseW, baseH);
