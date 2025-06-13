import 'package:flutter/material.dart';

final class ThemeHelper {
  static const Color kTransparenteColor = Colors.transparent;
  static const Color kPrimaryBlue = Color(0xFF461CDC);
  static const Color kAccentGreen = Color(0xFF6BFF50);
  static const Color kDarkBlack = Color(0xFF000023);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kLightGray = Color(0xFFF2F2F2);
  static const Color kMediumGray = Color(0xFFBFBFBF);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: kPrimaryBlue,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryBlue,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kWhite,
        iconColor: kPrimaryBlue,
        prefixIconColor: kPrimaryBlue,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}