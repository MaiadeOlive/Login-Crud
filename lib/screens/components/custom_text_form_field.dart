import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final String validatorVazio;
  final String validatorMaiorqueNumero;
  final FocusNode focusNode;
  final bool isObscureText;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.isObscureText,
    required this.keyboardType,
    required this.validatorVazio,
    required this.validatorMaiorqueNumero,
    required this.focusNode,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: true,
      style: const TextStyle(
        color: ThemeColors.white,
      ),
      obscureText: isObscureText,
      validator: (resposta) {
        {
          if (resposta!.isEmpty) {
            return validatorVazio;
          }
          if (resposta.length > 20) {
            return validatorMaiorqueNumero;
          }
          if (keyboardType == TextInputType.emailAddress) {
            if (!resposta.contains('@') || !resposta.contains('.')) {
              return 'Email inválido';
            }
          } else if (keyboardType == TextInputType.text) {
            if (resposta.length < 2 ||
                resposta.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]')) ||
                resposta.endsWith(' ')) {
              return 'A senha deve ter entre 2 e 20 caracteres,\nsem caracteres especiais.';
            }
          }

          return null;
        }
      },
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            hint,
            style: ThemeText.paragraph12WhiteBold,
          ),
        ),
        labelStyle: const TextStyle(color: ThemeColors.white),
        icon: Icon(icon),
        iconColor: ThemeColors.white,
        errorStyle: const TextStyle(
            color: ThemeColors.white), // Define a cor do texto de erro
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: ThemeColors.white), // Define a cor da borda de erro
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: ThemeColors
                  .white), // Define a cor da borda de erro quando o campo está focado
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: ThemeColors
                  .white), // Define a cor da borda quando o campo está focado
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: ThemeColors
                  .white), // Define a cor da borda quando o campo está habilitado, mas não está focado
        ),
      ),
    );
  }
}
