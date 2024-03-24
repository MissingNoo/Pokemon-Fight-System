#!/bin/bash
mkdir $1 
wget https://img.pokemondb.net/sprites/black-white/normal/$1.png -O $1/$1Front.png
wget https://img.pokemondb.net/sprites/black-white/back-normal/$1.png -O $1/$1Back.png
