import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
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
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 22,
              right: 22,
              bottom: 4,
            ),
            child: Text(
              'Além de realizar testes de usabilidade utilizando o Maze!',
              style: ThemeText.paragraph16WhiteBold,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Image.asset(
              'assets/images/onboarding3.png',
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
            child: Text(
              'Estou disponível para agendar uma entrevista <3',
              style: ThemeText.paragraph16WhiteBold,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
