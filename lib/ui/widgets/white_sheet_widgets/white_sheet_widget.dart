import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:untitled63/utils/constans.dart' as constants;


import '../../../domain/controllers/pokemon_about_controller.dart';
import '../../../domain/controllers/pokemon_more_info_controller.dart';
import '../../../domain/controllers/pokemon_stat_controller.dart';
import '../../../model/pokemon_basic_data.dart';
import '../white_sheet_widgets/moves_widget.dart';
import 'stats_row_widget.dart';

import 'about_widget.dart';
import 'more_info_widget.dart';

class WhiteSheetWidget extends StatefulWidget {
  final PokemonBasicData pokemon;
  final bool isDark;

  const WhiteSheetWidget(
      {Key? key, required this.pokemon, required this.isDark})
      : super(key: key);

  @override
  State<WhiteSheetWidget> createState() => _WhiteSheetWidgetState();
}

class _WhiteSheetWidgetState extends State<WhiteSheetWidget> {
  final _tabController = PageController();
  int _currentTabIndex = 0;
  bool loading = false;

  final List<String> _tabs = [
    'About pokemon',
    'Statistic',
    'Evolution and bla bla'
  ];

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final pokemon = widget.pokemon;
    // fetch pokemon about data
    await Provider.of<PokemonAboutDataController>(context, listen: false)
        .getPokemonAboutData(pokemon);
    if (!mounted) return;

    await Provider.of<PokemonMoreInfoController>(context, listen: false)
        .getPokemonMoreInfoData(pokemon);
    if (!mounted) return;

    await Provider.of<PokemonStatsController>(context, listen: false)
        .getPokemonStats(pokemon);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    // get screen height and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final isDark = widget.isDark;

    return Container(
      height: screenHeight * 0.6,
      width: screenWidth,
      decoration: BoxDecoration(
        color: isDark
            ? constants.whiteSheetDarkThemeColor
            : constants.whiteSheetLightThemeColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.085,
          ),
          SizedBox(
              height: screenHeight * .06,
              child: Center(child: customScrollerBuilder(isDark))),
          // display circular indicator when loading
          if (loading)
            const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                      color: constants.circularProgressIndicatorColor)),
            ),
          // display the pageView when finish loading
          if (!loading)
            Expanded(
              child: PageView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (int index) {
                  setState(() {
                    // update the tab index
                    _currentTabIndex = index;
                  });
                },
                children: [
                  AboutWidget(pokemon: pokemon),
                  StatsWidget(pokemon: pokemon),
                  MoreInfoWidget(pokemon: pokemon),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget customScrollerBuilder(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ..._tabs.map((tab) {
          int tabIndex = _tabs.indexOf(tab);
          return Expanded(child: tabBuilder(tabIndex, _tabs, isDark));
        }).toList(),
      ],
    );
  }

  Widget tabBuilder(int tabIndex, List<String> scrollTabs, bool isDark) {
    return GestureDetector(
      onTap: () {
        updateTabIndex(tabIndex);
      },
      child: Column(
        children: [
          Text(scrollTabs[tabIndex],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _currentTabIndex == tabIndex
                      ? (isDark ? Colors.white : Colors.black)
                      : Colors.grey)),
          if (tabIndex == _currentTabIndex)
            Container(
              width: scrollTabs[tabIndex].length * 10,
              height: 2,
              color: isDark
                  ? constants.customHorizontalScrollbarDarkThemeColor
                  : constants.customHorizontalScrollbarLightThemeColor,
            ),
        ],
      ),
    );
  }

  void updateTabIndex(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
      // add animation
      _tabController.animateToPage(tabIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    });
  }
}
