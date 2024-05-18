optionsFalas = ["Charmander"]
options = [
	[
		["Yes", "CharmanderChosen", true, function() {PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1])}],
		["No", "Exit", false]
	]
]