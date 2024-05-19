if (keyboard_check(vk_delete)) {
    instance_destroy();
}
reclerp = lerp(reclerp, 0, 0.15);
if (reclerp <= 30) {
    drawalpha = 1;
}
else {
	drawalpha = 0;
}
if (bagoffset < 0) {
    bagoffset+= 2;
}
if (bagoffset > 0) {
    bagoffset = 0;
}
fsm.step();
fsn.step();
if (keyboard_check_pressed(ord("A"))) {
    onBattle = !onBattle;
	if (onBattle) {
	    interactoptions = ["Use", "Cancel"];
	}else {
		interactoptions = ["Use", "Give", "Toss", "Cancel"];
	}
}