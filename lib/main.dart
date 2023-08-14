import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled63/ui/screens/favorite_screen.dart';
import 'package:untitled63/ui/screens/home_screen.dart';
import 'package:untitled63/ui/screens/pocemon_detail_screen.dart';
import 'package:untitled63/ui/screens/search_screen.dart';
import 'package:untitled63/ui/screens/settings_screen.dart';

import 'controllers/pokemon_about_controller.dart';
import 'controllers/pokemon_basic_controller.dart';
import 'controllers/pokemon_favorite_Controller.dart';
import 'controllers/pokemon_more_info_controller.dart';
import 'controllers/pokemon_stat_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme =
        prefs.getBool("isDark") ?? true;
    runApp(ChangeNotifierProvider<ThemeController>(
      child: const MyApp(),
      create: (_) => ThemeController(isDarkTheme),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonBasicDataController()),
        ChangeNotifierProvider(create: (_) => PokemonAboutDataController()),
        ChangeNotifierProvider(create: (_) => PokemonMoreInfoController()),
        ChangeNotifierProvider(create: (_) => PokemonStatsController()),
        ChangeNotifierProvider(create: (_) => PokemonFavoritesController()),
        ChangeNotifierProvider(create: (_) => SearchPokemonsController()),
      ],
      child: Consumer<ThemeController>(builder: (context, provider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: provider.themeData,
          title: 'Flutter Demo',
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            PokemonDetailScreen.routeName: (context) =>
                const PokemonDetailScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            FavoriteScreen.routeName: (context) => const FavoriteScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
          },
        );
      }),
    );
  }
}
