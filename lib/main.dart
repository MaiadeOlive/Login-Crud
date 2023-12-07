import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test_flutter_dev/domain/business/auth_service.dart';
import 'package:target_sistemas_test_flutter_dev/screens/login/login.dart';

import 'domain/business/auth_check.dart';
import 'firebase_options.dart';
import 'screens/home/home.dart';
import 'screens/onboarding/onboarding.dart';
import 'utils/theme.dart';

bool? isOnboardingCompleted;
bool? previousLogin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  isOnboardingCompleted = preferences.getBool('onboarding');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => AuthService())],
        child: const TargetTestApp()),
  );
}

class TargetTestApp extends StatelessWidget {
  const TargetTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Target Dev Flutter",
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: ThemeColors.bloodRed,
            secondaryHeaderColor: ThemeColors.eirieBlack,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const AuthCheck(),
            '/home': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
            '/onboarding': (context) => const OnboardingPage(),
          },
        );
      },
    );
  }
}
