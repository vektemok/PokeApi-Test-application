import 'package:untitled63/ui/screens/pokemon_detail_screen.dart';
import 'package:untitled63/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class Main extends StatefulWidget {
  static const String routeName = '/main';

  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  final pages = const [
    HomeScreen(),
    PokemonDetailListScreen(),
    SettingsScreen(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'local'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Home'),
          ]),
    );
  }
}
