import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/assets_helper.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const HeaderWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeHelper.kDarkBlack,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 40,
            child: Image.asset(
              AssetsHelper.assetsIntitutoMatera,
              height: 40,
            ),
          ),
          Positioned(
            right: 8,
            top: 42,
            child: IconButton(
              icon: const Icon(Icons.logout, color: ThemeHelper.kWhite),
              tooltip: 'Logout',
              onPressed: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}
