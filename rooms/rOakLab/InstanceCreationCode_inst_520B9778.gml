options = {
	"Charmander": [
		new dialog_option("Yes")
			.set_goto("CharmanderChosen")
			.set_function(function() {
				PlayerTeam[0] = __PFS_generate_pokemon(PFS.Pokes[4]);
			}),
		new dialog_option("No")
			.set_goto("CharmanderChosen")
			.set_function(function() {
				instance_destroy(oDialog);
			})
	],
	"CharmanderChosen": [
		new dialog_option("Yes").set_function(function() {
			PlayerData.got_starter = true;
			instance_create_depth(0, 0, -1000, oNickname, {
				pokemon: PlayerTeam[0],
				f: function() {
					instance_destroy(oDialog);
				},
			});
		}),
		new dialog_option("No")
			.set_goto("CharmanderChosen")
			.set_function(function() {
				instance_destroy(oDialog);
			})
	],
};
