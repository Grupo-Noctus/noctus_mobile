import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class RegisterFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validatorMessage;
  final bool obscureText;

  const RegisterFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validatorMessage,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: ThemeHelper.inputTextStyle,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
    );
  }
}
