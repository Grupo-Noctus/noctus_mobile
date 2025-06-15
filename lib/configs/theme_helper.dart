import 'package:flutter/material.dart';

final class ThemeHelper {
  static const Color kTransparenteColor = Colors.transparent;
  static const Color kPrimaryBlue = Color(0xFF461CDC);
  static const Color kAccentGreen = Color(0xFF6BFF50);
  static const Color kDarkBlack = Color(0xFF000023);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kLightGray = Color(0xFFF2F2F2);
  static const Color kMediumGray = Color(0xFFBFBFBF);

  static const TextStyle buttonTextStyle = TextStyle(
    color: kAccentGreen,
    fontWeight: FontWeight.bold,
    fontFamily: 'Open Sans',
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: kWhite,
    fontFamily: 'Open Sans',
  );

  static SwitchThemeData get switchTheme {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return kAccentGreen;
        }
        return kDarkBlack;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return kAccentGreen.withValues(alpha: (0.5 * 255));
        }
        return kDarkBlack;
      }),
    );
  }

  static ThemeData get theme {
    return ThemeData(
      primaryColor: kPrimaryBlue,
      scaffoldBackgroundColor: kPrimaryBlue,
      fontFamily: 'Open Sans',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: kAccentGreen,
          backgroundColor: kPrimaryBlue,
          textStyle: buttonTextStyle,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kDarkBlack,
        iconColor: kPrimaryBlue,
        prefixIconColor: kPrimaryBlue,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(
          color: kMediumGray,
          fontFamily: 'Open Sans',
        ),
      ),
      switchTheme: switchTheme,
    );
  }

  static InputDecoration buildInputDecoration({
    required String labelText,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: kDarkBlack,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: const TextStyle(
        color: kMediumGray,
        fontFamily: 'Open Sans',
      ),
      hintStyle: const TextStyle(
        color: kMediumGray,
        fontFamily: 'Open Sans',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: kMediumGray,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: kAccentGreen,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: kAccentGreen,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: kMediumGray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: kAccentGreen,
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(
        color: kAccentGreen,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
