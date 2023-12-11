import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target_sistemas_test_flutter_dev/presentation/login/login_controller.dart';
import 'package:toast/toast.dart';

import '../../domain/business/auth/auth_service.dart';
import '../../utils/theme.dart';
import '../components/custom_text_form_field.dart';
import '../components/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  late FocusNode focusNode1;
  late FocusNode focusNode2;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    ToastContext().init(context);
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        titulo = "Boas vindas";
        actionButton = "Login";
        toggleButton = "Ainda não tem conta? Cadastre-se agora!";
      } else {
        titulo = "Crie sua conta";
        actionButton = "Cadastrar";
        toggleButton = "Já possui uma conta? Voltar ao login!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.turkeyred,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLogo(),
                  const SizedBox(height: 40),
                  Text(
                    titulo,
                    style: ThemeText.h3title20WhiteBold,
                  ),
                  const SizedBox(height: 40),
                  buildTextFormField(
                    Icons.person,
                    focusNode1,
                    false,
                    TextInputAction.next,
                    'Usuário',
                    loginController,
                    TextInputType.emailAddress,
                    'Escreva seu email corretamente',
                    'Seu email deve ter menos de 20 caracteres',
                  ),
                  const SizedBox(height: 10),
                  buildTextFormField(
                    Icons.lock,
                    focusNode2,
                    true,
                    TextInputAction.done,
                    'Senha',
                    passwordController,
                    TextInputType.text,
                    'Escreva sua senha corretamente',
                    'Sua senha deve ter no mínimo 2 caracteres',
                  ),
                  const SizedBox(height: 90),
                  buildElevatedButton(),
                  const SizedBox(height: 30),
                  buildToggleButton(),
                  const SizedBox(height: 100),
                  buildPrivacyPolicyLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 60,
          width: 60,
        ),
      ),
    );
  }

  Widget buildTextFormField(
    IconData icon,
    FocusNode focusNode,
    bool isObscureText,
    TextInputAction textInputAction,
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    String validatorVazio,
    String validatorMaiorqueNumero,
  ) {
    return CustomTextFormField(
      icon: icon,
      focusNode: focusNode,
      isObscureText: isObscureText,
      textInputAction: textInputAction,
      hint: hint,
      controller: controller,
      keyboardType: keyboardType,
      validatorVazio: validatorVazio,
      validatorMaiorqueNumero: validatorMaiorqueNumero,
    );
  }

  Widget buildElevatedButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: ElevatedButton(
          onPressed: () {
            handleFormSubmit();
          },
          child: loading
              ? buildLoadingIndicator()
              : Text(
                  actionButton,
                  style: ThemeText.paragraph16RedBold,
                ),
        ),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          color: ThemeColors.turkeyred,
        ),
      ),
    );
  }

  Widget buildToggleButton() {
    return InkWell(
      onTap: () => setFormAction(!isLogin),
      child: Text(
        toggleButton,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildPrivacyPolicyLink() {
    return InkWell(
      onTap: controller.launchPrivacyPolicy,
      child: const Text(
        'Política de Privacidade',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void handleFormSubmit() {
    if (_formKey.currentState!.validate() &&
        controller.validation(
          loginController.text,
          passwordController.text,
        )) {
      if (isLogin) {
        login();
      } else {
        registration();
      }
    }
  }

  void login() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .login(loginController.text, passwordController.text);
      if (authService.userAuth != null) {
        Navigator.pushNamed(context, '/home');
      }
    } on AuthException catch (err) {
      handleAuthException(err);
    } finally {
      setState(() => loading = false);
    }
  }

  void registration() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(loginController.text, passwordController.text);
      if (authService.userAuth != null) {
        Navigator.pushNamed(context, '/home');
      }
    } on AuthException catch (err) {
      handleAuthException(err);
    } finally {
      setState(() => loading = false);
    }
  }

  void handleAuthException(AuthException err) {
    showToast(err.message);
  }
}
