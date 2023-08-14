import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../domain/controllers/pokemon_basic_controller.dart';
import '../../domain/controllers/theme_controller.dart';
import '../widgets/bottom_loading_bar.dart';
import '../widgets/custom_detail_list.dart';
import '../widgets/custom_sliver_grid_view.dart';
import 'package:untitled63/utils/constans.dart' as constants;

class PokemonDetailListScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const PokemonDetailListScreen({Key? key}) : super(key: key);

  @override
  State<PokemonDetailListScreen> createState() =>
      _PokemonDetailListScreenState();
}

class _PokemonDetailListScreenState extends State<PokemonDetailListScreen> {
  final _scrollController = ScrollController();
  int offset = 0;
  bool atBottom = false;
  bool loadData = false;

  @override
  void initState() {
    fetchPokemons();
    pokemonLazyLoading();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider
        .of<ThemeController>(context)
        .themeData;
    bool isDark = themeData == ThemeData.dark();
    return Scaffold(
        backgroundColor: isDark
            ? constants.scaffoldDarkThemeColor
            : constants.scaffoldLightThemeColor,
        body: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: constants.mediumPadding),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                    child: SizedBox(height: constants.mediumPadding)),
                const CustomDetailListView(),
                if (atBottom && loadData) const BottomLoadingBarWidget(),
                if (atBottom && !loadData)
                  const SliverToBoxAdapter(
                      child: SizedBox(height: constants.mediumPadding))
              ],
            )));
  }

  Future<void> fetchPokemons() async {
    await Provider.of<PokemonBasicDataController>(context, listen: false)
        .getAllPokemons(offset);
  }

  Future<void> pokemonLazyLoading() async {
    setState(() {
      atBottom = true;
      loadData = true;
    });

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;

        if (!isTop) {
          offset += 20;
          fetchPokemons();
        }
      } else if (offset >= 980) {
        setState(() {
          loadData = false;
          atBottom = false;
        });
      }
    });
  }
}
