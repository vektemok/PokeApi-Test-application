import 'package:flutter/material.dart';

import '../../model/pokemon_basic_data.dart';

import '../services/pokemon_basic_services.dart';

class PokemonBasicDataController with ChangeNotifier {
  List<PokemonBasicData> _pokemons = [];

  List<PokemonBasicData> get pokemons {
    return [..._pokemons];
  }

  final basicDataService = PokemonBasicDataService();

  Future<void> getAllPokemons(int offset) async {
    final fetchedPokemons = await basicDataService.getAllPokemons(offset);
print(_pokemons);
    for (var pokemon in fetchedPokemons) {
      _pokemons.add(pokemon);
    }

    notifyListeners();
  }
}
