import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled63/ui/widgets/pokemon_card_item.dart';
import '../../controllers/pokemon_basic_controller.dart';
import '../../controllers/pokemon_favorite_Controller.dart';
import '../../controllers/theme_controller.dart';
import '../../models/pokemon_basic_data.dart';

class CustomSliverGridView extends StatelessWidget {
  final bool showFavorites;

  const CustomSliverGridView({Key? key, this.showFavorites = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    return Consumer2<PokemonFavoritesController, PokemonBasicDataController>(
        builder: (_, favPokemonsProvider, allPokemonsProvider, ch) {
          // get all pokemons list
          List<PokemonBasicData> pokemons = allPokemonsProvider.pokemons;
          if (showFavorites) {
            // get favorite pokemons
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
                return PokemonCardItem(
                    pokemon: pokemon,
                    isDark: isDark,
                    id: pokemonIdPadLeft,
                    imageUrl: imageUrl);
              }, childCount: pokemons.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 200,
              ));
        });
  }
}
