import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:untitled63/ui/widgets/white_sheet_widgets/stats_row_widget.dart';
import 'package:untitled63/utils/constans.dart' as constants;

import '../../model/pokemon_basic_data.dart';
import '../../utils/colors_generator.dart';
import '../screens/pocemon_detail_screen.dart';

class PokemonDetailContainer extends StatefulWidget {
  final PokemonBasicData pokemon;
  final bool isDark;
  final String imageUrl;
  final String id;

  const PokemonDetailContainer({
    Key? key,
    required this.isDark,
    required this.pokemon,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  @override
  State<PokemonDetailContainer> createState() => _PokemonDetailContainerState();
}

class _PokemonDetailContainerState extends State<PokemonDetailContainer> {
  Color cardColor = Colors.transparent;
  late Map<String, String> getPokemonIdAndImage;
  bool colorReady = false;

  @override
  void initState() {
    generateContainerColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;
    final pokemonBasicInfo = widget.pokemon;

    // update ids and imageUrls
    return GestureDetector(onTap: () {
      Navigator.of(context).pushNamed(PokemonDetailScreen.routeName,
          arguments: {
            'pokemon': pokemonBasicInfo,
            'color': cardColor,
            'imageUrl': widget.imageUrl
          });
    }, child: Builder(builder: (context) {
      if (colorReady) {
        return Container(
          padding: const EdgeInsets.all(constants.mediumPadding),
          decoration: BoxDecoration(
              color: cardColor,
              borderRadius:
                  BorderRadius.circular(constants.containerCornerRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: pokemonBasicInfo.name,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  height: 110,
                  width: 100,
                  fadeInDuration: const Duration(milliseconds: 150),
                  fadeOutDuration: const Duration(milliseconds: 150),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const Text(
                'Click for more information',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(
                color: constants.circularProgressIndicatorColor));
      }
    }));
  }

  Future<void> generateContainerColor() async {
    ColorsGenerator colorsGenerator = ColorsGenerator();
    Color generatedColor =
        await colorsGenerator.generateCardColor(widget.imageUrl, widget.isDark);
    if (mounted) {
      setState(() {
        colorReady = true;
        cardColor = generatedColor;
      });
    }
  }
}
