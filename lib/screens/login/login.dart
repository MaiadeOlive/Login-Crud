import 'package:flutter/material.dart';
import 'package:target_sistemas_test_flutter_dev/screens/login/login_controller.dart';

import '../../domain/business/auth_service.dart';
import '../../utils/theme.dart';
import '../components/custom_text_form_field.dart';

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              ),
              const SizedBox(height: 40),
              Text(
                titulo,
                style: ThemeText.h3title20WhiteBold,
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                icon: Icons.person,
                focusNode: focusNode1,
                isObscureText: false,
                textInputAction: TextInputAction.next,
                hint: 'Usuário',
                controller: loginController,
                keyboardType: TextInputType.emailAddress,
                validatorVazio: 'Escreva seu email corretamente',
                validatorMaiorqueNumero:
                    'Seu email deve ter menos de 20 caracteres',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                icon: Icons.lock,
                focusNode: focusNode2,
                isObscureText: true,
                textInputAction: TextInputAction.done,
                hint: 'Senha',
                controller: passwordController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Escreva sua senha corretamente',
                validatorMaiorqueNumero:
                    'Sua senha deve ter no minimo 2 caracteres',
              ),
              const SizedBox(height: 90),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isLogin) {
                          controller
                              .login(
                                  context: context,
                                  login: loginController.text,
                                  password: passwordController.text)
                              .then(
                                (value) => Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Navigator.pushNamed(context, '/home');
                                    setState(
                                      () {
                                        loading =
                                            true; // Certifique-se de definir o loading como true somente após a navegação.
                                      },
                                    );
                                  },
                                ),
                              );
                        } else {
                          controller
                              .registration(
                                  context: context,
                                  login: loginController.text,
                                  password: passwordController.text)
                              .then(
                                (value) => Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Navigator.pushNamed(context, '/home');
                                    setState(() {
                                      loading =
                                          true; // Certifique-se de definir o loading como true somente após a navegação.
                                    });
                                  },
                                ),
                              );
                        }
                      }
                    },
                    child: loading
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            actionButton,
                            style: ThemeText.paragraph16RedBold,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => setFormAction(!isLogin),
                child: Text(
                  toggleButton,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: controller.launchPrivacyPolicy,
                child: const Text(
                  'Política de Privacidade',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
