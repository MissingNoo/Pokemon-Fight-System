//Feather disable GM2017
if (instance_exists(oDialog)) {
	exit;
}
if (!instance_exists(oDialog)) {
	if (ranaway or caught) {
		instance_destroy();
	}
	dialog = noone;
}
//var _cantchange = ["dialog", "choosingpokemon"];
//if (instance_exists(oDialog) and array_get_index(_cantchange, sys.get_current_state()) == -1) {
//    laststate = sys.get_current_state();
//	sys.change("dialog");
//}

//sys.beginstep();
//if (waittime > 0) {
//    exit;
//}
//if (instance_exists(PFSPokemonManager) or dialog != noone) {
//    exit;
//}

