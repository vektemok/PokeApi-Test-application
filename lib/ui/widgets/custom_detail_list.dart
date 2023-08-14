import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled63/ui/widgets/pokemon_card_item.dart';
import 'package:untitled63/ui/widgets/pokemon_detail_container.dart';

import '../../domain/controllers/pokemon_basic_controller.dart';
import '../../domain/controllers/pokemon_favorite_Controller.dart';
import '../../domain/controllers/theme_controller.dart';
import '../../model/pokemon_basic_data.dart';


class CustomDetailListView extends StatelessWidget {
  final bool showFavorites;

  const CustomDetailListView({Key? key, this.showFavorites = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    return Consumer2<PokemonFavoritesController, PokemonBasicDataController>(
        builder: (_, favPokemonsProvider, allPokemonsProvider, ch) {
      List<PokemonBasicData> pokemons = allPokemonsProvider.pokemons;
      if (showFavorites) {
        pokemons = favPokemonsProvider.favoritePokemons;
      }
      return SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            final pokemon = pokemons[index];

            String pokemonIdPadLeft = '';
            pokemonIdPadLeft = (index + 1).toString().padLeft(3, '0');
            String imageUrl =
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$pokemonIdPadLeft.png';
            if (showFavorites) {
              imageUrl = pokemon.imageUrl;
              pokemonIdPadLeft = pokemon.id;
            }
            return PokemonDetailContainer(
              pokemon: pokemon,
              isDark: isDark,
              id: pokemonIdPadLeft,
              imageUrl: imageUrl,

            );
          }, childCount: pokemons.length),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 200,
          ));
    });
  }
}