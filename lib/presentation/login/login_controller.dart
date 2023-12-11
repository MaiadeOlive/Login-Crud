import 'package:url_launcher/url_launcher.dart';

class LoginController {
  Future<void> launchPrivacyPolicy() async {
    final uri = Uri.parse('https://google.com.br');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  bool validation(login, password) {
    if (login.isNotEmpty && password.isNotEmpty) {
      if (password.length >= 2 &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(login) &&
          login.length <= 20 &&
          password.length <= 20 &&
          !login.endsWith(' ') &&
          !password.endsWith(' ')) {
        return true;
      }
    }
    return false;
  }
}
