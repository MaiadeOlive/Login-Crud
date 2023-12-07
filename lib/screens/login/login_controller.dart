import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target_sistemas_test_flutter_dev/domain/business/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/toast.dart';

class LoginController {
  Future<void> launchPrivacyPolicy() async {
    final uri = Uri.parse('https://google.com.br');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<void> registration({
    required BuildContext context,
    required String login,
    required String password,
  }) async {
    try {
      if (validation(login, password)) {
        await context.read<AuthService>().registrar(login, password);
      }
    } on AuthException catch (err) {
      showToast(err.message);
    }
  }

  Future<void> login({
    required BuildContext context,
    required String login,
    required String password,
  }) async {
    try {
      if (validation(login, password)) {
        await context.read<AuthService>().login(login, password);
      }
    } on AuthException catch (err) {
      showToast(err.message);
    }
  }

  validation(login, password) {
    if (login.isNotEmpty && password.isNotEmpty) {
      if (password.length >= 2 &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(login) &&
          login.length <= 20 &&
          password.length <= 20 &&
          !login.endsWith(' ') &&
          !password.endsWith(' ')) {
        return true;
      }
    } else {
      return false;
    }
  }
}
