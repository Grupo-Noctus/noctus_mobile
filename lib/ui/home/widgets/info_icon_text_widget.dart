import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class InfoIconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoIconText({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: ThemeHelper.kAccentGreen),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
