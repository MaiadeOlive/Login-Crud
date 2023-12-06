import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      color: ThemeColors.turkeyred,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Olá, eu sou a Maia!',
            style: ThemeText.h3title20eirieBlack,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Image.asset(
              'assets/images/onboarding1.png',
              height: MediaQuery.of(context).size.width * .7,
              width: MediaQuery.of(context).size.width * .8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 22,
              right: 22,
              bottom: 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Sou uma desenvolvedora de aplicativos móveis! \\o/''',
                  style: ThemeText.paragraph16eirieBlackBold,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
