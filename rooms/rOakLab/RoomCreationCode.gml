scribble_typists_add_event("didyouget", function() {
	if (PlayerData.got_starter) {
	    instance_destroy(oDialog);
		instance_create_depth(0, 0, -1000, oDialog, { npc : "LabSelect", text : "AlreadyGot" });
	}
});
scribble_typists_add_event("canreceivestarter", function() {
	if (!PlayerData.tried_to_exit_pallet) {
	    instance_destroy(oDialog);
		instance_create_depth(0, 0, -1000, oDialog, { npc : "LabSelect", text : "OakIsNotHere" });
	}
});