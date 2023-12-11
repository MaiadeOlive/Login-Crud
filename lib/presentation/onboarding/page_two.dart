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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/onboarding2.png',
              ),
              fit: BoxFit.fill,
            ),
            color: Color.fromRGBO(255, 255, 255, 9),
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
                    '''Como Mobile Developer, mergulho no universo do Android e Flutter, sempre buscando inovação. 

Acredito no poder da colaboração para crescer, seja pessoal ou profissionalmente. 
''',
                    style: ThemeText.paragraph16eirieBlackBold,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
