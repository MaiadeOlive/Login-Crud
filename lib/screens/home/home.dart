import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target_sistemas_test_flutter_dev/domain/business/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {});
                context.read<AuthService>().logout();
              },
              child: const Text("Logout"))
        ],
      ),
    );
  }
}
