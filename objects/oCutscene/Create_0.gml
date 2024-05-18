oPlayer.fsm.change("cutscene");
ini_open("Game.ini");
var _seen = bool(ini_read_real("Cutscenes", cutscene.cname, false));
ini_close();
if (_seen) {
    instance_destroy();
}
else {
	ini_open("Game.ini");
	ini_write_real("Cutscenes", cutscene.cname, true);
	ini_close();
}
currentstep = 0;
laststep = array_length(cutscene.steps) - 1;
alarms = [];
alarmdone = false;
currentmessage = 0;
cancontinue = true;
lastnpcinteracted = -1;