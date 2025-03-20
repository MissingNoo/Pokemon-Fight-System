optionsFalas = ["Squirtle", "SquirtleChosen", "SquirtleDespedida"]
options = [
	[
		["Yes", "SquirtleChosen", true, function() {
			PlayerTeam[0] = __PFS_generate_pokemon(PFS.Pokes[7])
		}],
		["No", "Exit", false]
	],
	[
		["Yes", "SquirtleDespedida", true, function() {
			PlayerData.got_starter = true;
			instance_create_depth(0, 0, -1000, oNickname, {pokemon : PlayerTeam[0], f : function() {
				instance_destroy(oDialog);
			}});
		}],
		["No", "Exit", false]
	],
	undefined
]