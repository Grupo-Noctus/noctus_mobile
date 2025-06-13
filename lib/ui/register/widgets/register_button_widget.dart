import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class RegisterButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('CONTINUE', style: ThemeHelper.buttonTextStyle),
      ),
    );
  }
}
