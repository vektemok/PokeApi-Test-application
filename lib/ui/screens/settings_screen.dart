import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled63/utils/constans.dart' as constants;

import '../../domain/controllers/theme_controller.dart';


class SettingsScreen extends StatelessWidget {
  static const String routeName = 'SettingsScreen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: isDark
              ? constants.appBarDarkThemeColor
              : constants.appBarLightThemeColor,
          title: const Text('Settings'),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(constants.mediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Theme'),
                  Switch(
                      activeColor: constants.switchActiveDarkThemeColor,
                      value: isDark,
                      onChanged: (value) {
                        Provider.of<ThemeController>(context, listen: false)
                            .toggleTheme();
                      }),
                ],
              ),

            ],
          ),
        ));
  }
}
