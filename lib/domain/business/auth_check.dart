import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target_sistemas_test_flutter_dev/domain/business/auth_service.dart';
import 'package:target_sistemas_test_flutter_dev/screens/home/home.dart';

import '../../main.dart';
import '../../screens/login/login.dart';
import '../../screens/onboarding/onboarding.dart';
import '../../utils/theme.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    if (isOnboardingCompleted == null) {
      return const OnboardingPage();
    } else if (authService.isLoading) {
      return loading();
    } else if (authService.userAuth == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      backgroundColor: ThemeColors.turkeyred,
      body: Center(
          child: CircularProgressIndicator(
        color: ThemeColors.white,
      )),
    );
  }
}
