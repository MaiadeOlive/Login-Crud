import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/onboarding1.png',
            ),
            fit: BoxFit.fill,
          ),
          color: Color.fromRGBO(255, 255, 255, 0.7),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Column(
              children: [
                Text(
                  'Olá! Eu sou a Maia!\n',
                  style: ThemeText.h2title35black,
                ),
                Text(
                  '''Desenvolvedora mobile e cientista da Informação. 📱✨''',
                  style: ThemeText.paragraph16eirieBlackBold,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
