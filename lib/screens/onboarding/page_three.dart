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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/onboarding3.png',
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
                    '''Estou aberta a novos projetos! 🚀💻 
                    
#DesenvolvimentoMobile #Flutter #Android #Tecnologia #Colaboração #Mentoria
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
