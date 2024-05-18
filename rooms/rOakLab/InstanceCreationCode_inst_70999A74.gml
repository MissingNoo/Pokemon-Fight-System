optionsFalas = ["Bulbasaur", "BulbasaurChosen"]
options = [
	[
		["Yes", "BulbasaurChosen", true, function() {PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1])}],
		["No", "Exit", false]
	],
	[
		["Yes", "BulbasaurChosen", true, function() {show_message_async("Not yet implemented!")}],
		["No", "Exit", false]
	]
]