import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class AppInputFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validatorMessage;
  final bool obscureText;
  final bool enabled;
  final TextInputAction? textInputAction;
  final String? hintText;

  const AppInputFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validatorMessage,
    this.obscureText = false,
    this.enabled = true,
    this.textInputAction,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: ThemeHelper.inputTextStyle,
      obscureText: obscureText,
      enabled: enabled,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ThemeHelper.kMediumGray,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeHelper.kAccentGreen,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeHelper.kAccentGreen,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeHelper.kMediumGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeHelper.kAccentGreen,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: ThemeHelper.kAccentGreen,
          fontWeight: FontWeight.w500,
        ),
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
