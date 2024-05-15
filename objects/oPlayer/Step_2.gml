//oCam.x += (oPlayer.x - oCam.x) / 16;
//oCam.y += (oPlayer.y - oCam.y) / 16;
if (movecam) {
    oCam.x = oPlayer.x;
	oCam.y = oPlayer.y;
}
fsm.endstep();