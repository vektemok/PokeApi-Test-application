import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled63/ui/screens/home_screen.dart';
import 'package:untitled63/ui/screens/main.dart';
import 'package:untitled63/ui/screens/pocemon_detail_screen.dart';
import 'package:untitled63/ui/screens/settings_screen.dart';
import 'domain/controllers/pokemon_about_controller.dart';
import 'domain/controllers/pokemon_basic_controller.dart';
import 'domain/controllers/pokemon_favorite_Controller.dart';
import 'domain/controllers/pokemon_more_info_controller.dart';
import 'domain/controllers/pokemon_stat_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'domain/controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("isDark") ?? true;
    runApp(ChangeNotifierProvider<ThemeController>(
      child: const Application(),
      create: (_) => ThemeController(isDarkTheme),
    ));
  });
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonBasicDataController()),
        ChangeNotifierProvider(create: (_) => PokemonAboutDataController()),
        ChangeNotifierProvider(create: (_) => PokemonMoreInfoController()),
        ChangeNotifierProvider(create: (_) => PokemonStatsController()),
        ChangeNotifierProvider(create: (_) => PokemonFavoritesController()),
      ],
      child: Consumer<ThemeController>(builder: (context, provider, ch) {
        return MaterialApp(
          theme: provider.themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: Main.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            PokemonDetailScreen.routeName: (context) =>
                const PokemonDetailScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            Main.routeName: (context) => const Main()
          },
        );
      }),
    );
  }
}
