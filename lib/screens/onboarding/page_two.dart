import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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
              '''
Projeto os primeiros esboços, o protótipo navegável no figma''',
              style: ThemeText.paragraph16WhiteBold,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Image.asset(
              'assets/images/onboarding2.png',
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
              '''e o desenvolvimento, seja nativo ou multiplataforma!''',
              style: ThemeText.paragraph16WhiteBold,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
