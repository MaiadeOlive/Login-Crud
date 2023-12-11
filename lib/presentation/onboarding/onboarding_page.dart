import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:target_sistemas_test_flutter_dev/utils/theme.dart';
import '../login/login_page.dart';
import 'onboarding_controller.dart';
import 'page_one.dart';
import 'page_three.dart';
import 'page_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  final _onboardingController = OnboardingController();
  int pageChanged = 0;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          drawer: Image.asset(
            'assets/images/logo.png',
            height: 45,
            width: 45,
          ),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
              });
            },
            controller: controller,
            children: const [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          bottomSheet: Container(
            color: ThemeColors.turkeyred,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (pageChanged == 0)
                  TextButton(
                    onPressed: () => {
                      _onboardingController.storeOnboardingInfo(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                    },
                    child: const Text(
                      'Pular',
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () => controller.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: ThemeColors.black,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
                if (pageChanged == 2)
                  TextButton(
                    onPressed: () => {
                      _onboardingController.storeOnboardingInfo(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                    },
                    child: const Text(
                      'Concluir',
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text(
                      'Próximo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
