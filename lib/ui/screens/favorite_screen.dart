import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/pokemon_favorite_Controller.dart';
import '../../controllers/theme_controller.dart';
import 'package:untitled63/utils/constans.dart' as constants;

import '../widgets/custom_sliver_grid_view.dart';


class FavoriteScreen extends StatefulWidget {
  static const routeName = 'FavoriteScreen';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> getFavPokemons() async {
    await Provider.of<PokemonFavoritesController>(context, listen: false)
        .getFavoritePokemonsData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    return Scaffold(
      backgroundColor: isDark
          ? constants.scaffoldDarkThemeColor
          : constants.scaffoldLightThemeColor,
      body: FutureBuilder(
        future: getFavPokemons(),
        builder: (_, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    color: constants.circularProgressIndicatorColor));
          } else {
            return  CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Favorite Pokemons'),
                  backgroundColor: isDark? constants.appBarDarkThemeColor: constants.appBarLightThemeColor,
                ),
                const SliverPadding(
                  padding:
                  EdgeInsets.all(constants.mediumPadding),
                  sliver: CustomSliverGridView(showFavorites: true),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}