optionsFalas = ["Squirtle"]
options = [
	[
		["Yes", "SquirtleChosen", true, function() {PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[4])}],
		["No", "Exit", false]
	]
]