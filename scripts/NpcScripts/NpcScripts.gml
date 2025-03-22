enum NpcNames {
	Oak,
	Gary
}
enum NpcMovement {
	Still,
	Random,
	Path,
	Rotating
}
enum NpcBattle {
	NoBattle,
	NormalBattle
}
function Npc(name) constructor
{
	static npcid = 0;
	npcname = name;
	nid = npcid;
	movement = NpcMovement.Still;
	battle = NpcBattle.NoBattle;
	dialog = false;
	text = "";
    options = undefined;
	sprites = [sRedWR, sRedWU, sRedWL, sRedWD];
    static setDialog = function(dialogtext) {
		dialog = true;
		text = dialogtext;
		return self;
    }
    static set_options = function(opt) {
		options = opt;
		return self;
    }
    static setSprites = function(arr) {
		sprites = arr;
		return self;
    }
	npcid++;
}

global.npcs = [];
#macro Npcs global.npcs
Npcs[NpcNames.Oak] = new Npc("Oak");
Npcs[NpcNames.Oak].setDialog("LabInteraction")
.setSprites([sOakWR, sOakWU, sOakWL, sOakWD]);

Npcs[NpcNames.Gary] = new Npc("Gary");
Npcs[NpcNames.Gary].setDialog("LabInteraction")
.setSprites([sGaryWR, sGaryWU, sGaryWL, sGaryWD]);