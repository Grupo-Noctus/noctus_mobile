import 'package:flutter/material.dart';
import 'package:noctus_mobile/utils/app_colors.dart';

const textStyleRegister = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);

const inputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.white),
  borderRadius: BorderRadius.all(Radius.circular(16)),
);

const labelTextStyle = TextStyle(color: AppColors.mediumGray);
const inputTextStyle = TextStyle(color: AppColors.white);

InputDecoration customInputDecoration(String label) => InputDecoration(
  labelText: label,
  labelStyle: labelTextStyle,
  enabledBorder: inputBorder,
  focusedBorder: inputBorder,
  errorBorder: inputBorder,
  focusedErrorBorder: inputBorder,
);

const buttonTextStyle = TextStyle(
  color: AppColors.accentGreen,
  fontWeight: FontWeight.bold,
  fontFamily: 'Open Sans',
);

const textSpanRegisterStyle = TextStyle(
  color: AppColors.accentGreen,
  fontWeight: FontWeight.bold,
);

InputDecoration customDropdownDecoration(String label) => InputDecoration(
  labelText: label,
  labelStyle: labelTextStyle,
  enabledBorder: inputBorder,
  focusedBorder: inputBorder,
  errorBorder: inputBorder,
  focusedErrorBorder: inputBorder,
  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
);