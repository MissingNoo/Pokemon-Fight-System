//Feather disable GM2017
if (instance_number(PFSPokemonManager) > 1) { instance_destroy(); }
surface = surface_create(240*3, 160*3);
windowSize = [700, 400];
startPosition = [0, 0];
selectedPokemon = 0;