fsm.step();
if (!instance_exists(oCam)) {
    instance_create_depth(0, 0, 0, oCam);
}
if (!canmove and alarm[0] == -1) {	
    alarm[0] = 4;
}