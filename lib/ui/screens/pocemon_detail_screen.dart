import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../domain/controllers/pokemon_basic_controller.dart';
import '../../domain/controllers/pokemon_favorite_Controller.dart';
import '../../domain/controllers/theme_controller.dart';
import '../../model/pokemon_basic_data.dart';
import '../widgets/white_sheet_widgets/white_sheet_widget.dart';
import 'package:untitled63/utils/constans.dart' as constants;

class PokemonDetailScreen extends StatefulWidget {
  static const String routeName = 'PokemonDetailScreen';

  const PokemonDetailScreen({Key? key}) : super(key: key);

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late PokemonBasicData pokemon;
  late Color cardColor;
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    bool isFavorite = false;

    Future<void> checkFavorite(String name) async {
      isFavorite = await Provider.of<PokemonFavoritesController>(context)
          .isPokemonFavorite(name);
    }

    final Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    cardColor = data['color'];
    pokemon = data['pokemon'];
    imageUrl = data['imageUrl'];

    // get screen height and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<PokemonBasicDataController>(
        builder: (ctx, provider, ch) {
          return SafeArea(
            child: WhiteSheetWidget(pokemon: pokemon, isDark: isDark),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
