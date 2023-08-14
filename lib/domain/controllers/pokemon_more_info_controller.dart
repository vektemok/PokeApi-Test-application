import 'package:flutter/material.dart';


import '../../model/pokemon_basic_data.dart';
import '../../model/pokemon_more_info_data.dart';
import '../services/pokemon_more_info_services.dart';

class PokemonMoreInfoController with ChangeNotifier {


  final pokemonAboutDataService = PokemonMoreInfoService();

  Future<void> getPokemonMoreInfoData(PokemonBasicData pokemon) async {
    final response = await  pokemonAboutDataService.fetchPokemonMoreIndoData(pokemon);

    PokemonMoreInfoData pokemonDetailedInfo = PokemonMoreInfoData(
      height: response['height'],
      weight: response['weight'],
      abilities: response['abilities'],
      types: response['types'],
      moves: response['moves'],
    );
    // add pokemon detail model to pokemon basic info model
    pokemon.pokemonMoreInfoData = pokemonDetailedInfo;

  }

}
