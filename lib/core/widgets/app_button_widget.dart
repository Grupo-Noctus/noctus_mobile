import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final bool enabled;

  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isProcessing = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: enabled && !isProcessing ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeHelper.kDarkBlack,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isProcessing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(ThemeHelper.kWhite),
                ),
              )
            : Text(text, style: ThemeHelper.buttonTextStyle),
      ),
    );
  }
}
