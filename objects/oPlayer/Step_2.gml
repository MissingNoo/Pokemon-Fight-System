//oCam.x += (oPlayer.x - oCam.x) / 16;
//oCam.y += (oPlayer.y - oCam.y) / 16;
if (movecam) {
    oCam.x = oPlayer.x;
	oCam.y = oPlayer.y;
}
fsm.endstep();
if (instance_exists(PFSFightSystem)) {
	fsm.change("battle");
	exit;
}
if (instance_exists(oNewDialog)) {
	fsm.change("dialog");
	exit;
}
if (instance_exists(oBag)) {
	fsm.change("bag");
	exit;
}