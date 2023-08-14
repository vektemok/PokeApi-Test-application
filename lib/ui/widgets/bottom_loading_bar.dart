import 'package:flutter/material.dart';
import 'package:untitled63/utils/constans.dart' as constants;


class BottomLoadingBarWidget extends StatelessWidget {
  const BottomLoadingBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(children: const [
          SizedBox(height: constants.largePadding),
          Center(
              child: CircularProgressIndicator(
                  color: constants.circularProgressIndicatorColor)),
          SizedBox(height: constants.largePadding),
        ]));
  }
}
